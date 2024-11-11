DROP DATABASE IF EXISTS Banco;

CREATE DATABASE Banco;

Create Table Cliente(
    id int not null auto_increment primary key,
    nome varchar(50) not null,
    telefone varchar(20),
    email varchar(50)
);

Create Table Conta(
    id int not null auto_increment,
    cliente_id int not null,
    saldo decimal(10, 2) default 0.0,
    primary key(id),
    foreign key(cliente_id) references Cliente(id)
);

Create Table Movimento(
    id int not null auto_increment primary key,
    conta_id int not null,
    DataMovimento datetime default now(),
    valor decimal(10, 2) not null,
    saldoAnterior decimal(10, 2),
    saldoAtual decimal(10, 2) foreign key(conta_id) references Conta(id)
);

create table movimento_log(
    movimento_id int not null primary key,
    modifucacao varchar(200),
    DataMovimento datetime,
    userName char(32)
);

----------------------------------------------
delimiter $ $ create trigger BeforeInsertMovimento before
insert
    on Movimento for each row begin
set
    New.saldoAnterior = (
        select
            saldo
        from
            Conta
        where
            id = New.conta_id
    );

update
    Conta
set
    saldo = saldo + new.valor
where
    id = New.conta_id;

end $ $ delimiter;

----------------------------------------------
delimiter $ $ create trigger BeforeUpdateMovimento before
update
    on Movimento for each row begin
set
    New.saldoAnterior = (
        select
            saldo
        from
            Conta
        where
            id = New.conta_id
    );

update
    Conta
set
    saldo = saldo - old + new.valor
where
    id = New.conta_id;

end $ $ delimiter;

----------------------------------------------
delimiter $ $ create trigger BeforeDeleteMovimento before delete on Movimento for each row begin
update
    Conta
set
    saldo = saldo - old.valor
where
    id = old.conta_id;

end $ $ delimiter;

----------------------------------------------
delimiter $ $ create trigger AfterInsertMovimento
after
insert
    on Movimento for each row begin
set
    Modif = concat_ws(
        ' ; ',
        new.valor,
        new.saldoAnterior,
        new.saldoAtual,
        'inserted'
    )
end $ $ delimiter;

----------------------------------------------
delimiter $ $ create trigger AfterUpdateMovimento
after
update
    on Movimento for each row begin


end $ $ delimiter;
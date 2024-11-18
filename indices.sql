use airport;

show tables;

show index
from
    airport;

desc airport;

create index airport_idx_on airport (airport);

create database mycompany;

use mycompany;

create table
    contact (
        id int not null auto_increment primary key,
        name varchar(25) not null,
        surname varchar(25),
        cc varchar(12) not null,
        nif int not null,
        email varchar(50),
        index name_idx (name (10), surname (10)),
        unique index cc_idx (cc),
        unique index nif_idx (nif)
    );
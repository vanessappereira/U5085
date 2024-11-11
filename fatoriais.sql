use myfuncs;

-- Fatorial Loop
delimiter $$
create function fatorialLoop(n int)
returns int
deterministic
begin
	declare fat int default 1;
    l1 loop
    if n<=1 then
    leave l1;
    end if;
    set fat=fat*n;
    set n=n-1;
    end loop l1;
    return fat;
end$$
delimiter ;

select fatorialLoop(5);

-- Fatorial While
delimiter $$
create function fatorialWhile(n int)
returns int
deterministic
begin
	declare fat int default 1;
   while n>1 do
   set fat=fat*n;
   set n=n-1;
    end while;
    return fat;
end$$
delimiter ;
select fatorialWhile(5);

-- Fatorial Repeat
delimiter $$
DROP function IF EXISTS `fatorialRepeat`;
create function fatorialRepeat(n int)
returns int
deterministic
begin
	declare fat int default 1;
    if n<=1 then
		return fat;
	end if;
    repeat
		set fat=fat*n;
        set n=n-1;
    until n=1
    end repeat;
    return fat;
end$$
delimiter ;

select fatorialRepeat(5);



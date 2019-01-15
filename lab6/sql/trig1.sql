create or replace function PK_DLC() returns trigger as $$
begin
	new.id_dlc = ( select max(id_dlc) from dlc) + 1;
	return new;
end;
$$
language 'plpgsql';

create trigger PKtrig 
before insert on dlc for each row
execute procedure PK_DLC();


insert into dlc (name,price,release_date,description) values ('name', 5, '2019-01-01', 'desc' );
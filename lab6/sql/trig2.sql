/*drop trigger if exists CheckG on dlc;*/

create or replace function mamma() returns trigger as $$
begin
	if (tg_op = 'DELETE') then
		delete from game where id_dlc = old.id_dlc;
		 return null;
	end if;
	if (tg_op = 'UPDATE') then
		--raise notice '%', new.id_dlc;
		update game set id_dlc = new.id_dlc where id_dlc = old.id_dlc;

		return new;
	end if;
end;
$$
language 'plpgsql';

/*create trigger ChDLC
after delete or update on dlc
for each row execute procedure mamma();*/





update dlc set id_dlc = 100 where id_dlc = 3;
--delete from dlc where id_dlc = 14;
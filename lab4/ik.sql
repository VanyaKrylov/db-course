create view select_all as
 select * from cpu

create view select_between as SELECT * FROM developer WHERE year_of_foundation BETWEEN 1954 AND 1970;
create view select_in as SELECT * FROM tournament WHERE xprize IN('4');
create view select_like as SELECT * FROM tournament WHERE rules LIKE 'S%';

create view select_count as SELECT COUNT (*) FROM tournament WHERE xprize = '4';

create view select_order as select * from tournament order by name, xprize desc

create view select_amm as SELECT avg(price), max(price), min(price) FROM game;

create view select_many as select * from game join dlc on (dlc.id_dlc = game.id_dlc)

-- 13 --  with summary as (select id_game as id_g, game.name as g_name, game.price as g_pr, SUM(dlc.price) as summ from game join dlc using (id_game) group by id_game) select id_g, g_name, g_pr, summ from summary where (g_pr < summ * 3);

-- 14 -- select * from cpu where cpu.cores * cpu.frequency > (select mult from (with summary as (select cpu.cores * cpu.frequency as mult from game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join cpu using (id_cpu)) select mult, ROW_NUMBER () OVER (order by mult) from summary) x where ROW_NUMBER = (select count(*) from game) / 2 + 1);

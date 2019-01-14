--1 -- select * from cpu

-- 2 --SELECT * FROM developer WHERE year_of_foundation BETWEEN 1954 AND 1970;
-- 2 --SELECT * FROM tournament WHERE xprize IN('4');
-- 2 --SELECT * FROM tournament WHERE rules LIKE 'S%';

-- 3 -- SELECT COUNT (*) FROM tournament WHERE xprize = '4';

-- 4--select * from tournament order by name, xprize desc

-- 5 --SELECT avg(price), max(price), min(price) FROM game;
-- 5 --sELECT avg(price), max(price), min(price) FROM dlc;

-- 6 --select * from game join dlc on (dlc.id_dlc = game.id_dlc)
-- 6 --select * from minimal_requirements join os on os.id_os = minimal_requirements.id_os

--7 --SELECT memory, COUNT(*) AS mem FROM gpu GROUP BY memory
------HAVING COUNT(*) > 2
------ORDER BY mem;

-- 8 --select * from optimal_requirements where id_os in (select id_os from os where bits > 20); 
-- 8 --select * from minimal_requirements where id_cpu in (select id_cpu from cpu WHERE ram IN('2')); 

-- 9 --INSERT INTO cpu VALUES ((SELECT MAX(id_cpu) FROM cpu)+1,'I am','krylov ivan', 2,2,8);

-- 10 --UPDATE cpu SET ram = 0 WHERE cores = 8;

-- 11 -- delete from game where price = (select max(price) from game);
-- 11 --delete from game where rating = (select min(rating) from game);

-- 12 -- delete from system_requirements where id_system_requirements not in (select id_system_requirements from game);


-- 13 -- select * from game join  (select id_game, SUM(dlc.price) from game join dlc using (id_game) group by id_game) as sub using (id_game);

-- 13 --  with summary as (select id_game as id_g, game.name as g_name, game.price as g_pr, SUM(dlc.price) as summ from game join dlc using (id_game) group by id_game) select id_g, g_name, g_pr, summ from summary where (g_pr < summ * 3);

-- 14 -- select * from cpu where cpu.cores * cpu.frequency > (select mult from (with summary as (select cpu.cores * cpu.frequency as mult from game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join cpu using (id_cpu)) select mult, ROW_NUMBER () OVER (order by mult) from summary) x where ROW_NUMBER = (select count(*) from game) / 2 + 1);

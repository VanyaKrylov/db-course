create view select_all as
 select * from cpu

create view select_between as SELECT * FROM developer WHERE year_of_foundation BETWEEN 1954 AND 1970;
create view select_in as SELECT * FROM tournament WHERE xprize IN('4');
create view select_like as SELECT * FROM tournament WHERE rules LIKE 'S%';

create view select_count as SELECT COUNT (*) FROM tournament WHERE xprize = '4';

create view select_order as select * from tournament order by name, xprize desc

create view select_amm as SELECT avg(price), max(price), min(price) FROM game;

create view select_many as select * from game join dlc on (dlc.id_dlc = game.id_dlc);

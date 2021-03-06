with summary as 
(select id_game as id_g, 
	game.name as g_name,
	game.price as g_pr,
	SUM(dlc.price) as summ from game 
		join dlc using (id_game)
		group by id_game) select id_g, g_name, g_pr, summ from summary 
			where (g_pr < summ * 3);

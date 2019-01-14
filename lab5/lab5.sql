CREATE OR REPLACE FUNCTION gen_requirements(game_src_id INTEGER, game_dst_id INTEGER, coeff INTEGER)
	RETURNS void 
LANGUAGE SQL
AS $$

-- minimal reqs --
WITH src_game_min as (select id_game, cpu.manufacturer as c_man, cpu.model as c_mod, cpu.cores as c_cores, cpu.frequency as c_freq, cpu.RAM as ram FROM game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join cpu using (id_cpu) where id_game = game_src_id)
INSERT INTO cpu VALUES ((SELECT MAX(id_cpu) FROM cpu) + 1, (SELECT c_man FROM src_game_min ), (SELECT c_mod FROM src_game_min), (SELECT c_cores FROM src_game_min) * coeff, (SELECT c_freq FROM src_game_min), (SELECT ram FROM src_game_min) * coeff);

WITH src_game_min as (select id_game, gpu.manufacturer as g_man, gpu.model as g_mod, gpu.memory as g_mem FROM game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join gpu using (id_gpu) where id_game = game_src_id)
INSERT INTO gpu VALUES ((SELECT MAX(id_gpu) FROM gpu) + 1, (SELECT g_man FROM src_game_min ), (SELECT g_mod FROM src_game_min), (SELECT g_mem FROM src_game_min) * coeff);

WITH src_game_min as (select id_game, OS.manufacturer as os_man, OS.version as os_v, OS.bits as os_b FROM game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join OS using (id_OS) where id_game = game_src_id) 
INSERT INTO OS VALUES ( (SELECT MAX(id_OS) FROM OS) + 1, (SELECT os_v FROM src_game_min),  (SELECT os_b FROM src_game_min), (SELECT os_man FROM src_game_min) );

INSERT INTO minimal_requirements VALUES ( (SELECT MAX(id_minimal_requirements) FROM minimal_requirements)+1, (SELECT id_OS FROM OS ORDER BY id_OS DESC LIMIT 1), (SELECT id_cpu FROM cpu ORDER BY id_cpu DESC LIMIT 1), (SELECT id_gpu FROM gpu ORDER BY id_gpu DESC LIMIT 1) );

-- optimal requirements --
WITH src_game_opt as (select id_game, cpu.manufacturer as c_man, cpu.model as c_mod, cpu.cores as c_cores, cpu.frequency as c_freq, cpu.RAM as ram FROM game join system_requirements using (id_system_requirements) join optimal_requirements using (id_optimal_requirements) join cpu using (id_cpu) where id_game = game_src_id)
INSERT INTO cpu VALUES ((SELECT MAX(id_cpu) FROM cpu) + 1, (SELECT c_man FROM src_game_opt ), (SELECT c_mod FROM src_game_opt), (SELECT c_cores FROM src_game_opt) * coeff, (SELECT c_freq FROM src_game_opt), (SELECT ram FROM src_game_opt) * coeff);

WITH src_game_opt as (select id_game,  gpu.manufacturer as g_man, gpu.model as g_mod, gpu.memory as g_mem FROM game join system_requirements using (id_system_requirements) join optimal_requirements using (id_optimal_requirements) join gpu using (id_gpu) where id_game = game_src_id)
INSERT INTO gpu VALUES ((SELECT MAX(id_gpu) FROM gpu) + 1, (SELECT g_man FROM src_game_opt), (SELECT g_mod FROM src_game_opt), (SELECT g_mem FROM src_game_opt) * coeff);

WITH src_game_opt as (select id_game, OS.manufacturer as os_man, OS.version as os_v, OS.bits as os_b FROM game join system_requirements using (id_system_requirements) join optimal_requirements using (id_optimal_requirements) join OS using (id_OS) where id_game = game_src_id) 
INSERT INTO OS VALUES ( (SELECT MAX(id_OS) FROM OS) + 1, (SELECT os_v FROM src_game_opt),  (SELECT os_b FROM src_game_opt), (SELECT os_man FROM src_game_opt) );

INSERT INTO optimal_requirements VALUES ( (SELECT MAX(id_optimal_requirements) FROM optimal_requirements) + 1, (SELECT id_OS FROM OS ORDER BY id_OS DESC LIMIT 1), (SELECT id_cpu FROM cpu ORDER BY id_cpu DESC LIMIT 1), (SELECT id_gpu FROM gpu ORDER BY id_gpu DESC LIMIT 1) );

-- system requirements --
WITH sys_req AS (SELECT id_game, system_requirements.OS as os, system_requirements.memory_space as mem FROM game join system_requirements using (id_system_requirements) where id_game = game_src_id )
INSERT INTO system_requirements VALUES ( (SELECT MAX(id_system_requirements) FROM system_requirements) + 1, (SELECT os FROM sys_req), (SELECT mem FROM sys_req), (SELECT id_minimal_requirements FROM minimal_requirements ORDER BY id_minimal_requirements DESC LIMIT 1), 1, (SELECT id_optimal_requirements FROM optimal_requirements ORDER BY id_optimal_requirements DESC LIMIT 1) );

-- update game reqs --
UPDATE game SET id_system_requirements = (SELECT id_system_requirements FROM system_requirements ORDER BY id_system_requirements DESC LIMIT 1) where id_game = game_dst_id;
$$;

SELECT gen_requirements(5, 12, 2);

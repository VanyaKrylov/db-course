WITH src_game_min as (select id_game as i_g, system_requirements.OS as os, system_requirements.memory_space as mem, cpu.manufacturer as c_man, cpu.model as c_mod, cpu.cores as c_cores, cpu.frequency as c_freq, cpu.RAM as ram FROM game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join cpu using (id_cpu) join gpu using (id_gpu) join OS using (id_OS) where id_game = 5)
INSERT INTO cpu VALUES ((SELECT MAX(id_cpu) FROM cpu) + 1, (SELECT c_man FROM src_game_min ), (SELECT c_mod FROM src_game_min), (SELECT c_cores FROM src_game_min), (SELECT c_freq FROM src_game_min), (SELECT ram FROM src_game_min));

WITH src_game_min as (select id_game as i_g, system_requirements.OS as os, system_requirements.memory_space as mem, gpu.manufacturer as g_man, gpu.model as g_mod, gpu.memory as g_mem FROM game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join cpu using (id_cpu) join gpu using (id_gpu) join OS using (id_OS) where id_game = 5)
INSERT INTO gpu VALUES ((SELECT MAX(id_gpu) FROM gpu) + 1, (SELECT g_man FROM src_game_min ), (SELECT g_mod FROM src_game_min), (SELECT g_mem FROM src_game_min));

WITH src_game_min as (select id_game as i_g, system_requirements.OS as os, system_requirements.memory_space as mem, OS.manufacturer as os_man, OS.version as os_v, OS.bits as os_b FROM game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join cpu using (id_cpu) join gpu using (id_gpu) join OS using (id_OS) where id_game = 5) 
INSERT INTO OS VALUES ( (SELECT MAX(id_OS) FROM OS) + 1, (SELECT os_v FROM src_game_min),  (SELECT os_b FROM src_game_min), (SELECT os_man FROM src_game_min) );

INSERT INTO minimal_requirements VALUES ( (SELECT MAX(id_minimal_requirements) FROM minimal_requirements)+1, (SELECT id_OS FROM OS ORDER BY id_OS DESC LIMIT 1), (SELECT id_cpu FROM cpu ORDER BY id_cpu DESC LIMIT 1), (SELECT id_gpu FROM gpu ORDER BY id_gpu DESC LIMIT 1) );

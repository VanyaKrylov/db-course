CREATE OR REPLACE FUNCTION dev_dif_dynamics(dev_id integer)
RETURNS TABLE (game_name varchar, rel_date date, id_dev integer, difficulty bigint)
LANGUAGE SQL
AS $$

SELECT name, release_date, id_developer, cpu.cores * cpu.frequency * cpu.ram * gpu.memory * (SELECT COUNT(*) FROM game join system_requirements using (id_system_requirements) join preinstalled_software using (id_system_requirements) WHERE id_developer = dev_id ) as difficulty FROM game join system_requirements using (id_system_requirements) join minimal_requirements using (id_minimal_requirements) join cpu using (id_cpu) join gpu using (id_gpu) WHERE id_developer = dev_id ORDER BY release_date;

$$;

SELECT * FROM dev_dif_dynamics(3);

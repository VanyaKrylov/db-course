delete from system_requirements where id_system_requirements not in (select id_system_requirements from game);


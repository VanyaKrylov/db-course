CREATE OR REPLACE FUNCTION sys_req_check() 
	returns trigger 
LANGUAGE plpgsql
AS $$
DECLARE 
	conflicts BIGINT [];
BEGIN 
	conflicts := ARRAY(
		SELECT id_system_requirements from system_requirements where (select cpu.cores from minimal_requirements join cpu using (id_cpu) where id_minimal_requirements = new.id_minimal_requirements) > (select cpu.cores from optimal_requirements join cpu using (id_cpu) where id_optimal_requirements = new.id_optimal_requirements)
	);
	IF array_length(conflicts, 1) > 0 THEN
		RAISE EXCEPTION 'Incorrect format: %', conflicts;
	END IF;
	RETURN new;
END;
$$;

CREATE TRIGGER sys_req_check
	BEFORE INSERT OR UPDATE
	ON system_requirements
	FOR EACH ROW EXECUTE PROCEDURE sys_req_check();

CREATE OR REPLACE FUNCTION game_name_leven_check() 
	returns trigger 
LANGUAGE plpgsql
AS $$
DECLARE 
	conflicts varchar [];
BEGIN 
	conflicts := ARRAY(
		SELECT name FROM game WHERE (new.id_developer = id_developer) AND (levenshtein(new.name :: text, name :: text) > 3)
	);
	IF array_length(conflicts, 1) > 0 THEN
		RAISE EXCEPTION 'Levenshtein value is greater than 3. Conflicts: %', conflicts;
	END IF;
	RETURN new;
END;
$$;

CREATE TRIGGER game_name_leven_check
	BEFORE INSERT OR UPDATE
	ON game
	FOR EACH ROW EXECUTE PROCEDURE game_name_leven_check();

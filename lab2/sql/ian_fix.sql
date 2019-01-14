CREATE TABLE IF NOT EXISTS OS(
	id_OS serial PRIMARY KEY,
	version varchar(32),
	bits smallint NOT NULL ,
	manufacturer varchar(32)
	);
	
CREATE TABLE IF NOT EXISTS CPU(
	id_CPU serial PRIMARY KEY,
	manufacturer varchar(32) NOT NULL,
	model varchar(64),
	cores smallint NOT NULL ,
	frequency smallint,
	RAM smallint NOT NULL
	);
CREATE TABLE IF NOT EXISTS tournament(
	id_tournament serial PRIMARY KEY ,
	name varchar(5),
	rules text,
	date_from date,
	date_to date,
	xprize smallint NOT NULL
	);
CREATE TABLE IF NOT EXISTS GPU(
	id_GPU serial PRIMARY KEY,
	manufacturer varchar(32) NOT NULL,
	model varchar(64),
	memory smallint NOT NULL 	
);
CREATE TABLE IF NOT EXISTS developer(
	id_developer serial PRIMARY KEY,
	name varchar(50),
	year_of_foundation smallint,
	website varchar(128)
);

CREATE TABLE IF NOT EXISTS minimal_requirements(
	id_minimal_requirements serial PRIMARY KEY,
	id_os integer,
	id_cpu integer,
	id_gpu integer,
	FOREIGN KEY (id_OS) REFERENCES OS(id_OS),
	FOREIGN KEY (id_CPU) REFERENCES CPU(id_CPU),
	FOREIGN KEY (id_GPU) REFERENCES GPU(id_GPU)
	);

CREATE TABLE IF NOT EXISTS optimal_requirements(
	id_optimal_requirements serial PRIMARY KEY,
	id_os integer,
	id_cpu integer,
	id_gpu integer,
	FOREIGN KEY (id_OS) REFERENCES OS(id_OS),
	FOREIGN KEY (id_CPU) REFERENCES CPU(id_CPU),
	FOREIGN KEY (id_GPU) REFERENCES GPU(id_GPU)
	);


CREATE TABLE IF NOT EXISTS system_requirements(
	id_system_requirements serial PRIMARY KEY,
	OS varchar(64) NOT NULL,
	memory_space smallint NOT NULL ,
	id_minimal_requirements integer,
	--id_preinstalled_software integer,--
	id_optimal_requirements integer,
	FOREIGN KEY (id_minimal_requirements) REFERENCES minimal_requirements(id_minimal_requirements),
	FOREIGN KEY (id_optimal_requirements) REFERENCES optimal_requirements(id_optimal_requirements)
);
CREATE TABLE IF NOT EXISTS preinstalled_software(
	id_preinstalled_software serial PRIMARY KEY,
	name varchar(32),
	instructions text,
	download_link varchar(32),
	id_system_requirements integer,
	FOREIGN KEY (id_system_requirements) REFERENCES system_requirements(id_system_requirements)
);
CREATE TABLE IF NOT EXISTS game(
	id_game serial PRIMARY KEY ,
	name text,
	price smallint NOT NULL ,
	release_date date,
	rating smallint NOT NULL,
	language text,
	id_developer integer,
	id_system_requirements integer,
	id_tournament integer,
	FOREIGN KEY (id_developer) REFERENCES developer(id_developer),
	FOREIGN KEY (id_system_requirements) REFERENCES system_requirements(id_system_requirements),
	FOREIGN KEY (id_tournament) REFERENCES tournament(id_tournament),
	PEGI_rating smallint NOT NULL

);
CREATE TABLE IF NOT EXISTS DLC(
	id_DLC serial PRIMARY KEY,
	name varchar(50),
	price smallint NOT NULL ,
	release_date date,
	description text,
	id_game integer,
	FOREIGN KEY (id_game) REFERENCES game(id_game)
);






		

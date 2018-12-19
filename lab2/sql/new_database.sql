-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2-alpha
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
-- 

-- object: public.game | type: TABLE --
-- DROP TABLE IF EXISTS public.game CASCADE;
CREATE TABLE public.game(
	id serial NOT NULL,
	name text,
	price smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	release_date date,
	rating smallint NOT NULL,
	language text,
	"id_PEGI_rating" smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	id_system_requirements integer,
	id_developer integer NOT NULL,
	"id_DLC" integer,
	id_tournament integer,
	CONSTRAINT game_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.game OWNER TO postgres;
-- ddl-end --

-- object: public."DLC" | type: TABLE --
-- DROP TABLE IF EXISTS public."DLC" CASCADE;
CREATE TABLE public."DLC"(
	id serial NOT NULL,
	name varchar(64),
	price smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	release_date date,
	description text,
	CONSTRAINT "DLC_pk" PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."DLC" OWNER TO postgres;
-- ddl-end --

-- object: public.system_requirements | type: TABLE --
-- DROP TABLE IF EXISTS public.system_requirements CASCADE;
CREATE TABLE public.system_requirements(
	id serial NOT NULL,
	"OS" varchar(64),
	memory_space smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	id_minimal_requirements smallint,
	id_optimal_requirements integer,
	id_preinstalled_software integer,
	CONSTRAINT system_requirements_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.system_requirements OWNER TO postgres;
-- ddl-end --

-- object: public.developer | type: TABLE --
-- DROP TABLE IF EXISTS public.developer CASCADE;
CREATE TABLE public.developer(
	id serial NOT NULL,
	name varchar(64) NOT NULL,
	year_of_foundation smallint,
	website varchar(128),
	CONSTRAINT developer_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.developer OWNER TO postgres;
-- ddl-end --

-- object: public."OS" | type: TABLE --
-- DROP TABLE IF EXISTS public."OS" CASCADE;
CREATE TABLE public."OS"(
	id serial NOT NULL,
	manufacturer varchar(32),
	version varchar(32),
	bits smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	CONSTRAINT "OS_pk" PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."OS" OWNER TO postgres;
-- ddl-end --

-- object: public."CPU" | type: TABLE --
-- DROP TABLE IF EXISTS public."CPU" CASCADE;
CREATE TABLE public."CPU"(
	id serial NOT NULL,
	manufacturer varchar(32),
	model varchar(64),
	cores smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	frequency float,
	"RAM" smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	CONSTRAINT "CPU_pk" PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."CPU" OWNER TO postgres;
-- ddl-end --

-- object: public."GPU" | type: TABLE --
-- DROP TABLE IF EXISTS public."GPU" CASCADE;
CREATE TABLE public."GPU"(
	id serial NOT NULL,
	manufacturer varchar(32),
	model varchar(64),
	memory smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	CONSTRAINT "GPU_pk" PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."GPU" OWNER TO postgres;
-- ddl-end --

-- object: public.minimal_requirements | type: TABLE --
-- DROP TABLE IF EXISTS public.minimal_requirements CASCADE;
CREATE TABLE public.minimal_requirements(
	id smallint NOT NULL,
	"id_OS" integer,
	"id_CPU" integer,
	"id_GPU" integer,
	CONSTRAINT minimal_requirements_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.minimal_requirements OWNER TO postgres;
-- ddl-end --

-- object: public.optimal_requirements | type: TABLE --
-- DROP TABLE IF EXISTS public.optimal_requirements CASCADE;
CREATE TABLE public.optimal_requirements(
	id serial NOT NULL,
	"id_OS" integer,
	"id_GPU" integer,
	"id_CPU" integer,
	CONSTRAINT optimal_requirements_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.optimal_requirements OWNER TO postgres;
-- ddl-end --

-- object: "CPU_fk" | type: CONSTRAINT --
-- ALTER TABLE public.minimal_requirements DROP CONSTRAINT IF EXISTS "CPU_fk" CASCADE;
ALTER TABLE public.minimal_requirements ADD CONSTRAINT "CPU_fk" FOREIGN KEY ("id_CPU")
REFERENCES public."CPU" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: minimal_requirements_uq | type: CONSTRAINT --
-- ALTER TABLE public.minimal_requirements DROP CONSTRAINT IF EXISTS minimal_requirements_uq CASCADE;
ALTER TABLE public.minimal_requirements ADD CONSTRAINT minimal_requirements_uq UNIQUE ("id_CPU");
-- ddl-end --

-- object: "OS_fk" | type: CONSTRAINT --
-- ALTER TABLE public.minimal_requirements DROP CONSTRAINT IF EXISTS "OS_fk" CASCADE;
ALTER TABLE public.minimal_requirements ADD CONSTRAINT "OS_fk" FOREIGN KEY ("id_OS")
REFERENCES public."OS" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: minimal_requirements_uq1 | type: CONSTRAINT --
-- ALTER TABLE public.minimal_requirements DROP CONSTRAINT IF EXISTS minimal_requirements_uq1 CASCADE;
ALTER TABLE public.minimal_requirements ADD CONSTRAINT minimal_requirements_uq1 UNIQUE ("id_OS");
-- ddl-end --

-- object: "GPU_fk" | type: CONSTRAINT --
-- ALTER TABLE public.minimal_requirements DROP CONSTRAINT IF EXISTS "GPU_fk" CASCADE;
ALTER TABLE public.minimal_requirements ADD CONSTRAINT "GPU_fk" FOREIGN KEY ("id_GPU")
REFERENCES public."GPU" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: minimal_requirements_uq2 | type: CONSTRAINT --
-- ALTER TABLE public.minimal_requirements DROP CONSTRAINT IF EXISTS minimal_requirements_uq2 CASCADE;
ALTER TABLE public.minimal_requirements ADD CONSTRAINT minimal_requirements_uq2 UNIQUE ("id_GPU");
-- ddl-end --

-- object: "GPU_fk" | type: CONSTRAINT --
-- ALTER TABLE public.optimal_requirements DROP CONSTRAINT IF EXISTS "GPU_fk" CASCADE;
ALTER TABLE public.optimal_requirements ADD CONSTRAINT "GPU_fk" FOREIGN KEY ("id_GPU")
REFERENCES public."GPU" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: optimal_requirements_uq | type: CONSTRAINT --
-- ALTER TABLE public.optimal_requirements DROP CONSTRAINT IF EXISTS optimal_requirements_uq CASCADE;
ALTER TABLE public.optimal_requirements ADD CONSTRAINT optimal_requirements_uq UNIQUE ("id_GPU");
-- ddl-end --

-- object: "OS_fk" | type: CONSTRAINT --
-- ALTER TABLE public.optimal_requirements DROP CONSTRAINT IF EXISTS "OS_fk" CASCADE;
ALTER TABLE public.optimal_requirements ADD CONSTRAINT "OS_fk" FOREIGN KEY ("id_OS")
REFERENCES public."OS" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: optimal_requirements_uq1 | type: CONSTRAINT --
-- ALTER TABLE public.optimal_requirements DROP CONSTRAINT IF EXISTS optimal_requirements_uq1 CASCADE;
ALTER TABLE public.optimal_requirements ADD CONSTRAINT optimal_requirements_uq1 UNIQUE ("id_OS");
-- ddl-end --

-- object: "CPU_fk" | type: CONSTRAINT --
-- ALTER TABLE public.optimal_requirements DROP CONSTRAINT IF EXISTS "CPU_fk" CASCADE;
ALTER TABLE public.optimal_requirements ADD CONSTRAINT "CPU_fk" FOREIGN KEY ("id_CPU")
REFERENCES public."CPU" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: optimal_requirements_uq2 | type: CONSTRAINT --
-- ALTER TABLE public.optimal_requirements DROP CONSTRAINT IF EXISTS optimal_requirements_uq2 CASCADE;
ALTER TABLE public.optimal_requirements ADD CONSTRAINT optimal_requirements_uq2 UNIQUE ("id_CPU");
-- ddl-end --

-- object: minimal_requirements_fk | type: CONSTRAINT --
-- ALTER TABLE public.system_requirements DROP CONSTRAINT IF EXISTS minimal_requirements_fk CASCADE;
ALTER TABLE public.system_requirements ADD CONSTRAINT minimal_requirements_fk FOREIGN KEY (id_minimal_requirements)
REFERENCES public.minimal_requirements (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: system_requirements_uq | type: CONSTRAINT --
-- ALTER TABLE public.system_requirements DROP CONSTRAINT IF EXISTS system_requirements_uq CASCADE;
ALTER TABLE public.system_requirements ADD CONSTRAINT system_requirements_uq UNIQUE (id_minimal_requirements);
-- ddl-end --

-- object: optimal_requirements_fk | type: CONSTRAINT --
-- ALTER TABLE public.system_requirements DROP CONSTRAINT IF EXISTS optimal_requirements_fk CASCADE;
ALTER TABLE public.system_requirements ADD CONSTRAINT optimal_requirements_fk FOREIGN KEY (id_optimal_requirements)
REFERENCES public.optimal_requirements (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: system_requirements_uq1 | type: CONSTRAINT --
-- ALTER TABLE public.system_requirements DROP CONSTRAINT IF EXISTS system_requirements_uq1 CASCADE;
ALTER TABLE public.system_requirements ADD CONSTRAINT system_requirements_uq1 UNIQUE (id_optimal_requirements);
-- ddl-end --

-- object: system_requirements_fk | type: CONSTRAINT --
-- ALTER TABLE public.game DROP CONSTRAINT IF EXISTS system_requirements_fk CASCADE;
ALTER TABLE public.game ADD CONSTRAINT system_requirements_fk FOREIGN KEY (id_system_requirements)
REFERENCES public.system_requirements (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: game_uq | type: CONSTRAINT --
-- ALTER TABLE public.game DROP CONSTRAINT IF EXISTS game_uq CASCADE;
ALTER TABLE public.game ADD CONSTRAINT game_uq UNIQUE (id_system_requirements);
-- ddl-end --

-- object: developer_fk | type: CONSTRAINT --
-- ALTER TABLE public.game DROP CONSTRAINT IF EXISTS developer_fk CASCADE;
ALTER TABLE public.game ADD CONSTRAINT developer_fk FOREIGN KEY (id_developer)
REFERENCES public.developer (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: game_uq1 | type: CONSTRAINT --
-- ALTER TABLE public.game DROP CONSTRAINT IF EXISTS game_uq1 CASCADE;
ALTER TABLE public.game ADD CONSTRAINT game_uq1 UNIQUE (id_developer);
-- ddl-end --

-- object: "DLC_fk" | type: CONSTRAINT --
-- ALTER TABLE public.game DROP CONSTRAINT IF EXISTS "DLC_fk" CASCADE;
ALTER TABLE public.game ADD CONSTRAINT "DLC_fk" FOREIGN KEY ("id_DLC")
REFERENCES public."DLC" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.tournament | type: TABLE --
-- DROP TABLE IF EXISTS public.tournament CASCADE;
CREATE TABLE public.tournament(
	id serial NOT NULL,
	name varchar(64),
	period daterange,
	rules text,
	prize smallint,
	CONSTRAINT tournaments_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.tournament OWNER TO postgres;
-- ddl-end --

-- object: tournament_fk | type: CONSTRAINT --
-- ALTER TABLE public.game DROP CONSTRAINT IF EXISTS tournament_fk CASCADE;
ALTER TABLE public.game ADD CONSTRAINT tournament_fk FOREIGN KEY (id_tournament)
REFERENCES public.tournament (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.preinstalled_software | type: TABLE --
-- DROP TABLE IF EXISTS public.preinstalled_software CASCADE;
CREATE TABLE public.preinstalled_software(
	id serial NOT NULL,
	name varchar(64),
	download_link varchar(256),
	instructions text,
	CONSTRAINT preinstalled_software_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.preinstalled_software OWNER TO postgres;
-- ddl-end --

-- object: preinstalled_software_fk | type: CONSTRAINT --
-- ALTER TABLE public.system_requirements DROP CONSTRAINT IF EXISTS preinstalled_software_fk CASCADE;
ALTER TABLE public.system_requirements ADD CONSTRAINT preinstalled_software_fk FOREIGN KEY (id_preinstalled_software)
REFERENCES public.preinstalled_software (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --



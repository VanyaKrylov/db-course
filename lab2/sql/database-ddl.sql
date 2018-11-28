
CREATE TABLE public.game(
	id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	price smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	release_date date,
	rating smallint NOT NULL,
	language text,
	id_developer varchar(64),
	"id_PEGI_rating" smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	"id_DLC" varchar(64),
	id_system_requirements smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	id_developer1 varchar(64) NOT NULL,
	CONSTRAINT game_pk PRIMARY KEY (id)

);


ALTER TABLE public.game OWNER TO postgres;

CREATE TABLE public."DLC"(
	id smallint NOT NULL,
	price smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	release_date date,
	description text,
	id_game smallint,
	CONSTRAINT "DLC_pk" PRIMARY KEY (id)

);

ALTER TABLE public."DLC" OWNER TO postgres;

ALTER TABLE public."DLC" ADD CONSTRAINT game_fk FOREIGN KEY (id_game)
REFERENCES public.game (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE public.system_requirements(
	"OS" varchar(64) NOT NULL,
	memory_space smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	preinstalled_software text,
	id_game smallint,
	id_minimal_requirements smallint,
	id_optimal_requirements smallint,
	CONSTRAINT system_requirements_pk PRIMARY KEY ("OS")

);

ALTER TABLE public.system_requirements OWNER TO postgres;

CREATE TABLE public.developer(
	id varchar(64) NOT NULL,
	rating smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	year_of_foundation smallint,
	website varchar(128),
	CONSTRAINT developer_pk PRIMARY KEY (id)

);

ALTER TABLE public.developer OWNER TO postgres;

CREATE TABLE public."OS"(
	id varchar(64) NOT NULL,
	version varchar(32),
	bits smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	CONSTRAINT "OS_pk" PRIMARY KEY (id)

);

ALTER TABLE public."OS" OWNER TO postgres;

CREATE TABLE public."CPU"(
	manufacturer varchar(32) NOT NULL,
	model varchar(64),
	cores smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	frequency smallint,
	"RAM" smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	CONSTRAINT "CPU_pk" PRIMARY KEY (manufacturer)

);

ALTER TABLE public."CPU" OWNER TO postgres;

CREATE TABLE public."GPU"(
	manufacturer varchar(32) NOT NULL,
	model varchar(64),
	memory smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	CONSTRAINT "GPU_pk" PRIMARY KEY (manufacturer)

);

ALTER TABLE public."GPU" OWNER TO postgres;

ALTER TABLE public.system_requirements ADD CONSTRAINT game_fk FOREIGN KEY (id_game)
REFERENCES public.game (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.system_requirements ADD CONSTRAINT system_requirements_uq UNIQUE (id_game);

ALTER TABLE public.game ADD CONSTRAINT developer_fk FOREIGN KEY (id_developer1)
REFERENCES public.developer (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE TABLE public.minimal_requirements(
	id smallint NOT NULL,
	"manufacturer_CPU" varchar(32),
	"id_OS" varchar(64),
	"manufacturer_GPU" varchar(32),
	CONSTRAINT minimal_requirements_pk PRIMARY KEY (id)

);

ALTER TABLE public.minimal_requirements OWNER TO postgres;

CREATE TABLE public.optimal_requirements(
	id smallint NOT NULL,
	"manufacturer_GPU" varchar(32),
	"id_OS" varchar(64),
	"manufacturer_CPU" varchar(32),
	CONSTRAINT optimal_requirements_pk PRIMARY KEY (id)

);

ALTER TABLE public.optimal_requirements OWNER TO postgres;

ALTER TABLE public.minimal_requirements ADD CONSTRAINT "CPU_fk" FOREIGN KEY ("manufacturer_CPU")
REFERENCES public."CPU" (manufacturer) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.minimal_requirements ADD CONSTRAINT minimal_requirements_uq UNIQUE ("manufacturer_CPU");

ALTER TABLE public.minimal_requirements ADD CONSTRAINT "OS_fk" FOREIGN KEY ("id_OS")
REFERENCES public."OS" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.minimal_requirements ADD CONSTRAINT minimal_requirements_uq1 UNIQUE ("id_OS");

ALTER TABLE public.minimal_requirements ADD CONSTRAINT "GPU_fk" FOREIGN KEY ("manufacturer_GPU")
REFERENCES public."GPU" (manufacturer) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.minimal_requirements ADD CONSTRAINT minimal_requirements_uq2 UNIQUE ("manufacturer_GPU");

ALTER TABLE public.optimal_requirements ADD CONSTRAINT "GPU_fk" FOREIGN KEY ("manufacturer_GPU")
REFERENCES public."GPU" (manufacturer) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.optimal_requirements ADD CONSTRAINT optimal_requirements_uq UNIQUE ("manufacturer_GPU");

ALTER TABLE public.optimal_requirements ADD CONSTRAINT "OS_fk" FOREIGN KEY ("id_OS")
REFERENCES public."OS" (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.optimal_requirements ADD CONSTRAINT optimal_requirements_uq1 UNIQUE ("id_OS");

ALTER TABLE public.optimal_requirements ADD CONSTRAINT "CPU_fk" FOREIGN KEY ("manufacturer_CPU")
REFERENCES public."CPU" (manufacturer) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.optimal_requirements ADD CONSTRAINT optimal_requirements_uq2 UNIQUE ("manufacturer_CPU");

ALTER TABLE public.system_requirements ADD CONSTRAINT minimal_requirements_fk FOREIGN KEY (id_minimal_requirements)
REFERENCES public.minimal_requirements (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.system_requirements ADD CONSTRAINT system_requirements_uq1 UNIQUE (id_minimal_requirements);

ALTER TABLE public.system_requirements ADD CONSTRAINT optimal_requirements_fk FOREIGN KEY (id_optimal_requirements)
REFERENCES public.optimal_requirements (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE public.system_requirements ADD CONSTRAINT system_requirements_uq2 UNIQUE (id_optimal_requirements);




CREATE TABLE temporadas (
    id SERIAL,
    nombre_temporada VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);


CREATE TABLE jornadas(
id SERIAL,
nombre_jornada VARCHAR(30) NOT NULL,
temporada_id integer NOT NULL,
created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(id),
CONSTRAINT jornadas_temporadas_fk FOREIGN KEY(temporada_id) REFERENCES temporadas(id)
);


CREATE TABLE partidos(
    id SERIAL,
    nombre_partido VARCHAR(50) NOT NULL,
    jornada_id INTEGER NOT NULL,
    temporada_id INTEGER NOT NULL,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT partidos_jornadas_fk FOREIGN KEY(jornada_id) REFERENCES jornadas(id),
    CONSTRAINT partidos_temporadas_fk FOREIGN KEY(temporada_id) REFERENCES temporadas(id)
);


CREATE TABLE clubes(
    id SERIAL,
    nombre VARCHAR(30) NOT NULL UNIQUE,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);



CREATE TABLE partidos_clubes(
    partido_id INTEGER NOT NULL,
    club_id INTEGER NOT NULL,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(partido_id,club_id),
    CONSTRAINT partidos_clubes_partidos_fk FOREIGN KEY(partido_id) REFERENCES partidos(id),
    CONSTRAINT partidos_clubes_clubes_fk FOREIGN KEY(club_id) REFERENCES clubes(id)
);

--PARA LA TABLA DE RESULTADOS DEBO CREAR PRIMERO EL ENUM (VÁLIDO SOLO PARA POSTGRESQL)
--CREATE TYPE resultado AS ENUM ('v','d','e');

CREATE TABLE resultados(
    id SERIAL,
    resultado resultado NOT NULL DEFAULT 'e',
    partido_id INTEGER NOT NULL,
    club_id INTEGER NOT NULL,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT resultados_partidos_clubes FOREIGN KEY(partido_id,club_id) REFERENCES partidos_clubes(partido_id,club_id)
);

--CREATE TYPE condicion AS ENUM('l','v');

CREATE TABLE condiciones(
    id SERIAL,
    condicion condicion NOT NULL,
    partido_id INTEGER NOT NULL,
    club_id INTEGER NOT NULL,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT condiciones_partidos_clubes FOREIGN KEY(partido_id,club_id) REFERENCES partidos_clubes(partido_id,club_id)
);


CREATE TABLE jugadores(
    id SERIAL,
    jugador VARCHAR(40) NOT NULL,
    club_id INTEGER,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT jugadores_clubes_fk FOREIGN KEY(club_id) REFERENCES clubes(id)
);


CREATE TABLE goles(
    id SERIAL,
    tiempo INTERVAL MINUTE NOT NULL,
    jugador_id INTEGER NOT NULL,
    club_id INTEGER NOT NULL,
    jugador_partido INTEGER NOT NULL,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT goles_jugadores_fk FOREIGN KEY(jugador_id) REFERENCES jugadores(id),
    CONSTRAINT goles_clubes_fk FOREIGN KEY(club_id) REFERENCES clubes(id),
    CONSTRAINT goles_partidos_fk FOREIGN KEY(jugador_partido) REFERENCES partidos(id)
);


CREATE TABLE asistencias(
    id SERIAL,
    tiempo INTERVAL MINUTE NOT NULL,
    jugador_id INTEGER NOT NULL,
    jugador_club_id INTEGER NOT NULL,
    partido_id INTEGER NOT NULL,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT asistencias_jugadores_fk FOREIGN KEY(jugador_id) REFERENCES jugadores(id),
    CONSTRAINT asistencias_clubes_fk FOREIGN KEY(jugador_club_id) REFERENCES clubes(id),
    CONSTRAINT asistencias_partidos_fk FOREIGN KEY(partido_id) REFERENCES partidos(id)
);


--CREATE TYPE tipo_tarjeta AS ENUM('r','a');

CREATE TABLE tarjetas(
    id SERIAL,
    tiempo INTERVAL MINUTE NOT NULL,
    tipo tipo_tarjeta NOT NULL,
    jugador_id INTEGER NOT NULL,
    jugador_club_id INTEGER NOT NULL,
    partido_id INTEGER NOT NULL,
    created_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT tarjetas_jugadores_fk FOREIGN KEY(jugador_id) REFERENCES jugadores(id),
    CONSTRAINT tarjetas_clubes_fk FOREIGN KEY(jugador_club_id) REFERENCES clubes(id),
    CONSTRAINT tarjetas_partidos FOREIGN KEY (partido_id) REFERENCES partidos(id)
);



CREATE TABLE clasificaciones(

    id SERIAL PRIMARY KEY,
    puntos INTEGER NOT NULL DEFAULT 0,
    partidos_jugados INTEGER NOT NULL DEFAULT 0,
    partidos_ganados INTEGER NOT NULL DEFAULT 0,
    partidos_empatados INTEGER NOT NULL DEFAULT 0,
    partidos_perdidos INTEGER NOT NULL DEFAULT 0,
    goles_favor INTEGER NOT NULL DEFAULT 0,
    goles_contra INTEGER NOT NULL DEFAULT 0,
    diferencia_goles INTEGER GENERATED ALWAYS AS (goles_favor - goles_contra) STORED,
    temporada_id INTEGER NOT NULL,
    club_id INTEGER NOT NULL,
     CONSTRAINT clasificaciones_temporadas FOREIGN KEY(temporada_id) REFERENCES temporadas(id),
      CONSTRAINT clasificaciones_clubes FOREIGN KEY(club_id) REFERENCES clubes(id)
);


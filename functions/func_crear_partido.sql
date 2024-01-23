
CREATE OR REPLACE FUNCTION crear_partido(team1 text,team2 text,jornada text,temporada text) RETURNS VOID
LANGUAGE PLPGSQL
AS
$FUNC$
BEGIN
--insert into partidos
    INSERT INTO partidos(jornada_id,nombre_partido, temporada_id) VALUES ( 
        (SELECT id FROM jornadas WHERE nombre_jornada ilike CONCAT('%',jornada)), 

        (SELECT CONCAT( (SELECT nombre FROM clubes WHERE nombre ilike CONCAT('%',team1)),
            ' - ',
            (SELECT nombre FROM clubes WHERE nombre ilike CONCAT('%',team2))
        ) ),
        (SELECT id FROM temporadas WHERE nombre_temporada ILIKE CONCAT('%',temporada))
    );

--inserto into partidos_clubes

    INSERT INTO partidos_clubes(partido_id,club_id) VALUES
    (
        (SELECT id FROM partidos WHERE nombre_partido ILIKE CONCAT(team1,'%',team2)),
        (SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',team1))
    ),
    (
        (SELECT id FROM partidos WHERE nombre_partido ILIKE CONCAT(team1,'%',team2)),
        (SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',team2))
    );

--insert into condiciones

    INSERT INTO condiciones(condicion,partido_id,club_id) VALUES (
        'l',
        (SELECT id FROM partidos WHERE nombre_partido ILIKE CONCAT(team1,'%',team2)),
        (SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',team1))
    ),
    (
        'v',
        (SELECT id FROM partidos WHERE nombre_partido ILIKE CONCAT(team1,'%',team2)),
        (SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',team2))
    );
-- insert into resultados

    INSERT INTO resultados(partido_id,club_id) VALUES (
        (SELECT id FROM partidos WHERE nombre_partido ILIKE CONCAT(team1,'%',team2)),
        (SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',team1))
    ),
    (
        (SELECT id FROM partidos WHERE nombre_partido ILIKE CONCAT(team1,'%',team2)),
        (SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',team2))
    );

END;
$FUNC$
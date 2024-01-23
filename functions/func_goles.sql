CREATE OR REPLACE FUNCTION gol(team1 text, team2 text,e_anota text, temporada text, futbolista text,minuto INTERVAL) RETURNS VOID LANGUAGE PLPGSQL AS
$$
BEGIN
    INSERT INTO goles(partido_id, jugador_id, club_id,tiempo) VALUES(
        (SELECT id FROM partidos WHERE nombre_partido ILIKE CONCAT('%',team1,'%',team2)),

        (SELECT  id FROM jugadores WHERE jugador ILIKE CONCAT('%',futbolista) AND club_id = (
            SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',e_anota)
        ) ),
        (SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',e_anota)), minuto
    );

END
$$
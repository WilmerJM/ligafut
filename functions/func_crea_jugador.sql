CREATE OR REPLACE FUNCTION crea_jugador(nombre_club text, nombre_j text) RETURNS VOID LANGUAGE PLPGSQL AS
$FUNC$
BEGIN
    INSERT INTO jugadores(jugador, club_id) VALUES
    (nombre_j, (SELECT id FROM clubes WHERE nombre ILIKE CONCAT('%',nombre_club)));
END;
$FUNC$
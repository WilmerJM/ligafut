CREATE VIEW plantillas AS
SELECT c.nombre AS Club, j.jugador  AS Jugador FROM clubes AS c
INNER JOIN jugadores AS j
ON c.id = j.club_id;
CREATE OR REPLACE VIEW clasificacion AS

SELECT DENSE_RANK() OVER(ORDER BY cl.puntos DESC, cl.goles_favor DESC, cl.diferencia_goles DESC, cl.goles_contra, c.nombre) AS POSICION ,c.nombre AS EQUIPO, cl.puntos AS PUNTOS, cl.partidos_jugados AS PJ, cl.partidos_ganados AS PG,
cl.partidos_empatados AS PE, cl.partidos_perdidos AS PP, cl.goles_favor AS GF, cl.goles_contra AS GC,
cl.diferencia_goles AS DG FROM clubes AS c 

INNER JOIN clasificaciones AS cl ON c.id = cl.club_id;

--ORDER BY cl.puntos DESC, cl.goles_favor DESC, cl.diferencia_goles DESC, cl.goles_contra;



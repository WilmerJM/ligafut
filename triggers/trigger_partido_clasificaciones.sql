CREATE TRIGGER t_partido_clasificacion
AFTER INSERT
ON partidos_clubes
FOR EACH ROW
EXECUTE PROCEDURE crea_partido_tfunc();
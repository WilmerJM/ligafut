CREATE TRIGGER t_puntaje
AFTER UPDATE
ON resultados
FOR EACH ROW
EXECUTE PROCEDURE clasificacion_tfunc();
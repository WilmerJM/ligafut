CREATE TRIGGER favor_contra_trigger
AFTER INSERT
ON goles
FOR EACH ROW
EXECUTE PROCEDURE goles_fc_tfunc();
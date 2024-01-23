DO
$$
 DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT id FROM clubes LOOP
    INSERT INTO clasificaciones(club_id, temporada_id) VALUES(rec.id,1);
    END LOOP;
END;
$$
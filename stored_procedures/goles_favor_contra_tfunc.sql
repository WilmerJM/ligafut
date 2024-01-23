CREATE OR REPLACE FUNCTION goles_fc_tfunc() RETURNS TRIGGER LANGUAGE PLPGSQL AS
$$
BEGIN

    UPDATE clasificaciones SET goles_favor = goles_favor + 1 WHERE club_id = NEW.club_id;
    UPDATE clasificaciones SET goles_contra = goles_contra + 1 WHERE club_id = (

        SELECT club_id FROM partidos_clubes WHERE partido_id = NEW.partido_id AND club_id != NEW.club_id
    );

    RETURN NEW;
END
$$
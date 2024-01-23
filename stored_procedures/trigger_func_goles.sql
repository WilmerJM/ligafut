CREATE FUNCTION gol_trigger() RETURNS TRIGGER LANGUAGE PLPGSQL AS 
$$
DECLARE
    goles_team1 INTEGER:= 0;
    goles_team2 INTEGER:= 0;
    rec RECORD;
    rec2 RECORD;
BEGIN


    FOR rec IN SELECT * FROM goles WHERE partido_id = NEW.partido_id AND club_id != NEW.club_id LOOP
    goles_team1 = goles_team1+1;
    END LOOP;

    FOR rec2 IN SELECT * FROM goles WHERE partido_id = NEW.partido_id AND club_id = NEW.club_id LOOP
    goles_team2 = goles_team2+1;
    END LOOP;

    IF goles_team2 > goles_team1  THEN
    UPDATE resultados SET resultado = 'v' WHERE partido_id = NEW.partido_id AND club_id = NEW.club_id;
    UPDATE resultados SET resultado = 'd' WHERE partido_id = NEW.partido_id AND club_id != NEW.club_id;
    RETURN NEW;

    ELSEIF goles_team2 < goles_team1 THEN
    UPDATE resultados SET resultado = 'd' WHERE partido_id = NEW.partido_id AND club_id = NEW.club_id;
    UPDATE resultados SET resultado = 'v' WHERE partido_id = NEW.partido_id AND club_id != NEW.club_id;
    RETURN NEW;

    ELSE
    UPDATE resultados SET resultado = 'e' WHERE partido_id = NEW.partido_id;
    RETURN NEW;
    END IF;
END
$$

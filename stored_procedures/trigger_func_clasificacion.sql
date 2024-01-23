CREATE OR REPLACE FUNCTION clasificacion_tfunc() RETURNS TRIGGER LANGUAGE PLPGSQL AS
$$
BEGIN

    IF OLD.resultado = NEW.resultado THEN RETURN NEW;

    ELSEIF OLD.resultado = 'e' AND NEW.resultado = 'v' THEN
    UPDATE clasificaciones SET puntos = puntos + 2, partidos_ganados = partidos_ganados + 1,
    partidos_empatados = partidos_empatados - 1 WHERE club_id = NEW.club_id;
    RETURN NEW;

    ELSEIF OLD.resultado = 'v' AND NEW.resultado = 'e' THEN
    UPDATE clasificaciones SET puntos = puntos - 2, partidos_ganados = partidos_ganados -1,
    partidos_empatados = partidos_empatados + 1 WHERE club_id = NEW.club_id;
    RETURN NEW;

    ELSEIF OLD.resultado = 'e' AND NEW.resultado = 'd' THEN
    UPDATE clasificaciones SET puntos = puntos - 1, partidos_empatados = partidos_empatados - 1,
    partidos_perdidos = partidos_perdidos + 1 WHERE club_id = NEW.club_id;
    RETURN NEW;

    ELSE
    UPDATE clasificaciones SET puntos = puntos + 1, partidos_empatados = partidos_empatados + 1,
    partidos_perdidos = partidos_perdidos - 1 WHERE club_id = NEW.club_id;
    RETURN NEW;
    END IF;
END
$$
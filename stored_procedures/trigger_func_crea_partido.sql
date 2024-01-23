CREATE OR REPLACE FUNCTION crea_partido_tfunc() RETURNS TRIGGER LANGUAGE PLPGSQL AS
$$
BEGIN

        UPDATE clasificaciones SET puntos = puntos + 1, partidos_jugados = partidos_jugados +1,
        partidos_empatados = partidos_empatados + 1
        WHERE club_id = NEW.club_id;
        RETURN NEW;
END
$$
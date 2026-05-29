-- PREPARE / Consulta parametrizada - Sistema Apícola - Equipo 02
-- $1 tipo_sensor (TEXT), $2 estado_colmena (TEXT), $3 min_promedio (NUMERIC)

PREPARE consulta_sensores_por_apiario (TEXT, TEXT, NUMERIC) AS
    SELECT a.id_apiario, a.ubicacion AS apiario,
           c.id_colmena, c.estado,
           s.id_sensor, s.tipo,
           COUNT(ds.id_dato) AS lecturas,
           AVG(ds.valor)     AS promedio,
           MAX(ds.valor)     AS max,
           MIN(ds.valor)     AS min
    FROM apiarios a
    INNER JOIN colmenas c      ON c.id_apiario = a.id_apiario
    INNER JOIN sensores_iot s  ON s.id_colmena = c.id_colmena
    INNER JOIN datos_sensor ds ON ds.id_sensor = s.id_sensor
    WHERE s.tipo   = $1
      AND c.estado = $2
    GROUP BY a.id_apiario, a.ubicacion, c.id_colmena, c.estado, s.id_sensor, s.tipo
    HAVING AVG(ds.valor) >= $3
    ORDER BY promedio DESC;

EXECUTE consulta_sensores_por_apiario('temperatura', 'Activa', 20.0);
EXECUTE consulta_sensores_por_apiario('humedad', 'Activa', 50.0);
EXECUTE consulta_sensores_por_apiario('peso', 'En revisión', 10.0);

DEALLOCATE consulta_sensores_por_apiario;

-- Scripts de CONSULTA CON PARÁMETROS (PREPARE) - Sistema Apícola - Equipo 02

-- Parámetros:
--   $1 -> tipo_sensor    (TEXT)    ej: 'temperatura'
--   $2 -> estado_colmena (TEXT)    ej: 'Activa'
--   $3 -> min_promedio   (NUMERIC) ej: 20.0

PREPARE consulta_sensores_por_apiario (TEXT, TEXT, NUMERIC) AS
    SELECT a.id_apiario, a.ubicacion AS apiario,
           c.id_colmena, c.estado AS estado_colmena,
           s.id_sensor, s.tipo AS tipo_sensor,
           COUNT(ds.id_dato) AS total_lecturas,
           AVG(ds.valor)     AS promedio_valor,
           MAX(ds.valor)     AS valor_max,
           MIN(ds.valor)     AS valor_min
    FROM apiarios a
    INNER JOIN colmenas c      ON c.id_apiario = a.id_apiario
    INNER JOIN sensores_iot s  ON s.id_colmena = c.id_colmena
    INNER JOIN datos_sensor ds ON ds.id_sensor = s.id_sensor
    WHERE s.tipo   = $1
      AND c.estado = $2
    GROUP BY a.id_apiario, a.ubicacion,
             c.id_colmena, c.estado,
             s.id_sensor, s.tipo
    HAVING AVG(ds.valor) >= $3
    ORDER BY promedio_valor DESC;

-- Ejecuciones de prueba
EXECUTE consulta_sensores_por_apiario('temperatura', 'Activa', 20.0);
EXECUTE consulta_sensores_por_apiario('humedad', 'Activa', 50.0);
EXECUTE consulta_sensores_por_apiario('peso', 'En revisión', 10.0);

DEALLOCATE consulta_sensores_por_apiario;

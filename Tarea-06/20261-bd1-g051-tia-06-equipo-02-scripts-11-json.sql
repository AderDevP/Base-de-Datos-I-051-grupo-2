-- JSON/JSONB - Sistema Apícola - Equipo 02

ALTER TABLE datos_sensor ADD COLUMN IF NOT EXISTS datos_ambientales JSONB;
ALTER TABLE productos    ADD COLUMN IF NOT EXISTS caracteristicas    JSONB;

-- INSERT lecturas IoT
INSERT INTO datos_sensor (id_sensor, valor, fecha, datos_ambientales) VALUES
(1, 34.5, NOW(),
 '{"temperatura": 34.5, "humedad": 72, "presion": 1012, "coordenadas": {"latitud": 6.2442, "longitud": -75.5812, "altitud_m": 1495}, "bateria_pct": 88, "estado": "normal"}'::JSONB),
(1, 41.8, NOW() - INTERVAL '1 hour',
 '{"temperatura": 41.8, "humedad": 65, "presion": 1008, "bateria_pct": 54, "estado": "alerta_temperatura"}'::JSONB),
(2, 33.1, NOW() - INTERVAL '2 hours',
 '{"temperatura": 33.1, "humedad": 79, "presion": 1015, "bateria_pct": 12, "estado": "bateria_baja"}'::JSONB);

-- INSERT características de productos
INSERT INTO productos (nombre, precio, caracteristicas) VALUES
('Miel orgánica', 20000, '{"color": "ambar", "peso": "500g", "origen": "natural", "vida_util_dias": 730}'::JSONB),
('Propóleo', 15000, '{"presentacion": "gotas", "uso": "medicinal", "volumen_ml": 30}'::JSONB);

-- SELECT completo
SELECT id_dato, id_sensor, valor, fecha, datos_ambientales
FROM datos_sensor WHERE datos_ambientales IS NOT NULL ORDER BY fecha DESC;

-- SELECT extrayendo campos con ->>
SELECT id_dato, id_sensor, fecha,
       datos_ambientales->>'temperatura' AS temperatura_c,
       datos_ambientales->>'humedad'     AS humedad_pct,
       datos_ambientales->>'bateria_pct' AS bateria,
       datos_ambientales->>'estado'      AS estado
FROM datos_sensor WHERE datos_ambientales IS NOT NULL ORDER BY fecha DESC;

-- SELECT coordenadas GPS (objeto anidado)
SELECT id_dato, id_sensor,
       datos_ambientales->'coordenadas'->>'latitud'   AS latitud,
       datos_ambientales->'coordenadas'->>'longitud'  AS longitud,
       datos_ambientales->'coordenadas'->>'altitud_m' AS altitud_m
FROM datos_sensor WHERE datos_ambientales ? 'coordenadas';

-- SELECT temperatura > 40°C
SELECT id_dato, id_sensor,
       (datos_ambientales->>'temperatura')::NUMERIC AS temperatura_c,
       datos_ambientales->>'estado' AS estado
FROM datos_sensor
WHERE datos_ambientales IS NOT NULL
  AND (datos_ambientales->>'temperatura')::NUMERIC > 40;

-- SELECT características de productos
SELECT id_producto, nombre, precio,
       caracteristicas->>'color'        AS color,
       caracteristicas->>'presentacion' AS presentacion
FROM productos WHERE caracteristicas IS NOT NULL;

-- UPDATE con || (merge JSONB)
UPDATE datos_sensor
SET datos_ambientales = datos_ambientales || '{"bateria_pct": 95, "estado": "normal"}'::JSONB
WHERE id_sensor = 2 AND datos_ambientales IS NOT NULL;

UPDATE productos
SET caracteristicas = caracteristicas || '{"certificacion": "organico-premium"}'::JSONB
WHERE nombre = 'Miel orgánica' AND caracteristicas IS NOT NULL;

-- SELECT verificación final
SELECT id_dato, id_sensor,
       datos_ambientales->>'bateria_pct' AS bateria,
       datos_ambientales->>'estado'      AS estado
FROM datos_sensor WHERE datos_ambientales IS NOT NULL ORDER BY id_sensor;

SELECT id_producto, nombre, caracteristicas->>'certificacion' AS certificacion
FROM productos WHERE caracteristicas IS NOT NULL;

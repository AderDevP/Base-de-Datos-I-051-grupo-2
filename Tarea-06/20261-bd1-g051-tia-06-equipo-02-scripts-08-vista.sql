-- Scripts de VISTAS (VIEW) - Sistema Apícola - Equipo 02

DROP VIEW IF EXISTS vista_resumen_pedidos_por_usuario;
DROP VIEW IF EXISTS vista_sensores_activos_por_apiario;

-- Vista #1: Resumen de pedidos por usuario (3 JOIN, WHERE, HAVING, SUM/AVG/MAX/MIN)
CREATE VIEW vista_resumen_pedidos_por_usuario AS
SELECT u.id_usuario, u.nombre AS usuario,
       r.nombre AS rol,
       COUNT(DISTINCT p.id_pedido)      AS total_pedidos,
       SUM(dp.cantidad)                 AS total_unidades,
       SUM(dp.cantidad * pr.precio)     AS total_cop,
       AVG(pr.precio)                   AS precio_promedio,
       MAX(pr.precio)                   AS precio_max,
       MIN(pr.precio)                   AS precio_min
FROM usuarios u
INNER JOIN roles r           ON r.id_rol       = u.id_rol
INNER JOIN pedidos p         ON p.id_usuario   = u.id_usuario
INNER JOIN detalle_pedido dp ON dp.id_pedido   = p.id_pedido
INNER JOIN productos pr      ON pr.id_producto = dp.id_producto
WHERE p.fecha >= '2024-01-01'
GROUP BY u.id_usuario, u.nombre, r.nombre
HAVING SUM(dp.cantidad * pr.precio) > 10000
ORDER BY total_cop DESC;

-- Vista #2: Sensores por apiario con lecturas del último año (3 JOIN, WHERE, HAVING, COUNT/AVG)
CREATE VIEW vista_sensores_activos_por_apiario AS
SELECT a.id_apiario, a.ubicacion AS apiario,
       s.tipo AS tipo_sensor,
       COUNT(s.id_sensor)  AS total_sensores,
       COUNT(ds.id_dato)   AS total_lecturas,
       AVG(ds.valor)       AS promedio_valor,
       MAX(ds.valor)       AS valor_max,
       MIN(ds.valor)       AS valor_min
FROM apiarios a
INNER JOIN colmenas c     ON c.id_apiario = a.id_apiario
INNER JOIN sensores_iot s ON s.id_colmena = c.id_colmena
INNER JOIN datos_sensor ds ON ds.id_sensor = s.id_sensor
WHERE ds.fecha >= NOW() - INTERVAL '1 year'
GROUP BY a.id_apiario, a.ubicacion, s.tipo
HAVING COUNT(s.id_sensor) > 1
ORDER BY a.ubicacion ASC, s.tipo ASC;

-- Consultar las vistas
SELECT * FROM vista_resumen_pedidos_por_usuario;
SELECT * FROM vista_sensores_activos_por_apiario;

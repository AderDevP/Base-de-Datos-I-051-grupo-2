-- Scripts de GROUP BY y HAVING - Sistema Apícola - Equipo 02

-- Consulta #1: Apicultores por apiario
SELECT a.id_apiario, a.ubicacion AS apiario,
       COUNT(ua.id_usuario) AS total_apicultores
FROM apiarios a
INNER JOIN usuarios_apiarios ua ON ua.id_apiario = a.id_apiario
INNER JOIN usuarios u           ON u.id_usuario  = ua.id_usuario
GROUP BY a.id_apiario, a.ubicacion
ORDER BY a.ubicacion ASC;

-- Consulta #2: Pedidos agrupados por producto
SELECT pr.id_producto, pr.nombre AS producto,
       COUNT(dp.id_detalle)          AS total_pedidos,
       SUM(dp.cantidad)              AS unidades_pedidas,
       SUM(dp.cantidad * pr.precio)  AS valor_total_cop
FROM productos pr
INNER JOIN detalle_pedido dp ON dp.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY total_pedidos DESC;

-- Consulta #3: Sensores por apiario y tipo
SELECT a.id_apiario, a.ubicacion AS apiario,
       s.tipo AS tipo_sensor,
       COUNT(s.id_sensor) AS total_sensores
FROM apiarios a
INNER JOIN colmenas c     ON c.id_apiario = a.id_apiario
INNER JOIN sensores_iot s ON s.id_colmena = c.id_colmena
GROUP BY a.id_apiario, a.ubicacion, s.tipo
ORDER BY a.ubicacion ASC, s.tipo ASC;

-- Consulta #4: Pedidos por usuario con total COP (HAVING > 50000)
SELECT u.id_usuario, u.nombre AS usuario,
       COUNT(DISTINCT p.id_pedido)       AS total_pedidos,
       SUM(dp.cantidad * pr.precio)      AS total_cop
FROM usuarios u
INNER JOIN pedidos p          ON p.id_usuario  = u.id_usuario
INNER JOIN detalle_pedido dp  ON dp.id_pedido  = p.id_pedido
INNER JOIN productos pr       ON pr.id_producto = dp.id_producto
GROUP BY u.id_usuario, u.nombre
HAVING SUM(dp.cantidad * pr.precio) > 50000
ORDER BY total_cop DESC;

-- Consulta #5: Productos pedidos de mayor a menor
SELECT pr.id_producto, pr.nombre AS producto,
       pr.precio AS precio_unitario,
       COUNT(dp.id_detalle)         AS total_veces_pedido,
       SUM(dp.cantidad)             AS total_unidades,
       SUM(dp.cantidad * pr.precio) AS total_cop
FROM productos pr
INNER JOIN detalle_pedido dp ON dp.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre, pr.precio
ORDER BY total_veces_pedido DESC;

-- ¿Producto con menos pedidos?
SELECT pr.nombre AS producto, COUNT(dp.id_detalle) AS total_pedidos
FROM productos pr
INNER JOIN detalle_pedido dp ON dp.id_producto = pr.id_producto
GROUP BY pr.id_producto, pr.nombre
ORDER BY total_pedidos ASC
LIMIT 1;

-- ¿Usuario con mayor monto total en pedidos (COP)?
SELECT u.nombre AS usuario, SUM(dp.cantidad * pr.precio) AS total_cop
FROM usuarios u
INNER JOIN pedidos p         ON p.id_usuario   = u.id_usuario
INNER JOIN detalle_pedido dp ON dp.id_pedido   = p.id_pedido
INNER JOIN productos pr      ON pr.id_producto = dp.id_producto
GROUP BY u.id_usuario, u.nombre
ORDER BY total_cop DESC
LIMIT 1;

-- ¿Usuario con más pedidos recibidos?
SELECT u.id_usuario, u.nombre AS usuario,
       COUNT(DISTINCT p.id_pedido) AS total_pedidos
FROM usuarios u
INNER JOIN pedidos p         ON p.id_usuario   = u.id_usuario
INNER JOIN detalle_pedido dp ON dp.id_pedido   = p.id_pedido
GROUP BY u.id_usuario, u.nombre
ORDER BY total_pedidos DESC
LIMIT 1;

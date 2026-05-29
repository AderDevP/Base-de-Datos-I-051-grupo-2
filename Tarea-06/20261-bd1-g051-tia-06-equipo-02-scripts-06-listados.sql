-- SELECT / Listados - Sistema Apícola - Equipo 02

-- #1 Apiarios en orden alfabético
SELECT id_apiario, ubicacion FROM apiarios ORDER BY ubicacion ASC;

-- #2 Usuarios con su rol (1 JOIN)
SELECT u.id_usuario, u.nombre AS usuario, u.correo, r.nombre AS rol
FROM usuarios u
INNER JOIN roles r ON u.id_rol = r.id_rol
ORDER BY r.nombre ASC, u.nombre ASC;

-- #3 Apiarios con colmenas y responsable (2 JOIN)
SELECT a.id_apiario, a.ubicacion AS apiario,
       c.id_colmena, c.estado,
       u.nombre AS responsable
FROM apiarios a
INNER JOIN colmenas c          ON c.id_apiario  = a.id_apiario
INNER JOIN usuarios_apiarios ua ON ua.id_apiario = a.id_apiario
INNER JOIN usuarios u          ON u.id_usuario  = ua.id_usuario
ORDER BY a.ubicacion ASC, c.id_colmena ASC;

-- #4 Apicultores, apiarios y sensores (3 JOIN)
SELECT u.nombre AS apicultor, a.ubicacion AS apiario,
       c.id_colmena, c.estado, s.tipo AS sensor
FROM usuarios u
INNER JOIN usuarios_apiarios ua ON ua.id_usuario = u.id_usuario
INNER JOIN apiarios a           ON a.id_apiario  = ua.id_apiario
INNER JOIN colmenas c           ON c.id_apiario  = a.id_apiario
INNER JOIN sensores_iot s       ON s.id_colmena  = c.id_colmena
ORDER BY u.nombre ASC, a.ubicacion ASC;

-- #5 Pedidos con usuario, producto y subtotal (3 JOIN)
SELECT p.id_pedido, p.fecha, u.nombre AS usuario,
       pr.nombre AS producto, dp.cantidad,
       pr.precio, (dp.cantidad * pr.precio) AS subtotal
FROM pedidos p
INNER JOIN usuarios u        ON u.id_usuario   = p.id_usuario
INNER JOIN detalle_pedido dp ON dp.id_pedido   = p.id_pedido
INNER JOIN productos pr      ON pr.id_producto = dp.id_producto
ORDER BY p.fecha DESC;

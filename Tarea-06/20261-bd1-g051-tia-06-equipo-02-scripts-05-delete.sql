-- Scripts de ELIMINACIÓN (DELETE) - Sistema Apícola - Equipo 02

-- ============================================================
-- Escenario #1: Insertar un producto y eliminarlo
-- (se ingresó por error, no se comercializará todavía)
-- ============================================================
INSERT INTO productos (nombre, precio)
VALUES ('Polen en cápsula - PRUEBA', 8500.00);

DELETE FROM productos
WHERE nombre = 'Polen en cápsula - PRUEBA';

-- ============================================================
-- Escenario #2: Insertar un apicultor y eliminarlo
-- (se registró por error, ya no participará en la red)
-- ============================================================
INSERT INTO usuarios (nombre, correo, id_rol)
VALUES ('Carlos Prueba', 'carlos.prueba@apicola.com', 1);

DELETE FROM usuarios
WHERE correo = 'carlos.prueba@apicola.com';

-- ============================================================
-- Otros DELETE específicos sobre el modelo real
-- ============================================================

-- Eliminar un usuario por ID (primero borrar sus pedidos si los tiene)
DELETE FROM detalle_pedido
WHERE id_pedido IN (SELECT id_pedido FROM pedidos WHERE id_usuario = 5);
DELETE FROM pedidos   WHERE id_usuario = 5;
DELETE FROM usuarios  WHERE id_usuario = 5;

-- Eliminar una colmena (primero sus sensores y datos)
DELETE FROM datos_sensor
WHERE id_sensor IN (SELECT id_sensor FROM sensores_iot WHERE id_colmena = 3);
DELETE FROM sensores_iot WHERE id_colmena = 3;
DELETE FROM colmenas     WHERE id_colmena = 3;

-- Eliminar inspecciones antiguas (columna correcta: fecha)
DELETE FROM inspecciones
WHERE fecha < '2024-01-01';

-- Eliminar sensores por tipo (columna correcta: tipo)
DELETE FROM sensores_iot
WHERE tipo = 'obsoleto';

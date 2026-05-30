-- UPDATE - Sistema Apícola - Equipo 02

-- Tres actualizaciones de dirección de mercados
UPDATE mercados SET direccion = 'Cra 45 # 30-50 Local 12' WHERE municipio = 'Medellín';
UPDATE mercados SET direccion = 'Calle 50 # 51-30 Plaza Central' WHERE municipio = 'Guarne';
UPDATE mercados SET direccion = 'Cra 31 # 30-15 Galería Municipal' WHERE municipio = 'El Carmen de Viboral';

-- Tres actualizaciones de precio de productos
UPDATE productos SET precio = 19500.00 WHERE nombre = 'Miel de abejas natural 500g';
UPDATE productos SET precio = 16000.00 WHERE nombre = 'Propóleo en gotas 30ml';
UPDATE productos SET precio = 37000.00 WHERE nombre = 'Jalea real 50g';

-- Verificación
SELECT id_mercado, nombre, direccion, municipio FROM mercados ORDER BY municipio;
SELECT id_producto, nombre, precio FROM productos ORDER BY id_producto;

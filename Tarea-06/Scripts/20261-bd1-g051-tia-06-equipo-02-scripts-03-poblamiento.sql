-- INSERT / Poblamiento - Sistema Apícola - Equipo 02

-- Roles
INSERT INTO roles (nombre) VALUES
('Apicultor'),
('Consumidor'),
('Administrador');

-- Entidades regulatorias
INSERT INTO entidades_regulatorias (nombre) VALUES
('ICA - Instituto Colombiano Agropecuario'),
('INVIMA'),
('Secretaría de Agricultura Antioquia');

-- Certificaciones
INSERT INTO certificaciones (nombre) VALUES
('Orgánico Certificado'),
('Buenas Prácticas Apícolas'),
('Libre de Antibióticos');

-- Apiarios
INSERT INTO apiarios (ubicacion) VALUES
('Vereda El Retiro - Medellín'),
('Corregimiento San Cristóbal - Medellín'),
('Municipio de Guarne'),
('Municipio de El Carmen de Viboral');

-- Mercados (un solo mercado por municipio)
INSERT INTO mercados (nombre, direccion, municipio) VALUES
('Mercado Apícola Medellín',     'Cra 45 # 30-12',  'Medellín'),
('Mercado Campesino Guarne',     'Calle 50 # 51-20', 'Guarne'),
('Plaza El Carmen',              'Cra 31 # 30-05',  'El Carmen de Viboral'),
('Mercado Verde Rionegro',       'Av Galán # 40-10', 'Rionegro');

-- Productos (Anexo C)
INSERT INTO productos (nombre, precio, caracteristicas) VALUES
('Miel de abejas natural 500g', 18000.00, '{"color": "ambar", "peso": "500g", "origen": "natural"}'),
('Propóleo en gotas 30ml',      15000.00, '{"presentacion": "gotas", "uso": "medicinal", "volumen_ml": 30}'),
('Cera de abeja 250g',          12000.00, '{"color": "amarillo", "peso": "250g", "pureza_pct": 98}'),
('Polen fresco 200g',           22000.00, '{"peso": "200g", "conservacion": "refrigerado"}'),
('Jalea real 50g',              35000.00, '{"peso": "50g", "uso": "suplemento"}');

-- Lotes de producción
INSERT INTO lotes_produccion (fecha, cantidad) VALUES
('2025-03-01', 120),
('2025-04-15', 95),
('2025-05-10', 140),
('2025-06-01', 80);

-- Usuarios (apicultores, consumidores, admin)
INSERT INTO usuarios (nombre, correo, id_rol) VALUES
('Carlos Mendoza', 'carlos.mendoza@apicola.com',   1),
('Laura Ríos',     'laura.rios@apicola.com',        1),
('Pedro Gómez',    'pedro.gomez@apicola.com',       1),
('Ana Martínez',   'ana.martinez@consumidor.com',   2),
('Jorge Herrera',  'jorge.herrera@consumidor.com',  2),
('Sofía Castillo', 'sofia.castillo@consumidor.com', 2),
('Admin Sistema',  'admin@apicola.com',             3);

-- Productos que elabora y vende cada apicultor
INSERT INTO apicultor_producto (id_usuario, id_producto) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 1),
(3, 5);

-- Colmenas
INSERT INTO colmenas (id_apiario, estado) VALUES
(1, 'Activa'),
(1, 'Activa'),
(1, 'En revisión'),
(2, 'Activa'),
(2, 'Activa'),
(3, 'Activa'),
(3, 'Inactiva'),
(4, 'Activa');

-- Sensores IoT
INSERT INTO sensores_iot (id_colmena, tipo) VALUES
(1, 'temperatura'),
(1, 'humedad'),
(2, 'temperatura'),
(3, 'peso'),
(4, 'temperatura'),
(6, 'peso'),
(8, 'temperatura');

-- Datos de sensores con JSONB
INSERT INTO datos_sensor (id_sensor, valor, fecha, datos_ambientales) VALUES
(1, 34.5, '2026-05-20 08:00:00', '{"temperatura": 34.5, "humedad": 72, "bateria_pct": 88, "estado": "normal"}'),
(1, 36.1, '2026-05-21 08:00:00', '{"temperatura": 36.1, "humedad": 70, "bateria_pct": 85, "estado": "normal"}'),
(2, 68.0, '2026-05-20 08:05:00', '{"humedad": 68, "bateria_pct": 90, "estado": "normal"}'),
(3, 41.8, '2026-05-20 09:00:00', '{"temperatura": 41.8, "humedad": 65, "bateria_pct": 54, "estado": "alerta_temperatura"}'),
(4, 18.7, '2026-05-20 10:00:00', '{"peso_kg": 18.7, "bateria_pct": 76, "estado": "normal"}'),
(5, 33.2, '2026-05-21 08:00:00', '{"temperatura": 33.2, "humedad": 74, "bateria_pct": 92, "estado": "normal"}'),
(6, 71.5, '2026-05-21 08:05:00', '{"peso_kg": 71.5, "bateria_pct": 88, "estado": "normal"}'),
(7, 35.0, '2026-05-22 08:00:00', '{"temperatura": 35.0, "humedad": 69, "bateria_pct": 12, "estado": "bateria_baja"}');

-- Pedidos (cabecera: consumidor + mercado + fecha)
INSERT INTO pedidos (id_usuario, id_mercado, fecha) VALUES
(4, 1, '2026-04-10'),
(5, 1, '2026-04-15'),
(6, 2, '2026-04-20'),
(4, 3, '2026-05-05'),
(5, 1, '2026-05-12'),
(6, 2, '2026-05-18');

-- Detalle de pedidos
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES
(1, 1, 3),
(1, 3, 2),
(2, 2, 1),
(2, 4, 2),
(3, 1, 5),
(3, 5, 1),
(4, 1, 2),
(4, 2, 3),
(5, 3, 4),
(5, 4, 1),
(6, 1, 6),
(6, 5, 2);

-- Inspecciones
INSERT INTO inspecciones (id_apiario, id_entidad, fecha) VALUES
(1, 1, '2025-09-10'),
(2, 2, '2025-10-05'),
(3, 1, '2025-11-20'),
(4, 3, '2026-01-15'),
(1, 3, '2026-03-08');

-- Usuarios - Apiarios (M:N)
INSERT INTO usuarios_apiarios (id_usuario, id_apiario) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(3, 2);

-- Apiarios - Certificaciones (M:N)
INSERT INTO apiarios_certificaciones (id_apiario, id_certificacion) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(4, 2);

-- Productos - Lotes (M:N)
INSERT INTO productos_lotes (id_producto, id_lote) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 1),
(4, 4),
(5, 2);

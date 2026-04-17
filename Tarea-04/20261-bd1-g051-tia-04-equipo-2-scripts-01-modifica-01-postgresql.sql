--
-- Scripts de Modificación de la Base de Datos - SGBD PostgreSQL
-- Todas las instrucciones en secuencia
--.


-- =====================================================
-- 1.1 Agregar un campo a la tabla productor (usuario)
-- =====================================================


ALTER TABLE usuario
ADD COLUMN telefono VARCHAR(20);


-- =====================================================
-- 1.2 Modificar un campo de la tabla productor
-- =====================================================


ALTER TABLE usuario
ALTER COLUMN telefono TYPE VARCHAR(30);


-- =====================================================
-- 1.3.1 Crear una tabla nueva coherente con el sistema
-- =====================================================


CREATE TABLE proveedor (
    id_proveedor SERIAL
);


-- =====================================================
-- 1.3.2 Agregar clave primaria y otros 3 campos
-- =====================================================


ALTER TABLE proveedor
ADD PRIMARY KEY (id_proveedor);


ALTER TABLE proveedor
ADD COLUMN nombre VARCHAR(80);


ALTER TABLE proveedor
ADD COLUMN direccion VARCHAR(120);


ALTER TABLE proveedor
ADD COLUMN cantidad_productos INT;


-- =====================================================
-- 1.3.3 Quitar uno de los campos
-- =====================================================


ALTER TABLE proveedor
DROP COLUMN direccion;


-- =====================================================
-- 1.3.4 Cambiar nombre de la tabla
-- =====================================================


ALTER TABLE proveedor
RENAME TO suministrador;


-- =====================================================
-- 1.3.5 Agregar un campo único
-- =====================================================


ALTER TABLE suministrador
ADD COLUMN correo VARCHAR(100) UNIQUE;


-- =====================================================
-- 1.3.6 Agregar fechas inicio y fin con control
-- =====================================================


ALTER TABLE suministrador
ADD COLUMN fecha_inicio DATE;


ALTER TABLE suministrador
ADD COLUMN fecha_fin DATE;


ALTER TABLE suministrador
ADD CONSTRAINT chk_fechas
CHECK (fecha_fin >= fecha_inicio);


-- =====================================================
-- 1.3.7 Agregar campo entero no negativo
-- =====================================================


ALTER TABLE suministrador
ADD COLUMN stock INT CHECK (stock >= 0);


-- =====================================================
-- 1.3.8 Modificar tamaño de campo texto
-- =====================================================


ALTER TABLE suministrador
ALTER COLUMN nombre TYPE VARCHAR(150);


-- =====================================================
-- 1.3.7 Modificar campo numérico con rango
-- =====================================================


ALTER TABLE suministrador
ADD CONSTRAINT chk_cantidad
CHECK (cantidad_productos BETWEEN 0 AND 10000);


-- =====================================================
-- 1.3.8 Agregar índice
-- =====================================================


CREATE INDEX idx_nombre_suministrador
ON suministrador(nombre);


-- =====================================================
-- 1.3.9 Eliminar una fecha
-- =====================================================


ALTER TABLE suministrador
DROP COLUMN fecha_fin;


-- =====================================================
-- 1.3.10 Borrar todos los datos sin dejar traza
-- =====================================================


TRUNCATE TABLE suministrador;

-- Scripts de VALIDACIÓN PROPIEDADES ACID - Sistema Apícola - Equipo 02

-- ============================================================
-- A) ATOMICIDAD - BEGIN / ROLLBACK
-- Ejecutar SELECT antes y después en pestaña separada del Query Tool
-- ============================================================

-- SELECT ANTES
SELECT id_colmena, estado FROM colmenas WHERE id_colmena = 1;
SELECT id_producto, nombre, precio FROM productos WHERE id_producto = 1;

BEGIN;
    UPDATE colmenas SET estado = 'En mantenimiento - ROLLBACK TEST' WHERE id_colmena = 1;
    UPDATE productos SET precio = 99999.99 WHERE id_producto = 1;
ROLLBACK;

-- SELECT DESPUÉS (debe ser idéntico al ANTES)
SELECT id_colmena, estado FROM colmenas WHERE id_colmena = 1;
SELECT id_producto, nombre, precio FROM productos WHERE id_producto = 1;


-- ============================================================
-- B) CONSISTENCIA - Operaciones que violan restricciones
-- ============================================================

-- B.1) PK duplicada → ERROR: duplicate key value violates unique constraint
INSERT INTO usuarios (id_usuario, nombre, correo, id_rol)
VALUES (1, 'Usuario Duplicado', 'duplicado@test.com', 1);

-- B.2) UNIQUE duplicado en correo → ERROR: duplicate key value
INSERT INTO usuarios (nombre, correo, id_rol)
VALUES ('Nuevo Usuario', 'correo_existente@test.com', 1);

-- B.3) FK activa: borrar apiario con colmenas asociadas → ERROR: foreign key constraint
DELETE FROM apiarios WHERE id_apiario = 1;


-- ============================================================
-- C) AISLAMIENTO - Caso hipotético (no requiere ejecución)
-- ============================================================
-- Sesión A actualiza precio del producto 1 sin hacer COMMIT.
-- Sesión B lee ese producto concurrentemente.
-- Con READ COMMITTED (default PostgreSQL): Sesión B NO ve el cambio
-- hasta que Sesión A haga COMMIT → se evitan lecturas sucias.
--
-- Sesión A:  BEGIN; UPDATE productos SET precio=50000 WHERE id_producto=1;
-- Sesión B:  BEGIN; SELECT precio FROM productos WHERE id_producto=1; COMMIT;
-- Sesión A:  COMMIT;


-- ============================================================
-- D) DURABILIDAD - BEGIN / COMMIT
-- Ejecutar SELECT antes y después en pestaña separada del Query Tool
-- ============================================================

-- SELECT ANTES
SELECT id_colmena, estado FROM colmenas WHERE id_colmena = 2;

BEGIN;
    UPDATE colmenas SET estado = 'Activa - Verificada COMMIT' WHERE id_colmena = 2;
COMMIT;

-- SELECT DESPUÉS (el cambio debe persistir de forma permanente)
SELECT id_colmena, estado FROM colmenas WHERE id_colmena = 2;

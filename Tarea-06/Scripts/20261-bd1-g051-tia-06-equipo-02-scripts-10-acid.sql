-- ACID - Sistema Apícola - Equipo 02

-- A) ATOMICIDAD - BEGIN / ROLLBACK
-- SELECT antes
SELECT id_colmena, estado FROM colmenas WHERE id_colmena = 1;
SELECT id_producto, nombre, precio FROM productos WHERE id_producto = 1;

BEGIN;
    UPDATE colmenas  SET estado = 'En mantenimiento - ROLLBACK TEST' WHERE id_colmena = 1;
    UPDATE productos SET precio = 99999.99 WHERE id_producto = 1;
ROLLBACK;

-- SELECT después (debe ser igual al antes)
SELECT id_colmena, estado FROM colmenas WHERE id_colmena = 1;
SELECT id_producto, nombre, precio FROM productos WHERE id_producto = 1;


-- B) CONSISTENCIA - operaciones que violan restricciones (deben fallar)

-- PK duplicada
INSERT INTO usuarios (id_usuario, nombre, correo, id_rol) VALUES (1, 'Duplicado', 'dup@test.com', 1);

-- UNIQUE duplicado en correo
INSERT INTO usuarios (nombre, correo, id_rol) VALUES ('Test', 'carlos.mendoza@apicola.com', 1);

-- FK activa: apiario tiene colmenas, no se puede borrar
DELETE FROM apiarios WHERE id_apiario = 1;


-- C) AISLAMIENTO - caso hipotético
-- Sesión A: BEGIN; UPDATE productos SET precio=50000 WHERE id_producto=1;
-- Sesión B: BEGIN; SELECT precio FROM productos WHERE id_producto=1; COMMIT;
-- Sesión B no ve el cambio hasta que Sesión A haga COMMIT (READ COMMITTED)
-- Sesión A: COMMIT;


-- D) DURABILIDAD - BEGIN / COMMIT
-- SELECT antes
SELECT id_colmena, estado FROM colmenas WHERE id_colmena = 2;

BEGIN;
    UPDATE colmenas SET estado = 'Activa - Verificada COMMIT' WHERE id_colmena = 2;
COMMIT;

-- SELECT después (cambio persiste permanentemente)
SELECT id_colmena, estado FROM colmenas WHERE id_colmena = 2;

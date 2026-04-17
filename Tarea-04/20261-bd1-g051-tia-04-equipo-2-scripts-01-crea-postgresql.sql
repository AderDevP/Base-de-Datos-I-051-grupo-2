-- Script de Creación de la Base de Datos - PostgreSQL

.
-- TABLAS INDEPENDIENTES
CREATE TABLE roles (
    id_rol SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE entidades_regulatorias (
    id_entidad SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);


CREATE TABLE certificaciones (
    id_certificacion SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);


CREATE TABLE apiarios (
    id_apiario SERIAL PRIMARY KEY,
    ubicacion VARCHAR(150) NOT NULL
);


CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);


CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    fecha DATE NOT NULL
);


CREATE TABLE lotes_produccion (
    id_lote SERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL
);




-- TABLAS DEPENDIENTES (1:N)




CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    id_rol INT NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);


CREATE TABLE colmenas (
    id_colmena SERIAL PRIMARY KEY,
    id_apiario INT NOT NULL,
    estado VARCHAR(50),
    FOREIGN KEY (id_apiario) REFERENCES apiarios(id_apiario)
);


CREATE TABLE sensores_iot (
    id_sensor SERIAL PRIMARY KEY,
    id_colmena INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_colmena) REFERENCES colmenas(id_colmena)
);


CREATE TABLE datos_sensor (
    id_dato SERIAL PRIMARY KEY,
    id_sensor INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    fecha TIMESTAMP NOT NULL,
    FOREIGN KEY (id_sensor) REFERENCES sensores_iot(id_sensor)
);


CREATE TABLE detalle_pedido (
    id_detalle SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


CREATE TABLE inspecciones (
    id_inspeccion SERIAL PRIMARY KEY,
    id_apiario INT NOT NULL,
    id_entidad INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_apiario) REFERENCES apiarios(id_apiario),
    FOREIGN KEY (id_entidad) REFERENCES entidades_regulatorias(id_entidad)
);




-- TABLAS M:N (INTERMEDIAS)




CREATE TABLE usuarios_apiarios (
    id_usuario INT NOT NULL,
    id_apiario INT NOT NULL,
    PRIMARY KEY (id_usuario, id_apiario),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_apiario) REFERENCES apiarios(id_apiario)
);


CREATE TABLE apiarios_certificaciones (
    id_apiario INT NOT NULL,
    id_certificacion INT NOT NULL,
    PRIMARY KEY (id_apiario, id_certificacion),
    FOREIGN KEY (id_apiario) REFERENCES apiarios(id_apiario),
    FOREIGN KEY (id_certificacion) REFERENCES certificaciones(id_certificacion)
);


CREATE TABLE productos_lotes (
    id_producto INT NOT NULL,
    id_lote INT NOT NULL,
    PRIMARY KEY (id_producto, id_lote),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_lote) REFERENCES lotes_produccion(id_lote)
);

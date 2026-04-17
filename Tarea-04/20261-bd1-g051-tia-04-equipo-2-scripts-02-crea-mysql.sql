--
-- Scripts de Creación de la Base de Datos - SGBD MySQL
--
-- 1. TABLAS INDEPENDIENTES 

-- Tabla 1: rol
CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id_rol)
);

-- Tabla 3: apiario
CREATE TABLE apiario (
    id_apiario INT AUTO_INCREMENT NOT NULL,
    ubicación VARCHAR(150) NOT NULL,
    PRIMARY KEY (id_apiario)
);

-- Tabla 7: producto 
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_producto)
);

-- Tabla 8: pedido
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (id_pedido)
);

-- Tabla 10: certificacion
CREATE TABLE certificacion (
    id_certificacion INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_certificacion)
);

-- Tabla 14: entidad_regulatoria
CREATE TABLE entidad_regulatoria (
    id_entidad INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_entidad)
);

-- Tabla 16: lote_produccion 
CREATE TABLE lote_produccion (
    id_lote INT AUTO_INCREMENT NOT NULL,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_lote)
);

-- 2. TABLAS DEPENDIENTES 

-- Tabla 2: usuario (Depende de rol)
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    id_rol INT NOT NULL,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

-- Tabla 4: colmena (Depende de apiario)
CREATE TABLE colmena (
    id_colmena INT AUTO_INCREMENT NOT NULL,
    id_apiario INT NOT NULL,
    estado VARCHAR(50) NULL,
    PRIMARY KEY (id_colmena),
    FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);

-- Tabla 9: detalle_pedido (Depende de pedido y producto)
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT NOT NULL,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_detalle),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Tabla 12: apiario_certificacion (Depende de apiario y certificacion)
CREATE TABLE apiario_certificacion (
    id_apiario INT NOT NULL,
    id_certificacion INT NOT NULL,
    PRIMARY KEY (id_apiario, id_certificacion),
    FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario),
    FOREIGN KEY (id_certificacion) REFERENCES certificacion(id_certificacion)
);

-- Tabla 13: producto_lote (Depende de producto y lote_produccion)
CREATE TABLE producto_lote (
    id_producto INT NOT NULL,
    id_lote INT NOT NULL,
    PRIMARY KEY (id_producto, id_lote),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (id_lote) REFERENCES lote_produccion(id_lote)
);

-- Tabla 15: inspeccion (Depende de apiario y entidad_regulatoria)
CREATE TABLE inspeccion (
    id_inspeccion INT AUTO_INCREMENT NOT NULL,
    id_apiario INT NOT NULL,
    id_entidad INT NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (id_inspeccion),
    FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario),
    FOREIGN KEY (id_entidad) REFERENCES entidad_regulatoria(id_entidad)
);


-- 3. TABLAS DEPENDIENTES 2

-- Tabla 5: sensor_iot (Depende de colmena)
CREATE TABLE sensor_iot (
    id_sensor INT AUTO_INCREMENT NOT NULL,
    id_colmena INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_sensor),
    FOREIGN KEY (id_colmena) REFERENCES colmena(id_colmena)
);

-- Tabla 11: usuario_apiario (Depende de usuario y apiario)
CREATE TABLE usuario_apiario (
    id_usuario INT NOT NULL,
    id_apiario INT NOT NULL,
    PRIMARY KEY (id_usuario, id_apiario),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_apiario) REFERENCES apiario(id_apiario)
);


-- 4. TABLAS DEPENDIENTES 3.

-- Tabla 6: dato_sensor (Depende de sensor_iot)
CREATE TABLE dato_sensor (
    id_dato INT AUTO_INCREMENT NOT NULL,
    id_sensor INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    fecha TIMESTAMP NOT NULL,
    PRIMARY KEY (id_dato),
    FOREIGN KEY (id_sensor) REFERENCES sensor_iot(id_sensor)
);

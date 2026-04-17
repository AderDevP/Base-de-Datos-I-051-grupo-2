-- Scripts de Modificación de la Base de Datos - SGBD PostgreSQL        
-- Todas las instrucciones se deben realizar en secuencia sin errores
-- Probar los scripts en detalle
-- Modificación de la Base de Datos.


1. DATOS SEMI-ESTRUCTURADOS PARA IOT (SENSORES)
Para la gestión de datos provenientes de sensores IoT, se decidió incorporar un campo de tipo JSONB en la tabla datos_sensor, denominado datos_ambientales.
Este campo permite almacenar información adicional de los sensores en formato semiestructurado, como temperatura, humedad y presión, sin necesidad de modificar constantemente la estructura de la base de datos.
Se realizaron las siguientes acciones:
* Se agregó el campo datos_ambientales de tipo JSONB a la tabla.
* Se insertaron registros de prueba que incluyen información ambiental en formato JSON.
* Se realizaron consultas utilizando operadores propios de PostgreSQL (->>), permitiendo extraer valores específicos del JSON.
El propósito de este campo es proporcionar flexibilidad en el almacenamiento de datos IoT, facilitando la integración de múltiples variables que pueden cambiar con el tiempo, optimizando así el manejo de grandes volúmenes de datos semiestructurados.
Agregar campo JSONB

ALTER TABLE datos_sensor
ADD COLUMN datos_ambientales JSONB;


Insertar registros


INSERT INTO datos_sensor (id_sensor, valor, fecha, datos_ambientales)
VALUES
(1, 25.5, NOW(), '{"temperatura": 25.5, "humedad": 60, "presion": 1012}'),
(1, 27.2, NOW(), '{"temperatura": 27.2, "humedad": 55, "presion": 1010}');












Consultar información


SELECT
id_dato,
datos_ambientales,
datos_ambientales->>'temperatura' AS temperatura,
datos_ambientales->>'humedad' AS humedad
FROM datos_sensor;
 2. DATOS SEMI-ESTRUCTURADOS PARA BIG DATA / IOT
Para el manejo de información adicional en productos, se implementó un campo de tipo JSONB en la tabla productos, denominado caracteristicas.
Este campo permite almacenar atributos variables de los productos, como color, peso, presentación u origen, sin necesidad de crear nuevas columnas en la tabla.
Se realizaron las siguientes acciones:
* Se agregó el campo caracteristicas de tipo JSONB a la tabla.
* Se insertaron registros con información adicional en formato JSON.
* Se realizaron consultas para acceder a atributos específicos utilizando operadores de PostgreSQL.
El propósito de este campo es mejorar la flexibilidad del modelo de datos, permitiendo adaptarse a cambios en los atributos de los productos sin afectar la estructura de la base de datos, lo cual es especialmente útil en escenarios de Big Data donde la información puede ser altamente variable.
Agregar campo JSONB


ALTER TABLE productos
ADD COLUMN caracteristicas JSONB;




Insertar registros


INSERT INTO productos (nombre, precio, caracteristicas)
VALUES
('Miel organica', 20000, '{"color": "ambar", "peso": "500g", "origen": "natural"}'),
('Propoleo', 15000, '{"presentacion": "gotas", "uso": "medicinal"}');






Consultar información


SELECT
   id_producto,
   nombre,
   caracteristicas,
   caracteristicas->>'color' AS color
FROM productos;


Método de ejecución la parte 1 primero y después se ejecuta la parte 2 para evitar errores

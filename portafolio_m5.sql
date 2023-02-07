CREATE TABLE categoria_usuario(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	ver_bd BOOLEAN, 
	modificar_bd BOOLEAN,
	descuentos_min BOOLEAN,
	descuentos_max BOOLEAN,
	promociones BOOLEAN
);

CREATE TABLE usuario(
	id SERIAL PRIMARY KEY,
	id_categoria INT NOT NULL,
	empresa BOOLEAN,
	rut VARCHAR(13) NOT NULL UNIQUE,
	nombre VARCHAR(100) NOT NULL,
	nombre_representante_legal VARCHAR(100),
	rut_representante_legal VARCHAR(13),
	domicilio VARCHAR(100),
	ciudad_o_comuna VARCHAR(50),
	telefono INT,
	email VARCHAR(50) NOT NULL UNIQUE,
	password VARCHAR(50) NOT NULL,
	activo BOOLEAN DEFAULT TRUE,
	FOREIGN KEY(id_categoria) REFERENCES categoria_usuario(id)
);
alter table usuario alter column telefono type bigint;

CREATE TABLE categoria_producto(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(100)
);
 
CREATE TABLE producto(
	id SERIAL PRIMARY KEY,
	id_categoria INT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(50) NOT NULL,
	stock INT not null default 0 check(stock >=0),
	precio DECIMAL NOT NULL check(precio >=0),
	FOREIGN KEY(id_categoria) REFERENCES categoria_producto(id)
);
alter table producto rename column descripcion to numero;
alter table producto alter column numero TYPE INT USING numero::integer;
alter table producto alter column numero SET NOT NULL;

CREATE TABLE proveedor(
	id SERIAL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	domicilio VARCHAR(100),
	ciudad_o_comuna VARCHAR(50),
	telefono INT,
	email VARCHAR(50) NOT NULL UNIQUE
);
alter table proveedor add column rut varchar(13);
alter table proveedor alter column telefono type bigint;

CREATE TABLE compra(
	id SERIAL PRIMARY KEY,
	id_proveedor INT NOT NULL,
	tipo_documento VARCHAR(10) NOT NULL DEFAULT 'factura',
	numero_documento INT NOT NULL,
	fecha DATE NOT NULL,
	neto INT NOT NULL,
	iva NUMERIC NOT NULL,
	bruto INT NOT NULL CHECK (BRUTO=(NETO+IVA)),
	FOREIGN KEY(id_proveedor) REFERENCES proveedor(id)
);

CREATE TABLE detalle_compra(
	id SERIAL PRIMARY KEY,
	id_compra INT NOT NULL,
	id_producto INT NOT NULL,
	cantidad INT NOT NULL,
	precio INT NOT NULL,
	FOREIGN KEY(id_compra) REFERENCES compra(id),
	FOREIGN KEY(id_producto) REFERENCES producto(id)
);

CREATE TABLE venta(
	id SERIAL PRIMARY KEY,
	id_usuario INT NOT NULL,
	tipo_documento VARCHAR(10) NOT NULL DEFAULT 'boleta',
	numero_documento INT NOT NULL,
	fecha DATE NOT NULL,
	neto INT NOT NULL,
	iva NUMERIC NOT NULL,
	bruto INT NOT NULL CHECK (BRUTO=(NETO+IVA)),
	FOREIGN KEY(id_usuario) REFERENCES usuario(id)
);
alter table venta add constraint numero_documento unique(numero_documento);
alter table venta drop constraint venta_check;
SELECT conname, contype
FROM pg_catalog.pg_constraint c
JOIN pg_class t ON t.oid = c.conrelid
WHERE t.relname ='venta';

CREATE TABLE detalle_venta(
	id SERIAL PRIMARY KEY,
	id_venta INT NOT NULL,
	id_producto INT NOT NULL,
	cantidad INT NOT NULL,
	precio_unidad INT NOT NULL,
	descuento INT CHECK (descuento<((precio_unidad*cantidad)*0.5)),
	precio_final INT CHECK (precio_final=(cantidad*precio_unidad-descuento)),
	FOREIGN KEY(id_venta) REFERENCES venta(id),
	FOREIGN KEY(id_producto) REFERENCES producto(id)
);
alter table detalle_venta alter column descuento set default 0;
alter table detalle_venta alter column cantidad set default 1;

-- INSERTAR DATOS TABLA CATEGORIA_USUARIO
INSERT INTO categoria_usuario(nombre, ver_bd, modificar_bd, descuentos_min, descuentos_max, promociones) VALUES
	('gold', false, false, true, true, true),
	('silver', false, false, true, false, true),
	('bronze', false, false, false, false, true),
	('admin', true, true, false, false, false),
	('curador', true, false, false, false, false);
SELECT * FROM categoria_usuario;

-- INSERTAR DATOS TABLA USUARIO
INSERT INTO usuario(id_categoria, empresa, rut, nombre, nombre_representante_legal, rut_representante_legal, domicilio, ciudad_o_comuna, telefono, email, password, activo) VALUES
	(1, true, '77.777.777-7', 'gonzales y cia. ltda.', 'juan gonzález', '7.654.321-k', 'los canelos 350', 'osorno', 5694505075, 'jgonzalez@mail.com', '123456', true),
	(2, false, '7.777.777-7', 'pedro soto', null, null, 'los vilo 830', 'valparaíso', 5605406064, 'psoto@mail.com', '123456', true),
	(3, false, '16.666.666-6', 'luisa pérez', null, null, 'san martín 123', 'santa juana', 567660657, 'lperez@mail.com', '123456', true),
	(1, false, '15.555.5555-', 'abel gómez', null, null, 'carrera 20', 'antofagasta', 569876543, 'agomez@mail.com', '123456', true),
	(2, true, '88.888.888-8', 'isometrico s.a.', 'maría araos', '18.564.314-3', 'argentina 720', 'conchalí', 5693245457, 'maraos@mail.com', '123456', true),
	(3, true, '99.999.999-9', 'full house spa', 'david tapia', '17.123.414-3', 'arabia 14 depto. 1401', 'puerto montt', 568645157, 'dtapia@mail.com', '123456', true),
	(4, false, '24.444.444-4', 'benito duna', null, null, 'coronel salas 360, depto 13b', 'las condes', 569789123, 'bduna@mail.com', '123456', true),
	(5, false, '10.101.000-1', 'alejandra fuentes', null, null, 'pasaje olga 13', 'punta arenas', 569678894, 'afuentes@mail.com', '123456', false);
SELECT * FROM usuario;

-- INSERTAR DATOS TABLA CATEGORIA_PRODUCTO
INSERT INTO categoria_producto(nombre, descripcion) VALUES
	('mujer', 'calzado para mujeres adultas'),
	('hombre', 'calzado para hombres adultos'),
	('unisex', 'calzado para ambos sexos'),
	('niño', 'calzado para niños'),
	('niña', 'calzado para niñas');
SELECT * FROM categoria_producto;	

-- INSERTAR DATOS TABLA PRODUCTO
INSERT INTO producto(id_categoria, nombre, numero, stock, precio) VALUES
	(1, 'zapato taco rojo', 37, 10, 35000),
	(2, 'zapatilla nike roja', 42, 20, 45000),
	(3, 'chalas amarillas', 39, 15, 15000),
	(4, 'zapato charol viol negro', 20, 18, 25000),
	(5, 'zapatilla dolpito verde', 17, 5, 18000),
	(1, 'zapatilla adidas celeste', 36, 20, 40000),
	(2, 'mocasin cafe jarman', 41, 3, 38000),
	(1, 'botas grises adagio', 37, 4, 55000);
SELECT * FROM producto;	

-- INSERTAR DATOS TABLA PROVEEDOR
INSERT INTO proveedor(nombre, domicilio, ciudad_o_comuna, telefono, email, rut) VALUES
	('industrial arias ltda', 'gabriela mistral 83', 'colina', 561054050, 'contacto@arias.cl', '88.888.151-3'),
	('comercial zapatos spa', 'pablo neruda 13', 'arica', 563151570, 'contacto@zapatos.cl', '75.545.545-3'),
	('todo zapatillas s.a.', 'pablo de rocka 818', 'viña del mar', 568786516, 'contacto@zapatillas.cl', '76.578.451-7'),
	('pies y más ltda.', 'zurita 720', 'providencia', 568818181, 'contacto@pies.cl', '80.878.128-5'),
	('calzados hernández eirl', 'vicente huidrobro', 'punta arenas', 567564886, 'contacto@chernandez.cl', '74.545.789-1');
SELECT * FROM proveedor;

-- INSERTAR DATOS TABLA COMPRA
INSERT INTO compra(id_proveedor, numero_documento, fecha, neto, iva, bruto) VALUES
	(1, 455645, '26/01/2022', 5000000, 950000, 5950000),
	(2, 46548, '02/05/2022', 3000000, 570000, 3570000),
	(3, 78616, '21/07/2022', 600000, 114000, 714000),
	(4, 891561, '12/08/2022', 4000000, 760000, 4760000),
	(5, 505605, '26/11/2022', 500000, 95000, 595000);
SELECT * FROM compra;

-- INSERTAR DATOS TABLA DETALLE_COMPRA
INSERT INTO detalle_compra(id_compra, id_producto, cantidad, precio) VALUES
	(2, 6, 80, 3000000),
	(2, 1, 30, 1950000),
	(2, 3, 20, 1000000),
	(3, 2, 50, 2400000),
	(3, 8, 30, 1170000),
	(4, 4, 25, 714000),
	(5, 7, 90, 4000000),
	(5, 5, 15, 760000),
	(6, 3, 10, 595000);
SELECT * FROM detalle_compra;

-- INSERTAR DATOS TABLA VENTA
INSERT INTO venta(id_usuario, tipo_documento, numero_documento, fecha, neto, iva, bruto) VALUES
	(2, 'boleta', 14, '28/01/2022', 85000, 16150, 101150),
	(3, 'boleta', 15, '02/02/2022', 120000, 22800, 142800),
	(1, 'factura', 7, '09/02/2022', 600000, 114000, 714000),
	(5, 'factura', 8, '04/03/2022', 500000, 95000, 595000),
	(4, 'boleta', 16, '26/04/2022', 50000, 9500, 59500),
	(7, 'boleta', 17, '16/05/2022', 30000, 5700, 35700),
	(3, 'boleta', 18, '02/06/2022', 150000, 28500, 178500),
	(6, 'factura', 9, '21/07/2022', 800000, 152000, 952000),
	(5, 'factura', 10, '12/08/2022', 200000, 38000, 238000),
	(8, 'boleta', 19, '05/12/2022', 70000, 13300, 83300),
	(2, 'boleta', 20, '15/12/2022', 45000, 8550, 53550),
	(7, 'boleta', 21, '28/12/2022', 180000, 34200, 214200);
SELECT * FROM venta;

-- INSERTAR DATOS TABLA DETALLE_VENTA
INSERT INTO detalle_venta(id_venta, id_producto, cantidad, precio_unidad, precio_final) VALUES
	(1, 6, 1, 85000, 85000),
	(2, 1, 1, 80000, 80000),
	(2, 3, 1, 40000, 40000),
	(3, 2, 2, 100000, 200000),
	(3, 8, 1, 200000, 200000),
	(3, 4, 4, 50000, 200000),
	(4, 7, 3, 70000, 210000),
	(4, 5, 6, 30000, 180000),
	(4, 6, 1, 110000, 110000),
	(5, 1, 1, 50000, 50000),
	(6, 3, 1, 30000, 30000),
	(7, 2, 1, 100000, 100000),
	(7, 8, 1, 50000, 50000),
	(8, 4, 5, 30000, 150000),
	(8, 7, 1, 50000, 50000),
	(8, 5, 12, 25000, 300000),
	(8, 3, 10, 30000, 300000),
	(9, 3, 5, 30000, 150000),
	(9, 2, 1, 50000, 50000),
	(10, 8, 1, 40000, 40000),
	(10, 4, 1, 30000, 30000),
	(11, 7, 1, 45000, 45000),
	(12, 5, 4, 25000, 100000),
	(12, 3, 4, 20000, 80000);
SELECT * FROM detalle_venta;


-- ACTUALIZAR PRECIOS DE TODOS LOS PRODUCTOS, -20% OFERTA VERANO
UPDATE producto SET precio = round(precio*0.8);
SELECT * FROM producto;


-- LISTAR PRODUCTOS CON STOCK CRITICO. IGUAL O MENOS DE 5 UNIDADES
SELECT * FROM producto WHERE stock<=5;


-- SIMULAR VENTA DE AL MENOS 3 PRODUCTOS, CALCULAR SUBTOTAL, AGREGAR IVA Y MOSTRAR TOTAL DE COMPRA

BEGIN
--SE REALIZA NUEVA VENTA
INSERT INTO venta(id_usuario, tipo_documento, numero_documento, fecha, neto, iva, bruto) VALUES 
(2, 'boleta', 22, '31/12/2022', 0, 0, 0);
SELECT * FROM venta;

--SE AGREGA EL DETALLE DE LA VENTA:
INSERT INTO detalle_venta(id_venta, id_producto, cantidad, precio_unidad, precio_final) VALUES
	((SELECT MAX(id) FROM venta), 1, 2, 28000, 56000),
	((SELECT MAX(id) FROM venta), 2, 1, 36000, 36000),
	((SELECT MAX(id) FROM venta), 8, 1, 44000, 44000);
SELECT * FROM detalle_venta;

--SE CALCULA SUBTOTAL, IVA Y PRECIO FINAL. CON DICHOS VALORES SE ACTUALIZA REGISTRO DE TABLA VENTA
UPDATE venta SET 
	neto=(SELECT SUM(PRECIO_FINAL) FROM DETALLE_VENTA WHERE ID_VENTA=(SELECT MAX(id) FROM venta))
	WHERE id=(SELECT MAX(id) FROM venta);
UPDATE venta SET 
	iva= (SELECT neto*0.19 FROM venta WHERE id=(SELECT MAX(id) FROM venta))
	WHERE id=(SELECT MAX(id) FROM venta);
UPDATE venta SET 
	bruto= (SELECT neto+iva FROM venta WHERE id=(SELECT MAX(id) FROM venta))
	WHERE id=(SELECT MAX(id) FROM venta);
	
SELECT id, id_usuario, fecha, neto AS SUBTOTAL, iva, bruto AS TOTAL_COMPRA FROM venta
WHERE id=(SELECT MAX(id) FROM venta);

--SE DESCUENTAN DEL STOCK DE PRODUCTOS, AQUELLOS QUE SE VENDIERON
UPDATE producto SET stock = stock -2 where id = 1;
UPDATE producto SET stock = stock -1 where id = 2;
UPDATE producto SET stock = stock -1 where id = 8;
SELECT * FROM producto;

ROLLBACK;
COMMIT;


-- MOSTRAR TOTAL DE VENTAS DEL MES DICIEMBRE 2022

	-- Lista cada venta realizada en diciembre 2022
SELECT * FROM venta WHERE fecha BETWEEN '01-12-2022'AND'31-12-2022';

	-- Muestra la cantidad de ventas realizadas y la suma total recaudada por ventas en diciembre 2022
SELECT COUNT(tipo_documento) AS "ventas realizadas dic-2022", SUM(bruto) AS "total recaudado ventas dic-2022" 
FROM venta WHERE fecha BETWEEN '01-12-2022'AND'31-12-2022';


-- LISTAR COMPORTAMIENTO DE COMPRA DE USUARIO QUE MÁS COMPRAS REALIZÓ DURANTE EL 2022

	-- COMPORTAMIENTO DE USUARIO CON MÁS COMPRAS EN RELACIÓN A SUMA TOTAL DEL PRECIO DE COMPRAS
SELECT u.id, u.nombre, v.tipo_documento, v.fecha, v.bruto FROM usuario u JOIN VENTA v ON u.id=v.id_usuario
WHERE u.id IN(SELECT ID_USUARIO FROM (SELECT ID_USUARIO, SUM(BRUTO) AS TOTAL
FROM VENTA GROUP BY ID_USUARIO HAVING SUM(BRUTO)=(SELECT SUM(BRUTO) AS TOTAL
FROM VENTA GROUP BY ID_USUARIO ORDER BY TOTAL DESC LIMIT 1) ORDER BY TOTAL) AS FOO);

	-- COMPORTAMIENTO DE USUARIO CON MÁS COMPRAS EN RELACIÓN A LA CANTIDAD DE COMPRAS REALIZADAS
SELECT u.id, u.nombre, v.tipo_documento, v.fecha, v.bruto FROM usuario u JOIN VENTA v ON u.id=v.id_usuario
WHERE u.id IN(SELECT ID_USUARIO FROM (SELECT ID_USUARIO, COUNT(TIPO_DOCUMENTO) AS TOTAL
FROM VENTA GROUP BY ID_USUARIO HAVING COUNT(TIPO_DOCUMENTO)=(SELECT COUNT(TIPO_DOCUMENTO) AS TOTAL
FROM VENTA GROUP BY ID_USUARIO ORDER BY TOTAL DESC LIMIT 1) ORDER BY TOTAL) AS FOO)
ORDER BY u.nombre;


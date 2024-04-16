CREATE DATABASE IF NOT EXISTS alkewallet;

USE alkewallet; 

CREATE TABLE monedas(
moneda_id INT PRIMARY KEY AUTO_INCREMENT,
nombre_moneda VARCHAR (40) NOT NULL,
simbolo_moneda VARCHAR (5) NOT NULL
);

INSERT INTO monedas (nombre_moneda,simbolo_moneda) VALUES
		("Dolar Americano", "USD"),
		("Euro", "EUR"),
		("yen", "JPY"),
        ("Peso Chileno","CLP");
        
CREATE TABLE Usuarios(
user_id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (35) NOT NULL,
apellido VARCHAR (35) NOT NULL,
correo_electronico VARCHAR (80) NOT NULL,
contraseña VARCHAR (80) NOT NULL
);  
 
 INSERT INTO Usuarios (nombre, apellido, correo_electronico, contraseña) VALUES
		("Emilio","Sequera","emilioSe@gmail.com",sha2("14147561", 256)),  
        ("Dayana","Ortiz","Dayiort@gmail.com",sha2("248747a8e", 256)),  
        ("Arturo","Dominguez","rodrigoj@gmail.com",sha2("ceff5478ef", 256)),  
        ("Trinidad","Salas","trinittt@hotmail.com",sha2("2ponh55", 256)),  
        ("Dayana","Rosario","Raosaesd@gmail.com",sha2("777784fbv", 256)),  
        ("Pedro","Campos","elpedror@gmail.com",sha2("2hhhse47a8e", 256)),  
        ("Ignasia","Reyes","ingirns@gmail.com",sha2("**gdfggbfd7c58}", 256)),  
        ("Carmen","Sequera","Dppooirt@gmail.com",sha2("bbgfd8gfrd{{<", 256)),  
        ("Donny","Darko","frankrabbit@gmail.com",sha2("efgldjefdde58rd", 256)),  
        ("Vincent","Straut","elviigd@ hotmail.com",sha2("**ldjbojuhnc58}", 256));
        
CREATE TABLE cuentas(
cuenta_id INT PRIMARY KEY AUTO_INCREMENT,
saldo INT DEFAULT 0,
fecha_apertura DATE NOT NULL, 
user_id INT,
FOREIGN KEY (user_id) REFERENCES Usuarios (user_id)
);

INSERT INTO cuentas (saldo,fecha_apertura,user_id) VALUES
		(8000000,"2024-04-10",1),
		(150350,"2023-12-24",2),
		(1253000,"2023-10-28",3),
		(738900,"2024-01-01",4),
		(5930800,"2024-02-07",5),
		(93400,"2024-02-15",6),
		(112090,"2024-03-10",7),
		(5400040,"2023-11-26",8),
		(65580,"2024-04-04",9),
		(352080,"2024-03-11",10);
     
     CREATE TABLE transacciones(
     transaccion_id INT PRIMARY KEY AUTO_INCREMENT,
     sender_user_id INT NOT NULL,
     receiver_user_id INT NOT NULL,
     importe INT NOT NULL,
     fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     moneda_id INT NOT NULL,
     cuenta_id INT NOT NULL, 
     FOREIGN KEY (sender_user_id) REFERENCES usuarios (user_id),
     FOREIGN KEY (receiver_user_id) REFERENCES usuarios (user_id),
     FOREIGN KEY (moneda_id) REFERENCES monedas (moneda_id),
     FOREIGN KEY (cuenta_id) REFERENCES cuentas (cuenta_id)
     );
     
     INSERT INTO transacciones (sender_user_id,receiver_user_id,importe,moneda_id,cuenta_id) values
		(1,3,35,2,3),
		(5,2,250000,4,2),
		(8,1,1000,1,1),
		(7,4,60,3,4),
		(9,2,200,2,2),
		(1,6,20000,4,6),
		(4,5,20,1,5),
        (10,4,50,2,4),
        (2,6,15000,4,6),
        (10,1,500,1,1);


-- 1 Consulta para obtener el nombre de la moneda elegida por un usuario específico

SELECT u.nombre, m.nombre_moneda, COUNT(t.transaccion_id) as transacciones_de_cuenta
FROM transacciones t
JOIN Monedas m ON t.moneda_id = m.moneda_id
JOIN Usuarios u ON t.sender_user_id = u.user_id
WHERE t.sender_user_id = 1
GROUP BY m.nombre_moneda
ORDER BY transacciones_de_cuenta DESC
LIMIT 1;    
     
-- 2 todas las transacciones de un usuario en especifico

SELECT * FROM transacciones WHERE sender_user_id = 4 OR receiver_user_id = 4;

-- 3 consulta para obtener todos los usuario registrados

SELECT user_id,nombre, apellido FROM usuarios;

-- 4 consulta para obtener todas las monedas registradas

SELECT * FROM monedas;

-- 5 consulta para obtener todas las transacciones registradas.

SELECT * FROM transacciones;

-- 6 consulta para obtener todas las transacciones realizadas por un usuario en específico.

SELECT u.nombre, t.transaccion_id, t.importe, t.fecha_transaccion 
FROM Transacciones t
JOIN Usuarios u ON t.sender_user_id = u.user_id
WHERE u.nombre = 'vincent';

-- 7 consulta para obtener todas las transacciones realizadas por un usuario en específico.

SELECT u.nombre, t.transaccion_id, t.importe, t.fecha_transaccion
FROM Transacciones t
JOIN Usuarios u ON t.receiver_user_id = u.user_id
WHERE u.nombre = 'emilio';

-- 8 Sentencia DML para modificar el campo correo electrónico de un usuario específico

UPDATE Usuarios
SET correo_electronico = "glira27@gmail.com"
WHERE user_id = 1;

-- 9 Sentencia para eliminar los datos de una transacción

DELETE FROM Transacciones
WHERE transaccion_id = 5;

-- 10 Sentencia para DDL modificar el nombre de la columna correo_electronico por email

ALTER TABLE Usuarios
CHANGE COLUMN correo_electronico e_mail VARCHAR(100);





		
        
       


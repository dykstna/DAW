/*EJERCICIO 11*/
/* Cree una vista llamada Nombre_Empleados con el nombre y apellidos 
(en un solo campo nombre) de todos los empleados que son de Málaga.*/
DROP VIEW IF EXISTS Nombre_Empleados;
CREATE VIEW Nombre_Empleados AS
SELECT CONCAT(nombre," ",apellido1," ",apellido2) AS Nombre_Completo 
FROM empleados
WHERE ciudad LIKE "Sevilla";
SELECT * FROM Nombre_Empleados;


/*EJERCICIO 12*/
/* Cree otra vista llamada Información_Empleados que contenga el 
nombre y apellidos (en un solo campo nombre) y edad (no fecha de 
nacimiento) de cada empleado.*/
DROP VIEW IF EXISTS Informacion_Empleados;
CREATE VIEW Informacion_Empleados AS
SELECT CONCAT(nombre," ",apellido1," ",apellido2) AS Nombre_Completo,
TRUNCATE(DATEDIFF(curdate(),fecha_nacimiento)/365,0) AS Edad
FROM empleados;
SELECT * FROM Informacion_Empleados;

/*EJERCICIO 13*/
/*Cree otra vista sobre la anterior llamada Información_Actual que 
dispone de toda la información de Información_Empleados junto con 
el salario que está cobrando en este momento.*/
DROP VIEW IF EXISTS Información_Actual;
CREATE VIEW Información_Actual AS
SELECT DISTINCT i.*,h.salario FROM Informacion_Empleados i,historial_salarial h;
SELECT * FROM Información_Actual;


/*EJERCICIO 14*/
/*Inserte una tupla sobre cada una de estas vistas. ¿Qué sucede?*/


/*EJERCICIO 15*/
/*Borrar todas las tablas. ¿Hay que tener en cuenta las claves 
foráneas a la hora de borrar las tablas?*/
DROP TABLE if EXISTS historial_salarial;
DROP TABLE if EXISTS historial_laboral;
DROP TABLE if EXISTS estudios;
DROP TABLE if EXISTS departamentos;
DROP TABLE if EXISTS trabajos;
DROP TABLE if EXISTS universidades;
DROP TABLE if EXISTS empleados;

--DROP DATABASE Universidad;


/*EJERCICI0 1*/
SELECT nombre FROM provincia;

/*EJERCICI0 2*/
SELECT nombre, apellidos FROM alumno;

/*EJERCICI0 3*/
SELECT * FROM asignatura;

/*EJERCICI0 4*/
SELECT dni,nombre,apellidos FROM profesor ORDER BY dni;

/*EJERCICI0 5*/
SELECT ID_ALUM,dni,nombre,apellidos,fecha_nac AS Fecha_de_nacimiento,nacido_en 
FROM alumno 
ORDER BY FECHA_NAC;

/*EJERCICI0 6*/
/*SELECT * FROM alumno where dni='56846315M';*/
SELECT * FROM alumno WHERE upper(dni) LIKE '56846315M';

/*EJERCICI0 7*/
/*SELECT * FROM alumno WHERE nacido_en>2 and nacido_en<8;*/
SELECT * FROM alumno WHERE nacido_en BETWEEN 3 and 7;

/*EJERCICI0 8*/
SELECT * FROM profesor WHERE nacido_en IN (1,3,5,7);

/*EJERCICI0 9*/
/*SELECT * FROM alumno WHERE fecha_nac>='1980-02-19' AND fecha_nac<='1984-07-20';*/
SELECT * FROM alumno WHERE fecha_nac BETWEEN'1980-02-19' AND '1984-07-20';

/*EJERCICI0 10*/
SELECT * FROM matriculado WHERE id_alum=7;

/*EJERCICI0 11*/
/*SELECT nombre,apellidos FROM alumno WHERE fecha_nac<='1999-01-09';*/
SELECT nombre,apellidos FROM alumno WHERE TIMESTAMPDIFF(YEAR,fecha_nac,curdate())>30;

/*EJERCICI0 12*/
SELECT * FROM alumno WHERE dni LIKE '%Y';

/*EJERCICI0 13*/
SELECT * FROM alumno where nombre LIKE 'S%';

/*EJERCICI0 14*/
SELECT nombre FROM alumno where UPPER(nombre) like '%N%';
/*SELECT nombre FROM alumno where LOWER(nombre) like '%n%';*/

/*EJERCICI0 15*/
SELECT nombre FROM alumno WHERE LOWER(apellidos) LIKE '%z%';

/*EJERCICI0 16*/
SELECT * FROM alumno WHERE nombre LIKE 'Manuel%';

/*EJERCICI0 17*/
SELECT * FROM alumno WHERE nombre='Manuel' or nombre='Cristina';
/*SELECT * FROM alumno WHERE nombre IN('Manuel','Cristina');*/
/*SELECT * FROM alumno WHERE nombre LIKE 'Manuel' or nombre LIKE 'Cristina';*/

/*EJERCICI0 18*/
SELECT * FROM alumno WHERE dni LIKE '2%';

/*EJERCICI0 19*/
SELECT DISTINCT nacido_en FROM alumno;

/*EJERCICI0 20*/
SELECT *,round(SUM(NOTA1+NOTA2+NOTA3)/3,2) AS Media 
FROM matriculado 
GROUP BY ID_ALUM,ID_ASIG;

/*EJERCICI0 21*/
SELECT * FROM matriculado 
WHERE nota1>=5 AND nota2>=5 AND nota3>=5 AND ID_ASIG=1;

/*EJERCICI0 22*/
SELECT * FROM matriculado WHERE nota1=10 or nota2=10 or nota3=10; 

/*EJERCICI0 23*/
SELECT * FROM matriculado 
WHERE (nota1>=5 and ID_ASIG=2) or (nota2>=5 and ID_ASIG=2) or (nota3>=5 and ID_ASIG=2);

/*EJERCICI0 24*/
SELECT * FROM matriculado WHERE nota1>=5 ORDER BY nota2,nota3 ASC;

/*EJERCICI0 25*/
SELECT * FROM alumno WHERE fecha_nac LIKE '1985%';

/*EJERCICI0 26*/
/*SELECT *,MONTH(fecha_nac) AS Mes FROM alumno;*/
SELECT *,date_format(fecha_nac,'%M') AS Mes FROM alumno ORDER BY MONTH(fecha_nac);
SELECT *,date_format(fecha_nac,'%m') AS Mes FROM alumno ORDER BY Mes;

/*EJERCICI0 27*/
SELECT *, DATE_FORMAT(FECHA_NAC,'Nacido el dia %d de %M de %Y') 
as 'Fecha de Nacimiento' FROM alumno;

/*EJERCICI0 28*/
/*SELECT nombre, apellidos,timestampdiff(year,fecha_nac,curdate()) 
as edad from alumno;*/

SELECT nombre, apellidos,TRUNCATE (DATEDIFF(curdate(),fecha_nac)/365,0) 
as edad from alumno;

/*EJERCICI0 29*/
SELECT *, DATEDIFF(curdate(),fecha_nac) AS 'Dias vividos' FROM alumno;

/*EJERCICI0 30*/
SELECT nombre,apellidos FROM alumno ORDER BY fecha_nac LIMIT 4;

/*EJERCICI0 31*/
SELECT COUNT(id_alum) AS Numero_Alumnos FROM alumno;

/*EJERCICI0 32*/
SELECT COUNT(ID_PROF) AS Numero_Profesores_Sevilla FROM profesor WHERE nacido_en=2;

/*EJERCICI0 33*/
SELECT MAX(nota2) AS 'Nota Maxima' FROM matriculado;

/*EJERCICI0 34*/
SELECT MIN(nota1) AS 'Nota Minima 1 Trimestre Redes' FROM matriculado;

/*EJERCICI0 35*/
SELECT nota1 AS Notas_Redes FROM matriculado WHERE id_asig=1;

/*EJERCICI0 36*/
SELECT SUM(nota1) AS Suma,SUM(id_asig) AS Numero_Notas,AVG(nota1) AS Nota_Media 
FROM matriculado WHERE id_asig=1;
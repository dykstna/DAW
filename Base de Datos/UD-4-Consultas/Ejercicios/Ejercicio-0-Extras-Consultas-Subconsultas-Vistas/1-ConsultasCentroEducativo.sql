/*RELACION*/
/*ASIGNATURA-MATRICULADO-ALUMNO-PROVINCIA-PROFESOR-IMPARTE-ASIGNATURA*/

/*-------------------SUBCONSULTAS-------------------------------*/

/*EJERCICIO 1*/
/*Obtener el nombre y apellido de los profesores que han nacido en 
la provincia de Cordoba.*/
SELECT nombre,apellidos FROM profesor WHERE nacido_en IN(
    SELECT ID_PROV FROM provincia where nombre LIKE 'Cordoba'
    );


/*EJERCICIO 2*/
/*Obtener el nombre de la provincia en la que ha nacido el profesor 
que imparte la asignatura con ID_ASIG = 2.*/
SELECT nombre FROM provincia WHERE ID_PROV IN(
    SELECT nacido_en FROM profesor WHERE ID_PROF IN(
        SELECT ID_PROF from imparte where ID_ASIG=2)
    );


/*EJERCICIO 3*/
/*Obtener el nombre de las asignaturas que no han sido impartidas 
por ningún profesor.*/
SELECT a.nombre from asignatura a WHERE ID_ASIG NOT IN(
    SELECT ID_ASIG FROM imparte i WHERE i.ID_ASIG=a.ID_ASIG
    );


/*EJERCICIO 4*/
/*Obtener el nombre de las asignaturas que han sido impartidas 
por el profesor con ID_PROF = 2.*/
SELECT nombre FROM asignatura WHERE ID_ASIG IN(
    SELECT ID_ASIG FROM imparte WHERE ID_PROF=2
    );


/*EJERCICIO 5*/
/*Obtener el número de alumnos matriculados y el nombre de cada 
asignatura.*/
SELECT a.nombre AS asignatura, (
    SELECT COUNT(*) FROM matriculado m 
    WHERE m.ID_ASIG = a.ID_ASIG) AS 'Nº ALUMNOS Matriculados'
FROM asignatura a;


/*EJERCICIO 6*/
/*Obtener el nombre y apellido del profesor que imparte la 
asignatura con ID_ASIG = 1.*/
SELECT nombre,apellidos FROM profesor WHERE ID_PROF IN(
    SELECT ID_PROF FROM imparte WHERE ID_ASIG=1
    );


/*EJERCICIO 7*/
/*Obtener el número de asignaturas impartidas por cada profesor.*/
SELECT concat(nombre," ",apellidos) AS nombre,(
    SELECT count(*) FROM imparte i 
    WHERE i.ID_PROF=p.ID_PROF) as Numero_Asignaturas
FROM profesor p;


/*EJERCICIO 8*/
/*Obtener el nombre y apellidos de los alumnos que no se han 
matriculado en ninguna asignatura.*/
SELECT concat(nombre," ",apellidos) AS Nombre FROM alumno 
WHERE ID_ALUM NOT IN(
    SELECT ID_ALUM from matriculado
    );


/*EJERCICIO 9*/
/*Obtener el nombre de las provincias en las que han nacido 
alumnos matriculados en la asignatura con ID_ASIG = 2.*/
SELECT nombre AS Provincia FROM provincia WHERE ID_PROV IN(
    SELECT nacido_en FROM alumno WHERE ID_ALUM IN(
        SELECT ID_ALUM FROM matriculado WHERE ID_ASIG=2
        ));


/*EJERCICIO 10*/
/*Obtener el nombre de las asignaturas que tienen una nota media 
superior a 6.0.*/
SELECT nombre AS Asignatura FROM asignatura 
WHERE ID_ASIG IN (
    SELECT ID_ASIG FROM MATRICULADO 
    GROUP BY ID_ASIG 
    HAVING AVG(NOTA1 + NOTA2 + NOTA3) / 3 > 6.0
    );


/*EJERCICIO 11*/
/*Obtener el nombre del profesor que ha impartido la asignatura 
con la nota media más alta.*/
SELECT p.NOMBRE FROM PROFESOR p 
JOIN IMPARTE i ON p.ID_PROF = i.ID_PROF JOIN (
    SELECT ID_ASIG, AVG(NOTA1 + NOTA2 + NOTA3)/3 AS NOTA_MEDIA
    FROM MATRICULADO
    GROUP BY ID_ASIG
    ORDER BY NOTA_MEDIA DESC
    LIMIT 1
    ) m ON i.ID_ASIG = m.ID_ASIG;


/*EJERCICIO 12*/
/*Obtener el nombre y apellidos de los alumnos que hayan nacido 
después del año 1985.*/
SELECT NOMBRE, APELLIDOS,FECHA_NAC FROM ALUMNO 
WHERE YEAR(FECHA_NAC) > (
    SELECT MAX(YEAR(FECHA_NAC)) FROM ALUMNO WHERE YEAR(FECHA_NAC) <= 1985
    );

/*EJERCICIO 13*/
/*Obtener el nombre de las asignaturas que tienen matriculados 
a alumnos con fecha de nacimiento posterior al 
1 de enero de 1975.*/
SELECT nombre FROM asignatura WHERE ID_ASIG IN(
    SELECT ID_ASIG FROM matriculado WHERE ID_ALUM IN(
        SELECT ID_ALUM FROM alumno where year(FECHA_NAC)<1975)
        );


/*EJERCICIO 14*/
/*Obtener el nombre de las tres provincias con mayor número 
de alumnos matriculados en asignaturas.*/
SELECT nombre FROM provincia where ID_PROV IN(
    SELECT count(NACIDO_EN) FROM alumno
    GROUP BY nacido_en
    ORDER BY count(nacido_en) DESC
    )LIMIT 3;


/*EJERCICIO 15*/
/*Obtener los nombres de las dos asignaturas con mayor 
nota media.*/
SELECT a.nombre,AVG(m.NOTA1+m.NOTA2+m.NOTA3)/3 AS NOTA_MEDIA 
FROM asignatura a 
JOIN matriculado m ON a.ID_ASIG = m.ID_ASIG 
WHERE a.ID_ASIG IN 
  (SELECT ID_ASIG FROM matriculado 
   GROUP BY ID_ASIG
   )
GROUP BY a.nombre
ORDER BY NOTA_MEDIA DESC
LIMIT 2;

/*EJERCICIO 16*/
/*Obtener los nombres de los dos profesores que más 
asignaturas han impartido.*/
SELECT nombre FROM profesor where ID_PROF IN(
    SELECT ID_PROF FROM IMPARTE
    GROUP BY ID_PROF
    HAVING count(ID_ASIG)
    ORDER BY count(ID_ASIG))
LIMIT 1;

/*EJERCICIO 17*/
/*Obtener el nombre y apellidos de los profesores que imparten alguna 
asignatura.*/
SELECT concat(nombre," ",apellidos) as nombre from profesor WHERE ID_PROF IN(
    SELECT ID_PROF FROM imparte
    );


/*EJERCICIO 18*/
/*Obtener el nombre de las asignaturas que ningún profesor imparte.*/
SELECT nombre FROM asignatura WHERE ID_ASIG not in(
    SELECT ID_ASIG FROM IMPARTE
    );



/*EJERCICIO 19*/
/*Obtener el nombre de los profesores que no imparten ninguna asignatura.*/
SELECT nombre FROM profesor WHERE ID_PROF not IN(
    SELECT ID_PROF FROM imparte
    );



/*EJERCICIO 20*/
/*Obtener el nombre de los profesores que imparten la asignatura con ID_ASIG 
igual a 1.*/
SELECT concat(nombre," ",apellidos) as Nombre FROM profesor WHERE ID_PROF IN(
    SELECT ID_PROF FROM IMPARTE WHERE ID_ASIG=1
    );


/*EJERCICIO 21*/
/*Obtener el nombre de los profesores que imparten la misma asignatura que 
el profesor con ID_PROF igual a 1.*/
SELECT nombre from PROFESOR where ID_PROF IN(
    SELECT ID_PROF from imparte where ID_PROF=1
    );



/*EJERCICIO 22*/
/*Obtener el nombre de los profesores que imparten la asignatura de algún 
alumno con ID_ALUM igual a 1.*/
SELECT concat(nombre," ",apellidos) as Nombre FROM profesor 
where ID_PROF IN(
    SELECT ID_PROF from imparte where ID_ASIG IN(
        SELECT ID_ASIG FROM asignatura where ID_ASIG in(
            SELECT ID_ASIG FROM alumno WHERE ID_ALUM=1)));



/*EJERCICIO 23*/
/*Obtener el número de alumnos matriculados en cada asignatura.*/
SELECT count(ID_ALUM) FROM matriculado GROUP BY ID_ASIG;



/*EJERCICIO 24*/
/*Obtener el número de asignaturas que hay en la base de datos.*/
SELECT count(ID_ASIG) FROM aignatura;


/*EJERCICIO 25*/
/*Obtener el número de profesores que imparten alguna asignatura.*/
SELECT count(ID_PROF) FROM imparte;

/*------------------------LIMIT--------------------------------------*/

/*EJERCICIO 26*/
/*Obtener el nombre de los alumnos que tienen una nota media mayor que la nota 
media de la asignatura con ID_ASIG mayor que 7.*/
SELECT concat(nombre," ",apellidos) as Nombre from alumno WHERE ID_ALUM IN(
    SELECT ID_ALUM FROM matriculado GROUP BY ID_ALUM
    HAVING avg(nota1+nota2+nota3)/3 > 7
    );


/*EJERCICIO 27*/
/*Obtener los 3 primeros profesores en orden alfabético por nombre y apellidos.*/
SELECT concat(nombre," ",apellidos) as Nombre FROM profesor
ORDER BY nombre
LIMIT 3;


/*EJERCICIO 28*/
/*Obtener las 2 primeras asignaturas en orden inverso por ID_ASIG.*/
SELECT nombre from asignatura ORDER BY ID_ASIG DESC
LIMIT 2;


/*EJERCICIO 29*/
/*Obtener el nombre y las notas de los dos alumnos con mayor nota media 
matriculados en la asignatura con ID_ASIG igual a 1.*/
SELECT concat(a.nombre," ",apellidos) as Nombre,nota1,nota2,nota3,asig.nombre 
FROM alumno a
JOIN matriculado m ON a.ID_ALUM=m.ID_ALUM
JOIN asignatura asig ON asig.ID_ASIG=m.ID_ASIG
WHERE m.ID_ASIG=1
GROUP BY a.nombre,a.apellidos
ORDER BY avg(nota1+nota2+nota3) DESC
LIMIT 2;


/*EJERCICIO 30*/
/*Obtener los datos de los 3 alumnos con la media mas alta en cualquier asignatura.*/
SELECT * FROM alumno WHERE ID_ALUM IN(
    SELECT ID_ALUM FROM matriculado
    GROUP BY ID_ALUM,ID_ASIG
    ORDER BY avg(nota1+nota2+nota3) DESC
    )
LIMIT 3;


/*EJERCICIO 31*/
/*Obtener los nombres y apellidos de los 2 primeros profesores que imparten 
alguna asignatura, ordenados por ID_PROF en orden inverso.*/
SELECT concat(nombre," ",apellidos) as nombre FROM PROFESOR WHERE ID_PROF IN(
    SELECT ID_PROF FROM imparte)
ORDER BY ID_PROF DESC
LIMIT 2;


/*EJERCICIO 32*/
/*Obtener las notas de los 3 alumnos con media(notas) más bajas matriculados 
en cualquier asignatura impartida por el profesor con ID_PROF igual a 1.*/
SELECT a.nombre,nota1,nota2,nota3,asig.nombre FROM alumno a
JOIN matriculado m ON a.ID_ALUM=m.ID_ALUM
JOIN asignatura asig ON asig.ID_ASIG=m.ID_ASIG
GROUP BY a.nombre,a.apellidos,m.ID_ASIG
ORDER BY avg(nota1+nota2+nota3)/3
LIMIT 3;


/*EJERCICIO 33*/
/*Obtener los datos de 3 alumnos matriculados en la asignatura 
con ID_ASIG igual a 2, ordenados alfabéticamente por nombre y apellidos.*/
SELECT * FROM alumno WHERE ID_ALUM IN(
    SELECT ID_ALUM from matriculado where ID_ASIG=2)
ORDER BY nombre,apellidos
LIMIT 3;

-----------------/*INSERT CON CONSULTAS*/-------------------------

/*EJERCICIO 34*/
/*Insertar un nuevo alumno solo si existe la provincia donde ha 
nacido.*/
INSERT INTO ALUMNO
SELECT 14, '12345678A', 'Juan', 'Pérez', '1990/01/01', 2 FROM provincia
WHERE ID_PROV=2;

INSERT INTO ALUMNO
SELECT 13, '12345678A', 'Juan',APELLIDOS, FECHA_NAC, NACIDO_EN FROM alumno
WHERE ID_ALUM=2;



/*EJERCICIO 35*/
/*Insertar una nueva asignatura solo si hay un profesor que la 
imparta.*/
/*INSERT INTO asignatura
SELECT 5,'Base de Datos' from asignatura where ID_ASIG in(
    SELECT ID_ASIG from imparte where ID_PROF=4
    );
SELECT * FROM asignatura;*/


/*EJERCICIO 36*/
/*Insertar un nuevo profesor solo si existe la provincia donde 
ha nacido.*/




/*EJERCICIO 37*/
/*Insertar un nuevo profesor que imparte una asignatura solo si 
la asignatura y la provincia donde ha nacido el profesor existen.*/



/*EJERCICIO 38*/
/*Insertar una nueva matrícula solo si el alumno y la asignatura 
existen.*/



/*EJERCICIO 39*/
/*Insertar una nueva matrícula solo si el alumno y la asignatura 
existen y el alumno no tiene ya matrícula en esa asignatura.*/



/*EJERCICIO 40*/
/*Insertar un nuevo profesor que imparte una asignatura solo si 
la asignatura existe y el profesor no imparte ya esa asignatura.*/



/*EJERCICIO 41*/
/*Insertar una nueva asignatura solo si no existe otra con el 
mismo nombre.*/



/*EJERCICIO 42*/
/*Insertar un nuevo alumno solo si no existe otro con el mismo 
DNI.*/



/*EJERCICIO 43*/
/*Insertar una nueva provincia solo si no existe otra con el 
mismo nombre.*/
/*EJERCICIO 1*/
SELECT * FROM pelicula WHERE genero LIKE "Animacion";

/*EJERCICIO 2*/
SELECT id_copia,estado,p.* FROM copia_pelicula cp,pelicula p
WHERE p.codigo=cp.pelicula;
/*JOIN cop_pelicula ON p.codigo=c.pelicula*/
SELECT cp.id_copia,cp.estado,p.* FROM copia_pelicula cp,pelicula p
JOIN copia_pelicula ON p.codigo=c.pelicula;

/*EJERCICIO 3*/
SELECT id_copia,estado,p.codigo,titulo,duracion,genero,anyo,precio_alquiler 
FROM copia_pelicula cp,pelicula p WHERE precio_alquiler<2.50 
AND p.codigo=cp.pelicula;

/*EJERCICIO 4*/
SELECT p.*,id_copia FROM pelicula p,copia_pelicula cp
WHERE p.codigo=cp.pelicula
GROUP BY p.codigo;

/*SELECT * FROM pelicula,copia_pelicula WHERE id_copia IN(
    SELECT id_copia from copia_pelicula)
GROUP BY codigo;*/

/*EJERCICIO 5*/
SELECT * from pelicula p
RIGHT JOIN copia_pelicula cp ON p.codigo=cp.pelicula;

/*EJERCICIO 6*/
SELECT nombre,apellido1,apellido2 FROM socio s, alquiler a 
WHERE copia_pel="113"
GROUP BY num_socio;

SELECT nombre,apellido1,apellido2 FROM socio,copia_pelicula WHERE id_copia in(
    SELECT id_copia from copia_pelicula WHERE id_copia='113');

/*EJERCICIO 7*/
SELECT nombre,apellido1,apellido2 FROM socio s, alquiler a 
WHERE MONTH(fec_alquila)=12
AND s.num_socio=a.socio
GROUP BY s.num_socio;

/*EJERCICIO 8*/
SELECT nombre,apellido1,apellido2,a.fec_devolucion FROM socio s, alquiler a 
WHERE fec_devolucion=ALL(
    SELECT fec_devolucion FROM alquiler WHERE DAY(fec_devolucion)=30
);

SELECT nombre,apellido1,apellido2,a.fec_devolucion FROM socio s, alquiler a 
WHERE fec_devolucion IN(
    SELECT fec_devolucion FROM alquiler WHERE DAY(fec_devolucion) BETWEEN 1 AND 29
)
GROUP BY nombre;

/*EJERCICIO 9*/
SELECT codigo,titulo,id_copia,count(fec_alquila) AS VecesAlquilada 
FROM pelicula p,copia_pelicula cp,alquiler a
WHERE p.codigo=cp.pelicula
AND cp.id_copia=a.copia_pel
GROUP BY copia_pel;

/*EJERCICIO 10*/
SELECT p.titulo FROM pelicula p,socio s WHERE poblacion in(
    SELECT poblacion from socio WHERE poblacion LIKE "Aguadulce"
)
GROUP BY p.titulo;

/*EJERCICIO 11*/
SELECT titulo,date_format(fec_alquila,"%d,%M,%Y") AS Fecha_Alquiler FROM pelicula p, alquiler a;

/*EJERCICIO 12*/
SELECT titulo, DATEDIFF(fec_devolucion,fec_alquila) AS Dias_Alquilada 
FROM pelicula,alquiler WHERE copia_pel IN(
    SELECT copia_pel FROM Alquiler
);

/*EJERCICIO 13*/
SELECT nombre,round(DATEDIFF(now(),fec_nac)/365) AS Edad FROM socio;

SELECT nombre, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), fec_nac)), '%Y') + 0 AS edad
FROM socio;

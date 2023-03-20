/*EJERCICIO 1*/
/*Mostrar la media de los precios de las reservas por cada cliente, 
visualizando por cada uno,nombre del cliente y la media de sus reservas 
con un redondeo hacia arriba de dos decimales(cuya columna debe 
llamarse MEDIA), ordenada ascendentemente por dicha media.*/
SELECT round(avg(r.precio_total),2) AS MEDIA,c.nombre FROM reserva r 
JOIN cliente c ON c.cod_cliente=r.cod_cliente
GROUP BY c.cod_cliente
ORDER BY MEDIA ASC;

/*EJERCICIO 2*/
/*Mostrar el numero de veces que un coche se ha reservado (llamada 
TOTAL RESERVAS COCHE).Si hay coches que no se han reservado tambien 
deben aparecer.*/
SELECT count(i.numero) AS 'TOTAL RESERVAS COCHE',c.* FROM coche c
LEFT JOIN incluye i ON c.matricula=i.matricula
GROUP BY c.matricula;


/*EJERCICIO 3*/
/*Nombre de los clientes(sin repetir) que han reservado un "Ibiza".*/
SELECT DISTINCT cl.nombre FROM cliente cl
JOIN reserva r ON cl.cod_cliente=r.cod_cliente
JOIN incluye i ON i.numero=r.numero
JOIN coche c ON i.matricula=c.matricula
WHERE modelo LIKE 'Ibiza';

/*EJERCICIO 4*/
/*Precio total de las reservas realizadas de menos de 8 dias.*/
SELECT precio_total FROM reserva
WHERE datediff(fecha_fin,fecha_inicio)<8;


/*EJERCICIO 5*/
/*Total de los precios de las reservas(llamada TOTAL RESERVAS) 
realizadas por cada matricula de coche, visualizando la matricula.*/
SELECT SUM(r.precio_total) AS 'TOTAL RESERVAS' FROM reserva r
JOIN incluye i ON i.numero=r.numero
JOIN coche c ON c.matricula=i.matricula
GROUP BY c.matricula;

SELECT i.MATRICULA, SUM(r.PRECIO_TOTAL) AS 'TOTAL RESERVAS'
FROM INCLUYE i
JOIN RESERVA r ON i.NUMERO = r.NUMERO
GROUP BY i.MATRICULA;


/*EJERCICIO 6*/
/*Total de los precios de las reservas(llamada TOTAL RESERVAS) 
realizadas por cada matricula de coche pero solamente de los mayores 
de 600, visualizando la matricula.*/
SELECT i.MATRICULA, SUM(r.PRECIO_TOTAL) AS 'TOTAL RESERVAS'
FROM INCLUYE i
JOIN RESERVA r ON i.NUMERO = r.NUMERO
GROUP BY i.MATRICULA
HAVING SUM(r.PRECIO_TOTAL) > 600;

/*EJERCICIO 7*/
/*Mostrar sin repetir los coches(marca, modelo y precio por dia) cuyo 
precio de reserva esté comprendido entre 200 y 500, ordenados por marca 
de coche descendente y modelo ascendente.*/
SELECT DISTINCT c.marca,c.modelo,c.precio_dia,r.precio_total  from coche c
JOIN incluye i ON c.matricula=i.matricula
JOIN reserva r ON i.numero=r.numero
WHERE r.precio_total BETWEEN 200 AND 500
ORDER BY c.marca DESC,c.modelo ASC;

/*EJERCICIO 8*/
/*Marca y Modelo de los coches que no han sido reservados ninguna vez.*/
SELECT DISTINCT c.marca,c.modelo FROM coche c
JOIN incluye i ON c.matricula=i.matricula;

/*EJERCICIO 9*/
/*Obtener el nombre del cliente que termina en 'a' o que hayan reservado 
por un precio mayor de 400€ y que dicha reserva haya durado más 
de 10 dias.*/
SELECT cl.nombre FROM cliente cl 
JOIN reserva r ON cl.cod_cliente=r.cod_cliente
WHERE cl.nombre LIKE '%a' AND precio_total>400 
AND datediff(fecha_fin,fecha_inicio)>10;

/*EJERCICIO 10*/
/*Mostrar el dni y el nombre del cliente, fecha de inicio de la 
reserva (con formato "Comienza el dia 01 de January de 2022") con 
el nombre de columna "Fin" que se ha reservado un coche de color 
rojo en el ultimo año.*/
SELECT DISTINCT cl.dni,cl.nombre,
date_format(r.fecha_inicio,'Comienza el dia %d de %M de %Y') AS Fin 
from cliente cl
JOIN reserva r ON cl.cod_cliente=r.cod_cliente
JOIN incluye i ON r.numero=i.numero
JOIN coche c ON i.matricula=c.matricula
WHERE c.color LIKE 'ROJO' AND r.fecha_inicio LIKE '2023%';
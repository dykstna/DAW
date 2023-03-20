
use ventas;

/*EJERCICIO 1*/
SELECT * FROM proyecto;

/*EJERCICIO 2*/
SELECT * FROM proyecto WHERE ciudad LIKE "Londres";

/*EJERCICIO 3*/
/*Obtener los códigos de las piezas suministradas por el proveedor s2, ordenados.*/
SELECT * FROM pieza,proveedor WHERE codpro IN(
    SELECT codpro from proveedor WHERE codpro="s2"
    );

/*EJERCICIO 4*/
/*Obtener los códigos de los proveedores del proyecto j1, ordenados.*/
SELECT pr.* FROM proveedor pr,proyecto py WHERE py.codpj LIKE "j1";

SELECT pr.* FROM proveedor pr,proyecto py WHERE py.codpj IN(
    SELECT codpj FROM proyecto WHERE codpj LIKE "j1"
    );

/*EJERCICIO 5*/
/*Obtener todas las ocurrencias p.color, p.ciudad eliminando los pares duplicados.*/
SELECT p.color,p.ciudad FROM pieza p,proveedor,proyecto
GROUP BY p.color,p.ciudad;

SELECT DISTINCT p.color,p.ciudad FROM pieza p,proveedor,proyecto;

/*EJERCICIO 6*/
/*Obtener los códigos de los cargamentos en los que la cantidad no sea nula.*/
SELECT codpie FROM pieza,ventas WHERE cantidad NOT IN(
    SELECT cantidad from ventas)
    ;

/*EJERCICIO 7*/
/*Obtener códigos de los proyectos y ciudades en las que la ciudad del proyecto 
tenga una 'o' en la segunda letra.*/
SELECT codpj,ciudad FROM proyecto WHERE ciudad LIKE '_o%';

/*EJERCICIO 8*/
/*Obtener un listado ascendente de los nombres de las piezas con más de 5 letras.*/
SELECT * FROM pieza WHERE LENGTH(nompie)>5
ORDER BY nompie ASC;

/*EJERCICIO 9*/
/*Obtener nombres abreviados de proyectos tomando sus primeras 3 letras.*/
SELECT LEFT(nompj,3) FROM proyecto;

/*EJERCICIO 10*/
/*Obtener los tres últimos caracteres de los nombres de proveedores 
por orden alfabético.*/
SELECT RIGHT(nompro,3),nompro FROM proveedor
ORDER BY nompro;

/*EJERCICIO 11*/
/*Hallar cuántas piezas distintas existen.*/
SELECT *,codp from pieza,ventas
WHERE codpie=codp;

/*EJERCICIO 12*/
/*Hallar cuántas piezas distintas existen dando nombre a la columna resultante Número.*/
SELECT count(codpie) AS Numero from pieza,ventas
WHERE codpie=codp;

/*EJERCICIO 13*/
/*Obtener el número total de proyectos suministrados por el proveedor sl.*/
SELECT p.*,v.cantidad from proyecto p,ventas v
WHERE p.codpj=v.codpj
AND codpro LIKE "s1";

/*EJERCICIO 14*/
/*Obtener la cantidad total de piezas p1 suministrada por s1.*/
SELECT COUNT(p.codpie) FROM pieza p,ventas v
WHERE p.codpie=v.codp
AND codpie LIKE "p1"
AND codpro IN(
    SELECT codpro FROM proveedor WHERE codpro LIKE "s1"
    );

/*EJERCICIO 15*/
/*Obtener la cantidad media de piezas suministradas, cantidad máxima y mínima
suministrada.*/
SELECT DISTINCT * FROM pieza pz 
RIGHT JOIN ventas v ON pz.codpie=codp;

/*EJERCICIO 16*/
/*Obtener los cargamentos en los que la cantidad de piezas esté 
entre 300 y 750 inclusive.*/
SELECT * FROM ventas WHERE cantidad BETWEEN 300 AND 750;

/*EJERCICIO 17*/
/*Construir una consulta que devuelva cod_p y VERDADERO si 
en la tabla piezas el color de la pieza no es ni azul ni gris.*/
SELECT codpie,'verdadero' FROM pieza where codpie IN(
    SELECT codpie from pieza
    WHERE color like "azul" or color like "gris")
    ;

/*EJERCICIO 18*/
/*Añade una nueva columna llamada fecha que indique la fecha de 
adquisición de una pieza por proveedor y proyecto.*/
ALTER TABLE ventas ADD fecha Date;


/*EJERCICIO 19*/
/*Modificar la fecha de adquisición de todas las piezas p2 a la fecha actual.*/
UPDATE ventas
SET fecha = CURRENT_DATE()
WHERE codp LIKE 'p2';

/*EJERCICIO 20*/
/*Se desea visualizar la fecha con formato del ejemplo ’11-NOV-2002’.*/
SELECT date_format(fecha,'%d-%b-%Y') AS Fecha FROM ventas;

/*EJERCICIO 21*/
/*Modificar la fecha de adquisición en los que participan los proyectos j1 y j2 a la fecha 12-11-2001 .*/
UPDATE ventas
SET fecha = '2001-11-12'
WHERE codp IN (
    SELECT codpj FROM proyecto py WHERE codpj IN('j1','j2')
    );

/*EJERCICIO 22*/
/*Construir una lista ordenada de todas las ciudades en las que al menos 
resida un suministrador, una pieza o un proyecto.*/
SELECT ciudad FROM (
  SELECT ciudad FROM proveedor
  UNION
  SELECT ciudad FROM pieza
  UNION
  SELECT ciudad FROM proyecto
) AS ciudades
GROUP BY ciudad
ORDER BY ciudad;

/*EJERCICIO 23*/
SELECT DISTINCT p.* FROM pieza p,proveedor;

/*EJERCICIO 24*/
/*Obtener todos los posibles tríos de código de proveedor, código de pieza y 
código de proyecto en los que el proveedor, pieza y proyecto estén en la 
misma ciudad.*/
SELECT DISTINCT pv.codpro,p.codpie,py.codpj FROM ventas v,proveedor pv 
JOIN pieza p ON p.ciudad=pv.ciudad
JOIN proyecto py ON py.ciudad=p.ciudad;


/*EJERCICIO 25*/
SELECT DISTINCT pv.codpro,p.codpie,py.codpj FROM ventas v,proveedor pv 
JOIN pieza p ON p.ciudad=pv.ciudad
JOIN proyecto py ON py.ciudad=p.ciudad;


/*EJERCICIO 26*/
/*Obtener todos los posibles tríos de código de proveedor, código de pieza 
y código de proyecto en los que el proveedor, pieza y proyecto no estén 
todos en la misma ciudad.*/
SELECT DISTINCT pv.codpro,p.codpie,py.codpj FROM pieza p,proveedor pv,proyecto py
WHERE ciudad NOT IN(
    SELECT ciudad FROM pieza p,proveedor pv 
    JOIN proyecto py ON py.ciudad=p.ciudad
);

/*EJERCICIO 27*/
/* Obtener todos los posibles tríos de código de proveedor, código de pieza y 
código de proyecto en los que el proveedor, pieza y proyecto no estén ninguno 
en la misma ciudad.*/
SELECT v.codpro,v.codp,v.codpj FROM ventas v
JOIN proveedor p ON v.codpro=p.codpro
JOIN pieza pz ON v.codp=pz.codpie
JOIN proyecto py ON v.codpj=py.codpj
WHERE p.ciudad<>pz.ciudad AND pz.ciudad<>py.ciudad AND p.ciudad<>py.ciudad;


/*EJERCICIO 28*/
/*Obtener los códigos de las piezas suministradas por proveedores de Londres.*/
SELECT codpro FROM ventas WHERE codpro IN(
    SELECT codpro FROM proveedor WHERE ciudad like 'Londres'
    );

/*EJERCICIO 29*/
/* Obtener los códigos de las piezas suministradas por proveedores de Londres 
a proyectos en Londres.*/
SELECT pz.codpie FROM pieza pz 
JOIN ventas v ON pz.codpie=v.codp
JOIN proveedor pv ON pv.codpro=v.codpro
JOIN proyecto py ON py.codpj=v.codpj
WHERE pv.ciudad LIKE 'Londres' AND py.ciudad LIKE 'Londres';

SELECT v.codp FROM ventas v
INNER JOIN proveedor p ON v.codpro = p.codpro
INNER JOIN proyecto pj ON v.codpj = pj.codpj
WHERE p.ciudad = 'Londres' AND pj.ciudad = 'Londres';

/*EJERCICIO 30*/
/*Obtener todos los pares de nombres de ciudades en las que un proveedor de 
la primera sirva a un proyecto de la segunda.*/
SELECT DISTINCT pv.ciudad,py.ciudad FROM ventas v
JOIN proyecto py ON v.codpj=py.codpj
JOIN proveedor pv ON v.codpro=pv.codpro;


/*EJERCICIO 31*/
/*Obtener códigos de piezas que sean suministradas a un proyecto por un 
proveedor de la misma ciudad del proyecto.*/
SELECT DISTINCT v.codp FROM ventas v
JOIN proyecto py ON py.codpj=v.codpj
JOIN proveedor pv ON pv.codpro=v.codpro
where py.ciudad=pv.ciudad;


/*EJERCICIO 32*/
/*Obtener códigos de proyectos que sean suministrados por un proveedor de una 
ciudad distinta a la del proyecto. Visualizar el código de proveedor 
y el del proyecto.*/
SELECT DISTINCT py.codpj FROM proyecto py
JOIN ventas v ON v.codpj=py.codpj
JOIN proveedor pv ON pv.codpro=v.codpro
WHERE py.ciudad<>pv.ciudad;

/*EJERCICIO 33*/
/* Obtener todos los pares de códigos de piezas suministradas por el mismo 
proveedor.*/
SELECT DISTINCT v.codp,codpie FROM ventas v
JOIN pieza pz ON pz.codpie=v.codp
JOIN proveedor pv ON pv.codpro=v.codpro;

/*EJERCICIO 34*/
/*Obtener todos los pares de códigos de piezas suministradas por el mismo 
proveedor.(eliminar pares repetidos)*/
SELECT DISTINCT v.codp,codpie FROM ventas v
JOIN pieza pz ON pz.codpie=v.codp
JOIN proveedor pv ON pv.codpro=v.codpro;

/*EJERCICIO 35*/
/*Obtener para cada pieza suministrada a un proyecto, el código de pieza, 
el código de proyecto y la cantidad total correspondiente.*/
SELECT pz.codpie,py.codpj,SUM(v.cantidad) AS 'Cantidad Total' FROM pieza pz
JOIN ventas v ON v.codp=pz.codpie
JOIN proyecto py ON v.codpj=py.codpj
GROUP BY pz.codpie,py.codpj;

/*EJERCICIO 36*/
/*Obtener los códigos de proyectos y los códigos de piezas en los que la 
cantidad media suministrada a algún proyecto sea superior a 320.*/
SELECT py.codpj,codp FROM proyecto py
JOIN ventas v ON v.codpj=py.codpj
GROUP BY py.codpj,codp
HAVING avg(cantidad)>320;


/*EJERCICIO 37*/
/* Obtener un listado ascendente de los nombres de todos los proveedores 
que hayan suministrado una cantidad superior a 100 de la pieza p1. 
Los nombres deben aparecer en mayúsculas.*/
SELECT upper(pv.nompro) AS 'Nombre Proveedores' FROM proveedor pv
JOIN ventas v ON v.codpro=pv.codpro
WHERE codp LIKE 'p1' AND cantidad>100
ORDER BY nompro ASC;


/*EJERCICIO 38*/
/* Obtener los nombres de los proyectos a los que suministra s1.*/
SELECT DISTINCT py.nompj AS 'Nombre Proveedores' FROM proveedor pv
JOIN ventas v ON v.codpro=pv.codpro
JOIN proyecto py ON py.codpj=v.codpj
WHERE pv.codpro LIKE 's1';  


/*EJERCICIO 39*/
/* Obtener los colores de las piezas suministradas por s1.*/
SELECT DISTINCT pv.codpro,pz.color FROM proveedor pv
JOIN ventas v ON v.codpro=pv.codpro
JOIN pieza pz ON pz.codpie=v.codp
WHERE pv.codpro LIKE 'S1';


/*EJERCICIO 40*/
/* Obtener los códigos de las piezas suministradas a cualquier 
proyecto de Londres.*/
SELECT DISTINCT pz.codpie,py.ciudad FROM pieza pz
JOIN ventas v ON pz.codpie=v.codp
JOIN proyecto py ON py.codpj=v.codpj
WHERE py.ciudad LIKE 'Londres';


/*EJERCICIO 41*/
/* Obtener los códigos de los proveedores con estado menor que s1.*/
SELECT pv.codpro FROM proveedor pv WHERE pv.status > IN(
    SELECT pv.codpro FROM proveedor pv WHERE pv.codpro LIKE 'S1'
    );


/*EJERCICIO 42*/
/* Obtener los códigos de los proyectos que usen la pieza pl en una 
cantidad media mayor que la mayor cantidad en la que cualquier 
pieza sea suministrada al proyecto j1.*/
SELECT codpro FROM proveedor
WHERE status < (
    SELECT status FROM proveedor WHERE codpro LIKE 'S1'
    );


/*EJERCICIO 43/
/*Obtener códigos de proveedores que suministren a algún proyecto la 
pieza p1 en una cantidad mayor que la cantidad media en la que se 
suministra la pieza p1 a dicho proyecto.*/
SELECT v.codpro,v.cantidad FROM ventas v
WHERE v.codp = 'P1' AND v.cantidad > (
    SELECT AVG(cantidad) FROM ventas WHERE codp = 'P1');


/*EJERCICIO 44*/
/* Obtener los códigos de los proyectos que usen al menos una pieza 
suministrada por s1.*/
SELECT DISTINCT py.codpj from proyecto py
JOIN ventas v ON py.codpj=v.codpj
WHERE v.codpro LIKE 'S1';


/*EJERCICIO 45*/
/* Obtener los códigos de los proveedores que suministren al menos 
una pieza por un proveedor que suministre al 
menos una pieza roja.*/
SELECT DISTINCT pv.codpro FROM proveedor pv
JOIN ventas v ON pv.codpro=v.codpro
JOIN pieza pz ON v.codp=pz.codpie
WHERE pz.color LIKE 'rojo';


/*EJERCICIO 46*/
/*Obtener los códigos de las piezas suministradas a cualquier proyecto 
de Londres usando EXISTS.*/
SELECT DISTINCT v.codp FROM ventas v where EXISTS(
    SELECT * from proyecto p 
    WHERE v.codpj=p.codpj AND ciudad='Londres'
    );


/*EJERCICIO 47*/
/* Obtener los códigos de los proyectos que usen al menos una pieza 
suministrada por s1 usando EXISTS.*/
SELECT DISTINCT v.codpj FROM ventas v WHERE EXISTS(
    SELECT codpie FROM pieza WHERE v.codpro LIKE 's1'
    );


/*EJERCICIO 48*/
/*Obtener los códigos de los proyectos que no reciban ninguna pieza 
roja suministrada por algún proveedor de Londres.*/
SELECT py.codpj FROM proyecto py
WHERE py.codpj NOT IN (
    SELECT DISTINCT v.codpj FROM ventas v
    JOIN proveedor p ON v.codpro = p.codpro
    JOIN pieza pz ON v.codp = pz.codpie
    WHERE pz.color LIKE 'rojo' AND p.ciudad LIKE 'Londres'
);


/*EJERCICIO 49*/
/* Obtener los códigos de los proyectos suministrados 
únicamente por s1.*/
SELECT DISTINCT v.codpj FROM ventas v
JOIN proveedor pv ON v.codpro=pv.codpro
WHERE pv.codpro LIKE 's1';


/*EJERCICIO 50*/
/* Obtener los códigos de las piezas suministradas a todos los 
proyectos en Londres.*/
SELECT DISTINCT v.codpj FROM ventas v
JOIN proyecto py ON v.codpj=py.codpj
WHERE py.ciudad LIKE 'Londres';


/*EJERCICIO 51*/
/* Obtener los códigos de los proveedores que suministren la misma 
pieza todos a los proyectos.*/


/*EJERCICIO 52*/
/*Obtener los códigos de los proyectos que reciban al menos todas las 
piezas que suministra s1.*/


/*EJERCICIO 53*/
/* Cambiar el color de todas las piezas rojas a naranja.*/
UPDATE pieza SET color = 'naranja'
WHERE color = 'rojo';


/*EJERCICIO 54*/
/*Borrar todos los proyectos para los que no haya cargamentos.*/
DELETE FROM proyecto
WHERE codpj NOT IN (
    SELECT codpj FROM ventas
    );


/*EJERCICIO 55*/
/*Borrar todos los proyectos en Roma y sus correspondientes 
cargamentos.*/
DELETE FROM ventas
WHERE codpj IN (SELECT codpj FROM proyecto WHERE ciudad = 'Roma');

DELETE FROM proyecto WHERE ciudad LIKE 'Roma';

/*EJERCICIO 56*/
/* Insertar un nuevo suministrador s6 en la tabla proveedor. 
El nombre y la ciudad son 'White'y ‘New York' respectivamente. 
El estado no se conoce todavía.*/
INSERT INTO proveedor 
VALUES ('S6', 'white', null, 'New York');


/*EJERCICIO 57*/
/*Construir una tabla conteniendo una lista de los códigos de las 
piezas suministradas a proyectos en Londres o suministradas por un 
suministrador de Londres.*/
CREATE TABLE piezas_londres AS
SELECT DISTINCT p.codpie FROM pieza p
JOIN ventas v ON p.codpie = v.codp
JOIN proyecto pr ON v.codpj = pr.codpj
JOIN proveedor pv ON v.codpro = pv.codpro
WHERE pr.ciudad = 'Londres' OR pv.ciudad = 'Londres';

SELECT * FROM piezas_londres;

/*EJERCICIO 58*/
/*Construir una tabla conteniendo una lista de los códigos de los 
proyectos de Londres o que tengan algún suministrador de Londres.*/
SELECT codpj FROM proyecto WHERE ciudad LIKE 'Londres' AND codpj in(
    SELECT codpj FROM ventas WHERE codpro in(
        SELECT codpro from proveedor WHERE ciudad like 'Londres'
    ));


/*EJERCICIO 59*/
/*Listar las tablas y secuencias definidas por el usuario ZEUS.*/


/*EJERCICIO Extra 1*/
/*Muestra el nombre y ciudad de los proveedores que han vendido alguna pieza 
a un proyecto en la misma ciudad que ellos.*/
SELECT nompro, ciudad
FROM proveedor WHERE ciudad IN (
    SELECT ciudad FROM pieza WHERE codpie IN (
        SELECT codp FROM ventas
        WHERE codpro = proveedor.codpro
    )
) AND ciudad IN (
    SELECT ciudad FROM proyecto WHERE codpj IN (
        SELECT codpj FROM ventas
        WHERE codpro = proveedor.codpro
    )
);

/*EJERCICIO Extra 2*/
/*Encuentra los proveedores que no han realizado ventas en el proyecto 'J4'.*/
SELECT nompro FROM proveedor WHERE codpro NOT IN (
    SELECT codpro FROM ventas WHERE codpj = 'J4'
    );

/*EJERCICIO Extra 3*/
/*Queremos obtener el nombre del proveedor, el nombre del proyecto y la 
cantidad vendida para todas las ventas donde la ciudad del 
proveedor sea Madrid.*/
SELECT p.nompro, j.nompj, v.cantidad
FROM ventas v
JOIN proveedor p ON p.codpro = v.codpro
JOIN proyecto j ON j.codpj = v.codpj
WHERE p.ciudad = 'Madrid';

/*EJERCICIO Extra 4*/
/*Calcular el precio total de ventas por proveedor. Suponiendo que cada 
pieza tiene un precio unitario de 5 euros, ¿cuál es el Precio total de ventas 
para cada proveedor?*/
SELECT p.codpro, p.nompro, SUM(v.cantidad*5) AS 'Precio Total' 
FROM ventas v
INNER JOIN pieza ON v.codp = pieza.codpie
INNER JOIN proveedor p ON v.codpro = p.codpro
GROUP BY p.codpro
ORDER BY p.codpro;

/*EJERCIICIO EXTRA 5*/
/*Crear una vista que almacene la ciudad de las piezas vendidas*/
CREATE OR REPLACE VIEW piezas_ciudad AS
SELECT p.codpie, p.ciudad AS ciudad_pieza, v.cantidad, pr.ciudad AS ciudad_proveedor, pj.ciudad AS ciudad_proyecto
FROM ventas v
JOIN pieza p ON v.codp = p.codpie
JOIN proveedor pr ON v.codpro = pr.codpro
JOIN proyecto pj ON v.codpj = pj.codpj;

SELECT * FROM piezas_ciudad;


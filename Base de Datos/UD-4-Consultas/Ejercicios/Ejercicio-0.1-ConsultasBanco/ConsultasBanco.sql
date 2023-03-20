
/*EJERCICIO 1*/
/*Seleccione los nombres y apellidos de los clientes que 
tienen una cuenta con un saldo superior a 50000.*/
SELECT nombre,apellidos FROM cliente WHERE cod_cliente in(
    SELECT cod_cliente FROM cuenta WHERE saldo>50000
    );


/*EJERCICIO 2*/
/*Seleccione los codigos de las sucursales que no tienen 
ninguna cuenta con un saldo negativo.*/
SELECT cod_sucursal,direccion from sucursal where cod_sucursal IN(
    SELECT cod_sucursal FROM cuenta where saldo>=0
    );


/*EJERCICIO 3*/
/*Seleccione los nombres y apellidos de los clientes que 
tienen al menos una cuenta con un saldo menor a 4000.*/
SELECT nombre,apellidos FROM cliente WHERE cod_cliente IN(
    SELECT cod_cliente FROM cuenta WHERE saldo<4000
    );


/*EJERCICIO 4*/
/*Seleccione los codigos de las sucursales que tienen 
al menos una cuenta con un saldo superior a 50000.*/
SELECT cod_sucursal FROM sucursal WHERE cod_sucursal IN(
    SELECT cod_sucursal FROM cuenta where saldo>50000
    );


/*EJERCICIO 5*/
/*Seleccione los nombres y apellidos de los clientes que 
tienen una cuenta en una sucursal cuya capital del año 
anterior fue inferior a 100000.*/
SELECT nombre,apellidos FROM cliente where cod_cliente IN(
    SELECT cod_cliente FROM cuenta WHERE cod_sucursal IN(
    SELECT cod_sucursal FROM sucursal WHERE capital_anio_anterior<100000
    ));


/*EJERCICIO 6*/
/*Seleccione los nombres y apellidos de los clientes que 
tienen una cuenta en una sucursal cuya capital del año 
anterior fue inferior a la capital promedio del año 
anterior de todas las sucursales.*/
SELECT nombre,apellidos,s.cod_sucursal FROM cliente ct 
JOIN cuenta c ON ct.cod_cliente=c.cod_cliente
JOIN sucursal s ON s.cod_sucursal=c.cod_sucursal
WHERE s.capital_anio_anterior <(
    SELECT avg(capital_anio_anterior) FROM sucursal
    WHERE capital_anio_anterior IS NOT NULL
    );

/*EJERCICIO 7*/
/*Seleccione la direccion de las sucursales que tienen más 
de 2 cuentas con un saldo superior a 20000.*/
SELECT DIRECCION FROM SUCURSAL WHERE COD_SUCURSAL IN (
    SELECT COD_SUCURSAL FROM CUENTA WHERE SALDO > 20000
    GROUP BY COD_SUCURSAL
    HAVING COUNT(*) > 2
    );



/*EJERCICIO 8*/
/*Seleccione los nombres y apellidos de los clientes que 
tienen más de una cuenta con un saldo superior a 10000.*/
SELECT nombre,apellidos FROM cliente WHERE cod_cliente in(
    SELECT cod_cliente FROM cuenta WHERE saldo>10000
    GROUP BY cod_cliente
    HAVING count(*)>1
    );


/*EJERCICIO 9*/
/*Seleccione los nombres y apellidos de los clientes que 
no tienen ninguna cuenta con un movimiento de salida.*/
SELECT DISTINCT nombre,apellidos FROM cliente c
JOIN cuenta ct ON c.cod_cliente=ct.cod_cliente
JOIN movimiento m on m.cod_cuenta=ct.cod_cuenta
JOIN TIPO_MOVIMIENTO tm on m.cod_tipo_movimiento=tm.cod_tipo_movimiento
where salida IS NULL OR salida like 'No';



/*EJERCICIO 10*/
/*Seleccione las direcciones de las sucursales que tienen 
al menos una cuenta con un movimiento de salida en el mes 
de febrero.*/
SELECT DIRECCION FROM SUCURSAL WHERE COD_SUCURSAL IN (
    SELECT COD_SUCURSAL FROM CUENTA WHERE COD_CUENTA IN (
        SELECT COD_CUENTA FROM MOVIMIENTO
        WHERE month(fecha_hora) = 2 AND COD_TIPO_MOVIMIENTO IN (
            SELECT COD_TIPO_MOVIMIENTO FROM TIPO_MOVIMIENTO
            WHERE SALIDA = 'Si'
            )));


/*EJERCICIO 11*/
/*Seleccione el nombre y el apellido de los clientes que 
tienen al menos una cuenta con un saldo mayor al promedio 
de los saldos de todas las cuentas de la sucursal en la que 
se encuentran.*/
SELECT nombre,apellidos FROM cliente WHERE cod_cliente in(
    SELECT cod_cliente FROM cuenta WHERE saldo>(
        SELECT avg(saldo) FROM cuenta WHERE cod_sucursal in(
            SELECT COD_SUCURSAL FROM SUCURSAL)));


/*EJERCICIO 12*/
/*Seleccione la dirección de las sucursales que tienen al 
menos una cuenta que no ha tenido movimientos de salida.*/
SELECT direccion from sucursal WHERE cod_sucursal in(
    SELECT cod_sucursal FROM cuenta WHERE cod_cuenta in(
        SELECT cod_cuenta FROM movimiento WHERE cod_tipo_movimiento in(
            SELECT cod_tipo_movimiento FROM TIPO_MOVIMIENTO
            WHERE salida like 'No')));


/*EJERCICIO 13*/
/*Seleccione el nombre y el apellido de los clientes que 
tienen al menos una cuenta con un interés mayor al promedio 
de los intereses de todas las cuentas en la misma sucursal.*/
SELECT DISTINCT nombre,apellidos FROM cliente ct 
join cuenta c on c.cod_cliente=ct.cod_cliente
join sucursal s on s.COD_SUCURSAL=c.cod_sucursal
where c.interes >(
    SELECT avg(c2.interes) from cuenta c2
    WHERE c.cod_sucursal=c2.cod_sucursal
    );
-----------------------------------------------------------

SELECT nombre, apellidos FROM cliente 
WHERE cod_cliente IN (
    SELECT cod_cliente FROM cuenta c1 WHERE c1.interes > (
        SELECT AVG(c2.interes) FROM cuenta c2 
        WHERE c2.cod_sucursal = c1.cod_sucursal
    )
);


/*EJERCICIO 14*//*PREGUNTAR*/
/*Seleccione el número de cuenta y el saldo de las cuentas 
que tuvieron movimientos de salida en el mismo mes en que 
se registró el mayor importe de un movimiento.*/
SELECT DISTINCT c.cod_cuenta,c.saldo from cuenta c
JOIN movimiento m on m.cod_cuenta=c.cod_cuenta
JOIN TIPO_MOVIMIENTO tm on tm.cod_tipo_movimiento=m.cod_tipo_movimiento
where tm.salida LIKE 'Si' AND m.FECHA_HORA in(
    SELECT m2.fecha_hora from m2.movimiento)
    where month(m.fecha_hora)=month(m2.fecha_hora
    GROUP BY m2.cod_cuenta
    HAVING max(c.importe)>0
    );




/*EJERCICIO 15*//*PREGUNTAR*/
/*Seleccione el nombre y el apellido de los clientes que 
tienen al menos una cuenta con un saldo inferior a 5000 y que no 
han realizado ningún movimiento en los últimos 30 días.*/
SELECT nombre,apellidos from cliente ct
JOIN cuenta c on c.cod_cliente=ct.cod_cliente
where c.saldo<5000 AND c.cod_cuenta in(
    SELECT cod_cuenta FROM movimiento WHERE FECHA_HORA in(
        SELECT fecha_hora FROM movimiento
        where datediff(curdate(),FECHA_HORA)<=30
        ));


/*EJERCICIO 16*/
/*Seleccione el número de cuenta y el importe del movimiento 
más grande registrado en cada cuenta.*/
SELECT COD_CUENTA,MAX(IMPORTE) FROM MOVIMIENTO
GROUP BY COD_CUENTA;



/*EJERCICIO 17*/
/*Seleccione la dirección de las sucursales que tienen más de 
una cuenta con movimientos en el mes de febrero.*/
SELECT s.direccion FROM sucursal s
JOIN cuenta c on c.cod_sucursal=s.cod_sucursal
WHERE s.cod_sucursal IN(
    SELECT cod_sucursal FROM cuenta WHERE cod_cuenta IN(
        SELECT cod_cuenta FROM movimiento WHERE month(fecha_hora)
        AND COD_TIPO_MOVIMIENTO IN(
            SELECT COD_TIPO_MOVIMIENTO FROM TIPO_MOVIMIENTO
            WHERE Salida LIKE 'Si'
            )))
GROUP BY s.cod_sucursal
HAVING COUNT(c.cod_cuenta)>1;




/*EJERCICIO 18*/
/*Seleccione el número de cuenta y la cantidad de movimientos 
realizados en cada cuenta.*/




/*EJERCICIO 19*/
/*Seleccione el número de cuenta y el saldo actual de las cuentas 
que tuvieron movimientos de entrada en los últimos 7 días.*/




/*EJERCICIO 20*/
/*Seleccione el nombre y el apellido de los clientes que tienen 
al menos una cuenta en una sucursal donde el capital del año 
anterior es mayor al capital del año anterior de cualquier 
otra sucursal.*/


/*EJERCICIO 21*/
/*Mostrar el saldo medio de todas las cuentas de la 
entidad bancaria.*/
SELECT round(AVG(saldo),2) FROM cuenta;

/*EJERCICIO 22*/
/*Mostrar la suma de los saldos de todas las cuentas 
bancarias.*/
SELECT round(sum(saldo),2) FROM cuenta;

/*EJERCICIO 23*/
/*Mostrar el saldo mínimo, máximo y medio de todas las 
cuentas bancarias.*/
SELECT min(saldo),max(saldo),round(avg(saldo),2) FROM cuenta;


/*EJERCICIO 24*/
/*Mostrar la suma de los saldos y el saldo medio de las 
cuentas bancarias agrupadas por su código de sucursal.*/
SELECT sum(saldo),round(avg(saldo),2) FROM cuenta
GROUP BY cod_sucursal;


/*EJERCICIO 25*/
/*Para cada cliente del banco se desea conocer su código, 
la cantidad total que tiene depositada en la entidad 
y el número de cuentas abiertas.*/
SELECT ct.cod_cliente,sum(c.saldo), count(c.cod_cuenta) FROM cliente ct
JOIN cuenta c on c.cod_cliente=ct.cod_cliente
GROUP BY cod_cliente;


/*EJERCICIO 26*/
/*Retocar la consulta anterior para que aparezca el nombre 
y apellidos de cada cliente en vez de su código de cliente.*/
SELECT ct.nombre,ct.apellidos,sum(c.saldo), count(c.cod_cuenta) FROM cliente ct
JOIN cuenta c on c.cod_cliente=ct.cod_cliente
GROUP BY ct.cod_cliente;


/*EJERCICIO 27*/
/*Para cada sucursal del banco se desea conocer su 
dirección, el número de cuentas que tiene abiertas y 
la suma total que hay en ellas.*/
SELECT s.direccion,count(c.cod_cuenta),sum(c.saldo) FROM sucursal s
LEFT JOIN cuenta c ON c.cod_sucursal=s.cod_sucursal
GROUP BY s.cod_sucursal;


/*EJERCICIO 28*/
/*Mostrar el saldo medio y el interés medio de las 
cuentas a las que se le aplique un interés mayor del 10%, 
de las sucursales 1 y 2.*/
SELECT avg(saldo),avg(interes) FROM cuenta
WHERE cod_sucursal in(1,2) AND interes>0.1 
GROUP BY cod_sucursal;


/*EJERCICIO 29*/
/*Mostrar los tipos de movimientos de las cuentas bancarias, 
sus descripciones y el volumen total de dinero que se 
manejado en cada tipo de movimiento.*/
SELECT DISTINCT tm.cod_tipo_movimiento,tm.descripcion,sum(m.importe) FROM TIPO_MOVIMIENTO tm
JOIN movimiento m on m.cod_tipo_movimiento=tm.cod_tipo_movimiento
GROUP BY tm.cod_tipo_movimiento;

/*EJERCICIO 30*/
/*Mostrar cuál es la cantidad media que sacan de cajero 
los clientes de nuestro banco.*/
SELECT avg(m.importe) FROM movimiento m
JOIN tipo_movimiento tm on tm.cod_tipo_movimiento=m.cod_tipo_movimiento
WHERE descripcion LIKE '%cajero%';

/*EJERCICIO 31*/
/*Calcular la cantidad total de dinero que emite la entidad 
bancaria clasificada según los tipos de movimientos de 
salida.*/
SELECT sum(m.importe),tm.descripcion FROM movimiento m
JOIN tipo_movimiento tm on tm.cod_tipo_movimiento=m.cod_tipo_movimiento
WHERE tm.salida LIKE 'si'
GROUP BY tm.descripcion;


/*EJERCICIO 32*/
/*Calcular la cantidad total de dinero que ingresa cada 
sucursal clasificada según los tipos de movimientos 
de entrada.*/
SELECT sum(m.importe),s.cod_sucursal FROM movimiento m
JOIN tipo_movimiento tm on tm.cod_tipo_movimiento=m.cod_tipo_movimiento
JOIN cuenta c on c.cod_cuenta=m.cod_cuenta
join sucursal s on s.cod_sucursal=c.cod_sucursal
where salida like 'no'
GROUP BY s.cod_sucursal;


SELECT DISTINCT (
    SELECT sum(importe) FROM movimiento
    ) as Total_importe FROM sucursal
    GROUP BY cod_sucursal;


/*EJERCICIO 30*/
/*Modifica el campo fecha_hora al año actual*/
UPDATE movimiento
SET fecha_hora = date_format(now(),'%Y-%m-%d');


/*EJERCICIO 30*/
/*Modifica el campo fecha_hora para que el mes 
coincida con el campo mes*/
UPDATE movimiento
SET fecha_hora = date_add(fecha_hora,INTERVAL(mes - month(fecha_hora))month);


/*EJERCICIO 30*/
/*Añadir a la tabla clientes el campo fecha_cuenta con el año 1990
solo a los clientes con cod_sucursal igual a 1 y 3*/
ALTER TABLE cliente ADD COLUMN fecha_cuenta DATE;

UPDATE cliente
SET fecha_cuenta = '1990/01/01'
WHERE cod_cliente IN(
    SELECT cod_cliente FROM cuenta WHERE cod_sucursal IN(
        SELECT cod_sucursal FROM sucursal
        WHERE cod_sucursal IN (1, 3)
        ));

UPDATE cliente
SET fecha_cuenta = '1994/07/12'
WHERE cod_cliente IN(
    SELECT cod_cliente FROM cuenta WHERE cod_sucursal IN(
        SELECT cod_sucursal FROM sucursal
        WHERE cod_sucursal IN (5)
        ));


/*EJERCICIO 30*/
/*Actualizar la fecha_cuenta al año 1995 a los clientes 
con vaolr nulo*/
UPDATE cliente
SET fecha_cuenta ='1995-04-20'
WHERE fecha_cuenta IS NULL;

/*EJERCICIO 30*/
/*Añadir un nuevo cliente a la sucursal con cod_sucursal 5*/
INSERT INTO  cliente
SELECT 'CLUEPTO', 'Fernandez Gonzalez', 'Manuel', 'C/ Goya, 7' FROM cliente
WHERE cod_cliente IN(
    SELECT cod_cliente FROM cuenta where cod_sucursal IN(
        SELECT cod_sucursal FROM sucursal WHERE cod_sucursal=5));



/*EJERCICIO 30*/
/*EJERCICIO 30*/
/*EJERCICIO 30*/
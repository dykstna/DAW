/*USO JOIN BASICAS*/

/*EJERCICIO 1*/
SELECT cl.nombre,cl.apellidos FROM cliente cl 
JOIN cuenta c ON c.cod_cliente=cl.cod_cliente
JOIN sucursal s ON c.cod_sucursal=s.cod_sucursal
where s.cod_sucursal = 3;

/*EJERCICIO 2*/
SELECT saldo FROM cuenta c 
JOIN cliente ct ON c.cod_cliente=ct.cod_cliente
WHERE ct.apellidos LIKE '%G_mez%'; 

/*EJERCICIO 3*/
SELECT ct.nombre,s.direccion FROM cliente ct 
JOIN cuenta c ON ct.cod_cliente=c.cod_cliente
JOIN sucursal s ON c.cod_sucursal=s.cod_sucursal
WHERE c.cod_cuenta=131274;

/*EJERCICIO 4*/
SELECT DISTINCT cl.nombre,s.direccion FROM sucursal s 
JOIN cuenta c ON c.cod_sucursal=s.cod_sucursal
JOIN cliente cl ON cl.cod_cliente=c.cod_cliente;

/*EJERCICIO 5*/
SELECT c.COD_CUENTA, m.FECHA_HORA 
FROM MOVIMIENTO m 
INNER JOIN CUENTA c ON m.COD_CUENTA = c.COD_CUENTA 
INNER JOIN CLIENTE cl ON c.COD_CLIENTE = cl.COD_CLIENTE 
WHERE cl.COD_CLIENTE = 'ARUBIO' 
AND YEAR(m.FECHA_HORA) = 2007;

/*EJERCICIO 6*/
SELECT c.cod_cuenta,ct.nombre FROM cliente ct 
JOIN cuenta c ON c.cod_cliente=ct.cod_cliente
WHERE c.saldo = (
    SELECT MAX(saldo) FROM cuenta
    );

/*EJERCICIO 7*/
SELECT DISTINCT direccion FROM sucursal s 
JOIN cuenta c ON s.cod_sucursal=c.cod_sucursal
AND c.saldo<0;

/*EJERCICIO 8*/
SELECT ct.nombre,c.cod_cuenta,c.saldo FROM cliente ct 
JOIN cuenta c ON c.cod_cliente=ct.cod_cliente
WHERE saldo>10000 AND ct.apellidos LIKE "%P_rez%";

/*EJERCICIO 9*/
SELECT DISTINCT CONCAT(nombre," ",apellidos) AS "Nommbre Cliente",
s.direccion AS "Direcc. Sucursal" FROM cliente ct
JOIN cuenta c ON c.cod_cliente=ct.cod_cliente
JOIN sucursal s ON s.cod_sucursal=c.cod_sucursal;

/*EJERCICIO 10*/
SELECT * FROM tipo_movimiento WHERE salida like"Si";

/*EJERCICIO 11*/
SELECT COUNT(cod_cuenta) AS "Cantidas de Cuentas",s.cod_sucursal 
FROM cuenta c
JOIN sucursal s ON s.cod_sucursal=c.cod_sucursal
GROUP BY s.cod_sucursal;

SELECT s.DIRECCION, COUNT(*) AS TOTAL_CUENTAS
FROM SUCURSAL s
JOIN CUENTA cu ON s.COD_SUCURSAL = cu.COD_SUCURSAL
GROUP BY s.DIRECCION;

/*EJERCICIO 12*/
SELECT COUNT(*) AS "Numero de Movimientos",c.cod_cuenta 
FROM movimiento m
JOIN cuenta c ON c.cod_cuenta=m.cod_cuenta
GROUP BY c.cod_cuenta;

/*EJERCICIO 13*/
SELECT DISTINCT c.saldo,nombre FROM cuenta c
JOIN cliente ct ON ct.cod_cliente=c.cod_cliente
ORDER BY nombre;

/*EJERCICIO 14*/
SELECT DISTINCT m.cod_tipo_movimiento,m.importe,m.fecha_hora FROM movimiento m
JOIN cuenta c ON c.cod_cuenta=m.cod_cuenta
JOIN cliente ct ON ct.cod_cliente=c.cod_cliente
WHERE c.cod_cliente LIKE "ASOTILLO";

SELECT tm.DESCRIPCION, m.IMPORTE, m.FECHA_HORA
FROM CLIENTE c
JOIN CUENTA cu ON c.COD_CLIENTE = cu.COD_CLIENTE
JOIN MOVIMIENTO m ON cu.COD_CUENTA = m.COD_CUENTA
JOIN TIPO_MOVIMIENTO tm ON m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO
WHERE c.COD_CLIENTE = 'ASOTILLO';

/*EJERCICIO 15*/
SELECT ROUND(avg(c.saldo),2) AS "Saldo Medio" ,s.cod_sucursal
FROM cuenta c
JOIN sucursal s ON s.cod_sucursal=c.cod_sucursal
GROUP BY s.cod_sucursal;

/*EJERCICIO 16*/
SELECT ct.* FROM cliente ct 
LEFT JOIN cuenta c ON ct.cod_cliente=c.cod_cliente
WHERE c.cod_cuenta is NULL;

/*EJERCICIO 17*/
SELECT c.* FROM cuenta c
LEFT JOIN movimiento m ON c.cod_cuenta=m.cod_cuenta
WHERE m.cod_cuenta IS NULL;

/*EJERCICIO 18*/
SELECT c.cod_cuenta,sum(c.saldo) FROM cuenta c
JOIN cliente ct ON c.cod_cliente=ct.cod_cliente
GROUP BY c.cod_cliente;

/*----------------------------FUNCIONES-------------------------------*/
/*EJERCICIO 19*/
SELECT sum(importe) AS "Total importe Movimiento" FROM movimiento
WHERE cod_cuenta=121221;

/*EJERCICIO 20*/
SELECT round(avg(saldo),2) AS "Saldo Medio Cuentas" FROM cuenta
WHERE cod_cliente LIKE "FSANTOS";

/*EJERCICIO 21*/
SELECT COUNT(cod_cuenta) FROM cuenta
WHERE cod_cliente LIKE "FSANTOS";

/*EJERCICIO 22*/

/*EJERCICIO 23*/

/*EJERCICIO 24*/

/*EJERCICIO 25*/

/*EJERCICIO 26*/

/*EJERCICIO 27*/

/*EJERCICIO 28*/

/*EJERCICIO 29*/

/*EJERCICIO 30*/

/*EJERCICIO 31*/

/*EJERCICIO 32*/


/*EJERCICIO 33*/

/*EJERCICIO 34*/

/*EJERCICIO 35*/

/*EJERCICIO 36*/

/*EJERCICIO 37*/

/*EJERCICIO 38*/

/*EJERCICIO 39*/

/*EJERCICIO 40*/

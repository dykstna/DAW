/*Ejercicio 1*/
SELECT AVG(SALDO) AS "Saldo Promedio"
FROM CUENTA;

/*Ejercicio 2*/
SELECT SUM(SALDO) AS "Suma de Saldos"
FROM CUENTA;

/*Ejercicio 3*/
SELECT MIN(SALDO) AS "Saldo Mínimo", 
AVG(SALDO) AS "Saldo Medio", MAX(SALDO) AS "Saldo Máximo"
FROM CUENTA;

/*Ejercicio 4*/
SELECT COD_SUCURSAL, AVG(SALDO) AS "SALDO MEDIO", SUM(SALDO) AS "SUMA DE LOS SALDOS"
FROM CUENTA
GROUP BY COD_SUCURSAL;

/*Ejercicio 5*/
SELECT cl.COD_CLIENTE, SUM(c.SALDO) AS TOTAL_DEPOSITADO, 
COUNT(c.COD_CUENTA) AS NUMERO_CUENTAS
FROM CLIENTE cl
JOIN CUENTA c ON cl.COD_CLIENTE = c.COD_CLIENTE
GROUP BY cl.COD_CLIENTE;

/*Ejercicio 6*/
SELECT cl.NOMBRE, cl.APELLIDOS, 
SUM(c.SALDO) AS TOTAL_DEPOSITADO, 
COUNT(c.COD_CUENTA) AS NUMERO_CUENTAS 
FROM CLIENTE cl
JOIN CUENTA c ON cl.COD_CLIENTE = c.COD_CLIENTE 
GROUP BY cl.NOMBRE,cl.APELLIDOS;

/*Ejercicio 7*/
SELECT s.DIRECCION, 
COUNT(c.COD_CUENTA) AS NUM_CUENTAS, 
SUM(c.SALDO) AS TOTAL_SALDO 
FROM SUCURSAL s
JOIN CUENTA c ON s.COD_SUCURSAL = c.COD_SUCURSAL 
GROUP BY s.DIRECCION 
ORDER BY NUM_CUENTAS DESC;


/*Ejercicio 8*/
SELECT AVG(saldo) AS "Saldo medio", AVG(interes) AS "Interés medio"
FROM cuenta
WHERE cod_sucursal IN (1, 2) AND interes > 0.1;


/*Ejercicio 9*/


/*Ejercicio 10*/
/*Ejercicio 11*/
/*Ejercicio 12*/
/*Ejercicio 13*/
/*Ejercicio 14*/
/*Ejercicio 15*/
/*Ejercicio 16*/
/*Ejercicio 17*/
/*Ejercicio 18*/
/*Ejercicio 19*/
/*Ejercicio 20*/
/*Ejercicio 21*/
/*Ejercicio 22*/

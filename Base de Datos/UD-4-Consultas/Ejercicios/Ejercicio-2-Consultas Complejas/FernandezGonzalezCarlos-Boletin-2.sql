/*EJERCICIO 1*/
SELECT round(avg(saldo),2) AS 'Media Saldo' FROM cuenta;

/*EJERCICIO 2*/
SELECT SUM(saldo) AS Total_Cuentas FROM cuenta;

/*EJERCICIO 3*/
SELECT MIN(saldo) AS Saldo_Min,MAX(saldo) AS Saldo_Max,round(AVG(saldo),2) AS Saldo_Medio FROM cuenta;

/*EJERCICIO 4*/
SELECT cod_sucursal AS Sucursal, SUM(saldo) AS Suma_Saldos,round(AVG(saldo),2) AS Saldo_Medio 
FROM cuenta GROUP BY cod_sucursal;

/*EJERCICIO 5*/
SELECT cod_cliente,saldo,count(cod_cuenta) AS Numero_Cuentas 
FROM cuenta GROUP BY cod_cliente;

/*EJERCICIO 6*/
SELECT nombre, apellidos,c.cod_cliente,saldo,count(cod_cuenta) AS Numero_Cuentas 
FROM cuenta c,cliente cl 
WHERE c.cod_cliente=cl.cod_cliente
GROUP BY c.cod_cliente;

/*EJERCICIO 7*/
SELECT s.cod_sucursal,direccion,COUNT(c.cod_cuenta),SUM(saldo) 
FROM sucursal s,cuenta c 
WHERE c.cod_sucursal=s.cod_sucursal
GROUP BY s.cod_sucursal;

/*EJERCICIO 8*/
SELECT round(avg(saldo),2) AS Saldo_Medio,round(avg(interes),2) AS Interes_Medio 
FROM cuenta WHERE interes>0.1 AND (cod_sucursal in(1,2)) 
GROUP BY cod_sucursal;

/*EJERCICIO 9*/
SELECT m.cod_tipo_movimiento,t.descripcion,SUM(importe) AS Importe_Total
FROM movimiento m,tipo_movimiento t
WHERE m.cod_tipo_movimiento=t.cod_tipo_movimiento
GROUP BY cod_tipo_movimiento,t.descripcion;

/*EJERCICIO 10*/
SELECT round(avg(importe),2) AS Retirada_media_Cajero,cod_tipo_movimiento 
FROM movimiento
WHERE cod_tipo_movimiento='RC';

/*EJERCICIO 11*/
SELECT m.cod_tipo_movimiento,round(SUM(importe),2) AS Saldo_Total 
FROM movimiento m,tipo_movimiento t
WHERE m.cod_tipo_movimiento=t.cod_tipo_movimiento AND m.cod_tipo_movimiento !='IE'
GROUP BY m.cod_tipo_movimiento;

/*EJERCICIO 12*/
SELECT m.cod_tipo_movimiento,round(SUM(importe),2) AS Saldo_Total 
FROM movimiento m,tipo_movimiento t
WHERE t.salida='No' AND m.cod_tipo_movimiento=t.cod_tipo_movimiento
GROUP BY m.cod_tipo_movimiento;

/*EJERCICIO 13*/
SELECT SUM(importe) FROM movimiento m,tipo_movimiento t 
WHERE salida="si" AND m.cod_tipo_movimiento=t.cod_tipo_movimiento 
GROUP BY salida;

/*EJERCICIO 14*/
SELECT sum(importe) AS SumaImporte, apellidos,nombre,c.cod_cuenta,descripcion 
FROM tipo_movimiento tm,cliente cl,cuenta c,movimiento m
WHERE cl.cod_cliente=c.cod_cliente 
AND m.cod_cuenta=c.cod_cuenta
AND tm.cod_tipo_movimiento=m.cod_tipo_movimiento
GROUP BY m.cod_tipo_movimiento,c.cod_cuenta ORDER BY nombre;

/*EJERCICIO 15*/
SELECT count(c.cod_cuenta) FROM cuenta c LEFT JOIN movimiento m 
ON c.cod_cuenta=m.cod_cuenta WHERE num_mov_mes is NULL;

/*EJERCICIO 16*/
SELECT apellidos, nombre, COUNT(*) AS num_cuentas_sin_movimiento
FROM cliente cl,(cuenta c LEFT JOIN movimiento m ON c.cod_cuenta=m.cod_cuenta)
WHERE cl.cod_cliente=c.cod_cliente AND m.cod_cuenta IS NULL
GROUP BY cl.nombre, cl.apellidos;

/*EJERCICIO 17*/
SELECT cod_cliente, SUM(saldo) AS SumaTotal, COUNT(cod_cuenta) AS Numero_Cuentas
FROM cuenta
GROUP BY cod_cliente
HAVING SUM(saldo)>=35000;

/*EJERCICIO 18*/
SELECT apellidos,nombre,count(cod_cuenta) AS Numero_de_cuentas 
FROM cliente cl,cuenta c
WHERE cl.cod_cliente=c.cod_cliente
GROUP BY cl.cod_cliente
HAVING count(cod_cuenta)>2;

/*EJERCICIO 19*/
SELECT c.cod_sucursal, direccion, capital_anio_anterior, SUM(saldo) AS SaldoTotal
FROM sucursal s, cuenta c
WHERE s.cod_sucursal = c.cod_sucursal
GROUP BY c.cod_sucursal
HAVING SUM(saldo)>capital_anio_anterior;

/*EJERCICIO 20*/
SELECT c.cod_cuenta, saldo, descripcion, SUM(importe) AS SumaTotal
FROM movimiento m, tipo_movimiento tm, cuenta c
WHERE (tm.cod_tipo_movimiento = m.cod_tipo_movimiento) 
AND (c.cod_cuenta = m.cod_cuenta)
GROUP BY c.cod_cuenta, descripcion
HAVING SUM(importe)>saldo*0.2;

/*EJERCICIO 21*/
SELECT c.cod_cuenta, saldo, descripcion, SUM(importe) AS SumaTotal
FROM movimiento m, tipo_movimiento tm, cuenta c
WHERE tm.cod_tipo_movimiento = m.cod_tipo_movimiento 
AND c.cod_cuenta = m.cod_cuenta
AND cod_sucursal != 4
GROUP BY c.cod_cuenta, descripcion
HAVING SUM(importe)>saldo*0.1;

/*EJERCICIO 22*/
SELECT cl.*, c.saldo 
FROM cuenta c, cliente cl, sucursal s  
WHERE c.cod_cliente=cl.cod_cliente 
AND s.cod_sucursal=c.cod_sucursal
AND (capital_anio_anterior*0.2)<=saldo 
GROUP BY c.cod_cliente;

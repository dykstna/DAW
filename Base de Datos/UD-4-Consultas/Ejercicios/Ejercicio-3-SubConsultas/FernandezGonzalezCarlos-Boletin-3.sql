/*SUBCONSULTA*/

/*EJERCICIO 1*/
SELECT apellidos,nombre,count(c.cod_cuenta) 
FROM cliente cl,cuenta c 
WHERE c.cod_cuenta NOT IN (
    SELECT cod_cuenta FROM movimiento
    )
AND cl.cod_cliente = c.cod_cliente
GROUP BY cl.cod_cliente;

/*EJERCICIO 2*/
SELECT cl.* FROM cliente cl 
JOIN cuenta c ON cl.cod_cliente=c.cod_cliente
WHERE 15000 < ALL (
	SELECT saldo
	FROM cuenta cue
	WHERE cl.cod_cliente=cue.cod_cliente	
)	
GROUP BY cl.cod_cliente;

/*EJERCICIO 3*/
SELECT cl.*  FROM cliente cl,cuenta c WHERE c.saldo IN (
    SELECT saldo FROM cuenta WHERE saldo>60000
    )
AND cl.cod_cliente=c.cod_cliente;

/*EJERCICIO 4*/
SELECT c.* FROM cuenta c,movimiento m WHERE fecha_hora IN (
    SELECT fecha_hora FROM movimiento WHERE fecha_hora LIKE "%14:15:__"
    )
AND c.cod_cuenta=m.cod_cuenta;

/*EJERCICIO 5*/
SELECT c.* FROM cuenta c 
WHERE cod_cuenta not in(
    SELECT cod_cuenta FROM movimiento
    WHERE cod_tipo_movimiento LIKE "PT"
    );

/*EJERCICIO 6*/
SELECT c.* FROM cuenta c, movimiento m 
WHERE c.cod_cuenta NOT IN(
    SELECT cod_cuenta FROM movimiento)
GROUP BY cod_cuenta;

/*EJERCICIO 7*/
SELECT c.* FROM cuenta c, movimiento m 
WHERE cod_tipo_movimiento IN (
    SELECT cod_tipo_movimiento FROM movimiento
    WHERE cod_tipo_movimiento LIKE "PT"
    )
AND c.cod_cuenta=m.cod_cuenta
GROUP BY c.cod_cuenta
HAVING count(cod_tipo_movimiento)>1;
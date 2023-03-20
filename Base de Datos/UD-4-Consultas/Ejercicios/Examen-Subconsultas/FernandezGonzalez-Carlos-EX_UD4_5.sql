/*RELACION TABLAS*/
/*coche-incluye-reserva-cliente-avala*/

/*EJERCICIO 1*/
SELECT nombre from cliente where COD_CLIENTE = (
    SELECT COD_CLIENTE from reserva
    group by COD_CLIENTE
    having min(precio)
    order by precio desc
    limit 1
    );

/*EJERCICIO 2*/
SELECT ct.dni,ct.nombre,count(AVALADO) as 'NUMERO AVALADOS' from avala a
JOIN cliente ct on ct.COD_CLIENTE=a.avalador
group by avalador
order by ct.dni desc;


/*EJERCICIO 3*/
SELECT ct.dni,ct.nombre from cliente ct
join avala a on ct.COD_CLIENTE=a.avalador
where COD_CLIENTE in(
    SELECT COD_CLIENTE from reserva where precio between 100 and 200)
order by nombre desc;



/*EJERCICIO 4*/
SELECT ct.COD_CLIENTE,ct.dni,ct.nombre from cliente ct
join avala a on ct.COD_CLIENTE=a.AVALADO where avalador in(
    SELECT COD_CLIENTE from cliente where dni like '%78%');


/*EJERCICIO 5*//*volver*/
SELECT * from coche where matricula in(
    SELECT matricula from incluye where numero in(
        SELECT count(numero) from reserva
        ))
group by modelo,marca;


/*EJERCICIO 6*/
update cliente
set TELEFONO = 666111222
where telefono is null;


/*EJERCICIO 7*/
INSERT INTO cliente
SELECT "00011", dni,concat(nombre,'BIS'), direccion, telefono from cliente
where COD_CLIENTE =(
    SELECT numero from reserva
    group by numero
    order by precio desc
    limit 1);


/*EJERCICIO 8*/
delete from cliente 
where COD_CLIENTE not in(
    SELECT COD_CLIENTE from reserva);


/*EJERCICIO 9*/
create view RESERVACOCHESMAS12 as
SELECT * FROM COCHE WHERE MATRICULA IN(
    SELECT MATRICULA FROM INCLUYE WHERE NUMERO IN(
        SELECT NUMERO FROM RESERVA WHERE DATEDIFF(FECHA_FIN,FECHA_INICIO)>12));
SELECT * FROM RESERVACOCHESMAS12;



/*EJERCICIO 10*/
CREATE TABLE COCHESCONAVAL
SELECT * FROM COCHE WHERE MATRICULA IN(
    SELECT MATRICULA FROM INCLUYE WHERE NUMERO IN(
        SELECT NUMERO FROM RESERVA WHERE COD_CLIENTE IN(
            SELECT COD_CLIENTE FROM CLIENTE WHERE COD_CLIENTE IN(
                SELECT AVALADOR FROM AVALA))));

SELECT * FROM COCHESCONAVAL;
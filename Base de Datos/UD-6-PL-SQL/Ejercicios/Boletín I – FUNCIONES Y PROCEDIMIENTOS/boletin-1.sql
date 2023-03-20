/*EJERCICIO 1*/
/*EJERCICIO 2*/
DELIMITER$$
DROP PROCEDURE IF EXISTS get_variable$$
CREATE PROCEDURE get_variable()
BEGIN
    DECLARE texto VARCHAR(50);
    SET texto='TEXTO'
    SELECT 
END
$$
CALL get_variable();

/*EJERCICIO 1*/
/*EJERCICIO 1*/
/*EJERCICIO 1*/
/*EJERCICIO 1*/
/*EJERCICIO 1*/

/*EJEMPLO variable definidas por usuario*/
SET @uservar;
DELIMITER$$
--DROP PROCEDURE IF EXISTS get_variable$$
CREATE PROCEDURE @uservar(INOUT a INT)
BEGIN
    DECLARE texto VARCHAR(50);
    SET a=a+1
    SELECT 
END
$$
CALL @uservar();
SELECT a;
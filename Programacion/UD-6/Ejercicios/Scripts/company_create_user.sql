CREATE DATABASE company_db;

CREATE USER 'company'@localhost IDENTIFIED BY 'company';

GRANT ALL PRIVILEGES ON company_db.* TO 'company'@localhost;



-- Ahora creamos una nueva sesi�n asociada al usuario y la abrimos
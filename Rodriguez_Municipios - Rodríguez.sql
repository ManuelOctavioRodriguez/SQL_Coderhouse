CREATE SCHEMA IF NOT EXISTS RODRIGUEZ_MUNICIPIOS;

USE RODRIGUEZ_MUNICIPIOS;

-- CREAMOS LAS TABLAS Y CON ELLAS SUS POSTERIORES INSERCIONES

CREATE TABLE IF NOT EXISTS ID_MUNICIPIOS (
    ID_Municipio INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Municipio VARCHAR(55) NOT NULL
);

CREATE TABLE ID_MUNICIPIOS_BACKUP LIKE ID_MUNICIPIOS;
INSERT INTO ID_MUNICIPIOS_BACKUP (SELECT * FROM ID_MUNICIPIOS);

CREATE TABLE IF NOT EXISTS DATOS_GEOGRAFICOS (
    ID_Datos_Geograficos INT NOT NULL AUTO_INCREMENT,
    Poblacion INT NOT NULL,
    Superficie DECIMAL(5 , 2 ) NOT NULL,
    Densidad INT NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Datos_Geograficos),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE DATOS_GEOGRAFICOS_BACKUP LIKE DATOS_GEOGRAFICOS;
INSERT INTO DATOS_GEOGRAFICOS_BACKUP (SELECT * FROM DATOS_GEOGRAFICOS);

CREATE TABLE IF NOT EXISTS BARRIOS_POPULARES (
    ID_Barrios_Populares INT NOT NULL AUTO_INCREMENT,
    Barrios_Populares INT NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Barrios_Populares),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE BARRIOS_POPULARES_BACKUP LIKE BARRIOS_POPULARES;
INSERT INTO BARRIOS_POPULARES_BACKUP (SELECT * FROM BARRIOS_POPULARES);

CREATE TABLE IF NOT EXISTS EMPLEO_REGISTRADO (
    ID_Empleo_Registrado INT NOT NULL AUTO_INCREMENT,
    Empleo_Registrado INT NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Empleo_Registrado),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE EMPLEO_REGISTRADO_BACKUP LIKE EMPLEO_REGISTRADO;
INSERT INTO EMPLEO_REGISTRADO_BACKUP (SELECT * FROM EMPLEO_REGISTRADO);

CREATE TABLE IF NOT EXISTS GASTO_PER_CAPITA (
    ID_Gasto_Per_Capita INT NOT NULL AUTO_INCREMENT,
    Gasto_Per_Capita INT NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Gasto_Per_Capita),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE GASTO_PER_CAPITA_BACKUP LIKE GASTO_PER_CAPITA;
INSERT INTO GASTO_PER_CAPITA_BACKUP (SELECT * FROM GASTO_PER_CAPITA);

CREATE TABLE IF NOT EXISTS GASTO_SALUD_PER_CAPITA (
    ID_Gasto_Salud_Per_Capita INT NOT NULL AUTO_INCREMENT,
    Gasto_Salud_Per_Capita INT NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Gasto_Salud_Per_Capita),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE GASTO_SALUD_PER_CAPITA_BACKUP LIKE GASTO_SALUD_PER_CAPITA;
INSERT INTO GASTO_SALUD_PER_CAPITA_BACKUP (SELECT * FROM GASTO_SALUD_PER_CAPITA);

CREATE TABLE IF NOT EXISTS GASTO_DESARROLLO_PER_CAPITA (
    ID_Gasto_Desarrollo_Per_Capita INT NOT NULL AUTO_INCREMENT,
    Gasto_Desarrollo_Per_Capita INT NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Gasto_Desarrollo_Per_Capita),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE GASTO_DESARROLLO_PER_CAPITA_BACKUP LIKE GASTO_DESARROLLO_PER_CAPITA;
INSERT INTO GASTO_DESARROLLO_PER_CAPITA_BACKUP (SELECT * FROM GASTO_DESARROLLO_PER_CAPITA);

CREATE TABLE IF NOT EXISTS ESTABLECIMIENTOS_EDUCATIVOS (
    ID_Establecimientos_Educativos INT NOT NULL AUTO_INCREMENT,
    Establecimientos_Educativos DECIMAL(4 , 2 ) NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Establecimientos_Educativos),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE ESTABLECIMIENTOS_EDUCATIVOS_BACKUP LIKE ESTABLECIMIENTOS_EDUCATIVOS;
INSERT INTO ESTABLECIMIENTOS_EDUCATIVOS_BACKUP (SELECT * FROM ESTABLECIMIENTOS_EDUCATIVOS);

CREATE TABLE IF NOT EXISTS CAMAS_PUBLICAS_INTERNACION (
    ID_Camas_Publicas_Internacion INT NOT NULL AUTO_INCREMENT,
    Camas_Publicas_Internacion INT NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_Camas_Publicas_Internacion),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE CAMAS_PUBLICAS_INTERNACION_BACKUP LIKE CAMAS_PUBLICAS_INTERNACION;
INSERT INTO CAMAS_PUBLICAS_INTERNACION_BACKUP (SELECT * FROM CAMAS_PUBLICAS_INTERNACION);

CREATE TABLE IF NOT EXISTS PBG (
    ID_PBG INT NOT NULL AUTO_INCREMENT,
    PBG DECIMAL(5 , 2 ) NOT NULL,
    ID_Municipio INT NOT NULL,
    PRIMARY KEY (ID_PBG),
    FOREIGN KEY (ID_Municipio)
        REFERENCES ID_Municipios (ID_Municipio)
);

CREATE TABLE PBG_BACKUP LIKE PBG;
INSERT INTO PBG_BACKUP (SELECT * FROM PBG);

-- VISTAS

CREATE VIEW PRESUPUESTOS_ALTOS AS
-- VISTA QUE MUESTRA PRESUPUESTOS MAYORES A 1000 PESOS PER CÁPITA
    SELECT 
        *
    FROM
        gasto_desarrollo_per_capita
    WHERE
        Gasto_Desarrollo_Per_Capita > 1000;

CREATE VIEW PRESUPUESTOS_BAJOS AS
-- VISTA QUE MUESTRA PRESUPUESTOS MENORES A 500 PESOS PER CÁPITA
   SELECT 
        *
    FROM
        gasto_desarrollo_per_capita
    WHERE
        Gasto_Desarrollo_Per_Capita < 500;

CREATE VIEW MIN_MAX_PRESUPUESTO AS
-- VISTA QUE MUESTRA EL GASTO MIN Y MAX PER CAPITA
    SELECT 
        MIN(gasto_desarrollo_per_capita) AS PRESUPUESTO_MIN,
        MAX(gasto_desarrollo_per_capita) AS PRESUPUESTO_MAX
    FROM
        gasto_desarrollo_per_capita;

CREATE VIEW GASTO_MUNICIPIO AS
-- VISTA QUE EL GASTO PER CAPITA JUNTO AL NOMBRE DEL MUNICIPIO    
    SELECT 
        gasto_per_capita.Gasto_Per_Capita,
        id_municipios.Municipio,
        gasto_per_capita.ID_Municipio
    FROM
        gasto_per_capita
            INNER JOIN
        id_municipios ON gasto_per_capita.ID_Municipio = id_municipios.ID_Municipio;

CREATE VIEW PBG_MUNICIPIO AS
-- VISTA QUE MUESTRA MUNICIPIO JUNTO A SU PORCENTAJE DE PBG   
    SELECT 
        id_municipios.Municipio, pbg.PBG
    FROM
        id_municipios
            LEFT JOIN
        pbg ON id_municipios.ID_Municipio = pbg.ID_Municipio;

CREATE VIEW ESTABLECIMIENTOS_EDUCATIVOS_MUNICIPIO AS
-- VISTA QUE MUESTRA MUNICIPIO JUNTO A LOS ESTABLECIMIENTOS EDUCATIVOS QUE POSEE
    SELECT 
        establecimientos_educativos.Establecimientos_Educativos,
        id_municipios.Municipio
    FROM
        establecimientos_educativos
            RIGHT JOIN
        id_municipios ON establecimientos_educativos.ID_Municipio = id_municipios.ID_Municipio
    ORDER BY Establecimientos_Educativos DESC;

CREATE VIEW POBLACION_MUNICIPIOS AS
-- VISTA QUE MUESTRA A LOS MUNICIPIOS Y SU POBLACIÓN
    SELECT 
        id_municipios.Municipio, datos_geograficos.Poblacion
    FROM
        id_municipios
            INNER JOIN
        datos_geograficos ON (id_municipios.ID_Municipio = datos_geograficos.ID_Municipio)
    ORDER BY Poblacion;

CREATE VIEW GASTOS_COMPLETOS AS
-- VISTA QUE MUESTRA LOS GASTOS COMPLETOS DE CADA MUNICIPIO
    SELECT 
        id_municipios.ID_Municipio,
        id_municipios.Municipio,
        gasto_per_capita.Gasto_Per_Capita,
        gasto_desarrollo_per_capita.Gasto_Desarrollo_Per_Capita,
        gasto_salud_per_capita.Gasto_Salud_Per_Capita
    FROM
        id_municipios
            INNER JOIN
        gasto_per_capita ON (id_municipios.ID_Municipio = gasto_per_capita.ID_Municipio)
            INNER JOIN
        gasto_desarrollo_per_capita ON (id_municipios.ID_Municipio = gasto_desarrollo_per_capita.ID_Municipio)
            INNER JOIN
        gasto_salud_per_capita ON (id_municipios.ID_Municipio = gasto_salud_per_capita.ID_Municipio);

-- TRIGGERS

CREATE TABLE IF NOT EXISTS USUARIOS_T(
	ID_MUNICIPIO INT auto_increment PRIMARY KEY,
    FECHA timestamp,
    USUARIO VARCHAR(100)
    );

-- EN LA TABLA SOBRE DATOS GEOGRÁFICOS LA INFORMACIÓN ACERCA LA POBLACIÓN Y DENSIDAD PUEDE ACTUALIZARSE. CUANDO ESO OCURRA EL SIGUIENTE TRIGGER AVISARÁ QUIEN Y CUANDO MODIFICÓ LA TABLA

CREATE trigger `AFT_DATOS_GEOGR` AFTER UPDATE ON datos_geograficos FOR EACH ROW
INSERT INTO  usuarios_t (id_municipio, fecha, usuario)
VALUES (NEW.ID_MUNICIPIO, current_timestamp(), session_user())
;

CREATE TABLE IF NOT EXISTS BARRIOS_D_T(
ID_MUNICIPIO INT auto_increment PRIMARY KEY,
FECHA timestamp,
USUARIO VARCHAR(100)
);

-- EN LA TABLA SOBRE BARRIOS POPULARES LA CANTIDAD ESTÁ SUJETO A MODIFICACIONES. CUANDO OCURRAN EL SIGUIENTE TRIGGER AVISARÁ QUIÉN Y CUANDO FUE EL USUARIO QUE LAS REALIZÓ

CREATE trigger `bfr_barrios_d` BEFORE UPDATE ON barrios_populares FOR EACH ROW
INSERT INTO barrios_d_t (id_municipio, feha, usuario)
VALUES (NEW.ID_MUNICIPIO, current_timestamp(), session_user())
;

CREATE TABLE IF NOT EXISTS RODRIGUEZ_MUNICIPIOS.LOG (
ID_MUNICIPIO INT,
FECHA timestamp,
USUARIO VARCHAR(100),
TIPO_MOVIMIENTO  VARCHAR(100)
);

-- CREADA UNA TABLA LOG DONDE SE MOSTRARAN LOS MOVIMIENTOS QUE OCURRAN DENTRO DE LA TABLA CAMAS_PUBLICAS_INTERNACION: PREVIO A UNA ACTUALIZACIÓN Y POSTERIOR A UNA ELIMINACIÓN

CREATE TRIGGER `BFR_CAMAS_UPD`
BEFORE update ON camas_publicas_internacion FOR EACH ROW
INSERT INTO log(ID_MUNICIPIO, FECHA, USUARIO, TIPO_MOVIMIENTO)
VALUES (NEW.ID_MUNICIPIO, current_timestamp(), session_user(), 'UPDATE')
;

CREATE TRIGGER `AFTR_CAMAS_DLT`
BEFORE delete ON camas_publicas_internacion FOR EACH ROW
INSERT INTO log(ID_MUNICIPIO, FECHA, USUARIO, TIPO_MOVIMIENTO)
VALUES (camas_publicas_internacion.ID_MUNICIPIO, current_timestamp(), session_user(), 'DELETE')
;

-- FUNCIONES

DELIMITER $$
-- El usuario define un ID y la función arrojará datos geográficos concatenados sobre cada municipio
CREATE FUNCTION DATOSUNIDOS(PARAM1 int) RETURNS VARCHAR(250)
READS SQL DATA
BEGIN
	DECLARE SUP decimal(5,2);
	DECLARE POBL int;
	DECLARE DENS int;
	DECLARE DATOS VARCHAR(250);
	SET SUP = (SELECT Superficie FROM datos_geograficos WHERE ID_Municipio = PARAM1);
	SET POBL = (SELECT Poblacion FROM datos_geograficos WHERE ID_Municipio = PARAM1);
	SET DENS = (SELECT Densidad FROM datos_geograficos WHERE ID_Municipio = PARAM1);
	SET DATOS = concat(SUP, ' ', POBL, ' ', DENS);
	RETURN DATOS;
END$$

DELIMITER $$
-- El usuario define un ID y la función arrojará el municipio que se corresponda
CREATE FUNCTION MUNICIPIO(PARAM1 int) RETURNS VARCHAR(55)
READS SQL DATA
BEGIN
DECLARE RESULT VARCHAR(55);
SET RESULT = (SELECT Municipio FROM id_municipios WHERE ID_Municipio = PARAM1);
RETURN RESULT;
END $$

DELIMITER $$
-- El usuario define un ID y la función arrojará el porcentaje de establecimientos educativos públicos dentro del municipio
CREATE FUNCTION ESCUELAS(PARAM1 int) RETURNS decimal(4,2)
READS SQL DATA
BEGIN
DECLARE ESC decimal(4,2);
SET ESC = (SELECT Establecimientos_Educativos FROM establecimientos_educativos WHERE ID_Municipio = PARAM1);
RETURN ESC;
END $$

-- STORED PROCEDURES

DELIMITER $$
-- STORED PROCEDURE QUE DEVUELVE EL GASTO DEL MUNICIPIO ELEGIDO EN DÓLARES
CREATE PROCEDURE `gasto_en_dolares` (IN PARAM2 int)
BEGIN
	SELECT Gasto_Per_Capita / 166.5 FROM gasto_per_capita where ID_Municipio = PARAM2;
END $$

DELIMITER $$
-- STORED PROCEDURE DONDE ESCRIBIENDO EL MUNICIPIO NOS DEVOLVERÁ EL GASTO PER CÁPITA
CREATE PROCEDURE `muni_gasto`(IN IDMUN VARCHAR(55))
BEGIN
	SELECT 
        id_municipios.Municipio AS Municipio,
        gasto_per_capita.Gasto_Per_Capita AS Gasto_Per_Capita
    FROM
        (id_municipios
        LEFT JOIN gasto_per_capita ON (id_municipios.ID_Municipio = gasto_per_capita.ID_Municipio))
    WHERE Municipio = IDMUN;
END $$

DELIMITER $$
-- STORED PROCEDURE DONDE ESCRIBIENDO EL MUNICIPIO NOS DEVOLVERÁ LA CANTIDAD DE EMPLEADOS REGISTRADOS
CREATE PROCEDURE `muni_empleo`(IN IDMUN VARCHAR(55))
BEGIN
	SELECT 
        id_municipios.Municipio AS Municipio,
        empleo_registrado.Empleo_Registrado AS Empleo_Registrado
    FROM
        (id_municipios
        LEFT JOIN empleo_registrado ON (id_municipios.ID_Municipio = empleo_registrado.ID_Municipio))
    WHERE Municipio = IDMUN;
END $$

DELIMITER $$
CREATE PROCEDURE `suma_gastos` (IN dato1 INT, OUT total INT)
BEGIN
	SELECT
		GD.Gasto_Desarrollo_Per_Capita AS Gasto_Desarrollo,
		GS.Gasto_Salud_Per_Capita AS Gasto_Salud,
	SUM(GD.Gasto_Desarrollo_Per_Capita + GS.Gasto_Salud_Per_Capita)
	FROM
		gasto_desarrollo_per_capita as GD
		INNER JOIN
	gasto_salud_per_capita as GS
	ON
	GD.ID_Municipio = GS.ID_Municipio
	WHERE
	GD.ID_Municipio = dato1;
	END $$
DELIMITER ;
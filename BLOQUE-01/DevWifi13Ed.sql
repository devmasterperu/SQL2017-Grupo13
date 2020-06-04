/*Seleccionar Base 
de Datos*/

USE master --Seleccionar Base de Datos master
go

if db_id('DevWifi13Ed') is not null --Si existe la BD DevWifi13Ed
begin
	drop database DevWifi13Ed --Eliminar la BD
end

create database DevWifi13Ed--Crear BD con nombre DevWifi13Ed
go

use DevWifi13Ed --Seleccionar Base de Datos DevWifi13Ed
go

/*
 * ER/Studio 8.0 SQL Code Generation
 * Company :      devmasterperu
 * Project :      MODELO_BLOQUE01.DM1
 * Author :       gmanriquev
 *
 * Date Created : Wednesday, June 03, 2020 21:17:50
 * Target DBMS : Microsoft SQL Server 2008
 */

/* 
 * TABLE: Cliente 
 */

CREATE TABLE Cliente( --Crear tabla Cliente (ENTIDAD=>TABLA)
    codcliente        int             IDENTITY(1,1), --Crear atributo codcliente (ATRIBUTO=>COLUMNA)
    codtipo           int             NOT NULL,
    numdoc            varchar(15)     NOT NULL,
    tipo_cliente      char(1)         NOT NULL,
    nombres           varchar(100)    NULL,
    ape_paterno       varchar(50)     NULL,
    ape_materno       varchar(50)     NULL,
    fec_nacimiento    date            NULL,
    sexo              char(1)         NULL,
    razon_social      varchar(255)    NULL,
    fec_inicio        date            NULL,
    email             varchar(320)    NULL,
    direccion         varchar(250)    NOT NULL,
    codzona           int             NOT NULL,
    estado            bit             NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (codcliente)
)
go



IF OBJECT_ID('Cliente') IS NOT NULL
    PRINT '<<< CREATED TABLE Cliente >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Cliente >>>'
go

/* 
 * TABLE: Contrato 
 */

CREATE TABLE Contrato(
    codplan              int               NOT NULL,
    codcliente           int               NOT NULL,
    fec_contrato         date              NOT NULL,
    fecha_baja           date              NULL,
    periodo              char(1)           NOT NULL,
    precio               decimal(6, 2)     NULL,
    ip_router            varchar(15)       NULL,
    ssis_red_wifi        varchar(50)       NULL,
    contrasena           varbinary(256)    NULL,
    fechora_registro     datetime          NOT NULL,
    fechora_actualiza    datetime          NULL,
    estado               char(1)           NOT NULL,
    CONSTRAINT PK9 PRIMARY KEY NONCLUSTERED (codplan, codcliente)
)
go



IF OBJECT_ID('Contrato') IS NOT NULL
    PRINT '<<< CREATED TABLE Contrato >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Contrato >>>'
go

/* 
 * TABLE: PlanInter 
 */

CREATE TABLE PlanInter(
    codplan        int              IDENTITY(1,1),
    nombre         varchar(50)      NOT NULL,
    precioref      decimal(6, 2)    NOT NULL,
    descripcion    varchar(200)     NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (codplan)
)
go



IF OBJECT_ID('PlanInter') IS NOT NULL
    PRINT '<<< CREATED TABLE PlanInter >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PlanInter >>>'
go

/* 
 * TABLE: Telefono 
 */

CREATE TABLE Telefono(
    tipo          varchar(3)     NOT NULL,
    numero        varchar(15)    NOT NULL,
    estado        bit            NOT NULL,
    codcliente    int            NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY NONCLUSTERED (tipo, numero)
)
go



IF OBJECT_ID('Telefono') IS NOT NULL
    PRINT '<<< CREATED TABLE Telefono >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Telefono >>>'
go

/* 
 * TABLE: TipoDocumento 
 */

CREATE TABLE TipoDocumento(
    codtipo      int            IDENTITY(1,1),
    desclarga    varchar(50)    NOT NULL,
    descorta     varchar(25)    NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY NONCLUSTERED (codtipo)
)
go



IF OBJECT_ID('TipoDocumento') IS NOT NULL
    PRINT '<<< CREATED TABLE TipoDocumento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TipoDocumento >>>'
go

/* 
 * TABLE: Ubigeo 
 */

CREATE TABLE Ubigeo(
    codubigeo    int             IDENTITY(1,1),
    cod_dpto     char(2)         NOT NULL,
    nom_dpto     varchar(50)     NOT NULL,
    cod_prov     char(2)         NOT NULL,
    nom_prov     varchar(50)     NOT NULL,
    cod_dto      char(2)         NOT NULL,
    nom_dto      varchar(100)    NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (codubigeo)
)
go



IF OBJECT_ID('Ubigeo') IS NOT NULL
    PRINT '<<< CREATED TABLE Ubigeo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Ubigeo >>>'
go

/* 
 * TABLE: Zona 
 */

CREATE TABLE Zona(
    codzona      int            IDENTITY(1,1),
    nombre       varchar(50)    NOT NULL,
    estado       bit            NOT NULL,
    codubigeo    int            NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (codzona)
)
go



IF OBJECT_ID('Zona') IS NOT NULL
    PRINT '<<< CREATED TABLE Zona >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Zona >>>'
go

/* 
 * TABLE: Cliente 
 */

ALTER TABLE Cliente ADD CONSTRAINT RefZona4 
    FOREIGN KEY (codzona)
    REFERENCES Zona(codzona)
go

ALTER TABLE Cliente ADD CONSTRAINT RefTipoDocumento5 
    FOREIGN KEY (codtipo)
    REFERENCES TipoDocumento(codtipo)
go


/* 
 * TABLE: Contrato 
 */

ALTER TABLE Contrato ADD CONSTRAINT RefPlanInter7 
    FOREIGN KEY (codplan)
    REFERENCES PlanInter(codplan)
go

ALTER TABLE Contrato ADD CONSTRAINT RefCliente8 
    FOREIGN KEY (codcliente)
    REFERENCES Cliente(codcliente)
go


/* 
 * TABLE: Telefono 
 */

ALTER TABLE Telefono ADD CONSTRAINT RefCliente6 
    FOREIGN KEY (codcliente)
    REFERENCES Cliente(codcliente)
go


/* 
 * TABLE: Zona 
 */

ALTER TABLE Zona ADD CONSTRAINT RefUbigeo3 
    FOREIGN KEY (codubigeo)
    REFERENCES Ubigeo(codubigeo)
go



/************************************************************
    GRUPO: 05   |  CURSO: L-IG
*  	UC: ADMINISTRAÇÃO E GESTÃO DE INFORMAÇÃO
*
*	PROJETO: RIDE-U   
*
*  	NOME: JOÃO RAMOS(20200255)
*  	NOME: MARTIM BENTO (20200488)
    NOME: PEDRO CUNHA (20200908)
*
************************************************************/
DROP DATABASE IF EXISTS RIDEU;
GO
CREATE DATABASE RIDEU;
GO

USE RIDEU
GO

-- CRIAR LOGINS
CREATE LOGIN [analista] WITH PASSWORD=N'pass'
CREATE LOGIN [cliente] WITH PASSWORD=N'pass'
CREATE LOGIN [condutor] WITH PASSWORD=N'pass'

-- CRIAR USER PARA OS LOGINS
CREATE USER [Uanalista] FOR LOGIN [analista] WITH DEFAULT_SCHEMA=['Sanalista']
CREATE USER [Ucliente] FOR LOGIN [cliente] WITH DEFAULT_SCHEMA=['Scliente']
CREATE USER [Ucondutor] FOR LOGIN [condutor] WITH DEFAULT_SCHEMA=['Scondutor']

-- CRIAR ROLES
CREATE ROLE Ranalista
CREATE ROLE Rcliente
CREATE ROLE Rcondutor
GO

-- ADICIONAR USER AO ROLE
sp_addrolemember @rolename = 'Rcliente', @membername = 'Ucliente'
GO
sp_addrolemember @rolename = 'Rcondutor', @membername = 'Ucondutor'
GO
sp_addrolemember @rolename = 'Ranalista', @membername = 'Uanalista'
GO
 
-- CRIAR SCHEMA Scliente
go
CREATE SCHEMA Scliente authorization Ucliente;
go

/*Condutor*/
go
CREATE SCHEMA Scondutor authorization Ucondutor;
GO

/*Analista*/
go
CREATE SCHEMA Sanalista authorization Uanalista;
go

GRANT SELECT ON SCHEMA::Scliente TO Rcliente
DENY SELECT ON Scliente.CLIENTE TO Rcliente
DENY SELECT ON Scliente.CONDAVCL TO Rcliente
DENY INSERT ON SCHEMA::Scliente TO Rcliente
DENY DELETE ON SCHEMA::Scliente TO Rcliente
DENY UPDATE ON SCHEMA::Scliente TO Rcliente
DENY REFERENCES ON SCHEMA::Scliente TO Rcliente
GO

EXEC AS USER='Ucliente'
SELECT * FROM Scliente.dadosCliente
REVERT

GRANT SELECT ON SCHEMA::Scondutor TO Rcondutor
DENY SELECT ON Scondutor.CONDUTOR TO Rcondutor
DENY SELECT ON Scondutor.CARRO TO Rcondutor
DENY SELECT ON Scondutor.CLAVCOND TO Rcondutor
DENY INSERT ON SCHEMA::Scondutor TO Rcondutor
DENY DELETE ON SCHEMA::Scondutor TO Rcondutor
DENY UPDATE ON SCHEMA::Scondutor TO Rcondutor
DENY REFERENCES ON SCHEMA::Scliente TO Rcondutor

GO
EXEC AS USER='Ucondutor'
SELECT * FROM Scondutor.CONDUTOR
REVERT
go






/*Analista Perms*/
GRANT SELECT ON SCHEMA::Sanalista TO Ranalista
DENY DELETE ON SCHEMA::Sanalista TO Ranalista
GRANT UPDATE ON SCHEMA::Sanalista TO Ranalista
DENY INSERT ON SCHEMA::Sanalista TO Ranalista
GRANT REFERENCES ON SCHEMA::Sanalista TO Ranalista


GO









 /********************
* Podemos verificar quem está a usar a base de dados e os schemas criados
********************/
GO
sp_who
GO
EXEC sp_tables
SELECT CURRENT_USER

--VIEWS-----
go
CREATE VIEW	Scliente.dadosCliente 
AS 
SELECT c.CL_NOME, c.CL_NOMEMEIO, c.CL_APELIDO, c.CL_GENERO, a.AVCL_ESTRELAS
FROM CONDAVCL a, CLIENTE c
go

go
CREATE VIEW	Scondutor.dadosCondutor
AS 
SELECT co.CON_NOME, co.CON_NOMEMEIO, co.CON_APELIDO, co.CON_GENERO, co.CON_LICTRANSP, aa.AVCON_ESTRELAS, car.CAR_MARCA, car.CAR_MODELO, car.CAR_COR
FROM CLAVCOND aa, CONDUTOR co, CARRO car
go
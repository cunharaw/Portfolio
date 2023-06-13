/********************
    Grupo: 05   |  Curso: L-IG
*  	UC: Administração e Gestão de Informação
*
*	Trabalho de Pesquisa:Controlo de acessos e segurança (encripatação)
*
*  	Nome: João Ramos(20200255)
*  	Nome: Martim Bento (20200488)
    Nome: Pedro Cunha (20200908)
*
********************/
DROP DATABASE IF EXISTS RIDEu
CREATE DATABASE RIDEu
use RIDEu
GO

/********************
*  Criar Logins
********************/
CREATE LOGIN [admin] WITH PASSWORD=N'pass'
CREATE LOGIN [cliente] WITH PASSWORD=N'pass'
CREATE LOGIN [popAvaliacao] WITH PASSWORD=N'pass'

/********************
*  Criar e definir utilizadores para os logins
********************/
CREATE USER [Ucliente] FOR LOGIN [cliente] WITH DEFAULT_SCHEMA=[SclienteVe]
CREATE USER [Uadmin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[Sadmin]
CREATE USER [Uavaliador] FOR LOGIN [popAvaliacao] WITH DEFAULT_SCHEMA=[SclienteVe]

/********************
*  Criar roles 
********************/
CREATE ROLE Rcliente
CREATE ROLE Ravaliador
CREATE ROLE Radmin

/********************
*  Atribuir Users aos Roles
********************/
GO
sp_addrolemember @rolename = 'Radmin', @membername = 'Uadmin'
GO
sp_addrolemember @rolename = 'Rcliente', @membername = 'Ucliente'
GO
sp_addrolemember @rolename = 'Ravaliador', @membername = 'Uavaliador'
GO
/********************
*  Criar schemas 
********************/

Create schema SclienteVe authorization Ucliente
GO

GO
CREATE SCHEMA Sadmin authorization Uadmin
GO

/********************
*  Fazer os creates
********************/
CREATE TABLE SclienteVe.Tabela (
	AVcon_estrelas int not null, 
	AVcon_Datahora datetime not null)

CREATE TABLE Condutor (
	Con_ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Con_dataNasc DATE NOT NULL,
	Con_genero char(1) NOT NULL,
	Con_Cc varchar(8) UNIQUE NOT NULL,
	Con_NIF INT UNIQUE NOT NULL,
	Con_nome VARCHAR(20) NOT NULL,
	Con_nomeMeio VARCHAR(20),
	Con_apelido VARCHAR(20) NOT NULL,
	Con_Email VARCHAR(255) UNIQUE NOT NULL,
	Con_Telemovel int UNIQUE NOT NULL,
	Con_licTransp INT UNIQUE NOT NULL,
	CONSTRAINT CHK_Con_Gen CHECK (Con_genero='M' or Con_genero='F'),
	CONSTRAINT CHK_Con_CC CHECK (LEN(Con_CC) = 8),  --RI VERIFICAR COMPRIMENTO CC
	CONSTRAINT CHK_Con_NIF CHECK (LEN(Con_NIF) = 9),  --RI VERIFICAR COMPRIMENTO NIF
	CONSTRAINT CHK_Con_Tel CHECK (LEN(Con_Telemovel) = 9),  --RI VERIFICAR COMPRIMENTO TELEFONE
	CONSTRAINT CHK_Con_Lic CHECK (LEN(Con_licTransp) = 6)  --RI VERIFICAR COMPRIMENTO TELEFONE
	);

CREATE TABLE Sadmin.Cliente (
	Cl_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Cl_dataNasc DATE NOT NULL,
	Cl_nome VARCHAR(20) NOT NULL,
	Cl_nomeMeio VARCHAR(20) ,
	Cl_apelido VARCHAR(20) NOT NULL,
	Cl_genero char(1) NOT NULL,
	Cl_Telemovel int not null,
	Cl_Email varchar(255) unique not null,
	CONSTRAINT CHK_Cl_Gen CHECK (Cl_genero='M' or Cl_genero='F'), -- RI: VERIFICAR GENERO
	CONSTRAINT CHK_Cl_Tel CHECK (LEN(Cl_Telemovel) = 9)  --RI: VERIFICAR COMPRIMENTO TELEFONE
	);

CREATE TABLE CodPostal(
	CP_ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CP_4D INT NOT NULL,
	CP_3D INT NOT NULL,
	CP_Rua VARCHAR(255) NOT NULL,
	CP_Freguesia VARCHAR(255) NOT NULL,
	CP_NumPorta INT NOT NULL DEFAULT(1),
	CP_Pais VARCHAR(50) NOT NULL,
	CONSTRAINT CHK_CP_4D CHECK (LEN(CP_4D) = 4),
	CONSTRAINT CHK_CP_3D CHECK (LEN(CP_3D) = 3),
	CONSTRAINT CHK_CP_Rua CHECK (CP_Rua not like '%[0-9]%'),
	CONSTRAINT CHK_CP_Freguesia CHECK (CP_Freguesia not like '%[0-9]%'),
	CONSTRAINT CHK_CP_Pais CHECK (CP_Pais not like '%[0-9]%')
);

CREATE TABLE Estatuto (
	Est_ID INT IDENTITY(1,1) PRIMARY KEY  NOT NULL,
	Est_nome Varchar(6) NOT NULL DEFAULT 'Bronze',
	Est_preco MONEY not null,
	Est_viagens INT not null,
	CONSTRAINT CHK_Est_nome CHECK (Est_nome not like '%[0-9]%')
	);

CREATE TABLE MetPagamento(
	Met_ID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Met_ano INT NOT NULL,
	Met_mes INT NOT NULL,
	Met_numCartao varchar(15) UNIQUE NOT NULL,
	Met_CVV int NOT NULL,
	CONSTRAINT CHK_Met_CVV CHECK (LEN(Met_CVV) = 3),
	CONSTRAINT CHK_Met_mes CHECK (Met_mes >= 1 AND Met_mes <= 12)
);

CREATE TABLE TaxasSistema(
	Tax_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Tax_TaxaApp INT NOT NULL DEFAULT(25)
);

CREATE TABLE Impostos(
	Imp_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Imp_IVA INT NOT NULL DEFAULT(23)
);

CREATE TABLE Tarifa(
	Tar_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Tar_nome VARCHAR(20),
	Tar_custoKM MONEY NOT NULL DEFAULT(1),
	Tar_CustoMin MONEY not null DEFAULT(0.09)
);
/********************
*  Lista de Entidades Fracas
********************/
CREATE TABLE CartaConducao(
	Cc_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Cc_numero VARCHAR(12) UNIQUE not null,
	Cc_dataEmissao date not null,
	CONSTRAINT CHK_Cc_numero CHECK (Cc_numero not like '%[A-Za-z]%')
);

CREATE TABLE Carro (
	Car_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Car_marca Varchar(20) NOT NULL,
	Car_cor Varchar(20) NOT NULL,
	Car_combustivel varchar(10) not null,
	Car_matricula varchar(6) not null,
	Car_lugares int not null,
	Car_dataReg date not null,
	Car_modelo varchar(15) not null,
	Car_DUA INT UNIQUE NOT NULL
);

/********************
*  Lista de Entidades Informacionais com FK
********************/
CREATE TABLE Fatura(
	Fat_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Fat_DataHora datetime not null,
	Fat_NIF int not null,
	Fat_Tax_ID INT,
	Fat_Imp_ID INT,
	FOREIGN KEY(Fat_Tax_ID) REFERENCES TaxasSistema(Tax_ID),
	FOREIGN KEY(Fat_Imp_ID) REFERENCES Impostos(Imp_ID),
	CONSTRAINT CHK_Fat_NIF CHECK (LEN(Fat_NIF) = 9)  --RI VERIFICAR COMPRIMENTO NIF
);

/********************
*  Lista de Entidades de Associação Fracas
********************/
CREATE TABLE Possuir(
	Pos_ID int primary key Identity(1,1),
	Pos_DataHora datetime not null,
	Possuir_Con_ID INT NOT NULL Unique,
	Possuir_Cc_ID int not null unique,
	FOREIGN KEY(Possuir_Cc_ID) REFERENCES CartaConducao(Cc_ID),
	FOREIGN KEY(Possuir_Con_ID) REFERENCES Condutor(Con_ID),
);

CREATE TABLE Conduzir(
	C_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	C_Datahora DATETIME NOT NULL,
	Conduzir_Con_ID int not null Unique,
	Conduzir_Car_ID INT NOT NULL,
	FOREIGN KEY(Conduzir_Car_ID) REFERENCES Carro(Car_ID),
	FOREIGN KEY(Conduzir_Con_ID) REFERENCES Condutor(Con_ID)
);

/********************
*  Lista de Entidades de Associação
********************/			
CREATE TABLE Viagem (
	Via_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Via_pntRecolha varchar(100) NOT NULL,
	Via_pntDestino varchar(100) NOT NULL,
	Via_dataHoraRec DATETIME NOT NULL,
	Via_dataHoraDst DATETIME NOT NULL,
	Via_CodUnico INT Unique NOT NULL,
	CONSTRAINT CHK_Codigo CHECK (LEN(Via_CodUnico) = 6)
	);

CREATE TABLE SclienteVe.clAVcond(
	AVcon_ID int primary key  identity(1,1) not null,
	AVcon_Datahora datetime not null,
	AVcon_estrelas int not null,
	AVcon_ClID int not null,
	AVcon_ConID INT NOT NULL,
	AVcon_ViID int not null,	


);

CREATE TABLE CondAVcl(
	AVcl_ID int primary key identity(1,1) not null,
	AVcl_Datahora datetime not null,
	AVcl_estrelas int not null,
	AVcl_ConID INT NOT NULL,
	AVcl_ClID int not null,
	AVcl_ViID int not null,
	
);

CREATE TABLE Abranger(
	Abranger_ID INT primary key identity(1,1) NOT NULL,
	Abranger_CP_Rec_ID INT NOT NULL,
	Abranger_CP_Dest_ID INT NOT NULL,
	Abranger_ViaID INT NOT NULL,
	FOREIGN KEY(Abranger_CP_Rec_ID) REFERENCES CodPostal(CP_id),
	FOREIGN KEY(Abranger_CP_Dest_ID) REFERENCES CodPostal(CP_id),
	FOREIGN KEY(Abranger_ViaID) REFERENCES Viagem(Via_id),
);

CREATE TABLE Conter(
	Conter_Via_ID INT NOT NULL,
	Conter_Tar_ID INT NOT NULL,
	FOREIGN KEY(Conter_Via_ID) REFERENCES Viagem(Via_id),
	FOREIGN KEY(Conter_Tar_ID) REFERENCES Tarifa(Tar_id),
	Primary key(Conter_Via_ID ,Conter_Tar_ID)
);

CREATE TABLE Gerar(
	Ger_ID int primary key not null identity(1,1),
	Ger_DataHora datetime not null,
	Ger_FatID int not null,
	Ger_ViaID int not null,
	FOREIGN KEY(Ger_FATID) REFERENCES Fatura(Fat_id),
	FOREIGN KEY(Ger_ViaID) REFERENCES Viagem(Via_id)
);

CREATE TABLE Pagar(
	Pag_ID INT NOT NULL IDENTITY(1,1),
	Pag_DataHora datetime not null,
	Pagar_MetID int not null,
	Pagar_FatID int not null,
	FOREIGN KEY(Pagar_MetID) REFERENCES MetPagamento(Met_id),
	FOREIGN KEY(Pagar_FatID) REFERENCES Fatura(Fat_id)
);

CREATE TABLE Deter(
	Det_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Det_DataHora datetime not null,
	Deter_Cl_ID INT NOT NULL UNIQUE,
	Deter_Est_ID INT NOT NULL,
	FOREIGN KEY(Deter_Est_ID) REFERENCES Estatuto(Est_ID),
);

CREATE TABLE Ter(
	Ter_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Ter_DataHora Datetime not null,
	Ter_ClID INT NOT NULL,
	Ter_MetID INT NOT NULL,
	FOREIGN KEY(Ter_MetID) REFERENCES MetPagamento(Met_ID),
);

CREATE TABLE Obter(
	Obt_ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Obt_DataHora DATETIME NOT NULL,
	Obt_Quantia MONEY NOT NULL,
	Obt_FatID INT NOT NULL,
	Obt_EstID INT NOT NULL,
	FOREIGN KEY(Obt_FatID) REFERENCES Fatura(Fat_ID),
	FOREIGN KEY(Obt_EstID) REFERENCES Estatuto(Est_ID)
);

/********************
*  Fazer inserts
********************/

INSERT INTO SclienteVe.Tabela VALUES
(3,'2022-03-11 17:26:58'),
(2,'2022-03-28 19:53:13'),
(4,'2022-01-11 06:32:52')

INSERT INTO Sadmin.Cliente VALUES
('2000-11-26', 'Royce', 'Karpmann', 'Lambal', 'M', 447114553, 'rlambale@ustream.tv'),
 ('2010-12-02', 'Albertine', 'Orry', 'MacLise', 'F', 289796637, 'amaclisef@tamu.edu'),
 ('2004-02-02', 'Garv', 'Helleker', 'Roycroft', 'M', 893116392, 'groycroftg@state.tx.us'),
 ('2010-09-11', 'Ozzie', 'Keys', 'Tollerton', 'M', 865162682, 'otollertonh@cloudflare.com'),
('2007-03-22', 'Ellsworth', null, 'Daymond', 'M', 296597455, 'edaymondi@foxnews.com'),
('2000-06-06', 'Papagena', null, 'Tremmil', 'F', 605288742, 'ptremmilj@google.co.jp'),
 ('2000-02-24', 'Ezmeralda', 'Truitt', 'McLise', 'F',820114993, 'emclisek@booking.com'),
('2000-04-29', 'Cory', 'Grundell', 'McLeoid', 'M', 941850179, 'cmcleoidl@skyrock.com'),
('2000-08-24', 'Julianna', 'Calver', 'Demonge', 'F', 630502657, 'jdemongem@ca.gov'),
('2000-04-04', 'Griffith', null, 'Scullard', 'M', 487429977, 'gscullardn@1und1.de'),
('2000-06-09', 'Marion', 'Symms', 'Dewer', 'M', 172318552, 'mdewero@cpanel.net'),
('2000-10-05', 'Jamison', 'Watting', 'Hinken', 'M', 177430946, 'jhinkenp@360.cn'),
('2100-02-15', 'Selina', 'Farnell', 'Wank', 'F', 167596607, 'swank0@blog.com')


/*********************************
*  Admin: Tem todo o tipo de acesso aos dados e pode criar/apagar tabelas no schema Desenvolvedor
*********************************/

GRANT SELECT ON SCHEMA::Sadmin TO Radmin
GO
GRANT CONTROL ON SCHEMA::Sadmin TO Radmin
GO
GRANT INSERT ON SCHEMA::Sadmin TO Radmin
GO
GRANT UPDATE ON SCHEMA::Sadmin TO Radmin
GO
GRANT REFERENCES ON SCHEMA::Sadmin TO Radmin
GO
GRANT CREATE TABLE TO Radmin
GO

EXEC AS USER = 'Uadmin' 

select * from Sadmin.Cliente

REVERT
 /********************
*  Utilizador: Pode ver, por exemplo, as avalições dos condutores
********************/
GRANT SELECT ON SCHEMA::SclienteVe TO Rcliente
GO
DENY INSERT ON SCHEMA::SclienteVe TO Rcliente
GO

EXEC AS USER = 'Ucliente'

SELECT* FROM SclienteVe.Tabela
INSERT INTO SclienteVe.Tabela VALUES (1,'2022-03-11 17:26:58')

REVERT

 /********************
*  Avaliador: Pode inserir avaliações mas não as pode ver
********************/
GRANT INSERT ON SCHEMA::SclienteVe TO Ravaliador
GO
DENY SELECT ON SCHEMA::SclienteVe To Ravaliador
GO
EXEC AS USER = 'Uavaliador'

INSERT INTO SclienteVe.Tabela VALUES (1,'2022-03-11 17:26:58')
SELECT* FROM SclienteVe.Tabela

REVERT

 /********************
* Podemos verificar quem está a usar a base de dados e os schemas criados
********************/
GO
sp_who
GO
EXEC sp_tables
SELECT CURRENT_USER

/************************************************************
*  Encriptação
************************************************************/

/************************************************************
*  Criação da chave mestra
************************************************************/

CREATE MASTER KEY ENCRYPTION
BY PASSWORD = 'pass'
GO
/************************************************************
*  Criação do Certificado
************************************************************/

CREATE CERTIFICATE CertificadoTest1
WITH SUBJECT = 'CertificadoTest'
GO
/************************************************************
*  Criação de uma chave simetrica utilizando o algoritmo AES_256
************************************************************/

CREATE SYMMETRIC KEY ChavesimetricaTest
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CertificadoTest1
/************************************************************
*  Verificar a criação da chave e certificado
************************************************************/

SELECT * FROM SYS.symmetric_keys
GO
SELECT * FROM SYS.certificates
GO

/************************************************************
*  Aplicar a encriptação simetrica
************************************************************/
alter table metpagamento
add metnumCartao_encrypt varbinary(max) null
go
/************************************************************
* Store Procedure para encriptação simetrica de coluna
************************************************************/
Create or alter Procedure spEncriptarCartaoCliente
AS BEGIN

OPEN SYMMETRIC KEY ChavesimetricaTest 
DECRYPTION BY CERTIFICATE CertificadoTest1

Update MetPagamento
set metnumCartao_encrypt =ENCRYPTBYKEY(key_guid('ChavesimetricaTest'),Met_numCartao) from MetPagamento
CLOSE SYMMETRIC KEY ChavesimetricaTest

end
go
/************************************************************
* Triger para ativar a Store procedure spEncriptarCartaoCliente
************************************************************/
CREATE OR ALTER TRIGGER TR_EexecEncriptarCartaoCliente ON MetPagamento
AFTER INSERT AS BEGIN

DECLARE @StartTime DATETIME
DECLARE @EndTime DATETIME

SET @StartTime = GETDATE();

EXEC spEncriptarCartaoCliente

SET @EndTime = GETDATE();

PRINT 'A chave Simetrica a encriptar demorou (ms): ' + CONVERT(CHAR, DATEDIFF(ms, @StartTime, @EndTime)); 
end

GO
-- TESTAR 
INSERT INTO metpagamento VALUES
(2025,2,'123456729014345', 633,null);

select * from MetPagamento

GO

/************************************************************
*  Desencriptar os dados
************************************************************/
Create or alter Procedure spDesencriptarCartaoCliente
AS BEGIN

OPEN SYMMETRIC KEY ChavesimetricaTest
DECRYPTION BY CERTIFICATE CertificadoTest1;

DECLARE @StartTime DATETIME; 
DECLARE @EndTime DATETIME; 

SET @StartTime = GETDATE();

SELECT met_ano, met_mes,met_numcartao,met_cvv,metnumCartao_encrypt AS 'Numero de Cartao Ecriptado',
CONVERT(varchar, DecryptByKey(metnumCartao_encrypt)) AS 'Numero de cartao desencriptado'
FROM MetPagamento;

SET @EndTime = GETDATE();

PRINT 'A chave simetrica a desencriptar demorou (ms): ' + CONVERT(CHAR, DATEDIFF(ms, @StartTime, @EndTime)); 
end

go

EXEC spDesencriptarCartaoCliente

/************************************************************
*  Encriptação assimetrica
************************************************************/
/************************************************************
*  Criar chave assimetrica
************************************************************/
CREATE ASYMMETRIC KEY chaveAssimetrica1
WITH ALGORITHM = RSA_2048
ENCRYPTION BY PASSWORD = 'Pass'

/************************************************************
*  Ver chave assimetrica
************************************************************/
SELECT * FROM  sys.asymmetric_keys

/************************************************************
*  Adicionar coluna para ecriptação
************************************************************/
ALTER TABLE Sadmin.Cliente 
ADD TelemovelEncriptado varbinary(MAX) NULL,
    EmailEncriptado varbinary(MAX) NULL;
GO

/************************************************************
*  Stock Procedure para Encriptar a coluna 
************************************************************/
Create or alter Procedure spEncriptarCliente
AS BEGIN

UPDATE Sadmin.Cliente
SET TelemovelEncriptado = ENCRYPTBYASYMKEY(ASYMKEY_ID('chaveAssimetrica1'), CAST(Cl_Telemovel AS varchar)) ,
	EmailEncriptado = ENCRYPTBYASYMKEY(ASYMKEY_ID('chaveAssimetrica1'),Cl_email)
FROM Sadmin.Cliente 

SELECT * FROM Sadmin.cliente

end
go
/************************************************************
*  TRIGER PARA ATIVAR O STORE PROCEDURE 
************************************************************/
CREATE OR ALTER TRIGGER TR_EexecEncriptaCliente ON Sadmin.cliente
AFTER INSERT AS BEGIN

DECLARE @StartTime DATETIME
DECLARE @EndTime DATETIME

SET @StartTime = GETDATE();

EXEC spEncriptarCliente

SET @EndTime = GETDATE();

PRINT 'A chave assimetrica a encriptar demorou (ms): ' + CONVERT(CHAR, DATEDIFF(ms, @StartTime, @EndTime)); 
end

GO
-- TESTAR 
INSERT INTO Sadmin.Cliente VALUES
('2000-02-15', 'Joana', 'Farnell', 'Wank', 'F', 937152607, 'swank87@blog.com',null,null);

go
/************************************************************
*  Desincriptar a coluna 
************************************************************/
Create or alter Procedure spDesencriptarCliente
AS BEGIN

DECLARE @StartTime DATETIME
DECLARE @EndTime DATETIME

SET @StartTime = GETDATE();

select *,TelemovelDesencriptado =  Convert(char(11),DECRYPTBYASYMKEY(ASYMKEY_ID('chaveAssimetrica1'), TelemovelEncriptado, N'Pass'))
FROM sadmin.cliente

select *,EmailDesencriptado =  Convert(char(11),DECRYPTBYASYMKEY(ASYMKEY_ID('chaveAssimetrica1'), EmailEncriptado, N'Pass'))
FROM sadmin.cliente;

SET @EndTime = GETDATE();
PRINT 'A chave assimetrica a desencriptar demorou (ms): ' + CONVERT(CHAR, DATEDIFF(ms, @StartTime, @EndTime)); 

END
go

EXEC spDesencriptarCliente

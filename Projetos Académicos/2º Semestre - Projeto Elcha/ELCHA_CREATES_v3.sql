/************************************************************
*  CREATES BASE DE DADOS ELCHA - INICIO
************************************************************/

/************************************************************
*	Grupo: 5    |  Curso: Informática de Gestão
*  	UC: Bases de Dados
*
*	Pojeto: ELCHA
*
*  	Nome: Eduardo Domingues (20200377)
*  	Nome: Gonçalo Carvalho (20200573)
*  	Nome: Pedro Cunha (20200908)
************************************************************/

/************************************************************
*  CRIAR E SELECIONAR A BASE DE DADOS
************************************************************/
CREATE DATABASE ELCHA_DB;
USE ELCHA_DB;

/************************************************************
*  Lista de Entidades Informacionais Primarias
************************************************************/
CREATE TABLE AppUser (
    Us_ID INT NOT NULL AUTO_INCREMENT,
    Us_firstName VARCHAR(50) NOT NULL,
    Us_lastName VARCHAR(50) NOT NULL,
    Us_gender CHAR(1) NOT NULL,
    Us_email VARCHAR(255) NOT NULL,
    Us_dob DATE NOT NULL,
    Us_points INT DEFAULT 10, -- RI10: Validar regra - Quando um utilizador cria um avatar, este ganha 10 pontos 
    Us_level VARCHAR(20) DEFAULT 'NO LEVEL', -- RI09: Validar regra - Quando um utilizador cria um avatar, este não possui qualquer tipo de nível 
    Us_gems INT DEFAULT 150, -- RI11: Validar regra - Quando um utilizador cria um avatar, este ganha 150 gemas 
    Us_status BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (Us_ID),
    UNIQUE KEY (Us_email), -- RI19: Validar regra - Não podem existir e-mails repetidos 
    CONSTRAINT `chk1_Gender` CHECK (Us_gender = 'M' OR Us_gender = 'F') -- RI12: Validar regra - O género do utilizador só pode ser masculino(M) ou feminino(F) 
);

CREATE TABLE Task (
    Task_ID INT NOT NULL AUTO_INCREMENT,
    Task_name VARCHAR(60) NOT NULL,
    Task_description VARCHAR(255) NOT NULL,
    Task_points INT NOT NULL DEFAULT 10,
    Task_category VARCHAR(40) NOT NULL,
    Task_gems INT NOT NULL DEFAULT 50,
    CONSTRAINT `chk2_Category` CHECK (Task_category = 'Technology'
									OR Task_category = 'Physic'
									OR Task_category = 'Mental'
									OR Task_category = 'Sustainability'), -- RI02: Validar regra - As categorias das Tarefas só podem ser quatro
    PRIMARY KEY (Task_ID),
    UNIQUE KEY (Task_name)
);

CREATE TABLE Personalization (
    Per_ID INT NOT NULL AUTO_INCREMENT,
    Per_name VARCHAR(40) NOT NULL,
    Per_type VARCHAR(40) NOT NULL,
    Per_gems INT NOT NULL,
    CONSTRAINT `chk3_Type` CHECK (Per_type = 'Head' 
									OR Per_type = 'Body'
									OR Per_type = 'Legs'
									OR Per_type = 'Feet'
									OR Per_type = 'Accessory'), -- RI04: Validar regra - Tipo de personalização
    PRIMARY KEY (Per_ID),
    UNIQUE KEY (Per_name)
);

CREATE TABLE Badge (
    Bad_ID INT NOT NULL AUTO_INCREMENT,
    Bad_name VARCHAR(40),
    Bad_description VARCHAR(255),
    Bad_type VARCHAR(40),
    CONSTRAINT `chk5_Category` CHECK (Bad_type = 'Technology'
									OR Bad_type = 'Physic'
									OR Bad_type = 'Mental'
									OR Bad_type = 'Sustainability'), -- RI06: Validar regra - O tipo de medalha só pode ser de quatro tipos
    PRIMARY KEY (Bad_ID),
    UNIQUE KEY (Bad_name)
);

CREATE TABLE Message (
    Mess_ID INT NOT NULL AUTO_INCREMENT,
    Mess_text VARCHAR(255),
    PRIMARY KEY (Mess_ID)
);

CREATE TABLE PostalCode (
    Pc_ID INT NOT NULL AUTO_INCREMENT,
    Pc_4D CHAR(4) NOT NULL,
    Pc_3D CHAR(3) NOT NULL,
    Pc_block VARCHAR(30),
    Pc_parish VARCHAR(40),
    Pc_country VARCHAR(40),
    PRIMARY KEY (Pc_ID)
);

/************************************************************
*  Lista de Entidades Fracas
************************************************************/
CREATE TABLE Avatar (
    Ava_ID INT NOT NULL AUTO_INCREMENT,
    Ava_Us_ID INT,
    Ava_nickname VARCHAR(60) NOT NULL,
    FOREIGN KEY (Ava_Us_ID)
        REFERENCES AppUser (Us_ID),
    PRIMARY KEY (Ava_ID)
);

/************************************************************
*  Lista de Entidades Informacionais com FK
************************************************************/
CREATE TABLE PhoneNr (
    Phnr_ID INT NOT NULL AUTO_INCREMENT,
    Phnr_Us_ID INT,
    Phnr_code VARCHAR(6) NOT NULL,
    Phnr_number VARCHAR(15) NOT NULL,
    PRIMARY KEY (Phnr_ID),
	FOREIGN KEY (Phnr_Us_ID)
        REFERENCES AppUser (Us_ID),
    UNIQUE KEY (Phnr_number) -- RI14: Validar regra - Não podem existir números de telefone repetidos 
);

CREATE TABLE Friendship (
    Fnd_ID INT AUTO_INCREMENT,
    Fnd_Us_ID1 INT,
    Fnd_Us_ID2 INT,
    Fnd_dtEstablished DATE NOT NULL,
    CHECK (Fnd_Us_ID1 != Fnd_Us_ID2),
    PRIMARY KEY (Fnd_ID),
    FOREIGN KEY (Fnd_Us_ID1)
        REFERENCES AppUser (Us_ID),
    FOREIGN KEY (Fnd_Us_ID2)
        REFERENCES AppUser (Us_ID)
);

/************************************************************
*  Lista de Entidades de Associacao
************************************************************/
CREATE TABLE Concludes (
    Conc_ID INT NOT NULL AUTO_INCREMENT,
    Conc_Us_ID INT,
    Conc_Task_ID INT,
    Conc_sDate DATE NOT NULL,
    Conc_cDate DATE,
    Conc_status VARCHAR(20),
    PRIMARY KEY (Conc_ID),
    FOREIGN KEY (Conc_Us_ID)
        REFERENCES AppUser (Us_ID),
    FOREIGN KEY (Conc_Task_ID)
        REFERENCES Task (Task_ID)
);    

CREATE TABLE Customized (
    Cust_ID INT NOT NULL AUTO_INCREMENT,
    Cust_Ava_ID INT,
    Cust_Per_ID INT,
    Cust_since DATE NOT NULL,
    PRIMARY KEY (Cust_ID),
    FOREIGN KEY (Cust_Ava_ID)
        REFERENCES Avatar (Ava_ID),
    FOREIGN KEY (Cust_Per_ID)
        REFERENCES Personalization (Per_ID)
);

CREATE TABLE Secures (
    Sc_ID INT NOT NULL AUTO_INCREMENT,
    Sc_Us_ID INT,
    Sc_Bad_ID INT,
    Sc_since DATE NOT NULL,
    PRIMARY KEY (Sc_ID),
    FOREIGN KEY (Sc_Bad_ID)
        REFERENCES Badge (Bad_ID),
    FOREIGN KEY (Sc_Us_ID)
        REFERENCES AppUser (Us_ID)
);

CREATE TABLE Lives (
    Lives_ID INT NOT NULL AUTO_INCREMENT,
    Lives_Us_ID INT,
    Lives_PC_ID INT,
    Lives_date DATE NOT NULL,
    PRIMARY KEY (Lives_ID),
    FOREIGN KEY (Lives_Us_ID)
        REFERENCES AppUser (Us_ID),
    FOREIGN KEY (Lives_PC_ID)
        REFERENCES PostalCode (PC_ID)
);

CREATE TABLE Send (
    Send_ID INT NOT NULL AUTO_INCREMENT,
    Send_US_IDsender INT,
    Send_US_IDreceiver INT,
    Send_Mess_ID INT,
    Send_date DATE NOT NULL,
    CHECK (Send_US_IDsender != Send_US_IDreceiver),
    PRIMARY KEY (Send_ID),
    FOREIGN KEY (Send_US_IDsender)
        REFERENCES AppUser (Us_ID),
    FOREIGN KEY (Send_US_IDreceiver)
        REFERENCES AppUser (Us_ID),
    FOREIGN KEY (Send_Mess_ID)
        REFERENCES Message (Mess_ID)
);
/************************************************************
*  CREATES BASE DE DADOS ELCHA - FIM
************************************************************/
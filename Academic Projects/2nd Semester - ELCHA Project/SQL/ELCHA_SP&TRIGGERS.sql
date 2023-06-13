/************************************************************
*  TRIGGERS/SP BASE DE DADOS ELCHA
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

use ELCHA_DB;

/************************************************************
*  SP/TRIGGER PARA VERIFICAR IDADE E EMAIL - INICIO
RI13/RI21: Validar regra - Idade tem de ser maior ou igual 
que 60 e menor ou igual a 120 e o e-mail tem de ser valido 
************************************************************/
DELIMITER $$
CREATE PROCEDURE SP_validate_appUser(IN Us_dob date, IN Us_email VARCHAR(255))
BEGIN
	DECLARE Us_Age int DEFAULT 0;
    SET Us_Age = TIMESTAMPDIFF(YEAR, Us_dob, CURDATE());
    
    IF Us_Age < 60 or Us_Age > 120 THEN
		SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'ERROR: User Age must be between 60 and 120';
    END IF;
	IF NOT (SELECT Us_email REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,63}$') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR: This E-mail is not valid!';
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER TRG_validate_AppUser_insert
BEFORE INSERT ON AppUser FOR EACH ROW
BEGIN
	CALL SP_validate_appUser(NEW.Us_dob, NEW.Us_email);
END$$
DELIMITER ;
/************************************************************
*  SP/TRIGGER PARA VERIFICAR IDADE E EMAIL - FIM
************************************************************/

/**********************************************************************************
*  TRIGGER PARA VERIFICAR TASK - INICIO
RI01/RI03: Validar regra - Os pontos das tarefas são no mínimo 10 e no máximo 250,
O mínimo de gemas ganhas por realizar uma tarefa é 50 e o máximo é 250
**********************************************************************************/
DELIMITER $$
CREATE PROCEDURE SP_validate_Task(IN Task_points INT, IN Task_gems INT)
BEGIN		
	IF (Task_points < 10 or Task_points > 250) THEN
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'ERROR: This Amount of Points is Invalid!';
    END IF;
    
    IF (Task_gems < 50 or Task_gems > 250) THEN
		SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'ERROR: This Amount of Gems is Invalid!';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER TRG_validate_Task
BEFORE INSERT ON Task FOR EACH ROW
BEGIN
	CALL SP_validate_Task(NEW.Task_points, NEW.Task_gems);
END$$
DELIMITER ;
/************************************************************
*  TRIGGER PARA VERIFICAR TASK - FIM
************************************************************/

/**************************************************************************************
*  TRIGGER PARA VERIFICAR PERSONALIZATION - INICIO
RI05: Validar regra - O preço mínimo de um item de personalização é 50 e o máximo 1500
**************************************************************************************/
DELIMITER $$
CREATE PROCEDURE SP_validate_Personalization(IN Per_gems INT)
BEGIN		
	IF (Per_gems < 50 or Per_gems > 1500) THEN
		SIGNAL SQLSTATE '45003' SET MESSAGE_TEXT = 'ERROR: This Amount of Gems is Invalid!';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER TRG_validate_Personalization
BEFORE INSERT ON Personalization FOR EACH ROW
BEGIN
	CALL SP_validate_Personalization(NEW.Per_gems);
END$$
DELIMITER ;
/************************************************************
*  TRIGGER PARA VERIFICAR PERSONALIZATION - FIM
************************************************************/

/**************************************************************
*  TRIGGER PARA VERIFICAR NUMERO NACIONAL - INICIO
RI22: Validar regra - Um número de telefone com o código “+351” 
tem de ter exatamente 9 dígitos para ser válido 
**************************************************************/
DELIMITER $$
CREATE TRIGGER TRG_validate_PhoneNr_PT
BEFORE INSERT ON PhoneNr FOR EACH ROW
BEGIN
	DECLARE numLength INT;
    SET numLength = (SELECT LENGTH(NEW.Phnr_number));
		
	IF (numLength <> 9) THEN
		SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = 'ERROR: This Phone Number is not Portuguese!';
    END IF;
END$$
DELIMITER ;
/************************************************************
*  TRIGGER PARA VERIFICAR NUMERO NACIONAL - FIM
************************************************************/

/********************************************************************************************
*  TRIGGER PARA VERIFICAR CODIGO POSTAL NACIONAL - INICIO
RI07/RI08: Validar regra - O código postal de 4 dígitos tem de ter obrigatoriamente 4 dígitos, 
o código postal de 3 dígitos tem de ter obrigatoriamente 3 dígitos
********************************************************************************************/
DELIMITER $$
CREATE TRIGGER TRG_validate_PC_PT
BEFORE INSERT ON PostalCode FOR EACH ROW
BEGIN
	DECLARE Pc_4DLength INT;
    DECLARE Pc_3DLength INT;
    
    SET Pc_4DLength = (SELECT LENGTH(NEW.Pc_4D));
    SET Pc_3DLength = (SELECT LENGTH(NEW.Pc_3D));
		
	IF (Pc_4DLength <> 4) or (Pc_3DLength <> 3) THEN
		SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'ERROR: This Postal Code is not Portuguese!';
    END IF;
END$$
DELIMITER ;
/************************************************************
*  TRIGGER PARA VERIFICAR CODIGO POSTAL NACIONAL - FIM
************************************************************/

/*****************************************************************
*  TRIGGER DE DELETE - INICIO
-- Quando execuatado, não deixa realizar delete na tabela Avatar
e altera o atributo 'Us_status' para false, ou seja, desativo,
simulando assim que o user apagou a sua conta
-- Não está a mudar o atributo para 0
****************************************************************/
DELIMITER //
CREATE TRIGGER TRG_delete_user BEFORE DELETE ON Avatar
FOR EACH ROW
BEGIN
	UPDATE AppUser
    SET Us_status = 0
    WHERE Us_ID = OLD.Ava_Us_ID;
    SIGNAL SQLSTATE '45006' SET MESSAGE_TEXT = 'Deleting from the table Avatar is forbidden!';
END//
DELIMITER ;

select * from appuser
drop trigger trg_delete_user
/************************************************************
*  TRIGGER DE DELETE - FIM
************************************************************/

/****************************************************************
*  SP PARA GERAR DUMMY DATA PARA A TABELA APPUSER, TASK - INICIO
Gera Dummy Data em 3 tabelas distintas de uma só vez  
****************************************************************/ 
DELIMITER //
CREATE PROCEDURE sp_InsertRandomData (IN firstNum INT, IN lastNum INT, IN firstNum2 INT, IN lastNum2 INT, IN firstNum3 INT, IN lastNum3 INT)
BEGIN
	DECLARE Count INT DEFAULT firstNum;
    DECLARE Count2 INT DEFAULT firstNum2;
    DECLARE Count3 INT DEFAULT firstNum3;
    DECLARE dt DATETIME DEFAULT '1955/01/01';
       
    WHILE (Count <= lastNum) DO
		INSERT INTO AppUser (Us_firstName, Us_lastName, Us_gender, Us_email, Us_dob, Us_status) 
		VALUES (
			CONCAT('FirstName', Count),
			CONCAT('LastName', Count),
            "M",
            CONCAT('Email', Count, '@elcha.pt'),
            dt,
            1
		);
        SET dt = DATE(dt) + INTERVAL 5 DAY;
		SET Count = Count + 1;
	END WHILE;
    
    WHILE (Count2 <= lastNum2) DO
		INSERT INTO Task (Task_name, Task_description, Task_points, Task_category, Task_gems)
        VALUES (
			CONCAT('Name', Count2),
            CONCAT('Description', Count2),
            FLOOR(10 + (RAND() * 100)),
            "Technology",
            FLOOR(50 + (RAND() * 100))
        );
		SET Count2 = Count2 + 1;
	END WHILE;
    
    WHILE (Count3 <= lastNum3) DO
		INSERT INTO Avatar (Ava_nickname)
        VALUES (
            CONCAT('Nickname', Count3)
        );
		SET Count3 = Count3 + 1;
	END WHILE;
END//
DELIMITER ;
/****************************************************************
*  SP PARA GERAR DUMMY DATA PARA A TABELA APPUSER, TASK - FIM  
****************************************************************/ 

/***********************************************************************************************
*  SP PARA ATRIBUIR NIVEL AO UTILIZADOR - INICIO
RI20: Validar regra - Se o utilizador tiver menos de 100 pontos não possui nenhum tipo de nível,
se o utilizador tiver entre 101 e 500 pontos é nível bronze, se o utilizador tiver entre 
501 e 1500 pontos é nível prata, se o utilizador tiver entre 1501 e 3000 pontos é nível ouro, 
se o utilizador tiver entre 3001 e 5000 pontos é nível diamante. 
***********************************************************************************************/
DELIMITER //
CREATE PROCEDURE sp_appUser()
BEGIN
	SELECT Us_ID AS "User ID", CONCAT(Us_firstName, Us_lastName) AS "Name", Us_gender AS "Gender", TIMESTAMPDIFF(YEAR, Us_dob, CURDATE()) AS "Age", Us_email AS "e-mail",
		CASE
            WHEN Us_points <= 100 THEN 'No level'
			WHEN Us_points BETWEEN 101 AND 500 THEN 'Bronze'
			WHEN Us_points BETWEEN 501 AND 1500 THEN "Silver"
			WHEN Us_points BETWEEN 1501 AND 3000 THEN "Gold"
			WHEN Us_points BETWEEN 3001 AND 5000 THEN "Diamond"
		END AS 'Level'
		FROM appUser, Concludes
        WHERE Us_ID = Conc_Us_ID;
END//
DELIMITER ;
/***********************************************************************************************
*  SP PARA ATRIBUIR NIVEL AO UTILIZADOR - FIM
***********************************************************************************************/

/**************************************************************
*  TRIGGER PARA ATRIBUIR PONTOS E GEMAS AO UTILIZADOR - INICIO
DELIMITER $$
CREATE PROCEDURE SP_give_pointsAndGemsToUser()
BEGIN
    
	IF (Conc_Us_ID = Us_ID) AND (Conc_Task_ID = Task_ID) THEN
		UPDATE AppUser
        SET Us_points = Us_points + Task_points;
        SET Us_gems = Us_gems + Task_gems;
	END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER TRG_give_pointsAndGemsToUser
AFTER INSERT ON Concludes FOR EACH ROW
BEGIN
	CALL SP_give_pointsAndGemsToUser(NEW.Conc_Us_ID, NEW.Conc_Task_ID, Us_ID, Us_points, Us_gems, Task_ID, Task_points, Task_gems);
END$$
DELIMITER ;
*  TRIGGER PARA ATRIBUIR PONTOS E GEMAS AO UTILIZADOR - FIM
NÃO ESTA A FUNCIONAR
**************************************************************/

/************************************************************
*  SP PARA DESPOLTAR TRIGGER - INICIO  
************************************************************/
DELIMITER //
CREATE PROCEDURE sp_activate_trigger (IN firstNum INT, IN lastNum INT)
BEGIN
	DECLARE Count INT DEFAULT firstNum; 
    DECLARE dt DATETIME DEFAULT '2020/01/01'; 
       
    WHILE (Count <= lastNum) DO
		INSERT INTO AppUser (Us_firstName, Us_lastName, Us_gender, Us_email, Us_dob) 
		VALUES (
			CONCAT('FirstName', Count),
			CONCAT('LastName', Count),
            "M",
            CONCAT('Email', Count, '@elcha.pt'),
            dt
		);
	END WHILE;
END//
DELIMITER ;
/************************************************************
*  SP PARA DESPOLTAR TRIGGER - FIM  
************************************************************/

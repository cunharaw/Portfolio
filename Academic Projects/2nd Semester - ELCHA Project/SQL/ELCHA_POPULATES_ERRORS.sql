/************************************************************
*  POPULATES COM ERROS BASE DE DADOS ELCHA
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
*  Executar o SP para despoltar trigger:
************************************************************/
call sp_activate_trigger(1,5);

/************************************************************
*  INSERIR DADOS NA TABELA APPUSER
************************************************************/
INSERT INTO AppUser VALUES (DEFAULT, 'Ana', 'Costa', 'F', 'ana@elcha.pt', '2002-04-20', default, DEFAULT, DEFAULT, DEFAULT); -- Testa Trigger validate_appUser com idade < 60 ('ERROR: User Age must be between 60 and 120')
INSERT INTO AppUser VALUES (DEFAULT, 'Paulo', 'Andrade', 'M', 'paulo@elcha.pt', '1900-01-01', default, DEFAULT, DEFAULT, DEFAULT); -- Testa Trigger validate_appUser com idade > 120 ('ERROR: User Age must be between 60 and 120')
INSERT INTO AppUser VALUES (DEFAULT, 'Hugo', 'Mendes', 'U', 'hmendes@elcha.pt', '1920-03-01', default, DEFAULT, DEFAULT, DEFAULT); -- Testa Check(Us_gender = 'M' OR Us_gender = 'F')
INSERT INTO AppUser VALUES (DEFAULT, 'Catarina', 'Santos', 'F', 'catarina.pt', '1950-02-14', default, DEFAULT, DEFAULT, DEFAULT); -- Testa Trigger validate_appUser com e-mail sem @ ('ERROR: This E-mail is not valid!')

/************************************************************
*  INSERIR DADOS NA TABELA TASK
************************************************************/
INSERT INTO Task VALUES (DEFAULT, 'New Friends', 'Add a new friend', 2 , 'Technology', 100); -- Testa Trigger TRG_validate_Task (pontos menores que 10)
INSERT INTO Task VALUES (DEFAULT, 'New Friends', 'Add a new friend', 600 , 'Technology', 100); -- Testa Trigger TRG_validate_Task (pontos maiores que 250)
INSERT INTO Task VALUES (DEFAULT, 'Begin with economy', 'get some money', 100 , 'Finance', 150); -- Testa check das 4 categorias
INSERT INTO Task VALUES (DEFAULT, 'Soduku', 'Play a Soduku game', 100 , 'Mental', 10); -- Testa Trigger TRG_validate_Task (gemas menores que 50)
INSERT INTO Task VALUES (DEFAULT, 'Walking', 'Go for a walk', '200', 'Physic', '400'); -- Testa Trigger TRG_validate_Task (gemas maiores que 250)

/************************************************************
*  INSERIR DADOS NA TABELA PERSONALIZATION
************************************************************/
INSERT INTO Personalization VALUES (DEFAULT, 'Smart Watch', 'Hands', 1000); -- Testa check de 5 tipos de personalização
INSERT INTO Personalization VALUES (DEFAULT, 'Cool Blue Shirt', 'Body', 20); -- Testa Trigger TRG_validate_Personalization (preço menor que 50)
INSERT INTO Personalization VALUES (DEFAULT, 'Cool Blue Shirt', 'Body', 2000); -- Testa Trigger TRG_validate_Personalization (preço maior que 1500)

/************************************************************
*  INSERIR DADOS NA TABELA BADGE
************************************************************/
INSERT INTO Badge VALUES (DEFAULT, 'Start a Game', 'Have fun online with friends', 'Gaming'); -- testa check das 4 categorias

/************************************************************
*  INSERIR DADOS NA TABELA POSTALCODE
************************************************************/
INSERT INTO PostalCode VALUES (DEFAULT, '300', '001', 'Tondela', 'Lisboa', 'Portugal'); -- Testa Trigger TRG_validate_PC_PT (código postal de 4 dígitos tem de ter obrigatoriamente 4 dígitos)
INSERT INTO PostalCode VALUES (DEFAULT, '25800', '001', 'Arroios', 'Lisboa', 'Portugal'); -- Testa Trigger TRG_validate_PC_PT (código postal de 4 dígitos tem de ter obrigatoriamente 4 dígitos)
INSERT INTO PostalCode VALUES (DEFAULT, '1000', '50', 'Oeiras', 'Lisboa', 'Portugal'); -- Testa Trigger TRG_validate_PC_PT (código postal de 3 dígitos tem de ter obrigatoriamente 3 dígitos)
INSERT INTO PostalCode VALUES (DEFAULT, '5602', '3024', 'Belem', 'Lisboa', 'Portugal'); -- Testa Trigger TRG_validate_PC_PT (código postal de 3 dígitos tem de ter obrigatoriamente  dígitos)

/************************************************************
*  INSERIR DADOS NA TABELA PHONENR
************************************************************/
INSERT INTO PhoneNr VALUES (31, DEFAULT, '+351', '918097344'); -- testa numeros repetidos
INSERT INTO PhoneNr VALUES (32, DEFAULT, '+351', '918097344'); -- testa numeros repetidos
INSERT INTO PhoneNr VALUES (33, DEFAULT, '+351', '9180973440'); -- Testa Trigger TRG_validate_PhoneNr_PT (numero com mais de 9 digitos)
INSERT INTO PhoneNr VALUES (34, DEFAULT, '+351', '91809734'); -- Testa Trigger TRG_validate_PhoneNr_PT (numero com menos de 9 digitos)

/************************************************************
*  INSERIR DADOS NA TABELA FRIENDSHIP
************************************************************/
INSERT INTO Friendship VALUES (DEFAULT, 4, 4, '2020-10-06'); -- testa check ser amigo de si mesmo

/************************************************************
*  INSERIR DADOS NA TABELA Send
************************************************************/
INSERT INTO Send VALUES (DEFAULT, 2, 2, 2, '2021-10-04'); -- testa check enviar mensagem a si mesmo
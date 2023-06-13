/************************************************************
*  POPULATES BASE DE DADOS ELCHA
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
*  INSERIR DADOS NA TABELA APPUSER
************************************************************/
INSERT INTO AppUser VALUES 
	(DEFAULT, 'Ana', 'Costa', 'F', 'anacostaa@gmail.com', '1955-04-20', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Rita', 'Marques', 'F', 'ritamarques@gmail.com', '1955-03-01', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Rui', 'Pestana', 'M', 'ruipestana@gmail.com', '1950-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Pedro', 'Fonseca', 'M', 'pedrofonseca@gmail.com', '1951-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Catarina', 'Ribeiro', 'F', 'catarinaribeiro@gmail.com', '1961-04-22', default, DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'Antonio', 'Sousa', 'M', 'antoniosousa@gmail.com', '1960-04-20', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Joao', 'Armando', 'M', 'joaoarmando@gmail.com', '1952-03-01', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Pedro', 'Carvalho', 'M', 'pedrocarvalho@gmail.com', '1953-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Gustavo', 'dos Santos', 'M', 'gustavosantos@gmail.com', '1940-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Adelaide', 'Pereira', 'F', 'adelaidepereira@gmail.com', '1942-04-22', default, DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'Lurdes', 'Silva', 'F', 'lurdessilva@gmail.com', '1938-04-20', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Carla', 'Cunha', 'F', 'carlacunha@gmail.com', '1946-03-01', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Gabriel', 'Vitorino', 'M', 'gabrielvitorino@gmail.com', '1941-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Nuno', 'Alves', 'M', 'nunoalves@gmail.com', '1920-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Caciano', 'Carvalho', 'M', 'cacianocarvalho@gmail.com', '1950-04-22', default, DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'Maria', 'Amélia', 'F', 'mariaamelia@gmail.com', '1955-04-20', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Filipa', 'Ferreira', 'F', 'filipaferreira@gmail.com', '1960-03-01', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Teresa', 'Silva', 'F', 'teresasilva@gmail.com', '1957-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Luis', 'Domingues', 'M', 'luisdomingues@gmail.com', '1949-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Domingos', 'dos Anjos', 'M', 'domingosanjos@gmail.com', '1958-04-22', default, DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'Alberto', 'Sousa', 'M', 'albertosousa@gmail.com', '1943-04-20', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Helena', 'Vitorino', 'F', 'helenavitorino@gmail.com', '1960-03-01', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Ana', 'Pardal', 'F', 'anapardal@gmail.com', '1955-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Manuel', 'Maria', 'M', 'manuelmaria@gmail.com', '1940-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Claudia', 'Ribeiro', 'F', 'claudiaribeiro@gmail.com', '1942-04-22', default, DEFAULT, DEFAULT, DEFAULT),
	(DEFAULT, 'André', 'Gonçalves', 'M', 'andregoncalves@gmail.com', '1945-04-20', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Anastacia', 'Gomes', 'F', 'anastaciagomes@gmail.com', '1930-03-01', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Rui', 'Pedro', 'M', 'ruipedro@gmail.com', '1930-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Anabela', 'Pereira', 'F', 'anabelapereira@gmail.com', '1928-04-22', default, DEFAULT, DEFAULT, DEFAULT),
    (DEFAULT, 'Francisco', 'Herculano', 'M', 'franciscoherculano@gmail.com', '1950-04-22', default, DEFAULT, DEFAULT, DEFAULT);

/************************************************************
*  INSERIR DADOS NA TABELA TASK
************************************************************/
INSERT INTO Task VALUES
	(DEFAULT, 'New Friends', 'Add a new friend', 100 , 'Technology', 150),
    (DEFAULT, 'Social Guru', 'Add 15 friends', '250', 'Technology', '250'),
    (DEFAULT, 'Contact List', 'Learn how to add a contact on your phone', '100', 'Technology', '200'),
    (DEFAULT, 'Carrier Pigeon', 'Send a message to a friend', '150', 'Technology', '175'),
    (DEFAULT, 'Interacting', 'Comment Something on the feed', '75', 'Technology', '160'),
 	(DEFAULT, 'Video Chatting', 'Participate in a video call', '150', 'Technology', '80'),
    (DEFAULT, 'Alphabet Soup', 'Play an Alphabet Soup game', '50', 'Mental', '75'),
    (DEFAULT, 'Sudoku', 'Play a Soduku game', '75', 'Mental', '100'),
    (DEFAULT, 'Calculation', 'Swipe to the left if the number is odd, or to the right if the number is even', '150', 'Mental', '200'),
    (DEFAULT, 'Attention', 'Swipe in the direction of the arrow if it is blue, but on the opposite direction if it is yellow', '100', 'Mental', '210'),   
	(DEFAULT, 'Memory', 'Touch on the dots by order of appearence', '175', 'Mental', '105'),
    (DEFAULT, 'Sort', 'Sort the objects (swipe in the right direction)', '100', 'Mental', '90'),
    (DEFAULT, 'Walking', 'Go for a walk', '200', 'Physic', '225'),
    (DEFAULT, 'Yoga', 'Do the yoga exercices that appear on screen', '180', 'Physic', '130'),
    (DEFAULT, 'Gymnastics', 'Do the exercices that appear on the screen', '150', 'Physic', '180'),
    (DEFAULT, 'Eco Friendly', 'Create something new with things you do not use anymore', '100', 'Sustainability', '200'),
    (DEFAULT, 'CO2', 'Plant a tree or a plant', '250', 'Sustainability', '200'),    
	(DEFAULT, 'Recicle', 'When you go out to put the trash, do recicle it and take a photo', '150', 'Sustainability', '150');

/************************************************************
*  INSERIR DADOS NA TABELA PERSONALIZATION
************************************************************/
INSERT INTO Personalization VALUES
	(DEFAULT, 'Cool Blue Shirt', 'Body', 350),
    (DEFAULT, 'Smart Watch', 'Accessory', 1000),
    (DEFAULT, 'Yellow Sweatshirt', 'Body', 600),
    (DEFAULT, 'Summer Shirt', 'Body', 350),
    (DEFAULT, 'Black Glasses', 'Accessory', 250),
    (DEFAULT, 'Green Golf Cap', 'Head', 500),
    (DEFAULT, 'Cowboy Hat', 'Head', 500),
    (DEFAULT, 'Winter Hat', 'Head', 75),
    (DEFAULT, 'Blue Jeans', 'Legs', 100),
    (DEFAULT, 'Cream Shorts', 'Legs', 250),
    (DEFAULT, 'Beach Shorts', 'Legs', 150),
    (DEFAULT, 'Ripped Black Jeans', 'Legs', 100),
    (DEFAULT, 'Flip Flops', 'Feet', 50),
    (DEFAULT, 'High Heels', 'Feet', 650),
    (DEFAULT, 'Summer Dress', 'Body', 750),
    (DEFAULT, 'Red Shoes', 'Feet', 500);
    
/************************************************************
*  INSERIR DADOS NA TABELA BADGE
************************************************************/
INSERT INTO Badge VALUES
	(DEFAULT, 'Technology Expert', 'Conclude all Technology Tasks', 'Technology'),
    (DEFAULT, 'Mental Expert', 'Conclude all Mental Tasks', 'Mental'),
    (DEFAULT, 'Sustainability Expert', 'Conclude all Sustainability Tasks', 'Sustainability'),
    (DEFAULT, 'Physic Expert', 'Conclude all Physic Tasks', 'Physic');

/************************************************************
*  INSERIR DADOS NA TABELA POSTALCODE
************************************************************/
INSERT INTO PostalCode VALUES
	(DEFAULT, '1000', '001', 'Arroios', 'Lisboa', 'Portugal'),
    (DEFAULT, '1000', '010', 'São João de Deus', 'Lisboa', 'Portugal'),
    (DEFAULT, '1000', '100', 'São Jorge de Arroios', 'Lisboa', 'Portugal'),
    (DEFAULT, '1100', '003', 'São Vicente de Fora', 'Lisboa', 'Portugal'),
    (DEFAULT, '1200', '005', 'Mártires', 'Lisboa', 'Portugal'),
    (DEFAULT, '1100', '100', 'Anjos', 'Lisboa', 'Portugal'),
    (DEFAULT, '1000', '005', 'São Cristóvão', 'Lisboa', 'Portugal'),
    (DEFAULT, '1500', '001', 'Benfica', 'Lisboa', 'Portugal'),
    (DEFAULT, '1700', '010', 'Campo Grande', 'Lisboa', 'Portugal'),
    (DEFAULT, '2860', '280', 'Alhos Vedros', 'Moita', 'Portugal'),
    (DEFAULT, '2830', '280', 'Verderena', 'Barreiro', 'Portugal'),
    (DEFAULT, '2830', '149', 'Santo André', 'Barreiro', 'Portugal'),
    (DEFAULT, '2830', '406', 'Coina', 'Barreiro', 'Portugal'),
    (DEFAULT, '7600', '001', 'Aljustrel', 'Beja', 'Portugal'),
    (DEFAULT, '2080', '000', 'Almeirim', 'Santarém', 'Portugal'),
    (DEFAULT, '4425', '001', 'Maia', 'Porto', 'Portugal'),
    (DEFAULT, '4425', '005', 'Maia', 'Porto', 'Portugal'),
    (DEFAULT, '4450', '007', 'Matosinhos', 'Porto', 'Portugal'),
    (DEFAULT, '4450', '003', 'Matosinhos', 'Porto', 'Portugal'),
    (DEFAULT, '2350', '011', 'Torres Novas', 'Santarém', 'Portugal'),
    (DEFAULT, '2830', '410', 'Coina', 'Barreiro', 'Portugal'),
    (DEFAULT, '4730', '680', 'Vila Verde', 'Braga', 'Portugal'),
    (DEFAULT, '3800', '041', 'Paço', 'Aveiro', 'Portugal'),
    (DEFAULT, '3800', '085', 'Samocal', 'Aveiro', 'Portugal'),
    (DEFAULT, '7600', '172', 'Monte Novo', 'Beja', 'Portugal'),
    (DEFAULT, '4730', '682', 'Vila Verde', 'Braga', 'Portugal'),
    (DEFAULT, '3865', '002', 'Canelas', 'Aveiro', 'Portugal'),
    (DEFAULT, '8700', '134', 'Olhão', 'Faro', 'Portugal'),
    (DEFAULT, '8500', '002', 'Alvor', 'Faro', 'Portugal'),
    (DEFAULT, '8500', '002', 'Alvor', 'Faro', 'Portugal');

/************************************************************
*  INSERIR DADOS NA TABELA AVATAR
************************************************************/
INSERT INTO Avatar VALUES
	(DEFAULT, 1, 'anacosta1'),
    (DEFAULT, 2, 'ritamarques1'),
    (DEFAULT, 3, 'ruipestana1'),
    (DEFAULT, 4, 'pedrofonseca1'),
    (DEFAULT, 5, 'catarinaribeiro1'),
    (DEFAULT, 6, 'antoniosousa1'),
    (DEFAULT, 7, 'joaoarmando1'),
    (DEFAULT, 8, 'pedrocarvalho1'),
    (DEFAULT, 9, 'gustavosantos1'),
    (DEFAULT, 10, 'adelaidepereira1'),
	(DEFAULT, 11, 'lurdessilva1'),
    (DEFAULT, 12, 'carlacunha1'),
    (DEFAULT, 13, 'gabrielvitorino1'),
    (DEFAULT, 14, 'nunoalves1'),
    (DEFAULT, 15, 'cacianocarvalho1'),
    (DEFAULT, 16, 'mariaamelia1'),
    (DEFAULT, 17, 'filipaferreira1'),
    (DEFAULT, 18, 'teresasilva1'),
    (DEFAULT, 19, 'luisdomingues1'),
    (DEFAULT, 20, 'domingosanjos1'),
	(DEFAULT, 21, 'albertosousa1'),
    (DEFAULT, 22, 'helenavitorino1'),
    (DEFAULT, 23, 'anapardal1'),
    (DEFAULT, 24, 'manuelmaria1'),
    (DEFAULT, 25, 'claudiaribeiro1'),
    (DEFAULT, 26, 'andregoncalves1'),
    (DEFAULT, 27, 'anastaciagomes1'),
    (DEFAULT, 28, 'ruipedro1'),
    (DEFAULT, 29, 'anabelapereira1'),
    (DEFAULT, 30, 'franciscoherculano1');
    
/************************************************************
*  INSERIR DADOS NA TABELA PHONENR
************************************************************/
INSERT INTO PhoneNr VALUES
	(DEFAULT, 1, '+351', '960077910'),
    (DEFAULT, 2, '+351', '968552147'),
    (DEFAULT, 3, '+351', '961142578'),
    (DEFAULT, 4, '+351', '915487458'),
    (DEFAULT, 5, '+351', '915648486'),
    (DEFAULT, 6, '+351', '934646487'),
    (DEFAULT, 7, '+351', '960054487'),
    (DEFAULT, 8, '+351', '935230147'),
    (DEFAULT, 9, '+351', '910008799'),
    (DEFAULT, 10, '+351', '961114784'),
    (DEFAULT, 11, '+351', '915548752'),
    (DEFAULT, 12, '+351', '914788871'),
    (DEFAULT, 13, '+351', '910014575'),
    (DEFAULT, 14, '+351', '960014587'),
    (DEFAULT, 15, '+351', '968878541'),
    (DEFAULT, 16, '+351', '912658478'),
    (DEFAULT, 17, '+351', '935645875'),
    (DEFAULT, 18, '+351', '966665897'),
    (DEFAULT, 19, '+351', '965874532'),
    (DEFAULT, 20, '+351', '966658547'),
    (DEFAULT, 21, '+351', '915666985'),
    (DEFAULT, 22, '+351', '912223658'),
    (DEFAULT, 23, '+351', '914478558'),
    (DEFAULT, 24, '+351', '960025487'),
    (DEFAULT, 25, '+351', '963330254'),
    (DEFAULT, 26, '+351', '963358420'),
    (DEFAULT, 27, '+351', '936225147'),
    (DEFAULT, 28, '+351', '936665002'),
    (DEFAULT, 29, '+351', '915554785'),
    (DEFAULT, 30, '+351', '965221447');
    
/************************************************************
*  INSERIR DADOS NA TABELA FRIENDSHIP
************************************************************/
INSERT INTO Friendship VALUES
	(DEFAULT, 1, 2, '2020-01-01'),
    (DEFAULT, 1, 3, '2020-01-01'),
    (DEFAULT, 2, 3, '2020-01-01'),
    (DEFAULT, 2, 10, '2020-01-01'),
    (DEFAULT, 2, 23, '2020-01-01'),
    (DEFAULT, 4, 5, '2020-01-01'),
    (DEFAULT, 5, 6, '2020-01-01'),
    (DEFAULT, 6, 15, '2020-01-01'),
    (DEFAULT, 7, 1, '2020-01-01'),
    (DEFAULT, 8, 20, '2020-01-01'),
    (DEFAULT, 9, 11, '2020-01-01'),
    (DEFAULT, 10, 12, '2020-01-01'),
    (DEFAULT, 21, 20, '2020-01-01'),
    (DEFAULT, 29, 30, '2020-01-01'),
    (DEFAULT, 15, 25, '2020-01-01');
    
/************************************************************
*  INSERIR DADOS NA TABELA MESSAGE
************************************************************/
INSERT INTO Message VALUES
	(DEFAULT, 'Hi!'),
    (DEFAULT, 'Hello!'),
    (DEFAULT, 'Good Morning'),
    (DEFAULT, 'How are you?'),
    (DEFAULT, 'Lets do a task'),
    (DEFAULT, 'Hi'),
    (DEFAULT, 'Good Evening'),
    (DEFAULT, 'So funny'),
    (DEFAULT, 'I love Elcha'),
    (DEFAULT, 'Nice to meet you'),
    (DEFAULT, 'I love this app'),
    (DEFAULT, 'I won a new badge'),
    (DEFAULT, 'What are you doing?'),
    (DEFAULT, 'Hi!'),
    (DEFAULT, 'Bye!!');
    
/************************************************************
*  INSERIR DADOS NA TABELA Concludes
************************************************************/
INSERT INTO Concludes VALUES
	(DEFAULT, 1, 2, '2021-06-01', '2021-06-01', 'FINISHED'),
    (DEFAULT, 1, 3, '2021-06-02', '2021-06-02', 'FINISHED'),
    (DEFAULT, 1, 10, '2021-06-03', '2021-06-03', 'FINISHED'),
    (DEFAULT, 2, 12, '2021-06-06', '2021-06-06', 'FINISHED'),
    (DEFAULT, 2, 2, '2021-06-07', '2021-06-07', 'FINISHED'),
    (DEFAULT, 3, 2, '2021-06-08', '2021-06-08', 'FINISHED'),
    (DEFAULT, 4, 14, '2021-06-04', '2021-06-04', 'FINISHED'),
    (DEFAULT, 4, 10, '2021-06-05', '2021-06-05', 'FINISHED'),
    (DEFAULT, 4, 1, '2021-06-09', '2021-06-09', 'FINISHED'),
    (DEFAULT, 5, 2, '2021-06-11', '2021-06-11', 'FINISHED'),
    (DEFAULT, 5, 8, '2021-06-10', '2021-06-10', 'FINISHED'),
    (DEFAULT, 5, 11, '2021-06-25', '2021-06-25', 'FINISHED'),
    (DEFAULT, 6, 2, '2021-06-26', '2021-06-26', 'FINISHED'),
    (DEFAULT, 7, 2, '2021-06-29', '2021-06-29', 'FINISHED'),
    (DEFAULT, 8, 2, '2021-06-12', '2021-06-12', 'FINISHED'),
    (DEFAULT, 9, 1, '2021-06-12', '2021-06-12', 'FINISHED'),
    (DEFAULT, 10, 1, '2021-06-13', '2021-06-13', 'FINISHED'),
    (DEFAULT, 11, 1, '2021-07-24', '2021-07-24', 'FINISHED'),
    (DEFAULT, 11, 6, '2021-07-24', '2021-07-24', 'FINISHED'),
    (DEFAULT, 12, 7, '2021-07-25', '2021-07-25', 'FINISHED'),
    (DEFAULT, 12, 9, '2021-07-21', '2021-07-21', 'FINISHED'),
    (DEFAULT, 12, 10, '2021-07-20', '2021-07-20', 'FINISHED'),
    (DEFAULT, 13, 14, '2021-07-09', '2021-07-09', 'FINISHED'),
    (DEFAULT, 17, 4, '2021-07-05', '2021-07-05', 'FINISHED'),
    (DEFAULT, 18, 2, '2021-07-18', '2021-07-18', 'FINISHED'),
    (DEFAULT, 25, 1, '2021-08-15', '2021-08-15', 'FINISHED'),
    (DEFAULT, 26, 1, '2021-08-20', '2021-08-20', 'FINISHED'),
    (DEFAULT, 27, 12, '2021-08-02', '2021-08-02', 'FINISHED'),
    (DEFAULT, 28, 13, '2021-08-01', '2021-08-01', 'FINISHED'),
    (DEFAULT, 29, 2, '2021-08-10', '2021-08-10', 'FINISHED');
    
    
/************************************************************
*  INSERIR DADOS NA TABELA CUSTOMIZED
************************************************************/
INSERT INTO Customized VALUES
	(DEFAULT, 1, 2, '2021-06-20'),
    (DEFAULT, 30, 3, '2021-06-20'),
    (DEFAULT, 1, 10, '2021-06-20'),
    (DEFAULT, 2, 12, '2021-06-20'),
    (DEFAULT, 2, 2, '2021-06-20'),
    (DEFAULT, 3, 2, '2021-06-20'),
    (DEFAULT, 4, 14, '2021-06-20'),
    (DEFAULT, 4, 10, '2021-06-20'),
    (DEFAULT, 4, 1, '2021-06-20'),
    (DEFAULT, 5, 2, '2021-06-20'),
    (DEFAULT, 5, 8, '2021-06-20'),
    (DEFAULT, 5, 11, '2021-06-20'),
    (DEFAULT, 6, 2, '2021-06-20'),
    (DEFAULT, 7, 2, '2021-06-20'),
    (DEFAULT, 8, 2, '2021-06-20'),
    (DEFAULT, 9, 1, '2021-06-20'),
    (DEFAULT, 10, 1, '2021-06-20'),
    (DEFAULT, 11, 1, '2021-06-20'),
    (DEFAULT, 11, 6, '2021-06-20'),
    (DEFAULT, 12, 7, '2021-06-20'),
    (DEFAULT, 12, 9, '2021-06-20'),
    (DEFAULT, 12, 10, '2021-06-20'),
    (DEFAULT, 13, 14, '2021-06-20'),
    (DEFAULT, 17, 4, '2021-06-20'),
    (DEFAULT, 18, 2, '2021-06-20'),
    (DEFAULT, 25, 1, '2021-06-20'),
    (DEFAULT, 26, 1, '2021-06-20'),
    (DEFAULT, 27, 12, '2021-06-20'),
    (DEFAULT, 28, 13, '2021-06-20'),
    (DEFAULT, 29, 2, '2021-06-20');
    
/************************************************************
*  INSERIR DADOS NA TABELA Secures
************************************************************/
INSERT INTO Secures VALUES
	(DEFAULT, 15, 1, '2019-05-10'),
	(DEFAULT, 13, 1, '2019-06-21'),
    (DEFAULT, 18, 2, '2019-07-25'),
    (DEFAULT, 5, 2, '2019-07-26'),
    (DEFAULT, 12, 2, '2019-09-21'),
	(DEFAULT, 6, 1, '2019-11-19'),
	(DEFAULT, 27, 3, '2020-02-15'),
    (DEFAULT, 28, 4, '2020-02-12'),
    (DEFAULT, 1, 4, '2020-03-21'),
    (DEFAULT, 4, 4, '2020-03-26'),
	(DEFAULT, 10, 3, '2020-03-23'),
	(DEFAULT, 14, 3, '2020-05-12'),
    (DEFAULT, 11, 3, '2020-06-24'),
    (DEFAULT, 16, 1, '2020-06-29'),
    (DEFAULT, 9, 1, '2020-06-10'),
	(DEFAULT, 22, 2, '2020-07-21'),
	(DEFAULT, 25, 2, '2020-07-12'),
    (DEFAULT, 7, 1, '2020-08-20'),
    (DEFAULT, 23, 3, '2020-08-29'),
    (DEFAULT, 3, 2, '2020-10-12'),
	(DEFAULT, 2, 2, '2020-12-26');
	
/************************************************************
*  INSERIR DADOS NA TABELA Lives
************************************************************/
INSERT INTO Lives VALUES
	(DEFAULT, 9, 9, '2019-05-10'),
	(DEFAULT, 13, 13, '2019-06-21'),
    (DEFAULT, 18, 18, '2019-07-25'),
    (DEFAULT, 5, 5, '2019-07-26'),
    (DEFAULT, 12, 12, '2019-09-21'),
	(DEFAULT, 6, 6, '2019-11-19'),
	(DEFAULT, 27, 27, '2020-02-15'),
    (DEFAULT, 28, 28, '2020-02-12'),
    (DEFAULT, 1, 1, '2020-03-21'),
    (DEFAULT, 4, 4, '2020-03-26'),
	(DEFAULT, 10, 10, '2020-03-23'),
	(DEFAULT, 3, 3, '2020-05-12'),
    (DEFAULT, 15, 15, '2020-06-24'),
    (DEFAULT, 16, 16, '2020-06-29'),
    (DEFAULT, 11, 11, '2020-06-10'),
	(DEFAULT, 22, 22, '2020-07-21'),
	(DEFAULT, 25, 25, '2020-07-12'),
    (DEFAULT, 8, 8, '2020-08-20'),
    (DEFAULT, 23, 23, '2020-08-29'),
    (DEFAULT, 14, 14, '2020-10-12'),
	(DEFAULT, 2, 2, '2020-12-26'),
	(DEFAULT, 17, 17, '2021-01-21'),
    (DEFAULT, 20, 20, '2021-02-15'),
    (DEFAULT, 30, 30, '2020-03-21'),
    (DEFAULT, 19, 19, '2021-04-30'),
	(DEFAULT, 26, 26, '2021-04-11'),
	(DEFAULT, 29, 29, '2021-05-11'),
    (DEFAULT, 7, 7, '2021-05-21'),
    (DEFAULT, 24, 24, '2021-06-15'),
    (DEFAULT, 21, 21, '2021-06-25');
    
/************************************************************
*  INSERIR DADOS NA TABELA Send
************************************************************/
INSERT INTO Send VALUES
	(DEFAULT, 1, 2, 1, '2021-06-20'),
    (DEFAULT, 1, 2, 15, '2021-06-20'),
    (DEFAULT, 1, 2, 10, '2021-06-20'),
    (DEFAULT, 1, 2, 12, '2021-06-20'),
    (DEFAULT, 1, 2, 2, '2021-06-20'),
    (DEFAULT, 1, 2, 5, '2021-06-20'),
    (DEFAULT, 1, 2, 4, '2021-06-20'),
    (DEFAULT, 1, 2, 3, '2021-06-20'),
    (DEFAULT, 1, 2, 11, '2021-06-20'),
    (DEFAULT, 1, 2, 12, '2021-06-20'),
    (DEFAULT, 1, 2, 13, '2021-06-20'),
    (DEFAULT, 1, 2, 14, '2021-06-20'),
    (DEFAULT, 1, 2, 6, '2021-06-20'),
    (DEFAULT, 1, 2, 7, '2021-06-20'),
    (DEFAULT, 1, 2, 8, '2021-06-20');
    
/************************************************************
*  INSERIR DUMMY DATA
************************************************************/
    CALL sp_InsertRandomData (31,231,19,219,31,231);
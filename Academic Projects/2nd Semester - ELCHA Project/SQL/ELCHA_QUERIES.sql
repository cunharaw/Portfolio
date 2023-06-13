/************************************************************
*  QUERIES BASE DE DADOS ELCHA
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
*  TABELAS
************************************************************/
-- Tabela AppUser
select Us_ID as "ID", concat(Us_firstName, " ", Us_lastName) as "User Name", timestampdiff(year, Us_dob, curdate()) as "Age" /*RI17: Validar regra - Us_Age = dataSistema – Us_dob */, 
Us_gender as "Gender", Us_points as "Points", Us_level as "Level", Us_gems as "Gems", Us_status as "Status" from AppUser;

select * from appuser;
delete from Avatar where Ava_Us_ID = 1;
call sp_appUser();

/************************************************************
*  QUERIES
************************************************************/

/************************************************************
*  SECÇÃO A:
2 query com pelo menos três tabelas, sugestões:
	▪Usar operadores LEFT/RIGHTJOIN e INNER JOIN
	▪Usar operadores AND e OR na clausula WHERE
	▪Usar operadores de agregação na clausula WHERE
************************************************************/

-- 1A. Apresenta o ID, Nome e Sobrenome, Genero, Numero de Telefone, E-mail, e Morada dos Utilizadores cujo nome ou apelido comece pela a letra A, ordenado por ID de utilizador:
SELECT
    AppUser.Us_ID AS 'User ID',
    AppUser.Us_firstName AS 'Name',
    AppUser.Us_lastName AS 'Surname',
    AppUser.Us_gender AS 'Gender',
    PhoneNr.Phnr_code AS 'Code',
    PhoneNr.Phnr_number AS 'Phone Number',
    AppUser.Us_email AS 'E-mail',
    PostalCode.Pc_4D AS '4 digit',
    PostalCode.Pc_3D AS '3 digit',
    PostalCode.Pc_parish AS 'Parish',
    PostalCode.Pc_country AS 'Country'
FROM
    (((AppUser
    INNER JOIN PhoneNr ON Us_ID = Phnr_Us_ID)
    INNER JOIN Lives ON Us_ID = Lives_Us_ID)
    INNER JOIN PostalCode ON Lives_PC_ID = PC_ID)
WHERE
    AppUser.Us_firstName LIKE 'A%'
        OR AppUser.Us_lastName LIKE 'A%'
ORDER BY Us_ID ASC;

-- 2A. Apresenta os utilizadores que realizaram uma certa Tarefa, ordenado por data de conclusão:
SELECT
    AppUser.Us_ID AS 'User ID',
    AppUser.Us_firstName AS 'Name',
    AppUser.Us_lastName AS 'Surname',
    Task.Task_name AS 'Task Name',
    Concludes.Conc_cDate AS 'Concluded in'
FROM
    ((AppUser
    INNER JOIN Concludes ON Us_ID = Conc_Us_ID)
    INNER JOIN Task ON Task_ID = Conc_Task_ID)
WHERE
    Task.Task_name = 'Social Guru'
ORDER BY Conc_cDate ASC;

/**************************************************************************
*  SECÇÃO B:
1 query com instruções de agregação (e.g., SUM, COUNT, AVG, MIN, MAX, ...):
**************************************************************************/    

-- 1B. Apresenta o Total de Utilizadores da Plataforma
SELECT 
    COUNT(Us_ID) AS 'Total Number of Users'
FROM
    AppUser; 

/***************************************************************
*  SECÇÃO C:
1 query com agrupamentos (GROUP BY) e instruções de agregação:
***************************************************************/   

-- 1C. Apresenta o Número de Utilizadores de cada Género:
SELECT 
    COUNT(Us_ID) AS 'Number of Users', Us_gender AS 'Gender'
FROM
    AppUser
GROUP BY Us_gender
ORDER BY COUNT(Us_ID) DESC;

/*****************************************************************
*  SECÇÃO D:
1 query com agrupamentos e restrições sobre o agrupamento 
(i.e., tem de ter uma instrução HAVING), com no mínimo 3 tabelas:
*****************************************************************/ 

-- 1D. Apresenta os Utilizadores que pertencem à área de Lisboa:
SELECT 
    AppUser.Us_firstName AS 'Name',
    AppUser.Us_lastName AS 'Surname',
    PostalCode.Pc_4D AS '4 digit',
    PostalCode.Pc_3D AS '3 digit',
    PostalCode.Pc_parish AS 'Parish'
FROM
    ((Lives
    INNER JOIN AppUser ON Lives_Us_ID = Us_ID)
    INNER JOIN PostalCode ON Lives_PC_ID = PC_ID)
HAVING PostalCode.Pc_4D LIKE '%1___';

/*********************************************************************************
*  SECÇÃO E:
2 query encadeada/composta (i.e., SELECT dentro da clausula WHERE), 
cada uma das queries tem de envolver, no mínimo, o relacionamento entre 3 tabelas:
*********************************************************************************/ 

-- 1E. Apresenta o total de Utilizadores que realizaram tarefas
SELECT COUNT(Us_ID) as "Number of Users"
FROM AppUser
WHERE AppUser.Us_ID IN (SELECT Sc_Us_ID
					FROM Secures
                    WHERE Sc_Us_ID = AppUser.Us_ID);

-- 2E. Apresenta o Utilizador que possui um certo numero de telefone
SELECT CONCAT(Us_firstName, ' ', Us_lastName) AS "User Name"
FROM AppUser
WHERE AppUser.Us_ID IN (SELECT Phnr_ID 
						FROM PhoneNr 
                        WHERE Phnr_Us_ID = AppUser.Us_ID 
                        AND Phnr_number = '960077910');

/****************************************************************************
*  SECÇÃO F:
2 views com duas ou mais tabelas, com agrupamentos e instruções de agregação:
****************************************************************************/ 

-- 1F. Apresenta a LeaderBoard Global da Plataforma:
CREATE VIEW LeaderBoard AS
	SELECT rank() over (order by Us_points desc) AS "Position", concat(Us_firstName, ' ', Us_lastName) as "User Name", Us_points "Points"
    FROM AppUser;
    
SELECT * FROM LeaderBoard;

-- 2F. Apresenta as Categorias das Tarefas que existem
CREATE VIEW CategoryOfTasks AS
	SELECT DISTINCT Task_category AS "Category of Task"
    From Task;
    
SELECT * FROM CategoryOfTasks

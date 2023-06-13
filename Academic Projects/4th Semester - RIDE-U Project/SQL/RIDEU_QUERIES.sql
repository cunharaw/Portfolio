--mínimo 10 consultas 
 
--	•	2 queries com pelo menos três tabelas, sugestões: 
--		o	Usar operadores LEFT/RIGHT JOIN e INNER JOIN 
--		o	Usar operadores AND e OR na clausula WHERE 
--		o	Usar operadores de agregação na clausula WHERE
/****************************************************************************
*  VERIFICAR CLIENTES DO GENERO MASCULINO E RESPETIVOS METODOS DE PAGAMENTO 
****************************************************************************/ 
SELECT
	C.CL_ID AS 'ID CLIENTE',
	CONCAT(C.CL_NOME, ' ', C.CL_NOMEMEIO, ' ' ,C.CL_APELIDO) AS 'NOME COMPLETO',
	M.MET_NUMCARTAO AS 'NUMERO DO CARTÃO DE CREDITO'
FROM sCliente.CLIENTE C
JOIN TER T
	ON C.CL_ID = T.TER_CLID
JOIN METPAGAMENTO M
	ON M.MET_ID = T.TER_METID
WHERE C.CL_GENERO = 'M'

/*********************************************************************************************
*  VERIFICAR INFO DO CARRO E RESPETIVO CONDUTOR DE CARROS DE CATEGORIA BUDGET E MARCA RENAULT 
*********************************************************************************************/ 
SELECT
	CO.CON_ID AS 'ID CONDUTOR',
	CONCAT(CO.CON_NOME, ' ', CO.CON_NOMEMEIO, ' ' ,CO.CON_APELIDO) AS 'NOME COMPLETO',
	CONCAT(CA.CAR_MARCA, ' ', CA.CAR_MODELO) AS 'CARRO',
	CA.CAR_MATRICULA AS 'MATRICULA CARRO',
	CT.CARTIP_NOME AS 'CATEGORIA CARRO'
FROM Scondutor.CONDUTOR CO
INNER JOIN Scondutor.CARRO CA
	ON CA.CAR_C_ID = CO.CON_ID
INNER JOIN CARROTIPO CT
	ON CT.CARTIP_CAR_ID = CA.CAR_ID
WHERE CT.CARTIP_NOME = 'BUDGET' AND CA.CAR_MARCA = 'RENAULT'

 --	•	1 query com instruções de agregação (e.g., SUM, COUNT, AVG, MIN, MAX, ...) 
  /*************************************************
*  VERIFICAR O NUMERO DE VIAGENS DE CADA CLIENTE
**************************************************/
SELECT 
	C.CL_ID AS 'ID CLIENTE',
	CONCAT(C.CL_NOME, ' ', C.CL_APELIDO) AS 'NOME CLIENTE',
	COUNT(AVC.AVCON_CLID) AS 'NUMERO DE VIAGENS'
FROM Scliente.CLIENTE C
LEFT JOIN Scondutor.CLAVCOND AVC
	ON AVC.AVCON_CLID = C.CL_ID
GROUP BY C.CL_ID, C.CL_NOME,C.CL_APELIDO

  /*************************************************
*  VERIFICAR QUANTOS CLIENTES TEM CADA ESTATUTO
**************************************************/
SELECT
	COUNT(C.CL_ID) AS 'N CLIENTES',
	E.EST_NOME AS 'ESTATUTO'
FROM Scliente.CLIENTE C
JOIN DETER D 
	ON C.CL_ID = D.DETER_CL_ID
JOIN ESTATUTO E
	ON E.EST_ID = D.DETER_EST_ID
GROUP BY E.EST_NOME

 --• 1 query com agrupamentos (GROUP BY) e instruções de agregação 
 /*************************************************
*  VERIFICAR QUANTOS CARROS TEM CADA CATEGORIA 
**************************************************/
SELECT 
    COUNT(C.CAR_ID) AS 'Numero de Carros', 
	CT.CARTIP_NOME AS 'Categoria'
FROM
    Scondutor.CARRO C JOIN CARROTIPO CT
		ON CT.CARTIP_CAR_ID = C.CAR_ID
GROUP BY CT.CARTIP_NOME
ORDER BY COUNT(C.CAR_ID) DESC;

--•	1 query com agrupamentos e restrições sobre o agrupamento (i.e., tem de ter pelo menos uma instrução de HAVING)  
 /***************************************************
*	VER ESTATUTO COM MAIS DE 10 CLIENTES
****************************************************/
SELECT
	COUNT(C.CL_ID) AS 'N CLIENTES',
	E.EST_NOME AS 'ESTATUTO'
FROM Scliente.CLIENTE C
JOIN DETER D 
	ON C.CL_ID = D.DETER_CL_ID
JOIN ESTATUTO E
	ON E.EST_ID = D.DETER_EST_ID
GROUP BY E.EST_NOME
HAVING COUNT(C.CL_ID) > 10

--•	2 query encadeada/composta (i.e., query dentro da clausula WHERE) 
 /***************************************************
*  CLIENTES COM IDADE ACIMA DA MEDIA DE IDADE (> 19)
****************************************************/
SELECT AVG(DATEDIFF(YEAR, C.CL_DATANASC, GETDATE() )) FROM CLIENTE C 

SELECT 
	CONCAT(C.CL_NOME, '  ', C.CL_APELIDO) AS 'NOME CLIENTE',
	DATEDIFF(YEAR, C.CL_DATANASC, GETDATE()) AS 'IDADE'
FROM Scliente.CLIENTE C
WHERE DATEDIFF(YEAR, C.CL_DATANASC, GETDATE() ) > (
    SELECT AVG(DATEDIFF(YEAR, C.CL_DATANASC, GETDATE() ))
    FROM Scliente.CLIENTE C);

 /***************************************************************************************
*  QUAL É O CARRO MAIS NOVO DE CADA MARCA E MODELO E QUAL A SUA IDADE ORDENADO CRESCENTE
*****************************************************************************************/
SELECT 
	CONCAT(CA.CAR_MARCA, ' ', CA.CAR_MODELO) AS 'CARRO',
	MIN(DATEDIFF(YEAR, CA.CAR_DATAREG, GETDATE())) AS 'IDADE CARRO'
FROM Scondutor.CARRO CA
WHERE DATEDIFF(YEAR, CA.CAR_DATAREG, GETDATE() ) > (
    SELECT AVG(DATEDIFF(YEAR, CA.CAR_DATAREG, GETDATE() ))
    FROM Scondutor.CARRO CA)
GROUP BY CA.CAR_MARCA,CA.CAR_MODELO
ORDER BY MIN(DATEDIFF(YEAR, CA.CAR_DATAREG, GETDATE())) ASC

--•	3 views com duas ou mais  tabelas, com agrupamentos e instruções de agregação (e.g., SUM, COUNT, AVG, MIN, MAX, ...), DISTINCT
 /*************************************************
*  AVALIAÇÃO MEDIA DE CADA CLIENTE
**************************************************/
go
CREATE OR ALTER VIEW avaliacaoCl AS
SELECT 
	C.CL_ID AS 'ID CLIENTE' ,
	CONCAT(C.CL_NOME, '', C.CL_APELIDO) AS 'NOME CLIENTE',
	ROUND(AVG(CL.AVCL_ESTRELAS),2) AS 'AVALIACAO MÉDIA',
	COUNT(CL.AVCL_CLID) AS 'NUMERO DE AVALIAÇÕES',
	E.EST_NOME AS 'ESTATUTO'
FROM Scliente.CLIENTE C INNER JOIN Scliente.CONDAVCL CL 
	ON CL.AVCL_CLID=C.CL_ID
INNER JOIN DETER D
	ON D.DETER_CL_ID = C.CL_ID
INNER JOIN ESTATUTO E
	ON E.EST_ID = D.DETER_EST_ID
GROUP BY C.CL_ID,C.CL_NOME, C.CL_APELIDO, E.EST_NOME
go
SELECT * FROM avaliacaoCl

 /*************************************************
*  AVALIAÇÃO MEDIA DE CADA CONDUTOR
**************************************************/
go
CREATE OR ALTER VIEW avaliacaoCon AS
SELECT 
	CO.CON_ID AS 'ID CONDUTOR' ,
	CONCAT(CO.CON_NOME, '', CO.CON_APELIDO) AS 'NOME CLIENTE',
	ROUND(AVG(CON.AVCON_ESTRELAS),2) AS 'AVALIACAO MÉDIA',
	COUNT(CON.AVCON_CONID) AS 'NUMERO DE AVALIAÇÕES'
FROM Scondutor.CONDUTOR CO INNER JOIN Scondutor.CLAVCOND CON 
	ON CON.AVCON_CONID=CO.CON_ID
GROUP BY CO.CON_ID,CO.CON_NOME, CO.CON_APELIDO
go
SELECT * FROM avaliacaoCon

 /*************************************************
*  REGISTO DAS VIAGENS ORDENADAS POR IDS E NOMES
**************************************************/--este
go
CREATE or alter VIEW listaInfoViagens AS
SELECT
	C.CL_ID AS 'ID CLIENTE',
	CONCAT(C.CL_NOME, ' ', C.CL_APELIDO) AS 'NOME CLIENTE',
	CO.CON_ID AS 'ID CONDUTOR',
	CONCAT(CO.CON_NOME, ' ', CO.CON_APELIDO) AS 'NOME CONDUTOR',
	CONCAT(CA.CAR_MARCA, ' ', CA.CAR_MODELO) AS 'CARRO',
	CA.CAR_MATRICULA AS 'MATRICULA',
	V.VIA_ID AS 'ID VIAGEM',
	V.VIA_PNTRECOLHA AS 'PONTO RECOLHA', 
	V.VIA_PNTDESTINO AS 'PONTO DESTINO',
	AVC.AVCON_ESTRELAS AS 'AVALIAÇÃO AO CONDUTOR',
	CVC.AVCL_ESTRELAS AS 'AVALIAÇÃO AO CLIENTE'
FROM Scliente.CLIENTE C INNER JOIN Scondutor.CLAVCOND AVC
	on C.CL_ID = AVC.AVCON_CLID
INNER JOIN Scondutor.CONDUTOR CO
	ON CO.CON_ID = AVC.AVCON_CONID
INNER JOIN Sanalista.VIAGEM V
	ON AVC.AVCON_VIID = V.VIA_ID
INNER JOIN Scliente.CONDAVCL CVC
	ON CVC.AVCL_VIID = V.VIA_ID
INNER JOIN Scondutor.CARRO CA
	ON CA.CAR_C_ID = CO.CON_ID
GROUP BY C.CL_ID, C.CL_NOME, C.CL_APELIDO, CO.CON_ID, CO.CON_NOME, CO.CON_APELIDO, CA.CAR_MARCA, CA.CAR_MODELO, CA.CAR_MATRICULA, V.VIA_ID, V.VIA_PNTRECOLHA, V.VIA_PNTDESTINO, AVC.AVCON_ESTRELAS, CVC.AVCL_ESTRELAS
go
SELECT * FROM listaInfoViagens 

 /*************************************************
*  REGISTO DAS VIAGENS E RESPETIVA FATURA E NIF
**************************************************/
go
CREATE OR ALTER VIEW viagemFatura AS
SELECT	
	V.VIA_ID AS 'ID DA VIAGEM',
	F.FAT_ID AS 'ID DA FATURA',
	F.FAT_NIF AS 'NIF DA FATURA'
FROM Sanalista.VIAGEM V
INNER JOIN GERAR G
	ON G.GER_VIAID = V.VIA_ID
INNER JOIN Sanalista.FATURA F
	ON G.GER_FATID = F.FAT_ID
go
SELECT * FROM viagemFatura
GO

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
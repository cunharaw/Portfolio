/************************************************************
*	Grupo: 05  |  Curso: L-IG (2º ano)
*  	UC: Administração e Gestão de Informação
*
*	Trabalho de Pesquisa: Transações & Concorrência
*
*  	Nome: João Ramos (20200255)
*	Nome: Martim Bento (20200488)
*  	Nome: Pedro Cunha (20200908)
*
************************************************************/
use tp1

/************************************************************
*  Exemplo de Nested Transaction com SavePoints
************************************************************/
BEGIN TRANSACTION T1
    SAVE TRANSACTION SavePoint1
	insert into [dbo].[Customer] values(250,253,'Jessica','F')
	insert into [dbo].[Customer] values(190,323,'Carolina','F')
 
     BEGIN TRANSACTION T2
          SAVE TRANSACTION SavePoint2
               insert into [dbo].[Customer] values(450,753,'carla','F')
				insert into [dbo].[Customer] values(590,623,'lucia','F')  

     COMMIT TRANSACTION T2 
     
COMMIT TRANSACTION T1 
Select * from Customer order by 1 desc

ROLLBACK TRANSACTION SavePoint2

/************************************************************
*  Exemplo de Dirty Read
************************************************************/
BEGIN TRANSACTION
	UPDATE Stock SET StockItemQTY=0 WHERE StockItemNO=1;
	--A passar a fatura
	WAITFOR DELAY '00:00:15'
	-- sem dinheiro na conta disponivel
ROLLBACK TRANSACTION

SELECT * FROM Stock WHERE StockItemNO=1;

/************************************************************
*  Exemplo de Lost Update
************************************************************/
BEGIN TRANSACTION
  DECLARE @QuantidadeDisponivel int
  SELECT @QuantidadeDisponivel = StockItemQTY FROM Stock WHERE StockID=2
  -- a fazer a transação
  WAITFOR DELAY '00:00:10'
  SET @QuantidadeDisponivel = @QuantidadeDisponivel - 1
  UPDATE Stock SET StockItemQTY = @QuantidadeDisponivel  WHERE StockID=2
  Print @QuantidadeDisponivel
COMMIT TRANSACTION

SELECT *FROM Stock where StockID=2

/************************************************************
*  Solução de Lost Update
************************************************************/

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
  SELECT @QuantidadeDisponivel = StockItemQTY FROM Stock WHERE StockID=2
  -- a fazer a transação
  WAITFOR DELAY '00:00:10'
  SET @QuantidadeDisponivel = @QuantidadeDisponivel - 1
  UPDATE Stock SET StockItemQTY = @QuantidadeDisponivel  WHERE StockID=2
  Print @QuantidadeDisponivel
COMMIT TRANSACTION

select * from stock where stockid=1

/************************************************************
*  Exemplo de Non Repeatable Read
************************************************************/
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION
SELECT StockItemQTY FROM Stock WHERE StockID = 3
-- a fazer algo
WAITFOR DELAY '00:00:10'
SELECT StockItemQTY FROM Stock WHERE StockID = 3
COMMIT TRANSACTION
select * from stock
/************************************************************
*  Solução de Non Repeatable Read
************************************************************/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT StockItemQTY FROM Stock WHERE StockID = 3
-- a fazer algo
WAITFOR DELAY '00:00:10'
SELECT StockItemQTY FROM Stock WHERE StockID = 3
COMMIT TRANSACTION


/************************************************************
*  Exemplo de Phantom Read
************************************************************/

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION
SELECT * FROM Customer where CustomerGender='M'; -- DEVOLVE 4 LINHAS
-- a fazer algo
WAITFOR DELAY '00:00:10'
SELECT * FROM Customer where CustomerGender='M';-- DEVOLVE 5 LINHAS
COMMIT TRANSACTION

/************************************************************
*  Solução de Phantom Read
************************************************************/

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE 
BEGIN TRANSACTION
SELECT * FROM Customer where CustomerGender='M'; -- DEVOLVE 4 LINHAS
-- a fazer algo
WAITFOR DELAY '00:00:10'
SELECT * FROM Customer where CustomerGender='M';-- DEVOLVE 5 LINHAS
COMMIT TRANSACTION
go
 
/************************************************************
*  Exemplo de DeadLock
************************************************************/
--Ativar monitorização de deadlocks
dbcc traceon(1204,-1)
dbcc traceon(1222,-1)

--Consultar flags ativas
dbcc tracestatus(-1)

BEGIN TRANSACTION
	INSERT INTO CUSTOMER values(10000,1000,'joana','M')
	--executar transação 2
	DELETE CUSTOMER
	ROLLBACK
	
go
/************************************************************
*  Consultar log de DeadLock
************************************************************/
if OBJECT_ID('tempdb.dbo.#error_log') is not null drop table #error_log
create table #error_log (logdate datetime,processinfo varchar(1000),text varchar(max))
insert into #error_log exec xp_ReadErrorLog
select * from #error_log where logdate in (select logdate from #error_log where text like 'DeadLock encountered%')

-- limpar o log
exec sp_cycle_errorlog

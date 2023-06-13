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
*  Exemplo de Dirty Read
************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED -- Ler dados que ainda n foram comited
SELECT * FROM Stock WHERE StockItemNO=1;

/************************************************************
* Solução de Dirty Read
************************************************************/

SET TRANSACTION ISOLATION LEVEL READ COMMITTED -- Ler dados que ja foram comited
SELECT * FROM Stock WHERE StockItemNO=1;
--ou
SELECT * FROM Stock (NOLOCK) WHERE StockItemNO=1

/************************************************************
*  Exemplo de Lost Update
************************************************************/
 BEGIN TRANSACTION
  DECLARE @QuantidadeDisponivel int
  SELECT @QuantidadeDisponivel = StockItemQTY FROM Stock WHERE StockID=2
  SET @QuantidadeDisponivel = @QuantidadeDisponivel - 2
  UPDATE Stock SET StockItemQTY = @QuantidadeDisponivel WHERE StockID=2
  Print @QuantidadeDisponivel
COMMIT TRANSACTION

/************************************************************
*  Solução de Lost Update
************************************************************/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
 BEGIN TRANSACTION
  DECLARE @QuantidadeDisponivel int-- Não é necessaria a declaração da variavel novamente pois ja foi declarada acima no exemplo errado
  SELECT @QuantidadeDisponivel = StockItemQTY FROM Stock WHERE StockID=2
  SET @QuantidadeDisponivel = @QuantidadeDisponivel - 2
  UPDATE Stock SET StockItemQTY = @QuantidadeDisponivel WHERE StockID=2
  Print @QuantidadeDisponivel
COMMIT TRANSACTION
/************************************************************
*  Exemplo de Non Repeatable Read
************************************************************/

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
UPDATE Stock SET StockItemQTY = 10 WHERE StockID = 3;

/************************************************************
*  Solução de Non Repeatable Read
************************************************************/

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
UPDATE Stock SET StockItemQTY = 6 WHERE StockID = 3;

/************************************************************
*  Exemplo de Phantom Read
************************************************************/

 SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
 BEGIN TRANSACTION
 insert into Customer values
 (18,178,'jao almeida','M');
 COMMIT TRANSACTION

 /************************************************************
*  Exemplo de DeadLock 
************************************************************/
GO

BEGIN TRANSACTION
	INSERT INTO CUSTOMER values(10010,1100,'joanaS','M')

	DELETE CUSTOMER
ROLLBACK

drop table Customer
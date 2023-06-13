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
--TRIGER QUE COLOCA O ATRIBUTO CLO_ATIVO PARA 0 QUANDO TENTAM APAGAR O CLIENTE SELECIONADO
Create or Alter TRIGGER trgEstadocl 
on Sanalista.cllogin Instead of delete

AS BEGIN

	DECLARE @CLID INT

	SELECT @CLID=deleted.CLO_ID
	FROM deleted

END
BEGIN
	RAISERROR('O atriburo ativo foi definido para 0',16 ,1)
              Update Sanalista.CLLOGIN
			  set CLO_Ativo=0 where clo_id=@CLID
              
END 
go
/*
DELETE FROM Sanalista.CLLOGIN WHERE CLO_ID=1;
insert into Sanalista.cllogin values (1,ENCRYPTBYASYMKEY(ASYMKEY_ID('CHAVEASSIMETRICA1'),CONVERT(VARCHAR,'brito.ra1mos@gmail.com')),
ENCRYPTBYASYMKEY(ASYMKEY_ID('CHAVEASSIMETRICA1'),CONVERT(VARCHAR,'123')),'1234167890',default)
select * from Sanalista.CLLOGIN
*/
GO
--TRIGER QUE COLOCA O ATRIBUTO CO_ATIVO PARA 0 QUANDO TENTAM APAGAR O CONDUTOR SELECIONADO
Create or Alter TRIGGER trgEstadoCon 
on Sanalista.conlogin Instead of delete

AS BEGIN

	DECLARE @Conid INT

	SELECT @Conid=deleted.CO_ID
	FROM deleted

END
BEGIN
	RAISERROR('O atriburo ativo foi definido para 0',16 ,1)
              Update Sanalista.CONLOGIN
			  set CO_Ativo=0 where Co_id=@Conid
          
END 
go
/*
insert into Sanalista.conlogin values (1,ENCRYPTBYASYMKEY(ASYMKEY_ID('CHAVEASSIMETRICA1'),CONVERT(VARCHAR,'brito.ra11os@gmail.com')),
ENCRYPTBYASYMKEY(ASYMKEY_ID('CHAVEASSIMETRICA1'),CONVERT(VARCHAR,'123')),'1234167890',default)
delete from Sanalista.CONLOGIN where co_id=1
select * from Sanalista.CONLOGIN
*/
GO
--TRIGGER EXECUTADO APOS NOVA AVALIAÇÃO AO CONDUTOR
CREATE OR ALTER TRIGGER trgCLAVCOND
on scondutor.CLAVCOND AFTER UPDATE
AS BEGIN
	EXEC SPCALCULOAVALIACAOCOND
END
GO
--TRIGGER EXECUTADO APOS NOVA AVALIAÇÃO AO CLIENTE
CREATE OR ALTER TRIGGER trgCONDAVCL
on scliente.CONDAVCL AFTER UPDATE
AS BEGIN
	EXEC SPCALCULOAVALIACAOCL
END
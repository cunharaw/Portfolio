/********************
* Populates com erros
********************/



/********************
* Inserir clientes atraves da SP SPREGISTARCL
********************/

GO
exec SPREGISTARCL @DATANASC='1999-06-04', @NOME='João', @NOMEMEIO='Rato',@APELIDO='Ramos',@GENERO='M',@TELEMOVEL=934500594 /*Correto*/
exec SPREGISTARCL @DATANASC='2014-06-04', @NOME='João', @NOMEMEIO='Rato',@APELIDO='Ramos',@GENERO='M',@TELEMOVEL=934500594 /*Demasiado Novo*/
exec SPREGISTARCL @DATANASC='1700-06-04', @NOME='João', @NOMEMEIO='Rato',@APELIDO='Ramos',@GENERO='M',@TELEMOVEL=934500594 /*Demasiado Velho*/
exec SPREGISTARCL @DATANASC='2003-06-04', @NOME='Jo5ão', @NOMEMEIO='Rato',@APELIDO='Ramos',@GENERO='M',@TELEMOVEL=934500594 /*Nome invalido, nº no nome*/
exec SPREGISTARCL @DATANASC='1999-06-04', @NOME='João', @NOMEMEIO='Rato',@APELIDO='Ramos',@GENERO='M',@TELEMOVEL=7834500594 /*Telemovel invalido, tamanho incorreto*/
select * from CLIENTE
GO


/********************
* Inserir login dos clientes atraves da SP SPREGISTARCLLOGIN
********************/
GO
exec SPREGISTARCLLOGIN @EMAIL ='martim@gmail.com', @PASSWORD='1234rer' /*Correto*/
exec SPREGISTARCLLOGIN @EMAIL ='martimgmail.com', @PASSWORD='1234rer' /*Email errado*/
exec SPREGISTARCLLOGIN @EMAIL ='martim@gmail.com', @PASSWORD='1234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg1234567fefewfewfewfewf
ewfwehy5tdjtydjtyjytjtyudtyujj89utyg1234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg1234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg1
234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg1234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg' 
/*Pass demasiado longa*/
select*from CLLOGIN
GO


/********************
* Inserir login dos clientes atraves da SP spRegistarMetPag
********************/
GO
exec spRegistarMetPag @ANO='2025',@MES='12',@NUMCARTAO='123456789012345', @CVV='514' /*Correto*/
exec spRegistarMetPag @ANO='2030',@MES='11',@NUMCARTAO='12345678901234', @CVV='514' /*Numero do cartao com 14 caraters*/
exec spRegistarMetPag @ANO='2026',@MES='11',@NUMCARTAO='1234567890123465', @CVV='514' /*Numero do cartao com 16 caraters*/
exec spRegistarMetPag @ANO='2026',@MES='11',@NUMCARTAO='12345ab7890123465', @CVV='514' /*Numero do cartao com letras*/
exec spRegistarMetPag @ANO='2025',@MES='10',@NUMCARTAO='123456789012345', @CVV='43' /* Cvv demasiado curto*/
exec spRegistarMetPag @ANO='2025',@MES='12',@NUMCARTAO='123456789012345', @CVV='4354' /* Cvv demasiado longo*/
exec spRegistarMetPag @ANO='2025',@MES='12',@NUMCARTAO='123456789012345', @CVV='FTA' /* Caracters incorretos no CVV*/
exec spRegistarMetPag @ANO='2025',@MES='13',@NUMCARTAO='123456789012345', @CVV='514' /* Mes invalido*/
exec spRegistarMetPag @ANO='1990',@MES='9',@NUMCARTAO='123456789012345', @CVV='514' /* Ano invalido*/


select*from METPAGAMENTO
GO


/********************
* Inserir  clientes atraves da SP SPREGISTARCON
********************/
GO
exec SPREGISTARCON @DATANASC = '1999-05-04', @GENERO='M',@CC='12345678',@NIF='1234561789',@NOME='Manel',@NOMEMEIO='Artur',
@APELIDO='Silva', @TELEMOVEL='935156584', @LICTRANSP='123456' /*Correto*/

exec SPREGISTARCON @DATANASC = '2019-05-04', @GENERO='M',@CC='12345678',@NIF='1234561789',@NOME='Manel',@NOMEMEIO='Artur',
@APELIDO='Silva', @TELEMOVEL='935156584', @LICTRANSP='123456' /*Demasiado Novo*/

exec SPREGISTARCON @DATANASC = '1700-05-04', @GENERO='M',@CC='12345678',@NIF='1234561789',@NOME='Manel',@NOMEMEIO='Artur',
@APELIDO='Silva', @TELEMOVEL='935156584', @LICTRANSP='123456' /*Demasiado velho*/

exec SPREGISTARCON @DATANASC = '1999-05-04', @GENERO='M',@CC='12345678',@NIF='1234561789',@NOME='Manel',@NOMEMEIO='Artur',
@APELIDO='Silva', @TELEMOVEL='9225146584', @LICTRANSP='123456' /*Nº de telemovel invalido, demasiado longo*/



/********************
* Inserir  clientes atraves da SP SPREGISTARCONLOGIN 
********************/

exec SPREGISTARCONLOGIN @EMAIL ='martim@gmail.com', @PASSWORD='1234rer' /*Correto*/
exec SPREGISTARCONLOGIN @EMAIL ='martimgmail.com', @PASSWORD='1234rer' /*Email errado*/
exec SPREGISTARCONLOGIN @EMAIL ='martim@gmail.com', @PASSWORD='1234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg1234567fefewfewfewfewf
ewfwehy5tdjtydjtyjytjtyudtyujj89utyg1234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg1234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg1
234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg1234567fefewfewfewfewfewfwehy5tdjtydjtyjytjtyudtyujj89utyg' 
/*Pass demasiado longa*/


/********************
* Inserir  clientes atraves da SP SPREGISTARCARTACOND 
********************/

exec SPREGISTARCARTACOND @NUMERO='123456789',@DATAEMISSAO='2001-06-07'/*Correto*/
exec SPREGISTARCARTACOND @NUMERO='1234567890',@DATAEMISSAO='2001-06-07'/*Numero demasiado grande*/
exec SPREGISTARCARTACOND @NUMERO='12345678',@DATAEMISSAO='2001-06-07'/*Numero demasiado pequeno*/



/********************
* Inserir  clientes atraves da SP SPREGISTARCARTACOND 
********************/

exec SPREGISTARCARRO @MARCA='Renaut', @COR='Azul',  @COMBUSTIVEL='ELETRICO',  @MATRICULA='061555',  @LUGARES='4',  @DATAREGISTO='2018-08-06',  @MODELO='Passat',  @DUA='123470789' /*Correto*/
exec SPREGISTARCARRO @MARCA='Renaut', @COR='Azul',  @COMBUSTIVEL='GAS',  @MATRICULA='061555',  @LUGARES='4',  @DATAREGISTO='2018-08-06',  @MODELO='Passat',  @DUA='123470789' /*Combustivel invalido*/
exec SPREGISTARCARRO @MARCA='Renaut', @COR='Azul',  @COMBUSTIVEL='GAS',  @MATRICULA='06ty1555',  @LUGARES='4',  @DATAREGISTO='2018-08-06',  @MODELO='Passat',  @DUA='12347078' /*DUA e matricula invalida*/
exec SPREGISTARCARRO @MARCA='Ren4ut', @COR='A2ul',  @COMBUSTIVEL='GAS',  @MATRICULA='06ty1555',  @LUGARES='4',  @DATAREGISTO='2018-08-06',  @MODELO='Passat',  @DUA='12347078' /*Marca e cor invalida*/

select*from CARRO
select*from CONDUTOR



















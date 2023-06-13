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

-- Instrução SQL para definir o nome da Base de Dados no SSMS 2019

DROP DATABASE tp1
CREATE DATABASE tp1;

USE tp1;


/************************************************************
*  Creates
************************************************************/


CREATE TABLE Stock
(
	StockID INT PRIMARY KEY,
	StockItem VARCHAR(50),
	StockItemNO INT,
	StockItemPrice INT,
	StockItemQTY INT 
)

CREATE TABLE Customer
(
    CustomerID INT PRIMARY KEY,
    CustomerCode VARCHAR(10),
    CustomerName VARCHAR(50),
	CustomerGender Varchar(10),
)

/************************************************************
*  Populates
************************************************************/

insert into Customer ([CustomerID],[CustomerCode],[CustomerName],[CustomerGender]) values
(1,12,'jonh serra','M'),
(2,15,'bia garcia','F'),
(3,17,'margarida barreto','F'),
(4,18,'margarida teles','F'),
(5,14,'Francisco teles','M'),
(6,13,'Artur teles','M'),
(7,20,'Jose teles','M'),
(8,19,'Francisca teles','F');

insert into Stock ([StockID],[StockItem],[StockItemNO],[StockItemPrice],[StockItemQTY]) values
(1,'bola',1,13,5),
(2,'copo',2,5,8),
(3,'taco',3,10,9),
(4,'arco',4,5,10),
(5,'panela',5,17,12),
(6,'caneta',6,19,15),
(7,'banco',7,20,17),
(8,'pneu',8,50,2010);


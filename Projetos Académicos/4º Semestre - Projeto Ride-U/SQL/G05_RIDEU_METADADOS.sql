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

USE RIDEU
GO

-- Alterar o recovery model da BD para "Full" para podermos executar o backup da log
ALTER DATABASE RIDEU SET RECOVERY FULL
GO
CREATE OR ALTER PROCEDURE spBackupSemanal
as begin
	BACKUP DATABASE RIDEU TO 
	DISK = 'C:\SQL\RIDEU_full_1.BAK',
	DISK = 'C:\SQL\RIDEU_full_2.BAK',
	DISK = 'C:\SQL\RIDEU_full_3.BAK',
	DISK = 'C:\SQL\RIDEU_full_4.BAK'
	with INIT,NAME = 'FULL RIDEU backup',STATS=4
end
GO
DROP DATABASE RIDEU
GO
USE master
RESTORE DATABASE RIDEU 
  FROM  DISK = N'C:\SQL\RIDEU_full_1.BAK',  
  DISK = N'C:\SQL\RIDEU_full_2.BAK',
  DISK = 'C:\SQL\RIDEU_full_3.BAK',
  DISK = 'C:\SQL\RIDEU_full_4.BAK'
  WITH STATS=4,NOUNLOAD,NORECOVERY,replace
GO
-- executar plano de backups semanal acontece todas as 6f as 23:55
USE msdb ;  
GO  
EXEC dbo.sp_add_job  
    @job_name = N'FullBackupSemanal' ;  
GO  
EXEC sp_add_jobstep  
    @job_name = N'FullBackupSemanal',  
    @step_name = N'spBackupSemanal',  
    @subsystem = N'TSQL',  
    @command = N'EXEC spBackupSemanal',   
    @retry_attempts = 5,  
    @retry_interval = 5 ;  
GO  
EXEC dbo.sp_add_schedule 
    @schedule_name = N'FullBackupSemanal',  
    @freq_type=8, 
	@freq_interval=32, 
	@freq_subday_type=1, 
	@freq_recurrence_factor=1, 
	@active_start_date=20220521, 
	@active_start_time=235513  
USE msdb ;  
GO  
EXEC sp_attach_schedule  
   @job_name = N'FullBackupSemanal',  
   @schedule_name = N'FullBackupSemanal';  
GO  
EXEC dbo.sp_add_jobserver  
    @job_name = N'FullBackupSemanal';  
GO  

USE RIDEU
GO
-- VER METADADOS DOS BACKUPS
CREATE VIEW VW_metBackups as
SELECT    
    database_name, name, backup_start_date, backup_finish_date, datediff(mi, backup_start_date, backup_finish_date) [tempo (min)],
    position, first_lsn, last_lsn, server_name, recovery_model, isnull(logical_device_name, ' ') logical_device_name, device_type,
    type, cast(backup_size/1024/1024 as numeric(15,2)) [Tamanho (MB)], B.is_copy_only
FROM msdb.dbo.backupset B
INNER JOIN msdb.dbo.backupmediafamily BF ON B.media_set_id = BF.media_set_id
where backup_start_date >=  dateadd(hh, -24 ,getdate())
    and type in ('D','I','L') and database_name = 'RIDEU'
GO
SELECT * FROM VW_metBackups
GO
--MOSTRA TODOS OS OBJETOS DO SSMS, DATA DE CRIAÇÃO DATA DE MODIFICAÇÃO E TIPO DOS MESMOS
SELECT * FROM sys.all_objects
GO
-- VER METADADOS SOBRE AS TABELAS
CREATE or alter VIEW VW_metTabelas as
SELECT
    t.NAME AS Entidade,
    p.rows AS Registos,
    SUM(a.total_pages) * 8 AS EspacoTotalKB,
    SUM(a.used_pages) * 8 AS EspacoUsadoKB,
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS EspacoNaoUsadoKB
	FROM
    sys.tables t
INNER JOIN
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN
    sys.schemas s ON t.schema_id = s.schema_id
WHERE
    t.NAME NOT LIKE 'dt%'
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255
GROUP BY
    t.Name, s.Name, p.Rows
GO
select * from vw_mettabelas
GO
--VER SCHEMAS DE CADA TABELAS,VIEWS VALORES DEFAULT E SE EXISTE A POSSIBILIDADE DE HAVER NULLS
SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, 
COLUMN_NAME, COLUMN_DEFAULT, IS_NULLABLE
FROM
RIDEU.INFORMATION_SCHEMA.COLUMNS
GO
-- LISTA AS FKS E PK COMO TAMBEM O SCHEMA PERTENCENTE E O NOME DA TABELA
SELECT
DISTINCT
Constraint_Name AS 'Constraint',
Table_Schema AS 'schema',
Table_Name AS 'Tabela'
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
order by TABLE_NAME asc
GO

-- LISTA TODAS AS VIEWS CRIADAS NA BD EM UTILIZAÇÃO
SELECT isv.TABLE_NAME, isv.VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS isv
where isv.TABLE_NAME in
	( SELECT OBJECT_NAME(sv.object_id)
	FROM sys.views sv
	where sv.is_replicated = 0 )
GO
--Espaço que a base de dados ocupa
EXEC sp_spaceused @oneresultset = 1

go
/************************************************************
    INDICES
************************************************************/
SET STATISTICS IO ON

--Metadados indices criados na tabela 'viagem'
select object_name(object_id) tabela,
	index_type_desc ,
	alloc_unit_type_desc as data_type, 
	Index_id,
	Index_depth,
	Index_level,
	record_count,
	page_count
	,fragment_count
from sys.dm_db_index_physical_stats(db_id(),object_id('viagem'), NULL, NULL ,
'DETAILED')
GO

/************************************************************
    calculo da densidade para varias colunas
************************************************************/
-- abranger
SELECT 1.00 / (CAST(COUNT(DISTINCT ABRANGER_VIAID) AS DECIMAL(10,4))/ COUNT(ABRANGER_VIAID)) from ABRANGER --abaixo de 10% de densidade são utilizados nas consultas
-- carro 
SELECT 1.00 / (CAST(COUNT(DISTINCT CAR_C_ID) AS DECIMAL(10,4))/ COUNT(CAR_C_ID)) from CARRO
-- carro tipo
SELECT 1.00 / (CAST(COUNT(DISTINCT CARTIP_CAR_ID) AS DECIMAL(10,4))/ COUNT(CARTIP_CAR_ID)) from CARROTIPO
-- carta condução
SELECT 1.00 / (CAST(COUNT(DISTINCT cc_con_id) AS DECIMAL(10,4))/ COUNT(cc_con_id)) from CARTACONDUCAO
-- condavcl
SELECT 1.00 / (CAST(COUNT(DISTINCT AVCL_VIID) AS DECIMAL(10,4))/ COUNT(AVCL_VIID)) from CONDAVCL
-- clavcond
SELECT 1.00 / (CAST(COUNT(DISTINCT AVCON_VIID) AS DECIMAL(10,4))/ COUNT(AVCON_VIID)) from ClAVcond
-- deter
SELECT 1.00 / (CAST(COUNT(DISTINCT DETER_CL_ID) AS DECIMAL(10,4))/ COUNT(DETER_CL_ID)) from deter
--obter
SELECT 1.00 / (CAST(COUNT(DISTINCT OBT_FATID) AS DECIMAL(10,4))/ COUNT(OBT_FATID)) from obter --abaixo de 10% de densidade são utilizados nas consultas
--pagar
SELECT 1.00 / (CAST(COUNT(DISTINCT PAGAR_FATID) AS DECIMAL(10,4))/ COUNT(PAGAR_FATID)) from pagar
--ter
SELECT 1.00 / (CAST(COUNT(DISTINCT TER_METID) AS DECIMAL(10,4))/ COUNT(TER_METID)) from ter --abaixo de 10% de densidade são utilizados nas consultas
SELECT 1.00 / (CAST(COUNT(DISTINCT TER_CLID) AS DECIMAL(10,4))/ COUNT(TER_CLID)) from ter
/************************************************************
    calculo da seletividade para varias colunas
************************************************************/
-- abranger
select CAST(COUNT(DISTINCT ABRANGER_VIAID) AS DECIMAL(10,4))/ COUNT(ABRANGER_VIAID) from ABRANGER
--carro
select CAST(COUNT(DISTINCT CAR_C_ID) AS DECIMAL(10,4))/ COUNT(CAR_C_ID) from CARRO
--carro tipo
select CAST(COUNT(DISTINCT CARTIP_CAR_ID) AS DECIMAL(10,4))/ COUNT(CARTIP_CAR_ID) from CARROTIPO
--condavcl
select CAST(COUNT(DISTINCT AVCL_VIID) AS DECIMAL(10,4))/ COUNT(AVCL_VIID) from CONDAVCL
--clavcond
select CAST(COUNT(DISTINCT AVCON_VIID) AS DECIMAL(10,4))/ COUNT(AVCON_VIID) from ClAVcond
--deter
SELECT CAST(COUNT(DISTINCT DETER_CL_ID) AS DECIMAL(10,4))/ COUNT(DETER_CL_ID) from deter
--obter
select CAST(COUNT(DISTINCT OBT_FATID) AS DECIMAL(10,4))/ COUNT(OBT_FATID) from OBTER
--pagar
SELECT CAST(COUNT(DISTINCT PAGAR_FATID) AS DECIMAL(10,4))/ COUNT(PAGAR_FATID) from pagar
--ter
select CAST(COUNT(DISTINCT TER_METID) AS DECIMAL(10,4))/ COUNT(TER_METID) from TER
SELECT CAST(COUNT(DISTINCT TER_CLID) AS DECIMAL(10,4))/ COUNT(TER_CLID) from TER
/************************************************************
    CRIAÇÃO DE INDICES PARA OS ATRIBUTOS ACIMA REFERENCIADOS
************************************************************/
--abranger
CREATE NONCLUSTERED INDEX IX_ABRANGER_VIAID
ON ABRANGER (ABRANGER_VIAID);
--carro
CREATE NONCLUSTERED INDEX IX_CAR_CC_ID
ON carro (CAR_C_ID);
--carrotipo
CREATE NONCLUSTERED INDEX IX_CARTIP_CAR_ID
ON carrotipo (CARTIP_CAR_ID);
--condavcl
CREATE NONCLUSTERED INDEX IX_AVCL_VIID
ON condavcl (AVCL_VIID);
--clavcond
CREATE NONCLUSTERED INDEX IX_AVCON_VIID
ON clavcond (AVCON_VIID);
--deter
CREATE NONCLUSTERED INDEX IX_DETER_CL_ID
ON deter (DETER_CL_ID);
--obter
CREATE NONCLUSTERED INDEX IX_OBT_FATID
ON obter (OBT_FATID);
--pagar
CREATE NONCLUSTERED INDEX IX_PAGAR_FATID
ON pagar (PAGAR_FATID);
--ter
CREATE NONCLUSTERED INDEX IX_TER_METID
ON ter (TER_METID);
CREATE NONCLUSTERED INDEX IX_TER_CLID
ON ter (TER_CLID);

-- retorna um conjunto de metadados sobre o indice especificado(numero de linhas,densidade,media do comprimento etc)
DBCC SHOW_STATISTICS(abranger,IX_ABRANGER_VIAID)
DBCC SHOW_STATISTICS(carro,IX_CAR_C_ID)
DBCC SHOW_STATISTICS(carrotipo,IX_CARTIP_CAR_ID)
DBCC SHOW_STATISTICS(condavcl,AVCL_VIID)
DBCC SHOW_STATISTICS(clavcond,IX_AVCON_VIID)
DBCC SHOW_STATISTICS(deter,IX_DETER_CL_ID)
DBCC SHOW_STATISTICS(obter,IX_OBT_FATID)
DBCC SHOW_STATISTICS(pagar,IX_PAGAR_FATID)
DBCC SHOW_STATISTICS(ter,IX_TER_METID)
DBCC SHOW_STATISTICS(ter,IX_TER_CLID)
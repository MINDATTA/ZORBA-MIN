
--How to List all Missing Identity Values for all Tables in SQL Server Database - SQL Server / T-SQL Tutorial
--Scenario : Download Script
--You are working as SQL Server Developer / TSQL developer for Law firm. You are doing working on data validation / data analysis project. Once of the task you got for analysis, You need to list all the missing Identity values for all the tables in SQL Server Database. 

--Solution:
--We will use cursor to loop through all the tables in a database which has identity column. we will load the missing identity values for each table in temp table and print at the end. We will get Database Name, Schema Name, Table Name, Identity Column and Missing Identity Values. 

--If you would like to run the script for single table. You can edit Where clause and include Table Name.

--USE YourDBName

go 

DECLARE @SchemaName VARCHAR(100) 
DECLARE @TableName VARCHAR(100) 
DECLARE @DatabaseName VARCHAR(100) 
DECLARE @IdentyColumnName VARCHAR(100) 

--Create Temp Table to Save Results    
IF Object_id('tempdb..##Results') IS NOT NULL 
  DROP TABLE ##results 

CREATE TABLE ##results 
  ( 
     schemaname           VARCHAR(100), 
     tablename            VARCHAR(100), 
     identitycolumname    VARCHAR(100), 
     identitymissingvalue INT 
  ) 

DECLARE cur CURSOR FOR 
  SELECT Schema_name(schema_id)   AS SchemaName, 
         Object_name(c.object_id) AS TableName, 
         C.NAME                   AS IdentityColumnName 
  FROM   sys.columns c 
         INNER JOIN sys.tables t 
                 ON c.object_id = t.object_id 
  WHERE  is_identity = 1 

OPEN cur 

FETCH next FROM cur INTO @SchemaName, @TableName, @IdentyColumnName 

WHILE @@FETCH_STATUS = 0 
  BEGIN 
      DECLARE @SQL VARCHAR(max)=NULL 
      DECLARE @InitialIDValue INT=1 
      DECLARE @MaxIdentityId INT 
      DECLARE @MAXID TABLE 
        ( 
           maxidentityid INT 
        ) 

      DELETE FROM @MAXID 

      DECLARE @SQLIdentity NVARCHAR(max) 

      SET @SQLIdentity='SELECT MAX(' + @IdentyColumnName + ') From [' 
                       + @SchemaName + '].[' + @TableName + ']' 

      INSERT INTO @MAXID 
      EXEC(@SQLIdentity) 

      --Select * from @MAXID  
      SET @MaxIdentityId=(SELECT * 
                          FROM   @MAXID) 

      PRINT @MaxIdentityId 

      WHILE @InitialIDValue <= @MaxIdentityId 
        BEGIN 
            DECLARE @SQLQuery NVARCHAR(max)=NULL 
            DECLARE @InitialIDValueCHAR VARCHAR(10)=NULL 

            SET @InitialIDValueCHAR=Cast(@InitialIDValue AS VARCHAR(10)) 

            PRINT @InitialIDValueCHAR 

            SET @SQLQuery=' IF NOT EXISTS (SELECT 1 FROM [' 
                          + @SchemaName + '].[' + @TableName 
                          + ']                    WHERE [' 
                          + @IdentyColumnName + '] = ' 
                          + @InitialIDValueCHAR + ')            INSERT INTO ##results(SchemaName,TableName,IdentityColumName,IdentityMissingValue )            VALUES ( ''' 
                          + @SchemaName + '''' + ',''' + @TableName + '''' + 
                          ',''' 
                          + @IdentyColumnName + '''' + ',''' 
                          + @InitialIDValueCHAR + ''')' 

            PRINT @SQLQuery 

            EXEC (@SQLQuery) 

			
            SET @InitialIDValue = @InitialIDValue + 1 
        END 

      FETCH next FROM cur INTO @SchemaName, @TableName, @IdentyColumnName 
  END 

CLOSE cur 

DEALLOCATE cur 

SELECT Db_name() AS DatabaseName, 
       schemaname, 
       tablename, 
       identitycolumname, 
       identitymissingvalue 
FROM   ##results 
ORDER  BY tablename 

--testing --select * from students_new

--drop table #Results 

USE SONGS

--To rename table names in UPPER Case:

SELECT 'EXEC sp_rename '
+ '''' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ''', '
+ '''' + UPPER(TABLE_NAME) + ''''
FROM INFORMATION_SCHEMA.TABLES
WHERE OBJECTPROPERTY(OBJECT_ID(QUOTENAME(TABLE_SCHEMA) + '.' +
QUOTENAME(TABLE_NAME)), 'IsMSShipped') = 0
AND TABLE_TYPE = 'BASE TABLE'
ORDER BY QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)

--EXECUTE ALL QUERY AS BELLOW TO RENAME OF ALL TABLE AS IN UPPER CASE.
EXEC sp_rename '[dbo].[CD]', 'CD'
EXEC sp_rename '[dbo].[CUSTOMER]', 'CUSTOMER'
EXEC sp_rename '[dbo].[EMPLOYEE]', 'EMPLOYEE'
EXEC sp_rename '[dbo].[EMPLOYEES]', 'EMPLOYEES'
EXEC sp_rename '[dbo].[PRODUCER]', 'PRODUCER'
EXEC sp_rename '[dbo].[SONG]', 'SONG'
EXEC sp_rename '[dbo].[SUPPLIER]', 'SUPPLIER'
EXEC sp_rename '[dbo].[sysdiagrams]', 'SYSDIAGRAMS'
EXEC sp_rename '[dbo].[VIP]', 'VIP'

--To rename Columns names in UPPER Case:

SELECT 'EXEC sp_rename ''' + TABLE_SCHEMA + '.' + TABLE_NAME + '.' + 
COLUMN_NAME + ''', ''' +
UPPER(COLUMN_NAME) + ''',''COLUMN'''
FROM INFORMATION_SCHEMA.COLUMNS
WHERE OBJECTPROPERTY(OBJECT_ID('[' + TABLE_SCHEMA + '].[' + TABLE_NAME + ']'),
'isMSShipped') = 0



SELECT TOP 10 * FROM
[INFORMATION_SCHEMA].[COLUMNS]
WHERE TABLE_NAME ='COPY_CUSTOMERS'

UPDATE [INFORMATION_SCHEMA].[COLUMNS]
SET ORDINAL_POSITION = 6
WHERE TABLE_NAME = 'COPY_CUSTOMERS'
AND COLUMN_NAME =  'CCITY'

UPDATE [INFORMATION_SCHEMA].[COLUMNS]
SET ORDINAL_POSITION = 7
WHERE TABLE_NAME = 'COPY_CUSTOMERS'
AND COLUMN_NAME =  'CBRANCHID'
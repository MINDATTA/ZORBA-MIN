USE ZORBA
DROP TABLE LOAD_DIFF_SOURCES
SELECT * FROM LOAD_DIFF_SOURCES

select * from EMPLOYEES

select * into duprecords from employees
drop table duprecords
select * from duprecords 

CREATE TABLE [dbo].[duprecords](
	[EID] [int] IDENTITY(1,1) NOT NULL,
	[ENAME] [varchar](20) NULL,
	[ESALARY] [money] NULL,
	[DID] [int] NULL
)

Insert into duprecords values

('SREEKANTH	',30000.00	,1),
('PAYAL		',40000.00	,1),
('MANOJ		',50000.00	,1),
('SINDHU	',35000.00	,2),
('HARI		',45000.00	,2),
('VIVEK		',55000.00	,2),
('SWETHA	',33000.00	,3),
('KRISHNA	',43000.00	,3),
('PAVANI	',53000.00	,3),
('ASHOK		',34000.00	,4),
('KIRAN		',44000.00	,4),
('RAHU		',54000.00	,4),
('VINAY		',36000.00	,5),
('RAJ		',46000.00	,5),
('RANJITH	',56000.00	,5)

select * from duprecords

--Method 1 using CTE 

BEGIN TRANSACTION

;with dup as 
(
select eid, ename, esalary, did, ROW_NUMBER() over (partition by did, esalary order by ename ) as dup_values from duprecords
)
--select * from dup
DELETE FROM dup where dup_values > 1
--ORDER BY ENAME 
	
ROLLBACK

--Method 2 using #tmp 

drop table #tmp 
begin transaction

(
select eid, ename, esalary, did, ROW_NUMBER() over (partition by did, esalary order by ename ) as dup_values into #tmp from duprecords
)
--select * from #tmp
DELETE FROM #tmp where dup_values > 1

rollback

select * from #tmp 

--Method 3 using Distinct

BEGIN TRANSACTION

SELECT DISTINCT E.EID, E.ENAME, E.ESALARY, E.DID 
--DELETE FROM E
FROM duprecords E 
JOIN duprecords F 
ON E.ENAME = F.ENAME  
AND E.EID > F.EID 
ORDER BY ENAME 
	
ROLLBACK

SELECT * from duprecords

-- Method 4 using Aggregation

SELECT * from duprecords
--DELECTE FROM duprecords
WHERE EID NOT IN ( SELECT MIN (EID) FROM duprecords GROUP BY ENAME) 
ORDER BY ENAME 

--Method 5 

create #temp as 
select * from duprecords group by eid, ename, esalary, did having count(*)>1;




drop table emptst 

select * from emptst

CREATE TABLE [dbo].[emptst]
(
	emp_no int,
	emp_name Varchar(10),
	dep_id varchar(10),
	salary float NULL
)

insert into emptst values 
(1,'A1','D1',1000),
(2,'A2','D1',3000),
(3,'A3','D2',4000),
(4,'A4','D1',2000),
(5,'A6','D2',3000)


SELECT * FROM EMPTST 
		
-- output should be 

--emp_no	emp_name	dep_id	salary
--1		A1			D1		6000
--2		A2			D1		6000
--3		A3			D2		7000
--4		A4			D1		6000
--5		A6			D2		7000

--USING #TMP

SELECT DEP_ID, SUM(SALARY) AS SALARY INTO #TEMP1 FROM EMPTST GROUP BY DEP_ID
select *from #temp1
SELECT T1.EMP_NO, T1.EMP_NAME, T1.DEP_ID, T11.SALARY FROM EMPTST  T1 JOIN #TEMP1 T11
ON T1.dep_id = T11.DEP_ID

--USING CTE

with cte_sum_sal 
as 
(select dep_id, sum(salary) as salary from emptst GROUP BY DEP_ID)
SELECT T1.EMP_NO, T1.EMP_NAME, T1.DEP_ID, T11.SALARY FROM EMPTST  T1 JOIN cte_sum_sal T11
ON T1.dep_id = T11.DEP_ID

















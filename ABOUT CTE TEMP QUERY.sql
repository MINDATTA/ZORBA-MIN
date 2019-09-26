--CTE

CTE: Common Table Expressions (CTE) have two types, recursive and non-recursive
CTE LIMITATION :
CTE-Select cannot include following clauses:
	DISTINCT
	INTO
	ORDER BY (except when a TOP clause is specified)
	GROUP BY
	OPTION clause with query hints FOR BROWSE
CTE-cannot include PIVOTed or Un-PIVOTed data;

1)	Simple-CTE: Defining a table expression with WITH statement.

drop table employee
create table employee
(
	ID int,
	first_Name varchar(20)
)

insert into employee values (1,'tom'), (2, 'smith'), (3, 'kate'), (4, 'luke'),(2, 'smith'), (3, 'kate')
SELECT ID,first_Name FROM employee




;WITH MySearch (ID, f_Name)
         AS ( SELECT ID,first_Name FROM employee)
 Select *  from MySearch a join employee e on a.id = e.id
 
 select getdate()
 select * from mysearch

001) one advantage is one step short then doing temp table to get distinct value

SELECT ID,first_Name FROM employee

SELECT ID,first_Name, row_number () over(partition by id, first_Name order by id) as cnt into #temp FROM employee 
select ID,first_Name from #temp where cnt = 1


;with ctename 
as 
(
	SELECT ID,first_Name, row_number () over(partition by id, first_Name order by id) as cnt  FROM employee 
)
select id, first_Name from ctename where cnt = 1


2)	Simple-CTE2: Defining CTE without Column aliasing
;WITH MySearch 
         AS ( SELECT ID,first_Name FROM employee)
 Select * from MySearch 


3)	Multiple CTEs using single WITH AS statement.
;WITH A AS (select * from Table1 ),
       B AS (select id, name Table2),
       C AS (Select name from Table3)
Select * from A,B,C;


4)	CTE with SET-operators.
WITH cte_Sample1
     AS (SELECT name from TABLE1 UNION ALL SELECT name from TABLE2)
Select * from cte_Sample1;



To demonstrate how the recursive CTE works:

IF OBJECT_ID('Employees', 'U') IS NOT NULL
DROP TABLE dbo.Employees
GO
CREATE TABLE dbo.Employees
(
  EmployeeID int NOT NULL PRIMARY KEY,
  FirstName varchar(50) NOT NULL,
  LastName varchar(50) NOT NULL,
  ManagerID int NULL
)
GO
INSERT INTO Employees VALUES (101, 'Ken', 'SMITH', NULL)
INSERT INTO Employees VALUES (102, 'Terri', 'Duffy', 101)
INSERT INTO Employees VALUES (103, 'Roberto', 'Tamburello', 101)
INSERT INTO Employees VALUES (104, 'Rob', 'Walters', 102)
INSERT INTO Employees VALUES (105, 'Gail', 'Erickson', 102)
INSERT INTO Employees VALUES (106, 'Jossef', 'Goldberg', 103)
INSERT INTO Employees VALUES (107, 'Dylan', 'Miller', 103)
INSERT INTO Employees VALUES (108, 'Diane', 'Margheim', 105)
INSERT INTO Employees VALUES (109, 'Gigi', 'Matthew', 105)
INSERT INTO Employees VALUES (110, 'Michael', 'Raheem', 106)

SELECT * FROM dbo.Employees

;WITH
  cteReports (EmpID, FirstName, LastName, MgrID, EmpLevel)
  AS
  (
    SELECT EmployeeID, FirstName, LastName, ManagerID, 1
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.FirstName, e.LastName, e.ManagerID, 
      r.EmpLevel + 1
    FROM Employees e
      INNER JOIN cteReports r
        ON e.ManagerID = r.EmpID
  )
SELECT
  FirstName + ' ' + LastName AS FullName, 
  EmpLevel,
  (SELECT FirstName + ' ' + LastName FROM Employees 
    WHERE EmployeeID = cteReports.MgrID) AS Manager
FROM cteReports 
ORDER BY EmpLevel, MgrID
 
The CTE query is itself made up of two SELECT statements, connected with the UNION ALL operator. A recursive CTE query must contain at least two members (statements), connected by the UNION ALL, UNION, INTERSECT, or EXCEPT operator. In this example, the first SELECT statement is the anchor member, and the second statement is the recursive member. All anchor members must precede the recursive members, and only the recursive members can reference the CTE itself. In addition, all members must return the same number of columns with corresponding data types.
Now lets look closer at the statements themselves. The first statement, the anchor member, retrieves the employee ID, first name, last name, and manager ID from the Employees table, where the manager ID is null. This would be the employee at the top of the hierarchy, which means this person reports to no one. Consequently, the manager ID value is null. To reflect that this person is at the top of the hierarchy, I assign a value of 1 to the EmpLevel column.
The second statement in the CTE query-the recursive member-also retrieves the employee ID, first name, last name, and manager ID for employees in the Employees table. However, notice that I join the Employees table to the CTE itself. In addition, the join is based on the manager ID in the Employees table and the employee ID in the CTE. By doing this, the CTE will loop through the Employees table until it returns the entire hierarchy.
One other item to notice about the second statement is that, for the EmpLevel column, I add the value 1 to the EmpLevel value as it appears in the CTE. That way, each time the statement loops through the hierarchy, the next correct level is applied to the employees at the level.

Different between temp table and cte:

CTEs...
•	Are unindexable (but can use existing indexes on referenced objects)
•	Cannot have constraints
•	Are essentially disposable VIEWs
•	Persist only until the next query is run
•	Can be recursive

#Temp Tables...
•	Are real materialized tables that exist in tempdb
•	Can be indexed
•	Can have constraints
•	Can be referenced by other queries or subprocedures



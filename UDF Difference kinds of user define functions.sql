use master

--Three difference kinds of User DefineCREATE TABLE Employeee
(
 EmpID int PRIMARY KEY,
 FirstName varchar(50) NULL,
 LastName varchar(50) NULL,
 Salary int NULL,
 Address varchar(100) NULL,
)
--Insert Data
Insert into Employeee(EmpID,FirstName,LastName,Salary,Address) Values(1,'Mohan','Chauahn',22000,'Delhi');
Insert into Employeee(EmpID,FirstName,LastName,Salary,Address) Values(2,'Asif','Khan',15000,'Delhi');
Insert into Employeee(EmpID,FirstName,LastName,Salary,Address) Values(3,'Bhuvnesh','Shakya',19000,'Noida');
Insert into Employeee(EmpID,FirstName,LastName,Salary,Address) Values(4,'Deepak','Kumar',19000,'Noida');
--See created table
Select * from Employeee 

--1. Scalar Function - return single values from the table.
Create function fnGetEmpFullName
(
 @FirstName varchar(50),
 @LastName varchar(50)
)
returns varchar(101)
As
Begin 
	return (Select @FirstName + ' '+ @LastName);
end 
--exec
Select dbo.fnGetEmpFullName(FirstName,LastName) as Name, Salary from Employeee  


--2. Inline Table-Valued Function

 Create function fnGetEmployee()
returns Table
As
 return (Select * from Employeee) 

--exec
 Select * from fnGetEmployee() 

 --3. Multi-Statement Table-Valued Function

 Create function fnGetMulEmployee()
returns @Emp Table
(
EmpID int, 
FirstName varchar(50),
Salary int
)
As
begin
 Insert into @Emp Select e.EmpID,e.FirstName,e.Salary from Employeee e;
--Now update salary of first employee
 update @Emp set Salary=25000 where EmpID=1;
--It will update only in @Emp table not in Original Employeee table
return
end 

--exec
Select * from fnGetMulEmployee() 

 --Now see the original table. This is not affected by above function update command

Select * from Employeee



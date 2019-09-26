--FUNCTION AND STORE PROCEDURE
--DIFFERENCE

--Example 1)
Drop Table R_EMPNAME

Create Table R_EMPNAME
(
FIRSTNAME Varchar (10),
MIDDLENAME Varchar(10),
LASTNAME Varchar (10),
ZIP_Address Varchar (15),
Date_of_Join Date
)

Select * From R_EMPNAME

Insert Into R_EMPNAME Values ('RAM',	'PRASHAD',	'RAI',	'75623',	'12/21/2018')
Insert Into R_EMPNAME Values ('SITA',	Null,	'PUN',	'878',	'1/20/2018')
Insert Into R_EMPNAME Values ('RABIN',	Null,	Null,	'78657-23',	'2/24/2017')
Insert Into R_EMPNAME Values ('  hari',	Null,	'roKa',	'778973432',	'1/11/2018')
Insert Into R_EMPNAME Values ('sabin ', 	Null,	'gurung',	'34567',	'5/27/2018')
Insert Into R_EMPNAME Values ('Majon',	'kumar',	'Maharajan',	'87868',	'12/29/2018')
Insert Into R_EMPNAME Values (Null,	Null,	'gurung',	'89789-23',	'10/4/2018')

Select * From R_EMPNAME


--TABLE TO BE INSERT INTO
drop table s_empname

Create Table S_EMPNAME
(
FullName Varchar (45),
ZIP_CODE varchar(20),
STATUS Varchar(10),
LOAD_DTM Date
)


drop PROCEDURE spInsert_Employee
alter PROCEDURE [dbo].[spInsert_Employee]

AS
BEGIN

--TRUNCATE TABLE DBO.S_EMPNAME

IF OBJECT_ID('tempdb.dbo.#TEMP', 'U') IS NOT NULL
  DROP TABLE #TEMP; 

Select
UPPER(LEFT(LTRIM(RTRIM(LASTNAME)),1)) + LOWER(SUBSTRING(LTRIM(RTRIM(LASTNAME)), 2 , LEN(LASTNAME)))   AS LASTNAME
,UPPER(LEFT(LTRIM(RTRIM(FIRSTNAME)),1)) + LOWER(SUBSTRING(LTRIM(RTRIM(FIRSTNAME)), 2 , LEN(FIRSTNAME)))  AS FIRSTNAME
,UPPER(LEFT(LTRIM(RTRIM(MIDDLENAME)),1)) + LOWER(SUBSTRING(LTRIM(RTRIM(MIDDLENAME)), 2 , LEN(MIDDLENAME)))  AS MIDDLENAME,
case 
when (len(Zip_Address) >= 5 ) then Left (Zip_Address,5)
When (len(Zip_Address) < 5 ) then Null
END
AS ZIP1 
,
Date_OF_Join,
Case
When Date_of_Join  < GETDATE() then 'Active'
Else 'Inactive' 
end
AS Status

, EOMONTH(Getdate()) AS LOAD_DTM

INTO #TEMP
From R_EMPNAME



INSERT INTO S_EMPNAME

SELECT 
ISNULL(LASTNAME, '') + ', ' + ISNULL(FIRSTNAME, '') + ' ' + ISNULL(MIDDLENAME, '')
, ZIP1,
 STATUS, 
 LOAD_DTM
FROM #TEMP

--SELECT * FROM r_EMPNAME
--SELECT * FROM S_EMPNAME


END


EXEC spInsert_Employee

SELECT * FROM S_EMPNAME

SELECT * FROM r_EMPNAME
SELECT * FROM S_EMPNAME






--EXAMPLE 2 : sp with parameter, if you have multiple you need to pass same patter parameter.
Select * From R_EMPNAME
SELECT * FROM S_EMPNAME

drop procedure spINSERT_PARAMETER
create PROCEDURE spINSERT_PARAMETER  @LASTNAME VARCHAR(20)
AS
begin
--truncate table s_empname

insert into s_empname

SELECT ISNULL(LASTNAME, '') + ', ' + ISNULL(FIRSTNAME, '') + ' ' + ISNULL(MIDDLENAME, '') 
, ZIP_Address, 
Case
When Date_of_Join  < GETDATE() then 'Active'
Else 'Inactive' 
end,
getdate()
from R_EMPNAME where LASTNAME =  @LASTNAME

SELECT * FROM S_EMPNAME
end

--you can execute in following three ways
exec spINSERT_PARAMETER 'abc'
spINSERT_PARAMETER 'gurung'
execute spINSERT_PARAMETER 'gurung'


--to see how store procedure is created:
sp_helptext spINSERT_PARAMETER





--example 3
drop procedure sp_combine_multiple_sp

create procedure sp_combine_multiple_sp
with encryption -- if you have this nobody can see what is in script of that store procedure using "sp_helptext"
as

begin
exec spInsert_Employee
exec spINSERT_PARAMETER 'gurung'
SELECT * FROM S_EMPNAME

end

exec sp_combine_multiple_sp

exec sp_helptext sp_combine_multiple_sp   -- if you have with encryption, you cannot see what is in store procedure




--example 4 : input and output parameter in store procedure

Drop Table Book

Create Table Book
(
Book_Id Varchar (15) Primary Key,
Book_Name Varchar (40),
ISBN Int ,
Cost_Price Money,
Published_Year varchar(20)
)

Select * From Book

Insert Into Book Values ('b001', 'Hardware Methodology', 2541122,	700, '2018')
Insert Into Book Values ('b002', 'Fundamental of Finance',	2548846,	1250, '2018')
Insert Into Book Values ('b003', 'Mobile Technology',	2545625,	700, '2016')
Insert Into Book Values ('b004', 'Art of Living',	1142586,	620, '2001')
Insert Into Book Values ('b005', 'World in 2050',	2145786,	526, '2007')
Insert Into Book Values ('b006', 'Anthologies',	1244824,	846, '2016')
Insert Into Book Values ('b007', 'The Sun Also Rises',	2214552,	632, '2007')
Insert Into Book Values ('b008', 'To Kill A Mockingbird',	8451355,	1400, '2003')
Insert Into Book Values ('b009', 'The Biographies of Dalai Lama',	1296565,	320, '2001')

Select * From Book


create procedure spCountNumberOfBook_byYear
@Published_Year varchar(20),
@countnumberofbook int output
as
begin
select @countnumberofbook = count(*) from Book where Published_Year = @Published_Year
end

--execute
declare @variabletoholdoutputvalue int  -- datatype of output parameter need to match 
exec spCountNumberOfBook_byYear '2018' , @variabletoholdoutputvalue out  -- you can use out or output
select @variabletoholdoutputvalue




--next way
--execute
declare @variabletoholdoutputvalue int  -- datatype of output parameter need to match 
exec spCountNumberOfBook_byYear  @countnumberofbook = @variabletoholdoutputvalue out,  @Published_Year = '2018' -- when you specifice parameter name, order of parmeter can also change
select @variabletoholdoutputvalue
if @variabletoholdoutputvalue > 0
begin
	print 'greater than 0'
end
else
begin
	print 'not greater than 0'
end



---

ALTER PROCEDURE ABC @YEARPUBLICE VARCHAR(20)
AS
BEGIN

declare @variabletoholdoutputvalue int  -- datatype of output parameter need to match 
exec spCountNumberOfBook_byYear @YEARPUBLICE , @variabletoholdoutputvalue out  -- you can use out or output
--select @variabletoholdoutputvalue
IF @variabletoholdoutputvalue > 0
	SELECT * FROM BOOK WHERE Published_Year = @YEARPUBLICE
ELSE
SELECT 'NO DATA'
END
---




sp_depends spCountNumberOfBook_byYear
sp_depends sp_combine_multiple_sp
sp_depends spInsert_Employee
sp_depends r_empname


--EXAMPLE 
--EXAMPLE OF DEFAULT PARAMETER 
Drop Table Book

Create Table Book
(
Book_Id Varchar (15) Primary Key,
Book_Name Varchar (40),
ISBN Int ,
Cost_Price Money,
Published_Year varchar(20)
)

Select * From Book

Insert Into Book Values ('b001', 'Hardware Methodology', 2541122,	700, '2018')
Insert Into Book Values ('b002', 'Fundamental of Finance',	2548846,	1250, '2018')
Insert Into Book Values ('b003', 'Mobile Technology',	2545625,	700, '2016')
Insert Into Book Values ('b004', 'Art of Living',	1142586,	620, '2001')
Insert Into Book Values ('b005', 'World in 2050',	2145786,	526, '2007')
Insert Into Book Values ('b006', 'Anthologies',	1244824,	846, '2016')
Insert Into Book Values ('b007', 'The Sun Also Rises',	2214552,	632, '2007')
Insert Into Book Values ('b008', 'To Kill A Mockingbird',	8451355,	1400, '2003')
Insert Into Book Values ('b009', 'The Biographies of Dalai Lama',	1296565,	320, '2001')

Select * From Book


create procedure spDefault_parameterExample 
@Published_Year varchar(20) = NULL

as
begin
select * from Book where Published_Year = ISNULL(@Published_Year, Published_Year)
end

EXEC spDefault_parameterExample 
EXEC spDefault_parameterExample '2018'
EXEC spDefault_parameterExample @Published_Year = '2003'




drop table r_empname, s_empname, Book

drop procedure spInsert_Employee, spINSERT_PARAMETER, sp_combine_multiple_sp, spCountNumberOfBook_byYear, spDefault_parameterExample





























--question:

CREATE PROCEDURE [dbo].[USP_StudentInformation]
@S_Name VARCHAR(50)
,@S_Address VARCHAR(500)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @Date VARCHAR(50)

SET @Date = GETDATE()


IF EXISTS (
        SELECT *
        FROM TB_StdFunction
        WHERE S_Name = @S_Name
            AND S_Address = @S_Address
        )
BEGIN
    UPDATE TB_StdFunction
    SET S_Name = @S_Name
        ,S_Address = @S_Address
        ,ModifiedDate = @Date
    WHERE S_Name = @S_Name
        AND S_Address = @S_Address

    SELECT *
    FROM TB_StdFunction
END
ELSE
BEGIN
    INSERT INTO TB_StdFunction (
        S_Name
        ,S_Address
        ,CreatedDate
        )
    VALUES (
        @S_Name
        ,@S_Address
        ,@date          
        )

    SELECT *
    FROM TB_StdFunction
END
END







-------------------------------------------------
carloan:	

R_LOAN		

SSN		loadamount	interestperyear	numberofyear	loaddate
1111	12000	     5	             1	            20181207
2222	15000	     3	             3	            20181207
				

EXEC SPABC loadamount,	interestperyear,	numberofyear,	loaddate,	ssn

DROP TABLE R_LOAD

CREATE TABLE R_LOAD
(
SSN INT,
loadamount	NUMERIC(12,2),
interestperyear	 INT,
numberofyear INT,
loaddate DATE
)

INSERT INTO R_LOAD VALUES (1111, 12000.00, 5, 1, '20181012')

SELECT * FROM R_LOAD
SELECT * FROM S_LOAN

CREATE TABLE S_LOAN
(
SSN INT,
INTEREST_AMT NUMERIC(12,2),
PRINCIPLE_AMT  NUMERIC(12,2),
MONTHLY_AMT  NUMERIC(12,2),
BALANCE_AMT  NUMERIC(12,2),
DUE_DATE DATE
)


-------------------------------
DECLARE @SSN INT =1111
DECLARE @loadamount	NUMERIC(12,2) = 12000.00
DECLARE @interestperyear	NUMERIC(12,2) = 5
DECLARE @numberofyear INT = 1
DECLARE @loaddate DATE = '20181210'

DECLARE @NEXT_MONTH DATE  = @loaddate
SET @NEXT_MONTH = DATEADD(D, 1, EOMONTH(@NEXT_MONTH))


--SELECT @SSN, @loadamount, @interestperyear, @numberofyear, @loaddate

DECLARE @NUMBEROFMONTHTOLOOP INT
DECLARE @LOOP_START INT = 1
DECLARE @PRINCIPLE NUMERIC(12,2)

DECLARE @INTERESTPERMONTH NUMERIC(12,2)
DECLARE @BALANCE_AMT NUMERIC(12,2) = @loadamount
DECLARE @MONTHLY_PAYMENT NUMERIC(12,2)

SET @NUMBEROFMONTHTOLOOP = @numberofyear * 12
SET @PRINCIPLE = @loadamount/ @NUMBEROFMONTHTOLOOP  -- NEED TO PAY EACH MONTH
SET @INTERESTPERMONTH = (@interestperyear * @BALANCE_AMT)/ 100
SET @MONTHLY_PAYMENT = @INTERESTPERMONTH+@PRINCIPLE
--SET @BALANCE_AMT = @BALANCE_AMT - 1000


WHILE @LOOP_START <= @NUMBEROFMONTHTOLOOP
BEGIN

INSERT INTO S_LOAN
SELECT @LOOP_START , @INTERESTPERMONTH, @PRINCIPLE, @MONTHLY_PAYMENT,  @BALANCE_AMT, @NEXT_MONTH
   
	SET @LOOP_START = @LOOP_START + 1;

	SET @BALANCE_AMT = @BALANCE_AMT - 1000
	SET @INTERESTPERMONTH = (@interestperyear * @BALANCE_AMT)/ 100
	SET @NEXT_MONTH = DATEADD(D, 1, EOMONTH(@NEXT_MONTH))
	SET @MONTHLY_PAYMENT = @INTERESTPERMONTH+@PRINCIPLE

END;


GO


CREATE TABLE S_LOAN
(
SSN INT,
INTEREST_AMT NUMERIC(12,2),
PRINCIPLE_AMT  NUMERIC(12,2),
MONTHLY_AMT  NUMERIC(12,2),
BALANCE_AMT  NUMERIC(12,2),
DUE_DATE DATE
)

SELECT * FROM S_LOAN
				
ssn	    interest	principle	monthlyamount	duedate
1111		700		1000			1700		20190101
1111		600		1000			1600		20190201
1111											20190301
1111											20190401
1111											20190501
1111											20190601
1111											20190701
1111											20190801
1111											20190901
1111											20191001
1111											20191101
1111											20191201

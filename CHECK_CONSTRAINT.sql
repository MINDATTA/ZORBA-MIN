--CHECK CONSTRAIN

create table employee, 
where it have 
1) empid as identity column, 
2) city where you should be able to enter only irving, euless, and arlington. 
3) gender where you should be able to enter m or f, 
4) salary where you should be able to enter 300.00 to 8000.00, 
5) data_of_job_start_date column where you should be able to enter only date which is before todays date.

DROP TABLE OM_ALL_EMPLOYEE

			CREATE TABLE OM_ALL_EMPLOYEE
			(
					EMP_ID INT IDENTITY(1,1) PRIMARY KEY,
					CITY NVARCHAR(30) CONSTRAINT check_city  CHECK (CITY IN ('irving', 'euless', 'arlington')),
					GENDER NVARCHAR(2)   CHECK (GENDER IN ('m', 'f')),
					SALARY DECIMAL CONSTRAINT check_salary  CHECK (SALARY BETWEEN 300 and 8000),
				 	data_of_job_start_date date CONSTRAINT CHECK_DATE CHECK (data_of_job_start_date < GETDATE() -1 )

			)

INSERT INTO OM_ALL_EMPLOYEE VALUES ('irving','M',700, '2019-02-14' )
select * from OM_ALL_EMPLOYEE



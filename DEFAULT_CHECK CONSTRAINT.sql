--CHECK CONSTRAINT

drop table Persons_FOR_CHECK
CREATE TABLE Persons_FOR_CHECK
(
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int, constraint ck_age CHECK (Age>=18),
	city varchar(20)
)

SELECT * FROM Persons_FOR_CHECK

ALTER TABLE Persons_FOR_CHECK
ADD CHECK (Age>19)

insert into Persons_FOR_CHECK  values (1,'smith', 'kathy', 20,'IRVING')
insert into Persons_FOR_CHECK  values (1,'smith', 'kathy', 12)
select * from Persons_FOR_CHECK

DELETE from Persons_FOR_CHECK

ALTER TABLE Persons_FOR_CHECK
ADD CONSTRAINT CHK_PersonAge CHECK (Age>=18 AND City='Sandnes')

insert into Persons_FOR_CHECK  values (1,'smith', 'kathy', 21, 'irving')
insert into Persons_FOR_CHECK  values (1,'smith', 'kathy', 21, 'Sandnes')
insert into Persons_FOR_CHECK  values (1,'smith', 'kathy', 12,'Sandnes')
select * from Persons_FOR_CHECK


ALTER TABLE Persons_FOR_CHECK
DROP CONSTRAINT CHK_PersonAge;

--EXAMPLE 2

ALTER TABLE dbo.Customers
ADD CONSTRAINT CK_Status_Credit_Limit
CHECK (Status = 'VIP' OR Status = 'Regular')

--DEFAULT
drop table Persons
CREATE TABLE Persons 
(
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255) DEFAULT 'Sandnes'
)

insert into Persons  values (1,'smith', 'kathy', 21, 'irving')
insert into Persons  values (1,'smith', 'kathy', 21, 'SandnesSD')
insert into Persons (id,lastname, firstname, age)  values (1,'smith', 'kathy', 12)
insert into Persons (id,lastname, firstname, age, CITY)  values (1,'smith', 'kathy', 12, 'LONDON' )

select * from Persons



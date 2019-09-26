--Method 1

select * from employee

delete from employee where eid = 10

create table #emptemp
(id int)

DECLARE @X INT 
SET @X=1 
WHILE(@X<=100) 
	
	BEGIN  
		INSERT INTO #emptemp VALUES(@X)  
		SET @X=@X+1 
	END 

select * from #emptemp

select * from #emptemp where not exists (select eid from employee where #emptemp.id=employee.eid)

--Method 2
--Suppose there is employee table and in eid col there is deleted some row and findout those deleted rows 

DECLARE @MIN INT, @MAX INT

SELECT @MIN=MIN(EID) FROM employee
SELECT @MAX=MAX(EID) FROM employee

WHILE @MIN <= @MAX

BEGIN 
	IF NOT EXISTS (SELECT * FROM employee WHERE EID = @MIN)
	PRINT @MIN
	SET @MIN = @MIN + 1
END

select * from employee

--Method 3

IF OBJECT_ID('DBO.OM_MISS_IDENTITY','U') IS NOT NULL

DROP TABLE OM_MISS_IDENTITY

CREATE TABLE OM_MISS_IDENTITY
(
EMPID INT IDENTITY(1,1),
NAME VARCHAR(20)
)
INSERT INTO OM_MISS_IDENTITY VALUES('AAA')
INSERT INTO OM_MISS_IDENTITY VALUES('BBB')
INSERT INTO OM_MISS_IDENTITY VALUES('CCC')
INSERT INTO OM_MISS_IDENTITY VALUES('DDD')
INSERT INTO OM_MISS_IDENTITY VALUES('EEE')
INSERT INTO OM_MISS_IDENTITY VALUES('FFF')
INSERT INTO OM_MISS_IDENTITY VALUES('GGG')
INSERT INTO OM_MISS_IDENTITY VALUES('HHH')
INSERT INTO OM_MISS_IDENTITY VALUES('III')
INSERT INTO OM_MISS_IDENTITY VALUES('JJJ')
INSERT INTO OM_MISS_IDENTITY VALUES('KKK')
INSERT INTO OM_MISS_IDENTITY VALUES('LLL')
INSERT INTO OM_MISS_IDENTITY VALUES('MMM')
INSERT INTO OM_MISS_IDENTITY VALUES('NNN')
INSERT INTO OM_MISS_IDENTITY VALUES('OOO')
INSERT INTO OM_MISS_IDENTITY VALUES('PPP')
INSERT INTO OM_MISS_IDENTITY VALUES('QQQ')
INSERT INTO OM_MISS_IDENTITY VALUES('RRR')
INSERT INTO OM_MISS_IDENTITY VALUES('SSS')
INSERT INTO OM_MISS_IDENTITY VALUES('TTT')
INSERT INTO OM_MISS_IDENTITY VALUES('UUU')
INSERT INTO OM_MISS_IDENTITY VALUES('VVV')
INSERT INTO OM_MISS_IDENTITY VALUES('WWW')
INSERT INTO OM_MISS_IDENTITY VALUES('XXX')
INSERT INTO OM_MISS_IDENTITY VALUES('YYY')
INSERT INTO OM_MISS_IDENTITY VALUES('ZZZ')

SELECT *FROM OM_MISS_IDENTITY

DELETE FROM OM_MISS_IDENTITY WHERE EMPID IN(5,10,15,20)

DECLARE @X INT ---LOWER VALUES
DECLARE @Y INT --- HIGHER VALUES

SELECT @X= MIN(EMPID),@Y=MAX(EMPID) FROM OM_MISS_IDENTITY

DECLARE @Z TABLE ( EMP INT)

WHILE @X<=@Y

BEGIN
	IF NOT EXISTS(SELECT *FROM OM_MISS_IDENTITY WHERE EMPID=@X)
	INSERT INTO @Z VALUES(@X)
	SET @X= @X+1
END

SELECT *FROM @Z 

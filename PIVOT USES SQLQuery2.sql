DROP TABLE customers
GO
create table customers ( IID INT IDENTITY(1,1),col0 varchar(90),col1 varchar(90))

GO

-- 1st set

insert into customers values ( 'NAME','A_NM')

insert into customers values ( 'ADDRESS','A_ADR')

insert into customers values ( 'PHONE','A_PH')

insert into customers values ( 'EMAIL','A_EMAIL')

-- 2nd set

insert into customers values ( 'NAME','B_BM')

insert into customers values ( 'ADDRESS','B_ADR')

insert into customers values ( 'PHONE','B_XYZ')

insert into customers values ( 'EMAIL','B_PH')

-- 3rd set

insert into customers values ( 'NAME','C_BM')

insert into customers values ( 'ADDRESS','C_ADR')

insert into customers values ( 'PHONE','C_XYZ')

insert into customers values ( 'EMAIL','C_EMAIL')

SELECT * FROM customers
GO
--------
WITH CUST_CTE(cid, COL0,COL1,RID)

AS

(

SELECT cid, COL0,COL1 , ROW_NUMBER() OVER (PARTITION BY (COL0)ORDER BY cID) AS RID FROM CUSTOMERS

)

SELECT NAME,ADDRESS,PHONE,EMAIL

FROM

(SELECT cid, COL0,COL1

FROM CUST_CTE)C

PIVOT

(

max(COL1)

FOR COL0 IN (NAME,[ADDRESS],PHONE,EMAIL)

) AS PivotTable;




--PIVOT EXAMPLE 2:

drop table #BookSales
go
CREATE TABLE #BookSales
(BookType VARCHAR(20), SalesYear INT, BookSales MONEY);
GO
 
INSERT INTO #BookSales VALUES('Fiction', 2014, 11201);
INSERT INTO #BookSales VALUES('Fiction', 2014, 12939);
INSERT INTO #BookSales VALUES('Fiction', 2013, 10436);
INSERT INTO #BookSales VALUES('Fiction', 2013, 9346);
INSERT INTO #BookSales VALUES('Nonfiction', 2014, 7214);
INSERT INTO #BookSales VALUES('Nonfiction', 2014, 5800);
INSERT INTO #BookSales VALUES('Nonfiction', 2013, 8922);
INSERT INTO #BookSales VALUES('Nonfiction', 2013, 7462);
--INSERT INTO #BookSales VALUES('Nonfiction', 2015, 11111);
 
SELECT DISTINCT SALESYEAR FROM #BookSales;

SELECT * FROM #BookSales;

SELECT *
FROM #BookSales
  PIVOT(SUM(BookSales) 
  FOR SalesYear IN([2013], [2014])
  ) AS PivotSales;



SELECT booktype, salesyear, sum(booksales) FROM #BookSales group by booktype, salesyear;

SELECT * FROM #BookSales;

SELECT booktype, salesyear, sum(booksales) FROM #BookSales group by booktype, salesyear;

--COLUMN NAME CHANGE
SELECT BookType AS BookCategory, 
  [2013] AS Year2013, [2014] AS Year2014
FROM #BookSales
  PIVOT(SUM(BookSales) 
  FOR SalesYear IN([2013], [2014])
  ) AS PivotSales;

--ONLY CERTAIN COLUMN

SELECT * FROM #BookSales;

  SELECT *
FROM #BookSales
  PIVOT(SUM(BookSales) 
  FOR SalesYear IN([2014])
  ) AS PivotSales;



--EXAMPLE 3
DROP TABLE #BookSales
CREATE TABLE #BookSales
(BookType VARCHAR(20), Region VARCHAR(20), 
  SalesYear INT, BookSales MONEY);
GO
 
INSERT INTO #BookSales VALUES('Fiction', 'east', 2014, 11201);
INSERT INTO #BookSales VALUES('Fiction', 'west', 2014, 12939);
INSERT INTO #BookSales VALUES('Fiction', 'west', 2013, 10436);
INSERT INTO #BookSales VALUES('Fiction', 'east', 2013, 9346);
INSERT INTO #BookSales VALUES('Fiction', 'east', 2013, 4356);
INSERT INTO #BookSales VALUES('Nonfiction', 'east', 2014, 7214);
INSERT INTO #BookSales VALUES('Nonfiction', 'west', 2014, 8456);
INSERT INTO #BookSales VALUES('Nonfiction', 'west', 2014, 5800);
INSERT INTO #BookSales VALUES('Nonfiction', 'east', 2013, 8922);
INSERT INTO #BookSales VALUES('Nonfiction', 'west', 2013, 7462);

SELECT * FROM #BookSales



SELECT BookType AS BookCategory,
    (CAST(SalesYear AS VARCHAR(4)) + '_' + Region) AS SalesRegion,
    BookSales
   FROM #BookSales



select * from 
(
SELECT BookType AS BookCategory,
    (CAST(SalesYear AS VARCHAR(4)) + '_' + Region) AS SalesRegion,
    BookSales
   FROM #BookSales) as Sales

   SELECT * FROM #BookSales

SELECT *
FROM 
  (SELECT BookType AS BookCategory,
    (CAST(SalesYear AS VARCHAR(4)) + '_' + Region) AS SalesRegion,
    BookSales
   FROM #BookSales) AS Sales
  PIVOT(SUM(BookSales) 
  FOR SalesRegion 
    IN([2013_east], [2013_west], [2014_east], [2014_west])
  ) AS PivotSales;




--EXAMPLE 4
CREATE TABLE [dbo].[#PivotExample](
       [Country]   [nvarchar](50)   NULL,
       [Year]   [smallint] NOT NULL,
       [SalesAmount]   [money] NULL
)
GO
 
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Australia', 2005, 1309047.1978)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Germany', 2006, 521230.8475)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'United States',   2007, 2838512.3550)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'France', 2008, 922179.0400)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Australia', 2007, 3033784.2131)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'France', 2005, 180571.6920)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'United Kingdom',   2006, 591586.8540)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Canada', 2006, 621602.3823)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'United Kingdom',   2005, 291590.5194)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'United States',   2005, 1100549.4498)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Canada', 2007, 535784.4624)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'France', 2007, 1026324.9692)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Germany', 2007, 1058405.7305)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Australia', 2006, 2154284.8835)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'United Kingdom',   2008, 1210286.2700)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'United States',   2008, 3324031.1600)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Germany', 2008, 1076890.7700)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'United Kingdom',   2007, 1298248.5675)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Australia', 2008, 2563884.2900)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Canada', 2005, 146829.8074)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Germany', 2005, 237784.9902)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'Canada', 2008, 673628.2100)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'United States',   2006, 2126696.5460)
INSERT   [dbo].[#PivotExample]   ([Country],   [Year], [SalesAmount])   VALUES (N'France', 2006, 514942.0131)
GO
 
SELECT * FROM [dbo].[#PivotExample] ORDER   BY Country
GO



SELECT   [Country], [2005],   [2006], [2007],   [2008]
FROM   [dbo].[#PivotExample] 
PIVOT
(
       SUM(SalesAmount)
       FOR [Year] IN ([2005], [2006], [2007], [2008])
) AS P

--just reversed

SELECT   [Year], [Australia],   [Canada], [France],   [Germany], [United Kingdom], [United States]
FROM   [dbo].[#PivotExample] 
PIVOT
(
       SUM(SalesAmount)
       FOR [Country] IN ([Australia], [Canada], [France], [Germany], [United Kingdom], [United States])
) AS pass


IF OBJECT_ID ('BookInventory', 'U') IS NOT NULL
DROP TABLE dbo.BookInventory;
 
 
CREATE TABLE dbo.BookInventory  -- target
(
  TitleID INT NOT NULL PRIMARY KEY,
  Title NVARCHAR(100) NOT NULL,
  Quantity INT NOT NULL
    CONSTRAINT Quantity_Default_1 DEFAULT 0
);
 
IF OBJECT_ID ('BookOrder', 'U') IS NOT NULL
DROP TABLE dbo.BookOrder;
 
CREATE TABLE dbo.BookOrder  -- source
(
  TitleID INT NOT NULL PRIMARY KEY,
  Title NVARCHAR(100) NOT NULL,
  Quantity INT NOT NULL
    CONSTRAINT Quantity_Default_2 DEFAULT 0
);
 
INSERT BookInventory VALUES
  (1, 'The Catcher in the Rye', 6),
  (2, 'Pride and Prejudice', 3),
  (3, 'The Great Gatsby', 0),
  (5, 'Jane Eyre', 0),
  (6, 'Catch 22', 0),
  (8, 'Slaughterhouse Five', 4);
 
INSERT BookOrder VALUES
  (1, 'The Catcher in the Rye', 3),
  (3, 'The Great Gatsby', 0),
  (4, 'Gone with the Wind', 4),
  (5, 'Jane Eyre', 5),
  (7, 'Age of Innocence', 8);


  MERGE BookInventory bi
USING BookOrder bo
ON bi.TitleID = bo.TitleID
WHEN MATCHED THEN
  UPDATE
  SET bi.Quantity = bi.Quantity + bo.Quantity;
 
SELECT * FROM BookInventory;
MERGE BookInventory bi
USING BookOrder bo
ON bi.TitleID = bo.TitleID
WHEN MATCHED AND
  bi.Quantity + bo.Quantity = 0 THEN
  DELETE
WHEN MATCHED THEN
  UPDATE
  SET bi.Quantity = bi.Quantity + bo.Quantity;
 
SELECT * FROM BookInventory;



MERGE BookInventory bi
USING BookOrder bo
ON bi.TitleID = bo.TitleID
WHEN MATCHED AND
  bi.Quantity + bo.Quantity = 0 THEN
  DELETE
WHEN MATCHED THEN
  UPDATE
  SET bi.Quantity = bi.Quantity + bo.Quantity
WHEN NOT MATCHED BY TARGET THEN
  INSERT (TitleID, Title, Quantity)
  VALUES (bo.TitleID, bo.Title,bo.Quantity);
 
SELECT * FROM BookInventory;



MERGE BookInventory bi
USING BookOrder bo
ON bi.TitleID = bo.TitleID
WHEN MATCHED AND
  bi.Quantity + bo.Quantity = 0 THEN
  DELETE
WHEN MATCHED THEN
  UPDATE
  SET bi.Quantity = bi.Quantity + bo.Quantity
WHEN NOT MATCHED BY TARGET THEN
  INSERT (TitleID, Title, Quantity)
  VALUES (bo.TitleID, bo.Title,bo.Quantity)
WHEN NOT MATCHED BY SOURCE
  AND bi.Quantity = 0 THEN
  DELETE;
 
SELECT * FROM BookInventory;


DECLARE @MergeOutput TABLE
(
  ActionType NVARCHAR(10),
  DelTitleID INT,
  InsTitleID INT,
  DelTitle NVARCHAR(50),
  InsTitle NVARCHAR(50),
  DelQuantity INT,
  InsQuantity INT
);
 
MERGE BookInventory bi
USING BookOrder bo
ON bi.TitleID = bo.TitleID
WHEN MATCHED AND
  bi.Quantity + bo.Quantity = 0 THEN
  DELETE
WHEN MATCHED THEN
  UPDATE
  SET bi.Quantity = bi.Quantity + bo.Quantity
WHEN NOT MATCHED BY TARGET THEN
  INSERT (TitleID, Title, Quantity)
  VALUES (bo.TitleID, bo.Title,bo.Quantity)
WHEN NOT MATCHED BY SOURCE
  AND bi.Quantity = 0 THEN
  DELETE
OUTPUT
    $action,
    DELETED.TitleID,
    INSERTED.TitleID,
    DELETED.Title,
    INSERTED.Title,
    DELETED.Quantity,
    INSERTED.Quantity
  INTO @MergeOutput;
 
SELECT * FROM BookInventory;
 
SELECT * FROM @MergeOutput;




DROP TABLE R_OM_STOCK1
CREATE TABLE R_OM_STOCK1
(
ITEMID VARCHAR(10), 
ITEM_NAME VARCHAR(45),
PRICE FLOAT ,
QTY INT ,
SOLD_DATE DATETIME
)
INSERT INTO R_OM_STOCK1 VALUES
('IKP36','BAG',25.55,45, GETDATE()),
('IKM40','PEN',15.10,50,GETDATE()),
('IKP33','SHOES',55.66,65,GETDATE())

INSERT INTO R_OM_STOCK1 VALUES
('IK536','BAG',25.55,45, GETDATE())


SELECT * FROM R_OM_STOCK1 

DROP TABLE R_OM_SALE1  
CREATE TABLE R_OM_SALE1
(
ITEMID VARCHAR(10) ,
QTY INT,
SOLD_DATE DATETIME
)
INSERT INTO R_OM_SALE1 VALUES
('IKP36',5, GETDATE()),
('IKM40',3,GETDATE()),
('IKP33',6,GETDATE())

INSERT INTO R_OM_SALE1 VALUES
('IKK36',5, GETDATE())

DROP TABLE S_OM_STOCK1
CREATE TABLE S_OM_STOCK1
(
ITEMID VARCHAR(10), 
ITEM_NAME VARCHAR(45),
PRICE FLOAT ,
QTY INT ,
SOLD_DATE DATETIME
)

DROP TABLE S_OM_SALE1
CREATE TABLE S_OM_SALE1
(
ITEMID VARCHAR(10) ,
QTY INT,
SOLD_DATE DATETIME
)


INSERT INTO S_OM_SALE1(ITEMID,QTY,SOLD_DATE) 
SELECT CASE
WHEN ((LEN(ITEMID)=5 AND ITEMID LIKE 'I%' AND(ITEMID LIKE '__P%' OR ITEMID LIKE'__M%'))) THEN ITEMID 
ELSE NULL
END  AS ITEMID, QTY,SOLD_DATE
FROM R_OM_SALE1 


INSERT INTO S_OM_STOCK1(ITEMID, ITEM_NAME, PRICE, QTY, SOLD_DATE) 
SELECT CASE
WHEN ((LEN(ITEMID)=5 AND ITEMID LIKE 'I%' AND(ITEMID LIKE '__P%' OR ITEMID LIKE'__M%'))) THEN ITEMID 
ELSE NULL
END  AS ITEMID, ITEM_NAME,PRICE,QTY,SOLD_DATE
FROM R_OM_STOCK1 


SELECT * FROM R_OM_STOCK1
SELECT * FROM R_OM_SALE1

SELECT * FROM S_OM_STOCK1
SELECT * FROM S_OM_SALE1


DROP TABLE R_OM_NEED_TO_BE_ORDER
CREATE TABLE R_OM_NEED_TO_BE_ORDER
(
ITEMID VARCHAR(10) ,
UPDATE_DATE DATETIME
)

INSERT INTO R_OM_NEED_TO_BE_ORDER VALUES
('IKP36',GETDATE()),
('IKM40',GETDATE()),
('IKP33',GETDATE())

SELECT * FROM R_OM_STOCK1
SELECT * FROM R_OM_SALE1
SELECT * FROM R_OM_NEED_TO_BE_ORDER

ITEMID VARCHAR(10) CHECK (LEN(ITEMID)=5 AND ITEMID LIKE 'I%' AND(ITEMID LIKE '__P%' OR ITEMID LIKE'__M%')) PRIMARY KEY,
ITEM_NAME VARCHAR(45),
PRICE FLOAT CHECK(PRICE>0),
QTY INT CHECK(QTY>0),
SOLD_DATE DATETIME
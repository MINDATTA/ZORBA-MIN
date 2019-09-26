Create table: OM_ITEM_DETAIL
ITEMID: item value MUST start with “I” and MUST have value length less than 5 char
ITEMNAME:
DISPLAYPRICE: must not be negative
DISCOUNT_PERCENT: must not be negative
FINAL_PRICE:
SOLD_DATE:
 
Create store procedure, in which pass input parameter itemid, itemname, displayprice, discount_percent. 
When you execute store procedure pass 4 parameter, itemid, itemname, displayprice, discount_percent. 
Then it should insert in above table OM_ITEM_DETAIL. Do calculate correct value to insert in FINAL_PRICE and insert today’s date in Sold_date
Try to solve this problem, and email your code in .sql

DROP TABLE OM_ITEM_DETAIL
CREATE TABLE OM_ITEM_DETAIL
(
ITEMID VARCHAR(10) constraint chk_item CHECK  (LEN(ITEMID)<5 AND ITEMID LIKE 'I%' ),
ITEMNAME VARCHAR (30),
DISPLAYPRICE INT CHECK(DISPLAYPRICE>0),
DISCOUNT_PERCENT INT CHECK(DISCOUNT_PERCENT>0),
FINAL_PRICE FLOAT,
SOLD_DATE DATETIME
)
SELECT * FROM OM_ITEM_DETAIL

DROP PROCEDURE SP_OM_ITEM_DETAIL
CREATE PROCEDURE SP_OM_ITEM_DETAIL
(
@ITEMID VARCHAR(10),
@ITEMNAME VARCHAR(20),
@DISPLAYPRICE FLOAT,
@DISCOUNT_PERCENT INT
)
AS 
BEGIN
	DECLARE @FINAL_PRICE FLOAT
	SET @FINAL_PRICE= @DISPLAYPRICE-(@DISPLAYPRICE * @DISCOUNT_PERCENT)/100 
	INSERT INTO OM_ITEM_DETAIL VALUES(@ITEMID,@ITEMNAME,@DISPLAYPRICE,@DISCOUNT_PERCENT,@FINAL_PRICE,GETDATE())
END

EXEC SP_OM_ITEM_DETAIL I45,'RAM',124,5





SELECT * FROM OM_ITEM_DETAIL


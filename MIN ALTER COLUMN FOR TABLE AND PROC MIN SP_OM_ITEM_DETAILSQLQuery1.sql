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

ALTER TABLE OM_ITEM_DETAIL ADD DISCOUNT_AMT INT

DROP PROCEDURE SP_OM_ITEM_DETAIL

ALTER PROCEDURE SP_OM_ITEM_DETAIL 
(
@ITEMID VARCHAR(10),
@ITEMNAME VARCHAR(20),
@DISPLAYPRICE FLOAT,
@DISCOUNT_PERCENT INT
)
AS 
BEGIN
	DECLARE @DISCOUNT_AMT INT
	SET @DISCOUNT_AMT= (@DISPLAYPRICE * @DISCOUNT_PERCENT)/100 
	DECLARE @FINAL_PRICE FLOAT
	SET @FINAL_PRICE= @DISPLAYPRICE-(@DISPLAYPRICE * @DISCOUNT_PERCENT)/100 
	INSERT INTO OM_ITEM_DETAIL VALUES(@ITEMID,@ITEMNAME,@DISPLAYPRICE,@DISCOUNT_PERCENT,@FINAL_PRICE,GETDATE(),@DISCOUNT_AMT)
END

EXEC SP_OM_ITEM_DETAIL I45,'RAM',124,5

SELECT * FROM OM_ITEM_DETAIL


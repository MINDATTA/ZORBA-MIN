DROP TABLE OM_SALES_PRICE
CREATE TABLE OM_SALES_PRICE
(
ORIGINAL_COST INT,
DISCOUNT INT,
)

INSERT INTO OM_SALES_PRICE VALUES
(100,7),(99,10),(140,25),(45,60)

SELECT * FROM OM_SALES_PRICE

SELECT ORIGINAL_COST * DISCOUNT/100 AS DISCOUNT_AMOUNT FROM OM_SALES_PRICE

SELECT ORIGINAL_COST-(ORIGINAL_COST * DISCOUNT/100) AS SALES_PRICE_AFTER_DISCOUNT FROM OM_SALES_PRICE


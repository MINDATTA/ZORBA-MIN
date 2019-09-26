DROP TABLE OM_FIND_EVEN_OR_ODD
CREATE TABLE OM_FIND_EVEN_OR_ODD 		
(
EVEN_OR_ODD INT
)	

INSERT INTO OM_FIND_EVEN_OR_ODD VALUES
(45),(67),(345),(45),(345),(44),(66),(80),(9092),(31),(4236)

SELECT * FROM OM_FIND_EVEN_OR_ODD

SELECT CASE WHEN EVEN_OR_ODD % 2 = 1 THEN EVEN_OR_ODD END AS ODD, 
CASE WHEN EVEN_OR_ODD % 2 = 0 THEN EVEN_OR_ODD END AS EVEN 
FROM OM_FIND_EVEN_OR_ODD

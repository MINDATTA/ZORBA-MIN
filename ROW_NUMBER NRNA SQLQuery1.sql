DROP TABLE OM_NRNA	
	
CREATE TABLE OM_NRNA	
(	
SN INT IDENTITY(1,1) PRIMARY KEY,	
STATE VARCHAR(30),	
GENERAL_MEMBER INT,	
LIFE_MEMBER INT,	
TOTAL INT�	
)	
INSERT INTO OM_NRNA VALUES	
('TEXAS',601,63,664),	
('NEW YORK',587,51,638),	
('MARYLAND',263,14,277),	
('CALIFORNIA',166,62,228),	
('COLORADO',118,17,135),	
('ILLINIOS',118,17,135),	
('VIRGINIA',74,44,118),	
('MASSACHUSETTS',85,23,108),	
('WISCONSIN',70,10,664),	
('NEW MAXICO',73,3,75),	
('OTHERS',480,127,607)	
	
	
SELECT *FROM OM_NRNA	
	
SELECT *, ROW_NUMBER() OVER (ORDER BY GENERAL_MEMBER) AS SN FROM OM_NRNA	


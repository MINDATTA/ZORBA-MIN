DROP TABLE OM_CODE

CREATE TABLE OM_CODE
(
CODE VARCHAR (20)
)	

INSERT INTO OM_CODE VALUES
('RA45T56'),
('KJkKO9j'),
('DFG345'),
('UIJ7hjuuY7'),
('45GGFDG'),
('DSF34G'),
('jk87JGU')

SELECT * FROM OM_CODE 

SELECT SUBSTRING(CODE, LEN(CODE)-3, 3) FROM OM_CODE

--OR WE CAN GET IT INDIVIDUALLY 

SELECT SUBSTRING ('RA45T56',4,3) 
SELECT SUBSTRING ('KJkKO9j',4,3)
SELECT SUBSTRING ('DFG345',3,3)
SELECT SUBSTRING ('UIJ7hjuuY7',7,3)
SELECT SUBSTRING ('45GGFDG',4,3)
SELECT SUBSTRING ('DSF34G',3,3)
SELECT SUBSTRING ('jk87JGU',4,3)


SELECT SUBSTRING(CODE, LEN(CODE)-3, 3) FROM OM_CODE
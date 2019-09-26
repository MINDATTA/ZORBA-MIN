
DROP TABLE OM_STUDENT	
CREATE TABLE OM_STUDENT	
(
SID VARCHAR(20),
SNAME VARCHAR(25),
GENDER VARCHAR(15),
CITY VARCHAR(25),
DOB DATE,
CID VARCHAR(20), 
SCORE INT
)

INSERT INTO OM_STUDENT VALUES
('S01','RAM THAPA','M','IRVING','1/23/1982','MATH1314',79),
('S02','SUMAN KARKI','M','EULESS','10/12/1970','MATH2305',99),
('S03','SUBASH KARKI','M','ARLINGTON','6/25/1985','POFT1301',45),
('S04','ANJILA SHRESTHA','F','IRVING','1/26/1988','ARTS1301',78),
('S05','JOYA SHARMA','F','IRVING','5/8/1962','MATH1314',89),
('S06','BABA SHARMA','F','IRVING','1/28/1982','MATH2305',90),
('S07','YUNISH RAI','M','ARLINGTON','2/21/1975','POFT1301',95),
('S08','BOBBY MAHARAJAN','F','ARLINGTON','2/22/1976','ARTS1301',34),
('S09','KAMAL THAPA','M','EULESS','12/23/1977','PHYS1401',67),
('S10','RUSS KARKI','M','EULESS','4/9/1981','BIOL1322',66),
('S11','BINAYA BASNET','M','ARLINGTON','12/10/1981','MATH1314',89),
('S12','SUJAN SHRESTHA','M','EULESS','4/11/1972','MATH2305',92),
('S13','KRISHNA SHRESTHA','M','IRVING','7/23/1984','POFT1301',56),
('S14','ANISH SHARMA','M','IRVING','3/5/1982','ARTS1301',	67),
('S15','ASHISH MAHARAJAN','M','IRVING','11/6/1982','PHYS1401',70),
('S16','PRIYANKA KARKI','F','EULESS','2/7/1980','MATH1314',45),
('S17','ANGEL SHAH','F','EULESS','9/8/1980','MATH2305',84),
('S18','ERIKA SHAH','F','EULESS','7/21/1982','POFT1301',78),
('S19','SUMEET SHAH','M','ARLINGTON','7/22/1969','ARTS1301',44),
('S20','RABI MAHARAJAN','M','EULESS','7/23/1979','PHYS1401',63),
('S21','SHRISTI MAHARAJAN','F','ARLINGTON','5/24/1970','BIOL1322',12),
('S22','DILIP MAHARAJAN','M','EULESS','7/25/1975','HIST1301',90),
('S23','BINA SHAH','F','ARLINGTON','2/14/1976','GOVT2304',78),
('S24','REEMA RAI','F','EULESS','8/15/1971','MATH1314',45),
('S25','VIJAYA RAI','M','IRVING','6/25/1985','MATH2305',78),
('S26','AMBIKA PUN','F','EULESS','1/26/1988','POFT1301',93),
('S27','BHUBAN RAI','M','IRVING','5/8/1962','ARTS1301',55),
('S28','SANGITA SHRESTHA','F','IRVING','1/28/1982','PHYS1401',62),
('S29','TONY SMITH','M','IRVING','2/21/1975','BIOL1322',34),
('S30','JEENA PUN','F','IRVING','2/22/1976','HIST1301',77)
						
SELECT * FROM OM_STUDENT




DROP TABLE OM_TEACHER
CREATE TABLE OM_TEACHER	
(
TID VARCHAR(20),
TNAME VARCHAR(20),
JOB_START_DT DATE,
COURSE_START_DT DATE,
CID VARCHAR(20)
)			

INSERT INTO OM_TEACHER VALUES
('T01','REEMA RAI','12/10/1981','5/15/2018','MATH1314'),
('T02','WINSON RANA','4/11/1972','5/16/2018','MATH2305'),
('T03','SABIN GAUTAM','7/23/1984','5/20/2018','POFT1301'),
('T04','KAMAL SATYAL','3/5/1982','5/24/2018','ARTS1301'),
('T05','RABINDRA NATH TEGOR','11/6/1982','5/28/2018','PHYS1401'),
('T06','JACKY CHANG','2/7/1980','6/1/2018','BIOL1322'),
('T07','PETER GURUNG','9/8/1980','6/5/2018','HIST1301'),
('T08','TIKA GURUNG','7/21/1982','6/9/2018','GOVT2304'),
('T09','DILIP SHRESTHA','4/11/1972','5/15/2018','MATH1314'),
('T10','BISHNU PARAJULI','7/23/1984','5/16/2018','MATH2305'),
('T11','KRIPASH SHRESTHA','3/5/1982','5/20/2018','POFT1301'),
('T12','SURESH SHRESTHA','11/6/1982','5/24/2018','ARTS1301'),
('T13','ASHOK GAUTAM','2/7/1980','5/28/2018','PHYS1401'),
('T14','SRIJANA SHRESTHA','8/15/1971','6/1/2018','BIOL1322'),
('T15','ANJULA GURUNG','6/25/1985','6/5/2018','HIST1301'),
('T16','SANJEEV RAI','7/25/1975','6/9/2018','GOVT2304')

SELECT * FROM OM_TEACHER


DROP TABLE OM_COURSE
CREATE TABLE OM_COURSE
(
CID VARCHAR(20),
CNAME VARCHAR(45),
FEE MONEY,
DURATION_MONTH INT
)

INSERT INTO OM_COURSE VALUES
('MATH1314','COLLEGE ALGEBRA','1356.3',5),
('MATH2305','DISCRETE MATHEMATICS','2345.56',6),
('POFT1301','BUSINESS ENGLISH','450.4',4),
('ARTS1301','ART APPRECIATION','670',5),
('PHYS1401','COLLEGE PHYSICS I','800.12',5),
('BIOL1322','NUTRITION AND DIET THERAPHY','4500.6',8),
('HIST1301','UNITED STATES HISTORY I','23.45',1),
('GOVT2304','INTRODUCTION TO POLITICAL SCIENCE','456.9',2)
			
SELECT * FROM OM_COURSE


1
WRITE QUERY TO DISPLAY ALL THE COLUMN FROM STUDENT TABLE WITH NEW COLUMN DISCOUNT. 							
UNDER DISCOUNT DISPLAY "10% DISCOUNT" IF STUDENT LEAVE IN CITY IRVING OR EULESS BUT MUST BE FEMALE. ELSE DISPLAY "NO DISCOUNT"	




SELECT *, CASE 
	WHEN (CITY = 'IRVING' OR CITY = 'EULESS') AND GENDER = 'F'  THEN '10% DISCOUNT'
	ELSE 'NO DISCOUNT'
	END AS DISCOUNT
FROM OM_STUDENT ORDER BY DISCOUNT

2)	
WRITE QUERY TO DISPLAY ALL THE COLUMN FROM STUDENT TABLE WITH NEW COLUMN DISCOUNT. UNDER DISCOUNT  					
DISPLAY "15% DISCOUNT" IF STUDENT IS MALE AND SCORE BETWEEN 0 TO 80,  							
DISPLAY "20% DISCOUNT" IF STUDENT IS MALE AND SCORE BETWEEN 81 TO 100							
DISPLAY "18% DISCOUNT" IF STUDENT IS FEMALE AND SCORE BETWEEN 0 TO 70							
DISPLAY "25% DISCOUNT" IF STUDENT IS FEMALE AND SCORE BETWEEN 71 TO 100	
						
SELECT *, CASE 
    WHEN GENDER = 'M' AND (SCORE BETWEEN 0 AND 80) THEN '15% DISCOUNT'
    WHEN GENDER = 'M' AND (SCORE BETWEEN 81 AND 100) THEN '20% DISCOUNT'
	WHEN GENDER = 'F' AND (SCORE BETWEEN 0 AND 70) THEN '18% DISCOUNT'
    WHEN GENDER = 'F' AND (SCORE BETWEEN 71 AND 100) THEN '25% DISCOUNT'
	ELSE 'NO DISCOUNT'
	END AS DISCOUNT
FROM OM_STUDENT ORDER BY DISCOUNT

SELECT * FROM OM_STUDENT 


3)	WRITE QUERY TO DISPLAY ALL THE COLUMN FROM STUDENT TABLE WITH NEW COLUMN DISCOUNT. UNDER DISCOUNT  	
DISPLAY "16% DISCOUNT" IF STUDENT IS MALE AND LEAVE IN IRVING AND SCORE GREATER THAN 90  					
DISPLAY "18% DISCOUNT" IF STUDENT IS FEMALE AND LEAVE IN EULESS AND SCORE GREATER THAN 90  					
IF ANY OF CONDITION IS NOT MATCH ABOVE CONITION, DISPLAY "NO DISCOUNT"							


SELECT *, CASE 
    WHEN (GENDER = 'M' OR CITY='IRVING') AND SCORE > 90 THEN '16% DISCOUNT'
	WHEN (GENDER = 'F' OR CITY='EULESS') AND SCORE > 90 THEN '18% DISCOUNT'
	ELSE 'NO DISCOUNT'
	END AS DISCOUNT
FROM OM_STUDENT ORDER BY DISCOUNT


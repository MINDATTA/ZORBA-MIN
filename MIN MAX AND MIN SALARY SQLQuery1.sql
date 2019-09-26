DROP TABLE Omsir_class_practice.EMPLOYEE_DPT 

create table Omsir_class_practice.EMPLOYEE_DPT
(
EMPNAME VARCHAR(45),
DEPARTMENT VARCHAR(45),
SALARY DECIMAL
)

INSERT INTO Omsir_class_practice.EMPLOYEE_DPT VALUES
('tom','sales',1000.56),
('harry','account',2300.67),
('raju','marketing',5670.89),
('tom1','sales',1300.54),
('harry1','account',7450.00),
('raju1','marketing',2170.00),
('tom2','sales',4508.34),
('harry2','account',2300.67),
('raju2','marketing',6770.89),
('tom3','sales',89000.34),
('tom3','sales',2070.21),
('harry3','account',3400.50),
('raju4','marketing',9070.80),
('raju5','marketing',3070.99),
('raju6','marketing',3470)
SELECT * FROM Omsir_class_practice.EMPLOYEE_DPT

SELECT MAX(SALARY) AS HIGHEST_SALARY, DEPARTMENT, MIN(SALARY) AS LOWEST_SALARY, DEPARTMENT 
FROM Omsir_class_practice.EMPLOYEE_DPT GROUP BY DEPARTMENT

--OR WITH EMPNAME

SELECT * FROM Omsir_class_practice.EMPLOYEE_DPT 
WHERE SALARY IN(SELECT MIN(SALARY)  FROM Omsir_class_practice.EMPLOYEE_DPT GROUP BY DEPARTMENT 
UNION ALL SELECT MAX(SALARY) FROM Omsir_class_practice.EMPLOYEE_DPT GROUP BY DEPARTMENT)
ORDER BY DEPARTMENT DESC








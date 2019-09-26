SELECT DISTINCT ID, STUFF((SELECT ','+I.NAME FROM om_table I WHERE I.ID=om_table.ID FOR XML PATH ('')),1,1,'') FROM om_table


create table om_table 
( 
id int,
name varchar (10)
)

insert into om_table values 
(1,'A'),
(1,'B'),
(1,'C'),
(2,'D'),
(2,'E'),
(3,'F'),
(4,'G')

SELECT * FROM om_table

--Method 1

SELECT ID,  
Name=STUFF  
(  
     (  
       SELECT DISTINCT ', ' + CAST(name AS VARCHAR(MAX))  
       FROM om_table t2   
       WHERE t2.ID = t1.ID   
       FOR XML PATH('')  
     ),1,1,''  
)  
FROM om_table t1  
GROUP BY ID  

--Method 2
SELECT DISTINCT ID, STUFF((SELECT ','+I.NAME FROM om_table I WHERE I.ID=om_table.ID FOR XML PATH ('')),1,1,'') FROM om_table



1.	 DECLARE @TStudent TABLE  
2.	 (  
3.	    RollNo INT IDENTITY(1,1),  
4.	    StudentID INT,  
5.	    Name INT  
6.	 )   
7.	 --Insert data to Table variable @TStudent   
8.	 INSERT INTO @TStudent(StudentID,Name)  
9.	 SELECT DISTINCT StudentID, Name FROM StudentMaster ORDER BY StudentID ASC   
10.	   
11.	 --Select data from Table variable @TStudent  
12.	 SELECT * FROM @TStudent  

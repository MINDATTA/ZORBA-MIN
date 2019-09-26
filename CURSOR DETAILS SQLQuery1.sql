--CURSOR
it process one row at a time.


SELECT TOP 10 * FROM T_MEMBER

Step 1: Declare variables to hold the output from the cursor.

DECLARE @BusinessEntityID as INT;
DECLARE @BusinessName as NVARCHAR(50);

Step 2: Declare the cursor object;
DECLARE @BusinessCursor as CURSOR;

Step 3: Assign the query to the cursor.

SET @BusinessCursor = CURSOR FOR
SELECT BusinessEntityID, Name
 FROM Sales.Store;

Step 4: Open the cursor.

OPEN @BusinessCursor;
Step 5: Fetch the first row.

1
FETCH NEXT FROM @BusinessCursor INTO @BusinessEntityID, @BusinessName;

Step 6: Loop until there are no more results.  In the loop print out the ID and the name from the result set and fetch the net row.
close cursor
deallocte cursor
-------------------------------------

DECLARE @MEMBER_GID as INT;
DECLARE @MEMBER_FIRST_NM as NVARCHAR(50);
 
DECLARE @BusinessCursor as CURSOR;
 
SET @BusinessCursor = CURSOR FOR
SELECT MEMBER_GID, MEMBER_FIRST_NM
 FROM T_MEMBER WHERE MEMBER_FIRST_NM IS NOT NULL AND MEMBER_FIRST_NM != ''; 
 
OPEN @BusinessCursor;
FETCH NEXT FROM @BusinessCursor INTO @MEMBER_GID, @MEMBER_FIRST_NM;    -- instead of next you can use last/ absolute 5
 
WHILE @@FETCH_STATUS = 0
BEGIN
 PRINT cast(@MEMBER_GID as VARCHAR (50)) + ' ' + @MEMBER_FIRST_NM;
 FETCH NEXT FROM @BusinessCursor INTO @MEMBER_GID, @MEMBER_FIRST_NM;   -- when you last, instead of next you can do prior so that it display from last to first
END
 
CLOSE @BusinessCursor;
DEALLOCATE @BusinessCursor;





-- more detail ABOUT CURSOR:
https://www.youtube.com/watch?v=RHRjLd0bEaQ

https://www.youtube.com/watch?v=INw_KGjyfDw



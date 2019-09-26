

Indexes are special lookup tables that the database search engine can use to speed up data retrieval. Simply put, an index is a pointer to data in a table. An index in a database is very similar to an index at the end of a book.

For example, if you want to reference all the pages in a book that discuss a certain topic, you first refer to the index, which lists all topics alphabetically and are then referred to one or more specific page numbers.

An index helps speed up SELECT queries and WHERE clauses, but it slows down data input, with UPDATE and INSERT statements. Indexes can be created or dropped with no effect on the data.

Creating an index involves the CREATE INDEX statement, which allows you to name the index, to specify the table and which column or columns to index, and to indicate whether the index is in ascending or descending order.

Indexes can also be unique, similar to the UNIQUE constraint, in that the index prevents duplicate entries in the column or combination of columns on which there's an index. '

CREATE INDEX Command
Following is the basic syntax of CREATE INDEX.

Syntax
CREATE INDEX index_name ON table_name
Single-Column Indexes
A single-column index is one that is created based on only one table column. Following is the basic syntax.

Syntax
CREATE INDEX index_name 
ON table_name (column_name)
Example -- default is non-cluster index
CREATE INDEX singlecolumnindex 
ON customers (ID)

--SAME AS ABOVE
CREATE NONCLUSTERED  INDEX singlecolumnindex 
ON employee_om (empname)

--CLUSTER INDEX
CREATE CLUSTERED INDEX singlecolumnindex 
ON employee_om (empname)

Unique Indexes:
Unique indexes are used not only for performance, but also for data integrity. 
A unique index does not allow any duplicate values to be inserted into the table. Following is the basic syntax.

Syntax
CREATE UNIQUE INDEX index_name 
on table_name (column_name)
Example
CREATE UNIQUE INDEX uniqueindex 
on customers (NAME)

Composite Indexes:
A composite index is an index on two or more columns of a table. Following is the basic syntax.
you can include up to 16 columns in an index. Both clustered and nonclustered indexes can be composite indexes.

Syntax
CREATE INDEX index_name on table_name (column1, column2) 
Example
CREATE INDEX compositeindex 
on customers (NAME, ID)
Whether to create a single-column index or a composite index, take into consideration the column(s) that you may 
use very frequently in a querys WHERE clause as filter conditions.

Should there be only one column used, a single-column index should be the choice. Should there be 
two or more columns that are frequently used in the WHERE clause as filters, the composite index would be the best choice.

Implicit Indexes
Implicit indexes are indexes that are automatically created by the database server when an object is created. 
Indexes are automatically created for primary key constraints and unique constraints.

--unique key will automatically implement unique index
drop table employee
create table employee
(
empid int unique,
empname varchar(20)
)

select * from employee -- check propery of table

insert into employee values (1, 'ram') select * from employee
insert into employee values (2, 'ram') select * from employee
insert into employee values (1, null) select * from employee
insert into employee values (1, 'ram') select * from employee


CREATE NONCLUSTERED INDEX NC_EmpDep 
  ON Employee(EmployeeID, DepartmentID)
  INCLUDE (Lastname)


DROP INDEX Command
An index can be dropped using MS SQL SERVER DROP command. Care should be taken when dropping an index because performance may be slowed or improved.

Syntax
Following is the basic syntax.

DROP INDEX tablename.index_name


--When to Avoid Indexes?
Although indexes are intended to enhance the performance of databases, there are times when they should be avoided. 
The following guidelines indicate when the use of an index should be reconsidered −

Indexes should not be used on small tables.

Indexes should not be used on columns that contain a high number of NULL values.

Tables that have frequent, large batch update or insert operations should not be indexed.

Columns that are frequently manipulated(insert, update, delete) should not be indexed.


--**to see index used in that table
SP_HELPINDEX tablename



--**The following query can be used to query all the tables, columns and indexes on the current database:


SELECT OBJECT_SCHEMA_NAME(BaseT.[object_id],DB_ID()) AS [Schema],  
  BaseT.[name] AS [table_name], I.[name] AS [index_name], AC.[name] AS [column_name],  
  I.[type_desc]
FROM sys.[tables] AS BaseT  
  INNER JOIN sys.[indexes] I ON BaseT.[object_id] = I.[object_id]  
  INNER JOIN sys.[index_columns] IC ON I.[object_id] = IC.[object_id] 
  INNER JOIN sys.[all_columns] AC ON BaseT.[object_id] = AC.[object_id] AND IC.[column_id] = AC.[column_id] 
WHERE BaseT.[is_ms_shipped] = 0 AND I.[type_desc] <> 'HEAP' 
ORDER BY BaseT.[name], I.[index_id], IC.[key_ordinal]




--The following query can be used to find the index fragmentation on all the tables in the current database:

SELECT object_name(IPS.object_id) AS [TableName], 
   SI.name AS [IndexName], 
   IPS.Index_type_desc, 
   IPS.avg_fragmentation_in_percent, 
   IPS.avg_fragment_size_in_pages, 
   IPS.avg_page_space_used_in_percent, 
   IPS.record_count, 
   IPS.ghost_record_count,
   IPS.fragment_count, 
   IPS.avg_fragment_size_in_pages
FROM sys.dm_db_index_physical_stats(db_id(DB_NAME()), NULL, NULL, NULL , 'DETAILED') IPS
   JOIN sys.tables ST WITH (nolock) ON IPS.object_id = ST.object_id
   JOIN sys.indexes SI WITH (nolock) ON IPS.object_id = SI.object_id AND IPS.index_id = SI.index_id
WHERE ST.is_ms_shipped = 0
order by IPS.avg_fragment_size_in_pages desc
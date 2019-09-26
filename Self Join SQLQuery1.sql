--by using self join display grand fathers name

truncate table Son_Father_table
create table Son_Father_table
(
name varchar(15),
fathers_name varchar(25)
)
insert into Son_Father_table values 
('Susheel Singh','I.B.Singh'),
('I.B.Singh','R.B.Singh'),
('Rudra Singh','Anil Singh'),
('Anil Singh','R.J.Singh'),
('R.J.Singh','R.L.Singh'),
('R.B.Singh','R.L.Singh')

select * from Son_Father_table

select s.name, so.fathers_name as grand_father from Son_Father_table s left join Son_Father_table so on s.fathers_name = so.name
--or
select s.name, isnull(so.fathers_name,'no data') as grand_father from Son_Father_table s left join Son_Father_table so on s.fathers_name = so.name

--use of case

ENAME	GENDER
SREEKANTH	M
KISHORE	M
SINDHU	F
MANASA	F
SURI	M

UPDATE EMP_GENDER SET Gender = CASE Gender WHEN 'F' THEN 'M' ELSE 'F' end

select * from EMP_GENDER






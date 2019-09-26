DROP TABLE OM_COUNTRIES
CREATE TABLE OM_COUNTRIES
(
COUNTRIES VARCHAR (25)
)
INSERT INTO OM_COUNTRIES VALUES
('Argentina'),
('Belgium'),
('Brazil'),
('Canada'),
('Denmark'),
('Finland'),
('France'),
('Nepal'),
('India'),
('China')
			
SELECT * FROM OM_COUNTRIES

DROP FUNCTION whichContinent

CREATE FUNCTION DBO.UDFwhichContinent 
(@Country nvarchar(15))
RETURNS varchar(30)
AS
BEGIN
declare @Return varchar(30)
select @return = case @Country
when 'Argentina' then 'South America'
when 'Belgium' then 'Europe'
when 'Brazil' then 'South America'
when 'Canada' then 'North America'
when 'Denmark' then 'Europe'
when 'India' then 'Asia'
when 'Nepal' then 'Asia'
else 'Unknown'
end

return @return
end

SELECT COUNTRIES, DBO.UDFwhichContinent(COUNTRIES) AS CONTINENT
FROM OM_COUNTRIES



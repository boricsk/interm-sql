/*
Irjunk lekérdezést, ami ha a @osszesOrszag valtozó értéke 1 kilistázza az összes országot.
Ha 0 csak azokat az országokat listázza ki ahol volt vásárlás
Jelenítsük meg a vásárlások számát is

*/

declare @osszesOrszag BIT = 0
declare @SQL NVARCHAR(max)

set @SQL ='
select c.Country, count(o.OrderID) as Orders
from Customer as c
' +case when @osszesOrszag = 1 then 'left' else 'inner' end +' join Orders as o on o.CustomerID = c.CustomerID
GROUP BY c.Country
ORDER BY c.Country'

print @SQL
EXECUTE(@SQL)
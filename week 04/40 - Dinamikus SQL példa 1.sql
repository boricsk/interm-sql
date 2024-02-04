/*
Irjunk egy olyan lekérdezést, amely egy változóban (@Year) megadott évből kérdezi le
a vásárlók és vásárlások adatait.
A lekérdezés keresse meg az adott év összes eladásait, vásárlóit és jelenítse meg
pivotban.
A pivot paraméterei:
Sor fejrész - vásárló országa, növekvő
Oszlop fejrész - termék színe, balról jobbra növekvő
Összeg
Összesített adat : Line total

Ha nincs a megadott évre adat akkor üzenet.
*/

declare @Year int = 2013
declare @BaseSQL NVARCHAR(max)
declare @distinctColors NVARCHAR(max)
declare @colors NVARCHAR(max)
declare @colorTable table(columName nvarchar(255))
--alaplekérdezés
SET @BaseSQL = '
select 
    c.Country,
    p.Color,
    od.LineTotal
from Customer as c
inner join Orders as o on c.CustomerID = o.CustomerID
inner join OrderDetail as od on o.OrderID = od.OrderID
inner join Product as p on p.ProductID = od.ProductID
WHERE year(o.OrderDate) = '+ cast(@Year as nvarchar(5)) + ' and c.Country is not NULL and p.Color is not NULL'

--A szinek distinct értékei
SET @DistinctColors = 'SELECT Distinct Color FROM ('+@BaseSQL+') as s'

/*
SET @SQL = '
    select *
    from Customer as c
    inner join Orders as o on c.CustomerID = o.CustomerID
    WHERE year(o.OrderDate) = ' + cast(@Year as nvarchar(5)) 
*/
--PRINT @SQL
INSERT into @colorTable(columName)
EXEC(@DistinctColors)

--select * from @colorTable

--A @Colors alapból NULL ezért kell összefűzéskor az isnull, ami ''-re cseréli az első vesszőt.
select @colors = isnull(@colors + ',','') + columName from @colorTable ORDER BY columName

--PRINT @colors

set @BaseSQL = '
SELECT Country, '+ @colors +'
FROM (
    '+@BaseSQL+'
) as s
PIVOT (SUM(LineTotal) FOR Color in ('+ @colors+')) as piv
ORDER BY Country
'

PRINT @BaseSQL

EXEC(@BaseSQL)
/*
Irjunk egy scriptet aminek van egy bemeneti változója @CustomerName NVARCHAR(100)
amelybe átadjuk a vásárló nevét.

Ha amegadott vásárló nem létezik, jeleníts meg egy üzenetet és lépj ki

Ha a vásárlónak nincs vásárlása akkor jelezni kell

Ha van vásárlás jelenítsd meg eredményhalmazként
*/

DECLARE @CustomerName NVARCHAR(100) = 'Curtis Lu'

if not exists(select * from Customer where (FirstName + ' ' + LastName) = @CustomerName)
    BEGIN
        PRINT 'Nincs ilyen vásárló!'
        RETURN
    END

if not exists(
    select *
    from Orders as o
    INNER JOIN Customer as c on c.CustomerID = o.CustomerID
    where (c.FirstName + ' ' + c.LastName) = @CustomerName
)
BEGIN
        PRINT 'Nincs vásárlása'
        RETURN
END
--Ha nincs vásárlása a return miatt nem lesz üres eredményhalmaz    
select *
from Orders as o
INNER JOIN Customer as c on c.CustomerID = o.CustomerID
where (c.FirstName + ' ' + c.LastName) = @CustomerName
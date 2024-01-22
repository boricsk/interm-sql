SELECT SalesPersonID, 
    SUM(Case When YEAR(OrderDate) = 2011 then Subtotal end) as [2011],
    SUM(Case When YEAR(OrderDate) = 2012 then Subtotal end) as [2012],
    SUM(Case When YEAR(OrderDate) = 2013 then Subtotal end) as [2013],
    SUM(Case When YEAR(OrderDate) = 2014 then Subtotal end) as [2014],
    SUM(Case When YEAR(OrderDate) = 2015 then Subtotal end) as [2015],
    SUM(Case When YEAR(OrderDate) = 2016 then Subtotal end) as [2016],
    SUM(SubTotal) as [Total]
FROM Orders
GROUP BY SalesPersonId
ORDER BY Total

/*
A fenti elegánsabb megoldása a pivot
4 dologra van szükség
-Mi legyen a sorok elején
-Mi legyen az oszlop cimke
-Milyen összesítófüggvényt használunk a mettszéspontokban
-Melyik oszlopra használjuk az összesítő fgvt

Elősször egy subqueryt kell csinálni azokkal az oszlopokkal, amelyekre szükség van.
*/
--      sornevek                   oszlopnevek 
select SalesPersonID, [2011], [2012], [2013], [2014], [2015]
from 
(
--          sornevek       oszlopnevek               Amit összesítük
    select SalesPersonID, YEAR(OrderDate) as [Year], SubTotal
from Orders
) as o
pivot(sum(Subtotal) for YEAR in ([2011], [2012], [2013], [2014], [2015])) as p

select SalesPersonID, 
    isnull([2011], 0) as [2011], 
    isnull([2012], 0) as [2012], 
    isnull([2013], 0) as [2013],
    isnull([2014], 0) as [2014], 
    isnull([2015], 0) as [2015]
from 
(
    select SalesPersonID, YEAR(OrderDate) as [Year], SubTotal
from Orders
) as o
pivot(sum(Subtotal) for YEAR in ([2011], [2012], [2013], [2014], [2015])) as p

--Összesítsük a vásárlásokat évenként és országonként
select Country, [2011], [2012], [2013], [2014], [2015]
FROM (
SELECT 
    YEAR(OrderDate) as [Year],
    SubTotal,
    Country
from Orders as o
inner join Customer as c on c.CustomerID = o.CustomerID
) as o
PIVOT(sum(Subtotal) for YEAR in ([2011], [2012], [2013], [2014], [2015])) as piv

--Célszerű azt az elvet követni, hogy amiból sok van az a sorokban jelenik meg, amiből kevesebb az a 
--oszlopokban. Szempont az is, hogy mi fog később változni

--Transzponálás
select [YEAR], [DE], [GB], [AU], [CA], [FR], [US], [Other]
FROM (
SELECT 
    YEAR(OrderDate) as [Year],
    SubTotal,
    isnull(Country, 'Other') as Country
from Orders as o
inner join Customer as c on c.CustomerID = o.CustomerID
) as o
PIVOT(sum(Subtotal) for Country in ([DE], [GB], [AU], [CA], [FR], [US], [Other])) as piv

--Éves és havi bontás
select [YEAR], [Month], [DE], [GB], [AU], [CA], [FR], [US], [Other]
FROM (
SELECT 
    YEAR(OrderDate) as [Year],
    Month(OrderDate) as [Month],
    SubTotal,
    isnull(Country, 'Other') as Country
from Orders as o
inner join Customer as c on c.CustomerID = o.CustomerID
) as o
PIVOT(sum(Subtotal) for Country in ([DE], [GB], [AU], [CA], [FR], [US], [Other])) as piv
ORDER BY 1, 2
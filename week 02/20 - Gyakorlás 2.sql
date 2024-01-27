/*
Készíts egy reportot ami összesíti az aktuális év eladásait termék kategóriaként havi bontásban
(a hónapok neveit jelenítsd meg). A termék kategória lista adott.

1. Készíts egy temptable-t amelyben eltoljuk a dátumokat 8 évvel
2. Készíts egy temptable-t a termék kategória nevekkel
3. Az aktuális év szűrés legyen dinamikus
4. Az oszlopban a hónapok nevei legyenek sorban
5. Olyan hónapokat is jelenítsünk meg, ahol nincs adat
6. Az első oszlopban a term kategória legyen sorrendban
7. NULL helyett 0 legyen

*/

--1
drop table if exists #adatok
SELECT
    OrderID,
    dateadd(year, 10, OrderDate) as OrderDate,
    CustomerID,
    SubTotal
into #adatok
from Orders

--2
--A kategóriákhoz adink random neveket

select distinct ProductSubcategoryID
from Product

--ezt subquery-be teszem és a newid()-vel generálok hozzá nevet
--és megcsinálom az ideiglenes táblát

drop table if exists #prodcategory
SELECT prodcat.ProductSubcategoryID, left(NEWID(),8) as ProdCatName
into #prodcategory
from (
    select distinct ProductSubcategoryID
    from Product
) as prodcat
where prodcat.ProductSubcategoryID is not NULL

--aktuális év
select 
    month(o.OrderDate) as [Month],
    o.SubTotal,
    pc.ProdCatName
    
from #adatok as o
inner join OrderDetail as od on o.OrderID = od.OrderID
inner join Product as p on p.ProductID = od.ProductID
inner join #prodcategory as pc on pc.ProductSubcategoryID = p.ProductSubcategoryID
WHERE o.OrderDate >= DATEFROMPARTS(year(GETDATE()),1,1) 

--hónap számával


SELECT ProdCatName, 
    [1] as Jan,
    [2] as Feb,
    [3] as Marc,
    [4] as April,
    [5] as May,
    [6] as June,
    [7] as July,
    [8] as Aug,
    [9] as Sep,
    [10] as Oct,
    [11] as Nov,
    [12] as Dec
from (
select 
    month(o.OrderDate) as [Month],
    o.SubTotal,
    pc.ProdCatName
    
from #adatok as o
inner join OrderDetail as od on o.OrderID = od.OrderID
inner join Product as p on p.ProductID = od.ProductID
inner join #prodcategory as pc on pc.ProductSubcategoryID = p.ProductSubcategoryID
WHERE o.OrderDate >= DATEFROMPARTS(year(GETDATE()),1,1) 
) as sub
PIVOT(sum(SubTotal) for month in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) as [pivot]
ORDER BY 1

--Hónap nevével

SET LANGUAGE Hungarian
SELECT ProdCatName, [január],[február],[március],[április],[május],[június],[július],[augusztus],[szeptember],[október],[november],[december]
from (
select 
    o.SubTotal,
    datename(month, o.OrderDate) as [MonthName],
    pc.ProdCatName
    
from #adatok as o
inner join OrderDetail as od on o.OrderID = od.OrderID
inner join Product as p on p.ProductID = od.ProductID
inner join #prodcategory as pc on pc.ProductSubcategoryID = p.ProductSubcategoryID
WHERE o.OrderDate >= DATEFROMPARTS(year(GETDATE()),1,1) 
) as sub
PIVOT(sum(SubTotal) for [MonthName] in ([január],[február],[március],[április],[május],[június],[július],[augusztus],[szeptember],[október],[november],[december])) as [pivot]
ORDER BY 1
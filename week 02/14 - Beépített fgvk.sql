/*
Listázzuk ki a vásárlókat a köv formátumban
CustomerID, 
Title First Name Last name,(Country, City)

Concat
A fgv automatikusan kasztol ha kell. (CustomerID)
Az isnull-t is megoldja
*/

select
    CustomerID,
    isnull(Title + ' ', '') + FirstName + ' ' + LastName + isnull(' (' + Country +', ' + City + ')',''),
    CONCAT(CustomerID, '-', Title + ' ', FirstName, ' ', LastName, '(' + Country +', ' + City + ')')
from Customer
--where CustomerID = '29574'

/*
Számoljuk meg, hogy hány tagból áll a termék product number oszlopa. (Hány kötőjel van benne)
len -> szöveg hossza
*/

select 
    ProductID,
    Name,
    ProductNumber,
    len(ProductNumber),
    replace(ProductNumber,'-', ''),
    len(replace(ProductNumber,'-', '')),
    len(ProductNumber) - len(replace(ProductNumber,'-', '')) + 1 as Tags
from Product

/*
A termék táblában csökkendsd az összes termék listaárát 10%-al, a formátum 2 tizedes legyen.
A round nem változtat adattipust
*/

select ProductID, Name, ListPrice,
    ListPrice * 0.9,
    ROUND(ListPrice * 0.9,2) as [Round],
    cast(ListPrice * 0.9 as decimal(10,2)) as [cast]
from Product

/*
A vásárlás részletezésénél jelenítsük meg % formában, hogy az adott terméksor
hány százalékát teszi ki a teljes vásárlásnak. (A line total hány %a a subtotalnak)
*/
select 
    od.OrderID,
    od.OrderQty,
    od.UnitPrice,
    od.LineTotal,
    od.OrderDetailID,
    FORMAT(od.LineTotal / o.SubTotal,'P2'),
    o.SubTotal
from OrderDetail as od
inner join Orders as o on o.OrderID = od.OrderID
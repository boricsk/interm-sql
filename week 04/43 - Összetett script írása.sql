/*
A mellékelt productcategory.xlsx fáljban a kategória adatok vannak.
Töltsük be ezt egy ideiglenes táblába
Állítsunk elő éves adatokat az orders és az order detail tábla alapján
-2 új ideiglenes táblába (#orders, #orderdetail)
-Az adatok véltlenszerű 2*50%-ból (a 2. esetben az ID eltolásával)

Ha a termék product subcategory null cseréld 0-ra
A #productCategoryt egészítsük ki új nullás sorral
Irjunk dinamikus lekérdezést ami megjeleníti az éves adatokat
-havi bontásban
-termék kategóriaként
-összeget összesítve
*/

drop table if exists #ProductCategory

select list.* 
into #ProductCategory
from (
values
-- ProductSubCategoryID  ProductSubCategoryName  ProductCategoryID  ProductCategoryName  
  (1,                    N'Mountain Bikes',      1,                 N'Bikes'           ),
  (2,                    N'Road Bikes',          1,                 N'Bikes'           ),
  (3,                    N'Touring Bikes',       1,                 N'Bikes'           ),
  (4,                    N'Handlebars',          2,                 N'Components'      ),
  (5,                    N'Bottom Brackets',     2,                 N'Components'      ),
  (6,                    N'Brakes',              2,                 N'Components'      ),
  (7,                    N'Chains',              2,                 N'Components'      ),
  (8,                    N'Cranksets',           2,                 N'Components'      ),
  (9,                    N'Derailleurs',         2,                 N'Components'      ),
  (10,                   N'Forks',               2,                 N'Components'      ),
  (11,                   N'Headsets',            2,                 N'Components'      ),
  (12,                   N'Mountain Frames',     2,                 N'Components'      ),
  (13,                   N'Pedals',              2,                 N'Components'      ),
  (14,                   N'Road Frames',         2,                 N'Components'      ),
  (15,                   N'Saddles',             2,                 N'Components'      ),
  (16,                   N'Touring Frames',      2,                 N'Components'      ),
  (17,                   N'Wheels',              2,                 N'Components'      ),
  (18,                   N'Bib-Shorts',          3,                 N'Clothing'        ),
  (19,                   N'Caps',                3,                 N'Clothing'        ),
  (20,                   N'Gloves',              3,                 N'Clothing'        ),
  (21,                   N'Jerseys',             3,                 N'Clothing'        ),
  (22,                   N'Shorts',              3,                 N'Clothing'        ),
  (23,                   N'Socks',               3,                 N'Clothing'        ),
  (24,                   N'Tights',              3,                 N'Clothing'        ),
  (25,                   N'Vests',               3,                 N'Clothing'        ),
  (26,                   N'Bike Racks',          4,                 N'Accessories'     ),
  (27,                   N'Bike Stands',         4,                 N'Accessories'     ),
  (28,                   N'Bottles and Cages',   4,                 N'Accessories'     ),
  (29,                   N'Cleaners',            4,                 N'Accessories'     ),
  (30,                   N'Fenders',             4,                 N'Accessories'     ),
  (31,                   N'Helmets',             4,                 N'Accessories'     ),
  (32,                   N'Hydration Packs',     4,                 N'Accessories'     ),
  (33,                   N'Lights',              4,                 N'Accessories'     ),
  (34,                   N'Locks',               4,                 N'Accessories'     ),
  (35,                   N'Panniers',            4,                 N'Accessories'     ),
  (36,                   N'Pumps',               4,                 N'Accessories'     ),
  (37,                   N'Tires and Tubes',     4,                 N'Accessories'     )
) as list([ProductSubCategoryID], [ProductSubCategoryName], [ProductCategoryID], [ProductCategoryName])

--Temp tábla kiegészítése
insert into #ProductCategory([ProductSubCategoryID], [ProductSubCategoryName], [ProductCategoryID], [ProductCategoryName])
values(0, 'Other', 0, 'Other')

select * from #ProductCategory

select list.ProductCategoryName, count(*)
from #ProductCategory list
inner join Product p on ISNULL(p.ProductSubcategoryID, 0) = list.ProductSubCategoryID --ahol a prodcat null volt azt kicseréltük 0-ra.
group by list.ProductCategoryName

--pivot létrehozása
select ProductCategoryName, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12]
from (
    select list.ProductCategoryName, month(o.OrderDate) as M, od.LineTotal
    from #ProductCategory list
    inner join Product p on ISNULL(p.ProductSubcategoryID, 0) = list.ProductSubCategoryID
    left join OrderDetail od on od.ProductID = p.ProductID
    left join Orders o on o.OrderID = od.OrderID
) s
pivot(sum(LineTotal) for M in ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) p

--az eredeti tábla felét adja vissza véletlen sorrendben.
--a newid() guidokat csinál, amelyek véletlenek, ha így rendezünk
--véletlen lesz az eredményhalmaz is.
select top 50 percent *
from Orders
order by newid()


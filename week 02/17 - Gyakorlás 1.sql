/*
1.
Mutassuk ki a duplikátumokat az orders táblában a lentiek szerint:
Firstname, Lastname, Country, City
Jelenítsük meg mindet egyben és a Cust összes oszlopát

2.
Listázzuk ki azokat a vásárlőkat akik a tavalyi évben vásároltak, de idén még nem
Szimuláljuk az adatokat 2018 és 2022 között
Mutassuk meg az érintett vásárlók utolsó vásárlását az előző évből (Dátum, összeg)

3.
Keressük ki azokat a vásárlókat amelyek utóneve a következő listában van:
"Keil,Gage,Almand,Emauel,Gates,Koch,Bourne,Colvin,Chambers,Ruth,Benson,Ray,West"
*/

SELECT c.*
from(
    select FirstName, LastName, Count(*) as [Count]
    from Customer
    GROUP BY FirstName, LastName
    HAVING COUNT(*) > 1
) as dupl
INNER JOIN Customer as c on c.FirstName = dupl.FirstName and c.LastName = dupl.LastName
ORDER BY 4, 5

select *
from(
    select *,COUNT(*) over(partition by FirstName, LastName) as [Count]
    from Customer
) as l
WHERE [Count] > 1
ORDER BY FirstName, LastName

select *
from(
    select *,COUNT(*) over(partition by FirstName, LastName, Country, City) as [Count]
    from Customer
) as l
WHERE [Count] > 1
ORDER BY FirstName, LastName

/*
2
*/

drop table if exists #adatok
SELECT
    OrderID,
    dateadd(year, 10, OrderDate) as OrderDate,
    CustomerID,
    SubTotal
into #adatok
from Orders

select c.*
from(
select distinct CustomerID from #adatok
where OrderDate BETWEEN '2023-01-01' and '2023-12-31'
EXCEPT
select distinct CustomerID from #adatok
where OrderDate BETWEEN '2024-01-01' and '2024-12-31'
) as o
JOIN Customer as c on c.CustomerID = o.CustomerID

--a dátumokat számolja ki dinamikusan
select c.*
from(
select distinct CustomerID from #adatok
--where OrderDate BETWEEN '2023-01-01' and '2023-12-31'
where OrderDate BETWEEN DATEFROMPARTS(YEAR(GETDATE()) -1,1,1) and DATEFROMPARTS(YEAR(GETDATE()) -1,12,31)
EXCEPT
select distinct CustomerID from #adatok
--where OrderDate BETWEEN '2024-01-01' and '2024-12-31'
where OrderDate BETWEEN DATEFROMPARTS(YEAR(GETDATE()),1,1) and DATEFROMPARTS(YEAR(GETDATE()),12,31) 
) as o
JOIN Customer as c on c.CustomerID = o.CustomerID

--utolsó vásárlás
select c.*, lastbuy.SubTotal, lastbuy.OrderDate as lastbuydate
from(
select distinct CustomerID from #adatok
where OrderDate BETWEEN DATEFROMPARTS(YEAR(GETDATE()) -1,1,1) and DATEFROMPARTS(YEAR(GETDATE()) -1,12,31)
EXCEPT
select distinct CustomerID from #adatok
where OrderDate BETWEEN DATEFROMPARTS(YEAR(GETDATE()),1,1) and DATEFROMPARTS(YEAR(GETDATE()),12,31) 
) as o
JOIN Customer as c on c.CustomerID = o.CustomerID
OUTER APPLY (
    --ez a subquery vehet át paramétert kívülről
    select top 1 *
    from #adatok as o
    WHERE o.CustomerID = c.CustomerID
    ORDER by OrderDate desc
) as lastbuy

/*
3
*/

--A litát fel kell bontani SQL-ben használható listára. Van beépített fgv.
--"Keil,Gage,Almand,Emauel,Gates,Koch,Bourne,Colvin,Chambers,Ruth,Benson,Ray,West"

select 'Keil,Gage,Almand,Emauel,Gates,Koch,Bourne,Colvin,Chambers,Ruth,Benson,Ray,West'

select * from string_split('Keil,Gage,Almand,Emauel,Gates,Koch,Bourne,Colvin,Chambers,Ruth,Benson,Ray,West',',')
--ez mindíg value névvel tér vissza, speciális mert from után kell tenni, mert úgy viselkedik mint egy tábla

select *
from string_split('Keil,Gage,Amland,Emanuel,Gates,Koch,Bourne,Colvin,Chambers,Ruth,Benson,Ray,West',',') as Name
inner join Customer as c on c.LastName = Name.[value]
--vagy

drop table if EXISTS #names
select [value] as Name
into #names
from string_split('Keil,Gage,Amland,Emanuel,Gates,Koch,Bourne,Colvin,Chambers,Ruth,Benson,Ray,West',',') as Name

select * from #names

select *
from #names as names
inner join Customer as c on c.LastName = names.Name
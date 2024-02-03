--Gyakorlat
/*
1. Készítsünk egy scriptet, amely a biztonsági mentés filenevét generálja le egy @file nevű válzozóba a köv. formátumben: Backup_éééé_hh_nn_óóppmm.bak
2. Készítsünk egy scriptet, amely amely megméri egy lekérdezés futási idejét és visszaadja milisec-ben
3. Írjunk egy lekérdezést ami 2 változóba lekérdezi, hogy melyik vásárlónak volt a legtöbb vásárlása és megjeleníti a köv. formátumban: CustomerID: 1176, Orders: 28
*/
--1
declare @file varchar(2000)
set @file = 'Backup_' + format(GETDATE(), 'yyyy_MM_dd_hhmmss') + '.bak'
select @file

--2
declare @start as datetime = GETDATE()
select top 100 * from Customer as c
outer apply (select sum(subtotal) as T from Orders where c.CustomerID = c.CustomerID) as o
select DATEDIFF(ms, @start, GETDATE())
print DATEDIFF(ms, @start, GETDATE()) --A messages tabra ír

--3
declare @Result NVARCHAR(100)
SELECT Top 1 @Result = 'CustomerID : ' + cast(CustomerID as VARCHAR(10)) + ', Orders: ' +  cast(count(*) as varchar(10)) 
from Orders
GROUP BY CustomerID
Order by count(*) desc
select @Result
print @Result

--Ha a selectet értékadásra használod akkor nem fog eredményt visszaadni, ill. nem lehet alias neve.

/*
Ideiglenes táblák
Olyan táblák, amelyek ténylegesen létrejönnek, de a kapcsolat bontás után törlődnek.
A szerver a tempdb adatbázisba rakja ezeket
A nevnek # kell kezdődni
Tulajdonságai = normál táblákéval
Tudunk létrehozni akkor is ha read only-k vagyunk.

*/
--szimulált adatok létrehozása egy temptable-ben.
drop table if exists #szimuláció
SELECT
    OrderID,
    DATEADD(Year, 10, OrderDate) as OrderDate,
    CustomerID,
    SalesPersonID,
    SubTotal
into #szimuláció
from orders

select * FROM #szimuláció

--elmúlt 2 év eladási adatainak lekérdezése
select * FROM #szimuláció
WHERE OrderDate > '2020-04-14'

--dinamikus szűrés megvalósítása
select dateadd(year, -2, GETDATE())

select * FROM #szimuláció
WHERE OrderDate > dateadd(year, -2, GETDATE()) and OrderDate <= GETDATE()

--ha datetime a típus akkor figyelni kell arra, hogy a szürési feltételben
--az aktuális időpont és a nap kezdete közti rész az kissebb lesz mint amit a get date
--visszaad. Azaz nem fogja megjeleníteni ezeket az adatokat

select cast(GETDATE() as date)

select * FROM #szimuláció
WHERE OrderDate > dateadd(year, -2, cast(GETDATE() as date)) and OrderDate < cast(GETDATE() as date)

select 
    min(OrderDate),
    max(OrderDate)
from Orders

select 
    min(OrderDate),
    max(OrderDate)
from #szimuláció

--A két évvel ezelőtti aktuális hónap első napja.
SELECT DATEFROMPARTS(year(dateadd(year, -2, GETDATE())), month(dateadd(year, -2, GETDATE())),1) as datep

--aktuális év akutális hónap első napja
SELECT DATEFROMPARTS(year(GETDATE()), month(GETDATE()),1) as datep

--aktuális előtti hónap utolsó napja
SELECT dateadd(day, -1,DATEFROMPARTS(year(GETDATE()), month(GETDATE()),1)) as datep

--mivel az előbbi  éjfélt fog visszaadni, ezért az utolsó nap 0:00:01 - 23:59:59
--közötti rnedelések nem lesznek benne, ezért  datetimefromparts kell
SELECT dateadd(day, -1,DATETIMEFROMPARTS(year(GETDATE()), month(GETDATE()),1,23,59,59,900)) as datep


select * FROM #szimuláció
WHERE OrderDate 
    BETWEEN 
    DATEFROMPARTS(year(dateadd(year, -2, GETDATE())), month(dateadd(year, -2, GETDATE())),1) and
    dateadd(day, -1,DATEFROMPARTS(year(GETDATE()), month(GETDATE()),1))

select * FROM #szimuláció
WHERE OrderDate 
    BETWEEN 
    DATEFROMPARTS(year(dateadd(year, -2, GETDATE())), month(dateadd(year, -2, GETDATE())),1) and
    dateadd(day, -1,DATETIMEFROMPARTS(year(GETDATE()), month(GETDATE()),1,23,59,59,900))

--vagy
select * FROM #szimuláció
WHERE OrderDate >= DATEFROMPARTS(year(dateadd(year, -2, GETDATE())), month(dateadd(year, -2, GETDATE())),1) and
      OrderDate < DATEFROMPARTS(year(GETDATE()), month(GETDATE()),1)

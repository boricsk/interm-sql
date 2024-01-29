/*
Változók
SQL programozás alapok
SQL szkriptek

Programozási elemek
-Adattipusok
-Változók és ezekkel végezhető műveletek
-Vezérlési utasítások
    *logikai kiértékelések
    *kód blokk definiálás
    *felt elágazások (többirányú nincs)
    *ciklus (előltesztelő while van)
    *ciklus vezérlés (kilépés, újraindítás)
-subrutinok (függvények -> visszatérési értéke van, eljárások)
-batch és scope a változók számára (lokális, globális)


Változók
Adatok ideiglenes tárolására van. A név @ kezdődik, adattipus megadása kötelező.
Névnek egyedinek kell lennie. Caseinsensitive. Nem lehet megszüntetni, 
amig fut a program, vagy él a kapcs a memóriát foglalja. 

Definiálás
DECLARE @VARNAME INT, @VARNAME BIGINT

Kezdeti értéke mindíg NULL lesz.
*/

declare 
    @myInt Int,
    @Valtozo bigint,
    @Harmadik date,
    @Szoveg NVARCHAR(100)
select @myInt, @Valtozo, @Harmadik

/*
Változó értékadás

Init = NULL

*/

SET @Valtozo = 123
select @myInt, @Valtozo, @Harmadik
--tömeges értékadás
select @Valtozo = 333, @myInt = 444, @Harmadik = '2024-01-23'
select @Valtozo, @myInt, @Harmadik

/*
A kezdeti érték származhat egy változóból is vagy egy lekérdezésből is, ha gondoskodunk
arról, hogy az egy skaláris értéket adjon vissza.
*/

SET @myInt = @Valtozo
select @Valtozo as [@Valtozo], @myInt as [@myInt], @Harmadik as [@Harmadik]

SET @myInt = (SELECT Count(*) from Customer)
select @Valtozo as [@Valtozo], @myInt as [@myInt], @Harmadik as [@Harmadik]

--Ebben az esetben az értékadás addig tart amíg végig nem megy a lekérdezés
--az egész táblán, csak az utolsó értéke marad meg.
select @myInt = CustomerID, @Szoveg = FirstName + ' ' + LastName
from Customer

select @myInt, @Szoveg
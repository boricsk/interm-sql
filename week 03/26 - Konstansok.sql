/*
Konstansok
declare 
                    Konstansok, mert ezek nem változnak.
    @Osszeg FLOAT = 123.1456 + 0.214

A konstansok tipusát a server kitalálja.
Számok : 123, 0.125
Szöveg : 
'Szöveg'

'Hosszú
szöveg'

Dátumok
'2023-02-11'
'20230101'

Hexa
0x660D167B99

Típusosság jelentősége
Fontos, hogy a megfelelő adattípust használjunk és ne szöveget, mert
-Dátumoknál ha szövegben tárolod akkor nem biztos, hogy rendezhető, nem biztosított a területenkénti megfelelő megjelenés, nagyobb helyet foglal. Dátumok esetében külön-külön tárolja a rendszer a komponenseket
-Számoknál is több helyet foglal a szöveges típus, itt is külön van tárolva az egészrész és a tört rész.

Adat konverziók
Meglévő típustól másikba rakjuk át. 
Implicit (háttérben történik) kasztolás lehet:
declare @myInt int ='5845698'
mert számok vannak megadva a '' között
Általában szövegre mindent lehet alakítani.
*/
--CONVERT
DECLARE @Datum Datetime = '31/1/2023' --hiba, nem tudja eldönteni a szerver, ha nem adom meg neki a konvertálás részleteit
DECLARE @Datum2 Datetime = convert(Datetime, '31/1/2023',103) --explicit típus konverzió, azaz megadom a részleteket a konvertáláshoz
--A 3. paraméter egy dátumtípuskód, ami a konvertálandó dátumra vonatkozik.
--https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16
--Nincs hibaellenőrzés, megáll a kód hiba esetén
SELECT @Datum2

--TRY_CONVERT
DECLARE @Datum3 Datetime = try_convert(Datetime, '3112023',103) --explicit típus konverzió, azaz megadom a részleteket a konvertáláshoz
SELECT @Datum3
--nem lesz hiba, NULL lesz az eredményhalmaz.

--CAST / TRY_CAST
DECLARE @Datum4 Datetime = cast('31/1/2023' as datetime) --explicit típuskényszerítés
SELECT @Datum4

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

declare @myInt Int
select @myInt
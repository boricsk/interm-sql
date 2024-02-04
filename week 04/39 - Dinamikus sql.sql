/*
Dinamikus QSL
Olyan esetekben van, amikor az SQL szkript nem ismert, menet közben kell előállítani.
Egy változóban van tárolva a lekérdezés. Bármilyen SQL utasítás használható ami a
statikus lekérdezésekben is használható. Lehet bemeneti paramétere is. EXEC parancsal 
lehet futtatni.

Ha lehet kerüljük, mert nehéz debuggolni. Könnyű hibázni is, mert a string-ben tárolt SQL
parancs nem ellenőrizhető előre, pl. DataStudio. Több ág esetén teszteléskor nem biztos,
hogy mindent le tudsz tesztelni.

Szintaktika
declare @SQL nvarchar(max)

set @SQL = 'SELECT * FROM Orders' -> futtatható SQL lekérdezésnek kell lenni, ez a belső v. dinamikus SQL

exec(@SQL)

A belső SQL-t nagybetűvel célszerű írni, hogy elkülönűljenek egymástól.
*/
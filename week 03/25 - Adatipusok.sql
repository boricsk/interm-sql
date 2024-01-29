/*
https://learn.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver16

Egész típusok
BIT             1 bit (0 vagy 1 az értéke)
TINYINT         8 bit (0-255)
SMALLINT        16 bit (-32,768 to 32,767)
INT             32 bit (-2,147,483,648 to 2,147,483,647)
BIGINT          64 bit (-9,223,372,036,854,775,808 to 9,223,372,036,854,775,807)

Tört számok (fix pontos)
DECIMAL             
MONEY
SMALLMONEY

Tört számok (lebegőpontos)
FLOAT

Rövid szöveg (Az N előtag arra utal, hogy UNICOD-al tárol)
CHAR,VARCHAR    1 byte (Korlát 8000 karakter)
NCHAR,NVARCHAR  2 byte (65536 karaktert lehet tárolni, 4000 karakter max, csak annyi helyet foglal amennyit beleírunk, dinamikusan változtatja a méretet ha kell)
Ha hosszabb a szöveg mint amire a változót definiáltuk le fogja vágni a szöveget.

Hosszú szövet tárolására > 4000 / 8000
VARCHAR(MAX)        4GB
NVARCHAR(MAX)       2GB
MAX -> A szöveg max. 2GB/4GB lehet.

Dátum típus
DATE
TIME
DATETIME (század mp 3 tizedes pontosságig)
DATETIME2 (század mp 8 tizedes pontosságig)

--Bináris tipusok
BINARY, VARBINARY
VARBINARY(MAX)

--Exotikus adattipusok
UNIQUEIDENTIFIER (GUIT-ot generál 16 byte-os)
JSON
SQL_VARIANT
*/

declare 
    @Osszeg FLOAT = 123.1456 + 0.214, --Csak a pont használható tizedes elválasztónak.
    @Datum date = GETDATE(),
    @Datum2 DATETIME = GETDATE(),
    @Datum3 DATETIME2 = GETDATE(),
    @GUID UNIQUEIDENTIFIER = newid()


SELECT @Osszeg, @Datum, @Datum2, @Datum3, @GUID

select * from sys.types
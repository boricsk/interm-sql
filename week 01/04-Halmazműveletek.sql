--Union, Union All
select *
    from (
        VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Miskolc'),
        (4, N'Debrecen'),
        (5, N'Győr')
    ) varos(ID, nev)
    UNION ALL
    select 1, 'Budapest'

--Visszajönnek a halmazok elemei. 
--Union erőforrásigényes lehet, mert meg kell mindíg nézni, hogy ami visszatért az benne van-e már az eredményhalmazban.
--Fontos, hogy a halmazműveletekket összekötött lekérdezések eredményhalmazai hasonlóak legyenek.
--Elvileg a típusnak is egyezni kell, de az sql szerver próbál kasztoni automatikusan, de ez nem mindíg jó
--Az oszlopneveket az első lekérd hat meg


select distinct *
from (select *
    from (
        VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Miskolc'),
        (4, N'Debrecen'),
        (5, N'Győr')
    ) varos(ID, nev)
    UNION ALL
    select 1, 'Budapest') as s

    
    select *
    from (
        VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Miskolc'),
        (4, N'Debrecen'),
        (5, N'Győr')
    ) varos(ID, nev)
    UNION ALL
    select 1, cast(125.35 as nvarchar(10)) --típusváltás
    UNION ALL
    select 7, 'ABC'
    Order by 2 --rendezni a legvégén lehet, és az egészre vonatkozik

/*
implicit - burkolt, rejtett, nem kifejtett
explicit - 
*/

--Except, Intersect
/*
Except - Kivonás, azaz az egyik halmaz elemei a másik nélkül.
*/
select *
    from (
        VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Miskolc'),
        (4, N'Debrecen'),
        (5, N'Győr')
    ) varos(ID, nev)
    EXCEPT
    select 1, 'Budapest'

--Ezt mostanság így szokás megcsinálni

select a.*, s.*
from (select *
    from (
        VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Miskolc'),
        (4, N'Debrecen'),
        (5, N'Győr')
    ) varos(ID, nev)) as a
    left join (select 1 as ID, 'Budapest' as nev ) as s on s.ID = a.ID and s.nev = a.nev
    WHERE s.id is null

/*
Intersect - Metszet A közös részeket adják vissza

*/

select *
    from (
        VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Miskolc'),
        (4, N'Debrecen'),
        (5, N'Győr')
    ) varos(ID, nev)
    INTERSECT
    select 1, 'Budapest'

--vagy
select s.*
from (
    select ID, Nev as Varos
    from (
        VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Miskolc'),
        (4, N'Debrecen'),
        (5, N'Győr')
    ) varos(ID, nev)) as s
    inner join (select 1 as ID, 'Budapest' as Nev) as a on s.ID = a.ID and s.Varos = a.Nev

/*
Példa
A customer táblában lécő country-t egészítsük ki Hollandiával és Olaszországgal
*/

select distinct Country
From Customer
WHERE Country is not null
Union All select 'IT'
Union ALL select 'NL'
Union ALL select 'RS'
Union ALL select 'PL'
Union ALL select 'RO'
Union ALL select 'SR'

--Union, Union All
select *
from (
    VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Debrecen'),
        (4, N'Győr'),
        (5, N'Miskolc')
) varos (ID, Nev)

UNION

select *
FROM (
    Values
    (1, N'Budapest'),
    (2, N'Bivalybasznád')
) varos2 (ID, Nev)

/*
A fenti két lekérdezést 1 eredményhalmazba adja vissza
*/

select distinct *
from (
    select *
    from (
        VALUES
            (1, N'Budapest'),
            (2, N'Szeged'),
            (3, N'Debrecen'),
            (4, N'Győr'),
            (5, N'Miskolc')
    ) varos (ID, Nev)

    UNION ALL

    select *
    FROM (
        Values
        (1, N'Budapest'),
        (2, N'Bivalybasznád')
    ) varos2 (ID, Nev)
) as s
--a distinct miatt nem jött a Bp 2x

select *
from (
    VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Debrecen'),
        (4, N'Győr'),
        (5, N'Miskolc')
) varos (ID, Nev)

UNION

select *
FROM (
    Values
    (1, cast(123.54 as nvarchar(10))),
    (2, cast(573.13 as nvarchar(10)))
) varos2 (ID, Lakosok)
--tipuskonverzió

--Except, Intersect
select *
from (
    VALUES
        (1, N'Budapest'),
        (2, N'Szeged'),
        (3, N'Debrecen'),
        (4, N'Győr'),
        (5, N'Miskolc')
) varos (ID, Nev)

EXCEPT

select *
FROM (
    Values
    (1, N'Budapest'),
    (2, N'Bivalybasznád')
) varos2 (ID, Nev)
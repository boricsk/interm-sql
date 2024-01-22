--Mozgó átlag 3 havi
/*
Mozgó átlag : A total 3 havi átlagát kell egy számított oszlopban megjeleníteni.
A következő sorban pedig csúszik lefelé az egész 1 el.

*/

--Első lépés az alapadatkészlet összeállítása aggregálva
SELECT
    year(OrderDate) as [Year],
    month(OrderDate) as [Month],
    sum(SubTotal) as [Total]
from Orders
GROUP BY  year(OrderDate), month(OrderDate) 
ORDER BY 1, 2
/*
Ablakozás elkészítése. A fentiből készíts egy subqueryt.
Az ablak változásának definiálása rows between 2 preceding and current row
Ez azt jelenti, hogy az aktuális sor felé kell menni 2 sorral
Ebben az esetben azonban nem áll meg a logika akkor, ha új évet kezd azaz
át kell helyezni az order by ba a yeart-is és a patrition by nem kell, mert
nem akarok évenkénti ablakot.
*/
select *,
    avg(Total) over (/*partition by Year */order by Year, Month rows between 2 preceding and current row)
FROM(
    select 
        YEAR(OrderDate) as [Year],
        MONTH(OrderDate) as [Month],
        SUM(SubTotal) as Total
    from Orders
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
    --ORDER BY 1, 2 (Subqueryben nem lehet)
) as t
ORDER BY 1, 2
/*
Ha nincs meg a 3 hónap akkor ne jelenítsünk meg semmit. Ehez össze kell számolni a sorokat
és csak akkor számolunk átlagot, ha a sorok száma > 3
*/
select *,
    avg(Total) over (/*partition by Year */order by Year, Month rows between 2 preceding and current row),
    count(Total) over (/*partition by Year */order by Year, Month rows between 2 preceding and current row),
    case when count(Total) over (/*partition by Year */order by Year, Month rows between 2 preceding and current row) >= 3
        then avg(Total) over (/*partition by Year */order by Year, Month rows between 2 preceding and current row)
        else NULL
    end as MonthMovingAvg
FROM(
    select 
        YEAR(OrderDate) as [Year],
        MONTH(OrderDate) as [Month],
        SUM(SubTotal) as Total
    from Orders
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
    --ORDER BY 1, 2
) as t
ORDER BY 1, 2
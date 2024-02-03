/*
Írjunk egy scriptet, amely kilistázza az akt. év minden hónapját
Minden sorban a hónap első és a hónap utolsó napját írassuk ki
Ha szökőév van akkor a január és február legyen összevonva
*/

DECLARE 
    @Eveleje DATE, 
    @Evvege date, 
    @datum DATE, 
    @sorszam INT = 1, 
    @utolsonap DATE,
    @szokonap DATE

SET @Eveleje = DATEFROMPARTS(year(GETDATE()),1,1)
SET @Evvege = DATEFROMPARTS(year(GETDATE()),12,31)
SET @szokonap = DATEFROMPARTS(year(GETDATE()),3,1)
SET @szokonap = DATEADD(day,-1, @szokonap)

SET @datum = @Eveleje


WHILE (@datum <= @Evvege)
BEGIN
    --SET @utolsonap = DATEADD(MONTH,1,@datum)
    --SET @utolsonap = DATEADD(day,-1 ,@utolsonap)
    if  day(@szokonap) = 29 and MONTH(@datum) in (1)
    begin
        SET @utolsonap = DATEADD(MONTH,2,@datum)
        SET @utolsonap = DATEADD(day,-1 ,@utolsonap)
        --vagy SET @utolsonap = EOMONTH(dateadd(month,1,@datum))
        PRINT Concat(@sorszam, ' - Első nap :',@datum, ', Utolsó nap : ', @utolsonap)
        SET @datum = DATEADD(MONTH,2,@datum)
    end ELSE
    BEGIN
        SET @utolsonap = EOMONTH(@datum)
        PRINT Concat(@sorszam, ' - Első nap :',@datum, ', Utolsó nap : ', @utolsonap)
        SET @datum = DATEADD(MONTH,1,@datum)
    END
    --A sorszám increase-t ki lehet hozni az ifből
    SET @sorszam += 1
END


PRINT @Evvege
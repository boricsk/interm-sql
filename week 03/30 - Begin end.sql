--SQLProgramozás
/*
BEGIN-END
Blokkok definiálása, ha több utasítást akarunk kezelni, bárhol használható és párban lakik
Üres blokk nem lehet.Komment se lehet


IF-ELSE
Feltételkezelés

*/
declare @v int = 2

if @v = 1
    select @v = count(*) from Orders
    print @v --az if után csak 1 utasítás állhat ezért ez mindíg lefut

declare @v2 int = 1
if (@v2 = 1) AND (@v = 1)
    begin
        select @v2 = count(*) from Orders
        print @v2 
    end
else -- lehet if el is folytatni
    print 'Nincs adat'

/*
While ciklus
Csak előltesztelő változata van, amíg ez igaz addig fut.
Csak 1 utasítás lehet utánna, ha több kell, akkor begin-end kell
*/
declare @Ciklus int = 0
PRINT @Ciklus
while @Ciklus < 10
    begin
        SET @Ciklus = @Ciklus + 1
        PRINT 'Hello' + ' ' + CAST(@Ciklus as VARCHAR)
        PRINT GETDATE()
    end

/*
BREAK-CONTINUE
*/
declare @Ciklus2 int = 0
PRINT @Ciklus2
while @Ciklus2 < 10
    begin
        IF @Ciklus2 = 5 BREAK
        PRINT 'Hello' + ' ' + CAST(@Ciklus2 as VARCHAR)
        PRINT GETDATE()
        SET @Ciklus2 = @Ciklus2 + 1
    end


/*
A CONTINUE az utánna lévő sorokat kihagyja, és kezd egy új ciklus iterációt.
*/

SET @Ciklus2 = 0
while @Ciklus2 < 10
    begin        
        PRINT 'Hello' + ' ' + CAST(@Ciklus2 as VARCHAR)
        IF @Ciklus2 = 5 CONTINUE
        PRINT GETDATE()
        SET @Ciklus2 = @Ciklus2 + 1
    end

/*
GOTO
Ugrás a megfelelő cimkére, elavult.
*/
DECLARE @Var INT
SET @Var = 1

GOTO NewLabel --Itt a newlabelre ugrik

--Utasítsok
--Utasítások

--Cimke fefiniálása
NewLabel:
--Utasítások

/*
RETURN
Script, eljárás futását szakítja meg
*/

WHILE @Var = 1
BEGIN
    If @Var = 1 RETURN
END

--1. Procedura przyjmuje pesel pasażera i szuka jego najczęściej wybieranego kierunku podróży. Zwraca kod
--lotniska. Mozna dodac kraj do lokalizacji i zwracac kraj

CREATE PROCEDURE ulubionyKierunek
    @peselPasazera char(11),
    @lotnisko VARCHAR(10) OUTPUT
AS
BEGIN
     WITH LotyPasażera AS (
        SELECT LotniskoPrzylotu, COUNT(*) as iloscLotow
        FROM LOT
        WHERE NumerLotu IN (
            SELECT NumerLotu
            FROM WIELELOTOW
            WHERE Pasazer = @peselPasazera
        )
        GROUP BY LotniskoPrzylotu
    )
    SELECT TOP 1 @lotnisko = LotniskoPrzylotu
    FROM LotyPasażera
    ORDER BY iloscLotow DESC;


        IF @@ROWCOUNT = 0
            SET @lotnisko = NULL;
END

DECLARE @lotniskoKodu VARCHAR(10);
EXEC ulubionyKierunek @peselPasazera = '59050327687', @lotnisko = @lotniskoKodu OUTPUT;
SELECT @lotniskoKodu AS UlubioneLotnisko;


--2 Procedura oblicza liczbę lotów dla każdego pasażera w ciągu ostatniego roku i nadaje odpowiednią zniżkę
-- w zależności od liczby lotów. Następnie procedura aktualizuje kolumnę Znizka w tabeli Pasazer,
-- przypisując odpowiednią zniżkę każdemu pasażerowi. Zniżka wynosi 10%, jeśli liczba lotów przekracza 10,
-- w przeciwnym razie zniżka wynosi tyle %, ile jest lotów.

ALTER TABLE Pasazer
    ADD Znizka INT;


CREATE PROCEDURE ZnizkaDlaPasazerow
AS
BEGIN

    DECLARE @Loty TABLE (Pesel CHAR(11), LiczbaLotow INT);

    INSERT INTO @Loty (Pesel, LiczbaLotow)
    SELECT WieleLotow.Pasazer, COUNT(*) AS LiczbaLotow
    FROM WieleLotow
    JOIN LOT ON LOT.NUMERLOTU = WieleLotow.NUMERLOTU
    WHERE LOT.DataWylotu >= DATEADD(YEAR, -1, GETDATE())
    GROUP BY WieleLotow.Pasazer;


    UPDATE Pasazer
    SET Znizka = CASE
        WHEN l.LiczbaLotow > 10 THEN 10
        ELSE l.LiczbaLotow
    END
    FROM Pasazer p
    JOIN @Loty l ON p.Pesel = l.Pesel;
END

EXEC ZnizkaDlaPasazerow;

--3 Wyzwalacz który nie pozwala na wstawienie lub zUpdateowanie rekordu jezeli daty są złe lub starsze niz miesiac

CREATE TRIGGER TR_ObslugaBagazu_AIUR
ON ObslugaBagazu
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE PoczatekZmiany >= KoniecZmiany)
    BEGIN
        RAISERROR('Poczatek zmiany musi byc wczesniej niz koniec zmiany', 16, 1);
        ROLLBACK;
    END

    IF EXISTS (SELECT 1 FROM inserted WHERE DATEDIFF(MONTH, PoczatekZmiany, GETDATE()) > 1)
    BEGIN
        RAISERROR('Data jest starsza niz miesiac.', 16, 1);
        ROLLBACK;
    END
END;

INSERT INTO ObslugaBagazu (NumerGrupy, PoczatekZmiany, KoniecZmiany, PracownikPesel, NrBagazuRej)
VALUES ('G001', '2023-01-01 10:00', '2022-12-31 09:00', '91032345861', 1);

--4 Wyzwalacz który zabrania edytowania w tabeli lot kolumn: numer lotu, lotnisko wylotu, numer samolotu i pesel pilota.

CREATE TRIGGER TR_LOT_IUR
ON Lot
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE(NumerLotu) OR UPDATE(LotniskoWylotu) OR UPDATE(Samolot_NumerSamolotu) OR UPDATE(Pilot_PracownikPesel)
    BEGIN
        RAISERROR(N'Nie można edytować kolumn: NumerLotu, LotniskoWylotu, Samolot_NumerSamolotu, Pilot_PracownikPesel', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    UPDATE Lot
    SET
        DataWylotu = i.DataWylotu,
        DataPrzylotu = i.DataPrzylotu,
        PrzewidywanaDataPrzylotu = i.PrzewidywanaDataPrzylotu
    FROM Lot l
    JOIN inserted i ON l.NumerLotu = i.NumerLotu;
END;


UPDATE Lot
SET NumerLotu = 'NowyNumer'
WHERE NumerLotu = '1';
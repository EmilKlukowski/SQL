--1. Procedura używa kursora, który sprawdza wszystkie daty z tabeli ObslugaBagazu. Jeżeli początek zmiany jest
-- wczesniej niz koniec to wypisuje dane. Jezeli nie to zamienia te daty ze sobą.


CREATE OR REPLACE PROCEDURE SprawdzIZamienZmianyDaty AS

    CURSOR c_obs_baga IS
        SELECT NumerGrupy, PoczatekZmiany, KoniecZmiany
        FROM ObslugaBagazu;
    v_numer_grupy     ObslugaBagazu.NumerGrupy%TYPE;
    v_poczatek_zmiany ObslugaBagazu.PoczatekZmiany%TYPE;
    v_koniec_zmiany   ObslugaBagazu.KoniecZmiany%TYPE;

BEGIN

    OPEN c_obs_baga;


    LOOP
        FETCH c_obs_baga INTO v_numer_grupy, v_poczatek_zmiany, v_koniec_zmiany;

        EXIT WHEN c_obs_baga%NOTFOUND;


        IF v_poczatek_zmiany > v_koniec_zmiany THEN
            DBMS_OUTPUT.PUT_LINE('Zamiana dat dla grupy' || v_numer_grupy);


            UPDATE ObslugaBagazu
            SET PoczatekZmiany = v_koniec_zmiany,
                KoniecZmiany   = v_poczatek_zmiany
            WHERE NUMERGRUPY = v_numer_grupy;

            COMMIT;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Dane poprawne dla: ' ||
                                 'NumerGrupy: ' || v_numer_grupy ||
                                 ', PoczatekZmiany: ' || v_poczatek_zmiany ||
                                 ', KoniecZmiany: ' || v_koniec_zmiany);

        END IF;
    END LOOP;


    CLOSE c_obs_baga;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Wystapil blad: ' || SQLERRM);
        ROLLBACK;
END SprawdzIZamienZmianyDaty;
/

call SprawdzIZamienZmianyDaty();




--2. Procedura bierze ID lotniska i usuwa związaną z nim lokalizację i miasto. Np. gdyby zamknęło się lotnisko, to
--nie potrzebujemy tego miasta i lokalizacji w bazie danych

CREATE OR REPLACE PROCEDURE UsunLotniskoZRazemZLokalizacjaIMiastem(
    p_LotniskoID IN VARCHAR2)
IS
BEGIN

    DELETE FROM Lokalizacja
    WHERE Id IN (SELECT Lokalizacja_Id FROM Lotnisko WHERE ID = p_LotniskoID);


    DELETE FROM Miasto
    WHERE ID IN (SELECT Miasto_ID FROM Lokalizacja WHERE Id IN (SELECT Lokalizacja_Id FROM Lotnisko WHERE ID = p_LotniskoID));

    DELETE FROM Lotnisko
    WHERE ID = p_LotniskoID;

    DBMS_OUTPUT.PUT_LINE('Poprawnie usunięto Lotnisko o numerze id: ' || p_LotniskoID);
END UsunLotniskoZRazemZLokalizacjaIMiastem;

call UsunLotniskoZRazemZLokalizacjaIMiastem(1);

--3. Wyzwalacz SprawdzLoty, sprawdza poprawność wprowadzonych do tabeli lot danych.
-- Jeśli data wylotu --jest późniejsza od daty przylotu lub lotniska wylotu i przylotu są takie same, --będzie błąd.

CREATE OR REPLACE TRIGGER SprawdzLoty
BEFORE INSERT OR UPDATE ON Lot
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.DataWylotu >= :NEW.DataPrzylotu THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data wylotu nie może być późniejsza lub równa dacie przylotu!');
    END IF;

    IF :NEW.LOTNISKOPRZYLOTU = :NEW.LOTNISKOWYLOTU THEN
        RAISE_APPLICATION_ERROR(-20001, 'Lotnisko przylotu nie może być takie same jak lotnisko wylotu!');
    END IF;
END;

UPDATE LOT
SET DATAWYLOTU = TO_DATE('2023-05-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS')
WHERE numerLotu = 1;



--4 Wyzwalacz Znizka sprawdza czy nowy pasażer jest/był pracownikiem linii. Jeśli tak to dostaje znizkę na lot.

CREATE OR REPLACE TRIGGER Znizka
BEFORE INSERT OR UPDATE ON PASAZER
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM PRACOWNIKLINIILOTNICZYCH
    WHERE PESEL = :NEW.PESEL;

    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Pasazer jest lub był pracownikiem linii lotniczych. Znizka 5%.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pasazer nie jest lub nie był pracownikiem linii lotniczych. Brak znizki.');
    END IF;
END;

Update PASAZER
SET imie = 'Andriej'
WHERE PESEL = 95011371382;


--Zad 1
--Napisz prosty program w Transact-SQL. Zadeklaruj zmiennÄ…, przypisz na tÄ… zmiennÄ… liczbÄ™ 
--rekordĂłw z tabeli T_Osoba i wypisz uzyskany wynik uĹĽywajÄ…c instrukcji PRINT, w postaci 
--napisu np. "W tabeli jest 6 osĂłb".

Declare @liczbaOsob INT

SELECT @liczbaOsob = COUNT(*) FROM T_Osoba

PRINT 'W tabeli jest ' + CAST(@liczbaOsob AS VARCHAR) + ' osob'


--Zad 2
--Policz liczbÄ™ osĂłb z tabeli T_Osoba. JeĹ›li liczba jest mniejsza niĹĽ 7, wstaw nowego 
--czĹ‚owieka â€śThomas Theramenesâ€ť i wypisz komunikat o jego dodaniu. W przeciwnym 
--wypadku wypisz komunikat informujÄ…cy o tym, ĹĽe nie wstawiono danych. Niech Id nowego
--czĹ‚owieka przyjmie wartoĹ›Ä‡ najwiÄ™kszego istniejÄ…cego id + 1 z tej tabeli.


Declare @liczbaOsob INT

SELECT @liczbaOsob = COUNT(*) FROM T_Osoba

IF @liczbaOsob < 7
BEGIN
    Declare @MaxId INT
    SELECT @MaxId = (Max(Id)) FROM T_Osoba


    INSERT INTO T_Osoba(Id, Imie, Nazwisko)
    VALUES(@MaxId+1, 'Thomas', 'Theramenes')

    PRINT N'Dodano nowÄ… osobÄ™: Thomas Theramenes'
END
ELSE
BEGIN
    PRINT N'Nie wystawiono danych, tabela ma juz 7 lub wiecej'
END



--Zad 3
--Napisz procedurę „ProduktyTanszeNiz”, która zwróci poprzez ResultSet nazwy i ceny wszystkich produktów
--z ceną mniejszą od wartości podanej w parametrze. 


Create PROCEDURE ProduktyTanszeNiz
    @PodanaCena money
AS
Begin
    Select Nazwa, Cena
    FROM T_Produkt
    WHERE Cena > @PodanaCena;
end

exec ProduktyTanszeNiz 10

--Zad 4
--Napisz procedurę„AktualizacjaCeny”,która będzie zwiększać cenę wszystkich produktów o wartość podaną w parametrze.
-- Jeśli wartość nie zostanie podana to domyślnie zwiększamy cenę o 0.01(korzystając z parametru DEFAULT).
--Dodatkowo wypisz komunikat z informacją o liczbie zmodyfikowanych rekordów „Ilość zaktualizowanych rekordów:”
-- używając do tego zmiennej systemowej @@ROWCOUNT.W procedurze wyłącz komunikat o liczbie wierszy,
-- które brały udział w operacji (SET NOCOUNT ON).

Create PROCEDURE AktualizacjaCeny
    @PodanaCena money = 0.01
AS
    Begin
        SET NOCOUNT ON;

        Update T_Produkt
        Set Cena = Cena + @PodanaCena

        PRINT 'Ilosc zaktualizowanych rekordow to: ' +
              CAST(@@ROWCOUNT AS NVARCHAR(10))
    end


exec AktualizacjaCeny 2


--Zad 5
--Napisz procedurę„NowyZakup”, która będzie rejestrować nowy zakup dla danego klienta z dzisiejszą datą.Nasza procedura ma przyjmować id --klienta i zwracać Id stworzonego zakupu w parametrze OUTPUT korzystając ze zmiennej systemowej@@IDENTITY.Dodatkowo wewnątrz procedury --chcemy wypisywać informację „Zarejestrowano nowy zakup o id : [id]”.Klucz główny „id” w tabeli T_Zakup ma właściwość IDENTITY, dlatego --przy dodawaniu rekordu nie podajemytejwartości, bo zostanie ona automatycznie wygenerowana.


Create PROCEDURE NowyZakup
    @IdKlienta int,
    @IdNowegoZakupu int OUTPUT
AS
Begin
    Insert into T_Zakup (Data, Klient)
    VALUES (GETDATE(), @IdKlienta);

    SET @IdNowegoZakupu = @@IDENTITY;
PRINT 'Zarejestrowano nowy zakup o id: ' + CAST(@IdNowegoZakupu AS NVARCHAR(10));
end


exec NowyZakup 6


--Zad 6
--Kontynuując zadanie 5 napisz procedurę „DodajProduktDoZakupu”, która doda produkt do danego zakupu. Jako parametry procedura ma przyjmować --Id produktu, Ilość oraz Id zakupu, który otrzymamy z procedury „NowyZakup” poprzez parametr OUTPUT. Należysprawdzić czy produkt i zakup o --podanym id istniejąi czy ilość jest większa od 0, jeśli nie to wypisujemy odpowiedni komunikat i kończymy procedurę. W przeciwnym razie --dodajemy produkt do zakupu i wypisujemy: „Do zakupu [id] dodano produkt [id], w ilości: [ilość]”.


CREATE procedure DodajProduktDoZakupu
    @IdProduktu int,
    @Ilosc int,
    @IdZakupu int
AS
    Begin
        IF not exists(SELECT 1 From T_Produkt where
        Id = @IdProduktu)
        begin
            Print 'Produkt o podanym ID nie istnieje'
            RETURN;
        end

        IF not exists(SELECT 1 From T_Zakup where
        Id = @IdZakupu)
        begin
            Print 'Zakup o podanym ID nie istnieje'
            RETURN;
        end

        IF @Ilosc <= 0
        Begin
            print 'Ilosc musi byc wieksza od 0'
        end

        INSERT into T_ListaProduktow(Zakup, Produkt, Ilosc)
        VALUES (@IdZakupu, @IdProduktu, @Ilosc);

        PRINT 'Do zakupu ' + CAST(@IdZakupu AS NVARCHAR(10)) + ' dodano produkt ' + CAST(@IdProduktu AS NVARCHAR(10)) +
          ', w ilości: ' + CAST(@Ilosc AS NVARCHAR(10));

    end



DECLARE @IdNowegoZakupu int;


EXEC NowyZakup @IdKlienta = 3, @IdNowegoZakupu OUTPUT;


EXEC DodajProduktDoZakupu @IdProduktu = 3, @Ilosc = 13, @IdZakupu = @IdNowegoZakupu;
EXEC DodajProduktDoZakupu @IdProduktu = 1, @Ilosc = 6, @IdZakupu = @IdNowegoZakupu;



--Zad 7
--Napisz procedurę „DanePracownika”, która będzie przyjmować Id pracownika i zwracać jego --Imię i Nazwisko przy użyciu parametru OUTPUT. --Jeśli pracownik o podanym Id nie istnieje --powinniśmy zwracać o tym informacje: “Pracownik o podanym id nie istnieje

CREATE PROCEDURE DanePracownika
    @IdPracownika int,
    @ImieNazwisko nvarchar(100) OUTPUT
AS
BEGIN
    -- Sprawdz, czy pracownik o podanym Id istnieje
    IF NOT EXISTS (SELECT 1 FROM T_Pracownik WHERE Id = @IdPracownika)
    BEGIN
        SET @ImieNazwisko = 'Pracownik o podanym id nie istnieje.';
        RETURN;
    END

    -- Pobierz Imie i Nazwisko pracownika o podanym Id
    SELECT @ImieNazwisko = Imie + ' ' + Nazwisko
    FROM T_Osoba
    WHERE Id = @IdPracownika;
END

--Zad 8
--Napisz procedure sluzaca do wstawiania produktów do tabeli Produkt. Procedura bedzie pobierac jako parametry: nazwe, cene oraz kategorie nowego produktu. Nalezy sprawdzic, --czy produkt o takiej nazwie juz istnieje. Jezeli istnieje, to nie wstawiamy nowego rekordu. Nalezy tez sprawdzic czy podana kategoria istnieje, jesli nie to nie dodajemy --rekordu i wypisujemy komunikat: „Podana kategoria nie istnieje, produkt nie zostal dodany”. Niech Id nowego produktu przyjmie wartosc najwiekszego istniejacego id + 1 z tej --tabeli.


Create procedure wstawianieProduktow
    @Nazwa varchar(50),
    @CenaProduktu money,
    @KategoriaProduktu varchar(50)
AS
    BEGIN
        DECLARE @IdNowegoProduktu int;

        If EXISTS(SELECT 1 From T_Produkt where Nazwa = @Nazwa)
        Begin
            Print 'Taki produkt istnieje'
            RETURN
        end

        If NOT EXISTS(SELECT 1 From T_Kategoria where Nazwa = @KategoriaProduktu)
        Begin
            Print N'Podana kategoria nie istnieje, produkt nie zostal dodany'
            RETURN
        end

        SELECT @IdNowegoProduktu = MAX(Id) + 1 From T_Produkt

        INSERT INTO T_Produkt (Id, Nazwa, Cena, Kategoria)
        VALUES (@IdNowegoProduktu, @Nazwa, @CenaProduktu, (SELECT Id from T_Kategoria WHERE Nazwa = @KategoriaProduktu));
        PRINT 'Dodano nowy produkt o nazwie: ' + @Nazwa + ', do kategorii: ' + @KategoriaProduktu;

    END



--Zad 9
--Napisz procedure która zaktualizuje stanowisko danego pracownika. Procedura ma przypisac pracownika do nowego stanowiska z dzisiejsza data, i jednoczesnie wypisac go ze --starego stanowiska równiez z dzisiejsza data (wartosc “Do” w tabeli T_Zatrudnienie).Jako argumenty procedura powinna przyjmowac @Id_pracownika i @Id_stanowiska. Jesli --pracownik jest aktualnie przypisany na podane stanowisko, to nie dodajemy go ponownie tylko wpisujemyinformacje „Pracownik jest juz przypisany na to stanowisko”.Jesli --pracownik lub stanowisko o podanym id nie istnieje wypisujemy o tym informacje i konczymy procedure.Stanowisko dla danego pracownika mozna zmieniac tylko raz dziennie, jesli --dzisiejsza data istnieje juz w kolumnie „Do” w tabeli T_Zatrudnienie dla danego pracownika, wtedy nie aktualizujemy jego stanowiska i wypisujemy informacje: „Zmiany nie --zostaly zapisane, stanowisko mozna aktualizowac tylko raz dziennie”. W procedurze wylacz komunikat o liczbie wierszy, które braly udzial w operacji(SET NOCOUNT ON).


Create procedure AktualizujStanowiskoPracownika
    @IdPracownika int,
    @IdStanowiska int
AS
    Begin
        Set Nocount ON;

        Declare @dzisiejszaData date = GETDATE();

        IF NOT EXISTS (SELECT 1 FROM T_Pracownik WHERE Id = @IdPracownika)
        BEGIN
            PRINT 'Pracownik o podanym Id nie istnieje.';
            RETURN;
        END

        IF NOT EXISTS (SELECT 1 FROM T_Stanowisko WHERE Id = @Id_stanowiska)
        BEGIN
            PRINT 'Stanowisko o podanym Id nie istnieje.';
            RETURN;
        END

        IF EXISTS(Select 1 FROM T_Zatrudnienie WHERE Pracownik = @IdPracownika AND Stanowisko = @IdStanowiska)
            Begin
                PRINT N'Pracownik jest juz przypisany na to stanowisko.';
            end

        IF EXISTS(Select 1 FROM T_Zatrudnienie WHERE Pracownik = @IdPracownika AND Do = @dzisiejszaData)
            Begin
                PRINT N'Dzisiejsza data juz istnieje. Stanowisko dla danego pracownika mozna zmieniac tylko raz dziennie'
            end

        UPDATE T_Zatrudnienie
        SET Do = @dzisiejszaData
        WHERE Pracownik = @IdPracownika AND Do IS NULL

        INSERT INTO T_Zatrudnienie(Pracownik, Stanowisko, Od)
        VALUES (@IdPracownika, @IdStanowiska, @dzisiejszaData);

    END

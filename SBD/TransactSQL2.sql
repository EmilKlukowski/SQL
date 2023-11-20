--Zad 1
--Przy pomocy kursora przejrzyj wszystkie produkty(tabela T_Produkt)izmodyfikuj cenytak, aby produkty droĹĽsze niĹĽ$2 staniaĹ‚y o 10%, a produkty taĹ„sze niĹĽ $1 podroĹĽaĹ‚y o 5%. 
--Dla kaĹĽdego zmienionego rekordu wypisz informacjÄ™: â€žCena {nazwa_produktu} zostaĹ‚a zmieniona na: {nowa_cena}$â€ť. Wykorzystaj pÄ™tlÄ™ WHILEi zmiennÄ… systemowÄ….
--@@Fetch_status.CenÄ™zaokrÄ…glij do 2 miejsc po przecinku.


Declare produktCursor CURSOR FOR
SElECT Id, Nazwa, Cena
FROM T_Produkt

DECLARE @ProductId int, @ProductName varchar(50), @OldPrice money, @NewPrice money;

OPEN produktCursor;

FETCH NEXT FROM produktCursor INTO @ProductId, @ProductName, @OldPrice;

WHILE @@FETCH_STATUS = 0
begin
    IF @OldPrice > 2
        SET @NewPrice = ROUND(@OldPrice*0.9, 2);
    ELSE IF @OldPrice < 1
        SET @NewPrice = ROUND(@OldPrice * 1.05, 2);
    ELSE SET @NewPrice = @OldPrice;

    UPDATE T_Produkt
    SET Cena = @NewPrice
    WHERE Id = @ProductId;

    PRINT 'Cena ' + @ProductName + ' zostaĹ‚a zmieniona na: ' + CAST(@NewPrice AS varchar(10)) + '$';

    FETCH NEXT FROM produktCursor INTO @ProductId, @ProductName, @OldPrice;
end

CLOSE produktCursor;
DEALLOCATE produktCursor;



--Zad 2 Przerób kod z zadania 1 na proceduręwykorzystującą kursortak, aby wartości cen produktów do obniżki i podwyżkinie były stałe,
--tylko były parametrami procedury.Nie korzystaj z IF-a, zamiast tego użyj CASE.


CREATE PROCEDURE ZmienCenyProduktow
    @ObnizkaProcent decimal(5,2),
    @PodwyzkaProcent decimal(5,2)
AS
BEGIN
   
    DECLARE produktCursor CURSOR FOR
    SELECT Id, Nazwa, Cena
    FROM T_Produkt;

    DECLARE @IdProduktu int, @NazwaProduktu varchar(50), @StaraCena money, @NowaCena money;

    OPEN produktCursor;

    FETCH NEXT FROM produktCursor INTO @IdProduktu, @NazwaProduktu, @StaraCena;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @NowaCena =
            CASE
                WHEN @StaraCena > 2 THEN ROUND(@StaraCena * (1 - @ObnizkaProcent), 2) --obnizka o x%
                WHEN @StaraCena < 1 THEN ROUND(@StaraCena * (1 + @PodwyzkaProcent), 2) -- podwyzka o x%
                ELSE @StaraCena
            END;
    
        UPDATE T_Produkt
        SET Cena = @NowaCena
        WHERE Id = @IdProduktu;

        PRINT 'Cena ' + @NazwaProduktu + ' została zmieniona na: ' + CAST(@NowaCena AS varchar(10)) + '$';

        FETCH NEXT FROM produktCursor INTO @IdProduktu, @NazwaProduktu, @StaraCena;
    END

    CLOSE produktCursor;
    DEALLOCATE produktCursor;
END


--Zad 3 Utwórz nowe zlecenie zaopatrzenia sklepu (tabela T_Zaopatrzenie) z dzisiejszą datą.Następnie,korzystając z kursora,przypisz do tego
  --zlecenia wszystkie produkty, które sprzedały się w więcej niż 10 sztukach w grudniu 2022. W T_ZaopatrzenieProdukt jako ilość podaj
  --dwukrotność sprzedanej ilości sztuk danego produktu zgrudnia2022. Po dodaniu każdego produktu wypisz informację: „Zamówiono produkt o ID=
  --{id} w ilości= {ilość}”.Nie korzystaj z IF-a.Podpowiedź: Najpierw należyutworzyć nowy rekord w tabeli T_Zaopatrzeniei przechwycić id
  --używając zmiennej systemowej @@Identity(PK ma właściwość Identity). Następnie przy użyciu kursora należy wstawić do tabeli --T_ZaopatrzenieProduktrekordy dla produktów, które nas interesują.


CREATE PROCEDURE ZaopatrzenieSklepu
AS
    Begin
        SET NOCOUNT ON;

        Insert into T_Zaopatrzenie(Data)
        Values (GETDATE())

        DECLARE @IdZaopatrzenia int = @@IDENTITY, @IdProduktu int, @Ilosc int

        DECLARE kursor CURSOR FOR
        SELECT Produkt, SUM(Ilosc) AS Ilosc
        FROM T_ListaProduktow
        JOIN T_Zakup on T_Zakup.Id = Zakup
        WHERE MONTH(Data) = 12 AND YEAR(Data) = 2022
        GROUP BY Produkt
        HAVING SUM(Ilosc)>10

        Open kursor

        FETCH next FROM kursor into @IdProduktu, @Ilosc

        While @@fetch_status = 0
        Begin
            Insert into T_ZaopatrzenieProdukt(Zaopatrzenie, Produkt, Ilosc)
            VALUES (@IdZaopatrzenia, @IdProduktu, @Ilosc*2)

            PRINT ('Zamowiono produkt o ID=' + Cast(@IdProduktu as Varchar(5)) + 'w ilosci' +
                  Cast(@Ilosc*2 as varchar(5)));
            FETCH Next from kursor into @IdProduktu, @Ilosc;
        end
        CLOSE kursor;
        DEALLOCATE kursor;
    end





--Zad 4  Dodaj kolumnę „Bonus” typu moneyz opcją NULLdo tabeli T_Pracownik. Następnie, korzystając z kursora, przypisz wartość
      --bonusukażdemu aktualnie zatrudnionemu pracownikowi. Bonus jest wyliczany na podstawie stażu w miesiącach i wynosi: pensja *
      --ilość_miesięcy/100. Jestonprzyznawany tylko osobom, które pracowały co najmniej6 miesięcy inie może wynieść więcej niż 30% pensji.Stwórz
      --perspektywę przechowującą id_pracownika i jego staż w miesiącach, która będzie wykorzystywana przez kursor. Po dodaniu bonusu wypisz 
      --informację: „Pracownik od id= {id} ma przypisanybonus w wysokości= {bonus} % pensji”.Na przykład: -bonus dla pracownika, który
      --przepracował 35 miesięcy wyniesie 30% pensji-bonus dla pracownika, który przepracował 27 miesięcy wyniesie 27% pensji-pracownik, który 
      --przepracował tylko 3 miesiące nie dostanie bonusuPodpowiedź: Do obliczenia stażu w miesiącach użyj funkcji DATEDIFF(). Aktualnie
      --zatrudnieni pracownicy mają przynajmniej jednego NULLa w kolumnie „Do”w tabeli T_Zatrudnienie. Jako datę rozpoczęcia pracy należy uznać 
      --najwcześniejszą datę „Od”z tabeli T_Zatrudnieniedla danego pracownika, biorąc pod uwagę wszystkie stanowiska na których pracował. Jako 
      --datę końcową należy uznać dzisiejszą datę (funkcja GETDATE()).


CREATE VIEW StazPracownikow(Pracownik, Staz)
AS
SELECT pracownik, DATEDIFF(MONTH, MIN(od), getdate()) as Staz
FROM T_Zatrudnienie
WHERE pracownik IN (SELECT pracownik FROM T_Zatrudnienie WHERE Do IS NULL)
group by pracownik

SET NOCOUNT ON;

DECLARE bonusPracownikow CURSOR for
SELECT pracownik,
    CASE
        WHEN STAZ<5 THEN NULL
        WHEN STAZ>30 THEN 30
        ELSE Staz
        END AS Bonus
FROM StazPracownikow

DECLARE @IdPracownika int, @Bonus int;
Open bonusPracownikow;
FETCH NEXT FROM bonusPracownikow INTO @IdPracownika, @Bonus;
WHILE @@FETCH_STATUS = 0
    begin
        UPDATE T_Pracownik
        SET bonus = ROUND(pensja*(@Bonus/100), 2)
        Where id = @IdPracownika AND @Bonus IS NOT NULL
        PRINT ('Pracownik o id' + CAST(@IdPracownika as varchar(5)) + ' ma przypisany bonus' +
               ' w wysokosci: ' + CAST(@Bonus as VARCHAR(5)) + '% pensji.')

        FETCH NEXT FROM bonusPracownikow INTO @IdPracownika, @Bonus
    end

CLose bonusPracownikow;
DEALLOCATE bonusPracownikow;




--Zad 5 Dodaj kolumnę „Ulubiony_produkt” typu intz opcją NULLdo tabeli T_Osoba.Następnie, korzystając z kursora,jako wartośćulubionego
--produktuprzypisz produkt, który dana osoba kupiła w największej ilości we wszystkich zakupach. Po dodaniu produktu wypisz informację:
--„Dodano ulubiony produkt o id= {id} dla osoby o id= {id}”.Tworzenie kolumny Ulubiony_produkt: ALTERTABLET_OsobaADDUlubiony_produkt 
--intnull,CONSTRAINTFK_Osoba_Produkt FOREIGNKEY (Ulubiony_produkt)REFERENCEST_Produkt(Id);Po dodaniu danych poniższe zapytanie powinno 
--zwracać wynik widoczny na obrazku:SELECTo.nazwisko,p.nazwa AS"ulubiony produkt"FROMT_Osoba o LEFTJOINT_Produkt p ONo.ulubiony_produkt=p.id;


Declare ulubionyProdukt CURSOR FOR
SELECT osoba.Id, produkt.id
FROM T_Osoba
JOIN T_Zakup ON T_Osoba.Id = T_Zakup.Klient
JOIN T_ListaProduktow on T_Zakup.Id = T_ListaProduktow.Zakup
JOIN T_Produkt on T_ListaProduktow.Produkt = T_Produkt.Id
WHERE produkt.id = (SELECT TOP (1) lp2.Produkt
                    FROM T_Zakup z2
                    JOIN T_ListaProduktow lp2 ON z2.Id = lp2.zakup
                    WHERE osoba.id = z2.Klient
                    GROUP BY lp2.Produkt
                    ORDER BY SUM(lp2.Ilosc) DESC
                    )
GROUP BY osoba.id, Produkt.id;

SET NOCOUNT ON;

DECLARE @IdOsoby int, @IdProduktu int;


Open ulubionyProdukt
FETCH NEXT FROM ulubionyProdukt INTO @IdOsoby, @IdProduktu;

WHILE @@FETCH_STATUS = 0
begin
    UPDATE T_Osoba
    SET Ulubiony_produkt = @IdProduktu
    WHERE id = @IdOsoby
    PRINT('Dodano ulubiony produkt o id= ' + CAST(@IdProduktu as VARCHAR(5)) + ' dla osoby o id= ' +
          CAST(@IdOsoby as VARCHAR(5)));
    FETCH NEXT FROM ulubionyProdukt INTO @IdOsoby, @IdProduktu;
end

close ulubionyProdukt
deallocate ulubionyProdukt;












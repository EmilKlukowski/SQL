--1. ZnajdĹş wszystkie osoby ktĂłrych nazwiska nie zaczynajÄ… siÄ™ od 'E' lub 'P'. Posortuj alfabetycznie po nazwiskach. 

SELECT * FROM T_OSOBA
WHERE NAZWISKO NOT LIKE 'E%' AND NAZWISKO NOT LIKE 'P%';


--2. Wypisz nazwÄ™ i cenÄ™ najdroĹĽszego produktu. 

SELECT NAZWA, CENA FROM T_PRODUKT
WHERE  CENA = (SELECT MAX(CENA) FROM T_PRODUKT)


--3. UĹĽywajÄ…c operatora NOT EXISTS wypisz osoby ktĂłre nigdy nie zrobiĹ‚y ĹĽadnych zakupĂłw. 

SELECT * FROM T_OSOBA O
WHERE NOT EXISTS (
    SELECT * FROM T_ZAKUP Z
    WHERE Z.KLIENT = O.ID
);


--4.1 KorzystajÄ…c z kwantyfikatora ALL wypisz nazwÄ™ i cenÄ™ tych produktĂłw, ktĂłre kosztujÄ… wiÄ™cej niĹĽ najdroĹĽszy produkt z kategorii 'fruit'

SELECT NAZWA, CENA FROM T_PRODUKT
WHERE CENA > ALL (
    SELECT MAX(CENA) FROM T_PRODUKT
    JOIN T_KATEGORIA on T_KATEGORIA.ID = T_PRODUKT.KATEGORIA
    WHERE T_KATEGORIA.NAZWA = 'fruit'
    )


--4.2 KorzystajÄ…c z kwantyfikatora ANY wypisz nazwÄ™ i cenÄ™ tych produktĂłw, ktĂłre kosztujÄ… wiÄ™cej niĹĽ najtaĹ„szy produkt z kategorii 'vegetable';

SELECT NAZWA, CENA FROM T_PRODUKT
WHERE CENA > ANY (
    SELECT MIN(CENA) FROM T_PRODUKT
    JOIN T_KATEGORIA on T_KATEGORIA.ID = T_PRODUKT.KATEGORIA
    WHERE T_KATEGORIA.NAZWA = 'vegetable'
    )


--5. Wypisz wszystkie produkty wraz z ich iloĹ›ciÄ… i kategoriÄ… z zakupu o ID == 4. Posortuj malejÄ…co po iloĹ›ci. 

SELECT * FROM T_PRODUKT
JOIN T_LISTAPRODUKTOW TL on T_PRODUKT.ID = TL.PRODUKT
join T_KATEGORIA TK on T_PRODUKT.KATEGORIA = TK.ID
join T_ZAKUP TZ on TL.ZAKUP = TZ.ID
WHERE TZ.ID = 4
ORDER BY ILOSC DESC


--6. Wypisz wszystkich aktualnie zatrudnionych pracowników, ich aktualne stanowiska oraz datę 
--od kiedy pracują na tym stanowisku. Posortuj rosnąco po dacie.

SELECT Osoba.imie || ' ' || Osoba.nazwisko AS Pracownik , Stanowisko.nazwa AS Stanowisko, Zatrudnienie.Od AS Od
FROM T_Zatrudnienie Zatrudnienie JOIN T_Stanowisko Stanowisko ON Zatrudnienie.stanowisko = Stanowisko.id
JOIN T_Pracownik Pracownik ON Zatrudnienie.pracownik = Pracownik.id
JOIN T_Osoba Osoba ON Osoba.id = Pracownik.id
WHERE Zatrudnienie.do IS NULL
ORDER BY Od;


--7. Wypisz imiona i nazwiska wszystkich pracowników aktualnie zatrudnionych (nazwij kolumnę 
--"Pracownik") + nazwisko ich szefa (nazwij kolumnę "Szef"). Jeśli ktoś nie ma szefa to wypisz 
--"No boss" w kolumnie "Szef". Podpowiedź: użyj UNION.  

SELECT Osoba.imie || ' ' || Osoba.nazwisko AS Pracownik, Szef.nazwisko AS Szef
FROM T_Pracownik Pracownik
JOIN T_Osoba Osoba ON Osoba.id = Pracownik.id
JOIN T_Osoba Szef ON Szef.id = Pracownik.szef
JOIN T_Zatrudnienie Zatrudnienie ON Zatrudnienie.pracownik = Pracownik.id
WHERE Pracownik.szef IS NOT NULL AND Zatrudnienie.Do IS NULL

UNION

SELECT Osoba.imie || ' ' || Osoba.nazwisko, 'No boss'
FROM T_Pracownik Pracownik JOIN T_Osoba Osoba ON Osoba.id = Pracownik.id
JOIN T_Zatrudnienie Zatrudnienie ON Zatrudnienie.pracownik = Pracownik.id
WHERE Pracownik.szef IS NULL AND Zatrudnienie.Do IS NULL;



--8. Oblicz w ilu zakupach zostały kupione produkty z kategorii 'fruit'. Wypisz nazwę produktu +
--ilość zakupów w których dany produkt został zakupiony.

SELECT Produkt.nazwa AS Produkt, COUNT(*) AS "ILOSC ZAKUPOW"
FROM T_Produkt Produkt
JOIN T_ListaProduktow ON Produkt.id = T_ListaProduktow.produkt
JOIN T_Zakup ON T_ListaProduktow.zakup = T_Zakup.id
JOIN T_Kategoria Kategoria ON Produkt.kategoria = Kategoria.id
WHERE Kategoria.nazwa = 'fruit'
GROUP BY Produkt.nazwa;


--9. Oblicz ile zakupów zrobił każdy z klientów w 2020 i 2021 roku. 

SELECT IMIE || ' ' || NAZWISKO AS KLIENT, COUNT(*) as Zakupy
FROM T_OSOBA
JOIN T_ZAKUP ON T_OSOBA.ID = T_ZAKUP.KLIENT
WHERE EXTRACT(YEAR FROM T_ZAKUP.DATA) IN (2020, 2021)
group by IMIE, NAZWISKO



--10. Wypisz klientów oraz ilość zakupionych przez nich ryb, jeśli kupili ich więcej niż 20. 

SELECT IMIE || ' ' || NAZWISKO AS KLIENT, SUM(T_LISTAPRODUKTOW.ILOSC) AS ILOSCRYB
FROM T_OSOBA
JOIN T_ZAKUP ON T_ZAKUP.KLIENT = T_OSOBA.ID
JOIN T_LISTAPRODUKTOW ON T_LISTAPRODUKTOW.ZAKUP = T_ZAKUP.ID
JOIN T_PRODUKT ON T_PRODUKT.ID = T_LISTAPRODUKTOW.PRODUKT
JOIN T_KATEGORIA ON T_KATEGORIA.ID = T_PRODUKT.KATEGORIA
WHERE T_KATEGORIA.NAZWA = 'fish'
group by IMIE, NAZWISKO
HAVING SUM(T_LISTAPRODUKTOW.ILOSC)>20;


--11. Wypisz wszystkie produkty wraz z ich ilością i kategorią które kupił szef Peter-a Paches-a (we
--wszystkich swoich zakupach). Posortuj po ilości rosnąco. 

SELECT PRODUKT.NAZWA AS NAZWA, KATEGORIA.NAZWA AS KATEGORIA, SUM(T_LISTAPRODUKTOW.ILOSC) AS ILOSC
FROM T_PRODUKT PRODUKT
JOIN T_KATEGORIA KATEGORIA on KATEGORIA.ID = PRODUKT.KATEGORIA
JOIN T_LISTAPRODUKTOW ON PRODUKT.ID = T_LISTAPRODUKTOW.PRODUKT
JOIN T_ZAKUP ON T_LISTAPRODUKTOW.ZAKUP = T_ZAKUP.ID
JOIN T_OSOBA ON T_ZAKUP.KLIENT = T_OSOBA.ID
WHERE KLIENT = (SELECT T_PRACOWNIK.SZEF
                    FROM T_PRACOWNIK
                    JOIN T_OSOBA ON T_OSOBA.ID = T_PRACOWNIK.ID
                    WHERE IMIE = 'Peter' AND NAZWISKO = 'Paches'
                )
group by PRODUKT.NAZWA, KATEGORIA.NAZWA
order by ILOSC ASC


--12. Wypisz wszystkie produkty jakie kupił Chris Cnemus i ile łącznie wydał na każdy z tych
--produktów (we wszystkich zakupach). 


SELECT PRODUKT.NAZWA, SUM(T_LISTAPRODUKTOW.ILOSC*CENA) || 'zł' AS WARTOSC
FROM T_PRODUKT PRODUKT
JOIN T_LISTAPRODUKTOW ON PRODUKT.ID = T_LISTAPRODUKTOW.PRODUKT
JOIN T_ZAKUP on T_LISTAPRODUKTOW.ZAKUP = T_ZAKUP.ID
JOIN T_OSOBA ON T_ZAKUP.KLIENT = T_OSOBA.ID
WHERE IMIE = 'Chris' AND NAZWISKO = 'Cnemus'
group by PRODUKT.NAZWA
ORDER BY WARTOSC


--13. Znajdź wszystkich klientów którzy wydali więcej niż 50 zł na zakupy w naszym sklepie. Wypisz
--imię i nazwisko klienta + sumę pieniędzy jaką wydał we wszystkich swoich zakupach. 

SELECT IMIE || ' ' || NAZWISKO AS KLIENT, SUM(T_LISTAPRODUKTOW.ILOSC*CENA) || ' ZŁ'AS WARTOSC
FROM T_OSOBA
JOIN T_ZAKUP ON T_OSOBA.ID = T_ZAKUP.KLIENT
JOIN T_LISTAPRODUKTOW on T_ZAKUP.ID = T_LISTAPRODUKTOW.ZAKUP
JOIN T_PRODUKT ON T_LISTAPRODUKTOW.PRODUKT = T_PRODUKT.ID
group by IMIE, NAZWISKO
HAVING SUM(T_LISTAPRODUKTOW.ILOSC*CENA)>50
ORDER BY WARTOSC




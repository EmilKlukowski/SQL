--INSERTY DLA T_SQL

--SAMOLOT =================================
INSERT INTO SAMOLOT (NumerSamolotu, Typ, LiczbaMiejsc)
VALUES ('1', 'komercyjny', 220);

INSERT INTO SAMOLOT (NumerSamolotu, Typ, LiczbaMiejsc)
VALUES ('2', 'prywatny', 20);

INSERT INTO SAMOLOT (NumerSamolotu, Typ, LiczbaMiejsc)
VALUES ('3', 'komercyjny', 200);

INSERT INTO SAMOLOT (NumerSamolotu, Typ, LiczbaMiejsc)
VALUES ('4', 'komercyjny', 250);

INSERT INTO SAMOLOT (NumerSamolotu, Typ, LiczbaMiejsc)
VALUES ('5', 'komercyjny', 180);



--MIASTO ==================================

INSERT INTO MIASTO (ID, NazwaMiasta)
VALUES(1, 'Warszawa');

INSERT INTO MIASTO (ID, NazwaMiasta)
VALUES(2, 'Kraków');

INSERT INTO MIASTO (ID, NazwaMiasta)
VALUES(3, 'Radom');

INSERT INTO MIASTO (ID, NazwaMiasta)
VALUES(4, 'Gdańsk');

INSERT INTO MIASTO (ID, NazwaMiasta)
VALUES(5, 'Szczecin');



--LOKALIZACJA =========================

INSERT INTO LOKALIZACJA (Id, Miasto_ID, Ulica, Numer, KodPocztowy)
VALUES (1, 1, 'ŻWIRKI I WIGURY', '1', '00001');

INSERT INTO LOKALIZACJA (Id, Miasto_ID, Ulica, Numer, KodPocztowy)
VALUES (2, 2, 'MILA', '2', '00002');

INSERT INTO LOKALIZACJA (Id, Miasto_ID, Ulica, Numer, KodPocztowy)
VALUES (3, 3, 'MALINOWA', '3', '00003');

INSERT INTO LOKALIZACJA (Id, Miasto_ID, Ulica, Numer, KodPocztowy)
VALUES (4, 4, 'POGODNA', '4', '00004');

INSERT INTO LOKALIZACJA (Id, Miasto_ID, Ulica, Numer, KodPocztowy)
VALUES (5, 5, 'WESOLA', '5', '00005');


--LOTNISKO ====================================

INSERT INTO LOTNISKO (ID, Wielkosc, Lokalizacja_Id)
VALUES ('1', 'DUZE', 1);

INSERT INTO LOTNISKO (ID, Wielkosc, Lokalizacja_Id)
VALUES ('2', 'DUZE', 2);

INSERT INTO LOTNISKO (ID, Wielkosc, Lokalizacja_Id)
VALUES ('3', 'DUZE', 3);

INSERT INTO LOTNISKO (ID, Wielkosc, Lokalizacja_Id)
VALUES ('4', 'MALE', 4);

INSERT INTO LOTNISKO (ID, Wielkosc, Lokalizacja_Id)
VALUES ('5', 'MALE', 5);

--PASAZER ================================

INSERT INTO PASAZER (PESEL, IMIE, NAZWISKO)
VALUES('95011371382', 'Andrzej', 'Marciniak');

INSERT INTO PASAZER (PESEL, IMIE, NAZWISKO)
VALUES('04291482662', 'Cyprian', 'Jaworski');

INSERT INTO PASAZER (PESEL, IMIE, NAZWISKO)
VALUES('83010569365', 'Rafał ', 'Sokołowski');

INSERT INTO PASAZER (PESEL, IMIE, NAZWISKO)
VALUES('59050327687', 'Mikołaj ', 'Sikora');

INSERT INTO PASAZER (PESEL, IMIE, NAZWISKO)
VALUES('70120517874', 'Dawid', 'Wysocki');


--BAGAZPODR =============================


INSERT INTO BAGAZPODRECZNY (numerbagazupodr)
VALUES (1);

INSERT INTO BAGAZPODRECZNY (numerbagazupodr)
VALUES (2);

INSERT INTO BAGAZPODRECZNY (numerbagazupodr)
VALUES (3);

INSERT INTO BAGAZPODRECZNY (numerbagazupodr)
VALUES (4);

INSERT INTO BAGAZPODRECZNY (numerbagazupodr)
VALUES (5);


--PRACOWNIKLINIILOTNICZYCH =========================================
INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('68012391023','Tomasz','Hejowski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('65020123912','Roman','Mistrz');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('65011868452','Roman','Wysocki');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('63072852355','Robert','Baranowski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('83062818387','Heronim','Wasilewska');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('86012662258','Alan','Czerwiński');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('91032345861','Łukasz','Jasiński');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('00301714769','Marek','Wysocki');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('80010674116','Krzysztof','Sobczak');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('69072348386','Kordian','Witkowski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('70032267966','Borys','Pawlak');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('53091524269','Olgierd','Chmielewski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('79111452585','Alojzy','Gajewska');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('72061143141','Konstanty','Andrzejewski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('53100823639','Dorian','Stępień');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('72022293292','Kazimierz','Michalak');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('01230852931','Bartłomiej','Kowalski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('02230957886','Roman','Wysocki');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('69111897741','Gniewomir','Kowalski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('78011626676','Bronisław','Jankowski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('55120679236','Czesław','Kwiatkowski');

INSERT INTO pracownikliniilotniczych (PESEL, IMIE, NAZWISKO)
VALUES('62120647431','Heronim','Jaworski');

--BAGAZREJESTROWANY =========================================

INSERT INTO bagazrejestrowany (numerbagazurej, WAGA, WYMIARY)
VALUES (1, 15, '40X30X15');

INSERT INTO bagazrejestrowany (numerbagazurej, WAGA, WYMIARY)
VALUES (2, 17, '40X40X15');

INSERT INTO bagazrejestrowany (numerbagazurej, WAGA, WYMIARY)
VALUES (3, 19, '40X40X20');

INSERT INTO bagazrejestrowany (numerbagazurej, WAGA, WYMIARY)
VALUES (4, 11, '40X20X15');

INSERT INTO bagazrejestrowany (numerbagazurej, WAGA, WYMIARY)
VALUES (5, 18, '40X40X15');



--OBSLUGABAGAZU ==========================

INSERT INTO OBSLUGABAGAZU (NUMERGRUPY, POCZATEKZMIANY, KONIECZMIANY, PRACOWNIKPESEL, NRBAGAZUREJ)
VALUES ('1', CONVERT(datetime2, '2023-05-05 07:00:00', 120), CONVERT(datetime2, '2023-05-05 15:00:00', 120), '68012391023', 1);

INSERT INTO OBSLUGABAGAZU (NUMERGRUPY, POCZATEKZMIANY, KONIECZMIANY, PRACOWNIKPESEL, NRBAGAZUREJ)
VALUES ('2', CONVERT(datetime2, '2023-05-05 15:00:00', 120), CONVERT(datetime2, '2023-05-05 23:00:00', 120), '65020123912', 2);

--PILOT ================================================

INSERT INTO PILOT (PRACOWNIKPESEL, NUMERLICENCJI)
VALUES ('00301714769', '1');

INSERT INTO PILOT (PRACOWNIKPESEL, NUMERLICENCJI)
VALUES ('80010674116', '2');

INSERT INTO PILOT (PRACOWNIKPESEL, NUMERLICENCJI)
VALUES ('69072348386', '3');

INSERT INTO PILOT (PRACOWNIKPESEL, NUMERLICENCJI)
VALUES ('70032267966', '4');

INSERT INTO PILOT (PRACOWNIKPESEL, NUMERLICENCJI)
VALUES ('53091524269', '5');


--LOT ====================================================

INSERT INTO LOT (NUMERLOTU, DATAWYLOTU, DATAPRZYLOTU, PRZEWIDYWANADATAPRZYLOTU, LOTNISKOWYLOTU, LOTNISKOPRZYLOTU, SAMOLOT_NUMERSAMOLOTU, PILOT_PRACOWNIKPESEL)
VALUES ('1', CONVERT(datetime2, '2023-05-05 11:00:00', 120), CONVERT(datetime2, '2023-04-05 13:30:00', 120), CONVERT(datetime2, '2023-04-05 13:15:00', 120), '1', '2', '1', '00301714769'),
       ('2', CONVERT(datetime2, '2023-05-05 11:15:00', 120), CONVERT(datetime2, '2023-05-05 13:00:00', 120), CONVERT(datetime2, '2023-05-05 13:00:00', 120), '2', '3', '2', '80010674116'),
       ('3', CONVERT(datetime2, '2023-05-05 12:00:00', 120), CONVERT(datetime2, '2023-05-05 14:00:00', 120), CONVERT(datetime2, '2023-05-05 14:05:00', 120), '3', '4', '3', '69072348386'),
       ('4', CONVERT(datetime2, '2023-05-05 17:00:00', 120), CONVERT(datetime2, '2023-05-05 18:00:00', 120), CONVERT(datetime2, '2023-05-05 17:50:00', 120), '4', '5', '4', '70032267966'),
       ('5', CONVERT(datetime2, '2023-05-05 21:00:00', 120), CONVERT(datetime2, '2023-05-05 22:30:00', 120), CONVERT(datetime2, '2023-05-05 22:30:00', 120), '5', '1', '5', '53091524269');

--WIELELOTOW =====================================

INSERT INTO wielelotow (Id, NumerLotu, Pasazer, nrbagazupodrecznego, nrbagazurejestrowanego)
values(1, '1', '95011371382', 1, 1);

INSERT INTO wielelotow (Id, NumerLotu, Pasazer, nrbagazupodrecznego, nrbagazurejestrowanego)
values(2, '2', '04291482662', 2, 2);

INSERT INTO wielelotow (Id, NumerLotu, Pasazer, nrbagazupodrecznego, nrbagazurejestrowanego)
values(3, '3', '83010569365', 3, 3);

INSERT INTO wielelotow (Id, NumerLotu, Pasazer, nrbagazupodrecznego, nrbagazurejestrowanego)
values(4, '4', '59050327687', 4, 4);

INSERT INTO wielelotow (Id, NumerLotu, Pasazer, nrbagazupodrecznego, nrbagazurejestrowanego)
values(5, '5', '70120517874', 5, 5);

--PRACOWNIKWSAMOLOCIE ===================================

INSERT INTO pracownikwsamolocie (pracownikpesel, nrlicencji)
VALUES ('79111452585', 1);

INSERT INTO pracownikwsamolocie (pracownikpesel, nrlicencji)
VALUES ('72061143141', 2);

INSERT INTO pracownikwsamolocie (pracownikpesel, nrlicencji)
VALUES ('53100823639', 3);

INSERT INTO pracownikwsamolocie (pracownikpesel, nrlicencji)
VALUES ('72022293292', 4);

INSERT INTO pracownikwsamolocie (pracownikpesel, nrlicencji)
VALUES ('01230852931', 5);

--ZALOGA ====================================

INSERT INTO ZALOGA (idgrupy, LOT_NUMERLOTU, PRACOWNIKPESEL)
VALUES (1, '1', 79111452585);

INSERT INTO ZALOGA (idgrupy, LOT_NUMERLOTU, PRACOWNIKPESEL)
VALUES (2, '2', 72061143141);

INSERT INTO ZALOGA (idgrupy, LOT_NUMERLOTU, PRACOWNIKPESEL)
VALUES (3, '3', 53100823639);

INSERT INTO ZALOGA (idgrupy, LOT_NUMERLOTU, PRACOWNIKPESEL)
VALUES (4, '4', 72022293292);

INSERT INTO ZALOGA (idgrupy, LOT_NUMERLOTU, PRACOWNIKPESEL)
VALUES (5, '5', 01230852931);


--KRL ======================================================

INSERT INTO KRL (pracownikpesel, numerlicencji, numerlotu)
VALUES ('02230957886', '1', '1');

INSERT INTO KRL (pracownikpesel, numerlicencji, numerlotu)
VALUES ('69111897741', '2', '2');

INSERT INTO KRL (pracownikpesel, numerlicencji, numerlotu)
VALUES ('78011626676', '3', '3');

INSERT INTO KRL (pracownikpesel, numerlicencji, numerlotu)
VALUES ('55120679236', '4', '4');

INSERT INTO KRL (pracownikpesel, numerlicencji, numerlotu)
VALUES ('62120647431', '5', '5');
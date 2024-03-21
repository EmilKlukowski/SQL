ALTER TABLE Zaloga DROP CONSTRAINT Zaloga_PracownikWSamolocie;
ALTER TABLE Zaloga DROP CONSTRAINT Zaloga_Lot;
ALTER TABLE WieleLotow DROP CONSTRAINT Table_18_Pasazer;
ALTER TABLE WieleLotow DROP CONSTRAINT Table_18_Lot;
ALTER TABLE WieleLotow DROP CONSTRAINT Table_18_BagazRejestrowany;
ALTER TABLE WieleLotow DROP CONSTRAINT Table_18_BagazPodreczny;
ALTER TABLE ObslugaBagazu DROP CONSTRAINT ObslugaBagazuPracownik;
ALTER TABLE ObslugaBagazu DROP CONSTRAINT ObslugaBagazuBagazRej;
ALTER TABLE Lotnisko DROP CONSTRAINT Lotnisko_Lokalizacja;
ALTER TABLE Lot DROP CONSTRAINT LotniskoWylotu;
ALTER TABLE Lot DROP CONSTRAINT LotniskoPrzylotu;
ALTER TABLE Lot DROP CONSTRAINT Lot_Samolot;
ALTER TABLE Lot DROP CONSTRAINT Lot_Pilot;
ALTER TABLE Lokalizacja DROP CONSTRAINT Lokalizacja_Miasto;
ALTER TABLE KRL DROP CONSTRAINT KRL_Lot;
ALTER TABLE KRL DROP CONSTRAINT PracownikKRL;



DROP TABLE WieleLotow;
DROP TABLE Zaloga;
DROP TABLE ObslugaBagazu;
DROP TABLE Pasazer;
DROP TABLE Pilot;
DROP TABLE PracownikWSamolocie;
DROP TABLE Samolot;
DROP TABLE PracownikLiniiLotniczych;
DROP TABLE KRL;
DROP TABLE Lotnisko;
DROP TABLE Lot;
DROP TABLE Lokalizacja;
DROP TABLE Miasto;
DROP TABLE BagazRejestrowany;
DROP TABLE BagazPodreczny;

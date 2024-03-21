-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-12-20 17:29:34.153
-- CREATE DLA T-SQL
-- tables
-- Table: BagazPodreczny
CREATE TABLE BagazPodreczny (
    NumerBagazuPodr integer  NOT NULL,
    CONSTRAINT BagazPodreczny_pk PRIMARY KEY (NumerBagazuPodr)
) ;

-- Table: BagazRejestrowany
CREATE TABLE BagazRejestrowany (
    NumerBagazuRej integer  NOT NULL,
    Waga integer  NOT NULL,
    Wymiary varchar(20)  NOT NULL,
    CONSTRAINT BagazRejestrowany_pk PRIMARY KEY (NumerBagazuRej)
) ;

-- Table: KRL
CREATE TABLE KRL (
    PracownikPesel char(11)  NOT NULL,
    NumerLicencji varchar(10)  NOT NULL,
    NumerLotu varchar(10)  NOT NULL,
    CONSTRAINT KRL_pk PRIMARY KEY (PracownikPesel)
) ;

-- Table: Lokalizacja
CREATE TABLE Lokalizacja (
    Id integer  NOT NULL,
    Miasto_ID integer  NOT NULL,
    Ulica varchar(50)  NOT NULL,
    Numer varchar(4)  NOT NULL,
    KodPocztowy char(5)  NOT NULL,
    CONSTRAINT Lokalizacja_pk PRIMARY KEY (Id)
) ;

-- Table: Lot
CREATE TABLE Lot (
    NumerLotu varchar(10)  NOT NULL,
    DataWylotu datetime2  NOT NULL,
    DataPrzylotu datetime2  NOT NULL,
    PrzewidywanaDataPrzylotu datetime2  NOT NULL,
    LotniskoWylotu varchar(10)  NOT NULL,
    LotniskoPrzylotu varchar(10)  NOT NULL,
    Samolot_NumerSamolotu varchar(10)  NOT NULL,
    Pilot_PracownikPesel char(11)  NOT NULL,
    CONSTRAINT Lot_pk PRIMARY KEY (NumerLotu)
) ;

-- Table: Lotnisko
CREATE TABLE Lotnisko (
    ID varchar(10)  NOT NULL,
    Wielkosc varchar(10)  NOT NULL,
    Lokalizacja_Id integer  NOT NULL,
    CONSTRAINT Lotnisko_pk PRIMARY KEY (ID)
) ;

-- Table: Miasto
CREATE TABLE Miasto (
    ID integer  NOT NULL,
    NazwaMiasta varchar(40)  NOT NULL,
    CONSTRAINT Miasto_pk PRIMARY KEY (ID)
) ;

-- Table: ObslugaBagazu
CREATE TABLE ObslugaBagazu (
    NumerGrupy char(5)  NOT NULL,
    PoczatekZmiany datetime2  NOT NULL,
    KoniecZmiany datetime2  NOT NULL,
    PracownikPesel char(11)  NOT NULL,
    NrBagazuRej integer  NOT NULL,
    CONSTRAINT ObslugaBagazu_pk PRIMARY KEY (NumerGrupy)
) ;

-- Table: Pasazer
CREATE TABLE Pasazer (
    Pesel char(11)  NOT NULL,
    Imie varchar(20)  NOT NULL,
    Nazwisko varchar(30)  NOT NULL,
    CONSTRAINT Pasazer_pk PRIMARY KEY (Pesel)
) ;

-- Table: Pilot
CREATE TABLE Pilot (
    PracownikPesel char(11)  NOT NULL,
    NumerLicencji varchar(10)  NOT NULL,
    CONSTRAINT Pilot_pk PRIMARY KEY (PracownikPesel)
) ;

-- Table: PracownikLiniiLotniczych
CREATE TABLE PracownikLiniiLotniczych (
    Pesel char(11)  NOT NULL,
    Imie varchar(30)  NOT NULL,
    Nazwisko varchar(50)  NOT NULL,
    CONSTRAINT PracownikLiniiLotniczych_pk PRIMARY KEY (Pesel)
) ;

-- Table: PracownikWSamolocie
CREATE TABLE PracownikWSamolocie (
    PracownikPesel char(11)  NOT NULL,
    NrLicencji integer  NOT NULL,
    CONSTRAINT PracownikWSamolocie_pk PRIMARY KEY (PracownikPesel)
) ;

-- Table: Samolot
CREATE TABLE Samolot (
    NumerSamolotu varchar(10)  NOT NULL,
    Typ varchar(20)  NOT NULL,
    LiczbaMiejsc integer  NOT NULL,
    CONSTRAINT Samolot_pk PRIMARY KEY (NumerSamolotu)
) ;

-- Table: WieleLotow
CREATE TABLE WieleLotow (
    Id integer  NOT NULL,
    NumerLotu varchar(10)  NOT NULL,
    Pasazer char(11)  NOT NULL,
    NrBagazuPodrecznego integer  NOT NULL,
    NrBagazuRejestrowanego integer  NOT NULL,
    CONSTRAINT WieleLotow_pk PRIMARY KEY (Id)
) ;

-- Table: Zaloga
CREATE TABLE Zaloga (
    IdGrupy integer  NOT NULL,
    Lot_NumerLotu varchar(10)  NOT NULL,
    PracownikPesel char(11)  NOT NULL,
    CONSTRAINT Zaloga_pk PRIMARY KEY (IdGrupy)
) ;

-- foreign keys
-- Reference: KRL_Lot (table: KRL)
ALTER TABLE KRL ADD CONSTRAINT KRL_Lot
    FOREIGN KEY (NumerLotu)
    REFERENCES Lot (NumerLotu);

-- Reference: Lokalizacja_Miasto (table: Lokalizacja)
ALTER TABLE Lokalizacja ADD CONSTRAINT Lokalizacja_Miasto
    FOREIGN KEY (Miasto_ID)
    REFERENCES Miasto (ID);

-- Reference: Lot_Pilot (table: Lot)
ALTER TABLE Lot ADD CONSTRAINT Lot_Pilot
    FOREIGN KEY (Pilot_PracownikPesel)
    REFERENCES Pilot (PracownikPesel);

-- Reference: Lot_Samolot (table: Lot)
ALTER TABLE Lot ADD CONSTRAINT Lot_Samolot
    FOREIGN KEY (Samolot_NumerSamolotu)
    REFERENCES Samolot (NumerSamolotu);

-- Reference: LotniskoPrzylotu (table: Lot)
ALTER TABLE Lot ADD CONSTRAINT LotniskoPrzylotu
    FOREIGN KEY (LotniskoWylotu)
    REFERENCES Lotnisko (ID);

-- Reference: LotniskoWylotu (table: Lot)
ALTER TABLE Lot ADD CONSTRAINT LotniskoWylotu
    FOREIGN KEY (LotniskoPrzylotu)
    REFERENCES Lotnisko (ID);

-- Reference: Lotnisko_Lokalizacja (table: Lotnisko)
ALTER TABLE Lotnisko ADD CONSTRAINT Lotnisko_Lokalizacja
    FOREIGN KEY (Lokalizacja_Id)
    REFERENCES Lokalizacja (Id);

-- Reference: ObslugaBagazuBagazRej (table: ObslugaBagazu)
ALTER TABLE ObslugaBagazu ADD CONSTRAINT ObslugaBagazuBagazRej
    FOREIGN KEY (NrBagazuRej)
    REFERENCES BagazRejestrowany (NumerBagazuRej);

-- Reference: ObslugaBagazuPracownik (table: ObslugaBagazu)
ALTER TABLE ObslugaBagazu ADD CONSTRAINT ObslugaBagazuPracownik
    FOREIGN KEY (PracownikPesel)
    REFERENCES PracownikLiniiLotniczych (Pesel);

-- Reference: PracownikKRL (table: KRL)
ALTER TABLE KRL ADD CONSTRAINT PracownikKRL
    FOREIGN KEY (PracownikPesel)
    REFERENCES PracownikLiniiLotniczych (Pesel);

-- Reference: PracownikPilot (table: Pilot)
ALTER TABLE Pilot ADD CONSTRAINT PracownikPilot
    FOREIGN KEY (PracownikPesel)
    REFERENCES PracownikLiniiLotniczych (Pesel);

-- Reference: PracownikWSamolocie (table: PracownikWSamolocie)
ALTER TABLE PracownikWSamolocie ADD CONSTRAINT PracownikWSamolocie
    FOREIGN KEY (PracownikPesel)
    REFERENCES PracownikLiniiLotniczych (Pesel);

-- Reference: Table_18_BagazPodreczny (table: WieleLotow)
ALTER TABLE WieleLotow ADD CONSTRAINT Table_18_BagazPodreczny
    FOREIGN KEY (NrBagazuPodrecznego)
    REFERENCES BagazPodreczny (NumerBagazuPodr);

-- Reference: Table_18_BagazRejestrowany (table: WieleLotow)
ALTER TABLE WieleLotow ADD CONSTRAINT Table_18_BagazRejestrowany
    FOREIGN KEY (NrBagazuRejestrowanego)
    REFERENCES BagazRejestrowany (NumerBagazuRej);

-- Reference: Table_18_Lot (table: WieleLotow)
ALTER TABLE WieleLotow ADD CONSTRAINT Table_18_Lot
    FOREIGN KEY (NumerLotu)
    REFERENCES Lot (NumerLotu);

-- Reference: Table_18_Pasazer (table: WieleLotow)
ALTER TABLE WieleLotow ADD CONSTRAINT Table_18_Pasazer
    FOREIGN KEY (Pasazer)
    REFERENCES Pasazer (Pesel);

-- Reference: Zaloga_Lot (table: Zaloga)
ALTER TABLE Zaloga ADD CONSTRAINT Zaloga_Lot
    FOREIGN KEY (Lot_NumerLotu)
    REFERENCES Lot (NumerLotu);

-- Reference: Zaloga_PracownikWSamolocie (table: Zaloga)
ALTER TABLE Zaloga ADD CONSTRAINT Zaloga_PracownikWSamolocie
    FOREIGN KEY (PracownikPesel)
    REFERENCES PracownikWSamolocie (PracownikPesel);

-- End of file.


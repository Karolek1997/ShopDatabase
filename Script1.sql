-- Stworzenie tabeli nadrzędnej Produkt
CREATE TABLE [dbo].[Produkt](
	[ProduktID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[KategoriaProduktuID] [int] NOT NULL,
	[ProducentID] [int] NOT NULL,
	[ModelID] [int] NOT NULL,
	[RozmiarID] [int] NOT NULL,
	[KolorID] [int] NOT NULL,
	[DostepnoscID] [int] NOT NULL);
 
 -- Stworzenie tabeli podrzędnej KategoriaProduktu
CREATE TABLE [dbo].[KategoriaProduktu] (
	[KategoriaProduktuID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[NazwaKategorii] [nvarchar](50) NOT NULL,
	CONSTRAINT UQ_NazwaKategorii UNIQUE (NazwaKategorii));

-- Stworzenie tabeli podrzędnej Dostepnosc
CREATE TABLE [dbo].[Dostepnosc](
	[DostepnoscID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[DostepnaIlosc] [int] NULL);
 
-- Stworzenie tabeli Kolor +  dodanie unikalności dla NazwyKoloru
CREATE TABLE [dbo].[Kolor](
	[KolorID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[NazwaKoloru] [nvarchar](50) NOT NULL,
CONSTRAINT [UC_NazwaKoloru] UNIQUE ([NazwaKoloru]));
 
-- Stworzenie tabeli Producent + dodanie unikalności dla NazwyProducenta
CREATE TABLE [dbo].[Producent](
	[ProducentID] [int] IDENTITY(1,1)PRIMARY KEY  NOT NULL,
	[NazwaProducenta] [nvarchar](50) NOT NULL,
CONSTRAINT [UC_NazwaProducenta] UNIQUE ([NazwaProducenta]));
 
-- Stworzenie tabeli Rozmiar
CREATE TABLE [dbo].[Rozmiar](
	[RozmiarID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[KategoriaProduktuID] [int] NOT NULL,
	[Rozmiar] [nvarchar](50) NOT NULL);
 
-- Dodanie unikalności dla Rozmiaru w zależności od KategoriaProduktuID
ALTER TABLE Rozmiar
ADD CONSTRAINT UC_RozmiarObuwia UNIQUE (KategoriaProduktuID, Rozmiar);
 
-- Stworzenie tabeli Model
CREATE TABLE [dbo].[Model](
	[ModelID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[KategoriaProduktuID] [int] NOT NULL,
	[NazwaModelu] [nvarchar](50) NOT NULL,
	[OpisModelu] [nvarchar](1000) NULL);

-- Stworzenie tabeli Cena
CREATE TABLE [dbo].[Cena](
	[ProduktID] [int],
	[CenaNetto] [decimal] (9, 2) NULL,
	[StawkaVAT] [int] NULL,
	[CenaBrutto] [decimal](9, 2) NULL);
 
-- Dodanie unikalności ProduktID w tabeli Cena, aby jeden produkt miał wyłącznie jedną cenę
ALTER TABLE Cena
ADD CONSTRAINT UQ_Cena_ProduktID UNIQUE (ProduktID);
 
-- Konkretny produkt musi mieć także konkretną cenę
ALTER TABLE [dbo].[Cena]
ADD CONSTRAINT FK_Produkt_Cena
FOREIGN KEY ([ProduktID]) REFERENCES [dbo].[Produkt]([ProduktID]);

-- Dodanie relacji do tabeli nadrzędnej określającą kategorieproduktu
ALTER TABLE [dbo].[Produkt]
ADD CONSTRAINT FK_Produkt_KategoriaProduktu
FOREIGN KEY ([KategoriaProduktuID]) REFERENCES [dbo].[KategoriaProduktu]([KategoriaProduktuID]);
 
-- Dodanie relacji do tabeli nadrzędnej określającą producenta produktu
ALTER TABLE [dbo].[Produkt]
ADD CONSTRAINT FK_Produkt_Producent
FOREIGN KEY ([ProducentID]) REFERENCES [dbo].[Producent]([ProducentID]);
 
-- Dodanie relacji do tabeli nadrzędnej określającą model
ALTER TABLE [dbo].[Produkt]
ADD CONSTRAINT FK_Produkt_Model
FOREIGN KEY ([ModelID]) REFERENCES [dbo].[Model]([ModelID]);
 
-- Dodanie relacji do tabeli nadrzędnej określającą rozmiar
ALTER TABLE [dbo].[Produkt]
ADD CONSTRAINT FK_Produkt_Rozmiar
FOREIGN KEY ([RozmiarID]) REFERENCES [dbo].[Rozmiar]([RozmiarID]);
 
-- Dodanie relacji do tabeli nadrzędnej określającą kolor
ALTER TABLE [dbo].[Produkt]
ADD CONSTRAINT FK_Produkt_Kolor
FOREIGN KEY ([KolorID]) REFERENCES [dbo].[Kolor]([KolorID]);

-- Dodanie relacji do tabeli nadrzędnej określającą dostępność
ALTER TABLE [dbo].[Produkt]
ADD CONSTRAINT FK_Produkt_Dostepnosc
FOREIGN KEY ([DostepnoscID]) REFERENCES [dbo].[Dostepnosc]([DostepnoscID]);

-- Uzaleźnienie Modelu od Kategorii Produktu, aby np. w przyszłości nie wyświetlały się modele butów w modelach innych produktów np. koszulek
ALTER TABLE [dbo].[Model]
ADD CONSTRAINT FK_Model_KategoriaProduktu
FOREIGN KEY ([KategoriaProduktuID]) REFERENCES [dbo].[KategoriaProduktu]([KategoriaProduktuID]);
 
-- Dodanie unikalności do modelu w zaleźności od KategoriiProduktu
ALTER TABLE [dbo].[Model]
ADD CONSTRAINT [UC_Model_Kategoria_NazwaModelu] UNIQUE ([KategoriaProduktuID], [NazwaModelu]);
 
  -- Uzaleźnienie Rozmiaru od Kategorii Produktu, aby np. w przyszłości nie wyświetlały się rozmiary butów w rozmiarach innych produktów np. koszulek
ALTER TABLE [dbo].[Rozmiar]
ADD CONSTRAINT FK_Rozmiar_KategoriaProduktu
FOREIGN KEY ([KategoriaProduktuID]) REFERENCES [dbo].[KategoriaProduktu]([KategoriaProduktuID]);

-- Stworzenie tabeli klient + włączenie unikalności adresów email i loginów
CREATE TABLE [dbo].[Klient](
	[KlientID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[login] [nvarchar] (50) NOT NULL,
	[Imie] [nvarchar] (50) NOT NULL,
	[Nazwisko] [nvarchar] (50) NOT NULL,
	[Email] [nvarchar] (50) NOT NULL,
	[NumerTelefonu] [char](9) NOT NULL,
CONSTRAINT [UC_Login] UNIQUE([Login]),
CONSTRAINT [UC_Email] UNIQUE ([Email]));
  
-- Stworzenie tabeli Adres + połączenie z tabelą Klient na zasadzie jeden klient wiele adresów
CREATE TABLE [dbo].[Adres](
	[AdresID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[MiastoID] [int] NOT NULL,
	[KodPocztowyID] [int] NOT NULL,
	[NumerBudynku] [int] NOT NULL,
	[NumerLokalu] [int] NOT NULL,
	[KlientID] [int] NOT NULL,
FOREIGN KEY (KlientID) REFERENCES Klient(KlientID));
 
-- Stworzenie tabeli Zamowienia + połączenie z tabelą Klient na zasadzie jeden klient wiele zamówień oraz z tabelą Adres na zasadzie jeden adres wiele zamówień
CREATE TABLE [dbo].[Zamowienia](
	[ZamowienieID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[KlientID] [int] NOT NULL,
	[DataZamowienia] [date] NOT NULL,
	[WartoscZamowienia] [int] NOT NULL,
	[AdresID] [int] NOT NULL,
	[StatusZamowienia] [nvarchar] (50) NOT NULL,
FOREIGN KEY (KlientID) REFERENCES Klient(KlientID),
FOREIGN KEY (AdresID) REFERENCES Adres(AdresID));

-- Stworzenie tabeli ZamowioneProdukty + połączenie z tabelami Zamowienia i Produkt na zasadzie klucza obcego złożonego przy uwzględnieniem nowego ZamowioneProduktyID dla kolejnych kombinacji
CREATE TABLE [dbo].[ZamowioneProdukty](
	[ZamowioneProduktyID] [int] IDENTITY(1,1) NOT NULL,
	[ZamowienieID] [int] NOT NULL,
	[ProduktID] [int] NOT NULL,
	[IloscZamowionychProduktow] [int] NOT NULL,
	[WartoscZamowionychProduktow] [int] NOT NULL,
PRIMARY KEY (ZamowienieID, ProduktID),
FOREIGN KEY (ZamowienieID) REFERENCES Zamowienia(ZamowienieID),
FOREIGN KEY (ProduktID) REFERENCES Produkt(ProduktID));
 
-- Stworzenie tabeli KodPocztowy, nadanie unikalnosci dla kodu pocztowego
CREATE TABLE [dbo].[KodPocztowy](
	[KodPocztowyID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[KodPocztowy] [char](6)  NOT NULL,
	[MiastoID] [int],
CONSTRAINT [UC_KodPocztowy] UNIQUE ([KodPocztowy]));   
  
-- Stworzenie tabeli Miasto
CREATE TABLE [dbo].[Miasto](
	[MiastoID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[NazwaMiasta] [nvarchar] (50) NOT NULL,
	[KrajID] [int] NOT NULL,
	[UlicaID] [int] NOT NULL);      	
 
-- Stworzenie tabeli Kraj, nadanie unikalnosci dla nazwy kraju
CREATE TABLE [dbo].[Kraj](
	[KrajID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[NazwaKraju] [nvarchar] (50) NOT NULL,
CONSTRAINT [UC_NazwaKraju] UNIQUE ([NazwaKraju]));
 
-- Stworzenie tabeli Ulica, nadanie unikalnosci dla nazwy ulicy
CREATE TABLE [dbo].[Ulica](
	[UlicaID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[NazwaUlicy] [nvarchar] (50) NOT NULL,
CONSTRAINT [UC_NazwaUlicy] UNIQUE ([NazwaUlicy]));
 
-- Polączenie tabeli KodPocztowy z tabela Miasto, tak aby kody pocztowe, były przypisane do konkretnych Miast
ALTER TABLE [dbo].[KodPocztowy]
ADD CONSTRAINT FK_Miasto_KodPocztowy
FOREIGN KEY ([MiastoID]) REFERENCES [dbo].[Miasto]([MiastoID]);
 
-- Polączenie tabeli Miasto z podrzędną tabelą Kraj
ALTER TABLE [dbo].[Miasto]
ADD CONSTRAINT FK_Miasto_Kraj
FOREIGN KEY ([KrajID]) REFERENCES [dbo].[Kraj]([KrajID]);
 
-- Polączenie tabeli Adres z podrzędną tabelą Miasto
ALTER TABLE [dbo].[Adres]
ADD CONSTRAINT FK_Adres_Miasto
FOREIGN KEY ([MiastoID]) REFERENCES [dbo].[Miasto]([MiastoID]);
 
-- Polączenie tabeli Adres z podrzędną tabelą KodPocztowy
 ALTER TABLE [dbo].[Adres]
ADD CONSTRAINT FK_Adres_Kod_Pocztowy
FOREIGN KEY ([KodPocztowyID]) REFERENCES [dbo].[KodPocztowy]([KodPocztowyID]);
 
-- Polączenie tabeli Miasto z podrzędną tabelą Ulica
ALTER TABLE [dbo].[Miasto]
ADD CONSTRAINT FK_Miasto_Ulica
FOREIGN KEY ([UlicaID]) REFERENCES [dbo].[Ulica]([UlicaID]);

-- END

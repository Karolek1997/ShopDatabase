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
CREATE TABLE [dbo].[KategoriaProduktu](
	[KategoriaProduktuID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[NazwaKategorii] [nvarchar](50) NOT NULL);
 
-- Stworzenie tabeli podrzędnej Dostepnosc
CREATE TABLE [dbo].[Dostepnosc](
	[DostepnoscID] [int] IDENTITY(1,1)PRIMARY KEY NOT NULL,
	[DostepnaIlosc] [int] NULL);
 
-- Stworzenie tabeli Kolor + dodanie unikalności dla NazwyKoloru
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
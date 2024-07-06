CREATE TABLE [dbo].[Informacjeoproduktach](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Nazwa] [nvarchar](255) NULL,
	[Podtytu³] [nvarchar](255) NULL,
	[Aktualna_cena] [float] NULL,
	[Pelna_cena] [float] NULL,
	[UnikalneID] [varchar](255) NULL,
	[Dostepnosc] [bit] NULL);

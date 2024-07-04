-- tabela do przechowywania informacji na temat produktow ze sklepu Nike
CREATE TABLE [dbo].[Informacjeoproduktach](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Nazwa] [nvarchar](255) NULL,
	[Podtytuł] [nvarchar](255) NULL,
	[Aktualna_cena] [float] NULL,
	[Pelna_cena] [float] NULL);
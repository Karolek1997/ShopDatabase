CREATE TABLE [dbo].[Informacjeoproduktach](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Nazwa] [nvarchar](255) NULL,
	[Podtytu³] [nvarchar](255) NULL,
	[Aktualna_cena] [float] NULL,
	[Pelna_cena] [float] NULL,
	[UnikalneID] [varchar](255) NULL,
	[Dostepnosc] [bit] NULL,
	[DataOd] [datetime2](7) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
	[DataDo] [datetime2](7) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
	PERIOD FOR SYSTEM_TIME (DataOd, DataDo)
	)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.Informacjeoproduktachhistory));
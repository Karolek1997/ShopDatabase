-- Procedura dodawania ceny do produktów w sklepie
CREATE PROCEDURE [dbo].[DodajCene]
    @KategoriaProduktuID INT,
    @NazwaModelu NVARCHAR(50),
    @CenaNetto DECIMAL(9, 2)
AS
BEGIN
    DECLARE @ModelID INT;
    DECLARE @ProduktID INT;
    DECLARE @NazwaKategorii NVARCHAR(50);

    -- Pobieram ModelID na podstawie NazwaModelu i KategoriaProduktuID
    SELECT @ModelID = ModelID
    FROM dbo.Model
    WHERE NazwaModelu = @NazwaModelu
      AND KategoriaProduktuID = @KategoriaProduktuID;

    IF @ModelID IS NULL
    BEGIN
        RETURN 0;
    END

    -- Pobieram NazwaKategorii na podstawie KategoriaProduktuID
    SELECT @NazwaKategorii = NazwaKategorii
    FROM dbo.KategoriaProduktu
    WHERE KategoriaProduktuID = @KategoriaProduktuID;

    -- Sprawdzam czy istnieje Produkt o danym ModelID i KategoriaProduktuID
    SELECT @ProduktID = ProduktID
    FROM dbo.Produkt
    WHERE ModelID = @ModelID
      AND KategoriaProduktuID = @KategoriaProduktuID;

    IF @ProduktID IS NULL
    BEGIN
        RETURN 0;
    END

    -- Dodaje lub aktualizuję cenę w tabeli Cena, jeśli jest już przypisana do produktu
    IF EXISTS (SELECT 1 FROM dbo.Cena WHERE ProduktID = @ProduktID)
    BEGIN
        UPDATE dbo.Cena
        SET CenaNetto = @CenaNetto
        WHERE ProduktID = @ProduktID;

        RETURN 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.Cena (ProduktID, CenaNetto)
        VALUES (@ProduktID, @CenaNetto);

        RETURN 1;
    END
END;


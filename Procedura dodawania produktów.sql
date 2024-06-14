-- Procedura dodawania produktów. @KategoriaProduktu i @Rozmiar nie przyjmuje domyslnie wartości NULL, ze względu na trigerry dotyczące tych parametrów
CREATE PROCEDURE InsertProduktow
    @KategoriaProduktu NVARCHAR(50),
    @Producent NVARCHAR(50) = NULL, 
    @Model NVARCHAR(50) = NULL,
    @Rozmiar NVARCHAR(10),
    @Kolor NVARCHAR(50) = NULL,
    @DostepnaIlosc INT = NULL
AS
BEGIN
    BEGIN TRY
-- Pobranie ID kategorii produktu
        DECLARE @KategoriaProduktuID INT;
        SELECT @KategoriaProduktuID = KategoriaProduktuID
        FROM KategoriaProduktu
        WHERE NazwaKategorii = @KategoriaProduktu;
        
-- Jeśli ID nie istnieje kończy procedurę
        IF @KategoriaProduktuID IS NULL
        BEGIN
            PRINT 'Błąd: Podana kategoria produktu nie istnieje.';
            RETURN;
        END;

-- Pobranie ID rozmiaru
        DECLARE @RozmiarID INT;
        SELECT @RozmiarID = RozmiarID
        FROM Rozmiar
        WHERE Rozmiar = @Rozmiar
        AND KategoriaProduktuID = @KategoriaProduktuID;

-- Jeśli rozmiar nie istnieje, dodaje go
        IF @RozmiarID IS NULL
        BEGIN
            INSERT INTO Rozmiar (KategoriaProduktuID, Rozmiar)
            VALUES (@KategoriaProduktuID, @Rozmiar);
            SELECT @RozmiarID = (SELECT TOP 1 RozmiarID FROM Rozmiar ORDER BY RozmiarID DESC);
        END;

-- Potwierdzenie że pobrano poprawne ID rozmiaru w zalezności od kategorii produktu
        IF @RozmiarID IS NULL
        BEGIN
            SELECT @RozmiarID = RozmiarID
            FROM Rozmiar
            WHERE Rozmiar = @Rozmiar
            AND KategoriaProduktuID = @KategoriaProduktuID;
        END;

-- Pobranie ID producenta
        DECLARE @ProducentID INT;
        SELECT @ProducentID = ProducentID
        FROM Producent
        WHERE NazwaProducenta = @Producent;

-- Jeśli producent nie istnieje, dodaje go
        IF @ProducentID IS NULL
        BEGIN
            INSERT INTO Producent (NazwaProducenta)
            VALUES (@Producent);
            SELECT @ProducentID = (SELECT TOP 1 ProducentID FROM Producent ORDER BY ProducentID DESC);
        END;

-- Pobranie ID modelu
        DECLARE @ModelID INT;
        SELECT @ModelID = ModelID
        FROM Model
        WHERE NazwaModelu = @Model
        AND KategoriaProduktuID = @KategoriaProduktuID;

-- Jeśli model nie istnieje, dodaje go
        IF @ModelID IS NULL
        BEGIN
            INSERT INTO Model (KategoriaProduktuID, NazwaModelu)
            VALUES (@KategoriaProduktuID, @Model);
            SELECT @ModelID = (SELECT TOP 1 ModelID FROM Model ORDER BY ModelID DESC); 
        END;

-- Pobranie ID koloru
        DECLARE @KolorID INT;
        SELECT @KolorID = KolorID
        FROM Kolor
        WHERE NazwaKoloru = @Kolor;

-- Jeśli kolor nie istnieje, dodaje go
        IF @KolorID IS NULL
        BEGIN
            INSERT INTO Kolor (NazwaKoloru)
            VALUES (@Kolor);
            SELECT @KolorID = (SELECT TOP 1 KolorID FROM Kolor ORDER BY KolorID DESC);
        END;

-- Pobranie DostepnoscID danego produktu, w przypadku kiedy już istnieje w bazie danych
        DECLARE @DostepnoscID INT;
        SELECT @DostepnoscID = DostepnoscID
        FROM Produkt
        WHERE KategoriaProduktuID = @KategoriaProduktuID
        AND ProducentID = @ProducentID
        AND ModelID = @ModelID
        AND RozmiarID = @RozmiarID
        AND KolorID = @KolorID;

-- Jesli dostepnośc nie istnieje to ją dodaje
        IF @DostepnoscID IS NOT NULL
        BEGIN

-- Aktualizacja dostępnej ilości danego produktu, jeśli juz istnieje w bazie danych
            UPDATE Dostepnosc
            SET DostepnaIlosc = DostepnaIlosc + @DostepnaIlosc
            WHERE DostepnoscID = @DostepnoscID;
            PRINT 'Dostępna ilość produktu została zaktualizowana.';
        END
        ELSE
        BEGIN

-- Wstawienie dostępnosci nowego produktu jeśli nie istnieje on w bazie
            INSERT INTO Dostepnosc (DostepnaIlosc)
            VALUES (@DostepnaIlosc);
            SELECT @DostepnoscID = (SELECT TOP 1 DostepnoscID FROM Dostepnosc ORDER BY DostepnoscID DESC);

-- Jeśli wszystko jest ok, dodaje parametry do tabeli Produkt
            INSERT INTO Produkt (KategoriaProduktuID, ProducentID, ModelID, RozmiarID, KolorID, DostepnoscID)
            VALUES (@KategoriaProduktuID, @ProducentID, @ModelID, @RozmiarID, @KolorID, @DostepnoscID);
            
            PRINT 'Nowy produkt został dodany do bazy danych sklepu.';
        END;
    END TRY
    BEGIN CATCH
        PRINT 'Wystąpił błąd. Produkt nie został dodany.';
    END CATCH
END;

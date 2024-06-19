-- Procedura generowania zamówienia z poziomu sql, jedno i wielo-produktowe
CREATE PROCEDURE GeneratorZamowienia (
    @KlientID INT,
    @ProduktID INT,
    @Ilosc INT,
    @CzyKoniec CHAR(3)
)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Klient WHERE KlientID = @KlientID)
    BEGIN
        RAISERROR ('Nieprawidłowy KlientID', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Produkt WHERE ProduktID = @ProduktID)
    BEGIN
        RAISERROR ('Nieprawidłowy ProduktID', 16, 1);
        RETURN;
    END

    DECLARE @Dostepnosc INT;
    DECLARE @DostepnoscID INT;

    SELECT @Dostepnosc = D.DostepnaIlosc, @DostepnoscID = D.DostepnoscID
    FROM Produkt P
    INNER JOIN Dostepnosc D ON P.DostepnoscID = D.DostepnoscID
    WHERE P.ProduktID = @ProduktID;

    IF @Dostepnosc < @Ilosc
    BEGIN
        RAISERROR ('Niewystarczająca ilość produktów dostępnych', 16, 1);
        RETURN;
    END

    DECLARE @CenaBrutto DECIMAL(9, 2);
    DECLARE @WartoscProduktu DECIMAL(9, 2);
    DECLARE @ZamowienieID INT;
    DECLARE @AdresID INT;

    SELECT @AdresID = AdresID FROM Adres WHERE KlientID = @KlientID;

    IF NOT EXISTS (SELECT 1 FROM Zamowienia WHERE KlientID = @KlientID AND StatusZamowienia = 'w trakcie')
    BEGIN

        INSERT INTO Zamowienia (KlientID, DataZamowienia, WartoscZamowienia, StatusZamowienia, AdresID)
        VALUES (@KlientID, GETDATE(), 0, 'w trakcie', @AdresID);

        SET @ZamowienieID = (SELECT MAX(ZamowienieID) FROM Zamowienia WHERE KlientID = @KlientID AND StatusZamowienia = 'w trakcie');

        SELECT @CenaBrutto = CenaBrutto FROM Cena WHERE ProduktID = @ProduktID;

        SET @WartoscProduktu = @CenaBrutto * @Ilosc;

        UPDATE Zamowienia
        SET WartoscZamowienia = @WartoscProduktu
        WHERE ZamowienieID = @ZamowienieID;
    END
    ELSE
    BEGIN
        SELECT @ZamowienieID = ZamowienieID
        FROM Zamowienia
        WHERE KlientID = @KlientID AND StatusZamowienia = 'w trakcie';

        SELECT @CenaBrutto = CenaBrutto
        FROM Cena
        WHERE ProduktID = @ProduktID;

        SET @WartoscProduktu = @CenaBrutto * @Ilosc;

        UPDATE Zamowienia
        SET WartoscZamowienia = WartoscZamowienia + @WartoscProduktu
        WHERE ZamowienieID = @ZamowienieID;
    END

    UPDATE Dostepnosc
    SET DostepnaIlosc = DostepnaIlosc - @Ilosc
    WHERE DostepnoscID = @DostepnoscID;

    INSERT INTO ZamowioneProdukty (ZamowienieID, ProduktID, IloscZamowionychProduktow, WartoscZamowionychProduktow)
    VALUES (@ZamowienieID, @ProduktID, @Ilosc, @WartoscProduktu);

    IF @CzyKoniec = 'Tak'
    BEGIN
        UPDATE Zamowienia
        SET StatusZamowienia = 'zakonczone'
        WHERE ZamowienieID = @ZamowienieID;
        PRINT 'Dziękujemy za dokonanie zamówienia';
    END
END;
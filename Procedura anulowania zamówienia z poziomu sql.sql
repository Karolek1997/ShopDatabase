-- Procedura anulowania zamowienia z poziomu sql, przywraca dostepnosc produktow, usuwa wpisy o zamowionych produktach
CREATE PROCEDURE AnulowanieZamowienia
    @KlientID INT,
    @ZamowienieID INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Zamowienia WHERE ZamowienieID = @ZamowienieID AND KlientID = @KlientID)
    BEGIN
        RAISERROR ('Zamówienie nie istnieje lub nie należy do klienta', 16, 1);
        RETURN;
    END

    UPDATE Dostepnosc
    SET DostepnaIlosc = DostepnaIlosc + zp.IloscZamowionychProduktow
    FROM Dostepnosc d
    JOIN Produkt p ON d.DostepnoscID = p.DostepnoscID
    JOIN ZamowioneProdukty zp ON p.ProduktID = zp.ProduktID
    WHERE zp.ZamowienieID = @ZamowienieID;

    DELETE FROM ZamowioneProdukty
    WHERE ZamowienieID = @ZamowienieID;

    UPDATE Zamowienia
    SET StatusZamowienia = 'anulowane'
    WHERE ZamowienieID = @ZamowienieID;

    PRINT 'Zamówienie zostało anulowane, a dostępność produktów została przywrócona.';
END;

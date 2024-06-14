-- Trigger sprawdzający dodawany rozmiar na podstawie tabeli walidacyjnej WalidacjaRozmiarow
CREATE TRIGGER SprawdzRozmiar
ON Rozmiar
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN KategoriaProduktu kp ON i.KategoriaProduktuID = kp.KategoriaProduktuID
        LEFT JOIN WalidacjaRozmiarow wr ON kp.NazwaKategorii = wr.NazwaKategorii
        WHERE CHARINDEX(i.Rozmiar, wr.DostepneRozmiary) = 0
    )
    BEGIN
        RAISERROR('Nieprawidłowy rozmiar dla wskazanej kategorii produktu.', 16, 1);
        RETURN; -- Zakończ działanie triggera bez wykonania wstawienia
    END
    INSERT INTO Rozmiar (KategoriaProduktuID, Rozmiar)
    SELECT KategoriaProduktuID, Rozmiar
    FROM inserted;
END;
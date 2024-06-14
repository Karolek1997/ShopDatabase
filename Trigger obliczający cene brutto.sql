-- Trigger obliczający cenę brutto na podstawie ceny netto i ustawionej stawki VAT dla wstawianych i aktualizowanych rekordów w tabeli Cena
CREATE TRIGGER ObliczCeneBrutto
ON Cena
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Cena
    SET CenaBrutto = 
		ISNULL(i.CenaNetto, 0)
		+ ((ISNULL(i.CenaNetto, 0) * (ISNULL(i.StawkaVAT, 0) / 100.0)))
    FROM inserted i
    WHERE Cena.ProduktID = i.ProduktID;
END;
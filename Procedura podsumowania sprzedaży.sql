-- procedura podsumowująca sprzedaż w danym roku
CREATE PROCEDURE PodsumujSprzedaz
AS
BEGIN
    -- Zwracanie wyników podsumowania sprzedaży
    SELECT 
        YEAR(DataZamowienia) AS 'Rok Sprzedazy',
        SUM(WartoscZamowienia) AS 'Dochod Brutto',
        SUM(WartoscZamowienia * 0.88) AS 'Dochod Netto',
        COUNT(ZamowienieID) AS 'Liczba Zamówień'
    FROM [dbo].[Zamowienia]
    WHERE StatusZamowienia = 'Zakonczone'
    GROUP BY YEAR(DataZamowienia);
END;

-- uruchomienie
EXEC PodsumujSprzedaz;



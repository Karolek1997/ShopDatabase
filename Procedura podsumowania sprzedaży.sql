-- procedura podsumowująca sprzedaż w danym roky
CREATE PROCEDURE PodsumujSprzedaz
AS
BEGIN
    SELECT 
        YEAR(DataZamowienia) AS RokSprzedazy,
        SUM(WartoscZamowienia) AS DochodBrutto,
        SUM(WartoscZamowienia * 0.88) AS DochodNetto,
        COUNT(ZamowienieID) AS LiczbaZamowienZrealizowanych
    FROM [dbo].[Zamowienia]
    WHERE StatusZamowienia = 'Zakonczone'
    GROUP BY YEAR(DataZamowienia);
END;
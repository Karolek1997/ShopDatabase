-- Widok na wszystkie produkty, posortowane po cenie brutto
CREATE VIEW WidokProdukty AS
SELECT
    p.NazwaProducenta as 'Producent',
    m.NazwaModelu as 'Model',
    k.NazwaKategorii as 'Kategoria produktu',
    r.Rozmiar as 'Rozmiar',
    ko.NazwaKoloru as 'Kolor',
    d.DostepnaIlosc as 'Dostępna ilość',
    c.CenaBrutto as 'Cena brutto',
    m.OpisModelu as 'Opis'
FROM
    Produkt pd
LEFT JOIN
    Producent p ON p.ProducentID = pd.ProducentID
LEFT JOIN
    Model m ON m.ModelID = pd.ModelID
LEFT JOIN
    KategoriaProduktu k ON k.KategoriaProduktuID = pd.KategoriaProduktuID
LEFT JOIN
    Rozmiar r ON r.RozmiarID = pd.RozmiarID
LEFT JOIN
    Kolor ko ON ko.KolorID = pd.KolorID
LEFT JOIN
    Dostepnosc d ON d.DostepnoscID = pd.DostepnoscID
LEFT JOIN
    Cena c ON c.ProduktID = pd.ProduktID;

-- Uruchomienie + posortowanie po cenie brutto
SELECT * FROM WidokProdukty
ORDER BY [Cena brutto] desc
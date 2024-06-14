-- uniwersalne dodanie wartosci VAT dla wszystkich istniejących produktów w tabeli Cena
UPDATE Cena
SET StawkaVAT = 12

-- w przypadku np. zmiany stawki VAT dla danej kategorii produktu, należy wykonać UPDATE w danej KategoriiProduktu 
-- np. dodanie 15% vatu dla wszystkich produktów w kategorii "Obuwie dziecice"

UPDATE Cena
SET Cena.StawkaVAT = 15
FROM Cena
JOIN Produkt ON Cena.ProduktID = Produkt.ProduktID
JOIN KategoriaProduktu ON KategoriaProduktu.KategoriaProduktuID = Produkt.KategoriaProduktuID
WHERE KategoriaProduktu.NazwaKategorii = 'Obuwie dzieciece';
-- Procedura, która sprawdza czy cena netto/brutto jakiegoś produktu w sklepie = 0 or null
CREATE PROCEDURE sprawdzceny
AS
BEGIN
    SELECT 
	kp.NazwaKategorii,
	m.NazwaModelu,
	r.Rozmiar
	FROM Cena c
	inner join produkt p on p.produktid = c.produktid
	inner join rozmiar r on r.RozmiarID = p.RozmiarID
	inner join model m on m.ModelID = p.ModelID
	inner join KategoriaProduktu kp on kp.KategoriaProduktuID = p.KategoriaProduktuID
	WHERE (c.CenaNetto = 0 OR c.CenaNetto IS NULL) OR (c.CenaBrutto = 0 OR c.CenaBrutto IS NULL);
END
SELECT 
    a.ID AS CurrentID,
    a.Nazwa AS CurrentNazwa,
    a.Aktualna_cena AS CurrentAktualna_cena,
    a.Pelna_cena AS CurrentPelna_cena,
    a.Dostepnosc AS CurrentDostepnosc,
    b.Aktualna_cena AS HistoryAktualna_cena,
    b.Pelna_cena AS HistoryPelna_cena,
    b.Dostepnosc AS HistoryDostepnosc,
    b.DataOd AS HistoryDataOd,
    b.DataDo AS HistoryDataDo
FROM 
    dbo.Informacjeoproduktach a
LEFT JOIN 
    dbo.Informacjeoproduktachhistory b
ON 
    a.UnikalneID = b.UnikalneID
WHERE 
    a.DataOd <> b.DataOd
ORDER BY 
    a.UnikalneID, a.DataOd

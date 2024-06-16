-- Widok na wszystkie dane klientów
CREATE VIEW WidokKlienci AS
SELECT 
    k.KlientID as 'Identyfikator klienta',
    k.Imie as 'Imie klienta',
    k.Nazwisko as 'Nazwisko klienta',
    k.login as 'Login klienta',
    k.email as 'Adres e-mail',
    k.NumerTelefonu as 'Numer telefonu',
    u.NazwaUlicy as 'Ulica',
    a.NumerBudynku as 'Numer budynku',
    a.NumerLokalu as 'Numer lokalu',
    m.NazwaMiasta as 'Miasto',
    kp.KodPocztowy as 'Kod Pocztowy',
    kr.NazwaKraju as 'Kraj'
FROM 
    Klient k
INNER JOIN 
    adres a ON a.KlientID = k.KlientID
INNER JOIN 
    Miasto m ON m.MiastoID = a.MiastoID
INNER JOIN 
    Kraj kr ON kr.KrajID = m.KrajID
INNER JOIN 
    ulica u ON u.UlicaID = m.UlicaID
INNER JOIN 
    KodPocztowy kp ON kp.KodPocztowyID = a.KodPocztowyID;

-- Uruchomienie
SELECT * FROM WidokKlienci;

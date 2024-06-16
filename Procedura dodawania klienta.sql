-- Procedura dodawania klienta z poziomu GUI
CREATE PROCEDURE DodajAdres (
    @Imie NVARCHAR(50),
    @Nazwisko NVARCHAR(50),
    @Email NVARCHAR(50),
    @NumerTelefonu CHAR(9),
    @NazwaMiasta NVARCHAR(50),
    @KodPocztowy CHAR(6),
    @NazwaKraju NVARCHAR(50),
    @NazwaUlicy NVARCHAR(50),
    @NumerBudynku INT,
    @NumerLokalu INT,
    @Login NVARCHAR(50)
)
AS
BEGIN
    DECLARE @KlientID INT;

    -- Sprawdzam czy adres email jest unikalny
    IF EXISTS (SELECT 1 FROM Klient WHERE Email = @Email)
    BEGIN
        RAISERROR('Adres email jest już używany.', 16, 1);
        RETURN; -- Zakończ procedurę
    END

    -- Sprawdzam czy login jest unikalny
    IF EXISTS (SELECT 1 FROM Klient WHERE Login = @Login)
    BEGIN
        RAISERROR('Login jest już używany.', 16, 1);
        RETURN; -- Zakończ procedurę
    END

    -- Sprawdzam czy klient istnieje w bazie na podstawie loginu lub emaila
    IF NOT EXISTS (SELECT 1 FROM Klient WHERE Login = @Login OR Email = @Email)
    BEGIN
        -- Dodaje klienta
        INSERT INTO Klient (Imie, Nazwisko, Email, NumerTelefonu, Login)
        VALUES (@Imie, @Nazwisko, @Email, @NumerTelefonu, @Login);
        SET @KlientID = (SELECT KlientID FROM Klient WHERE Login = @Login);
    END
    ELSE
    BEGIN
        SET @KlientID = (SELECT KlientID FROM Klient WHERE Email = @Email);
    END

    -- Sprawdzam poprawnośći kodu pocztowego, wymusza odpowiedni format kodu pocztowego
    IF NOT @KodPocztowy LIKE '[0-9][0-9]-[0-9][0-9][0-9]'
    BEGIN
        RAISERROR('Nieprawidłowy format kodu pocztowego. Wpisz kod pocztowy w formacie xx-xxx, gdzie x to cyfry.', 16, 1);
        RETURN; -- Zakończ procedurę
    END

    -- Sprawdzam czy kraj istnieje, jeśli nie, dodaje nowy
    IF NOT EXISTS (SELECT 1 FROM Kraj WHERE NazwaKraju = @NazwaKraju)
    BEGIN
        INSERT INTO Kraj (NazwaKraju)
        VALUES (@NazwaKraju);
    END

    -- Pobieram KrajID
    DECLARE @KrajID INT;
    SET @KrajID = (SELECT TOP 1 KrajID FROM Kraj WHERE NazwaKraju = @NazwaKraju);

    -- Sprawdzam czy ulica istnieje, jeśli tak, pobieram jej ID
    IF NOT EXISTS (SELECT 1 FROM Ulica WHERE NazwaUlicy = @NazwaUlicy)
    BEGIN
        INSERT INTO Ulica (NazwaUlicy)
        VALUES (@NazwaUlicy);
    END

    -- Pobieram UlicaID
    DECLARE @UlicaID INT;
    SET @UlicaID = (SELECT TOP 1 UlicaID FROM Ulica WHERE NazwaUlicy = @NazwaUlicy);

    -- Sprawdzam czy miasto istnieje, jeśli tak, pobieram jego ID
    DECLARE @MiastoID INT;
    IF EXISTS (SELECT 1 FROM Miasto WHERE NazwaMiasta = @NazwaMiasta AND KrajID = @KrajID AND UlicaID = @UlicaID)
    BEGIN
        SET @MiastoID = (SELECT TOP 1 MiastoID FROM Miasto WHERE NazwaMiasta = @NazwaMiasta AND KrajID = @KrajID AND UlicaID = @UlicaID);
    END
    ELSE

    -- Jeśli miasto nie istnieje, dodaje nowe
    BEGIN
        INSERT INTO Miasto (NazwaMiasta, KrajID, UlicaID)
        VALUES (@NazwaMiasta, @KrajID, @UlicaID);
        SET @MiastoID = (SELECT TOP 1 MiastoID FROM Miasto WHERE NazwaMiasta = @NazwaMiasta AND KrajID = @KrajID AND UlicaID = @UlicaID);
    END

    -- Sprawdzam czy kod pocztowy istnieje, jeśli nie, dodaje nowy
    IF NOT EXISTS (SELECT 1 FROM KodPocztowy WHERE KodPocztowy = @KodPocztowy)
    BEGIN
        INSERT INTO KodPocztowy (KodPocztowy, MiastoID)
        VALUES (@KodPocztowy, @MiastoID);
    END

    -- Pobieram KodPocztowyID
    DECLARE @KodPocztowyID INT;
    SET @KodPocztowyID = (SELECT TOP 1 KodPocztowyID FROM KodPocztowy WHERE KodPocztowy = @KodPocztowy);

    -- Dodaje wartosci do tabeli Adres
    INSERT INTO Adres (MiastoID, KodPocztowyID, NumerBudynku, NumerLokalu, KlientID)
    VALUES (@MiastoID, @KodPocztowyID, @NumerBudynku, @NumerLokalu, @KlientID);

    RAISERROR('Nowy klient i adres zostały pomyślnie dodane.', 0, 1);
END

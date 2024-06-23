-- Procedura umożliwia dodanie opisu dla danego modelu produktu
CREATE PROCEDURE [dbo].[DodajOpis]
    @NazwaModelu NVARCHAR(50),
    @OpisModelu NVARCHAR(500)
AS
BEGIN
    -- Aktualizuj OpisModelu dla wszystkich modeli o podanej NazwaModelu
    UPDATE dbo.Model
    SET OpisModelu = @OpisModelu
    WHERE NazwaModelu = @NazwaModelu;

    -- Zakończ procedurę
    RETURN;
END;
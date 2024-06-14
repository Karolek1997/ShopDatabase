-- triger ograniczający insertowany login do małych liter i cyfr, bez polskich znaków z zastosowaniem tablicy tymczasowej templogins
CREATE TRIGGER SprawdzLogin
ON dbo.Klient
AFTER INSERT
AS
BEGIN
	CREATE TABLE #templogins (login VARCHAR(50))
	INSERT INTO #templogins (login)
	SELECT login
	FROM inserted
    	WHERE Login LIKE '%[^a-z0-9]%' COLLATE Polish_BIN
	IF EXISTS(select 1 from #templogins)
	BEGIN
		RAISERROR('Niepoprawny format loginu', 14, 1);
		ROLLBACK TRANSACTION;
		RETURN;
	END
	DROP TABLE #templogins
END;
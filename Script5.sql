-- Trigger ograniczający insertowany email do małych liter i cyfr, bez polskich znaków z zastosowaniem tablicy tymczasowej templogins. Dodatkowo wymusza użycie @ oraz zezwala na kropki.
CREATE TRIGGER SprawdzEmail
ON dbo.Klient
AFTER INSERT
AS
BEGIN
	CREATE TABLE #tempemails (email VARCHAR(50));
	INSERT INTO #tempemails (email)
	SELECT email 
	FROM inserted
	WHERE email LIKE '%[^a-z0-9@.]%' COLLATE Polish_BIN
	OR CHARINDEX('@', email) = 0;

	IF EXISTS (SELECT 1 FROM #tempemails)
	BEGIN
		RAISERROR('Niepoprawny format adresu e-mail', 15, 1);
		ROLLBACK TRANSACTION;	
		RETURN;
	END

	DROP TABLE #tempemails;
END;
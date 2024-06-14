-- Procedura wyboru modelu dla guzików w aplikacji
CREATE PROCEDURE [dbo].[WybierzModelProduktu]
as
begin
select modelid, nazwamodelu from model
end
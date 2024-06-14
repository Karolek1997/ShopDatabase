-- Procedura wyboruy kategorii dla guzików w aplikacji
CREATE PROCEDURE [dbo].[WybierzKategorieProduktu]
as
begin
select kategoriaproduktuID, nazwakategorii from kategoriaproduktu
end

-- Procedura umożliwia wyświetlanie modeli produktów z eliminacją duplikacji
CREATE PROCEDURE [dbo].[WybierzModelProduktu3]
AS
BEGIN
    SELECT 
        MIN(modelid) AS modelid,
        nazwamodelu 
    FROM 
        model
    GROUP BY 
        nazwamodelu
END
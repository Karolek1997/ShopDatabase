select count(*) as Liczba_wszystkich_butów from Informacjeoproduktach

select count(*) as Liczba_Sztuk_Butów_Damskich from Informacjeoproduktach where Podtytu³ like '%damski%'
select top(3) * from Informacjeoproduktach where Podtytu³ like '%damski%'

select count(*) as Liczba_Sztuk_Butów_Mêskich from Informacjeoproduktach where Podtytu³ like '%mêski%'
select top(3) * from Informacjeoproduktach where Podtytu³ like '%mêski%'

select count(*) as Liczba_Sztuk_Butów_Dzieciêcych from Informacjeoproduktach where Podtytu³ like '%dzieci%'
select top(3) * from Informacjeoproduktach where Podtytu³ like '%dzieci%' 

select count(*) as Liczba_pozosta³ych_butów from Informacjeoproduktach where Podtytu³ NOT LIKE '%damski%' AND Podtytu³ NOT LIKE '%mêski%' AND Podtytu³ NOT LIKE '%dzieci%';
select top(3) * from Informacjeoproduktach where Podtytu³ NOT LIKE '%damski%' AND Podtytu³ NOT LIKE '%mêski%' AND Podtytu³ NOT LIKE '%dzieci%';

select count(*) as Liczba_wszystkich_but�w from Informacjeoproduktach

select count(*) as Liczba_Sztuk_But�w_Damskich from Informacjeoproduktach where Podtytu� like '%damski%'
select top(3) * from Informacjeoproduktach where Podtytu� like '%damski%'

select count(*) as Liczba_Sztuk_But�w_M�skich from Informacjeoproduktach where Podtytu� like '%m�ski%'
select top(3) * from Informacjeoproduktach where Podtytu� like '%m�ski%'

select count(*) as Liczba_Sztuk_But�w_Dzieci�cych from Informacjeoproduktach where Podtytu� like '%dzieci%'
select top(3) * from Informacjeoproduktach where Podtytu� like '%dzieci%' 

select count(*) as Liczba_pozosta�ych_but�w from Informacjeoproduktach where Podtytu� NOT LIKE '%damski%' AND Podtytu� NOT LIKE '%m�ski%' AND Podtytu� NOT LIKE '%dzieci%';
select top(3) * from Informacjeoproduktach where Podtytu� NOT LIKE '%damski%' AND Podtytu� NOT LIKE '%m�ski%' AND Podtytu� NOT LIKE '%dzieci%';

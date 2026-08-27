/*
SELECT COUNT(customer_id) AS "Klientide_koguarv" --COUNT funktsioon loeb kokku selle tulba väärtused. Nõuab järeloleva tulba nime sulgudes. AS salvestab uue väärtuse vastava nimega.
From "Customers"; -- FROM määrab ära millisest tabelist andmeid loetakse. Tabeli nimi on jutumärkides, kuna see muudab lugemise suure ja väikse tähe tundlikkuks. Kuna minu kood on minu Supabasesist kus salevastasin tabelid suure algus tähega.
*/

/*
SELECT * --AS "Klientide_andmed"
FROM "Customers"
LIMIT 10; --Piirab välja antavad tulemused kümne reaga
*/

/*
SELECT DISTINCT city AS Eri_linnad --DISTINCT väldib korduvaid tulemusi. SELECT ei vaja sulge.
FROM "Customers";
*/

/*
SELECT * --SELECT * tähendab, et valitakse kõik tulbad.
FROM "Customers"
WHERE city = 'Tallinn' -- WHERE otsib vastavale tingimusele vastavad tulemused.
LIMIT 15;
*/

/*
SELECT 
last_name, 
first_name, 
city  -- Siin toob välja täpselt millised kolm tulpa SELECT kutsub.
FROM "Customers"
WHERE city = 'Tallinn';
*/

/*
SELECT DISTINCT 
    city, 
    (SELECT COUNT(*) FROM "Customers" c2 WHERE c2.city = c1.city) AS "Arv_kliente" -- Siin on kasutusel alamküsitlus. Kasutatakse SELECTi, et luuauus tulp, mida nimetatakse Arv-kliente. WHERE rakkendab tingimust, et c1.city peab olema sama mis c2.city
FROM "Customers" c1; -- Siin nimetab peamine funktsioon Customers tabeli ümber c1-eks. Tuleb meeles pidada, et FROM, käsklust loeb kood kõigepealt mistõttu, c1 on juba defineeritud eelnevate ridade jaoks.
*/

-- SELECT COUNT(*) FROM "Customers" c2 on alam küsitlus. Kus nimetatakse Customers tabel alamküsitluse jaoks ümber c2-eks. Kui mõlemad küsitlused kasutaksid sama nime tekkiks koodis segadus. 

/*
SELECT 
    INITCAP(TRIM(city)) AS "Linnad", --INITCAP funktsioon formuleerib igasõna ainult esi tähe suureks. TRIM eemaldab tühikud sõnast.
    COUNT(*) AS "Kliendid"
FROM "Customers"
GROUP BY INITCAP(TRIM(city)) --GROUP BY rühmitab tulemused vastavalt sellele tulbale. 
ORDER BY "Linnad"; --ORDER BY sorteerib tulemused vastavalt tulbale. ASC on kasvava järjekord, DSC on kahanev järjekord.
*/

/*
SELECT DISTINCT 
    city, 
    (SELECT COUNT(*) FROM "Customers" c2 WHERE c2.city = c1.city)
FROM "Customers" c1;
*/

/*
WITH fixed_cities AS ( --WITH loob ajutise tabeli (fixed_cities) mida kood kasutab. See on vajalik selleks, et eemaldada hilisemast koodist mis jookseb loobis, resurssi võtvad funktsioonid.
    SELECT 
        INITCAP(TRIM(city)) AS clean_city -- Luuakse ajutisse tabelise tulp clean_city. See on sama suur kui orginaal kuid nimed on ära puhastatud tänu INITCAP ja TRIM funktsioonidele.
    FROM "Customers"
)
SELECT DISTINCT 
    clean_city,
    (SELECT COUNT(*) FROM fixed_cities c2 WHERE c2.clean_city = c1.clean_city) AS "Kliendid" -- Siin on kasutusel alamküsitlus mida rakendatakse juba puhastatud ajutise tabeli peal. Ning tulemused salevstatakse uue tulbana Kliendid.
FROM fixed_cities c1 -- FROM määrab ära, et siin me ei kutsu orginaal tabelit kus on puhastamata nimed vaid seda puhastatud tabelit mille lõin enne WITH funktsiooniga.
ORDER BY clean_city; -- ORDER BY sorteerib tulemused vastavalt puhastatud linnadele.
*/
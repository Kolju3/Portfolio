# Andmete Puhastamine SQL-iga: Kirurgia, Mitte Pomm

## Sissejuhatus

Andmete puhastamine on andmeanalüütiku kõige olulisem ja samas kõige alahinnatum oskus. Uuringud näitavad, et umbes 80% andmeanalüütiku tööajast kulub andmete puhastamisele ja ettevalmistamisele. Ainult 20% jääb tegelikuks analüüsiks ja visualiseerimiseks. See number üllatab paljusid, aga kui sa oled kunagi proovinud teha järeldusi mustadest andmetest, tead sa miks. Vale sisend annab vale väljundi. Inglise keeles öeldakse "Garbage In, Garbage Out" ehk GIGO. See on andmeanalüüsi raudne reegel.

Selles dokumendis õpid sa, kuidas SQL-iga andmeid puhastada: kuidas leida ja eemaldada duplikaate, kuidas käsitleda puuduvaid väärtusi (NULL), kuidas valideerida kuupäevi ja numbreid, kuidas ühtlustada tekstvälju ja kuidas teha seda kõike turvaliselt. Turvaliselt tähendab, et sa ei kaota kunagi originaalandmeid, sa dokumenteerid iga sammu ja sa saad alati tagasi minna, kui midagi läheb valesti.

Mõtle andmete puhastamisele kui kirurgiale, mitte kui pommitamisele. Sa ei taha kõike kustutada ja uuesti alustada. Sa tahad teha täpseid, kontrollitud parandusi, logida iga muudatus ja veenduda, et tulemus on parem kui algus.

---

## Miks Andmete Puhastamine On Nii Oluline

Kujuta ette, et sa oled koostamas aruannet UrbanStyle'i juhatusele. Sa kirjutad SQL päringu, mis näitab kvartali müügitulu. Tulemus ütleb 4,2 miljonit eurot. CEO Kristi Tamm on rõõmus. Aga keegi märkab, et müügitabelis on duplikaadid ja tegelik tulu on hoopis 2,8 miljonit. See vahe on 1,4 miljonit eurot. Kujuta ette, kuidas see mõjub investorite ees.

See pole hüpoteetiline stsenaarium. Sellised asjad juhtuvad ettevõtetes iga päev. Puuduvad andmed, duplikaadid, vigased kuupäevad ja ebajärjekindlad formaadid moonutavad iga analüüsi tulemust. Sellepärast on andmete puhastamine ESIMENE samm enne igasugust analüüsi.

Andmete puhastamine ei ole igav tehniline töö. See on detektiiviülesanne. Sa otsid vigu, tuvasted nende mustrid ja parandad need süstemaatiliselt. Ja SQL annab sulle selleks väga võimsad tööriistad.

---

## Duplikaatide Tuvastamine: GROUP BY ja HAVING

Duplikaadid on üks levinumaid andmekvaliteedi probleeme. Need tekivad sageli siis, kui sama tehing registreeritakse mitu korda, andmed imporditakse korduvalt või süsteemid ei kontrolli unikaalsust korralikult.

SQL-is on duplikaatide leidmiseks elegantsed vahendid: GROUP BY ja HAVING. GROUP BY koondab read rühmadesse sama väärtuse alusel. HAVING filtreerib neid rühmi pärast grupeerimist. Koos töötavad need nii: sa grupeerad read mingi veeru järgi ja siis filtreerid välja ainult need grupid, kus on rohkem kui üks rida.

```sql
-- Leia duplikaatsed invoice_id väärtused
SELECT
    invoice_id,
    COUNT(*) AS koopiate_arv
FROM sales
GROUP BY invoice_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;
```

See päring ütleb: "Grupeeri kõik müügid invoice_id kaupa ja näita mulle ainult need, kus on rohkem kui üks rida." Tulemus näitab sulle iga duplikaatse arvenumbri ja mitu koopiat sellest on.

Oluline on mõista, et GROUP BY ja HAVING on erinevad asjad. GROUP BY koondab andmeid, HAVING filtreerib koondatud tulemusi. WHERE filtreerib enne grupeerimist, HAVING filtreerib pärast. See erinevus on oluline. Kui sa tahad leida duplikaate, kasutad HAVING COUNT(*) > 1.

Mitu duplikaati on kokku? Selle saad teada nii:

```sql
-- Mitu duplikaatset rida on kokku?
SELECT COUNT(*) AS duplikaat_read
FROM sales
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales
    GROUP BY invoice_id
);
```

See päring ütleb: "Loe kokku kõik read, mis EI OLE oma grupi esimene rida." Kasutame `id` veergu (mitte `sale_id`), sest duplikaatridadel on sama `sale_id` väärtus — veerg `id` on automaatselt genereeritud primaarvõti, mis on iga rea jaoks unikaalne.

---

## Duplikaatide Eemaldamine: DELETE, ROW_NUMBER ja DISTINCT ON

Kui sa oled duplikaadid tuvastanud, tuleb need eemaldada. Aga ENNE seda tuleb teha üks kriitiline samm: luua test koopia!

```sql
-- Loo tabeli koopia enne kustutamist
CREATE TABLE sales_test AS SELECT * FROM sales;
```

Miks test koopia? Sest DELETE on pöördumatu. SQL-is pole UNDO nuppu. Kui sa kustutad vale rea production tabelist, on see läinud. Jäädavalt. Seepärast teed kõik eksperimendid test koopial ja alles siis, kui oled 100% kindel, rakendad muudatused päris tabelile.

Nüüd, kuidas duplikaate kustutada? Kõige tavalisem meetod on jätta alles iga grupi esimene rida ja kustutada ülejäänud:

```sql
-- Kustuta duplikaadid, jäta alles ainult üks rida iga invoice_id kohta (väikseim id)
DELETE FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
);
```

See lähenemine töötab hästi, kuid on ka elegantmaid viise. PostgreSQL-is saad kasutada ROW_NUMBER() akna funktsiooni:

```sql
-- ROW_NUMBER meetod: nummerda igasse gruppi kuuluvad read
DELETE FROM sales_test
WHERE id IN (
    SELECT id FROM (
        SELECT
            id,
            ROW_NUMBER() OVER (PARTITION BY invoice_id ORDER BY id) AS rn
        FROM sales_test
    ) numbered
    WHERE rn > 1
);
```

ROW_NUMBER() OVER (PARTITION BY invoice_id ORDER BY id) annab igale reale numbri oma grupi sees. Esimene rida saab 1, teine 2 ja nii edasi. Siis kustutad kõik read, kus number on suurem kui 1. Kasutame `id` veergu, sest see on iga rea jaoks unikaalne.

PostgreSQL-is on olemas ka DISTINCT ON, mis on veel üks viis unikaalseid ridu saada:

```sql
-- DISTINCT ON: vali iga grupi esimene rida
SELECT DISTINCT ON (invoice_id)
    sale_id, invoice_id, sale_date, customer_id, total_price
FROM sales_test
ORDER BY invoice_id, sale_id;
```

See annab sulle uue tabeli, kus iga invoice_id esineb ainult üks kord. DISTINCT ON on PostgreSQL-i spetsiifiline funktsioon, mida teistes andmebaasides ei pruugi olla.

---

## NULL Väärtuste Käsitlemine: IS NULL, COALESCE ja NULLIF

NULL on SQL-is eriline väärtus, mis tähendab "puudub" ehk "teadmata". NULL ei ole null. NULL ei ole tühi string. NULL ei ole 0. NULL on lihtsalt "me ei tea".

NULL väärtuste leidmiseks kasutad IS NULL ja IS NOT NULL:

```sql
-- Leia kõik read, kus kliendi ID puudub
SELECT * FROM sales WHERE customer_id IS NULL;

-- Leia kõik kliendid, kellel on e-mail olemas
SELECT * FROM customers WHERE email IS NOT NULL;
```

Oluline: sa EI SAA kasutada WHERE customer_id = NULL. See ei tööta kunagi, sest NULL ei ole millegagi võrdne, isegi mitte teise NULL-iga. Alati kasuta IS NULL.

Kui sa tahad NULL väärtused asendada, on COALESCE sinu parim sõber. COALESCE võtab mitu argumenti ja tagastab esimese, mis ei ole NULL:

```sql
-- COALESCE asendab NULL vaikeväärtusega
SELECT
    sale_id,
    COALESCE(customer_id, 0) AS puhas_customer_id,
    COALESCE(store_location, 'online') AS puhas_asukoht
FROM sales;
```

COALESCE on nagu turvavõrk. Kui väärtus on olemas, kasutab seda. Kui on NULL, annab asenduse. Sa saad anda mitu asendust ja COALESCE valib esimese mitte-NULL väärtuse:

```sql
SELECT COALESCE(NULL, NULL, 'Kolmas valik');
-- Tulemus: 'Kolmas valik'
```

Vastupidist tööd teeb NULLIF. NULLIF võrdleb kahte väärtust ja kui need on võrdsed, tagastab NULL:

```sql
-- NULLIF tagastab NULL, kui hind on 0
SELECT NULLIF(total_price, 0);
```

See on kasulik näiteks jagamise puhul. Kui sa jagad mingi väärtuse hinnaga ja hind on 0, saad jagamise nulliga vea. NULLIF(total_price, 0) muudab nulli NULL-iks ja jagamine tagastab samuti NULL, mitte veateate.

NULL väärtuste parandamine UPDATE käsuga:

```sql
-- Asenda puuduvad kliendinimed
UPDATE customers_test
SET first_name = 'Tundmatu'
WHERE first_name IS NULL;

-- Asenda puuduvad e-mailid
UPDATE customers_test
SET email = COALESCE(email, 'puudub@urbanstyle.ee')
WHERE email IS NULL;
```

---

## Kuupäevade Valideerimine: CASE WHEN ja Kuupäevafunktsioonid

Kuupäevad on üks tüüpilisemaid andmekvaliteedi probleemiallikaid. Tuleviku kuupäevad, liiga vanad kuupäevad ja ebareaalsed ajavahemikud viitavad vigadele, mida tuleb tuvastada ja parandada.

SQL-i CASE WHEN on nagu IF funktsioon Excelis, aga palju võimsam. Sa saad testida mitut tingimust ja anda igale tulemusele erineva väärtuse:

```sql
-- Valideeri kuupäevad
SELECT
    sale_id,
    sale_date,
    CASE
        WHEN sale_date > CURRENT_DATE THEN 'VIGA: tuleviku kuupäev'
        WHEN sale_date < '2020-01-01' THEN 'VIGA: liiga vana'
        WHEN sale_date IS NULL THEN 'VIGA: puudub'
        ELSE 'OK'
    END AS kuupäeva_staatus
FROM sales;
```

See päring kontrollib iga rea kuupäeva ja märgistab selle. CURRENT_DATE on PostgreSQL-i funktsioon, mis tagastab tänase kuupäeva. Read, mille kuupäev on tulevikus, on selgelt vigased. Read, mis on vanemad kui ettevõtte asutamine (UrbanStyle asutati 2020), on samuti kahtlased.

Vigaste kuupäevade parandamiseks saad kasutada UPDATE koos CASE WHEN-iga:

```sql
-- Paranda tuleviku kuupäevad tänaseks
UPDATE sales_test
SET sale_date = CURRENT_DATE
WHERE sale_date > CURRENT_DATE;
```

Aga ole ettevaatlik! Mõnikord on parem jätta vigane kuupäev paika ja märkida see eraldi veerus, mitte üle kirjutada. Nii säilitad originaalinfo ja saad hiljem uurida, miks kuupäev vale oli.

---

## Stringide Puhastamine: TRIM, UPPER, LOWER, INITCAP ja REPLACE

Tekstiandmed on sageli ebajärjekindlad. Sama linn võib esineda kui "Tallinn", "tallinn", "TALLINN" või isegi " Tallinn " (tühikutega). Need ebajärjekindlused tekitavad probleeme grupeerimisel ja filtreerimisel.

TRIM eemaldab tühikud stringi algusest ja lõpust:

```sql
-- Eemalda üleliigsed tühikud
SELECT TRIM('  Tallinn  ');
-- Tulemus: 'Tallinn'
```

UPPER muudab kõik tähed suurteks, LOWER väiketähtedeks ja INITCAP muudab iga sõna esitähe suureks:

```sql
SELECT UPPER('tallinn');    -- Tulemus: 'TALLINN'
SELECT LOWER('TALLINN');    -- Tulemus: 'tallinn'
SELECT INITCAP('tallinn');  -- Tulemus: 'Tallinn'
```

Linnanimed ühtlustad INITCAP ja TRIM kombinatsiooniga:

```sql
-- Ühtlusta kõik linnanimed
UPDATE customers_test
SET city = INITCAP(TRIM(city))
WHERE city != INITCAP(TRIM(city));
```

See leiab kõik read, kus linna nimi erineb standardformaadist, ja parandab need. Pärast seda on "tallinn", "TALLINN" ja " Tallinn " kõik muutunud korrektseks "Tallinn"-iks.

REPLACE asendab konkreetse alamstringi teisega:

```sql
-- Asenda vana kirjaviis uuega
UPDATE products_test
SET product_name = REPLACE(product_name, 'dress', 'kleit')
WHERE product_name LIKE '%dress%';
```

LENGTH kontrollib stringi pikkust ja LIKE otsib mustreid:

```sql
-- Leia ebatavaliselt lühikesed nimed (alla 2 tähemärgi)
SELECT * FROM customers
WHERE LENGTH(first_name) < 2;

-- Leia e-mailid, mis ei sisalda @-märki
SELECT * FROM customers
WHERE email NOT LIKE '%@%'
AND email IS NOT NULL;
```

---

## Andmetüüpide Teisendamine: CAST ja ::

Mõnikord on andmed vales andmetüübis. Hind võib olla salvestatud tekstina, kuupäev numbritena. SQL-is saad andmetüüpi teisendada CAST funktsiooniga või PostgreSQL-i lühendmärkega (::).

```sql
-- CAST süntaks
SELECT CAST('123.45' AS DECIMAL);
SELECT CAST('2024-01-15' AS DATE);

-- PostgreSQL lühend ::
SELECT '123.45'::DECIMAL;
SELECT '2024-01-15'::DATE;
```

Andmetüüpide teisendamine on oluline, sest vale tüübi puhul ei tööta arvutused korrektselt. Kui hind on tekst, siis ORDER BY sorteerib selle tähestikulises järjekorras, kus "9" on suurem kui "100".

---

## Transaktsioonid: BEGIN, COMMIT ja ROLLBACK

Transaktsioonid on turvalise andmete muutmise alustala. Transaktsioon on käskude komplekt, mida käsitletakse ühe tervikuna. Kas kõik käsud õnnestuvad ja muudatused jäävad püsima, või ühtegi muudatust ei rakendata.

```sql
-- Alusta transaktsioon
BEGIN;

-- Tee muudatused
DELETE FROM sales_test
WHERE sale_date > CURRENT_DATE;

-- NB: NULL customer_id = külalisost (kehtiv äriloogika, EI muuda!)
-- Dokumenteeri: SELECT COUNT(*) FROM sales_test WHERE customer_id IS NULL;

-- Kontrolli tulemusi
SELECT COUNT(*) FROM sales_test;

-- Kui kõik on korras, kinnita
COMMIT;

-- Kui midagi läks valesti, tühista kõik muudatused
-- ROLLBACK;
```

BEGIN alustab transaksiooni. COMMIT kinnitab kõik muudatused. ROLLBACK tühistab kõik muudatused ja taastab algse oleku. See on nagu Exceli UNDO, aga palju võimsam, sest sa saad tühistada terve seeria muudatusi korraga.

Reegel on lihtne: kui sa teed mitu muudatust korraga, paki need alati transaktsiooniks. Nii saad tagasi minna, kui midagi läheb valesti.

---

## Audit Logi: Dokumenteeri Iga Muudatus

Professionaalses andmeanalüüsis ei piisa ainult andmete parandamisest. Sa pead ka dokumenteerima, mida sa tegid, miks sa tegid ja mis tulemus oli. Selleks lood audit logi tabeli.

```sql
-- Loo audit logi tabel
CREATE TABLE cleaning_log (
    log_id SERIAL PRIMARY KEY,
    log_timestamp TIMESTAMP DEFAULT NOW(),
    table_name VARCHAR(50),
    action VARCHAR(100),
    rows_affected INT,
    details TEXT
);
```

Pärast iga puhastamissammu lisad logi:

```sql
-- Logige duplikaatide kustutamine
INSERT INTO cleaning_log (table_name, action, rows_affected, details)
VALUES ('sales_test', 'DELETE duplikaadid', 5116,
        'Kustutatud duplikaatsed read invoice_id alusel. Jäetud alles rida väikseima id-ga.');

-- Logige NULL väärtuste asendamine
INSERT INTO cleaning_log (table_name, action, rows_affected, details)
VALUES ('sales_test', 'UPDATE NULL customer_id', 230,
        'NULL customer_id väärtused asendatud 0-ga.');
```

See logi on sinu dokumentatsioon. Kui Toomas küsib "mida te tegite", näitad talle logitabelit. Kui keegi kahtlustab, et mõni muudatus oli vale, saad logist järgi vaadata. Professionaalne andmete puhastamine tähendab alati: test koopia, logi, dokumentatsioon.

---

## Puhastamise Protsess: Test, Verify, Log, Commit

Andmete puhastamisel on kindel protsess, mida tuleb alati järgida. See on nagu kirurgi kontrollnimekiri enne operatsiooni: iga samm on oluline ja ühtegi ei tohi vahele jätta.

**1. Test koopia** -- Loo tabeli koopia, kus katsetada. Kunagi ei tee muudatusi otse production tabelis.

**2. Diagnoos** -- Leia probleemid: duplikaadid, NULL-id, vigased kuupäevad, ebajärjekindlad stringid. Kasuta SELECT päringuid, et mõista probleemi ulatust.

**3. Paranda** -- Kirjuta DELETE, UPDATE käsud, mis lahendavad konkreetse probleemi. Alusta alati ühe probleemiga korraga.

**4. Kontrolli** -- Käivita uuesti sama diagnostikapäring. Kas probleem on lahendatud? Kas ridade arv on õige? Kas midagi olulist ei kadunud?

**5. Logi** -- Kirjuta audit logisse, mida tegid ja mis tulemus oli.

**6. Korda** -- Liigu järgmise probleemi juurde ja korda protsessi.

See protsess tundub aeglane, aga see on ainus viis, kuidas professionaalne andmepuhastamine toimib. Kiirustamine viib vigadeni ja vigade parandamine võtab rohkem aega kui algne ettevaatlik lähenemine.

---

## Kokkuvõte: Puhtad Andmed On Usaldusväärne Analüüsi Alus

Andmete puhastamine ei ole glamuurne töö, aga see on fundamentaalne. Ilma puhaste andmeteta on iga graafik, iga aruanne ja iga otsus ehitatud liivale. Selle nädala jooksul oled sa õppinud peamised tehnikad: duplikaatide leidmine GROUP BY ja HAVING abil, duplikaatide eemaldamine DELETE ja ROW_NUMBER abil, NULL väärtuste käsitlemine IS NULL ja COALESCE abil, kuupäevade valideerimine CASE WHEN abil, stringide ühtlustamine TRIM ja INITCAP abil, turvalise muutmise transaktsioonid BEGIN ja COMMIT abil ning audit logiga dokumenteerimine.

Kõige olulisem õppetund on aga protsess: Test, Verify, Log, Commit. See ei ole ainult SQL-i reegel. See on professionaalne tööviis, mida kasutavad andmeanalüütikud, andmeinsenerid ja andmeteadlased üle maailma. Andmete puhastamine on 80% tööst, aga see 80% teeb ülejäänud 20% võimalikuks.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist ja on optimeeritud NotebookLM audio genereerimiseks.*

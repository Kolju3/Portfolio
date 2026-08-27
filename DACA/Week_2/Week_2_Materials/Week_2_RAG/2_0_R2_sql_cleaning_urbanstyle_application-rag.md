# Andmete Puhastamine Praktikas: Toomas Kaski Juhatuse Koosoleku Tähtaeg

## Sissejuhatus

Reede õhtul pärast nädal 1 demo sessiooni võttis Toomas Kask sügavalt hinge. DataDriven meeskond oli leidnud täpselt need probleemid, mida ta kahtlustas: üle 5000 duplikaatse rea sales tabelis, sadu NULL väärtusega kliendikirjeid ja vigaseid kuupäevi. Tulemus oli isegi halvem, kui ta kartis.

Aga järgmisel hommikul helistas Kristi Tamm, UrbanStyle'i tegevjuht. "Toomas, mul on juhatuse koosolek kahe nädala pärast. Ma tahan näidata puhtaid numbreid. Kuidas ma saan usaldada numbreid, mis põhinevad kaoslikel andmetel?" Toomas vastas: "Andmete puhastamine on nagu kirurgia. Üks vale lõige ja kaotame olulisi andmeid. Aga me teeme selle korda."

Selles dokumendis käime samm-sammult läbi, kuidas sa puhastad UrbanStyle'i andmeid. Sa kasutad DELETE, UPDATE, COALESCE ja CASE WHEN päringuid päris andmetel ja näed, kuidas kaoslikud andmed muutuvad usaldusväärseks. Iga samm on logitud ja kontrollitud, täpselt nii nagu Toomas nõuab.

---

## Toomas Kaski Ülesanne: Puhasta ja Raporteeri

Toomas saatis esmaspäeva hommikul e-kirja pealkirjaga "Andmete puhastamine -- Juhatuse koosolek 2 nädala pärast". Tema nõudmised olid konkreetsed. Esiteks, tuvasta ja kustuta duplikaadid, jättes alles ainult ühe koopia igast arvest. Teiseks, täida NULL kliendinimed asendväärtusega. Kolmandaks, valideeri kuupäevad, sest keegi ei peaks nägema müüki aastast 2030. Neljandaks, ühtlusta linnade nimetused. Ja viiendaks, logi kõik muudatused: mida kustutati, mida muudeti, mitu rida mõjutati.

Toomas rõhutas eriti: "Ärge muutke production andmebaasi! Looge test koopia! Reegel: Test, Verify, Log, Commit. Alati selles järjekorras."

---

## Samm 1: Test Koopia Loomine

Esimene asi, mida sa teed, on test koopiate loomine. Sa ei puutu kunagi originaalandmeid enne, kui oled 100% kindel, et sinu puhastamisskript töötab õigesti.

```sql
-- Loo sales tabeli koopia
CREATE TABLE sales_test AS SELECT * FROM sales;

-- Loo customers tabeli koopia
CREATE TABLE customers_test AS SELECT * FROM customers;

-- Kontrolli: kas koopiad on täpsed?
SELECT COUNT(*) AS sales_originaal FROM sales;
SELECT COUNT(*) AS sales_koopia FROM sales_test;
SELECT COUNT(*) AS customers_originaal FROM customers;
SELECT COUNT(*) AS customers_koopia FROM customers_test;
```

Mõlemad paarid peaksid näitama sama arvu. Nüüd on sul turvaline keskkond katsetamiseks. Kui midagi läheb valesti, kustutad lihtsalt test tabeli ja lood uuesti.

Loo ka audit logi tabel, kuhu salvestad iga puhastamissammu:

```sql
CREATE TABLE cleaning_log (
    log_id SERIAL PRIMARY KEY,
    log_timestamp TIMESTAMP DEFAULT NOW(),
    table_name VARCHAR(50),
    action VARCHAR(100),
    rows_affected INT,
    details TEXT
);
```

---

## Samm 2: Müügitabeli Duplikaatide Eemaldamine

Sales tabelis on üle 5000 duplikaatse rea. Duplikaadid tekkisid, sest UrbanStyle'i e-kaubanduse platvormi ja füüsiliste kaupluste kassasüsteemide andmed imporditi korduvalt. Mõned arved registreeriti nii veebis kui ka POS-süsteemis.

Alusta diagnostikaga:

```sql
-- Mitu duplikaatset invoice_id on?
SELECT
    invoice_id,
    COUNT(*) AS koopiate_arv
FROM sales_test
GROUP BY invoice_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC
LIMIT 10;
```

See näitab sulle kõige rohkemate koopiatega arveid. Mõnel invoice_id on 2 koopiat, mõnel isegi 3.

```sql
-- Kokku duplikaatseid ridu
SELECT COUNT(*) AS duplikaat_read
FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
);
```

> **NB:** Kasutame `id` veergu (mitte `sale_id`), sest duplikaatridadel on sama `sale_id` väärtus. Veerg `id` on automaatselt genereeritud primaarvõti, mis on iga rea jaoks unikaalne.

Nüüd kustuta duplikaadid:

```sql
-- Enne: mitu rida?
SELECT COUNT(*) AS enne FROM sales_test;

-- Kustuta duplikaadid, jäta alles üks rida iga invoice_id kohta (väikseim id)
DELETE FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
);

-- Pärast: mitu rida?
SELECT COUNT(*) AS pärast FROM sales_test;
```

Kontrolli, et duplikaadid on kadunud:

```sql
-- Kas duplikaate on veel?
SELECT invoice_id, COUNT(*) AS koopiate_arv
FROM sales_test
GROUP BY invoice_id
HAVING COUNT(*) > 1;
-- Oodatav tulemus: 0 rida!
```

Logi tulemus:

```sql
INSERT INTO cleaning_log (table_name, action, rows_affected, details)
VALUES ('sales_test', 'DELETE duplikaadid (invoice_id)',
        5116, 'Duplikaatsed read kustutatud invoice_id alusel. Alles jäetud rida väikseima id-ga.');
```

---

## Samm 3: NULL Kliendinimede Parandamine

Liis Koppel, UrbanStyle'i operatsioonijuht, saatis Toomasele e-kirja: "Minu Tartu meeskond ütleb, et süsteemis on kliendid, kellel pole nime ega kontakti. Kuidas peaks müüja tegema personaalset teenindust, kui ta ei tea, kes klient on?"

See on reaalne äriprobleem. Leia esmalt ulatus:

```sql
-- Mitu klienti on ilma eesnimeta?
SELECT COUNT(*) AS puuduvad_eesnimed
FROM customers_test
WHERE first_name IS NULL;

-- Mitu klienti on ilma e-mailita?
SELECT COUNT(*) AS puuduvad_emailid
FROM customers_test
WHERE email IS NULL;

-- Vaata, millised kliendid on puudulike andmetega
SELECT customer_id, first_name, last_name, email, city
FROM customers_test
WHERE first_name IS NULL
   OR last_name IS NULL
   OR email IS NULL
ORDER BY customer_id
LIMIT 20;
```

Paranda puuduvad nimed:

```sql
-- Asenda NULL eesnimed
UPDATE customers_test
SET first_name = 'Tundmatu'
WHERE first_name IS NULL;

-- Asenda NULL perekonnanimed
UPDATE customers_test
SET last_name = 'Klient'
WHERE last_name IS NULL;
```

Logi:

```sql
INSERT INTO cleaning_log (table_name, action, rows_affected, details)
VALUES ('customers_test', 'UPDATE NULL first_name', 47,
        'NULL eesnimed asendatud väärtusega Tundmatu.');
```

Sales tabelis asenda puuduvad customer_id väärtused:

```sql
-- Mitu müüki on ilma kliendita?
SELECT COUNT(*) AS null_kliendid
FROM sales_test WHERE customer_id IS NULL;

-- Dokumenteeri NULL customer_id (need on külalisostud — kehtiv äriloogika!)
-- NB: ÄRGE asendage 0-ga! customer_id = 0 ei eksisteeri customers tabelis (FK viga).
-- Analüüsis kasuta COALESCE:
SELECT COALESCE(customer_id, -1) AS customer_id_puhas,
       COUNT(*) AS ostude_arv
FROM sales_test
GROUP BY COALESCE(customer_id, -1);
```

---

## Samm 4: Kuupäevade Valideerimine

UrbanStyle asutati 2020. aastal. Iga müük, mille kuupäev on enne seda, on kahtlane. Iga müük tuleviku kuupäevaga on selgelt vigane.

```sql
-- Leia probleemsed kuupäevad
SELECT
    sale_id,
    sale_date,
    CASE
        WHEN sale_date > CURRENT_DATE THEN 'TULEVIKUS'
        WHEN sale_date < '2020-01-01' THEN 'ENNE ASUTAMIST'
        WHEN sale_date IS NULL THEN 'PUUDUB'
        ELSE 'OK'
    END AS kuupäeva_staatus
FROM sales_test
WHERE sale_date > CURRENT_DATE
   OR sale_date < '2020-01-01'
   OR sale_date IS NULL
ORDER BY sale_date;
```

```sql
-- Mitu vigast kuupäeva on?
SELECT
    CASE
        WHEN sale_date > CURRENT_DATE THEN 'Tuleviku kuupäev'
        WHEN sale_date < '2020-01-01' THEN 'Enne UrbanStyle asutamist'
        WHEN sale_date IS NULL THEN 'Puuduv kuupäev'
        ELSE 'OK'
    END AS kategooria,
    COUNT(*) AS ridade_arv
FROM sales_test
GROUP BY kategooria
ORDER BY ridade_arv DESC;
```

See annab kokkuvõtliku ülevaate. Tuleviku kuupäevad saad parandada nii:

```sql
-- Paranda tuleviku kuupäevad
UPDATE sales_test
SET sale_date = CURRENT_DATE
WHERE sale_date > CURRENT_DATE;
```

---

## Samm 5: Linnanimed Korda

Liis mainis ka, et Tartu andmed on segased. Vaatame, millised linnaformaadid on kasutusel:

```sql
-- Millised linnakujud on andmebaasis?
SELECT DISTINCT city, COUNT(*) AS kordi
FROM customers_test
GROUP BY city
ORDER BY city;
```

Tüüpilised probleemid: "tallinn" ja "Tallinn" ja " Tallinn " on kolm erinevat väärtust. See tähendab, et grupeerimine linna järgi annab valesid tulemusi.

```sql
-- Ühtlusta kõik linnanimed
UPDATE customers_test
SET city = INITCAP(TRIM(city))
WHERE city != INITCAP(TRIM(city));
```

Kontrolli tulemust:

```sql
-- Nüüd peaks iga linn olema ainult üks kord
SELECT DISTINCT city, COUNT(*) AS kordi
FROM customers_test
GROUP BY city
ORDER BY city;
```

Logi:

```sql
INSERT INTO cleaning_log (table_name, action, rows_affected, details)
VALUES ('customers_test', 'UPDATE linnanimed INITCAP+TRIM', 89,
        'Ebajärjekindlad linnanimed ühtlustatud (tallinn→Tallinn jne).');
```

---

## Enne ja Pärast: Puhastamise Mõju

Koosta Toomasele kokkuvõttev raport, mis näitab enne ja pärast olukorda:

```sql
-- ENNE-PÄRAST RAPORT: Sales tabel
SELECT
    'Enne puhastamist' AS staatus,
    (SELECT COUNT(*) FROM sales) AS ridade_arv,
    (SELECT COUNT(*) - COUNT(DISTINCT invoice_id) FROM sales) AS duplikaadid,
    (SELECT COUNT(*) FROM sales WHERE customer_id IS NULL) AS null_kliendid,
    (SELECT COUNT(*) FROM sales WHERE sale_date > CURRENT_DATE) AS tuleviku_kuupäevad
UNION ALL
SELECT
    'Pärast puhastamist',
    (SELECT COUNT(*) FROM sales_test),
    (SELECT COUNT(*) - COUNT(DISTINCT invoice_id) FROM sales_test),
    (SELECT COUNT(*) FROM sales_test WHERE customer_id IS NULL),
    (SELECT COUNT(*) FROM sales_test WHERE sale_date > CURRENT_DATE);
```

See raport näitab ühes tabelis, mis oli enne ja mis on pärast. Toomas saab selle otse juhatusele esitada.

Vaata ka audit logi kokkuvõtet:

```sql
-- Kõik puhastamissammud kronoloogilises järjekorras
SELECT
    log_timestamp,
    table_name,
    action,
    rows_affected,
    details
FROM cleaning_log
ORDER BY log_timestamp;
```

---

## Liis Koppeli Tartu Mure: Praktliline Lahendus

Liis oli eriti mures Tartu poe andmete pärast. Pärast puhastamist saad talle konkreetse vastuse anda:

```sql
-- Tartu klientide andmekvaliteet pärast puhastamist
SELECT
    COUNT(*) AS tartu_kliente,
    COUNT(email) AS emailiga,
    COUNT(*) - COUNT(email) AS ilma_emailita,
    COUNT(phone) AS telefoniga
FROM customers_test
WHERE city = 'Tartu';
```

Nüüd saad Liisile öelda: "Tartu kliendibaasis on X klienti, neist Y-l on e-mail ja Z-l on telefon. Me ühtlustasime linnanimed ja parandasime puuduvad nimed." See on konkreetne, mõõdetav tulemus, mida operatsioonijuht saab kasutada.

---

## Puhastamisskript: Kõik Kokku

Professionaalne puhastamisskript koosneb kõigist sammudest õiges järjekorras, kommentaaridega:

```sql
-- ==============================================
-- UrbanStyle Andmete Puhastamisskript
-- Autor: DataDriven meeskond
-- Kuupäev: Nädal 2
-- Eesmärk: Puhastada sales ja customers tabelid
--          juhatuse koosolekuks
-- ==============================================

-- SAMM 0: Test koopiad
CREATE TABLE sales_test AS SELECT * FROM sales;
CREATE TABLE customers_test AS SELECT * FROM customers;

-- SAMM 1: Duplikaatide kustutamine (sales)
-- SAMM 2: NULL kliendi ID asendamine (sales)
-- SAMM 3: NULL nimede asendamine (customers)
-- SAMM 4: Kuupäevade valideerimine (sales)
-- SAMM 5: Linnanimed (customers)
-- SAMM 6: Enne-pärast raport

-- Iga samm on logitud cleaning_log tabelisse
```

See skript tuleb salvestada GitHubi portfooliosse. Toomas hindab mitte ainult tulemust, vaid ka protsessi kvaliteeti.

---

## Toomas Kaski Reaktsioon

Nädala lõpus, demo sessioonil, vaatab Toomas enne-pärast raportit ja audit logi. Ta on muljet avaldanud.

"Te tegite esimese asjana test koopia. See on professionaalne lähenemine. Te dokumenteerisite iga sammu logis ja raportis. Ma näen, et duplikaadid on kustutatud, NULL väärtused asendatud ja kuupäevad valideeritud. Ma usaldaksin teid production andmebaasiga."

Toomas teeb pausi ja lisab: "Aga järgmine väljakutse tuleb Annalt. Ta on turunduse juht ja teda ei huvita, kuidas andmed puhtaks said. Ta tahab teada, KES on meie parimad kliendid. Selleks peate ühendama mitut tabelit. JOINid on teel!"

See on sinu esimene päris andmete puhastamise kogemus. Sa oled õppinud, et andmete puhastamine ei ole lihtsalt tehniline töö, vaid distsiplineeritud protsess: tuvasta, test, paranda, kontrolli, logi. Ja sa oled näinud, kuidas see protsess lahendab reaalseid äriprobleeme.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist ja on optimeeritud NotebookLM audio genereerimiseks.*

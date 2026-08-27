# SQL Agregatsioon UrbanStyle'i Praktikas: Äriandmete Koondamine

## Sissejuhatus

Sel nädalal muutub kõik. Sa oled õppinud andmeid küsima ja tabeleid ühendama, aga nüüd hakkad sa vastama päris äriküsimustele. Anna Mets, UrbanStyle'i turunduse juht, vajab kiiresti koondnumbreid, sest CEO Kristi Tamm tahab juhatuse koosolekuks konkreetseid andmeid. Ja Liis Koppel, operatsioonijuht, on avastanud, et Tartu poe varudeandmed ei klapi. Mõlemad probleemid vajavad agregatsiooni.

Selles dokumendis vaatame läbi, kuidas GROUP BY, HAVING, CTE-d ja window functions töötavad UrbanStyle.ltd tegelikes stsenaariumides. Iga näide on seotud reaalse äriküsimusega, mida keegi UrbanStyle'i meeskonnast esitab. Sa näed, kuidas üks SQL-päring võib anda vastuse, mis mõjutab ettevõtte otsuseid.

## Anna Väljakutse: Müügitrendid CEO Raportisse

Anna Mets tuleb sinu juurde ja ütleb: "Kristi tahab juhatuse koosolekuks numbreid. Keskmine tellimusväärtus, top kategooriad, müügitrendid. KIIRESTI!" See on tüüpiline olukord andmeanalüütiku elus: keegi vajab numbreid ja nad vajavad neid kohe.

Esimene samm on müük kuude kaupa. See on kõige levinum agregatsiooni päring, sest peaaegu iga juht tahab näha, kuidas asjad aja jooksul muutuvad:

```sql
SELECT
    DATE_TRUNC('month', s.sale_date) AS kuu,
    COUNT(*) AS tellimusi,
    SUM(s.total_price) AS kogukäive,
    ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
FROM sales s
WHERE s.sale_date >= '2024-01-01'
GROUP BY DATE_TRUNC('month', s.sale_date)
ORDER BY kuu;
```

See päring annab Kristile kohe ülevaate: iga kuu käive, tellimuste arv ja keskmine tellimusväärtus. Kristi saab öelda juhatusele: "Meie Q4 müük kasvas 23% võrreldes Q3-ga ja keskmine tellimusväärtus tõusis 42 eurolt 47 eurole."

Aga Anna tahab rohkemat. Ta küsib: "Aga kuidas on erinevate tootekategooriatega? Kas naiste riided müüvad ikka kõige paremini?" Siin tuleb mängu mitme veeru grupeerimine:

```sql
SELECT
    p.category,
    COUNT(*) AS müüke,
    SUM(s.total_price) AS kogukäive,
    ROUND(AVG(s.total_price), 2) AS keskmine_hind,
    COUNT(DISTINCT s.customer_id) AS unikaalseid_kliente
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY kogukäive DESC;
```

Tulemus võib näidata, et naiste riided annavad 60% käibest, aksessuaarid 25% ja meeste riided 15%. See kinnitab UrbanStyle'i ärimudelit, aga näitab ka kasvuvõimalust: meeste riided on kasvav kategooria.

Aga Anna ei jää siin peatuma. Ta tahab teada veel rohkem: milline on müük kanali ja kategooria kombinatsioonis? Kas aksessuaarid müüvad paremini online või poes? See on oluline, sest füüsilises poes saab klient aksessuaare käes hoida ja proovida, aga online-poes on pildid kõik, mis kliendil on.

```sql
SELECT
    p.category,
    s.channel,
    COUNT(*) AS müüke,
    SUM(s.total_price) AS kogukäive,
    ROUND(AVG(s.total_price), 2) AS keskmine
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category, s.channel
ORDER BY p.category, kogukäive DESC;
```

See päring annab 6 rida: 3 kategooriat korda 2 kanalit. Ja tulemustest võib selguda, et aksessuaarid müüvad tõepoolest paremini poes, aga naiste riided müüvad paremini online. See on insight, mida Anna saab kohe turundusstrateegias kasutada: suuna aksessuaaride reklaam füüsilistesse kauplustesse ja naiste riiete reklaam online-kanalitesse.

## Müük Linnade Kaupa: Tallinn vs Tartu vs Pärnu

UrbanStyle'il on kolm füüsilist poodi: Tallinn (flagship, Rotermanni kvartal), Tartu (Tasku keskus) ja Pärnu (Port Artur). Lisaks on online-müük. Kristi tahab teada, kuidas iga asukoht toimib:

```sql
SELECT
    COALESCE(s.store_location, 'online') AS asukoht,
    COUNT(*) AS tellimusi,
    SUM(s.total_price) AS kogukäive,
    ROUND(AVG(s.total_price), 2) AS keskmine_tellimus,
    COUNT(DISTINCT s.customer_id) AS kliente
FROM sales s
GROUP BY COALESCE(s.store_location, 'online')
ORDER BY kogukäive DESC;
```

COALESCE on siin kasulik, sest online-tellimuste puhul võib store_location olla NULL. See päring annab selge pildi: milline kanal toob kõige rohkem tulu ja kus on kõige suurem keskmine tellimus?

Aga investorid tahavad rohkemat. Nad tahavad näha trendi: kas Tallinna poe müük kasvab või kahaneb? Siin tuleb mängu CTE ja LAG:

```sql
WITH asukoha_kuu_myyk AS (
    SELECT
        COALESCE(s.store_location, 'online') AS asukoht,
        DATE_TRUNC('month', s.sale_date) AS kuu,
        SUM(s.total_price) AS käive
    FROM sales s
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY COALESCE(s.store_location, 'online'),
             DATE_TRUNC('month', s.sale_date)
)
SELECT
    asukoht,
    kuu,
    käive,
    LAG(käive) OVER (PARTITION BY asukoht ORDER BY kuu) AS eelmine_kuu,
    ROUND(100.0 * (käive - LAG(käive) OVER (PARTITION BY asukoht ORDER BY kuu))
        / NULLIF(LAG(käive) OVER (PARTITION BY asukoht ORDER BY kuu), 0), 1
    ) AS kasv_protsent
FROM asukoha_kuu_myyk
ORDER BY asukoht, kuu;
```

See on juba keeruline päring, aga CTE muudab selle loetavamaks. Esimene osa arvutab iga asukoha iga kuu käive. Teine osa võrdleb iga kuud eelmisega, kasutades LAG-i PARTITION BY asukoht-iga, mis tähendab, et Tallinna kuud võrreldakse ainult Tallinna eelmiste kuudega.

## Parimate Toodete Leidmine Kategooriate Sees

Anna küsib: "Millised tooted müüvad igas kategoorias kõige paremini? Ma tahan teada TOP 3 toodet naiste riietes, aksessuaarides ja meeste riietes." See on klassikaline TOP-N partitsiooni järgi probleem ja siin on window functions asendamatud:

```sql
WITH toote_myyk AS (
    SELECT
        p.category,
        p.product_name,
        SUM(s.quantity) AS müüdud_kogus,
        SUM(s.total_price) AS käive,
        ROW_NUMBER() OVER (
            PARTITION BY p.category
            ORDER BY SUM(s.total_price) DESC
        ) AS koht
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY p.category, p.product_name
)
SELECT
    category AS kategooria,
    product_name AS toode,
    müüdud_kogus,
    käive,
    koht
FROM toote_myyk
WHERE koht <= 3
ORDER BY category, koht;
```

PARTITION BY p.category tähendab, et ROW_NUMBER alustab igast kategooriast uuesti. Nii saad sa iga kategooria TOP 3, mitte ainult üldise TOP 3.

## Kliendianalüüs: Segmenteerimine Ostukäitumise Järgi

Kristi tahab teada, kes on UrbanStyle'i kõige väärtuslikumad kliendid. See on oluline investoritele, sest see näitab kliendibaasi kvaliteeti. CTE koos CASE WHEN-iga annab vastuse:

```sql
WITH kliendi_kokkuvote AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS nimi,
        c.city,
        c.loyalty_tier,
        COUNT(*) AS tellimusi,
        SUM(s.total_price) AS kogukäive,
        MIN(s.sale_date) AS esimene_ost,
        MAX(s.sale_date) AS viimane_ost
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.loyalty_tier
)
SELECT
    nimi,
    city,
    loyalty_tier,
    tellimusi,
    kogukäive,
    esimene_ost,
    viimane_ost,
    CASE
        WHEN kogukäive > 500 AND tellimusi > 5 THEN 'VIP'
        WHEN kogukäive > 200 OR tellimusi > 3 THEN 'Aktiivne'
        ELSE 'Tavaline'
    END AS segment
FROM kliendi_kokkuvote
ORDER BY kogukäive DESC;
```

Tulemus näitab kogu kliendibaasi segmenteerituna. Kristi saab investoritele öelda: "Meil on 245 VIP-klienti, kes annavad 60% käibest. Nende keskmine tellimusväärtus on 89 eurot." See on number, mis veenab investoreid.

Aga Anna tahab ka teada segmentide koondnumbreid:

```sql
WITH kliendi_segment AS (
    SELECT
        c.customer_id,
        CASE
            WHEN SUM(s.total_price) > 500 AND COUNT(*) > 5 THEN 'VIP'
            WHEN SUM(s.total_price) > 200 OR COUNT(*) > 3 THEN 'Aktiivne'
            ELSE 'Tavaline'
        END AS segment,
        SUM(s.total_price) AS kogukäive
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id
)
SELECT
    segment,
    COUNT(*) AS kliente,
    SUM(kogukäive) AS segmendi_käive,
    ROUND(AVG(kogukäive), 2) AS keskmine_käive,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS protsent_klientidest,
    ROUND(100.0 * SUM(kogukäive) / SUM(SUM(kogukäive)) OVER (), 1) AS protsent_käibest
FROM kliendi_segment
GROUP BY segment
ORDER BY segmendi_käive DESC;
```

See on väga võimas päring: ta näitab iga segmendi kliente, käivet ja protsentuaalset osakaalu. SUM() OVER() ilma PARTITION BY-ta annab kogusumma, mida saab kasutada protsendi arvutamiseks.

## Liis Koppeli Varude Probleem: HAVING Anomaaliate Leidmisel

Liis helistab ja ütleb: "Anna, meie Tartu poe varude andmed ei klapi. Süsteem näitab 75 kleiti, aga laos on ainult 50. Kus on 25 kleiti?!" See on tõsine probleem, sest vale varudeinfo viib valede tellimusteni.

Anna kasutab agregatsiooni, et leida kõik tooted, kus on erinevusi:

```sql
SELECT
    p.product_name,
    i.location,
    i.quantity_available AS süsteemi_saldo,
    SUM(CASE WHEN im.movement_type = 'received' THEN im.quantity ELSE 0 END) AS kokku_sisse,
    SUM(CASE WHEN im.movement_type = 'sold' THEN im.quantity ELSE 0 END) AS kokku_välja,
    SUM(CASE WHEN im.movement_type = 'returned' THEN im.quantity ELSE 0 END) AS tagastused,
    SUM(CASE WHEN im.movement_type = 'received' THEN im.quantity ELSE 0 END)
    - SUM(CASE WHEN im.movement_type = 'sold' THEN im.quantity ELSE 0 END)
    + SUM(CASE WHEN im.movement_type = 'returned' THEN im.quantity ELSE 0 END) AS arvutatud_saldo
FROM products p
JOIN inventory i ON p.product_id = i.product_id
LEFT JOIN inventory_movements im ON p.product_id = im.product_id
    AND im.location = i.location
WHERE i.location = 'tartu'
GROUP BY p.product_name, i.location, i.quantity_available
HAVING ABS(
    i.quantity_available - (
        SUM(CASE WHEN im.movement_type = 'received' THEN im.quantity ELSE 0 END)
        - SUM(CASE WHEN im.movement_type = 'sold' THEN im.quantity ELSE 0 END)
        + SUM(CASE WHEN im.movement_type = 'returned' THEN im.quantity ELSE 0 END)
    )
) > 0
ORDER BY ABS(
    i.quantity_available - (
        SUM(CASE WHEN im.movement_type = 'received' THEN im.quantity ELSE 0 END)
        - SUM(CASE WHEN im.movement_type = 'sold' THEN im.quantity ELSE 0 END)
        + SUM(CASE WHEN im.movement_type = 'returned' THEN im.quantity ELSE 0 END)
    )
) DESC;
```

HAVING filtreerib välja ainult tooted, kus süsteemi saldo erineb arvutatud saldost. See on klassikaline andmevalideerimise päring. Liis saab nüüd näha iga toote kohta, millised liikumised on toimunud ja kus tekib erinevus. Sageli leiab ta, et mõned tagastused on topelt kirjendatud.

## CEO Dashboard Päring: Samm-Sammult Ülesehitus

Kristi vajab ühte kompaktset ülevaadet, mida ta saab juhatuse koosolekul ekraanile panna. Siin ehitame selle samm-sammult, kasutades mitut CTE-d:

```sql
WITH müügi_kpi AS (
    SELECT
        SUM(total_price) AS kogukäive,
        COUNT(*) AS tellimusi,
        ROUND(AVG(total_price), 2) AS keskmine_tellimus,
        COUNT(DISTINCT customer_id) AS unikaalseid_kliente
    FROM sales
    WHERE sale_date >= '2024-01-01'
),
parima_kuu AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
    ORDER BY käive DESC
    LIMIT 1
),
parima_linn AS (
    SELECT
        COALESCE(s.store_location, 'online') AS asukoht,
        SUM(s.total_price) AS käive
    FROM sales s
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY COALESCE(s.store_location, 'online')
    ORDER BY käive DESC
    LIMIT 1
)
SELECT
    m.kogukäive,
    m.tellimusi,
    m.keskmine_tellimus,
    m.unikaalseid_kliente,
    pk.kuu AS parim_kuu,
    pk.käive AS parima_kuu_käive,
    pl.asukoht AS parim_asukoht,
    pl.käive AS parima_asukoha_käive
FROM müügi_kpi m
CROSS JOIN parima_kuu pk
CROSS JOIN parima_linn pl;
```

See üks päring annab Kristile kõik olulised numbrid ühes reas: kogukäive, tellimuste arv, keskmine tellimus, unikaalsed kliendid, parim kuu ja parim asukoht. See on CEO dashboard ühes SQL-päringus.

## Keskmine Tellimusväärtus Aja Jooksul

Anna tahab näha, kuidas keskmine tellimusväärtus (AOV) muutub aja jooksul. Kasvav AOV tähendab, et kliendid ostavad rohkem iga tehingu kohta. See on oluline KPI:

```sql
WITH kuu_aov AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS kuu,
        ROUND(AVG(total_price), 2) AS aov,
        COUNT(*) AS tellimusi
    FROM sales
    WHERE sale_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT
    kuu,
    aov,
    tellimusi,
    LAG(aov) OVER (ORDER BY kuu) AS eelmine_aov,
    ROUND(aov - LAG(aov) OVER (ORDER BY kuu), 2) AS aov_muutus,
    ROUND(100.0 * (aov - LAG(aov) OVER (ORDER BY kuu))
        / NULLIF(LAG(aov) OVER (ORDER BY kuu), 0), 1
    ) AS aov_kasv_protsent
FROM kuu_aov
ORDER BY kuu;
```

Kui AOV kasvab, saab Kristi investoritele öelda: "Meie kliendid kulutavad iga kuuga rohkem, mis näitab brändi tugevust ja kliendilojaalsust."

## Jätkusuutlike Toodete Analüüs: Eco-Certified Tooted

UrbanStyle eristub konkurentidest jätkusuutlikkuse fookusega. Toodete tabelis on eco_certified veerg, mis näitab, kas toode on jätkusuutlikkuse sertifikaadiga. Kristi tahab teada, kas öko-sertifitseeritud tooted müüvad paremini ja kas kliendid on valmis nende eest rohkem maksma:

```sql
SELECT
    p.eco_certified,
    COUNT(*) AS müüke,
    SUM(s.total_price) AS kogukäive,
    ROUND(AVG(s.total_price), 2) AS keskmine_tellimus,
    COUNT(DISTINCT s.customer_id) AS kliente
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.eco_certified
ORDER BY kogukäive DESC;
```

See päring võrdleb eco-certified ja tavalist toodete müüki. Kui öko-tooted on kõrgema keskmise tellimusväärtusega, siis see toetab Kristi jätkusuutlikkuse strateegiat. Ta saab investoritele näidata: "Meie öko-tooted müüvad 15% kõrgema keskmise hinnaga ja kliendid eelistavad neid. See on meie konkurentsieelis."

Aga Marko Saar, tootehaldur, tahab teada veel rohkem: milliseid öko-tarnijaid eelistada? Millistel tarnijatel on parim müüginumber sertifitseeritud toodete seas?

```sql
SELECT
    p.supplier,
    COUNT(DISTINCT p.product_id) AS tooteid,
    SUM(s.quantity) AS müüdud_kogus,
    SUM(s.total_price) AS kogukäive,
    ROUND(AVG(s.total_price), 2) AS keskmine_hind
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE p.eco_certified = true
GROUP BY p.supplier
HAVING SUM(s.quantity) > 10
ORDER BY kogukäive DESC;
```

HAVING SUM(s.quantity) > 10 filtreerib välja tarnijad, kellel on liiga vähe müüke, et usaldusväärset järeldust teha. See on oluline statistiline kaalutlus: kui tarnijal on ainult 2 müüki, siis keskmine hind pole usaldusväärne.

## Nädalapäeva Analüüs: Millal Kliendid Ostavad?

Anna tahab optimeerida turunduskampaaniate ajastust. Selleks on vaja teada, millistel nädalapäevadel ja kellaaegadel kliendid kõige rohkem ostavad:

```sql
SELECT
    EXTRACT(DOW FROM s.sale_date) AS päeva_nr,
    CASE EXTRACT(DOW FROM s.sale_date)
        WHEN 0 THEN 'Pühapäev'
        WHEN 1 THEN 'Esmaspäev'
        WHEN 2 THEN 'Teisipäev'
        WHEN 3 THEN 'Kolmapäev'
        WHEN 4 THEN 'Neljapäev'
        WHEN 5 THEN 'Reede'
        WHEN 6 THEN 'Laupäev'
    END AS nädalapäev,
    COUNT(*) AS tellimusi,
    SUM(s.total_price) AS kogukäive,
    ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
FROM sales s
GROUP BY EXTRACT(DOW FROM s.sale_date)
ORDER BY päeva_nr;
```

Tulemustest selgub, et laupäev on kõige populaarsem ostupäev füüsilistes poodides, aga teisipäeva ja kolmapäeva õhtud on online-müügi tipptunnid. Anna saab selle infoga planeerida: Instagram-reklaame laupäeva hommikuks (poed), e-mail kampaaniaid teisipäeva pärastlõunaks (online).

## Kampaaniate Mõju: Promotions Tabeli Analüüs

UrbanStyle'i andmebaasis on promotions tabel, mis sisaldab sooduskampaaniate infot. Anna tahab mõista, kas kampaaniad toovad lisatulu või söövad lihtsalt marginaali:

```sql
WITH kampaania_müük AS (
    SELECT
        pr.promo_name,
        pr.discount_percent,
        COUNT(DISTINCT s.customer_id) AS kliente,
        COUNT(*) AS tehinguid,
        SUM(s.total_price) AS käive,
        ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
    FROM promotions pr
    JOIN sales s ON s.product_id = pr.product_id
        AND s.sale_date BETWEEN pr.start_date AND pr.end_date
    GROUP BY pr.promo_name, pr.discount_percent
)
SELECT
    promo_name,
    discount_percent,
    kliente,
    tehinguid,
    käive,
    keskmine_tellimus,
    ROUND(käive / NULLIF(kliente, 0), 2) AS käive_per_klient
FROM kampaania_müük
ORDER BY käive DESC;
```

See päring ühendab kampaaniad müükidega, mis toimusid kampaania perioodi jooksul. Tulemus näitab, millised kampaaniad tõid kõige rohkem tulu ja kliente. Anna saab otsustada, milliseid kampaaniaid korrata ja millistest loobuda.

## Kokkuvõte

Sel nädalal sa ei kirjutanud lihtsalt SQL-päringuid. Sa vastasid äriküsimustele. Anna saab nüüd esitada Kristile täpsed müügitrendid. Liis saab Tartu poe varudeprobleemi lahendada. Ja Kristi saab investoritele näidata konkreetseid numbreid.

See on andmeanalüütiku tegelik töö: keegi tuleb su juurde küsimusega, sina avad SQL-i ja annad vastuse. GROUP BY, HAVING, CTE-d ja window functions on su tööriistad. Aga kõige olulisem tööriist on su äriline mõtlemine: sa pead aru saama, mida küsija tegelikult teada tahab, ja pakkuma vastust, mis aitab tal otsuse teha.

Järgmisel nädalal hakkad sa neid numbreid visualiseerima. Sest üks hea graafik ütleb rohkem kui tuhat rida andmeid. Aga enne seda on sul vaja kindlust, et su agregatsiooni päringud annavad õiged tulemused. Seda sa sel nädalal õppisidki.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist. Optimeeritud NotebookLM audio genereerimiseks.*

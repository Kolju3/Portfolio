# SQL Agregatsioon: Kuidas Muuta Toornumbrid Äriküsimusteks

## Sissejuhatus

Sa oled juba õppinud andmebaasist andmeid küsima SELECT-lausetega ja eri tabeleid kokku ühendama JOIN-lausetega. Need on olulised oskused, aga mõtle nüüd sellele: kui sa tõmbad välja 10 000 müügirida, siis mida sa nendega teed? Kas sa hakkad käsitsi kokku arvutama? Muidugi mitte. Siin tulebki mängu agregatsioon ehk andmete koondamine.

Agregatsioon on see, mis muudab toornumbrid vastusteks. Mitte lihtsalt "siin on kõik müügitehingud", vaid "meie keskmine tellimuse väärtus on 47 eurot ja Tallinna kliendid ostavad 40% rohkem kui Tartu kliendid". See on täpselt see, mida juhid vajavad. Tegelikult umbes 90% äriküsimuste vastused nõuavad mingit koondamist: "kui palju?", "mis on keskmine?", "kes on parimad?" ja nii edasi.

Selles dokumendis vaatame läbi kõik peamised agregatsiooni kontseptsioonid: GROUP BY, agregaatfunktsioonid, HAVING, CTE-d ja window functions. Iga teema juures kasutame UrbanStyle.ltd näiteid, sest just nende andmetega sa iga päev töötad.

## Mis On Agregatsioon ja Miks See Oluline On?

Kujuta ette, et sul on karp täis müügikviitungeid. Iga kviitung on üks rida andmebaasis: kuupäev, klient, toode, summa. Lihtne SELECT on nagu ühe kviitungi lugemine. JOIN on nagu kahe erineva karbi võrdlemine, näiteks kviitungid ja kliendiandmed. Aga GROUP BY on midagi hoopis teistsugust: see on nagu kviitungite sorteerimine kuhjadesse, kuude kaupa või linnade kaupa, ja siis iga kuhja kokkulugemine.

Miks see oluline on? Sest juhid ei taha näha 10 000 rida andmeid. Nad tahavad näha 10 võtmenumbrit. CEO Kristi Tamm ei küsi "näita mulle kõik tehingud", vaid "kuidas meie müük kuude lõikes muutub?" või "mis on meie keskmine tellimusväärtus?". Agregatsioon on sild toornumbrite ja strateegiliste otsuste vahel.

Veel üks oluline aspekt: agregatsioon aitab leida anomaaliaid. Kui sa koondad andmeid ja tulemused ei klapi tegelikkusega, siis oled leidnud probleemi. Näiteks UrbanStyle'i operatsioonijuht Liis Koppel avastas, et Tartu poe varudeandmed ei klapi füüsilise inventuuriga. Just agregatsiooni abil sai ta sellest aru.

## GROUP BY: Andmete Grupeerimine

GROUP BY on agregatsiooni alustala. See ütleb andmebaasile: "Grupeeri read nende veergude järgi ja arvuta iga grupi kohta koondnäitajad." Ilma GROUP BY-ta saad sa kõik read eraldi. GROUP BY-ga saad kompaktsed kokkuvõtted.

Süntaks on järgmine: pärast SELECT-i paned grupi veerud ja agregaatfunktsioonid, FROM-i ja WHERE-i järel kirjutad GROUP BY ja loetled samad veerud, mille järgi grupeerid. See on oluline reegel: iga veerg, mis on SELECT-is ja ei ole agregaatfunktsiooni sees, peab olema ka GROUP BY-s.

Lihtne näide. Kui sa tahad teada, kui palju tellimusi ja milline kogukäive on igal kuul, kirjutad:

```sql
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    COUNT(*) AS tellimusi,
    SUM(total_price) AS kogukäive
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;
```

Selle asemel, et näha sadu üksikuid ridu, saad sa 12 rida: üks iga kuu kohta, koos tellimuste arvu ja kogukäivega. See on juba number, millega CEO midagi peale hakkab.

Sa saad grupeerida mitme veeru järgi korraga. Näiteks müük linna ja kuu kaupa:

```sql
SELECT
    c.city AS linn,
    DATE_TRUNC('month', s.sale_date) AS kuu,
    COUNT(*) AS tellimusi,
    SUM(s.total_price) AS kogukäive
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.city, DATE_TRUNC('month', s.sale_date)
ORDER BY linn, kuu;
```

Nüüd näed sa iga linna ja iga kuu kombinatsiooni eraldi: Tallinn jaanuaris, Tallinn veebruaris, Tartu jaanuaris ja nii edasi. See annab palju detailsema pildi.

Levinud viga algajatel on jätta mõni veerg GROUP BY-st välja. Kui sa kirjutad SELECT-i product_name, aga ei pane seda GROUP BY-sse ega agregaatfunktsiooni sisse, siis PostgreSQL annab veateate. Iga mitte-agregeeritud veerg peab olema GROUP BY-s. See on reegel, mida tasub meelde jätta.

## Agregaatfunktsioonid: COUNT, SUM, AVG, MIN, MAX

Agregaatfunktsioonid on tööriistad, mis arvutavad grupi kohta ühe koondväärtuse. Neid on viis peamist ja igaühel on oma otstarve. Vaatame igaüht lähemalt.

**COUNT** loendab ridu. See tundub lihtne, aga COUNT-il on kolm erinevat varianti ja nende erinevuse mõistmine on väga oluline.

COUNT(*) loeb kõik read, kaasa arvatud need, kus mõni veerg on NULL. See annab sulle tabeli täieliku ridade arvu. Kui sa tahad teada, mitu müügitehingut on andmebaasis kokku, kasutad COUNT(*).

COUNT(veeru_nimi) loeb ainult read, kus see konkreetne veerg ei ole NULL. See on kasulik andmekvaliteedi kontrolliks. Näiteks kui sa kirjutad COUNT(email), saad sa teada, mitmel kliendil on e-posti aadress kirjas. Kui COUNT(*) annab 2500 ja COUNT(email) annab 2125, siis sa tead, et 375 kliendil puudub e-posti aadress. See on 15% andmelünk, millega tuleb arvestada.

COUNT(DISTINCT veeru_nimi) loeb unikaalseid väärtuseid. See on eriti kasulik müügianalüüsis: COUNT(*) annab tehingute arvu, aga COUNT(DISTINCT customer_id) annab unikaalsete klientide arvu. Need on väga erinevad numbrid, sest üks klient võib olla teinud mitu tehingut.

```sql
-- Mitu erinevat klienti on ostnud UrbanStyle'ist?
SELECT COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales;

-- Võrdlus: tehinguid vs unikaalseid kliente
SELECT
    COUNT(*) AS tehinguid_kokku,
    COUNT(DISTINCT customer_id) AS unikaalseid_kliente,
    ROUND(COUNT(*)::NUMERIC / COUNT(DISTINCT customer_id), 1) AS tehinguid_per_klient
FROM sales;
```

**SUM** liidab väärtused kokku. See on kõige lihtsam, aga ka kõige sagedamini kasutatav funktsioon. Kogukäive, müüdud kogused, kogukulud: kõik need nõuavad SUM-i. Üks oluline nüanss: SUM ignoreerib NULL-väärtuseid. Kui sul on rida, kus total_price on NULL, siis SUM ei arvesta seda. See tähendab, et NULL ei ole sama mis 0. Kui sa tahad NULL-e nullidena käsitleda, kasuta COALESCE: SUM(COALESCE(total_price, 0)).

**AVG** arvutab keskmise. UrbanStyle'i puhul on keskmine tellimusväärtus ehk AOV (Average Order Value) üks olulisemaid KPI-sid. Aga ole ettevaatlik: AVG ignoreerib NULL-väärtuseid automaatselt, mis mõnikord võib anda vale tulemuse. Kui 100 reale kogusumma on 5000 ja 5 rida on NULL, siis AVG jagab 5000 ainult 95-ga, mitte 100-ga. See annab kõrgema keskmise, mis võib olla eksitav.

Kasuta ROUND-i, et keskmine oleks loetavam. Ilma ümardamiseta võid sa saada midagi nagu 47.382746, aga juht tahab näha 47.38:

```sql
SELECT ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales;
```

**MIN** ja **MAX** leiavad väikseima ja suurima väärtuse. Need on kasulikud hindade analüüsiks: milline on odavaim ja kalleim toode kategoorias? Aga ka kuupäevadega: millal oli esimene ja viimane tellimus? MAX(sale_date) annab viimase tehingu kuupäeva, MIN(sale_date) esimese.

Hindade puhul on MIN ja MAX koos kasulikud hinnavahemiku arvutamiseks:

```sql
SELECT
    p.category,
    COUNT(*) AS tooteid,
    MIN(p.retail_price) AS odavaim,
    MAX(p.retail_price) AS kalleim,
    MAX(p.retail_price) - MIN(p.retail_price) AS hinnavahemik,
    ROUND(AVG(p.retail_price), 2) AS keskmine_hind
FROM products p
GROUP BY p.category
ORDER BY keskmine_hind DESC;
```

Kõiki neid funktsioone saab kombineerida ühes päringus. See on ka kõige levinum: üks päring, mis annab sulle korraga tellimuste arvu, kogukäive, keskmise tellimuse, suurima ja väikseima tehingu. See on üks rida SQL-i, mis annab viis olulist numbrit korraga. Väga efektiivne.

## HAVING: Filtreerimine Pärast Grupeerimist

Siit tuleb üks SQL-i olulisemaid eristusi: WHERE vs HAVING. Mõlemad filtreerivad, aga erinevatel hetkedel.

**WHERE** filtreerib üksikuid ridu enne grupeerimist. Näiteks "ainult 2024. aasta tellimused" on WHERE tingimus. Sa ei saa WHERE-is kasutada agregaatfunktsioone nagu SUM() või COUNT(), sest neid pole veel arvutatud.

**HAVING** filtreerib gruppe pärast grupeerimist. Näiteks "ainult linnad, kus on rohkem kui 10 tellimust" on HAVING tingimus. Siin saad sa kasutada agregaatfunktsioone.

Mõtle sellele nii: WHERE on nagu uksel olev turvatöötaja, kes laseb sisse ainult õiged piletiga. HAVING on nagu filmauhindade žürii, kes vaatab filme (gruppe) ja valib välja ainult need, mis vastavad kriteeriumitele.

```sql
SELECT
    c.city AS linn,
    COUNT(*) AS tellimusi,
    SUM(s.total_price) AS kogukäive
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
WHERE s.sale_date >= '2024-01-01'     -- WHERE: ainult 2024. aasta read
GROUP BY c.city
HAVING COUNT(*) > 10                   -- HAVING: ainult linnad 10+ tellimusega
ORDER BY kogukäive DESC;
```

HAVING on eriti väärtuslik anomaaliate leidmisel. Näiteks Liis Koppeli varude probleem: ta leidis tooted, kus süsteemi ja füüsilise inventuuri vahe oli suur, kasutades HAVING filtrit:

```sql
SELECT
    p.product_name,
    SUM(CASE WHEN im.movement_type = 'IN' THEN im.quantity ELSE 0 END) AS sisse,
    SUM(CASE WHEN im.movement_type = 'OUT' THEN im.quantity ELSE 0 END) AS välja,
    SUM(CASE WHEN im.movement_type = 'IN' THEN im.quantity ELSE -im.quantity END) AS vahe
FROM inventory_movements im
JOIN products p ON im.product_id = p.product_id
WHERE im.location = 'tartu'
GROUP BY p.product_name
HAVING ABS(SUM(CASE WHEN im.movement_type = 'IN' THEN im.quantity ELSE -im.quantity END)) > 5
ORDER BY vahe DESC;
```

## CTE-d: Common Table Expressions

CTE ehk Common Table Expression on nagu ajutine tabel, mille sa lood päringu sees. Sa kirjutad WITH-klausli, annad tulemusele nime ja seejärel kasutad seda nime põhipäringus. Miks see kasulik on? Sest keerulised päringud muutuvad loetavamaks.

Mõtle CTE-le kui vahetulemuste tabelile. Selle asemel, et kirjutada üks tohutu päring, jaotatad sa loogika loogilisteks osadeks. Iga CTE teeb ühe asja ja lõpppäring paneb kõik kokku.

```sql
WITH kuu_myyk AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS käive
    FROM sales
    WHERE sale_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT
    kuu,
    käive,
    LAG(käive) OVER (ORDER BY kuu) AS eelmine_kuu,
    käive - LAG(käive) OVER (ORDER BY kuu) AS kasv
FROM kuu_myyk
ORDER BY kuu;
```

Siin on kaks sammu: esiteks arvutame iga kuu käive (CTE osa), siis võrdleme kuid omavahel (põhipäring). Ilma CTE-ta peaks sa kirjutama ühe pika ja raskesti loetava päringu.

Sa saad ka kasutada mitut CTE-d korraga, eraldades need komaga:

```sql
WITH kliendiinfo AS (
    SELECT
        customer_id,
        first_name || ' ' || last_name AS nimi,
        city
    FROM customers
),
kliendi_tellimused AS (
    SELECT
        customer_id,
        COUNT(*) AS tellimusi,
        SUM(total_price) AS kogukäive
    FROM sales
    GROUP BY customer_id
)
SELECT
    k.nimi,
    k.city,
    kt.tellimusi,
    kt.kogukäive,
    CASE
        WHEN kt.kogukäive > 1000 THEN 'VIP'
        WHEN kt.kogukäive > 500 THEN 'Aktiivne'
        ELSE 'Tavaline'
    END AS segment
FROM kliendiinfo k
JOIN kliendi_tellimused kt ON k.customer_id = kt.customer_id
ORDER BY kt.kogukäive DESC;
```

Siin on kaks CTE-d: üks kliendiinfo jaoks, teine tellimuste koondandmete jaoks. Lõpppäring ühendab need ja lisab kliendigmendid. See on palju loetavam kui üks hiiglaslik päring.

**CTE vs Subquery** ehk alampäring: millal kumba kasutada? CTE on parem, kui sa pead tulemust kasutama mitu korda või kui loogika on keeruline. Subquery sobib lihtsateks juhtudeks, näiteks "leia tooted, mille hind on üle keskmise":

```sql
SELECT product_name, retail_price
FROM products
WHERE retail_price > (SELECT AVG(retail_price) FROM products);
```

Siin on subquery lihtsam. Aga kui sul on kolm astet loogikat, siis CTE on selgelt parem valik.

Veel üks CTE eelis: see muudab debugging-u ehk vigade otsimise lihtsamaks. Kui su CTE-dega päring ei tööta, saad sa iga CTE-d eraldi käivitada ja kontrollida, kas vahetulemused on õiged. Suure alamõpäringu puhul on seda palju raskem teha.

CTE-d on ka väga head meeskonnatööks. Kui keegi teine loeb su koodi, on CTE-dega päring palju selgem: iga nimega CTE ütleb, mida see teeb. Näiteks `kuu_myyk` on kohe arusaadav, aga viietasemeline alamõpäring nõuab pikka uurimist. Hea andmeanalüütik kirjutab koodi, mida teised mõistavad.

## Window Functions: Uus Dimensioon

Window functions ehk akna funktsioonid on nagu GROUP BY noorem ja võimekam sugulane. Erinevus on selles, et GROUP BY koondab read kokku (sa kaotad üksikud read), aga window functions lisavad koondväärtuse igale reale ilma ridu kaotamata.

Süntaks kasutab OVER-klauslit:

```sql
FUNKTSIOON() OVER (
    PARTITION BY veerg    -- Millisesse gruppi rida kuulub
    ORDER BY veerg        -- Millises järjekorras arvutada
)
```

**ROW_NUMBER()** annab igale reale järjekorranumbri. See on väga kasulik TOP-N päringute jaoks partitsioonide sees. Näiteks: millised on TOP 3 toodet igas kategoorias?

```sql
WITH toote_myyk AS (
    SELECT
        p.category,
        p.product_name,
        SUM(s.quantity) AS müüdud,
        ROW_NUMBER() OVER (
            PARTITION BY p.category
            ORDER BY SUM(s.quantity) DESC
        ) AS koht
    FROM products p
    JOIN sales s ON p.product_id = s.product_id
    GROUP BY p.category, p.product_name
)
SELECT category, product_name, müüdud, koht
FROM toote_myyk
WHERE koht <= 3;
```

PARTITION BY category tähendab, et järjestusnumbrid alustavad igast kategooriast uuesti. Ilma PARTITION BY-ta oleks üks pikk järjestus üle kõigi toodete.

**RANK() ja DENSE_RANK()** on sarnased ROW_NUMBER-iga, aga käituvad viikide korral erinevalt. Kui kahel tootel on sama müügikogus, siis ROW_NUMBER annab neile siiski erinevad numbrid (1, 2), RANK annab sama numbri ja jätab järgmise vahele (1, 1, 3), DENSE_RANK annab sama numbri aga ei jäta vahele (1, 1, 2).

**LAG() ja LEAD()** on võrdlusfunktsioonid. LAG annab eelmise rea väärtuse, LEAD järgmise rea väärtuse. Need on ideaalsed kasvu arvutamiseks: "kui palju käive kasvas võrreldes eelmise kuuga?"

**SUM() OVER** on jooksev kogusumma ehk running total. See näitab kumulatiivset väärtust:

```sql
WITH kuu_myyk AS (
    SELECT
        DATE_TRUNC('month', sale_date) AS kuu,
        SUM(total_price) AS käive
    FROM sales
    GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT
    kuu,
    käive,
    SUM(käive) OVER (ORDER BY kuu) AS kumulatiivne_käive
FROM kuu_myyk;
```

See näitab, kuidas aastane käive kasvab kuust kuusse. Väga visuaalne ja juhile arusaadav number. Investorid armastavad seda graafikut, sest see näitab aasta kumulatiivset kasvu ühel joonel.

Oluline on mõista GROUP BY ja window functions erinevust veel selgemalt. GROUP BY koondab ja sa kaotad detailid: 10 000 rida muutuvad 12 reaks (üks iga kuu kohta). Window functions säilitavad kõik 10 000 rida, aga lisavad igale reale koondväärtuse. Mõlemad on vajalikud, aga erinevatel eesmärkidel.

Praktikas kasutad GROUP BY-d, kui sa tahad koondvaadet: "müük kuude kaupa", "käive linnade kaupa". Window functions kasutad, kui sa tahad järjestada, võrrelda perioode või arvutada jooksvaid summasid. Sageli kasutad mõlemat koos: CTE-s teed GROUP BY ja põhipäringus lisad window function-eid.

## SQL Päringu Täitmise Järjekord

Agregatsiooni mõistmiseks on kasulik teada, mis järjekorras SQL andmebaas su päringu tegelikult läbi töötab. See ei ole sama järjekord, milles sa päringu kirjutad.

Sa kirjutad: SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY. Aga andmebaas täidab seda hoopis nii: FROM (millistest tabelitest?), WHERE (millised read?), GROUP BY (millised grupid?), HAVING (millised grupid jäävad alles?), SELECT (millised veerud ja arvutused?), ORDER BY (millises järjekorras?).

See selgitab, miks sa ei saa WHERE-is kasutada agregaatfunktsioone: WHERE käivitatakse enne GROUP BY-d, seega gruppe ja koondväärtuseid pole veel olemas. HAVING käivitatakse pärast GROUP BY-d, seega koondväärtused on juba arvutatud.

See selgitab ka, miks sa ei saa WHERE-is kasutada SELECT-is defineeritud aliaseid: SELECT käivitatakse pärast WHERE-i. Aga ORDER BY käivitatakse viimasena, seega seal saad aliaseid kasutada.

See järjekord on oluline mõista, sest see aitab sul vigu leida ja päringuid optimeerida. Kui sa tead, et WHERE filtreerib enne grupeerimist, saad sa teha päringu efektiivsemaks: mida rohkem ridu sa WHERE-iga välja filtreerid, seda vähem tööd GROUP BY peab tegema.

## Kuupäevadega Töötamine Agregatsioonis

Kuupäevad on andmeanalüüsis kõikjal ja SQL annab sulle mitu head tööriista nendega toimetamiseks.

**DATE_TRUNC** ümardab kuupäeva soovitud täpsuseni. DATE_TRUNC('month', '2024-03-15') annab '2024-03-01'. See on ideaalne GROUP BY jaoks, kui tahad grupeerida kuude, kvartalite või aastate kaupa.

**TO_CHAR** teisendab kuupäeva stringiks. TO_CHAR(sale_date, 'YYYY-MM') annab '2024-03'. See on kasulik loetavuse jaoks, eriti kui eksportid tulemusi aruandesse.

**EXTRACT** eraldab kuupäevast ühe osa. EXTRACT(DOW FROM sale_date) annab nädalapäeva numbrina (0 = pühapäev, 1 = esmaspäev). See on kasulik, kui tahad analüüsida, millistel nädalapäevadel müüakse kõige rohkem.

```sql
SELECT
    EXTRACT(DOW FROM sale_date) AS nädalapäev,
    COUNT(*) AS tellimusi,
    SUM(total_price) AS käive
FROM sales
GROUP BY EXTRACT(DOW FROM sale_date)
ORDER BY nädalapäev;
```

## Andmete Usaldusväärsus ja Valideerimine

Agregatsioon pole ainult koondnumbrite arvutamine. See on ka kontrollitööriist. Kui sa koondad andmeid ja tulemused tunduvad kummalised, siis oled võib-olla leidnud vea.

Näiteks: kui sa arvutad kogumüügi ja see on negatiivsena, siis midagi on valesti. Kui keskmine tellimusväärtus on ootamatult suur, on ehk mõni vigane kirje. Kui mõne kuu müük on null, siis kas tõesti ei müüdud midagi või puuduvad andmed?

UrbanStyle'i puhul on see eriti oluline, sest andmebaas sisaldab tahtlikult vigu: NULL-väärtuseid, duplikaate ja ebakonsistentseid hindu. Agregatsioon aitab neid leida:

```sql
-- Kas mõnel tootel on müügihind erinev tootetabeli hinnast?
SELECT
    p.product_name,
    p.retail_price AS kataloogi_hind,
    AVG(s.unit_price) AS keskmine_müügihind,
    COUNT(*) AS tehinguid
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name, p.retail_price
HAVING ABS(p.retail_price - AVG(s.unit_price)) > 1
ORDER BY ABS(p.retail_price - AVG(s.unit_price)) DESC;
```

Selline päring leiab kõik tooted, kus tegelik müügihind erineb kataloogihinnast rohkem kui 1 euro. See on andmekvaliteedi kontroll ja oluline osa andmeanalüütiku tööst.

## Agregatsioon Ärikontekstis: KPI-d

Ärielus tähendab agregatsioon KPI-de ehk võtmenäitajate arvutamist. Siin on UrbanStyle'i kontekstis olulisimad:

**Kogutulu (Revenue):** SUM(total_price). Lihtne, aga kõige olulisem number.

**Keskmine tellimusväärtus (AOV):** AVG(total_price). See näitab, kui palju keskmiselt ühe tellimuse eest makstakse. Kui AOV kasvab, on see hea märk.

**Korduvad kliendid:** COUNT(DISTINCT customer_id) koos HAVING tellimusi > 1. See näitab kliendilojaalsust. UrbanStyle'ile on see eriti oluline, sest lojaalsed kliendid on väärtuslikumad.

**Müük kanali kaupa:** GROUP BY channel. See näitab, kas online või füüsiline pood müüb rohkem. UrbanStyle'il on umbes 60% online ja 40% füüsilises poes.

**Müük kanali kaupa:** GROUP BY channel. See näitab, kas online või füüsiline pood müüb rohkem. UrbanStyle'il on umbes 60% online ja 40% füüsilises poes. See suhtarv on oluline, sest online-müügi marginaal on tavaliselt erinev füüsilise poe omast.

**Müük linna kaupa:** GROUP BY city. See näitab geograafilist jõudlust: Tallinn vs Tartu vs Pärnu. Kui Tartu müük langeb, aga Tallinna oma kasvab, siis on vaja uurida, miks. Ehk on Tartu poes probleeme? Ehk on kohalik konkurents kasvanud?

**Brutomarginaal kategooria kaupa:** See arvutatakse (retail_price - cost_price) / retail_price. Mõni kategooria võib müüa palju, aga madala marginaaliga. Teine kategooria müüb vähem, aga kõrge marginaaliga. Juhile on oluline teada mõlemat.

**Varude käibekordaja:** See on müüdud toodete kogus jagatud keskmise laovaruga. Kõrge käibekordaja tähendab, et tooted liiguvad kiiresti. Madal käibekordaja tähendab, et tooted istuvad laos ja seovad raha kinni. Liis Koppel jälgib seda numbrit iga päev.

Kõik need KPI-d on numbrid, mida investorid tahavad näha. Kristi Tamm peab need esitama, kui ta otsib lisarahastust ettevõtte kasvuks. Ja andmeanalüütik on see inimene, kes need numbrid välja arvutab.

## Tavaline Töövoog: Kuidas Analüütik Agregatsiooni Kasutab

Vaatame, kuidas näeb välja tüüpiline tööpäev, kus agregatsioon on kesksel kohal.

Hommikul tuleb Anna Mets su juurde ja ütleb: "Kristi küsib, kuidas see kuu läheb võrreldes eelmisega." Sa avad SQL Editor-i ja kirjutad kiire päringu:

```sql
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS käive
FROM sales
WHERE sale_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;
```

Saad kaks rida: eelmise kuu ja jooksva kuu käive. Arvutad kasvu protsendi ja saadad Annale: "Jooksev kuu on 12% ees eelmisest kuust, aga kuu pole veel läbi."

Pärast lõunat helistab Liis ja küsib: "Millised tooted on Pärnu poes otsa saanud?" Sa kirjutad:

```sql
SELECT p.product_name, i.quantity_available
FROM inventory i
JOIN products p ON i.product_id = p.product_id
WHERE i.location = 'parnu' AND i.quantity_available = 0;
```

See pole isegi GROUP BY, aga see viib järgmise küsimuseni: "Kui kiiresti need tooted müüsid?" Ja siin on juba agregatsiooni vaja.

Õhtul valmib su aruanne: üks Google Sheet kolme kaardiga, mille sa lood SQL-päringutest eksportides. Kristile müügitrendid, Annale turunduse ROI, Liisile varude seisund. Kolm erinevat sidusrühma, kolm erinevat vaadet samadele andmetele. See on andmeanalüütiku elu.

## Kokkuvõte

Agregatsioon on andmeanalüütiku üks olulisemaid tööriistu. GROUP BY koondab andmeid gruppidesse, agregaatfunktsioonid arvutavad iga grupi kohta koondväärtuseid, HAVING filtreerib gruppe ja CTE-d muudavad keerulised päringud loetavaks. Window functions lisavad uue dimensiooni, võimaldades arvutada koondväärtuseid ilma ridu kaotamata.

Kõige olulisem on aga see: agregatsioon ei ole lihtsalt tehniline oskus. See on viis, kuidas sa muudad andmed vastusteks. Ja vastused on see, mida äri vajab. Kui sa oskad koostada päringu, mis vastab küsimusele "kuidas meie müük muutub?" või "kes on meie parimad kliendid?", siis sa ei ole enam lihtsalt SQL-i kirjutaja, vaid andmeanalüütik, kes aitab ettevõttel paremaid otsuseid teha.

Järgmisel nädalal hakkad sa neid numbreid visualiseerima: graafikud, dashboard'id ja andmete jutustamine. Aga enne seda on sul vaja kindlat alust: hästi kirjutatud agregatsiooni päringuid, mis annavad täpsed ja usaldusväärsed tulemused.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist. Optimeeritud NotebookLM audio genereerimiseks.*

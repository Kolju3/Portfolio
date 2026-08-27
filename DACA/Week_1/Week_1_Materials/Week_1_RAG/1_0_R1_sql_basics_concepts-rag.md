# SQL Põhitõed: Sinu Esimene Keel Andmetega Rääkimiseks

## Sissejuhatus

SQL on andmeanalüütiku kõige olulisem tööriist. Kui sa õpid elu jooksul ainult ühe tehnilise oskuse andmeanalüüsiks, siis see peaks olema SQL. Miks? Sest iga ettevõte, iga andmebaas, iga analüütiku töökoht kasutab SQL-i mingil kujul. See on universaalne keel, millega sa räägid andmebaasidega.

SQL ehk Structured Query Language loodi 1970. aastatel ja see on siiamaani maailma kõige populaarsem andmepäringute keel. Aga ära lase vanusel end eksitada. SQL on aktuaalsem kui kunagi varem, sest andmeid on rohkem kui kunagi varem. Ja see on üllatavalt lihtne õppida, eriti kui sa mõtled sellele mitte kui programmeerimiskeelele, vaid kui viisile küsimuste esitamiseks.

Selles dokumendis õpid sa SQL-i põhilised ehituskivid: SELECT, WHERE, ORDER BY, LIMIT, DISTINCT ja COUNT. Need kuus kontseptsiooni on piisavad, et sa saaksid juba päris andmetega töötada ja Toomas Kaski esimesele väljakutsele vastata.

---

## Mis On SQL ja Miks See On Number Üks Andmeanalüütiku Oskus

SQL on keel, millega sa esitad andmebaasile küsimusi. Kujuta ette, et andmebaas on nagu hiiglaslik raamatukogu. SQL on keel, millega sa ütled raamatukoguhoidjale, mida sa otsid. "Näita mulle kõik raamatud, mis on avaldatud pärast 2020. aastat" on SQL-is midagi sellist: SELECT * FROM raamatud WHERE avaldamise_aasta > 2020.

Tähtsaim erinevus SQL-i ja tavaprogrammeerimiskeelte vahel on see, et SQL on deklaratiivne keel. See tähendab, et sa ütled andmebaasile, MIDA sa tahad, mitte KUIDAS seda teha. Sa ütled: "Anna mulle kõik kliendid Tallinnast." Sa ei pea ütlema: "Vaata esimest rida, kontrolli linna, kui on Tallinn siis lisa tulemusele, liigu järgmisele reale." Andmebaas ise otsustab, kuidas sinu küsimusele kõige efektiivsemalt vastata.

Miks on SQL number üks andmeanalüütiku oskus? LinkedIn ja teised tööportaalid näitavad, et SQL on kõige nõutum tehniline oskus andmeanalüütiku ametikohtadel, olles ees isegi Pythonist ja Excelist. See on sellepärast, et SQL on universaalne. PostgreSQL, MySQL, SQL Server, BigQuery -- kõik kasutavad SQL-i ja kuigi neil on väikseid erinevusi, on põhisüntaks sama. Kui sa õpid SQL-i ühes süsteemis, saad sa kasutada seda igal pool.

---

## SELECT: Vali, Mida Tahad Näha

SELECT on SQL-i kõige fundamentaalsem käsk. Kõik algab SELECT-ist. See ütleb andmebaasile: "Ma tahan näha neid andmeid."

Kõige lihtsam SELECT päring näeb välja nii:

```sql
SELECT * FROM sales;
```

See ütleb: "Näita mulle KÕIKI veerge KÕIGIST ridadest sales tabelist." Tärn ehk asterisk tähendab "kõik veerud". FROM ütleb, millisest tabelist.

Aga tavaliselt sa ei taha kõiki veerge. Sa tahad konkreetseid. Siis kirjutad veergude nimed:

```sql
SELECT customer_id, first_name, city FROM customers;
```

See ütleb: "Näita mulle ainult kliendi ID, eesnimi ja linn klientide tabelist." See on nagu Excelis veergude peitmise asemel ainult vajalike veergude nägemine.

Mõned olulised asjad, mida meeles pidada. SQL-is ei ole vahet suur- ja väiketähtedel käskude puhul. SELECT, Select ja select töötavad kõik samamoodi. Aga hea tava on kirjutada SQL käsksõnad suurtähtedega, et need eristuksid tabeli ja veergude nimedest. Iga päring lõppeb semikooloniga, mis on nagu lause lõppu pandud punkt. Ja veergude nimed eraldatakse komadega.

---

## WHERE: Filtreeri Andmeid

WHERE on koht, kus SQL muutub tõeliselt kasulikuks. Ilma WHERE-ta saad kõik andmed. WHERE-ga saad täpselt need andmed, mida vajad.

```sql
SELECT * FROM sales WHERE channel = 'online';
```

See ütleb: "Näita mulle kõik müügid, mis toimusid veebikanalis." Märka, et tekstväärtused on ülakomade sees ja võrdusmärk on üksik võrdusmärk, mitte topelt nagu mõnes programmeerimiskeeles.

WHERE-s saad kasutada mitut operaatorit. Võrdusmärk kontrollib täpset vastet. Suurem kui ja väiksem kui toimivad nagu matemaatikas. BETWEEN annab sulle vahemiku, näiteks WHERE unit_price BETWEEN 20 AND 50 leiab kõik tooted, mille hind on 20 ja 50 euro vahel. IN laseb kontrollida mitut väärtust korraga, näiteks WHERE city IN ('Tallinn', 'Tartu') leiab kliendid mõlemast linnast. Ja LIKE on mustri järgi otsimine, näiteks WHERE product_name LIKE '%kleit%' leiab kõik tooted, mille nimes on sõna "kleit".

Sa saad kombineerida mitu tingimust AND ja OR abil. AND tähendab, et mõlemad tingimused peavad olema tõesed. OR tähendab, et vähemalt üks peab olema tõene.

```sql
SELECT * FROM sales
WHERE channel = 'store'
AND store_location = 'Tallinn'
AND total_price > 100;
```

See ütleb: "Näita mulle kõik poemüügid Tallinnas, kus summa ületas 100 eurot."

Veel üks oluline operaator on NOT EQUAL ehk "ei võrdu", mida SQL-is kirjutatakse <> sümbolitega. Näiteks WHERE city <> 'Tallinn' leiab kõik kliendid, kes EI ole Tallinnast.

---

## ORDER BY: Sorteeri Tulemused

Kui sa tahad tulemusi kindlas järjekorras, kasutad ORDER BY-d. Vaikimisi sorteerib SQL tulemusi kasvavas järjekorras ehk ASC, mis tähendab ascending ehk väiksemast suuremani. Kui sa tahad kahanevat järjekorda, lisad DESC ehk descending.

```sql
SELECT * FROM sales ORDER BY total_price DESC;
```

See ütleb: "Näita mulle kõik müügid, sorteerituna suurimast summast väikseimani." See on kasulik, kui sa tahad leida kõige suuremaid müüke.

```sql
SELECT * FROM sales ORDER BY sale_date ASC;
```

See sorteerib vanemast uuemani. Kuupäevade puhul tähendab ASC kronoloogilist järjekorda ja DESC pööratud kronoloogilist järjekorda.

Sa saad sorteerida mitme veeru järgi korraga:

```sql
SELECT * FROM customers ORDER BY city ASC, last_name ASC;
```

See sorteerib esmalt linna järgi ja siis iga linna sees perekonnanime järgi. See on nagu Excelis mitme taseme sorteerimine.

ORDER BY on eriti kasulik koos WHERE-ga. Näiteks, kui sa tahad leida kõige suuremad müügid Tartus:

```sql
SELECT * FROM sales
WHERE store_location = 'Tartu'
ORDER BY total_price DESC;
```

---

## LIMIT: Kontrolli Tulemuste Hulka

LIMIT on lihtne, aga oluline käsk. See piirab, mitu rida tulemustest kuvatakse.

```sql
SELECT * FROM sales LIMIT 10;
```

See ütleb: "Näita mulle ainult esimesed 10 rida." See on eriti kasulik kahel juhul. Esiteks, testimisel. Kui sa kirjutad uut päringut ja tahad kontrollida, kas see töötab, kasuta LIMIT 10, et mitte kogemata 15 000 rida ekraanile laadida. Teiseks, "top N" küsimuste vastamisel.

```sql
SELECT * FROM sales ORDER BY total_price DESC LIMIT 10;
```

See annab sulle 10 kõige suuremat müüki. See on üks kõige sagedamini kasutatavaid päringukombinatsioone andmeanalüüsis: ORDER BY DESC LIMIT N ehk "anna mulle top N".

Proovi mõelda, millised küsimused saab vastata "top N" päringutega UrbanStyle'i kontekstis. Kes on 10 kõige rohkem kulutanud klienti? Millised on 5 kalleimat toodet? Millised on 20 viimast müügitehingut? Kõik need on ORDER BY pluss LIMIT päringud.

---

## DISTINCT: Leia Unikaalsed Väärtused

DISTINCT on käsk, mis eemaldab tulemustest duplikaadid ja näitab ainult unikaalseid väärtusi.

```sql
SELECT DISTINCT city FROM customers;
```

See ütleb: "Millised erinevad linnad on klientide tabelis?" Tulemus võib olla Tallinn, Tartu, Pärnu ja mõned teised. Ilma DISTINCT-ta saaksid sa iga linna mitu korda, sest iga klient on eraldi rida.

DISTINCT on väga kasulik andmete uurimisel. Kui sa tahad teada, millised kategooriad on toodete tabelis:

```sql
SELECT DISTINCT category FROM products;
```

Või millised müügikanalid on kasutuses:

```sql
SELECT DISTINCT channel FROM sales;
```

DISTINCT töötab ka mitme veeruga:

```sql
SELECT DISTINCT city, loyalty_tier FROM customers;
```

See näitab kõiki unikaalseid linna ja lojaalsuse taseme kombinatsioone. Näiteks Tallinn-bronze, Tallinn-silver, Tallinn-gold, Tartu-bronze ja nii edasi.

DISTINCT on ka kasulik duplikaatide tuvastamiseks, kui sa võrdled COUNT(*) ja COUNT(DISTINCT veerg) tulemusi. Aga sellest räägime COUNT peatükis.

---

## COUNT: Loe Andmeid Kokku

COUNT on esimene agregeerimisfunktsioon, mida sa õpid. See loeb ridu kokku ja on andmeanalüütiku üks enim kasutatud tööriistu.

```sql
SELECT COUNT(*) FROM sales;
```

See ütleb: "Mitu rida on sales tabelis kokku?" Tärn COUNT(*) sees tähendab "loe kõiki ridu, ka neid, kus mõned veerud on NULL."

Aga COUNT-il on oluline nüanss. COUNT(*) ja COUNT(veerg) annavad erinevaid tulemusi!

```sql
SELECT COUNT(*) FROM customers;         -- Loeb KÕIKI ridu
SELECT COUNT(email) FROM customers;     -- Loeb ainult ridu, kus email EI OLE NULL
```

Vahe on NULL väärtustes. COUNT(*) loeb kõiki ridu, sealhulgas neid, kus mõned veerud on tühjad. COUNT(veerg) loeb ainult neid ridu, kus see konkreetne veerg ei ole NULL. See erinevus on väga oluline, sest see aitab tuvastada puuduvaid andmeid.

Kuidas leida puuduvate andmete arvu? Lahutad:

```sql
SELECT COUNT(*) - COUNT(email) AS puuduvad_emailid FROM customers;
```

See annab sulle arvu, mitu klienti on ilma e-mailita.

COUNT ja DISTINCT töötavad koos suurepäraselt:

```sql
SELECT COUNT(DISTINCT invoice_id) FROM sales;
```

See loeb unikaalsete arvete arvu. Kui sa võrdled seda COUNT(*)-ga, saad teada duplikaatide arvu:

```sql
SELECT COUNT(*) AS kogu_read FROM sales;                    -- Näiteks 15234
SELECT COUNT(DISTINCT invoice_id) AS unikaalseid FROM sales; -- Näiteks 10118
-- Vahe: 15234 - 10118 = 5116 duplikaati!
```

See on täpselt see avastus, mille Toomas Kask tegi ja mille pärast ta sulle kirjutas.

---

## NULL: Puuduv Väärtus, Mida Tuleb Mõista

NULL on üks kõige olulisemaid ja samas kõige segadust tekitavamaid kontseptsioone SQL-is. NULL ei ole null. NULL ei ole tühi string. NULL tähendab "puudub" ehk "teadmata".

Kujuta ette klienti, kes registreeris end poodi, aga ei andnud e-maili aadressi. Tema email veerg on NULL. See ei tähenda, et tema email on "null" või "" (tühi string). See tähendab, et me lihtsalt ei tea tema e-maili.

NULL-i kontrollimisel sa EI SAA kasutada tavalist võrdusmärki:

```sql
-- VALE! See ei tööta!
SELECT * FROM customers WHERE email = NULL;

-- ÕIGE! Kasuta IS NULL
SELECT * FROM customers WHERE email IS NULL;

-- Või vastupidi, leia kõik, kellel ON email
SELECT * FROM customers WHERE email IS NOT NULL;
```

See on üks sagedamaid algajate vigu. WHERE email = NULL ei tagasta kunagi midagi, sest NULL ei ole võrdne millegagi, isegi mitte teise NULL-iga. Alati kasuta IS NULL või IS NOT NULL.

UrbanStyle'i andmebaasis on NULL väärtusi mitmes kohas: klientide e-mailid, veebikülastuste kliendi ID (kui külastaja pole registreeritud) ja mõned toodete andmed. NULL-ide leidmine ja mõistmine on andmepuhastuse esimene samm.

---

## Kuidas SQL Mõtlemine Erineb Exceli Mõtlemisest

Kui sa tuled Exceli maailmast, on üleminek SQL-ile esialgu veider. Excelis sa NÄED andmeid kogu aeg. Sa kerid, filtreerid, värvid lahtrid. SQL-is sa EI NÄE andmeid, kuni sa küsid. Sa kirjutad päringu ja andmebaas vastab.

Exceli filter on nagu SQL WHERE. Exceli sorteerimine on nagu SQL ORDER BY. Exceli COUNTIF on nagu SQL COUNT koos WHERE-ga. Aga SQL on palju võimsam, sest ta saab töödelda miljoneid ridu sekunditega, samal ajal kui Excel hakkab 100 000 reaga juba aeglaseks muutuma.

Veel üks oluline erinevus: Excelis muudad sa sageli algandmeid, näiteks kustutad ridu, muudad lahtri väärtust. SQL-is on hea tava mitte muuta algandmeid, vaid teha päringuid, mis näitavad andmeid uuel kujul. Selle nädala jooksul sa ei muuda midagi, ainult vaatad ja analüüsid.

---

## Sagedased Algajate Vead ja Kuidas Neid Vältida

Igal algajal juhtuvad samad vead SQL-iga. Siin on kõige levinumad ja kuidas neid vältida.

Esimene viga on puuduv semikoolon. Iga SQL päring peab lõppema semikooloniga. Kui sa unustad selle, saad veateate. Harjuta lõpetama iga päring semikooloniga.

Teine viga on vale ülakomade kasutamine. Tekstväärtused peavad olema ülakomade sees: WHERE city = 'Tallinn'. Numbrid on ilma ülakomadeta: WHERE total_price > 100. Ära aja neid segamini.

Kolmas viga on NULL-i kontrollimine võrdusmärgiga. Nagu eespool mainitud, kasuta alati IS NULL, mitte = NULL.

Neljas viga on liiga suure tulemuse küsimine. Ära kirjuta SELECT * FROM sales ilma LIMIT-ta, kui sa pole kindel, kui palju ridu tabelis on. Alusta alati LIMIT 10 või LIMIT 100-ga.

Viies viga on kommentaaride puudumine. SQL-is algab kommentaar kahe kriipsuga: -- See on kommentaar. Lisa alati kommentaarid, mis selgitavad, mida päring teeb ja miks. See aitab sind ennast nädala pärast ja ka Toomast, kes sinu tööd kontrollib.

---

## SQL Päringute Järjekord: Kuidas Andmebaas Su Küsimust Loeb

SQL päringul on kindel struktuur ja järjekord. Tüüpiline päring näeb välja nii:

```sql
SELECT veerg1, veerg2           -- 1. Mida ma tahan näha?
FROM tabel                      -- 2. Kust ma seda otsin?
WHERE tingimus                  -- 3. Milliseid ridu ma tahan?
ORDER BY veerg DESC             -- 4. Mis järjekorras?
LIMIT 10;                       -- 5. Kui palju?
```

See on nagu küsimuse esitamine: "Näita mulle (SELECT) tabelist (FROM) need read, kus (WHERE) tingimus kehtib, sorteeri (ORDER BY) nii ja piira (LIMIT) sellele arvule."

Oluline on teada, et SQL töötleb päringut TEISES järjekorras kui sa seda loed. Andmebaas kõigepealt vaatab FROM ehk millist tabelit, siis WHERE ehk milliseid ridu, siis SELECT ehk milliseid veerge, siis ORDER BY ehk mis järjekorras ja lõpuks LIMIT. See selgitab, miks mõned asjad töötavad ja mõned mitte, aga algajana ei pea sa selle pärast veel muretsema. Piisab, kui sa järgid ülaltoodud struktuuri.

---

## Kuidas Mõelda Nädal 1 Päringutele: Küsimus Enne Koodi

Algaja kõige loomulikum harjumus on alustada koodist: "Millise SQL käsu ma pean kirjutama?" Andmeanalüütiku töö algab siiski teistsugusest küsimusest: "Mida ma tahan teada?" Alles siis tuleb SQL. See väike mõtteviisi muutus teeb õppimise palju rahulikumaks.

Näiteks kui Toomas küsib, kas `sales` tabelit saab usaldada, ei tähenda see kohe ühte valmis SQL käsku. See tähendab mitut väikest küsimust:

- mitu rida tabelis üldse on;
- mitu unikaalset arvet seal on;
- kas mõni oluline väärtus puudub;
- kas summades on midagi kahtlast;
- millised kanalid ja asukohad andmetes esinevad.

Iga selline küsimus muutub üheks lihtsaks päringuks. SQL ei pea alguses olema pikk ega nutikas. Hea algaja päring on lühike, loetav ja vastab ühele konkreetsele küsimusele. Kui päring muutub liiga pikaks, on see sageli märk, et küsimus tuleks jagada väiksemateks osadeks.

Kasulik on kasutada kolmeastmelist rütmi:

```sql
-- 1. Vaata väikest näidist
SELECT *
FROM sales
LIMIT 10;

-- 2. Loe kokku
SELECT COUNT(*) AS ridu_kokku
FROM sales;

-- 3. Uuri ühte konkreetset mustrit
SELECT DISTINCT channel
FROM sales;
```

Esimene päring aitab sul tabeliga tutvuda. Teine annab suurusjärgu. Kolmas hakkab otsima struktuuri. See on palju parem kui kohe keerulist raportit ehitada.

Nädal 1-s on lubatud ja isegi soovitatav teha palju väikeseid päringuid. Sa ei pea kohe teadma, milline neist "õige" on. Andmete uurimine ongi iteratiivne: küsid, vaatad vastust, saad uue mõtte, küsid uuesti. Just nii töötavad ka kogenud analüütikud.

---

## Kommentaarid ja Loetavus: Kirjuta SQL Tulevasele Endale

SQL päring ei ole ainult masinale. See on ka inimesele. Kui sa vaatad oma päringut nädala pärast, peaksid aru saama, miks sa selle kirjutasid. Sellepärast kasutame kommentaare.

Kommentaar algab kahe kriipsuga:

```sql
-- Kontrollin, mitu rida sales tabelis kokku on
SELECT COUNT(*) AS ridu_kokku
FROM sales;
```

Hea kommentaar ei korda lihtsalt SQL-i sõnu. Halb kommentaar oleks: "Valin count sales tabelist." Hea kommentaar selgitab eesmärki: "Kontrollin, kas imporditud ridade arv vastab oodatule." See aitab sul siduda tehnilise päringu ärilise mõttega.

Ka veerunimed tulemuses võiksid olla loetavad. Selleks kasutame `AS` alias't:

```sql
SELECT COUNT(*) AS ridu_kokku
FROM sales;
```

Ilma alias'ta võib tulemusveeru nimi olla `count`, mis ei ütle hiljem eriti palju. Alias `ridu_kokku` on selgem. Sama kehtib näiteks `unikaalseid_arveid`, `puuduvad_emailid` või `kahtlased_summad` kohta.

Loetav SQL kasutab tavaliselt iga suuremat osa eraldi real:

```sql
SELECT sale_id, sale_date, total_price
FROM sales
WHERE total_price > 500
ORDER BY total_price DESC
LIMIT 10;
```

See on palju loetavam kui kõik ühel real. Andmeanalüütiku portfoolios on loetavus osa professionaalsusest. Mentor ei vaata ainult seda, kas päring töötab; ta vaatab ka seda, kas sinu mõttekäik on jälgitav.

---

## Veateated Kui Õppimise Osa

SQL õppimisel saad sa veateateid. See ei tähenda, et sa "ei oska". See tähendab, et andmebaas annab sulle tagasisidet. Alguses on veateated ebamugavad, aga neist saab väga hea õpetaja.

Kui näed teadet, et veergu ei eksisteeri, kontrolli kolme asja:

- kas veeru nimi on õigesti kirjutatud;
- kas oled õiges tabelis;
- kas kasutasid õiget alakriipsu või tühikuteta nime.

Näiteks `store_location` ja `store location` ei ole sama. SQL tabelites kasutatakse enamasti alakriipse, sest veerunimedes tühikuid ei kasutata.

Kui näed süntaksiviga, otsi esmalt väga lihtsaid asju:

- kas semikoolon on lõpus;
- kas tekstväärtus on ülakomades;
- kas `FROM` on olemas;
- kas `ORDER BY` tuleb pärast `WHERE`;
- kas `LIMIT` on päringu lõpus.

Hea harjumus on parandada ainult üks asi korraga. Kui muudad korraga viis asja, ei tea sa, milline muutus vea lahendas. Kui parandad ühe asja ja käivitad uuesti, õpid palju kiiremini.

AI võib siin olla hea õpipartner, kui annad talle piisavalt konteksti. Halb küsimus on "miks ei tööta?". Parem küsimus on: "Õpin SQL-i PostgreSQL-is. Minu päring on [päring] ja veateade on [veateade]. Selgita algajale eesti keeles, mida kontrollida." Nii saad vastuse, mis aitab õppida, mitte ainult kiire paranduse.

---

## Miks Me Nädal 1-s Veel JOIN-e Ei Kasuta

Kui oled varem kuulnud SQL-ist, oled tõenäoliselt kuulnud ka JOIN-idest. JOIN võimaldab ühendada mitu tabelit, näiteks `sales` ja `products`, et näha müüki koos tootenimega. See on väga oluline oskus, aga Nädal 1-s me ei alusta sealt.

Põhjus on lihtne: enne tabelite ühendamist peab oskama ühte tabelit rahulikult lugeda. Kui sa ei ole veel kindel, mida `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT` ja `COUNT` teevad, muutub JOIN kiiresti liiga suureks korraga. DACA spiraalõppes liigume väiksemast suuremani: kõigepealt üks tabel ja lihtsad küsimused, hiljem mitu tabelit ja keerulisemad seosed.

See ei tähenda, et `products` ja `customers` pole N1-s tähtsad. Sa võid neid uurida täpselt samade tööriistadega:

```sql
SELECT COUNT(*) AS tooteid_kokku
FROM products;

SELECT DISTINCT category
FROM products;

SELECT COUNT(*) AS kliente_kokku
FROM customers;

SELECT DISTINCT city
FROM customers;
```

Need päringud aitavad sul mõista, millised andmed sul olemas on. Kui hiljem õpid JOIN-e, on sul juba pilt ees: millised tabelid eksisteerivad, millised veerud neis on ja milliseid küsimusi võiks nende põhjal küsida.

Nädal 1-s on täiesti piisav, kui oskad iga tabeli kohta vastata kolmele küsimusele: kui palju ridu seal on, millised olulised kategooriad seal on ja kas midagi tundub puudu või kahtlane. See on andmebaasi esmane kaardistamine.

---

## Andmeanalüütiku Harjumus: Ära Usalda Esimest Tulemust Liiga Kiiresti

Kui päring töötab ja annab tulemuse, tekib kergendus. Aga töötav päring ei tähenda automaatselt õiget järeldust. Andmeanalüütik kontrollib oma tulemust vähemalt ühe teise nurga alt.

Näiteks kui saad teada, et `sales` tabelis on 15 234 rida, siis järgmine küsimus ei ole kohe "mis on kogukäive?". Järgmine küsimus on: kas see ridade arv on ootuspärane? Kas on duplikaate? Kas kõik read on päris müügid? Kas mõned väärtused puuduvad?

See harjumus kaitseb sind liiga kiirete järelduste eest. UrbanStyle'i loos ongi esimene suur õppetund see, et suur tabel ei tähenda tingimata paremat andmestikku. Kui kolmandik ridadest on duplikaadid, võib ilus kogukäibe number olla eksitav.

Küsi endalt iga tulemuse järel:

- kas see number on loogiline;
- millega ma saan seda võrrelda;
- kas tulemus võib olla duplikaatide või puuduvate väärtuste tõttu moonutatud;
- millist lihtsat lisapäringut saan kontrolliks kasutada.

See ei ole umbusaldus andmete vastu. See on professionaalne ettevaatus. Andmeanalüütik ei ole inimene, kes lihtsalt võtab tabelist numbri ja kleebib selle slaidile. Andmeanalüütik on inimene, kes küsib: "Kas see number tähendab seda, mida me arvame, et see tähendab?"

---

## Kokkuvõte: Sa Oled Valmis Toomase Väljakutseks

Sa oled nüüd õppinud SQL-i kuus põhilist ehituskivi. SELECT valib veerud, mida sa tahad näha. WHERE filtreerib ridu tingimuste järgi. ORDER BY sorteerib tulemusi. LIMIT piirab tulemuste arvu. DISTINCT näitab ainult unikaalseid väärtusi. Ja COUNT loeb ridu kokku.

Nende kuue tööriistaga suudad sa juba vastata Toomas Kaski küsimustele. Mitu rida on müügitabelis? COUNT(*). Mitu unikaalset arvet? COUNT(DISTINCT invoice_id). Suurimad müügid? ORDER BY DESC LIMIT 10. Kus on puuduvaid andmeid? COUNT(*) miinus COUNT(veerg).

Järgmisel nädalal tuled sa nende tööriistadega tagasi ja hakkad uurima UrbanStyle'i andmeid päriselt. Alguses tundub see ehk hirmutav, aga mäleta: sa oled Shu faasis ja see on OK. Sa järgid juhiseid samm-sammult ja iga korraga muutud kindlamaks.

SQL on nagu jalgrattasõit. Esimesed meetrid on kõikuvad, aga peagi ei mõtle sa enam pedaalimisele ja keskendud hoopis sellele, kuhu sa sõidad. Samamoodi sa peagi ei mõtle enam SQL süntaksile, vaid sellele, millistele äriküsimustele sa vastust otsid.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist ja on optimeeritud NotebookLM audio genereerimiseks.*

# SQL JOINid: Kuidas Ühendada Andmetabeleid ja Avada Tõeline Analüüsivõimekus

## Sissejuhatus

Kuni selle hetkeni oled sa töötanud alati ühe tabeliga korraga. Sa oled küsinud müügitabelilt "mitu müüki oli?" ja klientide tabelilt "millised linnad on esindatud?". Aga pärismaailma äriküsimused nõuavad peaaegu alati mitme tabeli andmeid korraga. "Kes on meie parimad kliendid?" vajab nii müügiandmeid kui ka kliendiandmeid. "Millised tooted müüvad parimini Tallinna poes?" vajab nii müügi- kui ka tootetabelit. "Millised müügikanalid ja linnad annavad parima tulemuse?" vajab müüke, kliente ja tooteinfot koos.

SQL JOINid on tööriist, millega sa ühendad mitut tabelit üheks terviklikuks tulemuseks. JOIN on andmeanalüütiku igapäevane kaaslane. Uuringud näitavad, et üle 95% ärianalüütiku SQL päringutes on vähemalt üks JOIN. See on mõistetav, sest hästi disainitud andmebaasides on andmed tahtlikult jagatud eraldi tabelitesse, et vähendada kordumist ja parandada kvaliteeti. Sinu ülesanne analüütikuna on need tükid kokku panna, et vastata äriküsimustele.

Selles dokumendis õpid sa kõik peamised JOIN tüübid: INNER JOIN, LEFT JOIN, RIGHT JOIN ja FULL OUTER JOIN. Õpid ka tabelite aliaseid, multi-table JOINe ja levinumaid vigu, mida vältida.

---

## Miks Andmed On Mitmes Tabelis: Primary Key ja Foreign Key

Enne kui JOINe õppida, on oluline mõista, MIKS andmed on mitmes tabelis. Kujuta ette, et UrbanStyle hoiaks kõiki andmeid ühes hiiglaslikul tabelis: iga müügirea juures oleks kliendi nimi, e-mail, linn, toote nimi, kategooria, hind, lao seis ja veebikülastuse info. See tabel oleks tohutu, täis korduvat infot ja väga raske hallata. Kui klient muudab oma e-maili, peaks seda muutma IGAS reas, kus ta esineb.

Sellepärast kasutavad andmebaasid normaliseerimist. Andmed on jagatud loogilistesse tabelitesse: customers tabelis on kliendiinfo, products tabelis on toodete info, sales tabelis on müügitehingud. Iga tabel tegeleb ühe asjaga hästi.

Aga kuidas need tabelid omavahel seostuvad? Selleks on kaks mõistet.

**Primary Key** on unikaalne tunnus, mis identifitseerib iga rea tabelis. Customers tabelis on see customer_id. Products tabelis on product_id. Iga klient ja iga toode on oma ID-ga unikaalselt tuvastatav.

**Foreign Key** on viide teise tabeli primary key-le. Sales tabelis on customer_id ja product_id. Need ei ole unikaalsed sales tabelis, sest üks klient võib osta mitu korda ja üht toodet võib müüa mitmele kliendile. Aga need viitavad kindlale reale teises tabelis.

See on nagu raamatukogusüsteem. Igal raamatul on unikaalne kood (primary key). Laenutuskaardil on raamatu kood (foreign key), mis viitab konkreetsele raamatule. Sa ei kirjuta laenutuskaardile kogu raamatu infot, ainult koodi, ja kui vaja, saad selle abil raamatu üles leida.

---

## INNER JOIN: Ainult Sobivad Read Mõlemast Tabelist

INNER JOIN on kõige tavalisem JOIN tüüp. Ta ühendab kaks tabelit ja tagastab ainult need read, kus ühendav väärtus (key) esineb mõlemas tabelis.

```sql
SELECT
    s.sale_id,
    s.sale_date,
    s.total_price,
    c.first_name,
    c.last_name,
    c.city
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id;
```

See päring ütleb: "Võta sales tabelist müügiandmed ja customers tabelist kliendi nimi ja linn. Ühenda need read, kus customer_id on sama mõlemas tabelis." Tulemus on tabel, kus iga rida näitab nii müügiinfot kui ka kliendi infot.

Mis juhtub ridadega, kus pole vastet? Näiteks müük, kus customer_id on 0 (parandatud NULL), mille jaoks ei ole customers tabelis vastet? INNER JOIN jätab need read välja. Ta näitab AINULT sobivaid paare.

Kujuta ette Venni diagrammi. Vasakul ringil on kõik müügid. Paremal ringil on kõik kliendid. INNER JOIN tagastab ainult keskse osa, kus ringid kattuvad. Müügid ilma kliendita ja kliendid ilma müügita jäävad välja.

Miks on see kasulik? Sest enamasti sa tahad näha ainult neid müüke, mis on seotud tuntud klientidega. Kui sa koostab müügiraportit, tahad sa nime ja linna, mitte tundmatute klientide numbreid.

---

## Tabelite Aliased: Lühendid Loetavuse Jaoks

SQL päringutes, kus on mitu tabelit, kasutad aliaseid ehk lühendeid. Ilma aliaseta peaksid kirjutama tabeli täisnime iga veeru ees:

```sql
-- Ilma aliaseta - pikk ja kohmakas
SELECT sales.sale_id, customers.first_name
FROM sales
INNER JOIN customers ON sales.customer_id = customers.customer_id;

-- Aliasega - lühike ja selge
SELECT s.sale_id, c.first_name
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id;
```

Alias antakse tabelile kohe pärast tabeli nime FROM või JOIN klauslis. `sales s` tähendab "sales tabel, mida me kutsume edaspidi s-iks". See on puhtalt loetavuse küsimus, aga see muudab päringud palju selgemaks, eriti kui tabeleid on mitu.

Levinud tava on kasutada tabeli nime esitähte: s (sales), c (customers), p (products), i (inventory). Kui on mitu tabelit, mis algavad sama tähega, kasuta kahte tähte.

---

## LEFT JOIN: Kõik Vasakust Tabelist, Sobivad Paremast

LEFT JOIN on INNER JOIN-i "laiem vend". Ta tagastab KÕIK read vasakust tabelist ja lisab paremast tabelist need read, kus vaste leidub. Kui vastet pole, täidab parema tabeli veerud NULL-iga.

```sql
-- LEFT JOIN: kõik kliendid, ka need kes pole ostnud
SELECT
    c.first_name,
    c.last_name,
    c.city,
    s.sale_id,
    s.total_price
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
ORDER BY s.total_price DESC NULLS LAST;
```

See päring näitab KÕIKI kliente. Need, kes on ostnud, näitavad müügiinfot. Need, kes pole kunagi ostnud, näitavad NULL müügiveergudes.

See omakorda avab väga võimsa mustri: "kadunud andmete" leidmine. LEFT JOIN koos WHERE ... IS NULL filtriga leiab read, mis on AINULT vasakus tabelis:

```sql
-- Kliendid, kes pole KUNAGI ostnud
SELECT
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    c.registration_date
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;
```

See on ülimalt kasulik muster. Sa leiad kliendid, kes registreerusid, aga pole kunagi ostu teinud. See info on turunduse jaoks kulda väärt. Need on inimesed, kes näitasid üles huvi, aga midagi läks teel kaduma. Suunatud turunduskampaania võib neid tagasi tuua.

Venni diagrammis on LEFT JOIN kogu vasak ring pluss keskne kattumine. Sa saad KÕIK vasakust tabelist, olenemata sellest, kas paremal on vaste.

---

## RIGHT JOIN ja FULL OUTER JOIN

**RIGHT JOIN** on LEFT JOIN-i peegelkuju. Ta tagastab KÕIK read paremast tabelist ja sobivad vasakust. Praktikas kasutatakse RIGHT JOIN-i harva, sest seda saab alati asendada LEFT JOIN-iga, vahetades tabelite järjekorda. Kui sa kirjutad `A LEFT JOIN B`, on see sama mis `B RIGHT JOIN A`.

```sql
-- RIGHT JOIN: kõik müügid, ka need ilma kliendi vasteta
SELECT
    c.first_name,
    s.sale_id,
    s.total_price
FROM customers c
RIGHT JOIN sales s ON c.customer_id = s.customer_id
WHERE c.customer_id IS NULL;
-- Müügid, kus customer_id ei vasta ühelegi kliendile
```

**FULL OUTER JOIN** tagastab KÕIK read MÕLEMAST tabelist. Read, kus vaste on, ühendatakse. Read, kus vastet pole, näitavad NULL vastaspoolel.

```sql
-- FULL OUTER JOIN: kõik read mõlemast tabelist
SELECT
    c.first_name,
    c.last_name,
    s.sale_id,
    s.total_price
FROM customers c
FULL OUTER JOIN sales s ON c.customer_id = s.customer_id
WHERE c.customer_id IS NULL OR s.customer_id IS NULL;
```

See päring näitab kahte asja korraga: kliente ilma müükideta JA müüke ilma klientideta. See on väga kasulik andmekvaliteedi kontrollimisel, sest sa näed korraga kõik "orvud" mõlemast tabelist.

Venni diagrammis on FULL OUTER JOIN mõlemad ringid tervikuna. Sa saad kõik, olenemata vastete olemasolust.

---

## Multi-Table JOINid: 3 ja Rohkem Tabelit

Päris äriküsimused nõuavad sageli rohkem kui kahte tabelit. Näiteks "millised Tallinna kliendid ostavad eco-sertifitseeritud tooteid?" vajab kolme tabelit: sales, customers ja products.

```sql
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city,
    p.product_name,
    p.category,
    p.eco_certified,
    s.quantity,
    s.total_price
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
WHERE c.city = 'Tallinn'
AND p.eco_certified = true
ORDER BY s.total_price DESC;
```

See päring ühendab kolm tabelit. Sales on keskne tabel, sest seal on nii customer_id kui ka product_id. Customers liitub customer_id kaudu ja products liitub product_id kaudu. Pärast ühendamist filtreerid WHERE klausliga.

Iga JOIN lisab uue "kihi" andmeid. Sa saad lisada ka müügikanali info:

```sql
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    p.product_name,
    s.total_price,
    s.channel AS müügikanal
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
ORDER BY s.total_price DESC
LIMIT 20;
```

Siin ühendame kolm tabelit: sales annab müügiinfo ja kanali, customers annab kliendi nime ja products annab toote nime. Müügikanal tuleb otse sales tabelist (`s.channel`).

---

## JOIN ja GROUP BY Koos: Koondatud Ärianalüüs

JOINid muutuvad eriti võimsaks koos GROUP BY-ga. Sa saad ühendada tabeleid JA koondada tulemusi ühe päringuga.

```sql
-- TOP 20 klienti kogumüügi järgi
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city,
    COUNT(s.sale_id) AS ostude_arv,
    SUM(s.total_price) AS kogumuuk
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY kogumuuk DESC
LIMIT 20;
```

See päring ühendab kaks tabelit, grupeerib tulemused kliendi kaupa, arvutab kogumüügi ja sorteerib suurimast väikseimani. Üks päring, mis vastab ärilisele küsimusele.

GROUP BY tuleb põhjalikumalt nädala 4 materjalis, aga juba praegu on hea teada, et JOIN ja GROUP BY on andmeanalüütiku kaks võimsaimat tööriista, mida sageli kasutatakse koos.

---

## SQL JOIN versus Exceli VLOOKUP

Kui sa tunned Excelit, siis JOIN on nagu VLOOKUP, aga palju võimsam. VLOOKUP vaatab ühest tabelist väärtust ja toob teisest tabelist vastava rea. JOIN teeb sama, aga:

Esiteks, JOIN saab töödelda miljoneid ridu sekunditega, samal ajal kui VLOOKUP muutub aeglaseks juba tuhandete ridade juures. Teiseks, JOIN toetab mitut tabelit korraga. VLOOKUPiga pead tegema mitu eraldi otsingut. Kolmandaks, JOIN on paindlikum: sa saad valida INNER, LEFT, RIGHT või FULL OUTER, olenevalt sellest, milliseid andmeid tahad näha. VLOOKUPis sellist valikut pole.

Neljandaks ja ehk kõige olulisemalt: JOIN on pöörduv. Sa ei muuda originaalandmeid, sa lihtsalt küsid andmebaasilt "näita mulle neid kahte tabelit koos." Exceli VLOOKUP muudab töölehte, aga SQL JOIN ei muuda midagi. See teeb analüüsi palju turvalisemaks.

---

## Self-JOIN: Tabel Ühendatud Iseendaga

Mõnikord on vaja ühendada tabel iseendaga. See tundub kummalisena, aga on kasulik, kui tabelis on hierarhilised seosed. Näiteks, kui sul on töötajate tabel, kus iga töötajal on juhi ID, saad SELF-JOIN-iga leida iga töötaja juhi nime.

UrbanStyle'i kontekstis võid kasutada self-joini näiteks klientide puhul, kes on tuttavaid soovitanud:

```sql
-- Kliendid, kes registreerusid samal kuupäeval (potentsiaalsed sõbrad)
SELECT
    a.first_name AS klient_a,
    b.first_name AS klient_b,
    a.registration_date,
    a.city
FROM customers a
INNER JOIN customers b
    ON a.registration_date = b.registration_date
    AND a.city = b.city
    AND a.customer_id < b.customer_id
ORDER BY a.registration_date;
```

Self-JOIN puhul annad samale tabelile kaks erinevat aliast (a ja b) ja ühendad need tingimuse alusel. a.customer_id < b.customer_id tagab, et iga paar ilmub ainult üks kord.

---

## Levinumad JOIN Vead ja Kuidas Neid Vältida

JOINe õppides on mõned vead väga tavalised. Siin on olulisimad.

**1. Puuduv ON klausel.** Kui sa unustad ON tingimuse, saad cartesian producti ehk ristühendi, kus iga vasaku tabeli rida ühendatakse IGA parema tabeli reaga. Kui mõlemas tabelis on 1000 rida, saad 1 000 000 rida! See on peaaegu alati viga.

**2. Vale ühendusveerg.** Kui sa ühendad valetel veergudel, saad vale tulemuse ilma veateateta. Kontrolli alati, et ON klauslis on õige foreign key ja primary key.

**3. INNER JOIN, kui peaks olema LEFT JOIN.** Kui sa tahad näha KÕIKI kliente, ka neid kellel pole müüke, kasuta LEFT JOIN-i. INNER JOIN jätab kliendid ilma müükideta välja.

**4. Aliaseta viited.** Kui mõlemas tabelis on samanimeline veerg (nt customer_id), pead alati kasutama aliast (s.customer_id, c.customer_id). Muidu SQL ei tea, millist veergu sa mõtled.

**5. Duplikaatide ignoreerimine.** JOINid võivad tekitada duplikaate, kui üks klient on ostnud mitu korda. Kasuta COUNT(DISTINCT ...) ja GROUP BY, et vältida valede tulemuste saamist.

---

## JOIN Tüüpide Kokkuvõte

Kokkuvõttes on neli peamist JOIN tüüpi ja igaühel on oma koht.

**INNER JOIN** kasuta siis, kui tahad ainult sobivaid paare. Kõige tavalisem. Näide: kliendid, kes on ostnud.

**LEFT JOIN** kasuta siis, kui tahad KÕIKI ridu vasakust tabelist. Ideaalne "puuduvate" leidmiseks. Näide: kliendid, kes pole kunagi ostnud.

**RIGHT JOIN** kasutatakse harva, sest saab asendada LEFT JOIN-iga. Kasulik spetsiifilistes olukordades.

**FULL OUTER JOIN** kasuta andmekvaliteedi kontrolliks. Näide: kas on müüke ilma kliendita JA kliente ilma müügita?

Enamiku tööst teeb ära INNER JOIN ja LEFT JOIN. Need kaks on sinu igapäevased tööriistad.

JOINid avavad tõelise analüüsivõimekuse. Ilma nendeta saad vastata ainult ühte tabelit puudutavatele küsimustele. JOINidega saad vastata küsimustele nagu "kes ostab mida kust" ja "millised kliendid on kadunud" ja "milline turunduskanal toob parimaid kliente." Need on küsimused, mida juhtkond päriselt küsib ja millele andmeanalüütik peab vastama.

---

## Kuidas JOINi Kontrollida Enne Järeldust

JOIN võib tehniliselt töötada, aga äriliselt vale olla. Seetõttu tee enne järelduse kirjutamist alati kolm kontrolli.

**1. Kontrolli ridade arvu.** Käivita kõigepealt lihtne `COUNT(*)` algtabelitel ja siis JOIN tulemuse peal. INNER JOIN annab tavaliselt sama või väiksema ridade arvu kui vasak põhitabel, sest ta jätab vasteta read välja. LEFT JOIN annab vasaku tabeli ridade arvu või rohkem, kui paremal tabelis on mitu vastet ühe vasaku rea kohta.

```sql
SELECT COUNT(*) FROM sales;

SELECT COUNT(*)
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id;
```

Kui ridade arv muutub ootamatult väga suureks, võib ON tingimus olla vale või puudu. Kui ridade arv muutub ootamatult väga väikseks, võib INNER JOIN välja filtreerida palju vasteta ridu.

**2. Kontrolli ühendusveerge.** Küsi alati: kas `s.customer_id = c.customer_id` on loogiline? Kas `s.product_id = p.product_id` on loogiline? Ära ühenda nime nimega ega kuupäeva ID-ga lihtsalt sellepärast, et väärtused näevad sarnased välja.

**3. Kontrolli NULL-e.** LEFT JOIN-i puhul on NULL kasulik signaal. Kui otsid kliente, kes pole ostnud, siis `s.sale_id IS NULL` tähendabki "sellel kliendil ei olnud sales tabelis vastet". Kui näed NULL-e seal, kus neid ei oodanud, peatu ja uuri enne edasi.

Need kontrollid sobivad hästi Shu tasemele: sa ei pea veel keerulisi päringuid leiutama, aga sa õpid kontrollima, kas kopeeritud või kohandatud muster töötab õigesti.

## Week 3 Tabelipiir

Nädal 3 materjalid kasutavad ainult neid tabeleid, mis on selleks hetkeks osalejatele saadaval: `sales`, `customers`, `products` ja `inventory`. Kui kohtad mõnes AI vastuses või vanas märkmes viidet hilisema nädala veebikäitumise tabelile, ära kasuta seda nädal 3 ülesannetes. Detailsem veebikäitumise analüüs tuleb hiljem; W3 fookus on JOIN mustril olemasolevate tabelitega.

W3-s saab müügikanaleid uurida `sales.channel` veeru kaudu. See annab lihtsa vaate: kas ost toimus online-kanalis või poes. Kui tahad lisada piirkonna, kasuta `sales.store_location` või ühenda `customers` tabeliga ja vaata kliendi linna. See hoiab analüüsi kooskõlas andmekava ja osaleja tegeliku Supabase projektiga.

Näiteks:

```sql
SELECT
    s.channel,
    c.city,
    COUNT(s.sale_id) AS oste,
    SUM(s.total_price) AS kogumuuk
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY s.channel, c.city
ORDER BY s.channel, kogumuuk DESC;
```

See päring on W3 jaoks sobiv: ta kasutab kahte olemasolevat tabelit ja vastab Anna küsimusele ilma tuleviku tabelitele toetumata.

---

## JOINi Valimise Mõttepuu

Kui näed äriküsimust, ära alusta kohe SQL-i kirjutamisest. Alusta mõttepuust.

**Küsimus 1: Mis on põhientiteet?** Kui Anna küsib "kes on meie parimad kliendid?", on põhientiteet klient. Kui ta küsib "millised tooted pole müüdud?", on põhientiteet toode. Kui põhientiteet on selge, pane see tavaliselt `FROM` osasse.

**Küsimus 2: Kas ma tahan ainult neid, kellel on vaste, või kõiki?** Kui tahad ainult ostnud kliente, sobib `INNER JOIN`. Kui tahad kõiki kliente, ka neid, kes pole ostnud, sobib `LEFT JOIN`.

**Küsimus 3: Kust tuleb lisainfo?** Kliendi nimi tuleb `customers` tabelist, toote nimi tuleb `products` tabelist, müügikuupäev ja summa tulevad `sales` tabelist, laoseis tuleb `inventory` tabelist.

**Küsimus 4: Mis on ühendusvõti?** `sales.customer_id` ühendub `customers.customer_id` veeruga. `sales.product_id` ühendub `products.product_id` veeruga. `inventory.product_id` ühendub `products.product_id` veeruga.

Kui vastad neile neljale küsimusele, on JOIN peaaegu valmis. Näiteks "millised laos olevad tooted pole kunagi müüdud?" tähendab:

- põhientiteet on `products`;
- tahame kõiki tooteid, ka müümata;
- müügiinfo tuleb `sales`;
- laoseis tuleb `inventory`;
- seega kasutame `products LEFT JOIN sales` ja `products LEFT JOIN inventory`.

```sql
SELECT
    p.product_name,
    p.category,
    p.retail_price,
    i.location,
    i.quantity_available
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
LEFT JOIN inventory i ON p.product_id = i.product_id
WHERE s.sale_id IS NULL
  AND i.quantity_available > 0;
```

See on hea W3 näide, sest see kasutab ainult sel nädalal saadaolevaid tabeleid ja annab päris ärilise vastuse: millised tooted seovad raha laos, aga ei tekita müüki.

## JOIN ja Ärikeel

JOINi tehniline tulemus on tabel. Aga andmeanalüütiku töö ei lõpe tabeliga. Sama tulemus tuleb tõlkida ärikeelde.

Tehniline tulemus:

"LEFT JOIN näitas 47 rida, kus `s.sale_id IS NULL`."

Ärikeel:

"Meil on kliente, kes registreerusid, kuid pole ostu teinud. See on võimalus tervituskampaaniaks või onboarding sõnumiks."

Tehniline tulemus:

"INNER JOIN sales ja products vahel näitas, et kategooria X annab suurima kogumüügi."

Ärikeel:

"Anna saab kampaania fookuse panna kategooriale, mis juba tõestab nõudlust."

Tehniline tulemus:

"Products LEFT JOIN sales leidis müümata tooted."

Ärikeel:

"Marko ja Anna saavad otsustada, kas neid tooteid tuleks soodustada, ümber paigutada või valikust eemaldada."

Selline tõlge on oluline demo jaoks. Sessioon 3 ei ole koht, kus näidata ainult SQL süntaksit. Seal tuleb öelda, mis otsus muutub.

## AI-ga JOIN Päringu Kontrollimine

AI võib aidata JOIN süntaksit kontrollida, aga anna talle täpne kontekst. Halb prompt on: "Tee mulle JOIN." Hea prompt on:

"Mul on UrbanStyle andmebaasis tabelid `sales`, `customers`, `products`, `inventory`. Tahan leida kliendid, kes on registreerunud, aga pole kunagi ostnud. Kirjuta SQL PostgreSQL jaoks. Kasuta ainult neid tabeleid ja selgita, miks LEFT JOIN sobib."

Veel parem on lisada oma päring:

"Kontrolli seda päringut. Kas ON tingimus on õige? Kas `WHERE s.sale_id IS NULL` leiab kliendid ilma ostudeta?"

Ära lase AI-l lisada tabeleid, mida sul pole. Kui AI pakub mõne uue tabeli, küsi: "Kuidas teha sama ainult `sales`, `customers`, `products` ja `inventory` abil?" Nii jääb töö kooskõlla nädala andmekavaga.

## Üks Kontrollnäide Enne Kokkuvõtet

Kujuta ette, et Anna küsib: "Kas mul on kliente, kes on registreerunud, aga pole ostnud?" Õige mõtteviis on:

- tahan näha kõiki kliente;
- ostuinfo tuleb `sales` tabelist;
- ostuta kliendil puudub vaste `sales` tabelis;
- seega alustan `customers` tabelist ja teen `LEFT JOIN sales`.

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;
```

Kui sa paneksid siia `INNER JOIN`, kaoksid kõik ostuta kliendid tulemusest ära. See on JOINide kõige tähtsam õppetund: JOIN tüüp ei ole vormistus, vaid otsustab, millist lugu andmed räägivad.

Pea meeles ka seda, et `WHERE` tuleb pärast JOINi. Kõigepealt luuakse ühendatud tulemus, siis filtreeritakse. Seetõttu on `WHERE s.sale_id IS NULL` LEFT JOINi järel nii võimas: ta ei otsi NULL-e algses `customers` tabelis, vaid otsib neid kohti, kus `sales` vastet ei tekkinud.

See eristus aitab ka vigu debugida. Kui tulemus on tühi, eemalda ajutiselt `WHERE` filter ja vaata, kas JOIN üldse annab ridu. Kui annab, oli filter liiga kitsas. Kui ei anna, on probleem tõenäoliselt `ON` tingimuses või andmete võtmetes. Tee see väike kontroll enne, kui hakkad kogu päringut ümber kirjutama või andmeid süüdistama. Rahulik kontroll säästab palju aega.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist ja on optimeeritud NotebookLM audio genereerimiseks.*

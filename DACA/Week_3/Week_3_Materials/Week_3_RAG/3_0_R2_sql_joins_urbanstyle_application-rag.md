# SQL JOINid Praktikas: Anna Mets Tahab Teada, KES On Parimad Kliendid

## Sissejuhatus

Nädal 3 toob mängu uue tegelase. Anna Mets, UrbanStyle'i 31-aastane turunduse juht, on energiline, loominguline ja kannatamatu. Ta on kuulnud, et UrbanStyle analüüsimeeskond sai nädal 2-l müügitabeli korda: duplikaadid eemaldatud, NULL-id lahendatud, andmed puhastatud. Anna vaatab Toomase puhastatud tabelit ja ütleb: "OK, see on tore, et duplikaadid on kadunud. Aga ma ei saa sellest MIDAGI! Ma näen ainult numbreid. Ma tahan teada: KES on meie parimad kliendid?"

Anna saadab nädala alguses e-kirja pealkirjaga "KIIRE -- Vajan TOP 20 klientide listi". Tal on nädala lõpus turunduskampaania planeerimine ja ta vajab nelja asja. Esiteks, kes on TOP 20 klienti kogumüügi järgi. Teiseks, milliseid tooteid nad ostavad ja millised kategooriad domineerivad. Kolmandaks, millised müügikanalid ja linnad töötavad. Ja neljandaks, kes on registreerunud, aga pole kunagi ostnud.

Selles dokumendis lahendame Anna kõik neli küsimust samm-sammult, kasutades SQL JOINe UrbanStyle'i andmebaasil.

---

## Anna Esimene Küsimus: TOP 20 Klienti Kogumüügi Järgi

Anna tahab teada, kes kulutab UrbanStyle'is kõige rohkem raha. Müügiandmed on sales tabelis, aga seal on ainult customer_id ja total_price. Kliendi nimi ja linn on customers tabelis. Sa pead need kaks tabelit ühendama.

```sql
-- TOP 20 klienti kogumüügi järgi
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city,
    c.loyalty_tier,
    COUNT(s.sale_id) AS ostude_arv,
    SUM(s.total_price) AS kogumuuk,
    ROUND(AVG(s.total_price), 2) AS keskmine_ost
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.loyalty_tier
ORDER BY kogumuuk DESC
LIMIT 20;
```

See päring ühendab müügiandmed klientidega INNER JOIN abil. GROUP BY koondab tulemused kliendi kaupa. SUM arvutab kogumüügi, COUNT loeb ostude arvu ja AVG annab keskmise ostu suuruse.

Tulemus on tabel, mida Anna saab kohe kasutada. Ta näeb iga TOP kliendi nime, linna, lojaalsuse taset, ostude arvu ja kogumüüki. See on konkreetne, tegevuskõlblik info.

Anna vaatab tulemust ja ütleb: "Ma näen, et meie parimad kliendid on peamiselt Tallinnast ja gold-tasemel. See tähendab, et meie lojaalsusprogramm töötab! Aga ma tahan rohkem teada."

---

## Anna Teine Küsimus: Tootekategooriate Analüüs

Nüüd tahab Anna teada, MIDA parimad kliendid ostavad. Selleks pead ühendama kolm tabelit: sales, customers ja products.

```sql
-- Milliseid tootekategooriaid TOP kliendid eelistavad?
SELECT
    p.category,
    COUNT(s.sale_id) AS ostude_arv,
    SUM(s.total_price) AS kogumuuk,
    ROUND(AVG(s.total_price), 2) AS keskmine_ost
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY kogumuuk DESC;
```

See näitab, millised tootekategooriad müüvad enim. Anna saab teada, kas naiste riided domineerivad, kui palju aksessuaarid toovad ja kas meeste riided on kasvav segment.

Veel detailsem vaade -- konkreetsed tooted:

```sql
-- TOP 10 toodet müügitulu järgi
SELECT
    p.product_name,
    p.category,
    p.eco_certified,
    COUNT(s.sale_id) AS muudud_kordi,
    SUM(s.quantity) AS muudud_kogus,
    SUM(s.total_price) AS kogumuuk
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category, p.eco_certified
ORDER BY kogumuuk DESC
LIMIT 10;
```

Anna: "Huvitav! Meie bestseller on eco-sertifitseeritud! See on meie brändilubadusega kooskõlas. Ma saan seda kampaanias rõhutada."

Võid ka uurida, kas online ja poe müügid erinevad:

```sql
-- Kategooriate müük kanalite kaupa
SELECT
    s.channel,
    p.category,
    COUNT(s.sale_id) AS ostude_arv,
    SUM(s.total_price) AS kogumuuk
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY s.channel, p.category
ORDER BY s.channel, kogumuuk DESC;
```

See näitab, kas online kliendid ostavad samu asju kui poe kliendid. Kui aksessuaarid müüvad online paremini, saab Anna veebikampaanias neid rohkem rõhutada.

---

## Anna Kolmas Küsimus: Millised Müügikanalid Töötavad?

Anna tahab teada, milline müügikanal toob kõige rohkem kliente ja müüke. Sales tabelis on `channel` veerg, mis näitab müügikanalit (nt online, in-store jne).

```sql
-- Müügikanalite ülevaade
SELECT
    s.channel AS müügikanal,
    COUNT(DISTINCT s.customer_id) AS kliente,
    COUNT(s.sale_id) AS oste,
    SUM(s.total_price) AS kogumüük
FROM sales s
GROUP BY s.channel
ORDER BY kogumüük DESC;
```

See näitab, milline müügikanal toob kõige rohkem tulu ja kliente. Aga Anna tahab teada ka, millised tooted millistes kanalites müüvad. Selleks pead ühendama sales, customers ja products:

```sql
-- Milline müügikanal toob milliste toodete müüke?
SELECT
    s.channel AS müügikanal,
    p.category AS tootekategooria,
    COUNT(DISTINCT c.customer_id) AS kliente,
    COUNT(s.sale_id) AS oste,
    SUM(s.total_price) AS kogumüük
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY s.channel, p.category
ORDER BY s.channel, kogumüük DESC;
```

See on kolme tabeli JOIN. Sales annab müügikanali, customers annab kliendi linna ja products annab tootekategooria. Tulemus näitab, milline kanal toob milliste toodete müüke.

Anna: "Kui online-kanal toob meile 60% kõigist müükidest, siis ma suurendan selle eelarvet! Ja kui aksessuaarid müüvad online paremini, saan veebikampaanias neid rohkem rõhutada."

Võid vaadata ka müügikanaleid kaupluste kaupa:

```sql
-- Müügikanalid kaupluste kaupa
SELECT
    s.store_location AS kauplus,
    s.channel AS müügikanal,
    COUNT(s.sale_id) AS oste,
    SUM(s.total_price) AS kogumüük,
    ROUND(SUM(s.total_price) / COUNT(s.sale_id), 2) AS keskmine_ost
FROM sales s
GROUP BY s.store_location, s.channel
ORDER BY kauplus, kogumüük DESC;
```

Kas Tallinna, Tartu ja Pärnu kauplused kasutavad müügikanaleid erinevalt? See info aitab Annal turunduseelarvet suunata.

---

## Anna Neljas Küsimus: Registreerunud, Aga Pole Ostnud

See on Anna kõige intrigeerivam küsimus. Kes on need inimesed, kes registreerusid UrbanStyle'i kliendibaasis, aga pole kunagi ostu teinud? Need on "kadunud kliendid" ja nende leidmine on LEFT JOIN-i klassiline kasutusjuht.

```sql
-- Registreerunud kliendid, kes pole kunagi ostnud
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.email,
    c.city,
    c.registration_date,
    c.loyalty_tier
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
ORDER BY c.registration_date DESC;
```

See päring kasutab LEFT JOIN-i, et näidata KÕIKI kliente, ja filtreerib WHERE s.sale_id IS NULL abil välja ainult need, kellel pole ühtegi müüki. Tulemus on nimekiri klientidest, kes registreerusid, aga ei teinud kunagi ostu.

Mitu sellest klienti on?

```sql
-- Kadunud klientide arv
SELECT COUNT(*) AS kadunud_kliendid
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;
```

Anna: "47 klienti registreerusid, aga pole kunagi ostnud?! See on hullumeelne! Ma saan neile personaalse tervituskampaania saata -- 15% allahindlus esimesele ostule!"

Veelgi täpsem analüüs -- millal nad registreerusid?

```sql
-- Kadunud kliendid registreerimisaja järgi
SELECT
    EXTRACT(YEAR FROM c.registration_date) AS aasta,
    EXTRACT(MONTH FROM c.registration_date) AS kuu,
    COUNT(*) AS kadunud_kliente
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
GROUP BY aasta, kuu
ORDER BY aasta, kuu;
```

See näitab, millal need "kadunud" kliendid registreerusid. Kui suur osa registreerus hiljuti, võib see olla normaalne. Aga kui nad registreerusid kuude eest, on midagi valesti.

---

## Tooted, Mida Pole Kunagi Müüdud

Annale on see oluline. Kui UrbanStyle'il on tooteid, mida keegi pole kunagi ostnud, on need raisatud riiulipind ja laopind.

```sql
-- Tooted ilma ühegi müügita
SELECT
    p.product_name,
    p.category,
    p.retail_price,
    p.eco_certified
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL
ORDER BY p.retail_price DESC;
```

Mitu sellist toodet on?

```sql
SELECT COUNT(*) AS muumata_tooted
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;
```

Need on tooted, mille kohta Marko Saar (tootehaldur) peaks otsuse tegema: kas jätkata nendega, alandada hinda või eemaldada valikust?

---

## Müügid Linnade Kaupa: Kliendid ja Tulud

Anna tahab ka teada, kuidas müük jaguneb linnade vahel. See aitab tal planeerida regionaalseid kampaaniaid.

```sql
-- Müük linnade kaupa
SELECT
    c.city AS linn,
    COUNT(DISTINCT c.customer_id) AS kliente,
    COUNT(s.sale_id) AS oste,
    SUM(s.total_price) AS kogumuuk,
    ROUND(AVG(s.total_price), 2) AS keskmine_ost
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.city
ORDER BY kogumuuk DESC;
```

See annab selge pildi: millises linnas on kõige rohkem kliente, kõige rohkem müüke ja kõige suurem tulu? Kui Tallinn domineerib müügitulus, aga Tartu klientidel on kõrgem keskmine ost, võib see viidata erinevatele kliendiprofilidele.

---

## Koondraport Annale: Kõik Ühes Kohas

Pärast kõigi nelja küsimuse lahendamist koosta Annale koondülevaade:

```sql
-- KOONDRAPORT: UrbanStyle'i kliendianalüüs
-- 1. Klientide koguarv
SELECT COUNT(*) AS kliendid_kokku FROM customers;

-- 2. Aktiivsed kliendid (vähemalt 1 ost)
SELECT COUNT(DISTINCT customer_id) AS aktiivsed_kliendid FROM sales;

-- 3. Kadunud kliendid (registreerunud, pole ostnud)
SELECT COUNT(*) AS kadunud_kliendid
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;

-- 4. Müümata tooted
SELECT COUNT(*) AS muumata_tooted
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;
```

See koondraport annab Annale neli kriitilist numbrit ühe pilguga. Ta saab neid kasutada nädala lõpu turunduskampaania planeerimisel.

---

## Tegelaste Reaktsioonid

Anna Mets vaatab demo sessioonil tulemusi ja on vaimustuses: "See on TÄPSELT see, mida ma vajasin! Ma näen, et meie TOP kliendid on Tallinnast ja ostavad peamiselt naiste riideid. Ma näen kliente, kes registreerusid aga pole ostnud -- neile saadan kohe kampaania! Ja ma näen, kuidas online ja pood erinevad. AGA... ma tahan GRAAFIKUID, mitte tabeleid. Kas saate teha?"

Toomas Kask taustalt, vaikselt uhke: "Head tööd. Dokumenteerige kõik korralikult. Ja graafikud tulevad nädaletel 5-6, kui õpite visualiseerimist."

See on sinu esimene päris ärianalüüsi projekt. Sa oled ühendanud mitut tabelit, vastanud konkreetsetele äriküsimustele ja koostanud raporti, mida turunduse juht saab otse kasutada. See on täpselt see, mida andmeanalüütik igapäevaselt teeb.

---

## Kuidas Anna Küsimused Rollideks Jagada

Nädal 3 grupitöö on ehitatud nii, et iga roll vaatab sama äriprobleemi eri nurga alt. See aitab meeskonnal õppida koostööd ja samal ajal vältida seda, et kõik kirjutavad sama päringut.

**Roll A: TOP kliendid.** See roll vastab küsimusele "kes toob kõige rohkem tulu?". Tehniliselt kasutab ta `sales` ja `customers` tabeleid ning lisab `GROUP BY`, et müügid kliendi tasemele kokku võtta. Äriväljund on VIP kliendinimekiri.

**Roll B: registreerunud, aga mitte ostnud kliendid.** See roll kasutab `customers LEFT JOIN sales` mustrit. Äriväljund on nimekiri inimestest, kellele Anna saab teha esimese ostu kampaania.

**Roll C: müümata tooted ja inventuur.** See roll kasutab `products LEFT JOIN sales` ning lisab `inventory`, kui ta tahab teada, kas müümata toode seisab ka laos. Äriväljund on soovitus: soodustus, ümberpaigutamine või valikust eemaldamine.

**Roll D: müügikanalid ja linnad.** See roll kasutab `sales.channel`, `customers.city` ja vajadusel `products.category`. Äriväljund on küsimus: kas online ja pood käituvad erinevalt ning kas mõni linn või kategooria vajab eraldi sõnumit?

Kui meeskond paneb need neli vastust kokku, saab Anna esimese tervikliku kliendi- ja müügipildi. Iga roll üksi on ainult osa loost. Koos tekib lugu: kes ostab, mida ostab, kes ei osta ja kus tulemus tekib.

## Demo: Mida Näidata ja Mida Mitte Näidata

Anna ei vaja demo alguses SQL-i. Ta vajab vastust. Hea demo algab ühe lausega:

"Me ühendasime müügi-, kliendi- ja tootetabelid ning leidsime kolm kampaaniaotsust, mida Anna saab kohe kasutada."

Seejärel näita 3-4 leidu:

- TOP kliendid ja mis neid ühendab;
- kliendid, kes registreerusid, aga pole ostnud;
- müümata või laos seisvad tooted;
- müügikanali ja linna erinevused.

SQL päringuid võib näidata lõpus või lisas. Toomase jaoks on tehniline korrektsus oluline, aga Anna jaoks on oluline otsus. See on hea näide sellest, kuidas sama analüüsil on kaks auditooriumi: ärikasutaja ja tehniline kontrollija.

## Tulemuste Aus Sõnastus

W3 analüüs annab tugevaid signaale, aga mitte lõplikke põhjuseid. Näiteks kui online-kanalil on suurem kogumüük kui poel, ei tähenda see automaatselt, et online on "parem". Võib-olla on online ostukorv suurem, võib-olla poeostud on sagedasemad, võib-olla andmed sisaldavad kampaaniaperioodi.

Hea sõnastus on:

"Andmete järgi on online-kanali kogumüük suurem. Järgmise sammuna võrdleksime ostude arvu, keskmist ostu ja kategooriaid, enne kui eelarvet ümber tõstame."

Kui klientide linnade lõikes tuleb suur erinevus, ära ütle kohe, et üks linn on "halvem". Ütle:

"Linnade vahel on erinev muster. See võib viidata erinevale kliendibaasile, poe asukohale või kampaania mõjule."

Selline ettevaatlik sõnastus näitab, et osaleja mõtleb analüütikuna. Ta ei hüppa kohe järeldusele, vaid eristab vaatlust, tõlgendust ja soovitust.

## Portfoolio Väärtus

Nädal 3 artefakt sobib portfooliosse väga hästi, sest JOIN on tööandjale äratuntav oskus. README võiks öelda:

"Projekt vastab Anna Metsa turundusküsimustele, ühendades `sales`, `customers`, `products` ja `inventory` tabelid. Analüüs tuvastab TOP kliendid, ostuta registreerunud kliendid, müümata tooted ning müügikanalite/linnade erinevused."

Lisa 2-3 SQL faili või üks koondfail:

- `week3_top_customers.sql`;
- `week3_missing_customers.sql`;
- `week3_products_inventory.sql`;
- `week3_channel_city_analysis.sql`.

README-sse lisa ka "AI kasutamine" väli, kui AI aitas päringuid kontrollida. Näiteks:

"Kasutasime AI-d JOIN päringute loogika kontrollimiseks ja ON tingimuste ülevaatamiseks. Kõik päringud käivitasime Supabase SQL Editoris ja kontrollisime ridade arvu."

See näitab tööprotsessi, mitte ainult lõpptulemust.

## Seos Nädal 4-ga

Nädal 3 õpetab andmeid ühendama. Nädal 4 lisab koondamise: `GROUP BY`, `HAVING`, CTE-d ja keerukamad ärimõõdikud. Kui W3 küsimus on "kuidas ma saan kliendi nime müügirea juurde?", siis W4 küsimus on "kuidas ma võrdlen kategooriaid, kanaleid ja perioode nii, et otsus oleks põhjendatud?"

Seetõttu tasub W3 lõpus hoida alles kõik töötavad JOIN päringud. Need muutuvad W4-s ehitusplokkideks. JOIN loob andmetabeli, mida saab järgmisel nädalal koondada, filtreerida ja järjestada.

## Anna Lõplik Tellimus

Kui Anna peaks nädala lõpuks küsima ühe kokkuvõtva tabeli, võiks see olla mitte üks hiigelpäring, vaid neli väikest vastust. See on algaja jaoks parem ja äriliselt selgem.

Esimene vastus: TOP kliendid kogumüügi järgi. See ütleb, kellele võiks teha VIP sõnumi.

Teine vastus: ostuta registreerunud kliendid. See ütleb, kellele võiks teha esimese ostu kampaania.

Kolmas vastus: müümata tooted ja laoseis. See ütleb, millised tooted seovad raha või vajavad kampaaniat.

Neljas vastus: müügikanalid ja linnad. See ütleb, kas Anna peaks sõnumit erinevalt suunama online-kanalile, poodidele või konkreetsetele linnadele.

Selline nelja vastuse struktuur sobib hästi ka demo slaidile. Üks slaid, neli kasti, igas kastis üks leid ja üks soovitus. SQL jääb taustale, aga kvaliteet tuleb sellest, et iga soovitus on päringuga kontrollitav.

## Näide: Ühest Päringust Soovituseni

Päring:

```sql
SELECT
    s.channel AS muugikanal,
    c.city AS linn,
    COUNT(s.sale_id) AS oste,
    SUM(s.total_price) AS kogumuuk
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
GROUP BY s.channel, c.city
ORDER BY kogumuuk DESC;
```

Tehniline leid võib olla: "online-kanalis on Tallinnas suurim kogumüük." Ärisoovitus ei ole lihtsalt "paneme raha online'i". Parem soovitus on: "Testime Tallinna online-klientidele kategooriapõhist kampaaniat ja võrdleme tulemust poe kanaliga." Nii liigub meeskond tabelist eksperimendini.

Sama loogika kehtib müümata toodete puhul. Kui päring näitab, et teatud kategoorias on palju müümata tooteid, ei tähenda see kohe, et kategooria on halb. Võib-olla on hinnastamine vale, võib-olla toodet pole nähtavalt esile toodud, võib-olla laoseis on vales asukohas. JOIN annab signaali, mitte lõplikku kohtuotsust.

## Mida Osaleja Peaks Pärast W3 Oskama Öelda

Pärast nädal 3 peaks osaleja suutma öelda:

"Ma oskan võtta müügirea, kus on ainult `customer_id` ja `product_id`, ning ühendada selle kliendi nime, linna ja toote kategooriaga."

"Ma tean, millal kasutada INNER JOINi ja millal LEFT JOINi."

"Ma oskan leida puuduvaid seoseid, näiteks kliente ilma ostudeta või tooteid ilma müükideta."

"Ma oskan selgitada ärikasutajale, mida JOIN tulemus tähendab."

Need laused on portfoolio ja töövestluse mõttes väärtuslikud. Nad ei ütle ainult "ma õppisin SQL-i", vaid kirjeldavad tööoskust.

## Tuletus: Shu Tase On Siin Tugevus

Nädal 3 ei nõua, et osaleja leiutaks ise keerulisi andmemudeleid. Vastupidi: tugev töö tuleb sellest, et ta järgib mustrit hoolikalt. JOIN on täpne tööriist. Väike viga ON tingimuses võib anda täiesti vale tulemuse.

Shu tasemel on hea tööviis:

- kopeeri kontrollitud näide;
- muuda ainult tabelit või veergu, mida ülesanne nõuab;
- käivita päring;
- kontrolli ridade arvu;
- kirjuta tulemus ärikeeles.

Kui see muutub harjumuseks, on W4 keerukamad koondpäringud palju lihtsamad.

## Meeskonna Koondvastuse Mall

Kui meeskond peab nädala lõpus vastuse kokku panema, võib kasutada sellist malli:

**1. Äriprobleem.** Anna ei näe `sales` tabelist kliendi nime, toote kategooriat ega kliendi linna. Ta vajab ühendatud vaadet.

**2. Meetod.** Kasutasime `INNER JOIN` mustrit ostnud klientide ja toodete analüüsiks ning `LEFT JOIN ... IS NULL` mustrit puuduvate seoste leidmiseks.

**3. Leid 1.** TOP kliendid annavad fookuse VIP või lojaalsuskampaaniale.

**4. Leid 2.** Ostuta registreerunud kliendid on eraldi sihtrühm esimese ostu kampaaniaks.

**5. Leid 3.** Müümata tooted ja laoseis näitavad, kus võib raha seista.

**6. Leid 4.** Müügikanali ja linna vaade aitab sõnumit täpsemalt suunata.

**7. Järgmine samm.** Nädal 4-s koondame samu ühendatud andmeid kategooriate, kanalite ja ajaperioodide lõikes.

See mall hoiab demo kompaktse. Iga lause peab vastama küsimusele "mida Anna saab nüüd teha?" Kui lause sellele ei vasta, on see tõenäoliselt tehniline detail, mis sobib lisasse või GitHub README-sse.

## Miks See On Karjäärivahetajale Oluline

JOINid on üks esimesi kohti, kus varasem töökogemus muutub eeliseks. Müügi-, kliendi-, lao- või turundustaustaga osaleja tunneb ära, miks andmed on eri kohtades. Ta võib öelda: "Muidugi on klient ja müük eraldi; klient võib osta mitu korda." See äriline intuitsioon aitab SQL-i kiiremini mõista.

Nädal 3 eesmärk ei ole ainult tehniline süntaks. Eesmärk on õppida mõtlema seostes: klient seostub ostuga, ost seostub tootega, toode seostub laoseisuga, kanal seostub müügiolukorraga. Andmeanalüütik ei vaata tabelit eraldi saarena. Ta vaatab süsteemi.

Kui osaleja suudab selle mõtte oma sõnadega seletada, on ta astunud suure sammu edasi. Ta ei ole enam ainult päringu kopeerija. Ta hakkab aru saama, miks andmemudel on selline ja kuidas sellest äriväärtust kätte saada.

## Kontrollküsimused Enne Faili GitHubi Panemist

Enne kui meeskond paneb W3 töö GitHubi, tasub küsida:

- Kas iga SQL fail töötab Supabase SQL Editoris ilma veata?
- Kas päring kasutab ainult W3-s saadaolevaid tabeleid?
- Kas `ON` tingimused ühendavad õigeid võtmeid?
- Kas TOP kliendi päringus kasutatakse `SUM(s.total_price)`, mitte ühe rea summat?
- Kas ostuta klientide päring algab `customers` tabelist ja kasutab LEFT JOINi?
- Kas müümata toodete päring algab `products` tabelist ja kasutab LEFT JOINi?
- Kas README ütleb, mida Anna saab tulemusega teha?

Kui mõni vastus on "ei", ei ole töö veel valmis. See kontroll ei ole karistus; see on kvaliteediharjumus, mida andmeanalüütik vajab igas projektis.

Hea W3 repo ei pea olema suur. Parem on neli töötavat päringut ja selge README kui kümme poolikut päringut ilma tõlgenduseta. Anna vajab otsust, Toomas vajab korrektsust, ja portfoolio vajab selget lugu.

## Kõige Olulisem Mõte

Kui pead nädal 3 ühe mõttega kokku võtma, siis see on: JOIN muudab ID-d inimesteks, toodeteks ja otsusteks. Enne JOINi näeb Anna `customer_id` ja `product_id`. Pärast JOINi näeb ta kliendi nime, linna, toote kategooriat ja ostu väärtust.

See on andmeanalüüsi võlu väga praktilisel kujul. Andmed ei muutu paremaks sellepärast, et päring on pikk. Andmed muutuvad kasulikuks siis, kui õiged tabelid on õigesti ühendatud ja tulemus on sõnastatud inimesele, kes peab otsuse tegema. Nädal 3 on esimene kord, kus see tunne päriselt kätte tuleb: tehniline seos muutub äriliseks vastuseks.

Kui see lause jääb meelde, on nädal 3 hästi tehtud. Iga järgmine SQL teema ehitab sellele samale põhimõttele: kõigepealt ühenda õiged andmed, siis küsi parem küsimus ja kontrolli vastust enne otsust, demo ja portfooliosse lisamist. See on professionaalne analüütiku tööviis.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist ja on optimeeritud NotebookLM audio genereerimiseks.*

# SQL Praktikas: Toomas Kaski Esimene Väljakutse UrbanStyle'i Andmetega

## Sissejuhatus

Toomas Kask saatis sulle e-maili pealkirjaga "URGENT - Sales tabeli probleem". Ta on avastanud, et UrbanStyle'i müügitabelis on üle 5000 duplikeeritud rea ja ta vajab sinu abi. Aga enne kui midagi kustutama või parandama hakkad, tahab Toomas, et sa analüüsiksid andmeid ja raporteeriks, mida leiad.

See on sinu esimene päris andmeanalüüsi ülesanne ja sa lahendad selle SQL-iga. Selles dokumendis käime samm-sammult läbi, kuidas kasutada SELECT, WHERE, ORDER BY, LIMIT, DISTINCT ja COUNT konkreetselt UrbanStyle'i andmetega. Iga näide kasutab päris tabeleid ja päris veerge, mis on sinu Supabase andmebaasis.

---

## Toomas Kaski Esimene Päring: Kui Hull On Olukord?

Toomas alustas lihtsa küsimusega: mitu rida on sales tabelis? Siis küsis ta: mitu unikaalset arvet on? Ja vahe oli šokeeriv.

```sql
-- Mitu rida on sales tabelis kokku?
SELECT COUNT(*) AS kogu_ridade_arv FROM sales;
```

See päring annab vastuse: üle 15 000 rea. Aga see number ei ütle veel palju. Toomas teadis, et iga müügitehing peaks olema seotud ühe unikaalse invoice_id-ga. Nii et ta küsis:

```sql
-- Mitu unikaalset invoice_id on?
SELECT COUNT(DISTINCT invoice_id) AS unikaalseid_arveid FROM sales;
```

Tulemus: umbes 10 118 unikaalset arvet. Lihtne lahutamine: 15 234 miinus 10 118 võrdub 5 116. See tähendab, et sales tabelis on üle 5000 duplikaadi! See on umbes kolmandik kõigist ridadest.

See on esimene ja kõige olulisem leid. Duplikaadid tähendavad, et iga müügiaruanne, mida UrbanStyle on teinud, näitab liiga suurt käivet. Investoritele selliste numbritega minna oleks katastroof.

---

## Tallinn, Tartu ja Pärnu: Müügimustrite Uurimine

UrbanStyle'il on kolm poodi ja e-pood. Üks esimesi küsimusi, mida Toomas tahab teada, on: kuidas müük jaguneb asukohtade vahel? Alustame lihtsast uurimisest.

Esmalt vaatame, millised müügikanalid ja asukohad on andmetes:

```sql
-- Millised müügikanalid on kasutusel?
SELECT DISTINCT channel FROM sales;
```

See annab tavaliselt kaks väärtust: online ja store. Siis vaatame kauplusi:

```sql
-- Millised kaupluse asukohad on esindatud?
SELECT DISTINCT store_location FROM sales;
```

Siin näed Tallinn, Tartu, Pärnu ja tõenäoliselt ka NULL väärtusi, sest veebimüükidel ei ole kaupluse asukohta.

Nüüd saad hakata uurima konkreetseid mustreid. Näiteks, kui palju on veebimüüke versus poemüüke:

```sql
-- Kui palju on online müüke?
SELECT COUNT(*) AS online_muugid FROM sales WHERE channel = 'online';

-- Kui palju on poemüüke?
SELECT COUNT(*) AS poe_muugid FROM sales WHERE channel = 'store';
```

Või kui sa tahad näha konkreetse poe müüke:

```sql
-- Tallinna poe müügid, sorteeritud summa järgi
SELECT * FROM sales
WHERE store_location = 'Tallinn'
ORDER BY total_price DESC
LIMIT 10;
```

See annab sulle 10 kõige suuremat müüki Tallinna poes. Võid proovida sama Tartu ja Pärnuga ja võrrelda, kas on erinevusi.

---

## Toodete Uurimine: Millised Kategooriad Müüvad Paremini?

UrbanStyle müüb kolmes põhikategoorias: naiste riided, aksessuaarid ja meeste riided. Products tabelit saab uurida, et mõista toodete jaotust.

```sql
-- Millised tootekategooriad on?
SELECT DISTINCT category FROM products;
```

Siis saad vaadata, mitu toodet on igas kategoorias. Kuigi GROUP BY tuleb ametlikult alles nädala 4 materjalis, on hea teada, et DISTINCT näitab sulle vähemalt kategooriate nimed.

```sql
-- Mitu toodet on kokku?
SELECT COUNT(*) AS toodete_arv FROM products;

-- Mitu unikaalset toote nime on?
SELECT COUNT(DISTINCT product_name) AS unikaalseid_tooteid FROM products;
```

Kui need kaks numbrit on erinevad, tähendab see, et ka toodete tabelis on duplikaate.

Hindu saad uurida ORDER BY abil:

```sql
-- 5 kalleimat toodet
SELECT product_name, category, retail_price
FROM products
ORDER BY retail_price DESC
LIMIT 5;

-- 5 odavaimat toodet
SELECT product_name, category, retail_price
FROM products
ORDER BY retail_price ASC
LIMIT 5;
```

See annab sulle hinnavahemiku. Kui kõige kallim toode on näiteks 249 eurot ja odavaim 9 eurot, siis see ütleb sulle midagi UrbanStyle'i tootevaliku kohta.

Eco-sertifitseeritud toodete uurimine:

```sql
-- Mitu toodet on eco-sertifitseeritud?
SELECT COUNT(*) AS eco_tooted FROM products WHERE eco_certified = true;

-- Mitu ei ole?
SELECT COUNT(*) AS mitte_eco FROM products WHERE eco_certified = false;
```

See on oluline Kristile, kes rõhutab jätkusuutlikkust. Kui ainult väike osa tooteid on eco-sertifitseeritud, võib see olla probleem brändilubaduse seisukohalt.

---

## Kliendianalüüs: Kes On UrbanStyle'i Kliendid?

Customers tabel sisaldab infot klientide kohta. Alustame põhiküsimustega.

```sql
-- Mitu klienti on kokku?
SELECT COUNT(*) AS klientide_arv FROM customers;

-- Millised linnad on esindatud?
SELECT DISTINCT city FROM customers;
```

Nüüd kontrolli andmekvaliteeti. Mitu klienti on ilma e-mailita?

```sql
-- Puuduvad e-mailid
SELECT COUNT(*) - COUNT(email) AS puuduvad_emailid FROM customers;
```

See on oluline number. Kui näiteks 15% klientidest on ilma e-mailita, tähendab see, et UrbanStyle ei saa neile turunduskirju saata. See on äriliselt oluline probleem.

Vaatame ka lojaalsuse tasemeid:

```sql
-- Millised lojaalsuse tasemed on?
SELECT DISTINCT loyalty_tier FROM customers;
```

Tulemuseks peaks olema bronze, silver ja gold. Ja sa saad uurida, millise linnaga on seotud erinevad tasemed:

```sql
-- Tallinna gold-taseme kliendid
SELECT first_name, last_name, email
FROM customers
WHERE city = 'Tallinn'
AND loyalty_tier = 'gold'
ORDER BY last_name ASC;
```

See on päring, mida Anna Mets turunduse juht võiks kasutada VIP-kampaania planeerimiseks.

Kontrolli ka duplikaate e-mailide põhjal:

```sql
-- Mitu unikaalset e-maili on?
SELECT COUNT(DISTINCT email) AS unikaalseid_emaile FROM customers;

-- Võrdle kogu klientide arvuga
SELECT COUNT(*) AS kliendid_kokku FROM customers;
```

Kui unikaalseid e-maile on vähem kui kliente, on osa klientidest kirjas mitu korda.

---

## Müügiandmete Kvaliteet: Millised Read Vajavad Tähelepanu?

Nädal 1-s ei ole sinu eesmärk andmeid parandada. Sinu eesmärk on aru saada, kas müügiandmetes on kohti, mida Toomas peaks enne raportite koostamist kontrollima. Selleks piisab `sales` tabelist ja lihtsatest SQL päringutest.

```sql
-- Mitu müügirida on puuduva invoice_id-ga?
SELECT COUNT(*) - COUNT(invoice_id) AS puuduvad_invoice_id
FROM sales;

-- Mitu müügirida on puuduva kuupäevaga?
SELECT COUNT(*) - COUNT(sale_date) AS puuduvad_kuupaevad
FROM sales;
```

Kui `invoice_id` või `sale_date` puudub, on see müügiandmete jaoks tõsine kvaliteediprobleem. Ilma arve ID-ta on raske aru saada, kas rida on päris müük või tehniline jääk. Ilma kuupäevata ei saa müüki õigesse perioodi panna.

```sql
-- Millised müügikanalid on andmetes?
SELECT DISTINCT channel FROM sales;
```

See kontroll aitab sul näha, kas kanalite väärtused on ootuspärased. UrbanStyle'i N1 andmetes peaksid nägema eelkõige `online` ja `store` väärtusi. Kui ilmuks näiteks `Online`, `ONLINE` või tühikuga `store `, oleks see märk puhastamist vajavast andmest.

Kontrolli ka summade anomaaliaid:

```sql
-- Kas müügis on null või negatiivseid summasid?
SELECT COUNT(*) AS kahtlased_summad
FROM sales
WHERE total_price <= 0;
```

Kui `total_price` on 0 või negatiivne, võib see tähendada tagastust, testkirjet või importimise viga. Nädal 1-s sa seda veel ei paranda; sa märgid selle raportisse kui küsimuse, mida Toomas peab kontrollima.

```sql
-- 10 kõige suuremat müügisummat
SELECT sale_id, invoice_id, sale_date, total_price, channel, store_location
FROM sales
ORDER BY total_price DESC
LIMIT 10;
```

See päring näitab, kas andmetes on väga suuri müüke. Suur müük ei ole automaatselt viga, aga andmeanalüütik peab oskama eristada "huvitavat" ja "kahtlast". Kui üks rida on kümme korda suurem kui teised, tasub see raportis eraldi välja tuua.

---

## Samm-Sammult Näidisanalüüs: Toomas Kaski Raport

Nüüd paneme kõik kokku. Toomas tahab vastust neljale küsimusele. Siin on samm-sammult lähenemisviis, kuidas sa raportit koostad.

Esimene küsimus: täpne duplikaatide arv.

```sql
-- Ridade koguarv
SELECT COUNT(*) AS kogu_read FROM sales;

-- Unikaalsed arved
SELECT COUNT(DISTINCT invoice_id) AS unikaalseid FROM sales;

-- Vahe on duplikaatide arv
-- Näiteks: 15234 - 10118 = 5116 duplikaati
```

Kirjuta kommentaar: "Sales tabelis on [X] rida, millest [Y] on unikaalsed. Duplikaatide arv on [X-Y], mis moodustab [protsent]% kogu ridadest."

Teine küsimus: millised read on duplikaadid? Seda on raske vastata ainult selle nädala tööriistadega, aga sa saad näidata trende:

```sql
-- Kas duplikaadid on konkreetsest perioodist?
SELECT * FROM sales
ORDER BY sale_date DESC
LIMIT 20;
```

Kolmas küsimus: NULL väärtused.

```sql
-- NULL customer_id väärtused
SELECT COUNT(*) - COUNT(customer_id) AS null_kliendid FROM sales;

-- NULL store_location väärtused (peaks olema NULL online müükidel)
SELECT COUNT(*) - COUNT(store_location) AS null_asukoht FROM sales;
```

Neljas küsimus: suurimad ja väiksemad müügid.

```sql
-- 10 suurimat müüki
SELECT sale_id, sale_date, total_price, channel, store_location
FROM sales
ORDER BY total_price DESC
LIMIT 10;

-- 10 väikseimat müüki (kas on null või negatiivseid?)
SELECT sale_id, sale_date, total_price, channel, store_location
FROM sales
ORDER BY total_price ASC
LIMIT 10;
```

Kui leiad 0 või negatiivseid summasid, on see oluline leid, mis viitab tagastustele või vigadele.

---

## Kuidas Toomas Mõtleb: Tehnilisest Leiust Ärikeelde

Kui sa ütled Toomasele ainult "COUNT DISTINCT näitab väiksemat arvu kui COUNT", siis see on tehniliselt õige, aga äriliselt poolik. Toomas peab aru saama, miks see oluline on. Andmeanalüütiku töö ei ole ainult päringu kirjutamine, vaid tulemuse tõlkimine otsustajale.

Võrdleme kahte raporti lauset.

Esimene versioon:

"Sales tabelis on 15 234 rida ja 10 118 unikaalset invoice_id väärtust."

See on korrektne, aga lugeja peab ise järelduse tegema.

Parem versioon:

"Sales tabelis on 15 234 rida, kuid ainult 10 118 unikaalset arvet. See tähendab, et ligikaudu 5 116 rida on duplikaadid või vajavad eraldi kontrolli. Kui neid ridu kasutatakse käibe arvutamisel, võib müügitulemus olla oluliselt üle hinnatud."

Teine versioon seob tehnilise tulemuse äririskiga. Just seda ootab UrbanStyle'i meeskond: mitte ainult "mis päring tagastas", vaid "miks see meile korda läheb".

Nädal 1-s võid iga olulise päringu järel kirjutada endale kolm lühikest lauset:

1. Mis oli küsimus?
2. Mis oli tulemus?
3. Miks see UrbanStyle'i jaoks oluline on?

Näiteks:

```sql
-- Küsimus: mitu müügirida on sales tabelis?
SELECT COUNT(*) AS ridu_kokku
FROM sales;
```

Tõlgendus:

"Küsimus oli, kui suur on müügitabel. Tulemuseks oli 15 234 rida. See annab meile lähtepunkti, millega võrrelda unikaalsete arvete arvu ja hinnata duplikaatide ulatust."

Selline kirjutamisviis aitab sul portfoolios näidata mõtlemist, mitte ainult SQL-i.

---

## Väike Uurimisplaan Enne Päringute Kirjutamist

Kui andmebaas on ees, võib tekkida tunne, et peaks kohe midagi käivitama. Tegelikult on kasulik teha enne 5-minutiline plaan. Nädal 1 Toomase väljakutse puhul võiks plaan olla selline:

Esiteks vaatan tabelite suurust. Kui `sales`, `products` või `customers` on tühjad, ei ole mõtet veel analüüsi teha. See tähendab, et import vajab kontrolli.

```sql
SELECT COUNT(*) AS sales_read FROM sales;
SELECT COUNT(*) AS products_read FROM products;
SELECT COUNT(*) AS customers_read FROM customers;
```

Teiseks vaatan, millised väärtused korduvad kategoorilistes veergudes. See aitab mõista, kas andmed on ootuspärased.

```sql
SELECT DISTINCT channel FROM sales;
SELECT DISTINCT store_location FROM sales;
SELECT DISTINCT category FROM products;
SELECT DISTINCT city FROM customers;
```

Kolmandaks kontrollin puuduvate väärtuste märke. Nädal 1-s ei pea sa kõiki NULL väärtusi parandama, aga pead aru saama, kus need on.

```sql
SELECT COUNT(*) - COUNT(customer_id) AS puuduvad_customer_id
FROM sales;

SELECT COUNT(*) - COUNT(email) AS puuduvad_emailid
FROM customers;
```

Neljandaks vaatan äärmusi. Äärmused ei ole alati vead, aga need on sageli head kohad, kust anomaaliaid otsida.

```sql
SELECT sale_id, invoice_id, total_price
FROM sales
ORDER BY total_price DESC
LIMIT 10;

SELECT sale_id, invoice_id, total_price
FROM sales
ORDER BY total_price ASC
LIMIT 10;
```

Selline plaan muudab töö rahulikuks. Sa ei pea kõike korraga teadma. Sa liigud üldisest konkreetseks: suurus, väärtused, puuduvad andmed, äärmused.

---

## Kuidas Kasutada AI-d Ilma Oma Mõtlemist Välja Andmata

DACA-s on AI kasutamine lubatud ja oodatud, aga AI ei peaks sinu eest analüüsi "ära tegema". Hea kasutus on selline, kus AI aitab sul mõista, kontrollida ja sõnastada.

Näiteks pärast päringu kirjutamist võid küsida:

```text
Õpin SQL-i. Kirjutasin selle päringu:
[kleebi päring]

Selgita mulle algaja keeles, mida see päring teeb. Ära kirjuta uut keerulisemat lahendust, vaid aita mul aru saada, kas minu mõte on õige.
```

Kui saad veateate, küsi:

```text
Sain PostgreSQL-is selle veateate:
[kleebi veateade]

Minu päring on:
[kleebi päring]

Palun selgita, mis on tõenäoline põhjus ja millist ühte asja ma esimesena kontrollin.
```

Kui kirjutad portfoolio README kokkuvõtet, võid küsida:

```text
Mul on need SQL tulemused:
[kirjuta 3-5 tulemust]

Aita mul sõnastada neist lühike äriline kokkuvõte Toomas Kasele. Hoia keel lihtne ja ära lisa tulemusi, mida ma pole andnud.
```

Viimane lause on tähtis: "ära lisa tulemusi, mida ma pole andnud." AI võib vahel oletada. Andmeanalüütik ei tohi raportisse panna oletusi faktidena. Kui AI pakub midagi, mida sinu päring ei tõestanud, jäta see välja või kontrolli eraldi päringuga.

Hea AI kasutamine jätab sulle kontrolli. Sina otsustad, milline küsimus on oluline. Sina käivitad päringu. Sina vaatad tulemust. AI aitab seletada ja sõnastada, aga ei asenda sinu vastutust.

---

## Mida Teha, Kui Tulemused Erinevad Naabri Omadest

Nädal 1-s võib juhtuda, et sinu tulemus ei ole sama mis grupikaaslasel. See ei tähenda kohe, et keegi on halb analüütik. Enamasti tähendab see, et andmebaasi import või päringu tingimus erineb.

Kui näiteks sinu `sales` ridade arv ei ole 15 234, kontrolli kõigepealt importi. Kas `sales.csv` imporditi staging-tabeli kaudu? Kas mõni rida jäi veaga välja? Kas importisid kogemata sama faili kaks korda? Kas töötad õiges Supabase projektis?

Hea kontrollpäring on:

```sql
SELECT COUNT(*) AS ridu_kokku
FROM sales;
```

Kui see erineb oodatust, ära liigu edasi keerulisemate küsimuste juurde. Kõigepealt lahenda andmete aluskiht. Vale ridade arv tähendab, et kõik järgmised järeldused võivad olla nihkes.

Kui ridade arv on sama, aga näiteks duplikaatide arv erineb, kontrolli päringut:

```sql
SELECT COUNT(DISTINCT invoice_id) AS unikaalseid_arveid
FROM sales;
```

Kas kasutasid sama veergu? `invoice_id` ja `sale_id` ei tähenda sama asja. `sale_id` on rea tehniline ID, `invoice_id` on arve tunnus. Toomase probleem on seotud just arvetega, mitte lihtsalt rea ID-ga.

Kui tulemused erinevad filtritega päringutes, kontrolli tingimust. Tekstväärtused peavad olema täpsed:

```sql
-- Need võivad anda erineva tulemuse, kui andmetes on väärtused väikeste tähtedega
WHERE channel = 'online'
WHERE channel = 'Online'
```

Seetõttu on enne filtreerimist hea teha:

```sql
SELECT DISTINCT channel
FROM sales;
```

See näitab, millised väärtused tegelikult tabelis on. Ära eelda, et tead väärtuse kirjapilti peast.

Grupitöös on erinevad tulemused sageli kasulikud, sest need sunnivad kontrollima eeldusi. Ärge alustage vaidlust sellest, kelle vastus on "õige". Alustage sellest, kas mõlemad kasutasid sama andmestikku, sama tabelit, sama veergu ja sama tingimust.

---

## Nädal 1 Hea Lõpptulemus

Hea Nädal 1 tulemus ei ole täiuslik dashboard ega keeruline andmemudel. Hea tulemus on selge, kontrollitud ja seletatav esimene analüüs.

Kui Toomas vaatab sinu tööd, võiks ta näha:

- sa importisid õiged kolm tabelit;
- sa kontrollisid ridade arvu;
- sa leidsid duplikaatide ulatuse `invoice_id` põhjal;
- sa vaatasid olulisemaid NULL või kahtlasi väärtusi;
- sa dokumenteerisid päringud kommentaaridega;
- sa kirjutasid lihtsa ärilise kokkuvõtte.

Näiteks võib sinu kokkuvõte olla selline:

"Uurisin UrbanStyle'i `sales` tabelit, kus on 15 234 rida. Unikaalseid `invoice_id` väärtusi on ligikaudu 10 118, mis viitab umbes 5 116 duplikaadile või täiendavat kontrolli vajavale reale. See tähendab, et müügiraportid võivad näidata tegelikust suuremat käivet, kui duplikaate enne raporti koostamist ei käsitleta. Järgmine samm on Nädal 2-s duplikaatide täpsem tuvastamine ja puhastamise loogika."

See on hea, sest see on lühike, konkreetne ja seob SQL tulemuse ärilise riskiga. Seal ei ole liigset tehnilist müra, aga tehniline alus on olemas.

Kui tahad lisada veidi rohkem detailsust, võid mainida ka kanalite või asukohtade kontrolli:

"Lisaks kontrollisin müügikanaleid ja kaupluse asukohti. `channel` väärtused olid ootuspärased (`online`, `store`) ning `store_location` aitab eristada Tallinna, Tartu ja Pärnu poemüüke veebimüügist. Online müükide puhul võib `store_location` olla NULL, mis ei ole automaatselt viga."

Selline täpsustus näitab, et sa ei käsitle iga NULL väärtust probleemina. See on oluline analüütiku küpsuse märk: puuduv väärtus võib olla viga, aga võib olla ka äriliselt loogiline. Küsimus on kontekstis.

Nädal 1 lõpuks ei pea sa veel kõiki probleeme lahendama. Pead oskama need märgata, kirjeldada ja järgmise sammu sõnastada. See on juba päris andmeanalüüsi töö.

---

## Enne Kui Loed Analüüsi Valmis Olevaks

Enne töö lõpetamist tee üks rahulik enesekontroll. Kas kõik päringud kasutavad ainult neid tabeleid, mis Nädal 1-s olemas on: `sales`, `products` ja `customers`? Kas iga päring vastab ühele arusaadavale küsimusele? Kas tulemus on kirja pandud nii, et grupikaaslane saaks sellest aru ka ilma sinu kõrval istumata?

Kontrolli ka, et sa ei lubaks rohkem, kui sinu päring tõestab. Kui leidsid duplikaatide arvu, võid öelda, et andmestik vajab puhastamist. Sa ei pea veel ütlema, millised read tuleb kustutada, sest see on järgmiste nädalate teema. Kui näed `store_location` veerus NULL väärtusi, ära nimeta neid kohe veaks: online müükide puhul võib see olla täiesti loogiline.

Hea analüüs on aus oma piiride suhtes. See ütleb, mida me teame, mida me veel ei tea ja milline võiks olla järgmine kontroll. Just see teeb algaja tööst professionaalse esimese sammu.

Kui kahtled, kirjuta lühemalt, aga kontrolli iga väidet päringuga enne esitamist või jagamist.

---

## Portfooliosse Panemine: Kuidas Dokumenteerida Oma Tööd

Toomas ootab korrektselt dokumenteeritud tööd. See tähendab, et iga päring peab olema kommenteeritud ja tulemused peavad olema kokkuvõtlikult kirjeldatud.

Sinu week-1 kataloogis peaks olema fail week1_sales_exploration.sql, mis näeb välja umbes nii:

```sql
-- =====================================================
-- Week 1: UrbanStyle Sales Tabeli Uurimisuuring
-- Autor: [Sinu Nimi]
-- Kuupäev: [Kuupäev]
-- Eesmärk: Vastata Toomas Kaski küsimustele sales tabeli kohta
-- =====================================================

-- 1. Mitu rida on sales tabelis kokku?
SELECT COUNT(*) AS kogu_read FROM sales;
-- Tulemus: [kirjuta tulemus siia]
-- Kommentaar: [mis see tähendab?]

-- 2. Mitu unikaalset invoice_id on?
SELECT COUNT(DISTINCT invoice_id) AS unikaalseid FROM sales;
-- Tulemus: [kirjuta tulemus siia]
-- Duplikaatide arv: [kogu_read - unikaalseid]

-- 3. Kõige suuremad müügid
SELECT sale_id, sale_date, total_price, channel
FROM sales
ORDER BY total_price DESC
LIMIT 10;
-- Suurim müük: [summa] EUR, kuupäev: [kuupäev]

-- 4. Müügid üle 500 EUR
SELECT COUNT(*) AS suured_muugid
FROM sales
WHERE total_price > 500;
-- Tulemus: [arv] suurt müüki

-- 5. NULL klientide kontroll
SELECT COUNT(*) - COUNT(customer_id) AS null_kliendid FROM sales;
-- Tulemus: [arv] rida ilma kliendi ID-ta
```

Iga päringu juures kirjuta, mida sa leidsid ja mida see ärilliselt tähendab. Toomas hindab mitte ainult tehnilisi oskusi, vaid ka seda, kas sa mõistad, miks see info on oluline.

README.md failis kirjuta lühike kokkuvõte: mida sa leidsid, mis oli üllatav ja mis peaks olema järgmine samm. Näiteks: "Leiti 5116 duplikaati, mis moodustavad 33,6% kõigist ridadest. Soovitus: enne aruannete koostamist tuleb duplikaadid eemaldada."

---

## Kokkuvõte: Sinu Esimene Päris Analüüs

Selle nädala jooksul oled sa teinud midagi, mida paljud inimesed ei suuda: sa oled vaadanud toored andmed, leidnud neist probleeme ja koostanud aruande. See on andmeanalüütiku igapäevatöö.

Sa oled õppinud kasutama SELECT-i veergude valimiseks, WHERE-i andmete filtreerimiseks, ORDER BY-d sorteerimiseks, LIMIT-it tulemuste piiramiseks, DISTINCT-i unikaalsete väärtuste leidmiseks ja COUNT-i loendamiseks. Ja sa oled rakendanud neid kõiki UrbanStyle'i päris andmetele.

Toomas Kask on nüüd pisut vähem skeptiline. Ta ütleb: "Hea algus. Aga dokumentatsioon võiks olla detailsem." See on konstruktiivne tagasiside ja sa õpid sellest. Järgmisel nädalal hakkate neid duplikaate päriselt kustutama ja andmeid puhastama. Oled valmis?

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist ja on optimeeritud NotebookLM audio genereerimiseks.*

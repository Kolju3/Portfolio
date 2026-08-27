# UrbanStyle-i Esimene Dashboard: Investoritele Valmis Prototüüp

## Sissejuhatus

Kristi Tamm on just teada andnud: investorid tulevad viie nädala pärast. Nad tahavad näha numbreid, aga mitte Excelis ega PowerPointis. Nad tahavad interaktiivset, professionaalset dashboard-i, mis näitab UrbanStyle.ltd tervist ühe pilguga. Ja Anna Mets on juba elevil: "Lõpuks ma saan NÄHA andmeid, mitte ainult lugeda numbreid!"

See on su hetk. Neli nädalat SQL-i tööd on andnud sulle andmed. Nüüd on aeg need nähtavaks teha. Selles dokumendis vaatame läbi, kuidas ehitada UrbanStyle-i investor dashboard samm-sammult: milliseid mõõdikuid näidata, milliseid diagramme kasutada ja kuidas kogu pakett kokku panna.

## Kristi Väljakutse: Neli Küsimust

Kristi seisab meeskonna ees ja ütleb väga selgelt, mida ta vajab. Neli küsimust, millele dashboard peab vastama:

**"Kas me kasvame või sureme?"** See on kõige olulisem küsimus. Investor tahab näha trendi. Kas käive läheb üles, alla või on paigal? Sellele vastab igakuise käive joondiagramm. Kui joon läheb üles, on see hea uudis. Kui joon on lame või langeb, on probleem.

**"Mis tooted müüvad?"** Investor tahab aru saada, kas UrbanStyle-il on tugev tooteportfell. Kas on üks hitttoode või on müük ühtlaselt jaotunud? Sellele vastab TOP toodete tulpdiagramm. Kui Denim Jacket annab 28% käibest, on see tugev signaal, aga ka risk: liiga suur sõltuvus ühest tootest.

**"Kust tulevad meie kliendid?"** See küsimus puudutab geograafilist jaotust ja kanaleid. Kas online müüb rohkem kui poed? Milline linn on tugevaim? Sellele vastab linnade ja kanalite sektordiagramm või tulpdiagramm.

**"Kas marketing töötab?"** Anna Mets eriti ootab seda vastust. Investor tahab näha, et reklaamile kulutatud raha tuleb tagasi. Sellele vastab turunduskanalite ROI analüüs.

## Käivetrend: Joondiagramm

Esimene ja kõige olulisem element dashboard-is on käive joondiagramm. See on su dashboard-i "hero chart" ja ta peaks olema kõige suurem diagramm ekraanil.

Andmed tulevad SQL-ist, mida sa juba oskad:

```sql
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS käive
FROM sales
WHERE sale_date >= CURRENT_DATE - INTERVAL '12 months'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;
```

See päring annab sulle 12 rida: üks iga kuu kohta, koos käivega. Kui sa seda visualiseerid joondiagrammina, siis investor näeb kohe: kas joon läheb üles? Mitu protsenti see kasvas? Kus on tipud ja madalseisud?

Hea joondiagramm lisab konteksti. Ära lihtsalt näita joont, vaid lisa ka:
- Y-telje valuuta formaat (EUR)
- Selged kuuldi sildid (Jan, Feb, Mar)
- Pealkiri, mis vastab küsimusele: "UrbanStyle igakuine käive (viimased 12 kuud)"

Anna kommenteerib: "Ma näen detsembri tippu! See on jõulukampaania mõju. Ja vaata, september on ka tugev. Back-to-school hooaeg!" See on täpselt see mõtteprotsess, mida hea dashboard esile kutsub.

## Toote Analüüs: Tulpdiagramm

Teine oluline element on toodete analüüs. Investor tahab teada, millised tooted käivet sisse toovad. TOP 5 või TOP 10 toodet tulpdiagrammina on klassikaline valik.

```sql
SELECT
    p.product_name,
    SUM(s.total_price) AS käive
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY käive DESC
LIMIT 10;
```

Horisontaalne tulpdiagramm sobib siin hästi, sest tootenimed on pikad. Sorteeri tulbad kahanevalt ja kasutaja näeb kohe, mis on number üks.

Aga toodete analüüs ei piirdu ainult TOP toodetega. Anna tahab teada ka kategooria jaotust: naiste riided vs aksessuaarid vs meeste riided. See annab investorile ülevaate tooteportfellist:

```sql
SELECT
    p.category,
    COUNT(*) AS tehinguid,
    SUM(s.total_price) AS käive,
    ROUND(100.0 * SUM(s.total_price) / SUM(SUM(s.total_price)) OVER (), 1) AS osakaal
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY käive DESC;
```

Kui naiste riided annavad 60% käibest, aksessuaarid 25% ja meeste riided 15%, siis see on tervislik jaotus. Investor näeb, et ettevõttel on tugevad tuumkategooriad ja kasvav meeste liin.

## Geograafiline Analüüs: Linnade Võrdlus

UrbanStyle-il on kolm füüsilist poodi (Tallinn, Tartu, Pärnu) ja online-kanal. Investor tahab teada, kuidas need omavahel võrdlevad.

Sektordiagramm sobib siin hästi, sest kategooriaid on neli. 60% online, 20% Tallinn, 12% Tartu, 8% Pärnu oleks tüüpiline jaotus. See annab investorile kohese ülevaate: online domineerib, aga füüsilised poed lisavad väärtust.

Aga sektordiagramm näitab ainult hetkeseisu. Investor tahab teada ka trendi: kas online osakaal kasvab? Kas Tartu jõuab Tallinnale järele? Selleks on vaja kuist trendi linnade kaupa ja see on juba keerulisem visualiseerimine, mis sobib paremini Nädal 6 edasijõudnute ülesandeks.

Anna lisab siia veel ühe kihi: müügikanalite mõju. Kust tulevad kliendid? Millised müügikanalid toovad kõige rohkem tulu? See info tuleb sales tabeli channel veerust ja aitab mõista, millised kanalid töötavad kõige paremini.

## KPI Kaardid: Ühe Pilguga Ülevaade

Dashboard-i ülaosas peavad olema KPI kaardid. Need on suured numbrid, mis annavad kohese ülevaate. UrbanStyle-i puhul on neli peamist KPI-d:

**Kogukäive (Total Revenue):** See on kõige olulisem number. "250 000 EUR" suures kirjas, koos protsendiga: "+15% võrreldes eelmise aastaga". Roheline nool üles. Investor näeb kohe: kasv.

**Klientide arv (Total Customers):** Unikaalsete klientide arv näitab kliendibaasi suurust. "1 234 klienti" koos kasvuga: "+8%". See näitab, et UrbanStyle kasvab mitte ainult käibelt, vaid ka klientide arvult.

**Keskmine tellimusväärtus (Average Order Value):** "65 EUR" näitab, kui palju keskmine klient kulutab. Kui see number kasvab, tähendab see, et kliendid ostavad rohkem. See on positiivne signaal investorile.

**Kasv (Growth %):** Perioodi kasvu protsent annab kiire ülevaate. "+15% YoY" (Year over Year) on tugev number. Alla 5% oleks muret tekitav, üle 20% oleks muljetavaldav.

## Dashboard-i Kokkupanemine

Nüüd kui sul on kõik elemendid olemas, paned need kokku ühele ekraanile. Siin on layout, mis töötab:

Ülemises reas on neli KPI kaarti kõrvuti. Nad on suurte numbritega ja annavad kohese ülevaate. Selle all on peadiagramm: käive joondiagramm, mis hõlmab kogu ekraani laiuse. See on kõige olulisem visuaal ja ta saab kõige rohkem ruumi.

Allpool on kaks väiksemat diagrammi kõrvuti: vasakul TOP toodete tulpdiagramm, paremal müük linnade kaupa sektordiagramm. Need annavad detailsemat infot, aga ei domineeri.

Kõige all on filtrid: kuupäevavahemik ja linna valik. Need võimaldavad kasutajal dashboard-i kohandada.

See on lihtne, puhas ja professionaalne layout. Kristi saab sellega investoritele esineda. Anna saab sellega turundusstrateegiat planeerida. Ja sina saad selle GitHub-i portfooliosse panna.

## Lihtne Alustamine: Samm-Sammult

Kui Power BI või Plotly on sulle uus, ära proovi kõike korraga teha. Alusta ühest diagrammist. Tee see toimima. Seejärel lisa järgmine.

Soovitatav järjekord:
1. KPI kaardid (lihtsad numbrid, kiire edu)
2. Käive joondiagramm (peadiagramm)
3. TOP toodete tulpdiagramm
4. Linnade sektordiagramm
5. Filtrid
6. Layout ja disain

Iga sammu juures testi: kas andmed on õiged? Kas diagramm on loetav? Kas see vastab küsimusele? Alles siis liigu edasi.

Anna ütleb: "Ma vajan visuaale! Aga alustage lihtsalt. Üks hea diagramm on parem kui viis segast."

## Brändivärvid ja Disain

UrbanStyle-i dashboard peaks kasutama brändi värve. See annab professionaalse mulje ja näitab, et dashboard on osa ettevõtte identiteedist.

Peamised värvid: teal (#009B8D) peamine aktsentvärv, navy (#1A1A2E) teksti jaoks. Taustaks valge (#FFFFFF) ja helehall (#F5F5F5) sektsioonide eraldamiseks. Need värvid on puhtad, professionaalsed ja loetavad.

Fond: Calibri on UrbanStyle-i standard. Pealkirjad 18-24pt, põhitekst 12-14pt, sildid 10-12pt.

Tulemus peaks olema visuaalselt ühtsev kogu dashboard-i ulatuses. Samad värvid samadele kategooriatele kõigis diagrammides. Tallinn on alati sama värv, online on alati sama värv. See vähendab kognitiivset koormust ja aitab kasutajal kiiremini orienteeruda.

## Portfoolio Ettevalmistus

See dashboard läheb su GitHub portfooliosse. See on su esimene visuaalne projekt ja see peab olema muljetavaldav. Mida sa pead tegema:

Ekraanipilt on kohustuslik. Tee dashboard-ist kõrgekvaliteediline screenshot ja lisa see README faili. See on esimene asi, mida tööandja su portfooliot vaadates näeb.

README peab kirjeldama: kes on klient (UrbanStyle.ltd), mis probleem (investori dashboard), millised tööriistad (Power BI / Plotly + Streamlit), millised disainiotsused (miks just need diagrammitüübid) ja milline ärimõju (mida Kristi selle infoga teha saab).

SQL päringud pead dokumenteerima. Lisa eraldi .sql fail, kus on kõik päringud kommentaaridega. See näitab, et sa ei ole ainult kopeerinud, vaid mõistad, mida iga päring teeb.

## Kokkuvõte

Sel nädalal sa ehitad oma esimese professionaalse dashboard-i. See ei ole harjutus, see on päris projekt. Kristi kasutab seda investoritele esitamiseks. Anna kasutab seda turunduse planeerimiseks. Ja sina kasutad seda portfoolios, et näidata potentsiaalsele tööandjale: "Ma oskan muuta andmed otsusteks."

Kõige olulisem on alustada. Ära oota perfektset plaani. Tee üks diagramm. Tee see hästi. Lisa järgmine. Nädala lõpuks on sul toimiv dashboard, mis vastab Kristi neljale küsimusele.

Kristi sõnad pühapäeval: "Oot, te tegite seda ÜHES NÄDALAS?" Jah, sa tegid. Ja järgmisel nädalal sa viimistled seda, lisad andmeloo ja avaldad. Anna juba ootab.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist. Optimeeritud NotebookLM audio genereerimiseks.*

# Nädal 3 – SQL JOINid: müügikanalite ja kliendilinnade analüüs

**Autor:** Kalju  
**Programm:** DACA – Andmeanalüütiku Karjäärikiirendi  
**Nädala põhiteema:** SQL JOINid  
**Individuaalne roll:** Roll D – müügikanalite ja linnade analüüs  
**Töökeskkond:** Supabase / PostgreSQL  

---

## Projekti kontekst

UrbanStyle.ltd müügi-, kliendi- ja tooteandmed paiknevad eri tabelites. Üksikust müügitabelist on võimalik näha tehinguid ja summasid, kuid kliendi linna, tootekategooria ning müügikoha koosmõju analüüsimiseks tuleb tabelid omavahel ühendada.

Minu ülesanne oli toetada turundusjuht **Anna Metsa** ning selgitada:

- kuidas jagunevad tehingud ja käive müügikohtade vahel;
- millistest linnadest pärinevad kliendid;
- kas kliendi linn ja ostukoht on omavahel selgelt seotud;
- millised tootekategooriad annavad suurema osa seotud klientide käibest;
- kui suur osa müügist ei ole kliendiandmetega seostatav.

Töö keskendus minu individuaalsele rollile. Meeskonna ühine analüüs ja esitlus on lingitud README lõpus.

---

## Eesmärk

Analüüsi eesmärk oli kasutada SQL JOIN-lauseid selleks, et muuta eraldi tabelites olevad ID-d äriliselt tõlgendatavaks infoks.

Põhiküsimused olid:

1. Milline müügikoht või kanal annab kõige rohkem tehinguid ja käivet?
2. Milliste linnade kliendid annavad suurima osa kliendiga seotud müügist?
3. Kas kliendid eelistavad oma elukohale vastavat füüsilist kauplust?
4. Millised tootekategooriad on kliendiga seotud müügis suurimad?
5. Kui täielikult on müügitehingud kliendiandmetega seotud?

---

## Kasutatud andmed

Analüüs põhines puhastatud testtabelitel:

- `Testing_Sales_Cleaned`
- `Testing_Customers_Cleaned`
- `Testing_Products_Cleaned`

Kontrollitud müügiandmete maht:

| Näitaja | Tulemus |
|---|---:|
| Müügitehinguid kokku | 10 118 |
| Müügikäive kokku | 2 898 513,90 € |
| Kliendiga seotud tehinguid | 9 134 |
| Kliendiga seotud käive | 2 612 379,91 € |
| Kliendita või tuvastamata tehinguid | 984 |
| Kliendita või tuvastamata käive | 286 133,99 € |

---

## Tehniline lahendus

### Kasutatud SQL-võtted

Analüüsis kasutati:

- `INNER JOIN`-i müügi-, kliendi- ja tooteandmete ühendamiseks;
- korrektseid seosevõtmeid:
  - `sales.customer_id = customers.customer_id`;
  - `sales.product_id = products.product_id`;
- tabelite aliaseid päringute loetavuse parandamiseks;
- `COUNT()` ja `COUNT(DISTINCT ...)` funktsioone tehingute ning klientide loendamiseks;
- `SUM()` funktsiooni käibe arvutamiseks;
- `GROUP BY`-d tulemuste koondamiseks müügikoha, kliendilinna ja tootekategooria järgi;
- `CTE`-sid ning aknafunktsioone osakaalude ja võrdluste arvutamiseks;
- `NULLIF()`-i nulliga jagamise vältimiseks;
- `ROLLUP`-i detail- ja kogusummade esitamiseks samas tulemuses.

JOIN oli analüüsi keskne töövõte: selle abil seostati müügitehingud kliendi linna ja toote kategooriaga. Agregaatfunktsioone kasutati juba ühendatud tulemuste kokkuvõtmiseks.

### Valideerimine

Tulemuste kontrollimiseks võrreldi:

- müügitehingute koguarvu;
- kogukäivet;
- kliendiga seotud tehinguid;
- kliendita tehinguid;
- müügikohtade koondsumma vastavust koguandmetele.

Kontroll näitas, et müügikohtade kaupa koondatud tulemused annavad kokku 10 118 tehingut ja 2 898 513,90 eurot käivet.

---

## Peamised tulemused

### 1. Müük müügikoha või kanali järgi

| Müügikoht / kanal | Tehinguid | Osakaal tehingutest | Käive | Osakaal käibest | Keskmine tehing |
|---|---:|---:|---:|---:|---:|
| Tallinn | 3 801 | 37,57% | 1 086 272,37 € | 37,48% | 285,79 € |
| Online | 3 462 | 34,22% | 1 001 224,86 € | 34,54% | 289,20 € |
| Tartu | 1 797 | 17,76% | 522 286,81 € | 18,02% | 290,64 € |
| Pärnu | 1 058 | 10,46% | 288 729,86 € | 9,96% | 272,90 € |
| **Kokku** | **10 118** | **100,00%** | **2 898 513,90 €** | **100,00%** | **286,47 €** |

**Tõlgendus:**

- Tallinna kauplus on suurim müügikoht nii tehingute arvu kui ka käibe järgi.
- Online-kanal jääb Tallinnale vähe alla ning moodustab ligikaudu kolmandiku kogu müügist.
- Tartu keskmine tehing on neljast müügikohast veidi suurim.
- Pärnu osakaal käibest on tehingute osakaalust väiksem ja sealne keskmine tehing on madalaim.
- Müügikohtade tehingu- ja käibeosakaalud on üldiselt sarnased. See tähendab, et erinevused tulenevad peamiselt tehingute mahust, mitte väga suurest erinevusest keskmises ostusummas.

### 2. Kliendiga seostamata müük

| Näitaja | Tulemus |
|---|---:|
| Kliendita tehinguid | 984 |
| Osakaal kõigist tehingutest | 9,73% |
| Kliendita tehingute käive | 286 133,99 € |
| Osakaal kogukäibest | 9,87% |

Ligikaudu kümnendikku müügist ei saa kliendi linna ega kliendiprofiiliga seostada. Seetõttu põhineb kliendilinnade ja kliendiprofiilide analüüs 9 134 tehingul, mitte kogu müügil.

### 3. Suurimad kliendilinnad kliendiga seotud käibe järgi

| Kliendi linn | Käive | Osakaal kliendiga seotud käibest |
|---|---:|---:|
| Tallinn | 1 007 663,32 € | 38,57% |
| Tartu | 522 853,28 € | 20,01% |
| Pärnu | 371 467,72 € | 14,22% |
| Narva | 122 329,36 € | 4,68% |
| Viljandi | 98 270,83 € | 3,76% |

Tallinna kliendid annavad suurima osa kliendiga seotud käibest. Samas ei tähenda kliendi linn automaatselt, et ost tehakse sama linna kaupluses.

### 4. Kliendi linn ja ostukoht ei lange alati kokku

Näiteks Tartu klientide ostud jagunesid järgmiselt:

| Ostukoht | Tartu klientide käive |
|---|---:|
| Tallinn | 190 897,37 € |
| Online | 177 922,31 € |
| Tartu | 96 984,47 € |
| Pärnu | 57 049,13 € |

Tartu kliendid tegid analüüsitud andmetes rohkem oste Tallinna kauplusest ja online-kanalist kui Tartu kauplusest. Sarnane ristostmise muster ilmnes ka Pärnu klientide puhul.

See tulemus ei tõesta veel kindlat kliendikäitumise põhjust. Võimalikud selgitused võivad olla reisimine, online-ostude tugev roll, kliendilinna aegumine või andmete genereerimise ja sidumise loogika. Muster vajab enne asukohapõhiste turundusotsuste tegemist täiendavat valideerimist.

### 5. Tootekategooriad kliendiga seotud käibe järgi

| Tootekategooria | Käive | Osakaal kliendiga seotud käibest |
|---|---:|---:|
| Jalanõud | 695 584,82 € | 26,63% |
| Meesteriided | 668 761,67 € | 25,60% |
| Naisteriided | 618 344,58 € | 23,67% |
| Aksessuaarid | 353 218,51 € | 13,52% |
| Lasteriided | 276 470,33 € | 10,58% |

Kolm suurimat kategooriat — jalanõud, meesteriided ja naisteriided — annavad kokku ligikaudu 76% kliendiga seotud käibest.

---

## Suurim üllatus

Suurim üllatus oli see, et kliendi linn ei ennustanud selgelt ostukohta. Näiteks Tartu kliendid tegid rohkem oste Tallinna kauplusest kui Tartu kauplusest.

See näitab, miks ei piisa ainult ühe tabeli või ühe tunnuse vaatamisest. Alles müügi- ja kliendiandmete ühendamine tõi esile mustri, mida üksikutes tabelites ei olnud võimalik näha.

---

## Soovitused Anna Metsale

1. **Hoida turunduse põhifookus Tallinnal ja online-kanalil.**  
   Need kaks müügikohta annavad kokku üle 72% tehingutest ja ligikaudu 72% käibest.

2. **Analüüsida Pärnu madalamat keskmist tehingut eraldi.**  
   Kontrollida tuleks tootevalikut, kampaaniaid, hinnataset ja klientide ostukorvi koosseisu.

3. **Parandada kliendi tuvastamist müügiprotsessis.**  
   Ligikaudu 10% müügist ei ole kliendiga seotud. See piirab lojaalsuse, segmentatsiooni ja piirkondliku turunduse analüüsi.

4. **Mitte eeldada, et kliendi linn võrdub eelistatud kauplusega.**  
   Asukohapõhised kampaaniad tuleks enne laiemat rakendamist testida ja ristostmise muster valideerida.

5. **Kohandada kampaaniasõnumeid kategooriate järgi.**  
   Jalanõud, meesteriided ja naisteriided moodustavad suurema osa käibest ning vajavad põhikampaaniates selget esindatust.

6. **Jätkata analüüsi ajamõõtmega.**  
   Järgmine samm peaks olema kontrollida, kas müügikohtade, linnade ja kategooriate erinevused on ajas püsivad või tulenevad üksikutest perioodidest.

---

## Analüüsi piirangud

- 984 tehingut ei ole kliendiga seotud ja jäävad kliendilinna analüüsist välja.
- Kliendi linn võib olla aegunud või kirjeldada elukohta, mitte ostu tegemise hetke asukohta.
- Koondandmed näitavad seoseid, kuid ei tõesta nende põhjuseid.
- Müügikoha käive üksi ei näita kampaania tasuvust, sest analüüsis puuduvad kampaaniakulud.
- Tulemused põhinevad puhastatud testtabelitel ja neid ei tohiks käsitleda produktsiooniaruandena ilma täiendava kontrollita.

---

## Mida õppisin

Nädala jooksul õppisin:

- ühendama mitu tabelit õigete võtmete kaudu;
- eristama `INNER JOIN`-i kasutust olukordades, kus analüüs vajab ainult sobivaid kirjeid;
- kasutama tabelite aliaseid;
- kontrollima, kuidas JOIN mõjutab tulemuse ridade arvu;
- koondama ühendatud andmeid müügikoha, kliendilinna ja tootekategooria järgi;
- valideerima detailtulemusi kogusummade vastu;
- tõlgendama SQL-i tehnilisi tulemusi turunduse ja juhtimisotsuste vaates.

Nädala keskne õppetund oli, et JOIN ei ole ainult tabelite tehniline ühendamine. Selle abil muutuvad ID-d inimesteks, toodeteks, asukohtadeks ja otsuseid toetavaks infoks.

---

## AI kasutamine

AI-d kasutati:

- SQL-päringute loogika ja loetavuse kontrollimiseks;
- JOIN-seoste ning tulemuste valideerimise küsimuste läbimõtlemiseks;
- README struktuuri ja ärilise tõlgenduse korrastamiseks.

Kõik SQL-päringud käivitati Supabase'is ning README-s esitatud tulemusi kontrolliti algsete väljundfailide ja koondsumma vastu.

---

## Failid

### SQL-päringud

- [SQL-koodi kaust](./Week_3_Code/)
- [Client_and_shoping_data_analyzer.sql](./Week_3_Code/Client_and_shoping_data_analyzer.sql)
- [Client_and_shoping_data_analyzer_ver2.sql](./Week_3_Code/Client_and_shoping_data_analyzer_ver2.sql)
- [Sale_analyzer_1.sql](./Week_3_Code/Sale_analyzer_1.sql)
- [Sale_analyzer_2.sql](./Week_3_Code/Sale_analyzer_2.sql)

### Tulemused

- [Tulemuste kaust](./Week_3_Results/)
- [Week3_results.xlsx](./Week_3_Results/Week3_results.xlsx)
- [Analyze for Anna](./Week_3_Results/Analyze%20for%20Anna)

### Meeskonnatöö

- [Nädal 3 grupitöö README ja esitlus](https://github.com/Kolju3/DACA-group/tree/main/week-3/group)

---

## Kokkuvõte

Nädal 3 analüüs näitas, kuidas SQL JOINide abil ühendada müügi-, kliendi- ja tooteandmed terviklikuks ärivaateks. Tallinn ja online-kanal annavad suurema osa müügist, kuid kliendi linn ei määra üheselt ostukohta. Ligikaudu kümnendik müügist ei ole kliendiga seostatav, mis vähendab piirkondliku ja kliendipõhise analüüsi usaldusväärsust.

Kõige olulisem järgmine samm on parandada kliendi tuvastamist ning valideerida ristostmise muster enne asukohapõhiste kampaaniate laiendamist.

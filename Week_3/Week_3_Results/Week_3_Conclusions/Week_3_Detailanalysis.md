# Nädal 3 – detailne analüüs

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
- seoseid:
  - `sales.customer_id = customers.customer_id`;
  - `sales.product_id = products.product_id`;
- tabelite aliaseid päringute loetavuse parandamiseks;
- `COUNT()` ja `COUNT(DISTINCT ...)` funktsioone;
- `SUM()` funktsiooni käibe arvutamiseks;
- `GROUP BY`-d tulemuste koondamiseks;
- CTE-sid ja aknafunktsioone osakaalude ning võrdluste arvutamiseks;
- `NULLIF()`-i nulliga jagamise vältimiseks;
- `ROLLUP`-i detail- ja kogusummade esitamiseks.

JOIN oli analüüsi keskne töövõte: selle abil seostati müügitehingud kliendi linna ja toote kategooriaga.

### Valideerimine

Tulemuste kontrollimiseks võrreldi:

- müügitehingute koguarvu;
- kogukäivet;
- kliendiga seotud tehinguid;
- kliendita tehinguid;
- müügikohtade koondsumma vastavust koguandmetele.

Müügikohtade kaupa koondatud tulemused andsid kokku 10 118 tehingut ja 2 898 513,90 eurot käivet.

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
- Online-kanal moodustab ligikaudu kolmandiku kogu müügist.
- Tartu keskmine tehing on müügikohtadest suurim.
- Pärnu keskmine tehing on madalaim.
- Müügikohtade erinevused tulenevad eelkõige tehingute mahust.

### 2. Kliendiga seostamata müük

| Näitaja | Tulemus |
|---|---:|
| Kliendita tehinguid | 984 |
| Osakaal kõigist tehingutest | 9,73% |
| Kliendita tehingute käive | 286 133,99 € |
| Osakaal kogukäibest | 9,87% |

Ligikaudu kümnendikku müügist ei saa kliendi linna ega kliendiprofiiliga seostada. Kliendilinnade analüüs põhineb seetõttu 9 134 tehingul.

### 3. Suurimad kliendilinnad kliendiga seotud käibe järgi

| Kliendi linn | Käive | Osakaal kliendiga seotud käibest |
|---|---:|---:|
| Tallinn | 1 007 663,32 € | 38,57% |
| Tartu | 522 853,28 € | 20,01% |
| Pärnu | 371 467,72 € | 14,22% |
| Narva | 122 329,36 € | 4,68% |
| Viljandi | 98 270,83 € | 3,76% |

Tallinna kliendid annavad suurima osa kliendiga seotud käibest. Samas ei tähenda kliendi linn automaatselt, et ost tehakse sama linna kaupluses.

### 4. Kliendi linn ja ostukoht

Tartu klientide ostud jagunesid järgmiselt:

| Ostukoht | Tartu klientide käive |
|---|---:|
| Tallinn | 190 897,37 € |
| Online | 177 922,31 € |
| Tartu | 96 984,47 € |
| Pärnu | 57 049,13 € |

Tartu kliendid tegid rohkem oste Tallinna kauplusest ja online-kanalist kui Tartu kauplusest. Sarnane ristostmise muster ilmnes ka Pärnu klientide puhul.

Tulemus ei tõesta veel kindlat kliendikäitumise põhjust. Võimalikud selgitused on reisimine, online-ostude tugev roll, kliendilinna aegumine või andmete sidumise loogika. Muster vajab täiendavat valideerimist.

### 5. Tootekategooriad kliendiga seotud käibe järgi

| Tootekategooria | Käive | Osakaal kliendiga seotud käibest |
|---|---:|---:|
| Jalanõud | 695 584,82 € | 26,63% |
| Meesteriided | 668 761,67 € | 25,60% |
| Naisteriided | 618 344,58 € | 23,67% |
| Aksessuaarid | 353 218,51 € | 13,52% |
| Lasteriided | 276 470,33 € | 10,58% |

Kolm suurimat kategooriat annavad kokku ligikaudu 76% kliendiga seotud käibest.

---

## Suurim üllatus

Suurim üllatus oli see, et kliendi linn ei ennustanud selgelt ostukohta. Näiteks Tartu kliendid tegid rohkem oste Tallinna kauplusest kui Tartu kauplusest.

Alles müügi- ja kliendiandmete ühendamine tõi selle mustri esile.

---

## Soovitused Anna Metsale

1. **Hoida turunduse põhifookus Tallinnal ja online-kanalil.**  
   Need kaks kanalit annavad kokku üle 72% tehingutest ja käibest.

2. **Analüüsida Pärnu madalamat keskmist tehingut.**  
   Kontrollida tuleks tootevalikut, kampaaniaid, hinnataset ja ostukorvi koosseisu.

3. **Parandada kliendi tuvastamist müügiprotsessis.**  
   Ligikaudu 10% müügist ei ole kliendiga seotud.

4. **Mitte eeldada, et kliendi linn võrdub eelistatud kauplusega.**  
   Asukohapõhised kampaaniad tuleks enne rakendamist valideerida.

5. **Kohandada kampaaniaid kategooriate järgi.**  
   Jalanõud, meesteriided ja naisteriided moodustavad suurema osa käibest.

6. **Lisada järgmises analüüsis ajamõõde.**  
   Kontrollida, kas erinevused on ajas püsivad.

---

## Analüüsi piirangud

- 984 tehingut ei ole kliendiga seotud.
- Kliendi linn võib olla aegunud või kirjeldada elukohta, mitte ostukohta.
- Koondandmed näitavad seoseid, kuid ei tõesta nende põhjuseid.
- Müügikoha käive ei näita kampaania tasuvust, sest kampaaniakulud puuduvad.
- Tulemused põhinevad puhastatud testtabelitel.

---

## Mida õppisin

Nädala jooksul õppisin:

- ühendama mitu tabelit õigete võtmete kaudu;
- kasutama `INNER JOIN`-i ja tabelite aliaseid;
- kontrollima JOIN-i mõju tulemuse ridade arvule;
- koondama ühendatud andmeid;
- valideerima detailtulemusi kogusummade vastu;
- tõlgendama SQL-i tulemusi ärivajaduse vaates.

---

## AI kasutamine

AI-d kasutati:

- SQL-päringute loogika ja loetavuse kontrollimiseks;
- JOIN-seoste ja valideerimise läbimõtlemiseks;
- dokumentatsiooni ja ärilise tõlgenduse korrastamiseks.

Kõik päringud käivitati Supabase'is ning tulemused kontrolliti algsete väljundfailide ja koondsummade vastu.

---

## Seotud failid

- [Tagasi README-sse](./README.md)
- [SQL-koodi kaust](./Week_3_Code/)
- [Tulemuste kaust](./Week_3_Results/)
- [Week3_results.xlsx](./Week_3_Results/Week3_results.xlsx)
- [Analyze for Anna](./Week_3_Results/Analyze%20for%20Anna)
- [Nädal 3 grupitöö README ja esitlus](https://github.com/Kolju3/DACA-group/tree/main/week-3/group)

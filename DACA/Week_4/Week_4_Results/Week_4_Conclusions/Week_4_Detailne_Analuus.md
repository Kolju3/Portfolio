# Nädal 4 — Detailne analüüs: UrbanStyle müügiagregatsioon

**Autor:** Kalju | **Meeskond:** Operations Intelligence | **Allikas:** GitHub `week-4/individual/kalju`

---

## 1. Eesmärk ja kontekst

DACA Nädal 4 eesmärk on muuta toorandmed (üksikud müügiread) äriliselt loetavateks
koondnumbriteks, kasutades `GROUP BY`, `HAVING`, CTE-sid ja aknafunktsioone
(vt `4_0_1_P_IT_SQL_agregatsioon` töövihik). Anna Mets vajas Kristi Tamme jaoks
juhatuse koosolekuks müügitrende perioodide, asukohtade ja kategooriate kaupa.

Kalju lähenemine: ehitada **üks parametriseeritud päringustruktuur** (CTE-de ahel), kus
perioodi, asukoha ja kategooria valik toimub ühe `params` CTE muutmisega — mitte iga
küsimuse jaoks eraldi päringut kirjutades.

---

## 2. Andmete puhastamine (eeltöö enne agregatsiooni)

Enne müügianalüüsi puhastati mitu tuge tabelit — see on kooskõlas Nädal 2 põhimõttega
"puhasta enne, kui analüüsid":

| Tabel | Puhastusloogika | Duplikaadi definitsioon |
|---|---|---|
| `Inventory` | `INITCAP(TRIM(location))` | — (duplikaate ei eemaldatud) |
| `Inventory_Movements` | `INITCAP(TRIM(location))` + `ROW_NUMBER` dedup | (product_id, location, movement_type, quantity, timestamp) |
| `Promotions` | `INITCAP(TRIM(...))` kõigile tekstiväljadele | (promo_name, start_date, end_date, category, discount_percent) |
| `Suppliers` | `INITCAP(TRIM(...))`, email ainult `TRIM` | supplier_name (standardiseeritud) |

Kõik neli kasutavad sama mustrit:
```sql
ROW_NUMBER() OVER (PARTITION BY <duplikaadi_võti> ORDER BY <id> ASC) AS rn
...
WHERE rn = 1
```
See on täpselt Nädal 2 materjalis õpitud "jäta alles väikseima ID-ga rida" muster,
rakendatuna aknafunktsiooniga (elegantsem versioon `NOT IN (SELECT MIN(id)...)` mustrist).

**Hea praktika, mis siin silma jääb:** eraldi `Inventory_Movment_duplicate_row_Finder.sql`
loob **audit-tabeli**, kus iga duplikaadigrupi kõik read on näha koos `KEPT`/`REMOVED`
märgistusega. See on täpselt see, mida Nädal 2 juhend nõuab (audit log, mitte lihtsalt
vaikne kustutamine) — tubli lisand, mida põhitöövihik otseselt ei nõudnud.

⚠️ **Kontrollpunkt:** `Inventory_Movments_duplicates.csv` näitab, et duplikaadid on
tuvastatud `movement_id` järgi erineva `reference` (ORD-numbri) väärtusega — st sama
liikumine on tabelis kahe erineva tellimuse viitega. Tasub Toomasele/endale küsida:
*kas need on tõesti duplikaadid, või on tegu kahe eraldi, kokkusattunud liikumisega?*
Praegune loogika eeldab, et sama (toode, asukoht, tüüp, kogus, ajahetk) kombinatsioon
ei saa juhuslikult kaks korda esineda — see on mõistlik eeldus, aga väärt ühte lauset
põhjendust raportis.

---

## 3. Müügiagregatsiooni ülesehitus

### 3.1 CTE-ahela loogika (kõigis kolmes analüüsiskriptis sarnane)

1. **`params`** — kõik muudetavad sisendid ühes kohas (periood, `interval_unit`,
   asukohad, kategooriad, minimaalsed lävendid)
2. **`sales_all`** — JOIN `Testing_Sales_Cleaned` + `Testing_Products_Cleaned`,
   filtreeritud perioodi ja asukoha järgi (kategooriata — kasutatakse baasina protsentide jaoks)
3. **`sales_filtered`** — sama, aga ka kategooria-filtriga (need read, mida kuvatakse)
4. **`interval_location_totals`** / **`grand_interval_totals`** — nimetajad protsentide arvutamiseks
5. **`aggregated_filtered`** — `GROUP BY interval, (location), category` + `HAVING` lävendi filter
6. **`category_period_totals`** — terve perioodi kategooria summa (min-väärtuse filtri jaoks)
7. **`final_data`** — kõigi eelnevate `JOIN`, protsentide arvutus `ROUND(100.0 * x / NULLIF(y,0), 2)`

**Tugevus:** `NULLIF(nimetaja, 0)` kasutamine kõigis jagamistes väldib "division by
zero" viga — hästi meelde jäetud detail, mida algajad tihti unustavad.

**Erinevus kolme skripti vahel:**
- `Periodic_sales_analyzer.sql` — kõige lihtsam, ainult periood × kokku (kasutati CSV väljundite genereerimiseks)
- `Periodic_location_sales_analyzer.sql` — lisab asukoha dimensiooni + `HAVING` lävendid
- `Periodic_category_sales_analyzer.sql` — kategooria dimensioon, kokku üle kõigi asukohtade
- `Monthly_Sales_Table_Generator.sql` — kombineerib asukoha JA kategooria, salvestab **püsiva tabelina** (`CREATE TABLE ... AS`), mitte ainult SELECT-ina

### 3.2 Miks see on hea Ha-taseme (Nädal 4-7) lahendus

Nädala eesmärk oli GROUP BY + HAVING + CTE. Kalju lahendus lisab omalt poolt:
- **parametriseerituse** (üks muudetav plokk kogu loogika jaoks) — see pole nädala
  miinimumnõue, aga näitab, et loogikat mõistetakse piisavalt, et seda üldistada
- **kahesuunalised protsendid** (osakaal asukoha sees JA osakaal grand totalist) — annab
  rikkalikuma äritõlgenduse kui lihtne "% kogust"

---

## 4. Tulemuste kontroll (CSV-põhine, andmetest arvutatud)

Kontrollisin `Week_4_Results/*_Monthly_sales_analyze.csv` faile otse, et näha, kas
README-s väidetud numbrid klapivad.

| Aasta | Kuid failis | Tehinguid kokku | Käive kokku |
|---|---|---|---|
| 2023 | 12 (täielik) | 4 271 | 1 231 783,56 € |
| 2024 | 12 (täielik) | 5 134 | 1 463 106,64 € |
| 2025 | **3** (jaan, veebr, dets) | 693 | 198 614,27 € |
| 2026 | **6**, väga hõredalt (1–6 tehingut/kuu) | 20 | 5 009,43 € |

**Arvutatud kasv 2023 → 2024:**
- Tehingute arv: (5134−4271)/4271 = **+20,2 %**
- Käive: (1 463 106,64−1 231 783,56)/1 231 783,56 = **+18,8 %**

### 4.1 ⚠️ Oluline lahknevus README väitega

Kalju README/Järeldused väidavad *"umbes 50% kasv 2023–2024"*, aga otse CSV-de
summeerimine annab **~19–20%**. See on märkimisväärne erinevus, mille põhjust tasub
enne lõpliku raporti esitamist kontrollida. Võimalikud seletused:
- 50% viitas hoopis mõne konkreetse kuu või kategooria kasvule, mitte kogu aasta kasvule
- Võrreldi valesid aluseid (nt tipp-kuu vs madalseis, mitte aasta-summa vs aasta-summa)
- Lihtsalt eksitud hinnangus

**Soovitus:** käivita üks kontrollpäring, mis annab ühemõttelise vastuse:
```sql
SELECT
    date_part('year', sale_date) AS aasta,
    COUNT(*) AS tehinguid,
    SUM(total_price) AS kaive
FROM "Testing_Sales_Cleaned"
WHERE date_part('year', sale_date) IN (2023, 2024)
GROUP BY aasta
ORDER BY aasta;
```
Kui tulemus kinnitab ~19–20%, tuleks README-s number parandada — see on täpselt see
"aus enda piiride suhtes" harjumus, mida DACA materjalid rõhutavad (vt Nädal 1 R2:
"ära lase raportisse oletusi, mida päring ei tõestanud").

### 4.2 ⚠️ 2025–2026 "kokkuvarisemine" — tõenäoliselt andmete puudulikkus, mitte äritrend

2025. aasta failis on ainult **3 kuud** (jaanuar, veebruar, detsember) ja nende
protsendid (47%, 50%, 3%) on arvutatud **nende kolme kuu, mitte 12 kuu suhtes** — see
tähendab, et päring ise ei väida "aasta langes", vaid lihtsalt ei sisalda ülejäänud
kuude andmeid. 2026. aasta failis on kokku vaid 20 tehingut kuue kuu peale (1–6
tehingut kuus) — see on selgelt katkendlik andmestik, mitte usutav igakuine müügimaht
võrreldes 2023–2024 sadade tehingutega kuus.

**Järeldus, mida raportisse **EI** tohiks praegusel kujul panna:** *"Alates 2025.
aastast on müük täielikult kokku kukkunud."* See sõnastus jätab mulje reaalsest
äriprobleemist, aga tõenäolisem seletus on:
- andmestik lihtsalt ei kata 2025–2026 perioodi täies mahus (import puudulik või
  andmed genereeritud ainult osaliselt), või
- kuupäevad on W2 puhastuses osaliselt NULL-iks muudetud/piiratud tuleviku-kuupäevade
  reegli tõttu (`sale_date > CURRENT_DATE` puhastus, vt Nädal 2 materjal)

**Enne selle väite esitamist Kristile/Toomasele, kontrolli:**
```sql
SELECT
    date_part('year', sale_date) AS aasta,
    COUNT(*) AS ridu,
    MIN(sale_date) AS varaseim,
    MAX(sale_date) AS hiliseim
FROM "Testing_Sales_Cleaned"
GROUP BY aasta
ORDER BY aasta;
```
Kui 2025–2026 kohta on tõesti vaid mõnisada rida (võrreldes 2023/2024 tuhandetega),
on õigem sõnastus: *"2025–2026 andmed on andmebaasis osalised — usaldusväärset
trendijäreldust nende perioodide kohta praegu teha ei saa. Vajame kinnitust, kas
andmeimport nende aastate kohta on lõpetatud."*

Seda tüüpi tähelepanek on täpselt see, mida DACA "Andmete usaldusväärsus ja
valideerimine" peatükk õpetab: kui koondnumber tundub ootamatu (siin: müük "kukub
kokku" 100%), on esimene samm kontrollida andmemahtu, mitte kohe äriline järeldus teha.

---

## 5. Sesoonsuse ja kategooria leiud (kinnitatud CSV-ga)

2023 ja 2024 kuupõhistest arvudest on selgelt näha:
- **Suvekuud (juuni–august)** on mõlemal aastal kõrgeima müügiga: 2023 424–425
  tehingut/kuu, 2024 509–511 tehingut/kuu — märgatavalt üle aasta keskmise
  (~356 tehingut/kuu 2023, ~428 tehingut/kuu 2024)
- **Detsember** on mõlemal aastal aasta suurima käibega kuu (2023: 129 187,75 €;
  2024: 170 537,76 €) — toetab järeldust aastalõpu kampaania mõjust
- Kategooria-tasandi väited (meeste/naiste rõivad + jalanõud domineerivad, aksessuaarid
  ja lasterõivad väiksemad) põhinevad graafikutel — need CSV-na eraldi väljas ei ole,
  seega soovitan need ka arvudena (mitte ainult graafikuna) portfooliosse lisada, et
  väidet oleks lihtne kontrollida.

---

## 6. Kokkuvõte ja soovitused järgmiseks

| Prioriteet | Tegevus |
|---|---|
| 🔴 Kõrge | Kontrolli 2023→2024 kasvuprotsent otse (praegu README ütleb 50%, andmed näitavad ~19–20%) |
| 🔴 Kõrge | Kontrolli 2025–2026 andmete täielikkust enne "kokkuvarisemise" väite esitamist |
| 🟡 Keskmine | Lisa kategooria- ja asukohapõhised koondnumbrid ka CSV/tabelina (praegu ainult graafikuna) |
| 🟢 Madal | Nimeta HAVING-lävendite valik (miks just 100€/5 tehingut) — lisa üks lause põhjendust |

Tehniline tase (CTE struktuur, parametriseeritus, dedup-loogika, audit-tabel) on
tugev ja ületab nädala baasnõude. Peamine arengukoht on **järelduste kontrollimine
enne raportisse kirjutamist** — täpselt see samm, mida Ha-tasemel (Nädal 4-7)
oodatakse: mitte ainult õige SQL, vaid ka õige äriline tõlgendus.

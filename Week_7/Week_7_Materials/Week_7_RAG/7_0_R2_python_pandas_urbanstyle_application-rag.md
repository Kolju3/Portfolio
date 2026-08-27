# UrbanStyle-i RFM Kliendisegmenteerimine: Marko Saare Väljakutse

## Sissejuhatus

Marko Saar kõnnib sisse meeskonna koosolekule, sülearvuti käes, ja vaatab dashboard-i ekraanil. "See on COOL! Aga ma vajan DEEPER insights-e." Marko on tootehaldur ja tema küsimused on teistsugused kui Kristi või Anna omad. Ta ei taha lihtsalt näha, kui palju müüdi. Ta tahab teada: KES on meie parimad kliendid? Kes on ohus kaduda? Ja kuidas me saame neile personaliseeritud pakkumisi saata?

See on RFM analüüsi väljakutse. RFM tähendab Recency (hiljutisus), Frequency (sagedus) ja Monetary (rahaline väärtus). See on klassikaline kliendisegmenteerimise meetod, mida kasutatakse e-kaubanduses üle maailma. Ja Python koos pandas-ega on ideaalne tööriist selle teostamiseks.

Selles dokumendis vaatame läbi, kuidas laadida UrbanStyle-i kliendiandmeid, arvutada RFM skoorid, luua segmendid ja anda Markole konkreetsed soovitused.

## Marko Äriprobleem

Marko on UrbanStyle-is see inimene, kes otsustab, milliseid tooteid juurde tellida ja kuidas neid turundada. Siiani on ta teinud seda "kõhutunde" järgi. Aga nüüd, pärast kuute nädalat andmetega töötamist, tahab ta olla andmepõhine.

Tema konkreetsed küsimused:

**"Kes on meie VIP kliendid?"** Marko tahab teada, kes on need inimesed, kes ostavad tihti, kulutavad palju ja on hiljuti ostnud. Need on UrbanStyle-i kõige väärtuslikumad kliendid ja neid tuleb hoida nagu kullakangid.

**"Kes on churn risk?"** Churn tähendab kliendi kadumist. Marko tahab teada, kes ostis varem palju, aga pole enam kuude kaupa ostnud. Need kliendid on ohus ja neid saab veel tagasi võita, kui kiiresti tegutseda.

**"Kuidas ma saadan erinevaid e-maile eri gruppidele?"** Anna Mets (turundus) on juba elevil: "Oota, ma saan saata ERINEVAID e-maile VIP-dele vs casuals-ile? GENIAALNE!" Segmenteeritud turunduskampaaniad on 3x efektiivsemad kui üks-kõigile lähenemine.

## Andmete Laadimine Supabase-ist

Esimene samm on andmete laadimine. Sa kasutad Supabase Python SDK-d, et tõmmata müügiandmed ja kliendiandmed:

```python
from supabase import create_client
import pandas as pd
import os

supabase = create_client(os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY"))

# Laadi müügiandmed
response = supabase.table('sales').select('*').execute()
df_sales = pd.DataFrame(response.data)

# Laadi kliendiandmed
response_customers = supabase.table('customers').select('*').execute()
df_customers = pd.DataFrame(response_customers.data)
```

Pärast laadimist kontrolli alati, mida sa said:

```python
print("Müügiandmete kuju:", df_sales.shape)
print("Kliendiandmete kuju:", df_customers.shape)
print("\nMüügi veerud:", df_sales.columns.tolist())
print("\nEsimesed 5 rida:")
print(df_sales.head())
```

See on nagu SQL-i SELECT * FROM sales LIMIT 5, aga Python-is. Sama loogika: vaata andmeid enne, kui hakkad nendega töötama.

Seejärel liida tabelid kokku, et saada klienditeave müügiandmete juurde:

```python
df = pd.merge(
    df_sales,
    df_customers[['customer_id', 'email', 'first_name', 'last_name', 'city']],
    on='customer_id',
    how='left'
)
```

See on nagu SQL LEFT JOIN customers c ON sales.customer_id = c.customer_id. Sama kontseptsioon, erinev süntaks.

## Andmete Puhastamine

Enne analüüsi tuleb andmed puhastada. UrbanStyle-i andmebaas sisaldab tahtlikult vigu, sest see simuleerib reaalseid olukordi.

```python
# 1. Kontrolli duplikaate
print("Duplikaadid:", df.duplicated().sum())
df = df.drop_duplicates()

# 2. Kontrolli NULL-e
print("\nNULL-id:\n", df.isnull().sum())
df = df.dropna(subset=['customer_id', 'sale_date', 'total_price'])

# 3. Teisenda kuupäevad
df['sale_date'] = pd.to_datetime(df['sale_date'])

# 4. Eemalda ebarealistlikud väärtused
print("\nNegatiivsed summad:", (df['total_price'] < 0).sum())
df = df[df['total_price'] > 0]

# Puhastusraport
print(f"\nPuhastatud: {df.shape[0]} rida, {df.shape[1]} veergu")
print(f"Unikaalseid kliente: {df['customer_id'].nunique()}")
print(f"Kuupäevavahemik: {df['sale_date'].min()} kuni {df['sale_date'].max()}")
```

See puhastusraport on oluline. Sa pead teadma, kui palju andmeid sa eemaldasid ja miks. Markole ei ole vaja näidata iga tehnilist detaili, aga ta peab saama usaldada, et analüüs ei põhine katkisel andmel. Hea sõnastus on: "Analüüsisime ostnud kliente, eemaldasime kriitiliste väljade puuduvad väärtused ja kontrollisime, et igal RFM real oleks üks klient."

## RFM Arvutamine Samm-Sammult

### Recency: Päevi Viimasest Ostust

Recency mõõdab, kui hiljuti klient ostis. Mida väiksem number, seda parem.

```python
today = pd.to_datetime('2025-03-05')  # Viitekuupäev

# Iga kliendi viimane ostu kuupäev
recency = df.groupby('customer_id')['sale_date'].max().reset_index()
recency.columns = ['customer_id', 'last_purchase_date']

# Arvuta päevade arv
recency['recency_days'] = (today - recency['last_purchase_date']).dt.days
```

Tulemus: iga klient saab ühe numbri. Klient, kes ostis eile, saab recency_days = 1. Klient, kes ostis 6 kuud tagasi, saab recency_days = 180. Madalam on parem.

### Frequency: Ostude Arv

Frequency mõõdab, kui tihti klient ostab. Mida rohkem, seda parem.

```python
frequency = df.groupby('customer_id')['sale_id'].nunique().reset_index()
frequency.columns = ['customer_id', 'frequency']
```

Siin kasutame `nunique()` (unikaalsete väärtuste arv), mitte `count()`. See tagab, et iga tellimus loetakse ainult ühe korra, isegi kui samal tellimusel on mitu tooterida.

### Monetary: Kogukulutus

Monetary mõõdab, kui palju klient kokku kulutas. Mida rohkem, seda väärtuslikum.

```python
monetary = df.groupby('customer_id')['total_price'].sum().reset_index()
monetary.columns = ['customer_id', 'monetary_value']
```

### RFM Tabeli Kokkupanek

Nüüd liidetakse kolm tabelit kokku:

```python
rfm = recency[['customer_id', 'recency_days']].merge(
    frequency, on='customer_id'
).merge(
    monetary, on='customer_id'
)
```

Tulemus on DataFrame, kus iga rida on üks klient ja veerud on: customer_id, recency_days, frequency, monetary_value.

### Skooride Määramine

Skoorid 1-5 määratakse kvintiilide alusel. Pandas-e `pd.qcut()` jagab andmed viieks võrdseks grupiks:

```python
# Recency: madalam = parem, seega vastupidised sildid
rfm['R_score'] = pd.qcut(rfm['recency_days'], 5, labels=[5, 4, 3, 2, 1])

# Frequency: kõrgem = parem
rfm['F_score'] = pd.qcut(
    rfm['frequency'].rank(method='first'), 5, labels=[1, 2, 3, 4, 5]
)

# Monetary: kõrgem = parem
rfm['M_score'] = pd.qcut(rfm['monetary_value'], 5, labels=[1, 2, 3, 4, 5])

# Teisenda integeriks
rfm['R_score'] = rfm['R_score'].astype(int)
rfm['F_score'] = rfm['F_score'].astype(int)
rfm['M_score'] = rfm['M_score'].astype(int)

# Koguskoor
rfm['RFM_Score'] = rfm['R_score'] + rfm['F_score'] + rfm['M_score']
```

Oluline nüanss: Recency puhul on sildid vastupidised, sest madalam recency_days on parem (hiljutisem). Frequency ja Monetary puhul on kõrgem parem, seega sildid on loogilises järjekorras.

`pd.qcut()` võib anda vea, kui andmetes on palju kordusväärtuseid (näiteks paljud kliendid on ostnud täpselt 1 kord). Sel juhul lisa `duplicates='drop'` parameeter.

### Segmentide Loomine

Nüüd luuakse kliendisegmendid RFM skoori põhjal:

```python
def segment_customer(row):
    if row['RFM_Score'] >= 13:
        return 'VIP Champions'
    elif row['RFM_Score'] >= 10:
        return 'Loyal Customers'
    elif row['RFM_Score'] >= 7:
        return 'Potential Loyalists'
    elif row['RFM_Score'] >= 4:
        return 'At Risk'
    else:
        return 'Lost'

rfm['Segment'] = rfm.apply(segment_customer, axis=1)
```

Kokkuvõte:
```python
print("Segmendid:")
print(rfm['Segment'].value_counts())
print(f"\nVIP Champions: {(rfm['Segment'] == 'VIP Champions').sum()} klienti")
print(f"VIP-de tulu: EUR {rfm[rfm['Segment'] == 'VIP Champions']['monetary_value'].sum():,.2f}")
print(f"VIP-de osakaal tulust: {rfm[rfm['Segment'] == 'VIP Champions']['monetary_value'].sum() / rfm['monetary_value'].sum() * 100:.1f}%")
```

## Tulemuste Tõlgendamine Markole

Numbrid on olemas, aga Marko tahab ärilisi vastuseid. Siin on see, mida sa talle ütled:

**"Väike VIP Champions grupp genereerib ebaproportsionaalselt suure osa kogukäibest."** See on klassikaline Pareto printsiip tegevuses: väike osa kliente annab suurima osa tulust. Marko mõistab kohe: need kliendid vajavad erilist kohtlemist.

**"At-Risk kliendid on kõrge väärtusega, aga pole mitu kuud ostnud."** Need on endised head kliendid, kes on vaikselt kadumas. Marko reageerib: "Ma pean neile KOHE pakkumise saatma! Win-back kampaania!"

**"Potential Loyalists on ühe sammu kaugusel VIP-ist."** Need kliendid on aktiivsed, aga ei ole veel tipptasemel. Lojaalsusprogramm võiks neid tõugata VIP staatusse.

## Markole Konkreetsed Soovitused

Soovitused peavad olema tegutsemiskõlbulikud. Mitte "me peaksime mõtlema klientidele", vaid konkreetsed sammud:

**VIP Program (launch kohe):**
- Varajane ligipääs uutele Denim Jacket värvidele
- Personaalsed 20% sooduskoodid
- Alati tasuta tarne

**Win-Back Campaign (At-Risk kliendid):**
- "Me igatseme teid!" e-mail personaliseeritud tootesoovitustega
- 15% "tagasituleku" allahindlus
- Aja piirang (7 päeva), et luua kiireloomulisust

**Nurture Program (Potential Loyalists):**
- Lojaalsuspunktide süsteem
- "Veel üks ost ja sa oled VIP!" sõnumid
- Soovitusprogramm (soovita sõbrale, saa boonust)

Anna Mets kinnitab: "Kui segmenteeritud kampaaniad toovad parema konversiooni kui üks-kõigile lähenemine, on meil lõpuks nimekiri, mille põhjal seda katsetada. ÜHEST RFM analüüsist saab praktiline kampaaniaplaan."

## CSV Eksport Turundusmeeskonnale

Lõpptulemus peab olema kasutatavas formaadis. Anna vajab CSV-d, mida ta saab oma e-maili tööriista importida:

```python
# Ekspordi kogu RFM tabel
rfm.to_csv('output/urbanstyle_rfm_segments.csv', index=False)

# Ekspordi ainult VIP-d (spetsiaalne nimekiri)
vip = rfm[rfm['Segment'] == 'VIP Champions']
vip.to_csv('output/vip_customers.csv', index=False)

# Ekspordi At-Risk (win-back nimekiri)
at_risk = rfm[rfm['Segment'] == 'At Risk']
at_risk.to_csv('output/at_risk_customers.csv', index=False)
```

CSV sisaldab: customer_id, email, first_name, recency_days, frequency, monetary_value, R_score, F_score, M_score, RFM_Score, Segment. Anna saab selle otse e-maili tööriista importida ja alustada segmenteeritud kampaaniatega.

## Visualiseerimine Plotly-ga

Markole meeldivad visuaalid. Kolm diagrammi, mis räägivad loo:

**Segmentide jaotus (tulpdiagramm):** Näitab, kui palju kliente on igas segmendis. Marko näeb kohe, milline grupp on suur, milline väike ja millise segmendiga peaks Anna esimesena tegelema. See on dashboard-i "ühe pilguga" element.

**RFM hajuvusdiagramm (scatter plot):** X-teljel recency, y-teljel monetary, värvid segmendid, punkti suurus frequency. See on kõige informatiivsem diagramm: VIP-d on vasakul üleval (hiljutine, kõrge kulutus), Lost on paremal all (vana, madal kulutus). Marko näeb klastrite mustrit ja saab aru kliendidünaamikast.

**TOP 10 VIP klienti (tulpdiagramm):** Marko tahab teada, kes täpselt on tema parimad kliendid. TOP 10 VIP-i kogukulutuse järgi annab konkreetsed nimed, kellele helistada.

## Portfoolio Väärtus

See RFM projekt läheb GitHub portfooliosse ja see on üks tugevamaid esitlusi, mida sa saad tööandjale näidata. Miks?

**See on reaalne äriline väärtus.** RFM analüüsi kasutatakse päris ettevõtetes iga päev. Tööandja näeb, et sa oskad mitte ainult koodi kirjutada, vaid ka äriprobleemi lahendada.

**See on reprodutseeritav.** Su RFM skripti saab kasutada ÜKSKÕIK MILLISE e-kaubanduse ettevõtte jaoks. Muuda andmebaasi ühendust ja kood töötab.

**See näitab mõtteprotsessi.** Jupyter Notebook koos Markdown selgitustega näitab, et sa mõtled struktureeritult: probleem, andmed, analüüs, tulemused, soovitused.

GitHub repositooriumi struktuur peaks olema puhas: README ekraanipiltide ja peamiste leidudega, scripts kaust RFM skriptiga, notebooks kaust Jupyter Notebook-iga, output kaust CSV failidega ja images kaust diagrammidega.

## Marko Tagasiside

Nädala lõpus Marko vaatab tulemusi ja reageerib: "See on TÄPSELT see, mida ma vajasin! Ma ei näe enam ainult kogumüüki, vaid kliendirühmi, kellele saab teha erineva pakkumise."

Aga Marko küsib ka: "Kas see RFM script saab automaatselt käivituda iga nädal? Ma ei taha seda manually käivitada." See on eelvaade Nädal 8-le: Python automatiseerimine ja Supabase API.

Kristi lisab: "Te muutsite Marko product strategy. Ta oli gut feeling product manager. Nüüd ta on data-driven product manager. See on transformatiivne."

## Kuidas RFM Tulemusi Markole Selgitada

Marko ei vaja esimesena koodi. Ta vajab otsust. Seetõttu tuleb RFM tulemus tõlkida neljaks kihiks.

**1. Mis juhtus?** Näita segmentide jaotust. Näiteks: kui suur osa ostnud klientidest on aktiivsed, kui suur osa on kadumisohus ja kui palju on madala väärtusega juhuostjaid. See annab Markole pildi kliendibaasi tervisest.

**2. Miks see oluline on?** Selgita, et kõik kliendid ei vaja sama kampaaniat. VIP klient vajab tunnustust ja eksklusiivsust. At-Risk klient vajab tagasituleku põhjust. Potential Loyalist vajab väikest tõuget, et muuta juhuost harjumuseks.

**3. Mida teha järgmisena?** Iga segment vajab ühte konkreetset tegevust. Kui soovitus ei muutu tegevuseks, jääb analüüs riiulile. Hea soovitus on näiteks: "Saada At-Risk klientidele 7-päevane win-back pakkumine, kus sõnum viitab nende varasemale ostukategooriale."

**4. Kuidas mõõta?** Marko peab teadma, kas tegevus töötas. Mõõdikud võivad olla avamismäär, klikkimise määr, ostu sooritamise määr, keskmine ostukorv ja kampaania lisatulu. RFM analüüs ei lõppe segmendi loomisega. See loob hüpoteesi, mida saab testida.

## UrbanStyle Segmentide Äriline Loogika

**VIP Champions** on grupp, keda UrbanStyle ei taha kaotada. Nende puhul ei ole kõige targem pakkuda lihtsalt suurimat allahindlust. Kui inimene juba ostab tihti ja kulutab palju, võib tugev allahindlus vähendada marginaali ilma lojaalsust suurendamata. Parem on pakkuda varajast ligipääsu uutele toodetele, tasuta tarne piiri alandamist või personaalset tänusõnumit.

**Loyal Customers** on stabiilne tuluallikas. Nad ostavad piisavalt tihti, aga ei pruugi olla kõige kõrgema kogukulutusega. Nende puhul töötab lojaalsusprogramm, kus iga ost kasvatab järgmise ostu tõenäosust. Marko jaoks on oluline küsida: milline tootekategooria võiks neid järgmisele tasemele viia?

**Potential Loyalists** on kõige huvitavam kasvugrupp. Nad on hiljuti ostnud ja neil on positiivne signaal, aga ostude arv või kogukulu pole veel kõrge. Anna saab siin kasutada pehmeid kampaaniaid: "Sulle võib meeldida", "täienda komplekti", "teine ost tasuta tarnega". Eesmärk ei ole kohe maksimaalne tulu, vaid harjumuse loomine.

**At Risk** on kiiruse küsimus. Need kliendid olid kunagi väärtuslikud, aga nende hiljutisus on halb. Kui nendega liiga kaua oodata, muutuvad nad Lost segmendiks. Siin peab kampaania olema konkreetne ja ajaliselt piiratud. Samas tuleb olla ettevaatlik: kui At-Risk klient ei reageeri, ei tähenda see automaatselt, et ta on "halb klient". Võib-olla on tema vajadus hooajaline või ta ostis toote, mida ei ostetagi sageli.

**Lost** ei ole esimene prioriteet, kui ressursse on vähe. Lost segment võib sisaldada kliente, kes tegid ühe juhuostu ja ei plaaninudki tagasi tulla. Mõnikord on mõistlik neid hoida madala kuluga uudiskirjas, mitte kulutada kallist kampaaniaraha.

## Andmete Piirangud ja Aus Tõlgendus

RFM on lihtne ja kasulik, aga ta ei tea kõike. Ta ei tea, miks klient ei ostnud. Ta ei tea, kas klient kolis, kas toode läks moest välja või kas konkurendil oli parem pakkumine. Ta mõõdab ostukäitumist, mitte motivatsiooni.

Seetõttu peab Week 7 portfoolio README sisaldama ka piiranguid. Hea piirangute lõik võib öelda:

"RFM analüüs põhineb ajaloolistel müügiandmetel ja ei sisalda kliendi tagasisidet, kampaaniate avamismäärasid ega konkurendi infot. Segmendid on seega käitumuslikud hüpoteesid, mida tuleks testida kampaaniatega."

See lause teeb portfoolio küpsemaks. Tööandja näeb, et sa ei müü analüüsi üle. Sa oskad eristada andmetest nähtavat ja sellest tehtavat oletust.

## Kuidas Meeskond Tööd Jagab

Nädal 7 grupitöö sobib hästi rollideks, sest RFM analüüsil on loomulik etappide jada.

**Extract roll** kontrollib, et `sales` ja `customers` andmed on olemas ning õigete veergudega. Ta teeb `df.head()`, `df.info()` ja kontrollib ridade arvu. Kui Supabase ei tööta, kasutab ta CSV fallback'i.

**Clean roll** teisendab kuupäevad, eemaldab puuduvad kriitilised väärtused ja kontrollib duplikaate. Tema ülesanne on vältida olukorda, kus ilus graafik põhineb katkisel andmel.

**Analyze roll** arvutab RFM tabeli. Ta kasutab `groupby`, `agg`, `qcut` ja segmentide loogikat. Tema töö peab olema kõige paremini kommenteeritud, sest siin tekivad kõige sagedamini vead.

**Visualize roll** loob Markole ja Annale sobivad vaated: segmentide jaotus, RFM scatter plot ja TOP kliendid. Ta kontrollib, et pealkirjad ja teljesildid räägiksid ärikeeles, mitte ainult tehnilises keeles.

**Story roll** kirjutab README kokkuvõtte: probleem, meetod, kolm leidu, soovitused, piirangud ja järgmine samm. See roll hoiab fookuse outcome'il, mitte output'il.

## Näidisküsimused, Mida Marko Võib Küsida

Marko võib küsida: "Miks just need segmendipiirid?" Hea vastus: "Kasutasime kvintiile, sest see jagab kliendid andmestiku enda jaotuse põhjal viieks rühmaks. See on alganalüüsiks neutraalne valik, aga järgmises iteratsioonis võiks piire kohandada äriliste eesmärkide järgi."

Ta võib küsida: "Kas ma saan seda kasutada iga kuu?" Hea vastus: "Jah, kui paneme analüüsi skripti ja uuendame referentskuupäeva. Nädal 8 teema ongi automatiseerimine, kus sama loogika saab muutuda korduvaks pipeline'iks."

Ta võib küsida: "Kas At-Risk tähendab, et klient on kindlasti lahkunud?" Hea vastus: "Ei. See tähendab, et ostukäitumise järgi on risk tõusnud. Segment on signaal, mitte lõplik tõde."

Ta võib küsida: "Mis on esimene kampaania, mille te käivitaksite?" Hea vastus seob segmendi ja tegevuse: "Alustaksime At-Risk kõrge monetary väärtusega klientidest, sest neil on olnud väärtuslik ostuajalugu ja kiire sekkumine võib tuua nad tagasi."

## AI Kasutamine Week 7 Portfoolios

Alates programmi keskosast peab AI kasutamine muutuma nähtavaks osaks tööprotsessist. Week 7 README-s piisab 1-2 ausast lausest. Näiteks:

"Kasutasime AI-d pandas groupby ja qcut süntaksi kontrollimiseks ning veateadete tõlgendamiseks. Kõik AI pakutud koodijupid käivitasime ise läbi ja võrdlesime tulemusi DataFrame'i kontrollvaadetega."

See on parem kui üldine "kasutasime ChatGPT-d". See näitab, milles AI aitas ja kuidas meeskond vastutuse enda kätte jättis.

## Seos Nädal 8-ga

Nädal 7 lõpus tekib loomulik küsimus: kas RFM analüüsi peab iga kord käsitsi jooksutama? Vastus on ei. Nädal 8 viib sama loogika edasi automatiseerimise ja API töövoo suunas. Kui Week 7 annab Markole analüüsi, siis Week 8 annab Markole korduva süsteemi.

See üleminek on oluline. Week 7 portfoolio artefakt võib olla notebook või skript, mis arvutab segmendid. Week 8 artefakt võib sama mõtte muuta automatiseeritud andmetoruks: lae andmed, arvuta segmendid, salvesta tulemus ja valmista ette raport. Nii näeb osaleja, kuidas üks analüüs kasvab tööprotsessiks.

## Mida Teha, Kui Supabase Ei Tööta

Week 7 õppimise keskmes ei ole Supabase ühenduse silumine. Kui ühendus töötab, on see hea, sest osaleja näeb päris API töövoogu. Kui ühendus ei tööta, peab meeskond kasutama CSV fallback'i ja jätkama RFM analüüsiga. See on teadlik pedagoogiline otsus: Python ja pandas on selle nädala põhiteema.

Praktiline sõnum osalejale on lihtne: "Kui API ühendus peatab töö rohkem kui 10-15 minutiks, võta `sales.csv` ja `customers.csv`, lae need `pd.read_csv` abil ning jätka analüüsiga." Sama RFM loogika töötab mõlemal juhul. Hiljem saab ühenduse korda teha ja allika välja vahetada.

CSV fallback ei ole läbikukkumine. Päris analüütikutöös kasutatakse sageli mitut andmeallikat: andmebaas, CSV eksport, API, Exceli fail. Oluline on hoida analüüsi loogika puhas. Kui kood on kirjutatud nii, et alguses tekib `df_sales` ja `df_customers`, siis pole ülejäänud analüüsi jaoks väga oluline, kas need tulid Supabase'ist või CSV-st.

Näiteks:

```python
# Variant A: Supabase
df_sales = pd.DataFrame(supabase.table('sales').select('*').execute().data)
df_customers = pd.DataFrame(supabase.table('customers').select('*').execute().data)

# Variant B: CSV fallback
df_sales = pd.read_csv('sales.csv')
df_customers = pd.read_csv('customers.csv')
```

Pärast seda on järgmised sammud samad: kontrolli veerge, teisenda kuupäevad, arvuta RFM ja loo segmendid. Selline mõtlemine valmistab ette Week 8 automatiseerimist, kus andmeallika vahetamine peab olema teadlik ja kontrollitud.

## Portfoolio README Miinimumstruktuur

Week 7 tulemus peab olema arusaadav inimesele, kes ei näinud sessiooni. README võiks olla lühike, aga täielik.

Kirjuta pealkiri: "UrbanStyle RFM kliendisegmenteerimine Pythoniga". Seejärel lisa äriprobleem: Marko vajab kliendisegmente, et teha personaliseeritud kampaaniaid. Lisa andmed: kasutatud tabelid on `sales` ja `customers`; kui kasutasid CSV fallback'i, ütle seda ausalt.

Meetodi osas selgita RFM-i ühe lõiguga. Ära pane ainult koodi. Ütle, et Recency mõõdab viimase ostu värskust, Frequency ostude arvu ja Monetary kogukulutust. Lisa kolm peamist leidu, aga kirjuta need oma tegelike tulemuste järgi.

Soovituste osas pane iga segmendi taha tegevus. Näiteks VIP Champions: eksklusiivne pakkumine; At Risk: win-back kampaania; Potential Loyalists: lojaalsusprogrammi tõuge. Lõpeta piirangutega ja järgmise sammuga: automaatne uuendamine Week 8 töövoos.

Selline README näitab, et osaleja ei teinud ainult notebook'i, vaid ehitas portfoolio artefakti, mida saab töövestlusel selgitada.

## Üks Hea Demo Lause

Kui meeskond peab nädalalõpu demos oma töö ühe lausega kokku võtma, võiks see kõlada nii: "Me muutsime UrbanStyle'i üldise müügivaate kliendisegmentideks, mille põhjal Marko ja Anna saavad teha erinevaid kampaaniaotsuseid."

See lause on tugev, sest see ei kirjelda ainult output'i. Output on notebook, CSV ja graafik. Outcome on otsus: VIP kliente hoitakse, At-Risk kliente püütakse tagasi võita ja Potential Loyalists saavad lojaalsust kasvatava sõnumi. Nädal 7 demos peaks meeskond alati jõudma selleni, milline äriline tegevus muutub.

Kui esitlus läheb liiga tehniliseks, too fookus tagasi küsimusele: "Mida Marko homme teisiti teeb?" See on lihtne filter, mis aitab otsustada, millised graafikud ja numbrid on väärt näitamist.

Demo lõpus võiks meeskond öelda ka ühe piirangu: "See segmentatsioon põhineb ostukäitumisel, mitte kliendi küsitlusel ega kampaaniareaktsioonidel." See ei nõrgesta tööd. Vastupidi, see näitab analüütilist küpsust ja loob silla järgmisteks mõõdetavateks ärilisteks katseteks ja korduvateks kampaaniateks.

## Kokkuvõte

Sel nädalal sa lahendasid Marko äriprobleemi Python-i ja pandas-ega. Sa laadisid andmed Supabase-ist, puhastasid need, arvutasid RFM skoorid, lõid kliendisegmendid ja andsid konkreetsed soovitused.

Tulemus: ostnud kliendid on segmenteeritud viide gruppi: VIP Champions, Loyal Customers, Potential Loyalists, At Risk ja Lost. Igal grupil on konkreetne turundusplaan. Äriline mõju ei tule ilusast tabelist, vaid sellest, et Marko ja Anna saavad teha erinevatele klientidele erinevaid otsuseid.

See on andmeanalüütiku tegelik väärtus. Mitte ainult kood, vaid otsused. Mitte ainult numbrid, vaid soovitused. Mitte ainult analüüs, vaid ärimõju.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist. Optimeeritud NotebookLM audio genereerimiseks.*

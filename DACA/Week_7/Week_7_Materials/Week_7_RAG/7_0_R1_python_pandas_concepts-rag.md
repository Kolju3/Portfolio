# Python ja Pandas: Andmeanalüüs Koodiga

## Sissejuhatus

Sa oled neli nädalat SQL-iga andmeid pärinud ja kaks nädalat neid visualiseerinud. SQL on tugev tööriist andmete küsimiseks ja koondamiseks. Dashboard näitab tulemusi visuaalselt. Aga nüüd on käes hetk, kus SQL-i jõud lõppeb. Mitte sellepärast, et SQL oleks halb, vaid sellepärast, et mõned analüüsid nõuavad loogikat, mida SQL-is on keeruline või võimatu kirjutada.

Marko Saar, UrbanStyle.ltd tootehaldur, tahab teada: kes on meie VIP kliendid? Kes on ohus kaduda? Kuidas me grupeerime kliente, et saata neile personaliseeritud pakkumisi? See on RFM (Recency, Frequency, Monetary) analüüs ja kuigi sa saaksid seda osaliselt SQL-iga teha, on Python palju loomulikum valik. Python võimaldab keerulisi arvutusi, kohandatud loogikat, automatiseerimist ja visualiseerimist ühes kohas.

Selles dokumendis vaatame läbi Python-i põhitõed, pandas teegi alused, andmete manipuleerimise ja RFM analüüsi aluspõhimõtted. Iga kontseptsioon on seotud UrbanStyle-i andmetega, sest su eesmärk on praktiline: anda Markole vastused.

## Miks Python? Miks Nüüd?

Python on maailma kõige populaarsem andmeanalüüsi keel. LinkedIn-i andmetel mainib 5,2 miljonit tööpakkumist Python-i oskust. Andmeanalüütiku palgauuringud näitavad, et Python-i oskus lisab mediaanpalgale umbes 25% võrreldes ainult SQL-i oskusega. See on konkreetne number, mis räägib iseenda eest.

Aga karjääriperspektiiv on ainult üks põhjus. UrbanStyle-i perspektiivist on Python vajalik, sest:

**Keerulised arvutused.** RFM skoorid, kaalutud keskmised, kvintiilipõhine hindamine: need on arvutused, mis SQL-is nõuavad pikki ja raskesti loetavaid päringuid, aga Python-is on need mõni rida koodi.

**Kohandatud loogika.** "Kui klient on ostnud 5+ korda JA viimane ost oli alla 30 päeva JA kogukulutus on üle 500 EUR, siis ta on VIP." See on lihtne Python-is (if/elif/else), aga SQL-is on see pikk CASE WHEN ahel.

**Automatiseerimine.** Nädal 8 teema. Python-i skripti saab ajastada käivituma iga nädal: laadi uued andmed, arvuta RFM, ekspordi CSV, saada e-mail Markole. SQL seda ei tee.

**Visualiseerimine.** Plotly on Python-i teek, mida sa oled juba Nädal 5-6 kasutanud (Track B). Python-is saad sa ühes skriptis teha kõike: laadida andmeid, töödelda, analüüsida ja visualiseerida.

## Python vs SQL: Millal Kumba?

See on oluline mõista, sest Python ei asenda SQL-i. Nad täiendavad teineteist.

**SQL tugevused:** Andmete pärimine andmebaasist (SELECT), tabelite ühendamine (JOIN), agregatsioon (GROUP BY), andmete filtreerimine (WHERE). SQL töötab otse andmebaasis ja on optimeeritud suurte andmemahtude jaoks.

**Python tugevused:** Keerulised arvutused ja kohandatud loogika, andmete teisendamine ja ümberstruktureerimine, masinõppe mudelid, automatiseerimine ja skriptimine, visualiseerimine ja aruandlus.

**Tüüpiline töövoog:** SQL laadib andmed andmebaasist. Python töötleb, analüüsib ja visualiseerib. See on kõige levinum muster: SQL on andmete "tõmbaja", Python on andmete "töötleja".

UrbanStyle-i RFM analüüsi puhul: SQL pärib müügiandmed Supabase-ist. Python arvutab RFM skoorid, loob segmendid, genereerib visualisatsioonid ja ekspordib tulemused CSV-sse.

## Python-i Põhitõed

Kui sa oled Python-iga kokku puutunud, siis see osa on kiire kordamine. Kui sa oled täielik algaja, siis ära muretse: Python on üks lihtsamaid keeli alustamiseks.

### Muutujad ja Andmetüübid

Python-is ei pea sa tüüpi deklareerima. Sa lihtsalt omistad väärtuse:

```python
kliendi_nimi = "Jüri Tamm"          # string (tekst)
tellimuse_summa = 89.99              # float (komaarv)
tellimuste_arv = 5                    # integer (täisarv)
on_vip = True                         # boolean (tõeväärtus)
```

Need on samad andmetüübid, mida sa tunned SQL-ist: VARCHAR on string, NUMERIC on float, INTEGER on integer, BOOLEAN on boolean. Kontseptsioonid on samad, süntaks on erinev.

**Listid** on järjestatud kogumikud:
```python
linnad = ["Tallinn", "Tartu", "Pärnu"]
hinnad = [89.99, 45.50, 120.00, 67.30]
```

**Sõnastikud (Dictionaries)** on võti-väärtuse paarid:
```python
klient = {
    "id": 1001,
    "nimi": "Jüri Tamm",
    "linn": "Tallinn",
    "segment": "VIP"
}
```

### Juhtimisstruktuurid

**If/else** on tingimuslause, mida sa kasutad pidevalt RFM segmenteerimises:
```python
if kogukulutus > 500 and ostude_arv > 5:
    segment = "VIP Champions"
elif kogukulutus > 200:
    segment = "Loyal Customers"
else:
    segment = "Regular"
```

**For-tsükkel** käib läbi kõik elemendid:
```python
for linn in linnad:
    print(f"Analüüsin linna: {linn}")
```

### Funktsioonid

Funktsioonid on korduvkasutatavad koodiplokid. Sa kirjutad loogika ühe korra ja kasutad seda mitu korda:
```python
def arvuta_allahindlus(summa):
    if summa > 100:
        return summa * 0.10
    return 0

allahindlus = arvuta_allahindlus(150)  # Tagastab 15.0
```

RFM analüüsis kasutad funktsioone palju: arvuta_recency(), arvuta_frequency(), loo_segmendid() ja nii edasi. See muudab koodi loetavaks ja taaskasutatavaks.

### Import-laused

Python-i võimsus tuleb teekidest. Teegid on koodipakid, mille keegi on juba kirjutanud. Sa ei pea jalgratast leiutama:
```python
import pandas as pd        # Andmetöötlus
import plotly.express as px # Visualiseerimine
from datetime import datetime  # Kuupäevad
```

`as pd` on lühend. Sa saad kirjutada `pd.DataFrame()` selle asemel, et kirjutada `pandas.DataFrame()` iga kord. See on Python-i konventsioon ja sa näed seda igas õpetus materjalis.

## Pandas: DataFrame-i Põhitõed

Pandas on Python-i andmetöötluse teek. Wes McKinney, "Python for Data Analysis" autor, on pandas-e looja. See on andmeanalüütiku igapäevane tööriist.

### DataFrame: Mis See On?

DataFrame on sisuliselt tabel: read ja veerud, täpselt nagu SQL-i tabel. Iga rida on üks andmepunkt (üks müügitehing, üks klient) ja iga veerg on üks atribuut (kuupäev, summa, linn).

```
     customer_id  sale_date  total_price  city
0    1001         2025-01-15  89.99         Tallinn
1    1002         2025-01-16  45.50         Tartu
2    1001         2025-01-20  120.00        Tallinn
```

Series on üks veerg DataFrame-ist. Näiteks `df['total_price']` annab kõik summad Series-ina. See on nagu SQL-i ühe veeru tulemus.

### Andmete Laadimine

Sa saad andmeid laadida mitmest allikast:

**CSV failist:** `df = pd.read_csv('urbanstyle_sales.csv')`

**Supabase-ist:**
```python
from supabase import create_client
import os

supabase = create_client(os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_KEY"))
response = supabase.table('sales').select('*').execute()
df = pd.DataFrame(response.data)
```

Mõlemal juhul saad sa DataFrame-i, millega edasi töötada. Supabase-ist laadimine on nagu SQL SELECT * FROM sales, aga Python-i kaudu.

### Andmete Uurimine

Pärast andmete laadimist on esimene samm alati uurimine: mis andmed mul on?

```python
df.head()           # Esimesed 5 rida (kiire pilguheit)
df.tail()           # Viimased 5 rida
df.info()           # Veerutüübid, NULL-ide arv
df.describe()       # Statistika: keskmine, min, max, standardhälve
df.shape            # Ridade ja veergude arv (tuple: (1000, 8))
df.columns          # Veergude nimed
```

`df.info()` on eriti oluline, sest see näitab, kas veerutüübid on õiged. Kui sale_date on "object" (string) mitte "datetime64", siis pead sa selle teisendama: `df['sale_date'] = pd.to_datetime(df['sale_date'])`.

### Andmete Filtreerimine

Filtreerimine on nagu SQL WHERE:

```python
# SQL: WHERE city = 'Tallinn'
tallinn_df = df[df['city'] == 'Tallinn']

# SQL: WHERE total_price > 100
suured_tellimused = df[df['total_price'] > 100]

# SQL: WHERE city = 'Tallinn' AND total_price > 100
tallinn_suured = df[(df['city'] == 'Tallinn') & (df['total_price'] > 100)]
```

Märka, et Python kasutab `&` (ja) ja `|` (või), mitte `AND` ja `OR` nagu SQL. Ja iga tingimus peab olema sulgudes.

### Agregatsioon: GroupBy

GroupBy on nagu SQL GROUP BY:

```python
# SQL: SELECT store_location, SUM(total_price) FROM sales GROUP BY store_location
asukoha_käive = df.groupby('store_location')['total_price'].sum()

# SQL: SELECT store_location, COUNT(*), AVG(total_price) FROM sales GROUP BY store_location
asukoha_stats = df.groupby('store_location')['total_price'].agg(['count', 'sum', 'mean'])
```

See on täpselt sama kontseptsioon, mida sa SQL-iga juba oskad. Grupeeri andmed kategooria järgi ja arvuta koondväärtuseid. Süntaks on erinev, aga loogika on sama.

### Andmete Liitmine: Merge

Merge on nagu SQL JOIN:

```python
# SQL: SELECT * FROM sales s JOIN customers c ON s.customer_id = c.customer_id
merged = pd.merge(df_sales, df_customers, on='customer_id', how='left')
```

`how='left'` on LEFT JOIN, `how='inner'` on INNER JOIN, `how='right'` on RIGHT JOIN. Jällegi: samad kontseptsioonid, erinev süntaks.

### Veergude Loomine

Uue veeru loomine on lihtne:

```python
# Uus veerg: allahindluse summa
df['allahindlus'] = df['total_price'] * 0.10

# Tingimuslik veerg (nagu SQL CASE WHEN)
df['kliendi_tüüp'] = df['total_price'].apply(
    lambda x: 'VIP' if x > 100 else 'Tavaline'
)
```

### Sorteerimine

```python
# SQL: ORDER BY total_price DESC
df.sort_values('total_price', ascending=False)

# Mitu veergu
df.sort_values(['city', 'total_price'], ascending=[True, False])
```

### Puuduvate Andmete Käsitlemine

NULL-id on Python-is NaN (Not a Number). Pandas annab sulle tööriistad nendega toimetamiseks:

```python
# Mitu NULL-i igas veerus?
df.isnull().sum()

# Eemalda read, kus customer_id on NULL
df = df.dropna(subset=['customer_id'])

# Asenda NULL väärtused
df['city'].fillna('Teadmata', inplace=True)
```

## RFM Analüüsi Alused

RFM on kliendisegmenteerimise klassikaline meetod. See on lihtne, aga väga võimas. Kolm mõõdikut:

**Recency (R):** Kui hiljuti klient ostis? Mida hiljutisem, seda parem. Klient, kes ostis eile, on tõenäolisemalt aktiivne kui klient, kes ostis 6 kuud tagasi.

**Frequency (F):** Kui tihti klient ostab? Klient, kes on teinud 10 ostu, on lojaalsem kui klient, kes on teinud 1 ostu. Sagedased ostjad on väärtuslikumad.

**Monetary (M):** Kui palju klient kulutab? Klient, kes on kulutanud 500 eurot, on väärtuslikum kui klient, kes on kulutanud 20 eurot. See on lihtne, aga oluline.

Iga mõõdiku jaoks arvutatakse skoor 1-5, kus 5 on parim. Skooride arvutamiseks kasutatakse kvintiile: andmed jagatakse viieks võrdseks grupiks. Kõrgeim Recency skoor (5) saab klient, kes ostis kõige hiljutisemalt. Kõrgeim Frequency skoor (5) saab klient, kes ostis kõige sagedamini. Kõrgeim Monetary skoor (5) saab klient, kes kulutas kõige rohkem.

RFM_Score on kolme skoori summa: vahemik 3-15. Kõrgeim skoor (13-15) on VIP Champion. Madalaim (3-5) on Lost ehk kaotatud klient.

**Segmendid:**
- 13-15: VIP Champions (su parimad kliendid)
- 10-12: Loyal Customers (lojaalsed, aga mitte tipud)
- 7-9: Potential Loyalists (ühe sammu kaugusel VIP-ist)
- 4-6: At Risk (olid head, aga kaovad)
- 3: Lost (kadunud kliendid)

Marko kasutab neid segmente turunduskampaaniate jaoks: VIP-dele eksklusiivne varajane ligipääs, At-Risk klientidele "me igatseme teid" kampaania, Potential Loyalists klientidele lojaalsuspunktide programm.

## Plotly Visualiseerimine Python-is

Plotly Express on kiire viis interaktiivsete diagrammide loomiseks. Sa oled seda juba Nädal 5-6 kasutanud (Track B), aga nüüd kasutad sa seda RFM tulemuste visualiseerimiseks.

```python
import plotly.express as px

# Segmentide jaotus (tulpdiagramm)
fig = px.bar(
    rfm['Segment'].value_counts().reset_index(),
    x='Segment', y='count',
    title='UrbanStyle Kliendisegmendid (RFM)',
    color='Segment'
)
fig.show()

# RFM hajuvusdiagramm
fig = px.scatter(
    rfm,
    x='recency_days', y='monetary_value',
    color='Segment', size='frequency',
    title='Recency vs Monetary (RFM)',
    labels={'recency_days': 'Päevi viimasest ostust',
            'monetary_value': 'Kogukulutus (EUR)'}
)
fig.show()
```

Hajuvusdiagramm on RFM analüüsis eriti kasulik. X-teljel recency (päevi viimasest ostust), y-teljel monetary (kogukulutus). Punkti suurus on frequency (ostude arv). Värvid on segmendid. Ühe pilguga näed: VIP-d on vasakul üleval (hiljutine ost, kõrge kulutus), Lost on paremal all (vana ost, madal kulutus).

## McKinney ja Andmete Puhastamine

"Python for Data Analysis" 7. peatükk käsitleb andmete puhastamist ja ettevalmistamist. See on Python-i tugevus: enne analüüsi tuleb andmed korrastada.

Peatükk 7 katab: puuduvate andmete käsitlemine (fillna, dropna), andmete teisendamine (apply, map), liitmine ja ühendamine (merge, concat) ning kujundamine ja pivot-tabelid.

Need on samad teemad, mida sa SQL-is Nädal 2 õppisid: andmete puhastamine. Python annab sulle rohkem paindlikkust: sa saad kirjutada kohandatud funktsioone, mis puhastamiseks vajalikke reegleid rakendavad.

## Jupyter Notebook

Jupyter Notebook on interaktiivne keskkond, kus sa saad koodi kirjutada, käivitada ja tulemusi näha samas dokumendis. See on nagu interaktiivne aruanne: kood, väljund ja selgitused ühes kohas.

Notebook koosneb lahtritest. Koodilahtrid sisaldavad Python-i koodi. Markdown lahtrid sisaldavad teksti ja selgitusi. Väljundlahtrid näitavad koodi tulemusi: tabeleid, graafikuid, numbreid.

RFM analüüsi jaoks on Jupyter ideaalne: iga samm on eraldi lahter, mida sa saad iseseisvalt käivitada ja kontrollida. Kui midagi läheb valesti, ei pea sa kogu skripti uuesti käivitama, ainult probleemne lahter.

Portfoolio jaoks on Jupyter Notebook väga väärtuslik: tööandja näeb mitte ainult koodi, vaid ka su mõtteprotsessi. Markdown lahtrid selgitavad, MIKS sa midagi teed, mitte ainult MIDA.

## Tüüpiline pandas Töövoog UrbanStyle Analüüsis

Kui sa õpid pandas't esimest korda, on kõige tähtsam mitte pähe õppida kõiki funktsioone, vaid ära tunda korduv töövoog. Peaaegu iga analüüs läbib viis sammu.

**1. Laadi andmed.** Andmed võivad tulla CSV failist, Supabase API-st või andmebaasi päringust. Nädal 7 kontekstis on lubatud mõlemad variandid: kui Supabase ühendus töötab, loe tabelid API kaudu; kui ühendus tekitab tõrke, kasuta osalejate CSV faile. Õpieesmärk ei ole ühenduse peal kinni jääda, vaid aru saada DataFrame'i loogikast.

**2. Vaata andmeid.** Enne igat analüüsi küsi kolm küsimust: mitu rida ja veergu mul on, mis on veergude nimed, kas andmetüübid on mõistlikud. Selleks kasuta `shape`, `columns`, `head`, `info` ja `describe`. See on sama mõtteviis nagu SQL-is `LIMIT`, `COUNT(*)` ja veergude kontroll.

**3. Puhasta andmed.** Kontrolli duplikaate, puuduvaid väärtuseid ja kuupäeva vormingut. RFM analüüsis on eriti oluline, et `sale_date` oleks kuupäev, mitte tekst. Kui kuupäev jääb tekstiks, ei saa Python õigesti arvutada, mitu päeva on viimasest ostust möödunud.

**4. Arvuta mõõdikud.** Siin kasutad `groupby`, `agg`, `max`, `count`, `sum`, `mean`, `qcut` ja vajadusel `apply`. Need ei ole lihtsalt funktsioonid, vaid analüüsi ehitusplokid. RFM puhul arvutad kliendi kohta viimase ostu kuupäeva, ostude arvu ja kogukulutuse.

**5. Tõlgenda ja väljasta.** Viimane samm on äriline tõlge. DataFrame'is olev segment peab muutuma soovituseks: mida Marko või Anna selle infoga teeb? CSV eksport, Plotly graafik ja README kokkuvõte on osa analüüsist, mitte lisakaunistus.

## SQL-ist pandas'esse Mõtlemine

SQL ja pandas lahendavad sageli sama probleemi eri kohas. SQL töötab andmebaasis. pandas töötab sinu Python keskkonnas. Selle vahe mõistmine aitab otsustada, kumba kasutada.

Kui sul on vaja andmebaasist kiiresti välja võtta kindlad read ja veerud, on SQL tavaliselt parim algus. Näiteks "anna mulle kõik 2024. aasta müügid" või "liida sales ja customers customer_id järgi" on loomulik SQL ülesanne. Kui sul on vaja teha järjest mitu arvutusetappi, katsetada segmendireegleid, luua mitu vaheveergu ja eksportida tulemused failidesse, muutub pandas mugavamaks.

Pandas'is mõtle DataFrame'ist nagu tabelist, kuid sellisest tabelist, millele saad lisada vaheveerge ja mille iga sammu saad kohe kontrollida. SQL-is kirjutad sageli ühe suure päringu. pandas'is ehitad analüüsi väikestest sammudest:

```python
df_sales['sale_date'] = pd.to_datetime(df_sales['sale_date'])

rfm = df_sales.groupby('customer_id').agg(
    last_purchase=('sale_date', 'max'),
    frequency=('sale_id', 'count'),
    monetary_value=('total_price', 'sum')
).reset_index()

rfm['recency_days'] = (reference_date - rfm['last_purchase']).dt.days
```

Selles näites on iga rida kontrollitav. Kui tulemus tundub vale, saad printida `df_sales.head()`, `rfm.head()` või `rfm.describe()` ja näha, kus loogika nihkus. See on algajale eriti kasulik, sest viga ei jää suure päringu sisse peitu.

## DataFrame Indeks ja Veerud

pandas DataFrame'il on kaks olulist osa: veerud ja indeks. Veerud on nimedega andmeväljad, näiteks `customer_id`, `sale_date`, `total_price` ja `store_location`. Indeks on ridade aadress. Alguses on indeks lihtsalt 0, 1, 2, 3 ja nii edasi.

Enamasti ei pea sa indeksit käsitsi muutma. Kuid sa pead teadma, et mõned operatsioonid, eriti `groupby`, võivad teha grupeeritavast veerust indeksi. Sellepärast kasutatakse tihti lõpus `.reset_index()`. See muudab grupi nime jälle tavaliseks veeruks.

```python
käive_asukoha_järgi = (
    df_sales
    .groupby('store_location')['total_price']
    .sum()
    .reset_index()
)
```

Ilma `reset_index()`-ita on `store_location` indeks. Plotly või CSV ekspordi jaoks on sageli mugavam, kui see on tavaline veerg.

## Andmetüüpide Kontroll

Üks levinumaid pandas vigu on see, et arv või kuupäev on tegelikult tekst. See võib juhtuda CSV importimisel või API vastuse töötlemisel. Kui `total_price` on tekst, võib summa arvutamine anda vale tulemuse või vea. Kui `sale_date` on tekst, ei saa arvutada recency't.

Kontrolli alati:

```python
print(df_sales.dtypes)
```

Kui vaja, teisenda:

```python
df_sales['sale_date'] = pd.to_datetime(df_sales['sale_date'])
df_sales['total_price'] = pd.to_numeric(df_sales['total_price'], errors='coerce')
```

`errors='coerce'` tähendab, et vigased väärtused muudetakse `NaN`-iks. See on parem kui vaikne vale arvutus. Pärast seda kontrolli, mitu puuduvat väärtust tekkis:

```python
df_sales[['sale_date', 'total_price']].isna().sum()
```

See on osa professionaalsest andmeanalüütiku tööstiilist: ära eelda, et andmed on korras, vaid kontrolli.

## RFM Skooride Tõlgendamine

RFM ei ole ainult tehniline skoor. See on äriline keel. Recency vastab küsimusele "kas klient on veel meiega?". Frequency vastab küsimusele "kas klient on harjunud meilt ostma?". Monetary vastab küsimusele "kui suur on kliendi äriline väärtus?".

Oluline erisus: Recency puhul väiksem päevade arv on parem. Kui klient ostis 5 päeva tagasi, on see parem kui 180 päeva tagasi. Seetõttu tuleb Recency skoori arvutamisel suund ümber pöörata: kõige väiksemad `recency_days` väärtused saavad kõrgeima skoori.

Frequency ja Monetary puhul on suund tavapärane: suurem ostude arv ja suurem kogukulutus on parem. See teeb RFM-ist hea algaja analüüsi, sest kontseptsioon on arusaadav, aga tehniline teostus õpetab korraga kuupäevi, gruppeerimist, agregatsiooni, skoorimist ja segmenteerimist.

## AI Tugi pandas Õppimisel

AI võib olla väga kasulik pandas süntaksi õppimisel, aga ainult siis, kui annad talle piisavalt konteksti. Halb küsimus on: "Miks mu pandas ei tööta?" Hea küsimus on:

"Mul on DataFrame `df_sales` veergudega `customer_id`, `sale_date`, `total_price`, `store_location`. Tahan arvutada iga kliendi ostude arvu ja kogukulu. Kirjuta pandas kood ning selgita iga rida. Ära kasuta veerge, mida ma ei nimetanud."

Veel parem on lisada veateade. Kui näed `KeyError: 'city'`, tähendab see tavaliselt, et DataFrame'is ei ole sellise nimega veergu. Siis küsi AI-lt:

"Sain vea `KeyError: 'city'`. Minu veerud on `df.columns.tolist()` järgi sellised: [...]. Kuidas parandada koodi, et kasutada õiget veergu?"

AI vastus ei ole tõde. Käivita kood, kontrolli ridade arvu, kontrolli veergude nimesid ja vaata esimesi ridu. Nädal 7 eesmärk on õppida AI-ga koostööd nii, et sina juhid analüüsi ja AI aitab süntaksiga.

## Levinud Vead ja Kontrollküsimused

Pandas õppimisel on mõned vead nii tavalised, et neid tasub ette teada.

**KeyError tähendab enamasti valet veerunime.** Kui kood ütleb `KeyError: 'city'`, siis DataFrame'is ei ole `city` veergu. UrbanStyle `sales` tabelis on poe või ostukoha jaoks `store_location`; kliendi linn asub `customers.city` veerus ja jõuab müügiandmetesse alles pärast `merge` sammu. Seetõttu küsi endalt alati: kas ma töötan `sales` tabeliga, `customers` tabeliga või juba ühendatud DataFrame'iga?

**Kuupäevatekst ei ole veel kuupäev.** Kui `sale_date` näeb välja nagu kuupäev, ei tähenda see, et pandas seda kuupäevana käsitleb. Kontrolli `df.dtypes`. Kui näed `object`, teisenda `pd.to_datetime` abil. RFM recency arvutus peab põhinema kuupäeva tüübil.

**qcut võib ebaõnnestuda, kui väärtused korduvad.** Kui paljud kliendid on teinud sama arvu oste, võivad kvintiilide piirid kattuda. Siis aitab `rank(method='first')`, sest see annab igale reale järjestuse ja lubab jaotuse teha stabiilsemalt.

**Boolean indexing vajab sulge.** pandas ei luba kirjutada `df['city'] == 'Tallinn' and df['total_price'] > 100`. Kasuta `&` ja pane iga tingimus sulgudesse: `df[(tingimus1) & (tingimus2)]`.

**reset_index ei ole kosmeetika.** Kui tahad tulemust hiljem Plotly graafikus või CSV ekspordis kasutada, tee pärast `groupby` sageli `.reset_index()`. See muudab grupeeritud väärtuse jälle tavaliseks veeruks.

Enne kui ütled, et analüüs on valmis, tee kiire kontroll:
- Kas ridade arv on pärast puhastust loogiline?
- Kas kliendi kohta on üks RFM rida?
- Kas `recency_days` ei ole negatiivne?
- Kas kõige hiljutisemad kliendid saavad kõrgema R skoori?
- Kas segmentide jaotus on usutav, mitte kõik kliendid ühes segmendis?
- Kas lõplik CSV sisaldab ainult vajalikke veerge ja ei avalda üleliigseid isikuandmeid?

Need kontrollid on väikesed, aga nad muudavad algaja koodi analüütiku tööks.

## Mida Hoida Mälus Enne Sessiooni

Kui kuulad seda RAG-i NotebookLM audio formaadis, jäta meelde neli lauset. Esiteks: DataFrame on tabel Pythoni mälus. Teiseks: `groupby` on pandas'e vaste SQL `GROUP BY` mõtteviisile. Kolmandaks: RFM-i puhul on Recency suund tagurpidi, sest väiksem päevade arv on parem. Neljandaks: iga koodijupp peab lõppema kontrolliga, sest ilma kontrollita ei tea sa, kas tulemus on usutav.

Need neli lauset aitavad sessioonis orienteeruda ka siis, kui süntaks tundub uus. Sa ei pea kõike peast teadma. Sa pead suutma küsida õige kontrollküsimuse: millised veerud mul on, milline on andmetüüp, mitu rida jäi alles, kas tulemus vastab äriloogikale?

## Kokkuvõte

Python ja pandas on andmeanalüütiku supervõime. SQL pärib andmeid. Dashboard näitab andmeid. Python manipuleerib, analüüsib ja automatiseerib andmeid. Kolm tööriista koos moodustavad võimsa toolchain-i.

Sel nädalal õpid sa pandas-e põhitõed ja rakendad need RFM analüüsis. Tulemus on konkreetne: Marko Saar saab CSV faili ostnud klientide segmentidega ja soovitused, mida nende segmentidega teha. See ei ole harjutus, see on äriline väärtus.

Python vs SQL: mitte üks VÕI teine, vaid mõlemad KOOS. SQL toob andmed. Python muudab need otsusteks.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist. Optimeeritud NotebookLM audio genereerimiseks.*

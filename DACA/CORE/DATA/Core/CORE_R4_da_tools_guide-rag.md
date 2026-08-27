# Andmeanalüütiku Tööriistad: Täielik Juhend

## Sissejuhatus

DACA programmis õpid kasutama professionaalseid andmeanalüütiku tööriistu, mis on **100% tasuta** ja laialt kasutatud tööstuses. See dokument kirjeldab iga tööriista, miks me seda kasutame, kuidas see töötab ja kuidas sa saad seda õppida.

Hea uudis: **Kõik need tööriistad on algajasõbralikud.** Sa ei pea olema programmeerija ega IT-ekspert. Me alustame nullist ja liigume järk-järgult edasi.

---

## 1. PostgreSQL ja Supabase: Andmebaas

### Mis on PostgreSQL?

**PostgreSQL** (või lihtsalt "Postgres") on **relatsiooniline andmebaas** - süsteem, mis salvestab andmeid struktureeritud tabelitena. Mõtle sellele kui Excel'i tabelid, aga palju võimsamad ja optimeeritud suurte andmete koguste jaoks.

**Miks me kasutame PostgreSQL?**
- **Tööstuse standard:** Suurem osa ettevõtteid kasutab relatsioonilist andmebaasi (PostgreSQL, MySQL, SQL Server)
- **SQL keel:** Õpid SQL-i, mis on ülekantav teistele andmebaasidele
- **Võimas:** Toetab keerukaid päringuid, suuri andmemahte
- **Avatud lähtekoodiga:** Tasuta ja kogukonnapoolne tugi

### Mis on Supabase?

**Supabase** on **pilv-põhine PostgreSQL hosting** - see tähendab, et sa ei pea ise andmebaasi installeerima ja haldama. Supabase teeb selle sinu eest.

**Supabase annab sulle:**
- **PostgreSQL andmebaasi** (cloud-hosted, alati kättesaadav)
- **SQL Editor:** Veebipõhine tööriist SQL päringute kirjutamiseks
- **Graafiline liides:** Vaata tabeleid ja andmeid
- **API:** (Kasutame hiljem, kui tahame Pythoniga ühendada)

**Kuidas sa Supabase't kasutad?**

1. **Sign up:** Mine supabase.com, loo tasuta konto
2. **Projekti loomine:** Mentor annab sulle UrbanStyle'i andmebaasi projekti linki
3. **SQL Editor:** Kirjuta SQL päringuid ja vaata tulemusi
4. **Table View:** Vaata tabeleid graafiliselt

**Näide SQL päringust Supabase SQL Editoris:**

```sql
-- Vaata esimesed 10 klienti
SELECT * FROM customers LIMIT 10;
```

Vajuta "Run" ja näed tulemusi!

### PostgreSQL Peamised Kontseptid

**Tabelid (Tables):**
- Andmed on organiseeritud tabelitesse (nagu Excel'i lehed)
- Näide: `customers` tabel sisaldab klientide andmeid

**Veerud (Columns):**
- Iga tabel on jaotatud veergudeks
- Näide: `customers` tabelis on veerud `customer_id`, `first_name`, `email`

**Read (Rows):**
- Iga rida esindab üht kirjet
- Näide: Üks rida = üks klient

**Primaarai Key:**
- Unikaalne identifikaator iga rea jaoks
- Näide: `customer_id` on `customers` tabeli primaarai key

**Välised Võtmed (Foreign Keys):**
- Viitavad teise tabeli primaarai võtmele
- Näide: `sales` tabelis on `customer_id`, mis viitab `customers.customer_id`-le

---

## 2. SQL: Andmebaasi Päringukeel

### Mis on SQL?

**SQL (Structured Query Language)** on **keel, millega sa "räägid" andmebaasiga.** See võimaldab sul:
- Küsida andmeid tabelitest
- Filtreerida, sorteerida, grupeerida
- Ühendada mitu tabelit
- Agregeerida (keskmised, summad)

**SQL on deklaratiivne keel:**
- Sa ütled **mida** sa tahad, mitte **kuidas** seda tehakse
- Näide: "Näita mulle kõiki kliente Tallinnast" (andmebaas leiab efektiivseima tee selle saavutamiseks)

### SQL Põhikomandid (Week 1-3)

#### SELECT - Vali Andmeid

**Kõige lihtsam päring:**
```sql
SELECT * FROM customers;
```
- `SELECT`: "Tahan valida andmeid"
- `*`: "Kõik veerud"
- `FROM customers`: "Tabelist customers"

**Konkreetsed veerud:**
```sql
SELECT first_name, last_name, email FROM customers;
```

**Näita ainult 10 rida:**
```sql
SELECT * FROM customers LIMIT 10;
```

#### WHERE - Filtreerimine

**Näita ainult Tallinna kliente:**
```sql
SELECT * FROM customers WHERE city = 'Tallinn';
```

**Mitu tingimust (AND, OR):**
```sql
SELECT * FROM customers
WHERE city = 'Tallinn' AND loyalty_tier = 'gold';
```

#### ORDER BY - Sorteerimine

**Sorteeri nime järgi:**
```sql
SELECT * FROM customers ORDER BY last_name ASC;
```
- `ASC`: Tõusva järjekorra (A-Z, 1-10)
- `DESC`: Laskuva järjekorra (Z-A, 10-1)

#### Agregeerimised (COUNT, SUM, AVG, MIN, MAX)

**Kui palju kliente meil on?**
```sql
SELECT COUNT(*) FROM customers;
```

**Mis on keskmine tellimuse väärtus?**
```sql
SELECT AVG(total_price) FROM sales;
```

**Mis on kõrgeim müügihind?**
```sql
SELECT MAX(total_price) FROM sales;
```

#### GROUP BY - Grupeerimine

**Müük linnade kaupa:**
```sql
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city;
```

**Müük kategooriate kaupa:**
```sql
SELECT category, SUM(total_price) AS total_revenue
FROM sales
JOIN products ON sales.product_id = products.product_id
GROUP BY category;
```

### SQL Keskataseme Kontseptid (Week 4-7)

#### JOIN - Tabelite Ühendamine

**INNER JOIN (kõige levinum):**
```sql
SELECT customers.first_name, sales.total_price
FROM customers
INNER JOIN sales ON customers.customer_id = sales.customer_id;
```
- Tagastab ainult read, kus mõlemas tabelis on vaste

**LEFT JOIN:**
```sql
SELECT customers.first_name, sales.total_price
FROM customers
LEFT JOIN sales ON customers.customer_id = sales.customer_id;
```
- Tagastab kõik kliendid, isegi kui neil ei ole müüke (müük on NULL)

**Mitu JOINi:**
```sql
SELECT
  customers.first_name,
  products.product_name,
  sales.total_price
FROM sales
INNER JOIN customers ON sales.customer_id = customers.customer_id
INNER JOIN products ON sales.product_id = products.product_id;
```

#### Subqueries - Alampäringud

**Näita kliente, kes on ostnud rohkem kui keskmine:**
```sql
SELECT * FROM customers
WHERE customer_id IN (
  SELECT customer_id FROM sales
  WHERE total_price > (SELECT AVG(total_price) FROM sales)
);
```

#### CTEs (Common Table Expressions) - Ühised Tabelite Avaldised

**Sama, aga loetavam:**
```sql
WITH avg_sales AS (
  SELECT AVG(total_price) AS avg_price FROM sales
)
SELECT * FROM sales
WHERE total_price > (SELECT avg_price FROM avg_sales);
```

**Miks CTE on parem?**
- Loetavem
- Võid kasutada mitut CTE-d järjest
- Hõlpsam debugida

### SQL Keerukamad Tehnikad (Week 8-10)

#### Window Functions - Akna Funktsioonid

**Järjesta kliendid ostu summa järgi:**
```sql
SELECT
  customer_id,
  SUM(total_price) AS total_spent,
  RANK() OVER (ORDER BY SUM(total_price) DESC) AS rank
FROM sales
GROUP BY customer_id;
```

#### Date/Time Operations

**Müük kuu kaupa:**
```sql
SELECT
  DATE_TRUNC('month', sale_date) AS month,
  SUM(total_price) AS revenue
FROM sales
GROUP BY month
ORDER BY month;
```

**Viimased 30 päeva:**
```sql
SELECT * FROM sales
WHERE sale_date >= CURRENT_DATE - INTERVAL '30 days';
```

### SQL Õppimise Nipid

1. **Alusta lihtsast:** Ära hüppa kohe JOIN-idesse - õpi SELECT, WHERE, ORDER BY
2. **Kasuta LIMIT:** Alati testi päringuid LIMIT 10-ga, et mitte kogemata alla laadida miljoneid ridu
3. **Kommenteeri:** Kasuta `--` kommentaaride jaoks
   ```sql
   -- See päring leiab kõik Tallinna kliendid
   SELECT * FROM customers WHERE city = 'Tallinn';
   ```
4. **Kontrolli tulemusi:** Enne kui teed keerukaid päringuid, vaata, kas lihtsamad päringud töötavad
5. **Kasuta SQL formaatterit:** Supabase SQL Editor automaatselt formaterib su koodi (vajuta Shift+Alt+F)

---

## 3. Python: Programmeerimise Keel

### Mis on Python?

**Python** on **üldotstarbelaine programmeerimise keel**, mis on laialt kasutatud andmeteaduses, masinõppes, veebirakenduses ja automatiseerimises.

**Miks andmeanalüütikud kasutavad Pythonit?**
- **Lugev:** Pythoni kood on ligilähedane inglise keelele
- **Võimas teegid:** pandas, numpy, plotly - need teevad andmeanalüüsi lihtsaks
- **Automatiseerimine:** Saad kirjutada skripte, mis teevad samme automaatselt
- **Paindlik:** Saad teha kõike - andmete töötlemine, visualiseerimine, masinõpe

### Python Põhitõed

#### Muutujad ja Andmetüübid

```python
# Täisarvud (integers)
age = 25

# Ujukomaarv (floats)
price = 19.99

# Stringid (text)
name = "Anna Mets"

# Booleanid (tõene/väär)
is_active = True
```

#### Listid (Lists)

```python
# List on järjestatud kogum
cities = ["Tallinn", "Tartu", "Pärnu"]

# Ligipääs elementidele (index algab 0-ga)
print(cities[0])  # "Tallinn"

# Lisa element
cities.append("Narva")
```

#### Dictionaryd (Sõnaraamatud)

```python
# Dictionary on key-value paarid
customer = {
    "name": "Kristi Tamm",
    "city": "Tallinn",
    "loyalty": "gold"
}

# Ligipääs väärtustele
print(customer["name"])  # "Kristi Tamm"
```

#### Looped (Tsüklid)

```python
# For loop
for city in cities:
    print(f"City: {city}")

# While loop
count = 0
while count < 5:
    print(count)
    count += 1
```

#### Funktsioonid

```python
# Definiiri funktsioon
def calculate_discount(price, discount_pct):
    discount = price * discount_pct
    return price - discount

# Kasuta funktsiooni
final_price = calculate_discount(100, 0.1)  # 90
```

### Python Andmeanalüüsi Teegid

#### NumPy - Numbrilised Arvutused

```python
import numpy as np

# Loo array
prices = np.array([10, 20, 30, 40, 50])

# Keskmine
mean_price = np.mean(prices)  # 30.0

# Summa
total = np.sum(prices)  # 150
```

#### Pandas - Andmete Manipuleerimine

**Pandas on andmeanalüütiku kõige tähtsam tööriist.**

**DataFrame - Põhikontseptsioon:**
```python
import pandas as pd

# Loo DataFrame (mõtle sellele kui Excel tabel)
data = {
    "name": ["Kristi", "Toomas", "Anna"],
    "age": [38, 42, 31],
    "city": ["Tallinn", "Tartu", "Tallinn"]
}
df = pd.DataFrame(data)

print(df)
#      name  age     city
# 0  Kristi   38  Tallinn
# 1  Toomas   42    Tartu
# 2    Anna   31  Tallinn
```

**Lae andmed CSV-st:**
```python
df = pd.read_csv("customers.csv")
```

**Lae andmed SQL-st (Supabase):**
```python
import pandas as pd
from sqlalchemy import create_engine

# Ühenda Supabase andmebaasiga
engine = create_engine("postgresql://user:password@host:port/database")
df = pd.read_sql("SELECT * FROM customers", engine)
```

**Põhioperatsioonid:**

```python
# Vaata esimesed 5 rida
df.head()

# Vaata tabelite infot
df.info()

# Kirjeldav statistika
df.describe()

# Filtreerimine
tallinn_customers = df[df["city"] == "Tallinn"]

# Sorteerimine
df_sorted = df.sort_values("age", ascending=False)

# Grupeerimine
df.groupby("city")["age"].mean()

# Uue veeru lisamine
df["age_in_months"] = df["age"] * 12
```

**Andmete Puhastamine:**

```python
# Eemalda NULL väärtused
df_clean = df.dropna()

# Asenda NULL väärtused
df["email"].fillna("unknown@example.com", inplace=True)

# Eemalda duplikaadid
df_unique = df.drop_duplicates()
```

---

## 4. Visualiseerimine: Power BI vs. Plotly

### Track A: Power BI Desktop

**Mis on Power BI?**

**Power BI Desktop** on Microsofti tasuta äriline andmevisualiseerimise tööriist. See on **GUI-põhine** (graphical user interface), mis tähendab, et sa ei kirjuta koodi - sa lood graafikuid visuaalselt, drag-and-drop meetodiga.

**Power BI Põhifunktsioonid:**

1. **Data Import:** Impordi andmeid CSV, Excel, SQL (ka Supabase)
2. **Data Modeling:** Loo seoseid tabelite vahel
3. **Visualizations:** 20+ graafikutüüpi (column, line, pie, map, jne)
4. **DAX (Data Analysis Expressions):** Arvutused ja meetmed (nagu Excel formulas)
5. **Dashboardid:** Interaktiivsed, filtritavad dashboardid

**Power BI Workflow:**

1. **Get Data:** Ühenda andmeallikaga (Supabase SQL, CSV)
2. **Transform Data (Power Query):** Puhasta ja transfórmi andmeid (filter, merge)
3. **Model:** Loo suhted tabelite vahel
4. **Visualize:** Drag-and-drop graafikud canvas'ile
5. **Publish:** Ekspordi PDF või publitseeri Power BI Service'sse

### Power BI + Supabase: levinud ühenduse vead

Kui osaleja ühendab Power BI Desktopi Supabase'iga, kasuta alati **Session pooler** ühendust:

- **Server:** `...pooler.supabase.com` host Supabase'i **View parameters** vaatest
- **Database:** `postgres`
- **User name:** `postgres.<projekti-id>` (mitte lihtsalt `postgres`)
- **Password:** Supabase **database password**, mitte Supabase konto parool
- **Mode:** Import

**Viga 1: "The remote certificate is invalid according to the validation procedure."**

See tähendab, et Power BI ei usalda hetkel Supabase'i SSL-sertifikaati. See ei ole tavaliselt kasutaja parooli viga.

Shu-tasemel standardvastus:

1. Sulge Power BI.
2. Käivita Windows Update ja tee restart, kui Windows seda pakub.
3. Kui viga jääb: Supabase → **Database** → **Settings** → **SSL configuration** → **Download certificate**.
4. Ava allalaaditud `.crt` fail Windowsis.
5. **Install Certificate** → **Local Machine** → **Trusted Root Certification Authorities**.
6. Sulge ja ava Power BI uuesti.
7. Loo ühendus uuesti Session pooler andmetega.

G1-s töötas see tee Sille ja Mari puhul pärast seda, kui tavaline Windows Update ei lahendanud probleemi.

**Viga 2: "SSL connection is required."**

See tähendab, et SSL/encryption on Power BI-s välja lülitatud, aga Supabase pooler nõuab SSL-i.

Standardvastus:

- ära soovita Supabase'i puhul "Encrypt connections" välja lülitada;
- kustuta Power BI vana ühenduse mälu: **File** → **Options and settings** → **Data source settings** → vali Supabase host → **Clear Permissions**;
- loo ühendus uuesti nii, et encryption jääb sisse;
- kui seejärel tuleb certificate error, kasuta ülalolevat sertifikaadi paigaldamise sammu.

**Viga 3: pärast sertifikaadi parandust "We couldn't authenticate..."**

See on eraldi autentimise viga. Sertifikaadi probleem on tõenäoliselt juba lahendatud.

Kontrolli:

- `User name` peab olema `postgres.<projekti-id>`;
- parool peab olema Supabase **database password**;
- kui parool pole kindel, lase Supabase'is database password uuesti määrata;
- Power BI-s tee uuesti **Clear Permissions**.

**Viga 4: Navigatoris `auth.*` tabelid on Error**

See on ootuspärane. `auth.*` ja `storage.*` on Supabase'i sisemised skeemid. Osaleja peab valima `public` skeemi tabelid:

- `sales`
- `customers`
- `products`
- vajadusel `inventory`, `web_logs`, `suppliers`, `promotions`

Ära lase Shu-tasemel osalejal hakata RLS-i või õiguseid ise parandama. Esmalt kontrolli, kas ta vaatab `public` skeemi.

**Mentori fallback: ODBC**

Kui sisseehitatud PostgreSQL connector jääb mõnes Windowsi keskkonnas endiselt sertifikaadi taha kinni, on mentorile olemas fallback: `psqlODBC` driver + Windows ODBC Data Source Administrator + Power BI **Get Data → ODBC**. See ei ole esimene juhis osalejale, vaid tehniline varutee mentorile.

**Näide Visualizatsioonist:**

1. Drag "category" → X-axis
2. Drag "total_price" → Y-axis
3. Vali "Column Chart"
4. Lisa filter "city = Tallinn"

**Power BI Eelised:**
- Kiire ja lihtne
- Professionaalne välimus
- Laialt kasutatud ettevõtetes (eriti finantssektoris)

**Power BI Puudused:**
- Windows-põhine (Mac'is vajad virtuaalmasinat või parallels)
- Vähem paindlik kui koodipõhine lähenemine
- Ei saa lihtsalt automatiseerida (vajab makrode või API-t)

### Track B: Python + Plotly + Streamlit

**Mis on Plotly?**

**Plotly** on **Pythoni teek interaktiivsete graafikute loomiseks.** Sa kirjutad koodi, mis genereerib HTML-based graafikuid.

**Plotly Põhinäide:**

```python
import plotly.express as px
import pandas as pd

# Lae andmed
df = pd.read_csv("sales.csv")

# Loo scatter plot
fig = px.scatter(df, x="quantity", y="total_price", color="category")
fig.show()
```

**Plotly Graafikutüübid:**
- **Scatter:** Punktdiagramm
- **Line:** Joongraafik (trendid)
- **Bar:** Tulpdiagramm
- **Pie:** Sektordiagramm
- **Histogram:** Histogramm (jaotus)
- **Box:** Kastdiagramm (kvartiilid)
- **Heatmap:** Soojuskaart

**Mis on Streamlit?**

**Streamlit** on **Pythoni teek kiireks web-app'ide loomiseks.** Sa saad luua interaktiivseid dashboards ainult Python koodiga (ei vaja HTML/CSS/JavaScript).

**Streamlit Põhinäide:**

```python
import streamlit as st
import pandas as pd
import plotly.express as px

# Pealkiri
st.title("UrbanStyle Sales Dashboard")

# Lae andmed
df = pd.read_csv("sales.csv")

# Sidebar filter
city = st.sidebar.selectbox("Select City", df["city"].unique())
df_filtered = df[df["city"] == city]

# Graafikud
st.plotly_chart(px.bar(df_filtered, x="category", y="total_price"))
```

**Streamlit Workflow:**

1. Kirjuta `app.py` fail Python koodiga
2. Käivita: `streamlit run app.py`
3. Avaneb veebibrauser dashboard'iga
4. Kui muudad koodi, dashboard auto-refreshib

**Track B Eelised:**
- Täielik kontroll
- Automatiseeritav (skriptid)
- Tasuta ja open-source
- Hea, kui tahad programmeerimise suunda

**Track B Puudused:**
- Vajab koodi kirjutamist
- Algul aeglasem kui Power BI
- Vähem professionaalne välismus (vajab CSS kohandamist)

---

## 5. GitHub: Versioonihaldus ja Portfoolio

### Mis on GitHub?

**GitHub** on **koodide hostimise platvorm**, mis kasutab **Git** versioonihaldust. See võimaldab:
- Hoida koodi turvaliselt pilves
- Jälgida kõiki muudatusi (versioonihaldus)
- Koostööd teha (meeskonnatöö)
- **Portfoolio loomine:** Avalik GitHub profile on sinu CV

### Põhikontseptidid

**Repository (Repo):**
- Projekt (nt "daca-week3-sql-project")
- Sisaldab faile, koodi, dokumentatsiooni

**Commit:**
- Snapshot su koodist
- Iga commit on kirjeldusega ("Added SQL query for customer segmentation")

**Push:**
- Saada commit pilve (GitHub serverisse)

**Pull:**
- Tõmba uusimad muudatused serverist

**Branch:**
- Paralleelne versioon projektist (nt "feature-new-analysis")

### Git Workflow (DACA Projektiga)

**1. Loo uus repo GitHubis:**
```bash
# Veebibrauser: github.com → New Repository → "daca-week3-sql"
```

**2. Klooni repo oma arvutisse:**
```bash
git clone https://github.com/sinuusername/daca-week3-sql.git
cd daca-week3-sql
```

**3. Loo failid (nt `analysis.sql`, `README.md`):**

**4. Commit muudatused:**
```bash
git add .
git commit -m "Added SQL analysis for customer segmentation"
```

**5. Push GitHubi:**
```bash
git push origin main
```

### GitHub Portfoolio DACA-ks

**Su DACA portfoolio struktuur:**

```
github.com/sinuusername/
├── daca-week1-sql-basics/
│   ├── queries.sql
│   ├── results.csv
│   └── README.md
├── daca-week3-joins/
│   ├── analysis.sql
│   ├── notebook.ipynb
│   └── README.md
├── daca-week5-pandas/
│   ├── cleaning.py
│   ├── analysis.ipynb
│   └── README.md
...
```

**Iga projekti README.md peab sisaldama:**
- **Projekti kirjeldus:** "See projekt analüüsib UrbanStyle'i klientide segmentatsiooni"
- **Kasutatud tööriistad:** SQL, Python, pandas
- **Leitud insights:** "Tallinna kliendid kulutavad 30% rohkem kui teised"
- **Kuidas koodi käivitada:** Step-by-step juhend

**Tööandjad vaatavad sinu GitHubi:**
- Nad tahavad näha **koodi kvaliteeti**
- **Dokumentatsiooni** (kas sa oskad selgitada?)
- **Projekte mitmekesisust** (SQL, Python, visualiseerimist)

---

## 6. VS Code: Arenduskeskkond

### Mis on VS Code?

**Visual Studio Code (VS Code)** on **tasuta, avatud lähtekoodiga code editor** Microsoftilt. See on **kõige populaarsem arenduskeskkond** programmeerijatel ja andmeanalüütikutel.

**Miks VS Code?**
- **Tasuta ja cross-platform** (Windows, Mac, Linux)
- **Extensionid:** Saad installida laiendusi SQL, Python, Git, jne jaoks
- **Integrated Terminal:** Käivita Bash/PowerShell otse editoris
- **IntelliSense:** Automaatne koodi lõpetamine
- **Debugger:** Leia vigu koodis

### VS Code Setup DACA-ks

**1. Installi VS Code:**
- Mine code.visualstudio.com, lae alla

**2. Installi Extensions:**
- **Python** (Microsoft)
- **Jupyter** (Microsoft)
- **PostgreSQL** (Chris Kolkman)
- **GitLens** (Eric Amodio)
- **Prettier** (Code formatter)

**3. Ühenda Git:**
```bash
# Terminallis
git config --global user.name "Sinu Nimi"
git config --global user.email "sinu@email.com"
```

### SQLTools + Supabase: Levinud Häälestuse Vead

Kui osaleja kasutab VS Code'is SQLTools laiendust Supabase PostgreSQL ühenduseks, juhenda teda väga konkreetselt. Osaleja on Shu-tasemel: ära räägi pikalt sertifikaadiahelatest, vaid anna 3-6 sammu.

**Õiged Supabase andmed SQLTools jaoks:**

- Kasuta Supabase **Session pooler** andmeid.
- Host lõpeb kujul `pooler.supabase.com`.
- Port on `5432`.
- Database on `postgres`.
- User algab kujul `postgres.` ja sisaldab projekti ID-d, näiteks `postgres.abcdefghijklmnop`.
- Password on Supabase **database password**, mitte Supabase konto parool.

**Juhtum 1: `self signed certificate in certificate chain`**

Mida see tähendab: SQLTools proovib Supabase'iga ühenduda, aga ei usalda sertifikaati. See ei tähenda automaatselt, et parool on vale.

Standardvastus osalejale:

> See viga ei tähenda, et sa kindlasti midagi valesti tegid. SQLTools ei usalda hetkel Supabase ühenduse sertifikaati. Kontrolli, et kasutad Session pooler andmeid, SSL on sees, ja kui näed valikut `Reject Unauthorized` või `Verify Certificate`, pane see välja. Kui sa seda kohta ei leia, saada palun screenshot SQLTools ühenduse seadete aknast ilma paroolita.

**Juhtum 2: `connection successful`, aga `Save Connection` annab `Unable to write into workspace settings`**

Mida see tähendab: Supabase ühendus töötab. Probleem on VS Code'i seadete salvestamises, mitte andmebaasis.

Standardvastus osalejale:

> Super, `connection successful` tähendab, et Supabase ühendus on korras. Uus viga on VS Code'i salvestamise viga. Proovi ühendust salvestades valida `User settings`, mitte `Workspace settings`. Kui seda valikut ei näe, vajuta `Ctrl + Shift + P`, kirjuta `Preferences: Open Workspace Settings (JSON)`, ava fail ja saada screenshot kohast, kus on punane viga. Parooli ära näita.

**Mentori/AI toon:** ära lase osalejal rohkem Supabase parooli või hosti korduvalt muuta, kui `connection successful` on juba olemas. Siis on ühendus tõestatud ja järgmine probleem on VS Code'i seadistusfail.

### VS Code Põhikasutus

**File Explorer (Vasak külg):**
- Vaata projekte faile

**Editor (Keskel):**
- Kirjuta koodi

**Terminal (All):**
- Käivita käsklusi (git, python, npm)

**Extensions (Vasak külg, alt):**
- Installi laiendusi

**Klaviatuuri Shortcuts (Mac):**
- `Cmd+P`: Ava fail kiiresti
- `Cmd+Shift+P`: Command Palette (kõik käsklused)
- `Cmd+/`: Kommentaar/lahti kommentaar
- `Cmd+S`: Salvesta

---

## 7. AI Tööriistad: ChatGPT ja GitHub Copilot

### Millal Kasutada AI-t?

**AI tööriistad on abistajad, mitte asendajad.** Nad aitavad:
- **Selgitada kontsepte:** "Mis on SQL JOIN?"
- **Debugida koodi:** "Miks see päring annab veateate?"
- **Genereerida koodi:** "Kirjuta SQL päring, mis leiab kõik kliendid Tallinnast"
- **Parandada koodi:** "Kuidas seda optimeerida?"

### ChatGPT

**Mis on ChatGPT?**
- OpenAI AI vestlusrobot
- Tasuta versioon (GPT-3.5) piisab DACA-ks

**Kuidas Kasutada ChatGPTd DACA-ks:**

**1. Selgitused:**
```
Prompti: "Selgita mulle SQL LEFT JOIN-i nagu ma oleksin algaja."
```

**2. Koodiabi:**
```
Prompti: "Kirjuta SQL päring, mis leiab kõik kliendid, kes on ostnud rohkem kui 100 eurot. Kasutada tabeleid customers ja sales."
```

**3. Debugida:**
```
Prompti: "Ma sain veateate 'column "city" does not exist'. Siin on mu päring: [kleepida päring]. Mis läks valesti?"
```

**KRIITILINE: Ära Usaldab AI Pimesi**

- **Valida vastust:** ChatGPT võib eksida
- **Testi koodi:** Alati testi AI genereeritud koodi
- **Mõista, mida teed:** Kui sa ei saa aru, küsi uuesti

### GitHub Copilot

**Mis on GitHub Copilot?**
- AI code assistant (töötab VS Code'is)
- Automaatselt soovitab koodi, kui sa kirjutad

**Näide:**
```python
# Kirjuta kommentaar:
# Load data from Supabase

# Copilot soovitab koodi:
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql://user:password@host:port/database")
df = pd.read_sql("SELECT * FROM customers", engine)
```

**GitHub Copilot Hind:**
- ~$10/kuu (aga **tasuta üliõpilastele**)
- Registreeru GitHub Student Developer Pack'iga

**Millal Kasutada Copilot'i:**
- Kiire prototyping
- Vältida boilerplate koodi kirjutamist
- Õppida uusi APIs

**Millal MITTE Kasutada:**
- Kriitilises koodis (testa alati!)
- Kui sa ei mõista, mida kood teeb
- Eksamitel/intervjuudel

---

## 8. Jupyter Notebooks: Interaktiivsed Analüüsid

### Mis on Jupyter Notebook?

**Jupyter Notebook** on **interaktiivne keskkond**, kus sa saad kombineerida:
- **Koodi** (Python)
- **Teksteid** (Markdown)
- **Visualiseeringud** (graafikud)

**Miks andmeanalüütikud armastavad Jupyter'it?**
- **Interaktiivne:** Käivita koodi samm-sammult
- **Dokumenteeritud:** Lisa selgitusi ja järeldusi
- **Jagamine:** Saada .ipynb fail või ekspordi HTML/PDF

### Jupyter Notebook Struktuur

**Cells (Lahtrid):**
- **Code Cell:** Pythoni kood
- **Markdown Cell:** Tekst (pealkirjad, lõigud, linkid)

**Näide:**

```markdown
# Klientide Segmenteerimine

See analüüs segmenteerib UrbanStyle'i kliente lojaalsuse ja ostukäitumise järgi.
```

```python
import pandas as pd
df = pd.read_csv("customers.csv")
df.head()
```

### Jupyter Käivitamine

**1. Installi Jupyter:**
```bash
pip install jupyter
```

**2. Käivita:**
```bash
jupyter notebook
```

**3. Avaneb veebibrauser:**
- Loo uus .ipynb fail
- Kirjuta koodi ja teksti
- Käivita cellid Shift+Enter-ga

**4. Salvesta:**
- File → Save
- File → Download as → HTML/PDF

---

## Tööriistad Kokkuvõttes

| Tööriist | Eesmärk | Oskuse Tase | Aeg Õppimiseks |
|----------|---------|-------------|----------------|
| PostgreSQL/Supabase | Andmebaas | Algaja | Week 0-1 |
| SQL | Päringukeel | Algaja → Ekspert | Week 1-10 |
| Python | Programmeerimist | Algaja | Week 2-5 |
| pandas | Andmete manipuleerimine | Algaja → Keskmine | Week 4-8 |
| Power BI (Track A) | Visualiseerimine | Algaja | Week 5-7 |
| Plotly/Streamlit (Track B) | Visualiseerimine | Keskmine | Week 5-10 |
| GitHub | Versioonihaldus | Algaja | Week 0-2 |
| VS Code | Code editor | Algaja | Week 0 |
| ChatGPT | AI abi | Algaja | Week 0 |

---

## Õppimise Strateegiad

### 1. "Learning by Doing"

- **Ära ainult loe** - kirjuta koodi, tee päringuid
- **Tee vigu** - vigadest õpid kõige rohkem
- **Eksperimenteeri** - "Mis juhtub, kui ma muudan seda?"

### 2. "Break It Down"

- **Alusta lihtsa** - õpi SELECT enne JOIN-e
- **Ehita järk-järgult** - lisa keerukust järk-järgult
- **Debugi väikeste sammu** - kui miski ei tööta, kontrolli iga rida

### 3. "Document Everything"

- **Kommenteeri koodi:**
  ```sql
  -- Leiab kõik Tallinna kliendid
  SELECT * FROM customers WHERE city = 'Tallinn';
  ```
- **Kirjuta README.md:**
  - Mis see projekt teeb?
  - Kuidas seda kasutada?
  - Mida sa õppisid?

### 4. "Ask for Help"

- **Mentor:** Kui sa ei saa aru, küsi sessioonides
- **ChatGPT:** Kiire abi väiksemates küsimustes
- **Stack Overflow:** Google'i oma veateate - keegi on juba küsinud

### 5. "Build Portfolio Consciously"

- **Iga projekt on CV-sse:** Tee seda kvaliteetselt
- **Dokumenteeri insights:** Mida sa leidsid? Miks see on oluline?
- **Näita progressiooni:** Võrdle Week 1 ja Week 10 projekte

---

## Kokkuvõte

DACA kasutab professionaalseid, tööstuses laialt kasutatud tööriistu:
- **PostgreSQL/Supabase:** Andmebaas
- **SQL:** Päringukeel
- **Python (pandas, numpy, plotly):** Analüüs ja visualiseerimine
- **Power BI või Plotly/Streamlit:** Dashboardid
- **GitHub:** Portfoolio
- **VS Code:** Arenduskeskkond
- **AI tööriistad:** Abistajad

Kõik need tööriistad on **100% tasuta** ja **algajasõbralikud.** Sa ei pea olema programmeerija - me alustame nullist.

11 nädala pärast oskad sa neid tööriistu professionaalselt kasutada ja sul on portfoolio, mis seda tõestab.

**Valmis alustama?** Let's build!

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist.*

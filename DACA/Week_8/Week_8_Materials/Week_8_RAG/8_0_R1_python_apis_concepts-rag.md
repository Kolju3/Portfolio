# Python ja API-d: Kuidas Automatiseerida Andmeanalüütikat

## Sissejuhatus

Sa oled jõudnud põnevasse murdepunkti. Eelmisel nädalal tegid sa RFM-analüüsi, segmenteerisid UrbanStyle'i kliente ja avastasid väärtuslikke mustreid. Aga mõtle nüüd sellele: homme tulevad uued tellimused. Järgmine nädal veel rohkem. Su analüüs on juba aegunud. Kas sa hakkad iga kord käsitsi sama skripti käivitama? Muidugi mitte. Siin tulebki mängu automatiseerimine ja API-d.

Nädal 8 on sild kahe maailma vahel: analüütikust, kes käivitab skripte, saab insener, kes ehitab süsteeme. See on Shu-Ha-Ri raamistikus oluline üleminek: sa liigud Ha-tasemelt (kohanda) Ri-tasemele (innoveeri). Sa ei järgi enam ainult malle, vaid hakkad looma oma lahendusi. Automatiseerimine ei ole laiskus, see on skaleeritavus. Ja API-d on tööriistad, mis selle võimalikuks teevad.

Selles dokumendis vaatame läbi kõik olulised kontseptsioonid: mis on API, kuidas REST API töötab, kuidas Supabase Python SDK-d kasutada, kuidas ehitada andmete pipeline, kuidas seda ajastada ja kuidas tagada tootmisvalmidus. Iga teema juures kasutame UrbanStyle.ltd näiteid, sest just nende probleemide lahendamiseks sa neid oskuseid vajad.

## Mis On API ja Miks See Oluline On?

API ehk Application Programming Interface on lihtne kontseptsioon, mida nimetatakse keeruliselt. Mõtle sellele kui restoranile: sa ei lähe kööki ise toitu tegema. Sa annad kelnerile tellimuse, kelner viib selle kööki, kokk valmistab toidu ja kelner toob selle sulle. API on see kelner. Sinu Pythoni skript on klient, andmebaas on köök ja API on vahendaja, kes hoolitseb selle eest, et kõik toimiks korrektselt.

Ilma API-ta peaksid sa iga kord Supabase'i sisse logima, navigeerima õige tabeli juurde, andmeid käsitsi CSV-sse eksportima, selle faili oma arvutisse laadima, avama Pythoni ja alles siis faili pandas-iga sisse lugema. See on viis manuaalset sammu, millest igaüks võib minna valesti. API-ga on see üks rida koodi: sa küsid andmeid ja saad need kohe kätte. Erinevus on tohutu, eriti kui sa tahad seda teha iga nädal automaatselt.

API-del on ka teine oluline eelis: andmed on alati värsked. Kui sa laadisid CSV-faili eile, siis tänased tehingud sinna ei jõua. Aga API annab sulle alati viimased andmed, sest see pöördub otse andmebaasi poole. See tähendab, et su analüüs on alati ajakohane. Kui Marko Saar tahab reedel teada, millised kliendid tegid oste neljapäeval, siis API annab selle info kohe. CSV-faili puhul peaks keegi esmalt uue ekspordi tegema.

Kolmas eelis on turvalisus. CSV-failid rändavad arvutite vahel, neid saadetakse e-postiga, neid kopeeritakse mälupulkadele, neid unustatakse avalikesse kaustadesse. Iga koopia on turvarisk, eriti kui failid sisaldavad kliendiandmeid nagu nimed, e-postiaadressid ja ostukäitumine. API puhul andmed jäävad andmebaasi ja su skript pöördub nende poole autenditud ühenduse kaudu. Sa ei pea kunagi tundlikke andmeid oma arvutis hoidma. See on eriti oluline GDPR-i ja andmekaitse kontekstis, mida UrbanStyle kui Euroopa ettevõte peab järgima.

Neljas eelis on mastaapsus. CSV-fail, mis sisaldab 10 000 rida, on hallitav. Aga kui UrbanStyle kasvab ja neil on 100 000 tehingut, muutub CSV-lähenemine problemaatiliseks: failid on suured, nende avamine võtab kaua ja Excel võib kokku joosta. API kasutab lehekülgedeks jagamist ehk pagination-it, mis tähendab, et sa saad andmeid osade kaupa, vastavalt vajadusele. See töötab miljonite ridadega sama sujuvalt kui tuhandete ridadega.

## REST API: Universaalne Suhtlusstandard

REST ehk Representational State Transfer on standard, mida enamik kaasaegseid API-sid kasutab. See on nagu ühine keel, mida kõik programmid räägivad. REST API kasutab HTTP-protokolli, sama protokolli, mida su brauser kasutab veebilehtede laadimiseks. See tähendab, et REST API töötab kõikjal, kus internet töötab.

REST API-l on neli peamist meetodit, mida nimetatakse CRUD operatsioonideks (Create, Read, Update, Delete):

**GET** on lugemine. Sa küsid andmeid ja saad need tagasi. See on kõige levinum meetod andmeanalüütikas. Kui sa tahad teada UrbanStyle'i müügiandmeid, teed GET-päringu. Umbes 90% su API-kasutusest on GET-päringud, sest analüütikuna loed sa andmeid palju rohkem kui muudad neid.

**POST** on loomine. Sa saadad uued andmed ja need lisatakse andmebaasi. Näiteks kui su pipeline arvutab uued RFM-skoorid ja tahab need andmebaasi salvestada uude tabelisse, kasutad POST-meetodit. See on nagu uue rea lisamine Exceli tabelisse, aga programmiliselt.

**PUT** ja **PATCH** on uuendamine. Sa muudad olemasolevaid andmeid. PUT asendab kogu kirje, PATCH muudab ainult osa. Näiteks kui sa tahad uuendada kliendi segmendi "VIP"-ist "Loyal"-iks, kasutad PATCH-meetodit: sa muudad ainult segmendi veergu, mitte kogu kliendikirjet.

**DELETE** on kustutamine. Seda kasutad andmeanalüütikas harva, aga see on olemas. Enamasti ei kustuta analüütikud andmeid, vaid märgistavad need mitteaktiivseks.

Iga API-päring läheb konkreetsele aadressile ehk endpoint-ile. See on nagu URL, aga programmide jaoks. Supabase loob automaatselt iga andmebaasi tabeli jaoks oma endpoint-i. Näiteks `https://su-projekt.supabase.co/rest/v1/sales` on endpoint, kust saad müügiandmeid. Teine näide: `https://su-projekt.supabase.co/rest/v1/customers` annab kliendiandmed. See on väga mugav, sest sa ei pea ise endpoint-e looma: Supabase teeb seda automaatselt su andmebaasi skeemi põhjal.

Vastus tuleb JSON-formaadis. JSON ehk JavaScript Object Notation on andmeformaat, mis näeb välja nagu Pythoni sõnastik: võtmed ja väärtused, loogeliste sulgudega ümbritsetud. Pythoni jaoks on JSON loomulik formaat, sest `json.loads()` teisendab selle kohe Pythoni andmestruktuuriks. Ja pandas DataFrame-i saad luua otse sõnastike loetelust, mis ongi täpselt see, mida API tagastab.

JSON-i näide ühe müügitehingu kohta:

```json
{
    "sale_id": 1234,
    "customer_id": 567,
    "sale_date": "2024-11-15",
    "total_price": 89.50,
    "channel": "online"
}
```

See on inimloetav ja masinloetav korraga. Su pandas-kood teisendab selle automaatselt DataFrame-i reaks. Sada sellist objekti massivis annab sada rida DataFrame-is. Lihtne ja loogiline.

## Autentimine: Kuidas Tõestad, Et Sul On Õigus?

API-d ei ole avatud kõigile. Sul on vaja tõestada, et sul on õigus andmetele ligi pääseda. See on nagu hoone turvakontroll: sa näitad oma kaarti ja sind lastakse sisse. Ilma kaardita jääd uksele.

Supabase kasutab API-võtmeid autentimiseks. Sul on kaks võtit, mis on erinevate juurdepääsutasemetega. Anon-võti ehk anonüümne võti on nagu külaliskart, mis annab piiratud juurdepääsu. See järgib Row Level Security (RLS) reegleid, mis tähendab, et sa saad näha ainult neid andmeid, mida RLS-poliitika lubab. Service-role-võti on nagu peamehe võti, mis avab kõik uksed ja ignoreerib RLS-reegleid. DACA programmis kasutad sa anon-võtit, sest see on turvalisem ja sobib analüütiku vajadusteks.

Aga siin on kriitiline reegel, mida sa pead meeles pidama kogu oma karjääri jooksul: **MITTE KUNAGI ära pane API-võtmeid oma koodi sisse!** See on üks suurimaid ja ohtlikumaid vigu, mida algajad teevad. Kui sa kirjutad oma skripti `key = "eyJhbGciOiJIUzI1NiIs..."` ja teed sellele commit-i GitHub-isse, siis kogu maailm näeb su võtit. Automatiseeritud robotid otsivad pidevalt GitHub-ist API-võtmeid ja kasutavad neid ära mõne minuti jooksul.

Selle asemel kasutad sa keskkonnamuutujaid ehk environment variables. Sa lood `.env`-faili, kuhu paned oma võtmed. See fail jääb ainult su arvutisse ja ei jõua kunagi GitHub-i:

```
SUPABASE_URL=https://su-projekt.supabase.co
SUPABASE_KEY=su-anon-võti-siin
```

Ja `.gitignore`-faili lisad `.env`, et Git ei jälgiks seda faili:

```
.env
*.env
```

Pythonis laed need väärtused `python-dotenv` teegi abil:

```python
from dotenv import load_dotenv
import os

load_dotenv()  # Loeb .env-faili sisse
url = os.getenv("SUPABASE_URL")  # Saab URL-i
key = os.getenv("SUPABASE_KEY")  # Saab võtme
```

Lisa ka `.env.example` fail, mis näitab teistele, millised muutujad on vajalikud, aga ei sisalda tegelikke väärtuseid:

```
SUPABASE_URL=your-project-url-here
SUPABASE_KEY=your-anon-key-here
```

See on tööstusstandard, mida kasutavad kõik professionaalsed arendajad. Kui sa õpid selle harjumuse ära nüüd, säästab see sind tulevikus paljudest probleemidest. Toomas Kask kontrollib esimese asjana, kas API-võtmed on turvaliselt hoitud. Kui ta näeb võtit koodis, on see automaatne läbikukkumine.

## Supabase Python SDK: Sinu Uus Tööriist

Supabase on ehitatud PostgreSQL-i peale, sama andmebaas, millega sa oled SQL-i õppinud nädalatel 1-4. Aga Supabase lisab peale hulga kasulikke kihte: automaatne REST API iga tabeli jaoks, autentimise süsteem, reaalajas tellimused ja palju muud. Python SDK on teek, mis muudab API-päringud lihtsaks Pythoni koodiks, nii et sa ei pea käsitsi HTTP-päringuid koostama.

Installimine on lihtne. Avad terminali ja kirjutad:

```bash
pip install supabase-py python-dotenv
```

See installib kaks teeki: `supabase-py` on Supabase'i klientteek ja `python-dotenv` on keskkonnamuutujate laadimiseks. Pane tähele, et teegi nimi on `supabase-py`, mitte lihtsalt `supabase`. See on levinud viga, mis tekitab ModuleNotFoundError.

Ühendamine on samuti lihtne:

```python
from supabase import create_client

supabase = create_client(url, key)
```

Nüüd saad sa andmeid pärida. Süntaks on intuitiivne, eriti kui sa tunned SQL-i. Tegelikult on Supabase Python client disainitud nii, et see sarnaneks SQL-ile:

```python
# SELECT * FROM sales
response = supabase.table('sales').select('*').execute()

# SELECT * FROM sales WHERE city = 'Tallinn'
response = supabase.table('sales').select('*').eq('city', 'Tallinn').execute()

# SELECT * FROM sales WHERE total_price >= 100 ORDER BY total_price DESC LIMIT 10
response = supabase.table('sales').select('*').gte('total_price', 100).order('total_price', desc=True).limit(10).execute()
```

Vaata, kuidas `.eq()` vastab SQL-i `WHERE =` klauslile, `.gte()` vastab `WHERE >=` klauslile ja `.order()` vastab `ORDER BY` klauslile. Kui sa tunned SQL-i, tunned sa ka Supabase Python client-i.

Tulemused on `response.data`-s, mis on Pythoni sõnastike loetelu. Selle teisendamine pandas DataFrame-iks on üks rida:

```python
import pandas as pd
df = pd.DataFrame(response.data)
```

Ja nüüd saad sa kasutada kõiki pandas-oskuseid, mida eelmisel nädalal õppisid: grupeerimine, filtreerimine, RFM-arvutused, kliendisegmenteerimine. Ainus erinevus on, et andmed tulid API-st, mitte CSV-failist. See on väike muutus koodis, aga suur muutus töövoos.

Oluline on mõista ka filtreerimise efektiivsust. Sa saad filtreerida kas API tasemel ehk andmebaasi tasemel, või Pythoni tasemel ehk oma arvuti tasemel. API tasemel filtreerimine on alati kiirem, sest andmebaas teeb töö ära ja saadab sulle ainult vajalikud read. Pythoni tasemel filtreerimine tähendab, et sa laadid kõik andmed üle võrgu oma arvutisse ja siis filtreerid, mis on aeglasem, mälumahukam ja raiskab ribalaiust.

```python
# KIIRE: filter API tasemel (ainult Tallinna read tulevad üle võrgu)
response = supabase.table('sales').select('*').eq('city', 'Tallinn').execute()

# AEGLANE: filter Pythoni tasemel (kõik read tulevad, filtreerime hiljem)
response = supabase.table('sales').select('*').execute()
df = pd.DataFrame(response.data)
df_tallinn = df[df['city'] == 'Tallinn']
```

Mõlemal juhul saad sama tulemuse, aga esimene variant on palju efektiivsem. See on oluline, kui andmemaht kasvab: 10 000 rida võib mõlemaga hakkama saada, aga 100 000 rida puhul on erinevus kriitiline. Andmebaas on optimeeritud filtreerimiseks, su arvuti ei ole.

Suurte andmemahtude puhul on kasulik ka lehekülgedeks jagamine ehk pagination. Supabase'i vaikimisi piirang on 1000 rida päringu kohta. Kui sul on 10 000 rida, pead sa tegema mitu päringut:

```python
all_data = []
batch_size = 1000
offset = 0

while True:
    response = supabase.table('sales') \
        .select('*') \
        .range(offset, offset + batch_size - 1) \
        .execute()

    batch = response.data
    if not batch:
        break

    all_data.extend(batch)
    offset += batch_size

df = pd.DataFrame(all_data)
```

See muster on oluline meelde jätta, sest tootmiskeskkonnas on andmemahud sageli suured ja pagination on paratamatus.

## Andmete Pipeline: Extract-Transform-Load

ETL ehk Extract-Transform-Load on andmeinseneri üks olulisemaid kontseptsioone ja see on muster, mida kasutavad kõik andmemeeskonnad maailmas. See on viis, kuidas andmed liiguvad allikast analüüsini ja sealt tulemusteni. Mõtle sellele kui tehase konveierile: toore materjal tuleb sisse, seda töödeldakse ja valmistoode läheb välja.

**Extract** on andmete hankimine. Sa pöördud API poole ja laadid andmed. See on esimene samm ja siin on oluline veakäsitlus: mis juhtub, kui API ei vasta? Mis juhtub, kui võrguühendus katkeb? Mis juhtub, kui andmebaas on hoolduse tõttu maas? Hea pipeline käsitleb neid olukordi graatsiliselt: proovib uuesti, logib vea ja teavitab kedagi.

Extract-faasis on oluline ka andmete valideerimine: kas saadud andmed on oodatud formaadis? Kas kõik vajalikud veerud on olemas? Kas ridade arv on mõistlikus vahemikus? Kui tavaliselt on 10 000 rida, aga täna tuli ainult 10, siis midagi on valesti ja pipeline peaks selle märkama.

**Transform** on andmete töötlemine. Siin tulevad mängu kõik pandas-oskused, mida sa oled õppinud: puhastamine (duplikaadid, NULL-id, andmetüübid), arvutamine (KPI-d, skoorid, protsendid), grupeerimine (kuude kaupa, linnade kaupa, segmentide kaupa) ja segmenteerimine (RFM-analüüs). See on osa, kus su analüütikaoskused loevad. Sa muudad toored andmed väärtuslikeks järeldusteks.

Transform-faas on sageli kõige keerulisem, sest siin on enim äriloogikat. Kuidas sa defineerid VIP-kliendi? Milliseid kaalusid kasutad RFM-skooride puhul? Kuidas sa käsitled klienti, kelle viimane ost oli just piiri peal? Need otsused mõjutavad tulemusi ja peavad olema dokumenteeritud.

**Load** on tulemuste salvestamine ja edastamine. See võib olla CSV-faili eksport ajatempliga failinimes, andmebaasi tagasikirjutamine uude tabelisse, e-kirja saatmine Markole, Google Workspace Chat'i sõnumi saatmine meeskonnale või dashboard-i andmete uuendamine. See on osa, kus su töö muutub teistele nähtavaks ja kasutatavaks.

Pipeline-i arhitektuur peaks olema modulaarne. See tähendab, et iga etapp on eraldi funktsioon oma vastutusalaga:

```python
def extract_data():
    """Hangi andmed Supabase API-st"""
    response = supabase.table('sales').select('*').execute()
    return pd.DataFrame(response.data)

def transform_data(df):
    """Töötle andmed: puhastamine, arvutused, segmenteerimine"""
    df = clean_data(df)
    df_rfm = calculate_rfm(df)
    return df_rfm

def load_data(df_result, output_dir='./output'):
    """Salvesta tulemused CSV-faili"""
    filename = f"rfm_segments_{datetime.now().strftime('%Y%m%d')}.csv"
    df_result.to_csv(os.path.join(output_dir, filename), index=False)
    return filename

def run_pipeline():
    """Orkestreeeri kogu pipeline"""
    logging.info("Pipeline algab")
    df_raw = extract_data()
    logging.info(f"Laaditi {len(df_raw)} rida")
    df_processed = transform_data(df_raw)
    logging.info(f"Töödeldud {len(df_processed)} klienti")
    output = load_data(df_processed)
    logging.info(f"Eksporditud: {output}")
```

Miks modulaarne? Sest kui midagi läheb valesti, saad sa kohe teada, millises etapis viga tekkis. Kui extract ebaõnnestub, on see API-probleem. Kui transform ebaõnnestub, on see andmekvaliteedi probleem. Ja sa saad iga etappi eraldi testida, ilma kogu pipeline-i käivitamata. See muudab arenduse ja silumise palju kiiremaks.

## Veakäsitlus: Mis Juhtub, Kui Midagi Läheb Valesti?

Tootmiskõlblik kood peab olema valmis vigade jaoks. API võib olla maas, võrguühendus võib katkeda, andmebaas võib olla ülekoormatud, andmed võivad olla vigased. Kui su skript lihtsalt jookseb kokku, siis keegi ei tea, mis juhtus, ja Marko ei saa oma esmaspäevast VIP-listi. Halvimal juhul jookseb ta endiselt eelmise nädala andmetega ja teeb valesid otsuseid, arvates, et andmed on värsked.

Pythoni try-except on su peamine tööriist vigade käsitlemiseks:

```python
try:
    response = supabase.table('sales').select('*').execute()
    df = pd.DataFrame(response.data)
    logging.info(f"Edu: {len(df)} rida laaditud")
except Exception as e:
    logging.error(f"VIGA andmete laadimisel: {e}")
    # Siia tuleb veakäsitluse loogika: teavita, proovi uuesti, kasuta vahemälu
```

Aga lihtsalt vea püüdmine ei piisa. Hea pipeline logib vead, proovib uuesti ja teavitab, kui midagi on tõsiselt valesti. See on erinevus harrastaja ja professionaali vahel.

**Retry-loogika** ehk uuesti proovimise loogika on oluline, sest paljud vead on ajutised. Võrguühendus võib hetkeks katkeda, API võib olla ajutiselt ülekoormatud, andmebaas võib teha lühikest hooldust. Selle asemel, et kohe alla anda, proovid sa uuesti, iga kord natuke kauem oodates:

```python
import time

def fetch_with_retry(table_name, max_retries=3):
    for attempt in range(max_retries):
        try:
            response = supabase.table(table_name).select('*').execute()
            return pd.DataFrame(response.data)
        except Exception as e:
            wait_time = 2 ** attempt  # 1, 2, 4 sekundit
            logging.warning(f"Katse {attempt + 1}/{max_retries} ebaonnestus: {e}")
            logging.info(f"Ootan {wait_time} sekundit enne järgmist katset...")
            time.sleep(wait_time)
    logging.error(f"Kõik {max_retries} katset ebaõnnestusid tabeli {table_name} jaoks!")
    raise Exception(f"Andmete laadimine ebaonnestus pärast {max_retries} katset")
```

See on exponential backoff muster: iga kord ootad sa kauem enne uut katset (1 sekund, 2 sekundit, 4 sekundit). See annab API-le aega taastuda ja väldib olukorda, kus su skript pommitab API-d päringutega just siis, kui see on ülekoormatud.

Oluline on ka eristada erinevaid veatüüpe. Mõned vead on taastumisvõimelised (võrguviga, ajutine ülekoormatus), mõned mitte (vale API-võti, tabel ei eksisteeri). Taastumisvõimeliste vigade puhul proovi uuesti, mittetaastumisvõimeliste puhul logi ja lõpeta kohe.

## Logimine: Su Pipeline'i Must Kast

Lennukitel on must kast, mis salvestab kõik lennuandmed. Kui midagi läheb valesti, saab must kast aidata probleemi tuvastada. Su pipeline'i must kast on logifail. Ilma logifailita on sul ainult kaks olekut: "töötas" ja "ei töötanud". Logifailiga on sul täielik ajalugu: mis juhtus, millal juhtus, millises etapis juhtus ja mis oli tulemus.

Pythoni `logging`-moodul on palju parem kui `print()`. Print-laused kaovad, kui terminal suletakse. Logifailid jäävad alles ja neid saab hiljem analüüsida. Print-laused ei sisalda ajatemplit. Logifailid sisaldavad automaatselt kuupäeva, kellaaega ja logitaset.

```python
import logging
from datetime import datetime

logging.basicConfig(
    filename=f'logs/pipeline_{datetime.now().strftime("%Y%m%d")}.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

logging.info("Pipeline kaivitub")
logging.info("Laadin muugiandmeid...")
logging.warning("5% klientidest puudub e-posti aadress")
logging.error("API paring ebaonnestus: Timeout after 30 seconds")
```

Logifaili sisu näeb välja selline:

```
2025-03-10 09:00:01 - INFO - Pipeline kaivitub
2025-03-10 09:00:03 - INFO - Laadin muugiandmeid...
2025-03-10 09:00:05 - INFO - Laaditi 10234 muugirida
2025-03-10 09:00:06 - WARNING - 5% klientidest puudub e-posti aadress
2025-03-10 09:00:08 - INFO - RFM arvutatud 2487 kliendile
2025-03-10 09:00:09 - INFO - Eksporditud: output/rfm_segments_20250310.csv
2025-03-10 09:00:09 - INFO - Pipeline loppes edukalt. Kestus: 8 sekundit
```

Logimise tasemed on olulised ja igaühel on oma otstarve. **DEBUG** on detailne tehniline info, mida kasutad silumise ajal. **INFO** on tavaline tegevus, mis näitab, et kõik töötab. **WARNING** on midagi, mida peaks jälgima, aga mis ei blokeeri tööd. **ERROR** on tõsine probleem, mis takistab oodatud tulemust. **CRITICAL** on katastroof, mis nõuab kohest sekkumist.

Hea logimine aitab sul probleeme leida ka siis, kui sa ei istu arvuti taga. Kui esmaspäeval kell 9 pipeline ei tööta, saad sa kell 10 logifaili avada ja näha täpselt, mis läks valesti. See on hädavajalik automaatsete süsteemide puhul.

## Ajastamine: Cron ja GitHub Actions

Automatiseeritud pipeline ei ole midagi väärt, kui sa pead seda ikkagi käsitsi käivitama. Ajastamine on see, mis teeb pipeline-ist tõelise süsteemi. Ilma ajastamiseta on see lihtsalt skript, mida keegi peab mäletama käivitada.

**Cron** on Unix ja Linux süsteemide ajastamise tööriist, mis on eksisteerinud juba aastakümneid. Mac kasutab samuti cron-i. Cron-süntaks on viis numbrit, mis määravad, millal käsk käivitub:

```
* * * * *
│ │ │ │ │
│ │ │ │ └── Nädalapäev (0-7, 0 ja 7 = pühapäev)
│ │ │ └──── Kuu (1-12)
│ │ └────── Kuupäev (1-31)
│ └──────── Tund (0-23)
└────────── Minut (0-59)
```

Näiteks `0 9 * * 1` tähendab "iga esmaspäev kell 9:00". See on täpselt see, mida Marko vajab: värske RFM-segmenteerimine iga esmaspäeva hommikul. Teine näide: `0 8 1 * *` tähendab "iga kuu esimesel päeval kell 8:00". Ja `*/30 * * * *` tähendab "iga 30 minuti tagant". Cron on väga paindlik.

Cron-i probleem on aga see, et su arvuti peab olema sees ja töötama. Kui su sülearvuti on suletud esmaspäeva hommikul, siis pipeline ei käivitu. See on koht, kus pilveajastamine tuleb mängu.

**GitHub Actions** on pilveajastamine, mis töötab GitHub-i serverites. Selle asemel, et su arvuti peab olema sees, käivitub pipeline GitHub-i infrastruktuuris. Sa kirjutad YAML-faili, mis kirjeldab, mida teha ja millal teha:

```yaml
name: Weekly RFM Pipeline
on:
  schedule:
    - cron: '0 9 * * 1'  # Iga esmaspaev 9:00 UTC
  workflow_dispatch:  # Manuaalne trigger (nupp GitHub-is)
jobs:
  rfm-analysis:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - run: pip install pandas supabase-py python-dotenv pyyaml
      - name: Run pipeline
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
          SUPABASE_KEY: ${{ secrets.SUPABASE_KEY }}
        run: python automated_rfm_pipeline.py
      - uses: actions/upload-artifact@v3
        with:
          name: rfm-segments
          path: output/*.csv
```

See YAML-fail ütleb GitHub-ile: "Iga esmaspäev kell 9 UTC loo uus virtuaalne masin Ubuntu-ga, installi Python ja vajalikud teegid, käivita mu skript ja salvesta väljundfail." API-võtmed tulevad GitHub Secrets-ist, mis on turvaline viis saladuste hoidmiseks.

GitHub Actions on edasijõudnute tase, aga selle kontseptsiooni mõistmine on oluline kõigile. See näitab, kuidas professionaalsed andmemeeskonnad töötavad: pipeline käivitub automaatselt, tulemused on alati värsked ja keegi ei pea käsitsi midagi tegema. Su portfoolios näitab GitHub Actions workflow, et sa mõistad tootmissüsteeme.

## Konfiguratsioonifailid: Paindlik Pipeline

Hea pipeline ei sisalda kõvakodeeritud väärtuseid. Mis on kõvakodeerimine? See on, kui sa kirjutad oma koodi sisse konkreetsed numbrid, teed ja parameetrid, mida hiljem on raske muuta:

```python
# HALB: kovakodeeritud - iga muutus nõuab koodi muutmist
lookback_days = 365
vip_threshold = 13
output_dir = "./output"
```

Mis juhtub, kui Marko tahab muuta VIP-lävendi 12-le? Või kui sa tahad analüüsida ainult viimased 180 päeva? Või kui väljundkaust peab olema teine? Sa pead koodi muutma. See on ohtlik, sest iga koodimuutus võib tuua uusi vigu. Ja see nõuab programmeerimisoskuseid, mida lõppkasutajal ei pruugi olla.

Parem lahendus on konfiguratsioonifail. YAML on populaarne formaat, mis on inimloetav ja lihtne:

```yaml
pipeline:
  lookback_days: 365
  output_dir: "./output"
  schedule: "0 9 * * 1"

rfm:
  recency_weight: 1.0
  frequency_weight: 1.5
  monetary_weight: 2.0

segments:
  vip_threshold: 13
  loyal_threshold: 10
  at_risk_threshold: 6
```

Pythonis laed selle nii:

```python
import yaml

with open('config.yaml', 'r') as f:
    config = yaml.safe_load(f)

lookback = config['pipeline']['lookback_days']
vip_threshold = config['segments']['vip_threshold']
```

Nüüd saab Marko ise muuta konfiguratsiooni, ilma koodi puutumata. Ta avab `config.yaml`, muudab `vip_threshold: 12`-ks ja pipeline kasutab järgmisel käivitusel uut lävendi. See on oluline, sest lõppkasutaja ei peaks vajama programmeerimisoskuseid, et pipeline-i kohandada.

## Tootmisvalmiduse Kontrollnimekiri

Mida tähendab "tootmisvalmis"? See tähendab, et su kood ei tööta ainult su arvutis ideaaltingimustes, vaid käsitleb ka erandolukordi, on dokumenteeritud nii, et keegi teine saab seda kasutada ja hallata, ning töötab usaldusväärselt ilma su pideva järelevalveta.

Siin on kontrollnimekiri, mida professionaalsed andmemeeskonnad kasutavad enne süsteemi tootmisesse laskmist:

**Veakäsitlus:** kas su skript käsitleb API-vigu, puuduvaid andmeid, võrgukatkestusi ja ootamatuid andmeformaate? Kas vead logitakse koos piisava kontekstiga, et neid hiljem diagnoosida?

**Logimine:** kas su skript logib oma tegevust struktureeritult? Kas logifailid on kuupäevalised? Kas logitasemed on õigesti kasutatud?

**Konfiguratsioon:** kas kõik parameetrid on konfiguratsioonifailis, mitte koodis? Kas konfiguratsioon on valideeritud (kas vajalikud võtmed on olemas)?

**Dokumentatsioon:** kas README selgitab, kuidas skripti seadistada ja käivitada? Kas funktsioonidel on docstring-id? Kas levinumad vead ja nende lahendused on dokumenteeritud?

**Turvalisus:** kas API-võtmed on `.env`-failis ja `.gitignore`-is? Kas `.env.example` on olemas? Kas saladusi pole kunagi commit-itud?

**Testimine:** kas sa oled testinud, mis juhtub, kui andmed on tühjad, kui API on maas, kui konfiguratsioon on vale, kui andmed sisaldavad ootamatuid väärtuseid?

Toomas Kask, UrbanStyle'i IT-direktor, ütleb: "Ma ei usalda koodi, mis ei ole testitud. Ma ei usalda pipeline-i, mis ei logi. Ja ma ei kasuta süsteemi, mida keegi ei dokumenteeri." See on kõrge standard, aga see on standard, mida tööstus nõuab.

## Automatiseerimine Karjääriskillina

Automatiseerimisoskused on tööturul üha väärtuslikumad. Traditsiooniline andmeanalüütik kirjutab päringuid ja loob aruandeid. Aga kaasaegne andmeanalüütik ehitab süsteeme, mis teevad seda automaatselt. See on oluline eristus, mis mõjutab nii palgataset kui ka karjäärivõimalusi.

Uus populaarne roll on "Analytics Engineer" ehk analüütika insener. See on inimene, kes on sild andmeanalüütiku ja andmeinseneri vahel. Ta mõistab äriküsimusi nagu analüütik, aga ehitab automatiseeritud süsteeme nagu insener. Ja see roll on nõutud: palgad on keskmiselt 20-30% kõrgemad kui traditsioonilise analüütiku omad ja tööpakkumisi on rohkem.

API-integratsioonide oskus on ka kasulik SaaS-tööriistade maailmas. Paljud ettevõtted kasutavad tööriistu nagu Zapier, Make.com ja Airbyte, mis ühendavad erinevaid süsteeme API-de kaudu. Kui sa mõistad, kuidas API-d töötavad, saad sa neid tööriistu palju efektiivsemalt kasutada ja isegi oma integratsioone luua.

Pipeline-i inseneeria on oskus, mis eristab sind teistest kandidaatidest tööturul. Kui su GitHub portfoolios on automatiseeritud pipeline GitHub Actions workflow-ga, siis see näitab tööandjale, et sa mõistad tootmissüsteeme, mitte ainult ad hoc analüüsi. See on signaal, mis ütleb: "See inimene suudab luua väärtust, mis kestab ja skaleerub."

## McKinney ja Knaflic Viited

McKinney raamatu peatükk 8 "Data Wrangling: Join, Combine, and Reshape" on sel nädalal eriti asjakohane. See katab andmete ühendamist mitmest allikast, mis on täpselt see, mida sa teed, kui kombineerid API kaudu saadud müügiandmeid kliendiandmetega. Loe eriti sektsioone andmete liitmisest `pd.merge()` abil ja andmete kujundamisest `pivot_table()` ja `melt()` abil.

Knaflic raamatu peatükk 8 "Pulling It All Together" keskendub sellele, kuidas esitada automatiseeritud järeldusi huvigruppidele. Kui sa esitled oma pipeline-i Markole või Toomasele, kasuta Knaflic-u soovitusi: alusta valupunktist (manuaalne töö on aeglane ja vigane), näita lahendust (automatiseeritud pipeline-i diagramm), demo väljundit (värske CSV iga esmaspäev) ja tõsta esile mõju (4 tundi nädalas hoitud kokku, alati värsked andmed).

## Kokkuvõte

Automatiseerimine ja API-d on see, mis muudavad sind ühekordsete analüüside tegijast süsteemide ehitajaks. API annab sulle programmaatilise juurdepääsu andmetele, pipeline organiseerib su töö loogilisteks etappideks (Extract-Transform-Load) ja ajastamine teeb kõik automaatseks. Veakäsitlus, logimine ja konfiguratsioonifailid tagavad, et süsteem töötab usaldusväärselt ka siis, kui sa ei jälgi seda.

Kõige olulisem on aga mõtteviisi muutus. Sa ei mõtle enam "ma käivitan selle skripti", vaid "see süsteem töötab ise". Marko saab oma VIP-listi iga esmaspäev. Toomas saab varude hoiatused. Anna saab turundussegmendid. Ja sina saad keskenduda järgmise probleemi lahendamisele, mitte eelmise kordamisele.

See on täpselt see, mida Toomas mõtleb, kui ta ütleb "production-grade analytics". Mitte ühekordne skript, vaid süsteem. Automatiseeritud, testitud, dokumenteeritud ja monitooritud. Ja kui sa oskad seda teha, siis sa oled valmis mitte ainult andmeanalüütiku, vaid ka analüütika inseneri rolliks.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist. Optimeeritud NotebookLM audio genereerimiseks.*

# DACA Programmi Raamistik ja Struktuur

## Sissejuhatus

DACA (Data Analytics Career Accelerator - Andmeanalüütiku Karjäärikiirendaja) on 11-nädalane intensiivne programm, mis viib sind nullist praktiseeriva andmeanalüütikuni. See ei ole tavaline online kursus - see on **simulatsiooni-põhine õppeprogramm**, kus töötad realistlike andmetega, lahendad realistlikke äriprobleeme ja lood portfoolio, mis näitab su oskusi.

See dokument kirjeldab DACA programmi **arhitektuuri, õpisüsteemi, hindamist ja progressioonimudelit.** Mõista seda raamistikku, et saada aru, kuidas programm sind arendab.

---

## DACA Programmi Nelja Komponendi Arhitektuur

DACA kasutab **neljakomponandilist arhitektuuri**, mis toetab erinevaid õpistiile ja eesmärke:

### Komponent 1: Mentorlus (Põhikomponent)

**See on DACA süda.** Mentorlus koosneb kolmest nädalasest sessioonist:

1. **Session 1 - Concepts (90 min):** Õppematerjalide läbiarutamine, kontseptide selgitamine, Q&A
2. **Session 2 - Group Work (90 min):** Praktiline grupiülesanne, meeskonna simulatsioon
3. **Session 3 - Retrospective (60 min):** Tagasiside, reflektsioon, portfoolio juhendamine

**Kohustuslik:** Jah (arvestuse saamiseks pead osalema vähemalt 80% sessioonidest)

**Formaat:** Live Google Meet sessioonid, 10-15 osalejat, mentor juhendab

**Hindamine:** **Arvestatud/Mittearvestatud** (pass/fail), portfoolio-põhine ainult

### Komponent 2: Portfoolio (Põhikomponent)

**See on sinu CV.** Iga nädal teed praktilisi projekte, mida laed üles GitHub'i:

- **8-10 projekti** 11 nädala jooksul
- Iga projekt näitab konkreetset oskust (SQL, pandas, visualiseerimine)
- Projekte hinnatakse **Arvestatud/Mittearvestatud** (mitte numbritega)
- Lõpus on sul **avalik GitHub portfoolio**, mida saad tööintervjuudel näidata

**Kohustuslik:** Jah (vähemalt 8 projekti peavad olema "arvestatud")

**Formaat:** GitHub repository, Jupyter Notebooks, Python skriptid, Power BI failid

**Hindamine:** Mentor annab kirjaliku tagasiside, **Arvestatud/Mittearvestatud**

### Komponent 3: E-Õpik (Põhikomponent)

**Sinu teadmiste baas.** Kaks e-raamatut (e-õppematerjalid):

1. **"SQL for Data Analysis" (fiktsioonline pealkiri):** SQL põhitõed PostgreSQL-is
2. **"Python for Data Science Beginners" (fiktsioonline pealkiri):** Python, pandas, numpy, visualiseerimine

**Kohustuslik:** Jah (lugeda enne sessioone)

**Formaat:** PDF/ePub formaadis, inglise keeles (lihtne inglise keel algajatele)

**Hindamine:** Ei hinnata otse, kuid sessioonides eeldatakse lugemist

### Komponent 4: E-Õppe Kataloog (Vabatahtlik Boonuskomponent)

**Täiendavad õppematerjalid vabatahtlikuks süvendamiseks.** See sisaldab:

- Täiendavaid videotunde
- Interaktiivsed harjutused (nt HackerRank-stiilis SQL ülesanded)
- Artikid ja juhendid
- Boonusülesanded

**KRIITILISELT OLULINE:** **Komponent 4 MITTE KUNAGI ei anna "hindeid" ega ole arvestuseks nõutud.**

- Kui mentor viitab e-õppe kataloogile, siis nad viitavad **E-Õppe Kataloogi (Component 4)**
- See on 100% vabatahtlik
- Mitte keegi ei kontrolli, kas sa teed seda
- See EI mõjuta su arvestust
- See on lihtsalt **boonusmaterjalide kataloog** neile, kes tahavad süveneda

**Kohustuslik:** **EI** (100% vabatahtlik)

**Formaat:** Online platvorm, videod, harjutused

**Hindamine:** **Ei hinnata kunagi** - see on puhtalt vabatahtlik

---

## DACA Hindamissüsteem: Arvestatud/Mittearvestatud

### Miks Mitte Numbrilised Hinded?

DACA kasutab **Arvestatud/Mittearvestatud (Pass/Fail)** süsteemi, mitte numbreid (0-100). Põhjused:

1. **Fokus õppimisele, mitte hindele:** Me tahame, et sa keskendud oskuste omandamisele, mitte "A" hinde jahtimisele
2. **Portfoolio on tähtsam:** Tööandjad tahavad näha, **mida sa oskad teha** (GitHub portfoolio), mitte numbrit
3. **Päris töös pole hindeid:** Päris analüütikuna saad sa tagasisidet ("see töötab" või "parandada vaja"), mitte numbreid
4. **Vähendab stressi:** Keskendud õppimisele, mitte "kas saan 85 või 90?"

### Kuidas "Arvestatud" Saada?

Portfoolio projekt loetakse **"Arvestatud"**, kui:

1. **Ülesanne on täidetud:** Kõik nõutud sammud on läbitud
2. **Kood töötab:** SQL päringud/Python skriptid annavad oodatud tulemused
3. **Dokumenteeritud:** Kommentaarid koodis, selgitused README.md-s
4. **Analüüs on mõistlik:** Järeldused on loogilised ja põhjendatud
5. **Esitatud õigeaegselt:** Tähtajast mööda maksimum 1 nädal (edaspidi ei hinnata)

**"Mittearvestatud"** saad, kui:

- Ülesanne on poolik või puudu
- Kood ei tööta või on vigadega
- Järeldused on ebaloogilised või põhjendamata
- Kopeeritud kelleltki teiselt (plagiarism)

### Korduvesitamine

Kui projekt on **"Mittearvestatud"**, saad:

- **Kirjaliku tagasiside mentorlot:** Mis läks valesti, mida parandada
- **1 korduvesitamise võimaluse:** Parandada ja esitada uuesti järgmise 2 nädala jooksul

Kui korduvesitamine on ka "Mittearvestatud", projekt jääb hindamata ja pead tegema täiendava boonusprojekti.

### Programmi Lõpetamine

DACA programmi lõpetamiseks pead:

1. **Osalema 80%+ mentorlussessioonidest** (Sessions 1, 2, 3)
2. **Olema "Arvestatud" vähemalt 8 projektil** (11 nädala jooksul)
3. **Avalik GitHub portfoolio** (vähemalt 8 projekti)

Saad **DACA lõpudiplomi** (certificate of completion), mis näitab, et oled läbinud 11-nädalalise intensiivprogrammi.

---

## Nädalase Struktuuri: "Flip the Classroom"

DACA kasutab **"flip the classroom"** (pööratud klassiruumi) lähenemist:

### Traditsiooniline vs. DACA Lähenemine

**Traditsiooniline:**
1. Tund → Õpetaja räägib
2. Kodutöö → Sa teed ülesandeid üksi

**DACA (Pööratud):**
1. **Self-Study (Üksi)** → Sa õpid teoreetilisi kontsepte enne sessiooni
2. **Sessions (Live)** → Sa rakendad neid kontsepte praktiliselt, mentorite ja grupi toel

### Nädalane Tsükkel (10 nädalat, Week 1-10)

Iga nädal koosneb **neljast faasist:**

---

#### **FAAS 1: Self-Study (Eelnevad nädalad, 45-60 min)**

**Mis:** Sa õpid iseseisvalt teoreetilisi kontsepte enne esimest sessiooni.

**Formaat:** Self-Study Workbook (PDF), mis sisaldab:
- **4C struktureeritud õppematerjali** (Sharon Bowmani meetod):
  - **Connection:** Side varasema teadmisega ("Mida sa juba tead SQL-i kohta?")
  - **Concepts:** Uued kontseptid ja teooriad (SQL JOIN, pandas GroupBy)
  - **Concrete Practice:** Praktiline harjutus ("Proovi seda Supabase SQL Editoris")
  - **Conclusions:** Kokkuvõte ja reflektsioon ("Mida sa õppisid? Mis oli keeruline?")
- **RAG Files:** NotebookLM-optimeeritud dokumendid (4 core + 2 weekly)
- **Value/Waste Lens:** "Mis loob väärtust? Mis on raiskamine?"
- **Character Lens A:** Üks UrbanStyle'i tegelase perspektiiv (nt Toomas muretseb andmekvaliteedi pärast)
- **Mini-AI Reflection:** "Kuidas saab AI aidata selle teemaga?" (ainult Week 0, 2, 5, 8)
- **Knowledge Check:** 10 küsimust (self-check, ei hinnata)

**Aeg:** 45-60 minutit (sõltuvalt lugemiskiirusest)

**Kus:** Üksi, oma tempos, oma arvutis

**Tulemused:**
- Sa mõistad põhikontsepte
- Oled valmis sessiooniks
- Tead, millised küsimused sul on

---

#### **FAAS 2: Session 1 - Concepts (90 min, Live Google Meet)**

**Mis:** Mentor juhendatud sessioon, kus arutad self-study materjale, esitad küsimusi ja teed flash-harjutusi.

**Formaat:**
- **4C meetod (Sharon Bowman):**
  - **Connection (10 min):** "Mida te mäletate self-study-st?" Brainstorm, sharing
  - **Concepts (30 min):** Mentor selgitab raskeid kontsepte, Q&A, näited
  - **Concrete Practice (40 min):** Flash-harjutused (Miro-based):
    - Näiteks: "Kirjuta SQL päring 5 minutiga"
    - Grupid töötavad koos Miro boardil
  - **Conclusions (10 min):** Kokkuvõte, reflektsioon
- **Character Lens B:** Teine UrbanStyle'i tegelase perspektiiv (erinev self-study'st)
- **Dual Challenge Introduction:** Tutvustus Group Work kahe ülesandega

**Tulemused:**
- Kõik küsimused on vastatud
- Oled valmis Group Work'iks
- Tead, mida Session 2-s teha

---

#### **FAAS 3: Session 2 - Group Work (90 min + presentatsioonid, Live Google Meet)**

**Mis:** Praktiline grupiülesanne, kus rakendad neid kontsepte realistlikele UrbanStyle'i probleemidele.

**Formaat:**
- **Dual Challenge Pattern** (Weeks 1-7):
  - **Challenge A (Non-IT/Physical):** Traditsiooniline, struktureeritud lähenemine (nt Office Renovation WBS)
    - 40-45 minutit
  - **Challenge B (IT/Digital):** Agile, adaptiivne lähenemine (nt ChatbotRapid Agile)
    - 40-45 minutit
  - **Synthesis (10 min):** "Mis oli ühist? Mis oli erinevat?"
- **KISS Presentations:** "Keep It Simple, Stupid"
  - Iga grupp esitab 3-5 minutit
  - Fookus järeldustele, mitte protsessile
  - "Stakeholders lose attention fast"

**Tulemused:**
- Praktiline kogemus andmeanalüüsiga
- Meeskonna koostöö simulatsioon
- Üks GitHub projekt (portfoliosse)

---

#### **FAAS 4: Session 3 - Retrospective (60 min, Live Google Meet)**

**Mis:** Reflektsioon, tagasiside ja portfoolio juhendamine.

**Formaat:**
- **Peer Feedback (20 min):** Grupiliikmed annavad teineteisele konstruktiivset tagasisidet
- **Mentor Debrief (30 min):** Mentor jagab insights, näitab "model solutions"
- **Self-Reflection Questionnaire (10 min):** Isiklik reflektsioon:
  - "Mis läks hästi?"
  - "Mis oli keeruline?"
  - "Mida õppisin?"

**Tulemused:**
- Tagasiside, mis aitab parandada
- Selgus, mida portfoolios parandada
- Valmis järgmiseks nädalaks

---

### Nädal 0: Erand

**Nädal 0** on erinev - see on **sissejuhatus ja orienteerumine:**

- **Self-Study:** UrbanStyle'i tutvustus, andmeanalüütiku roll, DACA ootused
- **Session 1:** Mentorite tutvustus, meeskonna tutvumine, Supabase setup
- **Session 2:** Andmebaasi esimene uurimine (exploratory queries)
- **Session 3:** GitHub portfoolio loomine, esimene projekt

Nädal 0 on lõdvem ja keskendub **ühendamisele ja keskkonna seadistamisele.**

---

## 4C Metoodika (Sharon Bowman)

DACA kasutab **4C õppemeetodit,** mis on tõestatud täiskasvanute õppimise jaoks:

### 1. Connection (Ühendamine)

**"Siduda uus teadmine varasemaga."**

- Aktiveerib eelteadmisi
- Loob konteksti
- Äratab huvi

**Näide (Week 3 - SQL JOIN):**
> "Mõtle oma igapäevast elu - kui sa soovid teada, kes on ostnud konkreetse toote, pead vaatama kaht tabelit: kliendid ja ostud. Kuidas sa neid kokku viid?"

### 2. Concepts (Kontseptid)

**"Selgita uusi ideid ja teooriaid."**

- Teoreetiline selgitus
- Näited ja illustratsioonid
- Ühendus praktikaga

**Näide:**
> "SQL JOIN ühendab kaks tabelit ühise veeru põhjal. INNER JOIN tagastab ainult read, kus mõlemas tabelis on vaste."

### 3. Concrete Practice (Praktiline Harjutus)

**"Rakenda kohe, mida õppisid."**

- Hands-on tegevus
- Praktiline harjutus
- "Learning by doing"

**Näide:**
> "Nüüd proovi ise: Kirjuta SQL päring, mis ühendab `customers` ja `sales` tabelid ning leiab, kes on ostnud rohkem kui 100 eurot."

### 4. Conclusions (Järeldused)

**"Reflekteeri ja kinnistada õpitud."**

- Kokkuvõte
- Reflektsioon
- Järgmised sammud

**Näide:**
> "Mida sa täna õppisid SQL JOIN-ide kohta? Mida sa järgmine kord teisiti teeksid? Milline küsimus on veel vastamata?"

**Miks 4C töötab?**

- **Täiskasvanud õpivad paremini,** kui õppimine on struktureeritud, praktiline ja reflektiivne
- **Mitte passiivne kuulamine,** vaid aktiivne osalus
- **Kinnistab pikaajalisse mällu,** sest rakendad kohe

---

## Shu-Ha-Ri Progressioonimudel

DACA kasutab **Shu-Ha-Ri** mudeli, mis pärineb Jaapani võitluskunstidest ja on laialdaselt kasutatud Agile'is:

### Shu (守) - "Kaitse, Järgi"

**Nädala 0-3: Fundamentals**

- **Eesmärk:** Õpi põhitõed, järgi reegleid täpselt
- **Mentor:** Annab täpsed sammud, juhendab detailselt
- **Osalejad:** Järgivad juhiseid, küsivad palju küsimusi
- **Analoogia:** Õpid sõitma autot - mentor ütleb, millal gaas, millal pidur

**Teemad (Week 0-3):**
- SQL põhitõed (SELECT, WHERE, ORDER BY)
- Andmete eksploratsiooni
- Lihtsad agregeerimised (COUNT, SUM, AVG)

### Ha (破) - "Purusta, Kõrvale"

**Nädala 4-7: Intermediate**

- **Eesmärk:** Kohanda reegleid oma vajadustele, eksperimenteeri
- **Mentor:** Annab üldisi juhiseid, osalejad teevad otsuseid
- **Osalejad:** Hakkavad improviseerima, proovivad erinevaid lähenemisi
- **Analoogia:** Oled osav juht - hakkad leidma oma stiili, kohaldama tehnikaid

**Teemad (Week 4-7):**
- Keerukamad SQL päringud (JOINs, subqueries, CTEs)
- Pandas andmete manipuleerimine
- Visualiseerimise tehnikad

### Ri (離) - "Vabandus, Transstsendentsus"

**Nädala 8-10: Advanced**

- **Eesmärk:** Loovilik problemaresenemine, autonoomne töö
- **Mentor:** Annab ainult eesmärgi, osalejad valivad meetodi
- **Osalejad:** Teevad iseseisvaid otsuseid, leiavad unikaalseid lahendusi
- **Analoogia:** Ekspert - võid isegi õpetada teisi

**Teemad (Week 8-10):**
- Komplekssed ärianalüüsid (CLV, RFM, Cohort)
- Predictive analytics (trendi prognoos)
- Dashboardide loomine investorite jaoks

### Miks Shu-Ha-Ri?

- **Progressioon on loomulik:** Sa alustada juhistest ja liigud autonoomia poole
- **Vältib ülekoormust:** Alguses ei nõua liiga palju iseseisvust
- **Ehitab enesekindlust:** Alustada väikestega võitudega, siis suuremate väljakutsetega

---

## RAG Failide Süsteem: Incremental Lähenemine

DACA kasutab **RAG faile** (Retrieval-Augmented Generation), mis on optimeeritud NotebookLM-i jaoks. Need failid toetavad õppimist nii enne kui pärast sessioone.

### Mis on RAG Failid?

**RAG failid** on struktureeritud, pikad (3000-8000 sõna) Markdown dokumendid, mis:
- Selgitavad kontsepte konversatsioonis toonis
- Sisaldavad praktiisi näiteid UrbanStyle'i kontekstis
- On optimeeritud NotebookLM Audio funktsiooniga (kuulamiseks)

### Inkrementaalne Lähenemine: CORE + Weekly Swap

**DACA ei eemalda RAG faile - need akumuleeruvad:**

| Week | CORE Files | Weekly Files | Total Files |
|------|------------|--------------|-------------|
| 0    | 4          | 2            | 6           |
| 1    | 4          | 4            | 8           |
| 2    | 4          | 6            | 10          |
| 3    | 4          | 8            | 12          |
| ...  | 4          | ...          | ...         |
| 10   | 4          | 22           | 26          |

**CORE Files (Permanent):**
- `CORE_R1_urbanstyle_company-rag.md`
- `CORE_R2_urbanstyle_characters-rag.md`
- `CORE_R3_daca_program_framework-rag.md`
- `CORE_R4_da_tools_guide-rag.md`

**Weekly Files (Accumulate):**
- Iga nädal lisandub 2 uut RAG faili (kontseptid + harjutused)
- Vanad RAG failid **jäävad alles** (ei eemaldata)
- Selle tulemusena saad nädalast 10 oled lisanud 22 weekly RAG faili

**Miks Inkrementaalne?**

- **Kontekst kasvab:** Kõik eelnev teadmine on alati kättesaadav
- **NotebookLM saab paremaks:** Rohkem konteksti = paremad vastused
- **Võid alati tagasi minna:** "Kuidas oli see SQL JOIN Week 3-s?"

**NotebookLM Capacity:**

- NotebookLM toetab **~50 source dokumendid**
- DACA jõuab maksimum **26 failini** (Week 10)
- Seega, **ruumi on rohkem kui piisavalt**

**Valikuline:** Kui jõudlus hakkab kannatama (harvem juhtub), saad Week 6 järel arhiveerida Week 1-3 weekly RAG faile, kuid **CORE files jäävad alati.**

---

## Visuaalne Õppimise Toetus: Miro Assets

Iga nädala materjal sisaldab **Miro assets** (SVG failid), mis on:
- **Session 1 presentatsioonid:** PPTX-slide elemendid (graafikud, diagrammid)
- **Flash harjutused:** Interaktiivsed Miro board template (nt "5-Why template")
- **Group Work canvases:** Backgrounds, cards, instructions (nt "WBS canvas")
- **Retrospective templates:** Peer feedback matrix, reflections

**Miks Miro?**

- **Visuaalne ja interaktiivne:** Paremini kui Google Docs
- **Koostöö real-time:** Grupp töötab koos samal boardil
- **Professionaalne nägu:** UrbanStyle'i branding, clean design

---

## Kaks E-Õpikut: Teadmise Alused

DACA kasutab kahte põhilist e-õpikut:

### 1. "SQL for Data Analysis" (Fiktsioonline Pealkiri)

**Mis:** Sisestab SQL põhitõed PostgreSQL-is, optimeeritud andmeanalüüsi jaoks.

**Sisult (10 peatükki):**
1. Sissejuhatus SQL-i ja andmebaasidesse
2. SELECT ja WHERE
3. Sorteerimine ja filtrid (ORDER BY, LIMIT)
4. Agregeerimised (COUNT, SUM, AVG, MIN, MAX)
5. Grupeerimine ja HAVING
6. JOIN-id (INNER, LEFT, RIGHT, FULL)
7. Subqueries ja CTE-d (Common Table Expressions)
8. Funktsiooni ja string manipulations
9. Date/Time operations
10. Andmebaasi disain ja normalisatsioon (sissejuhatus)

**Tase:** Algaja-friendly, lihtne inglise keel, praktilised näited

### 2. "Python for Data Science Beginners" (Fiktsioonline Pealkiri)

**Mis:** Sissejuhatus Pythonisse, pandas, numpy ja visualiseerimisse.

**Sisult (12 peatükki):**
1. Python põhitõed (muutujad, andmetüübid, looped)
2. Listid, dicts, tuples
3. Funktsioonid
4. NumPy arrays
5. Pandas DataFrames
6. Data loading (CSV, SQL)
7. Data cleaning (NULL, duplikaadid)
8. Data manipulation (filter, sort, group)
9. Aggregations ja pivot tables
10. Matplotlib visualiseerimine
11. Plotly interaktiivsed graafikud
12. Streamlit dashboardid (Track B)

**Tase:** Algaja-friendly, koodiga näited, step-by-step

---

## Kaks Rada (Tracks): Power BI vs. Python

DACA pakub **kahte rada visualiseerimiseks:**

### Track A: Power BI (Business-Focused)

**Mis:** Power BI Desktop (tasuta tööriist Microsoftilt) äriline andmevisualiseerimiseks.

**Eelised:**
- Kasutajasõbralik (drag-and-drop)
- Professionaalne välimus
- Laialt kasutatud äriettevõtetes
- Hea dashboardid interaktiivsete filtritega

**Ideaalne, kui:**
- Sa eelistad GUI (Graphical User Interface) üle koodi
- Sul on huvi business intelligence rollide vastu
- Tahad kiirete tulemusi

**Tools:** Power BI Desktop, SQL, lihtsat Python skriptimist

### Track B: Python + Plotly + Streamlit (Technical-Focused)

**Mis:** Koodipõhine visualiseerimine ja web-based dashboardid.

**Eelised:**
- Täielik kontroll visualiseerimise üle
- Automatiseeritavad (skriptid)
- Hea, kui tahad programmeerimise suunda
- Avatud lähtekoodiga, tasuta

**Ideaalne, kui:**
- Sa eelistad koodi
- Sul on huvi andmeteaduse või engineering rollide vastu
- Tahad õppida rohkem programmeerimist

**Tools:** Python, pandas, Plotly, Streamlit, SQL

**Kas saad vahetada?**

- Jah, kuid soovitame valida ühe ja jääda sellega (keskendamine)
- Pärast DACA lõppu võid iseseisvalt teist rada õppida

---

## Programmi Tempo ja Koormus

### Ajakulu Nädalas

| Tegevus | Aeg |
|---------|-----|
| Self-Study Workbook | 45-60 min |
| Session 1 (Live) | 90 min |
| Session 2 (Live) | 90 min |
| Session 3 (Live) | 60 min |
| Group Work projekt (portfoolio) | 2-3h |
| E-Õpiku lugemine | 1-2h |
| **KOKKU** | **~7-9h nädalas** |

**See on intensiivne programm,** kuid realistlik töötavatele inimestele.

### Nädalavahetused

- **Sessioonid** on tavaliselt **teisipäeva-neljapäeva õhtuti** (18:00-20:00 EET)
- **Nädalavahetused** on vabad (aga võid teha portfolio projekte)

---

## Tehnoloogiline Stack: 100% Tasuta

DACA kasutab ainult **tasuta tööriistu:**

| Tööriist | Eesmärk | Hind |
|----------|---------|------|
| PostgreSQL (Supabase) | Andmebaas | Tasuta |
| Python | Programmeerimise keel | Tasuta |
| VS Code | Arenduskeskkond | Tasuta |
| GitHub | Versioonihaldus, portfoolio | Tasuta |
| Power BI Desktop | Visualiseerimine (Track A) | Tasuta |
| Miro | Kollaboratsioon | Tasuta (student plan) |
| Google Meet | Live sessioonid | Tasuta (mentor provides) |
| ChatGPT | AI abi (valikuline) | Tasuta (basic tier piisab) |

**Mitte mingeid varjatud kulusid.** Kõik tööriistad on 100% tasuta.

---

## Õppekeskkonna Filosoofia

### 1. Õppite Tehes (Learning by Doing)

- **Mitte passiivsed videod,** vaid praktiline tegemise
- **Mitte teoreetilised eksamid,** vaid päris projektid
- **Mitte "õppetöö,"** vaid realistlik ärisimualatsioon

### 2. Safe-to-Fail Environment

- **Eksimusi on lubatud:** Need on õppimise osa
- **Arvestatud/Mittearvestatud süsteem:** Vähendab stressi
- **Korduvesitamise võimalus:** Saad parandada ja proovida uuesti
- **Mentore toetus:** Alati saadaval

### 3. Kollegiaalne Õppimine

- **Grupiülesanded:** Õpid teistelt
- **Peer feedback:** Näed, kuidas teised lähenevad probleemidele
- **Koostöö-simulatsioon:** Päris töös teed sa analüüsid meeskonnas

### 4. Portfoolio Kui CV

- **Lõpus ei ole eksami,** vaid **avalik GitHub portfoolio**
- **Tööandjad tahavad näha,** mida sa oskad teha
- **Sinu projektid on sinu CV**

---

## DACA vs. Teised Programmid

| Aspekt | DACA | Traditsiooniline Online Kursus |
|--------|------|-------------------------------|
| Formaat | Live mentorlus + self-study | Eelnevalt salvestatud videod |
| Hindamine | Arvestatud/Mittearvestatud, portfoolio | Numbriline hinne, eksamid |
| Praktiline | Realistlik ärisimualatsioon | Abstraktsed harjutused |
| Koostöö | Grupiülesanded, live sessioonid | Üksi, foorumid |
| Tulemused | GitHub portfoolio (8-10 projekti) | Sertifikaat, mitte portfoolio |
| Tempo | Intensiivne, 11 nädalat | Paindlik, oma tempos |
| Komponent 4 | Vabatahtlik boonuskontroll | Tihti kohustuslik |

---

## Kokkuvõte: DACA Programmi DNA

DACA programmi raamistik on disainitud nii, et:

1. **Sa õpid praktiliselt,** töötades realistlike andmetega
2. **Sa ehitad portfoolio,** mis näitab su oskusi tööandjatele
3. **Sa keskendud õppimisele,** mitte hinnete jahtimisele (Arvestatud/Mittearvestatud)
4. **Sa areneda progressiivselt** (Shu-Ha-Ri) algajast ekspertini
5. **Sa teed koostööd,** nagu päris analüütik teeks
6. **Kõik tööriistad on tasuta** - ei ole varjatud kulusid
7. **Komponent 4 (E-Õppe Kataloog) on vabatahtlik** - see EI mõjuta su arvestust

11 nädala pärast oled sa **praktkiselt valmis andmeanalüütik** portfoolioga, mis tõendab su oskusi.

Tere tulemast DACA programmi! Valmis alustama?

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist.*

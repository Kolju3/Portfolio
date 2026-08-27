# Visualiseerimise Disain: Kuidas Muuta Numbrid Lugudeks

## Sissejuhatus

Sa oled neli nädalat SQL-iga töötanud. Sa oskad andmeid pärida, puhastada, ühendada ja koondada. Aga nüüd mõtle sellele: kui sa annad CEO-le 500-realise tabeli, kas ta loeb seda? Muidugi mitte. Tal on 30 sekundit su jaoks ja ta tahab kohe aru saada, kas ettevõte kasvab või mitte. Siin tuleb mängu andmete visualiseerimine.

Visualiseerimine ei ole lihtsalt "tee ilus graafik". See on kommunikatsioonitööriist. See on viis, kuidas sa muudad toornumbrid otsusteks. Hea dashboard vastab küsimustele enne, kui keegi neid küsibki. Halb dashboard tekitab rohkem küsimusi kui vastuseid. Ja see vahe on täpselt see, mida sa sel nädalal õpid.

Sel nädalal sukeldume visualiseerimise põhimõtetesse: millal kasutada millist diagrammitüüpi, kuidas ehitada dashboard, mis räägib lugu, ja miks vähem on sageli rohkem. Kasutame kahte rada: Power BI (Track A) ja Plotly koos Streamlit-iga (Track B), aga põhimõtted on mõlema puhul samad.

## Miks Visualiseerimine On Oluline?

Inimaju töötleb visuaalset infot 60 000 korda kiiremini kui teksti. See on bioloogiline fakt. Kui sa näitad graafikut, kus joon läheb üles, saab igaüks kohe aru: kasv. Aga kui sa kirjutad "käive kasvas jaanuaris 23 450 eurolt veebruaris 27 890 eurole, mis on 18.9% kasv", siis inimene peab mõtlema, arvutama ja seejärel otsustama. See võtab aega ja tähelepanu.

Andmeanalüütiku jaoks on visualiseerimine karjääri eristaja. Maailmas on palju inimesi, kes oskavad SQL-i kirjutada. Aga inimesi, kes oskavad andmed muuta arusaadavaks loooks, on palju vähem. LinkedIn-i andmetel mainib 2,3 miljonit töökuulutust "data storytelling" oskust. See on number, mis räägib iseenda eest.

UrbanStyle.ltd puhul on see eriti aktuaalne. CEO Kristi Tamm valmistub investoritele esitluseks ja ta vajab dashboard-i, mis näitab ettevõtte tervist ühe pilguga. Tema sõnad: "Investorid ei viitsi lugeda 500-realisi tabeleid. Ma vajan dashboard-i, kus ma näen kõike ühe ekraani peal." See on su ülesanne.

## Diagrammitüübid: Millal Millist Kasutada?

See on üks olulisemaid otsuseid, mida andmeanalüütik teeb. Vale diagrammitüüp võib moonutada andmeid või muuta need raskesti loetavaks. Õige diagrammitüüp muudab andmed kohe arusaadavaks.

### Joondiagramm (Line Chart)

Joondiagramm on parim valik, kui sa tahad näidata muutust ajas. See sobib trendide, hooajaliste mustrite ja kasvu visualiseerimiseks. UrbanStyle-i puhul on kõige levinum kasutus: igakuine käive aja jooksul.

Miks joondiagramm töötab trendide jaoks? Sest joon ühendab punktid ja inimaju näeb automaatselt suunda: kas joon läheb üles, alla või on stabiilne. See on kohene, intuitiivne arusaamine. Tulpdiagrammiga samu andmeid vaadates peaks sa ise joone ette kujutama. Joondiagramm teeb selle su eest ära.

Üks oluline nüanss: joondiagramm eeldab, et x-teljel on järjepidev skaala. Kuupäevad, kuud, kvartid sobivad ideaalselt. Aga kui sa paned x-teljele kategooriaid, nagu "Tallinn, Tartu, Pärnu", siis joon loob petliku mulje, nagu oleks nende vahel mingi liikumine. Ei ole. Kategooriate jaoks kasuta tulpdiagrammi.

### Tulpdiagramm (Bar Chart)

Tulpdiagramm on parim valik kategooriate võrdlemiseks. TOP 5 toodet käibe järgi, müük linnade kaupa, meeskonnatöötajate tulemuslikkus: kõik need on tulpdiagrammi koduväli. Tulpade pikkused on koheselt võrreldavad ja silm näeb erinevusi väga täpselt.

Vertikaalne tulpdiagramm (column chart) sobib, kui kategooriate nimed on lühikesed. Horisontaalne tulpdiagramm (bar chart) sobib, kui nimed on pikad, sest siis on rohkem ruumi nime jaoks. UrbanStyle-i toodete nimede puhul, nagu "Organic Cotton Summer Dress" on horisontaalne parem.

Oluline reegel: sorteeri tulbad alati väärtuse järgi. Kui sa paned tulbad tähestiku järjekorda, on raske näha, milline on suurim. Sorteeri kahanevalt ja silm näeb kohe: esimene tulp on parim. See on lihtne, aga paljud inimesed teevad seda viga.

### Sektordiagramm (Pie Chart)

Sektordiagramm ehk ringdiagramm on kõige vastuolulisem diagrammitüüp. Andmevisualiseerimise spetsialistid väldivad seda sageli, sest inimsilm on halb nurkade ja sektorite võrdlemisel. Tulpade pikkusi on palju lihtsam võrrelda.

Aga sektordiagrammil on oma koht: kui sa tahad näidata osakaalu tervikust ja kategooriaid on vähem kui viis. Näiteks: "Online müük moodustab 60%, Tallinn 20%, Tartu 12%, Pärnu 8%." Neli sektorit, selge pilt. Aga kui sul on 15 tootekategooriat, siis sektordiagramm muutub segaseks ja loetamatuks. Sel juhul kasuta tulpdiagrammi.

Reegel: maksimaalselt 5 sektorit. Kui sul on rohkem, koonda väiksemad kategooriad gruppi "Muud" ja kasuta tulpdiagrammi detailide jaoks.

### Hajuvusdiagramm (Scatter Plot)

Hajuvusdiagramm näitab kahe muutuja vahelist seost. Iga punkt on üks andmepunkt ja tema asukoht näitab mõlema muutuja väärtust. See on ideaalne korrelatsioonide leidmiseks: kas kõrgem hind tähendab vähem müüki? Kas rohkem veebikülastusi tähendab rohkem oste?

UrbanStyle-i puhul on see kasulik turunduse ROI analüüsiks. X-teljel reklaamikulud, y-teljel müügitulu. Kui punktid moodustavad tõusva joone, siis reklaam töötab. Kui punktid on laiali, siis seos puudub.

Hajuvusdiagrammi tugevus on anomaaliate leidmises. Kui enamik punkte on klastris, aga üks on kaugel, siis see väärib uurimist. Ehk on see kuuma suvekampaania, mis töötab erakordselt hästi, või hoopis viga andmetes.

### Soojuskaart (Heatmap)

Soojuskaart kasutab värvi intensiivsust, et näidata väärtuste suurust kahedimensioonilises ruudustikus. See on ideaalne, kui sul on kaks kategooriat ja nende ristumise väärtus. Näiteks: müük nädalapäeva ja kellaaja kaupa. Tumedad lahtrid näitavad kõrget müüki, heledad madalat.

UrbanStyle-i puhul saab Anna Mets sellega teada, millal postitada Instagram-i. Kui soojuskaart näitab, et kolmapäeva õhtu kell 19-21 on online-müügi tippaeg, siis peaks turunduskampaania olema selleks ajaks aktiivne.

### KPI Kaardid (KPI Cards)

KPI kaardid ei ole traditsiooniline diagramm, aga need on dashboard-i üks olulisemaid elemente. KPI kaart näitab ühte suurt numbrit: kogukäive, klientide arv, keskmine tellimus. See on dashboard-i "hero number", mis vastab ühele küsimusele kohe.

Hea KPI kaart sisaldab kolme asja: number, muutuse suund (nool üles/alla) ja kontekst (protsent kasvu võrreldes eelmise perioodiga). Näiteks: "250 000 EUR" on number, roheline nool üles ja "+15%" on kontekst. Kohe on selge: asjad lähevad hästi.

## Dashboard-i Anatoomia: Ühe Ekraani Reegel

Dashboard on rohkem kui lihtsalt graafikute kogu ühel lehel. See on hoolikalt disainitud infosüsteem, kus iga element on oma kohal ja teenib kindlat eesmärki. Hea dashboard vastab kolmele küsimusele ilma, et kasutaja peaks midagi tegema: "Kuidas läheb?", "Miks nii?" ja "Mida teha?".

### Hierarhia: Mis On Kõige Olulisem?

Dashboard-i disainis on hierarhia kõige olulisem otsus. Mõtle sellele, kuidas silm liigub: vasakult ülevalt paremale alla. Seda nimetatakse F-mustriks ja see on tõestatud silma liikumise muster. Kõige olulisem info peaks olema vasakul üles.

Praktikas tähendab see:
- **Ülemine rida:** KPI kaardid (suurimad numbrid, kohene ülevaade)
- **Keskmine ala:** Peamine diagramm (tavaliselt kõige suurem, näiteks käivetrend)
- **Alumine ala:** Toetavad diagrammid (kategooria jaotus, linnade võrdlus)
- **Küljed või all:** Filtrid ja interaktiivsus

See struktuur on nagu ajaleht: pealkiri, juhtlugu, toetavad artiklid. Lugeja saab kiiresti ülevaate ja saab süveneda, kui tahab.

### Ühe Ekraani Reegel

Hea dashboard mahub ühele ekraanile. Mitte kerimist. Mitte teist lehte. Üks ekraan. See on karm reegel, aga see sunnib sind mõtlema: mis on tõesti oluline? Kui sa ei mahu ühele ekraanile, siis sa proovid öelda liiga palju korraga.

See ei tähenda, et sa ei saa rohkem infot näidata. Interaktiivsus, filtrid ja drill-down võimaldavad kasutajal süveneda ilma ekraani täitmata. Aga algne vaade peab olema kompaktne ja selge.

### Filtrid ja Interaktiivsus

Filtrid muudavad staatilise dashboard-i dünaamiliseks. Kasutaja saab valida ajaperioodi, linna, kategooria ja kõik diagrammid uuenduvad vastavalt. See on nagu lens, mille kaudu andmeid vaadata.

Kõige levinumad filtrid: kuupäevavahemik (viimased 3 kuud, viimased 6 kuud, kogu aeg), asukoht (Tallinn, Tartu, Pärnu, online) ja tootekategooria. Need kolm filtrit katavad enamiku äriküsimusi.

Cross-filtering on veel võimsam: kui sa klikid joondiagrammil ühel kuul, siis kõik teised diagrammid näitavad ainult selle kuu andmeid. See on nagu interaktiivne uurimistööriist, mis võimaldab kasutajal "kaevuda" andmetesse.

## Data-Ink Ratio: Vähem On Rohkem

Edward Tufte, andmevisualiseerimise guru, tutvustas data-ink ratio kontseptsiooni. See on lihtne mõte: iga piksel su ekraanil peaks kas näitama andmeid või olema tühi. Kõik muu on müra.

Mida see praktikas tähendab? Eemalda kõik, mis ei aita andmeid mõista:
- **Eemalda ruudustikujooned** (gridlines): need segavad, harva aitavad
- **Eemalda 3D efektid:** 3D tulpdiagramm näeb cool välja, aga moonutab andmeid. Tagumine tulp tundub väiksem kui esimene, isegi kui nad on samad
- **Eemalda liigsed sildid:** kui tulpade väärtused on sarnased, piisab ühe sildi näitamisest
- **Kasuta valgeid ruumi:** ära täida iga pikslit. Hingamisruum aitab silmal puhata ja fookust hoida

Tufte reegel on: "Maksimaalne andmete-tindi suhe, mõistlikkuse piires." See tähendab, et iga element ekraanil peab teenima eesmärki. Kui sa ei oska seletada, miks mingi element seal on, eemalda see.

UrbanStyle-i dashboard-i puhul tähendab see: puhas, minimalistlik disain. Mitte 15 värvi, mitte keerulised piirjooned, mitte taustapildid. Andmed ja ainult andmed.

## Värviteooria: Kuidas Värvid Mõjutavad Arusaamist

Värvid ei ole ainult esteetika. Need on kommunikatsioonitööriist. Õige värvikasutus aitab andmeid mõista, vale värvikasutus segab.

### Kategoorilised Värvid

Kui sa kasutad värve kategooriate eristamiseks (Tallinn, Tartu, Pärnu, online), siis kasuta selgelt erinevaid värve. Aga mitte rohkem kui 5-7. Inimsilm ei erista rohkem kui 7 värvi korraga. Kui sul on rohkem kategooriaid, koonda väiksemad gruppi "Muud" ja kasuta halli.

### Järjestikused Värvid

Kui sa kasutad värve väärtuste suuruse näitamiseks (väike kuni suur), kasuta ühte värvi erinevates toonides: hele on väike, tume on suur. See on soojuskaardi põhimõte. Ära kasuta vikerkaarepaletti: see näeb cool välja, aga ei ole intuitiivne.

### Tähenduslikud Värvid

Mõned värvid on kultuuriliselt kokku lepitud: roheline tähendab "hea" või "kasv", punane tähendab "halb" või "langus". Kasuta neid tähendusi: kasv on roheline, langus on punane. See on kohene ja intuitiivne.

### Ligipääsetavus: Värvipimesus

Umbes 8% meestest ja 0.5% naistest on värvipimedad. See tähendab, et sa ei saa toetuda ainult värvile info edastamiseks. Lisa alati ka teisi visuaalseid vihjeid: mustrid, sildid, ikoonid. Ja kontrolli oma paletti tööriistadega nagu ColorBrewer, mis pakub värvipimedate sõbralikke palette.

WCAG standardid nõuavad piisavat kontrasti teksti ja tausta vahel. Fondisuurus 12+ põhitekstile ja 20+ pealkirjadele tagab loetavuse.

## Dual-Track: Power BI vs Plotly + Streamlit

DACA programm pakub kaks rada visualiseerimiseks. Mõlemal on omad tugevused ja need sobivad erinevatele olukordadele.

### Track A: Power BI

Power BI on Microsoft-i ärianalüütika tööriist. See on drag-and-drop liides, mis tähendab, et sa saad luua diagramme hiirega lohistades, ilma koodi kirjutamata. See on kiire ja kasutajasõbralik. Power BI Desktop on tasuta, Power BI Service võimaldab avaldamist ja jagamist. Aga oluline piirang: Power BI Desktop töötab ainult Windows-is. MacOS kasutajad peavad kasutama Track B-d.

Power BI tugevused: kiire prototüüpimine, ilus visuaalne tulemus, lihtne avaldamine, laialdaselt kasutatav ettevõtetes. Nõrkused: piiratud kohandamisvõimalused, DAX keel võib olla keeruline ja Windows-only.

### Track B: Plotly + Streamlit

Plotly on Python-i visualiseerimise teek, mis loob interaktiivseid diagramme. Streamlit on raamistik, mis muudab Python-i skriptid veebiäppideks. Koos moodustavad need võimsa toolchain-i.

Plotly + Streamlit tugevused: täielik kontroll iga piksli üle, platvormideülene (töötab ka macOS-is), Python-i põhine (ühtib Nädal 7-8 materjaliga), avaliku lingi genereerimine Streamlit Cloud-is, portfoolio potentsiaal. Nõrkused: nõuab koodi kirjutamist, algajale aeglasem, rohkem seadistamist.

### Millist Valida?

Kui sa oled Windows kasutaja ja eelistad graafilist liidest, vali Track A. Kui sa oled Mac kasutaja või tahad sügavamat Python-i kogemust, vali Track B. Oluline: mõlemad rajad teevad SAMA asja. Dashboard näeb välja sarnane ja vastab samadele küsimustele. Tööriist on erinev, tulemus on sama.

## Knaflic ja Disainerimõtlemine

Cole Nussbaumer Knaflic-u raamat "Storytelling with Data" on DACA programmi üks kohustuslikke õpikuid. Selle raamatu 5. peatükk "Think Like a Designer" annab neli olulist põhimõtet, mis kehtivad iga dashboard-i puhul.

### Affordantsid (Visuaalsed Vihjed)

Affordants on visuaalne vihje, mis ütleb kasutajale, mida vaadata ja kuidas tõlgendada. Suurus, värv, positsioon ja kontrast on kõik affordantsid. Suurem element tundub olulisem. Ere värv tõmbab tähelepanu. Ülemises vasakus nurgas olev element loetakse esimesena.

Praktikas tähendab see: tee KPI kaardid suured ja silmapaistvad, kasuta peadiagrammi jaoks enim ruumi ja lisa kontrastsed värvid elementidele, kuhu sa tahad tähelepanu suunata.

### Ligipääsetavus

Me rääkisime juba värvipimeusest, aga ligipääsetavus on laiem teema. Fondisuurus peab olema piisavalt suur. Kontrastsus peab olema piisav. Sildid peavad olema selged ja ühemõttelised. Interaktiivsed elemendid peavad olema klaviatuuriga navigeeritavad. Ekraanilugejad peavad saama diagrammi kirjeldust lugeda.

### Esteetika

Esteetika ei ole lihtsalt "ilus". See on funktsionaalne. Joondamine loob korda ja usaldusväärsust. Valge ruum annab hingamisruumi. Järjepidevus (samad värvid samadele kategooriatele läbi kogu dashboard-i) vähendab kognitiivset koormust.

UrbanStyle-i puhul tähendab see: kasuta brändi värve (teal #009B8D, navy #1A1A2E), hoia fondid Calibri-s ja järgi DACA stiiliraamatu juhiseid.

### Omaksvõtt

Disain ei ole valmis, kui analüütik ütleb "valmis". See on valmis, kui kasutaja ütleb "ma saan aru". Testi oma dashboard-i päris kasutajatega. Kristi Tamm, Anna Mets, Liis Koppel: kas nemad saavad aru? Kui mitte, siis dashboard vajab parandamist, mitte kasutaja.

## McKinney ja Visualiseerimine

Wes McKinney raamat "Python for Data Analysis" 9. peatükk käsitleb plotimist ja visualiseerimist. Seal tutvustatakse matplotlib-i, mis on Python-i baasvisualiseerimise teek, ja pandas-e sisseehitatud plotimise meetodeid.

Kuigi DACA programmis kasutad sa Plotly-t (Track B), on McKinney peatükk kasulik, sest see annab alustõed: kuidas andmeid visualiseerimiseks ette valmistada, millised on erinevad diagrammitüübid ja kuidas kohandada graafikute välimust. Need kontseptsioonid kehtivad sõltumata tööriistast.

Track A kasutajatele on see peatükk Python-i tulevikuks valmistumine: Nädal 7 kasutab pandas-t ja seal tulevad need teadmised kasuks.

## Andmete Ettevalmistamine Dashboard-i Jaoks

Enne kui sa avad Power BI või kirjutad Plotly koodi, pead sa andmed ette valmistama. See on tegelikult SQL-i töö, mida sa oled juba neli nädalat harjutanud.

Dashboard-i jaoks vajad agregeeritud andmeid. Mitte tuhandeid üksikuid ridu, vaid koondnumbreid: igakuine käive, TOP 10 toodet, müük linnade kaupa. Need päringud sa juba oskad. Nüüd on küsimus, kuidas need tulemused dashboard-i saada.

Track A (Power BI) ühendub otse Supabase andmebaasiga ja sa saad DAX-i või Power Query abil andmeid töödelda. Track B (Plotly) kasutab Python-i: sa laed andmed Supabase-ist pandas DataFrame-i ja seejärel lood Plotly diagramme.

Mõlemal juhul on oluline: andmed peavad olema õiges formaadis. Kuupäevad peavad olema kuupäevatüübina (mitte stringina). Summad peavad olema numbrilised. Kategooriad peavad olema järjepidevad. Need on andmekvaliteedi probleemid, mida sa oled juba harjutanud lahendama.

## Kokkuvõte

Visualiseerimine on andmeanalüütiku üks olulisemaid kommunikatsioonitööriistu. Diagrammitüübi valik, dashboard-i struktuur, värviteooria ja data-ink ratio on kõik põhimõtted, mis muudavad lihtsad graafikud professionaalseks tööriistaks.

Kõige olulisem on aga see: dashboard ei ole kunst galeriis. See on tööriist, mis aitab inimestel teha paremaid otsuseid. Kristi Tamm ei taha ilusat graafikut. Ta tahab vastust küsimusele "kas me kasvame?" Sinu dashboard peab sellele vastama kolme sekundiga.

Sel nädalal ehitad sa oma esimese dashboard-i UrbanStyle.ltd andmetega. See on su esimene visuaalne portfoolio-esitus ja see läheb GitHub-i. Tee see hästi, sest investorid tulevad ja Kristi vajab sind.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist. Optimeeritud NotebookLM audio genereerimiseks.*

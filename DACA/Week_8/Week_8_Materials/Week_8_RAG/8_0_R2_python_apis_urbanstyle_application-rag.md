# Python ja API-d UrbanStyle'i Praktikas: Marko Automatiseerimise Väljakutse

## Sissejuhatus

Sel nädalal muutub kõik. Marko Saar, UrbanStyle'i tootehaldur, jooksis meeskonna koosolekule sisse, sülearvuti lahti ja silmad säravad. Eelmisel nädalal sai ta kätte RFM-analüüsi tulemused: 245 VIP-klienti, kes genereerivad 42% käibest. Marko oli vaimustuses, aga siis tabas teda realiteet: see analüüs on staatiline. See on eilsete andmete snapshot. Homme tulevad uued tellimused ja ülehomine veel rohkem. Analüüs vananeb iga päevaga ja iga uue tehinguga.

Marko ei taha enam manuaalset tööd. Ta tahab süsteemi, mis töötab tema eest. Ja Toomas Kask, IT-direktor, kes on kogu programmi jooksul olnud kriitiline ja skeptiline, noogutab. "See on täpselt see, mida tootmisvalmis analüütika tähendab," ütleb Toomas. "Mitte ühekordne skript, vaid süsteem." See on pöördepunkt Toomase arenguloos: ta on muutunud skeptikust toetajaks.

Selles dokumendis vaatame läbi, kuidas ehitada UrbanStyle'i jaoks automatiseeritud andmete pipeline, alates Supabase API ühendamisest kuni ajastatud aruanneteni ja IT-meeskonna koolitamiseni.

## Marko Väljakutse: Automaatne Iganädalane Segmenteerimine

Marko saatis DataDriven meeskonnale konkreetse e-kirja, mis kirjeldab tema vajadusi väga selgelt. Ta tahab süsteemi, mis iga esmaspäeval kell 9:00 pärib värsked andmed Supabase'ist, arvutab RFM-skoorid, genereerib CSV-faili klientide segmentidega ja ideaalis saadab tulemuse talle e-kirjaga. Ja kõik see peab toimuma automaatselt, ilma et keegi peaks käsitsi midagi käivitama. Ta ütleb: "Automatiseerimine pole laiskus. See on skaleeritavus."

See ei ole lihtsalt tehniline harjutus. See on reaalse ärivajaduse lahendamine. Marko kasutab VIP-listi personaalsete pakkumiste saatmiseks: VIP-kliendid saavad eksklusiivse eelesitluse uute kollektsioonide kohta. Anna Mets kasutab segmenteerimist turunduskampaaniate sihtimiseks: at-risk klientidele läheb "me igatseme teid" kampaania, potentsialsetele klientidele läheb soodustuskulpong. Kristi Tamm kasutab koondnumbreid investorite raportis: "Meie VIP-segment kasvas sel kuul 3% ja nende keskmine tellimusväärtus on 89 eurot." Kui need andmed on iganädalaselt värsked ja automaatsed, siis kogu ettevõte töötab paremini.

## CSV-lt API-le: Esimene Suur Muutus

Eelmisel nädalal laadisid sa andmed CSV-failist. See töötas hästi: `df = pd.read_csv('urbanstyle_sales.csv')` ja sa said kohe analüüsima hakata. Aga see tähendas, et keegi pidi käsitsi Supabase'i sisse logima, navigeerima õige tabeli juurde, klikkama "Export CSV", faili oma arvutisse laadima, selle õigesse kausta panema ja alles siis skripti käivitama. Kolm kuni viis manuaalset sammu enne analüüsi algust. Ja iga samm on koht, kus midagi võib minna valesti: vale kuupäevavahemik, unustatud filter, vana fail, mis kirjutab uue üle.

Supabase Python SDK-ga on kõik üks samm. Sa ühendad oma skripti otse andmebaasiga ja andmed tulevad kohe, värsked ja täielikud. Mõtle, mida see tähendab Marko jaoks: ta ei pea enam kellelegi helistama ja ütlema "palun ekspordi uued andmed." Ta ei pea enam ootama, kuni keegi jõuab seda teha. Süsteem teeb seda automaatselt, täpselt õigel ajal. Ja mis kõige olulisem: andmed on alati värsked. Mitte eilsed, mitte eelmise nädala omad, vaid praegused.

Esimene ülesanne on asendada CSV-laadimine API-päringuga. See on väike muutus koodis, aga suur muutus filosoofias. CSV on nagu ajaleht: keegi prindib selle välja ja sa loed vananenud uudiseid. API on nagu reaalajas uudisvoog: sa näed alati viimast infot. Ja see filosoofiline muutus on see, mis eristab juunior-analüütikut senioor-analüütikust: senioor ei küsi "kust ma saan andmed?", vaid ehitab süsteemi, mis andmed automaatselt toob.

Aga mitte ainult müügiandmed. Marko vajab ka kliendiandmeid segmenteerimiseks, et teada iga kliendi nime, linna ja lojaalsustasest. Ta vajab tooteandmeid kategooriate lisamiseks, et näha, millised tootekategooriad on iga segmendi lemmikud. Ja ta vajab varudeandmeid, et saada hoiatusi, kui VIP-klientide lemmiktooted on otsa saamas. See tähendab mitut API-päringut, mis tuleb kombineerida üheks tervikuks. Siin tulevad mängu eraldi funktsioonid: `fetch_sales()`, `fetch_customers()`, `fetch_products()`. Iga funktsioon teeb ühe asja ja teeb seda hästi. See on single responsibility printsiip: iga funktsioon vastutab ühe andmeallika eest.

## Pipeline Ehitamine: Neli Moodulit

UrbanStyle'i automatiseeritud pipeline koosneb neljast moodulist, nagu tehase neli osakonda. Iga moodul on eraldi fail, eraldi vastutusalaga, eraldi testidega. See modulaarsus on oluline, sest see muudab süsteemi hallitavaks: kui midagi läheb valesti, tead sa kohe, millises moodulis probleem on.

**data_fetcher.py** on extract-moodul. See sisaldab funktsioone, mis pärivad andmeid Supabase API-st. Iga funktsioon käsitleb ühte tabelit: `fetch_sales()` müügid, `fetch_customers()` kliendid, `fetch_products()` tooted. Funktsioonid sisaldavad veakäsitlust: kui API ei vasta, proovitakse uuesti exponential backoff mustriga. Kui kolm katset ebaõnnestuvad, logitakse viga ja teavitatakse.

Marko jaoks on oluline, et andmete hankimine on parameetritega juhitav. Ta tahab vahetevahel vaadata ainult viimase 30 päeva andmeid kiireks analüüsiks, vahetevahel kogu aastat põhjalikuks ülevaateks. Funktsioon `fetch_sales()` võtab valikulised parameetrid `start_date` ja `end_date`, mis võimaldavad paindlikku andmete hankimist ilma koodi muutmata.

**transform.py** on transform-moodul. See sisaldab andmetöötluse loogikat: puhastamine, arvutused, segmenteerimine. Siin taaskasutatakse nädala 7 RFM-koodi, aga funktsioonidesse pakituna. `clean_data()` eemaldab duplikaadid ja käsitleb NULL-väärtuseid. `calculate_rfm()` arvutab Recency, Frequency ja Monetary skoorid. `assign_segments()` jaotab kliendid segmentidesse. Iga funktsioon võtab DataFrame-i ja tagastab DataFrame-i. See muudab koodi testihavaks.

Puhastamise funktsioon on eriti oluline, sest UrbanStyle'i andmebaas sisaldab tahtlikult vigu: mõned kliendid on topelt, mõnel kliendil puudub e-posti aadress, mõne tehingu hind ei vasta tootetabeli hinnale. Kui su pipeline ei suuda nendega hakkama saada, siis tulemused on valed ja Marko teeb valesid otsuseid.

**pipeline.py** on orkestreeija. See ühendab extract- ja transform-moodulid üheks tervikuks ning lisab logimise ja väljundi. Pipeline.py on nagu dirigent, kes juhib orkestrit: ta ei mängi ise ühtegi instrumenti, aga koordineerib kõiki teisi. Ta teab, mis järjekorras asjad toimuvad, ja hoiab kõike koos.

Pipeline.py kasutab käsurea argumente, et pipeline oleks paindlik. `--date` määrab analüüsi kuupäeva, `--output-dir` väljundkausta, `--format` väljundformaadi. Nii saab sama pipeline-iga teha erinevaid asju: `python pipeline.py --date 2025-03-01 --format csv` teeb CSV-väljundi märtsi alguse andmetega, `python pipeline.py --format json` teeb JSON-väljundi tänaste andmetega.

**monitor.py** on monitoorimismoodul. See kontrollib, kas pipeline töötas õigesti ja kas tulemused on mõistlikud. Kas väljundfail eksisteerib? Kas see on värske, mitte eilne? Kas ridade arv on mõistlik? Kas segmentide jaotus tundub normaalne? Kui midagi on valesti, logitakse hoiatus ja saadetakse teavitus.

## Andmekvaliteedi Kontrollid Pipeline-is

Marko ei taha lihtsalt numbreid. Ta tahab õigeid numbreid. Vale VIP-list on hullem kui puuduv VIP-list, sest see viib valede otsusteni. Seetõttu sisaldab pipeline mitmetasandilisi andmekvaliteedi kontrolle.

Pärast andmete hankimist kontrolli: kas ridade arv on oodatav? Kui tavaliselt on 10 000 müügirida, aga täna tuli ainult 100, siis midagi on valesti, võib-olla API filtrid on valed või andmebaasis on probleem. Kas kõik oodatavad veerud on olemas? Kui `total_price` veerg puudub, siis RFM-arvutus ei tööta. Kas andmetüübid on õiged? Kui `sale_date` on string, mitte kuupäev, siis Recency arvutus annab vale tulemuse.

Pärast transformeerimist kontrolli: kas RFM-skoorid on vahemikus 1-5? Kas segmendid on oodatavad (VIP, Loyal, Potential, At-Risk, Lost)? Kas segmentide osakaal on mõistlik? Kui äkki 80% klientidest on VIP, siis midagi on lävendi seadistusega valesti.

Need kontrollid on nagu kvaliteedikontroll tehases. Sa ei saada toodet välja ilma kontrollita. Toomas hindab seda eriti: "Andmekvaliteet on kõige olulisem. Vale analüüs on hullem kui puuduv analüüs, sest vale analüüs tekitab vale kindlustunde."

## Automatiseeritud Aruandlus: Marko Esmaspäevane E-kiri

Marko unistus on lihtne ja konkreetne: esmaspäeva hommikul, enne esimest koosolekut, avab ta oma e-posti ja seal on värske aruanne. Selles on VIP-klientide list koos nimede ja viimasesumma ostuga, at-risk klientide hoiatus koos päevade arvuga viimasest ostust, nädala koondnumbrid ja segmentide jaotuse muutus võrreldes eelmise nädalaga.

Pipeline-i põhiväljund on CSV-fail ajatempliga: `output/rfm_segments_20250310.csv`. See fail sisaldab iga kliendi RFM-skoore ja segmendi. Marko saab selle avada Excelis ja kasutada oma turundusplatvormile laadimiseks. Failinimi sisaldab kuupäeva, nii et vanemaid versioone saab alati üles leida.

Edasijõudnute tasemel saab lisada e-kirja saatmise. Pythoni `smtplib` moodul võimaldab saata e-kirju otse skriptist. Sa saad lisada CSV-faili manusena ja kirjutada HTML-formaadis kokkuvõtte koondstatistikaga. Marko saab siis e-kirja, mis ütleb: "Tere Marko! Selle nädala RFM-analüüsi tulemused: 248 VIP-klienti (kasv +3), 15 uut at-risk klienti, kogutulu viimase 7 päeva jooksul: 18 450 eurot. Detailsed andmed on manuses."

## Hoiatussüsteem: Varude ja Churni Jälgimine

Pipeline ei pea piirduma ainult RFM-iga. Toomas tahab automatiseeritud hoiatusi kahes kriitilises valdkonnas. Esimene on varude hoiatus: kui mõne toote laoseis langeb alla kriitilise piiri, peab Liis Koppel sellest kohe teada saama, sest tühja riiuli tõttu kaotab UrbanStyle müüki. Teine on churni risk ehk klientide kaotuse oht: kui klient pole 60 või enam päeva ostnud, on ta potentsiaalselt kadunud ja Anna Mets saab talle saata re-engagement kampaania.

Mõlemad hoiatused on pipeline-i osad. Sama skript, mis arvutab RFM-skoore, kontrollib ka varusid ja churni riski. See on süsteemne mõtlemine: üks käivitus, mitu väljundit, mitu huvigrupi. Marko saab segmenteerimise, Anna saab turunduslistid, Liis saab varude hoiatused ja Kristi saab koondnumbrid. Kõik ühest käivitusest.

## IT Meeskonna Koolitamine: Rollide Vahetus

Toomase palve on sel nädalal eriline ja emotsionaalselt tähtis: ta tahab, et DataDriven meeskond koolitaks tema IT-meeskonda. See on rollide vahetus. Kaheksa nädalat tagasi olid osalejad algajad, kes õppisid SQL-i põhitõdesid ja kes vajasid pidevalt abi. Nüüd on nad piisavalt kogenud, et õpetada teisi. See on Toomase suurim kompliment: ta usaldab neid oma meeskonna arendamisega.

Toomas kirjeldab oma IT-meeskonda: Jaan on backend-arendaja, kes tunneb Pythonit hästi, aga pole kunagi teinud andmeanalüütikat. Liisa on DevOps-insener, kes tunneb automatiseerimist ja pipeline-e, aga ei tea andmestruktuuridest midagi. Peeter on andmeanalüütik, kes tunneb SQL-i suurepäraselt, aga pole kunagi Pythonit kasutanud. Igaühel on oma tugevus, aga keegi ei näe tervikpilti. DataDriven meeskond peab neile näitama, kuidas SQL, Python ja API-d üheskoos töötavad.

Koolituspakett sisaldab README-d, mis selgitab pipeline-i eesmärki, arhitektuuri ja kasutamist, ning 60-minutilist seminari plaani, mis järgib tuttavat 4C-meetodit. See on väärtuslik oskus: teiste koolitamine tähendab, et sa mõistad teemat sügavalt. Ja see on väärtuslik CV-le: "Designed and delivered Python + API training for IT team."

## Pipeline-i Äriline Mõju

Marko arvutas välja, et manuaalne iganädalane analüüs võtab neli tundi: andmete eksport Supabase'ist (30 min), puhastamine ja ettevalmistamine Excelis (1 tund), RFM-arvutused (1.5 tundi), aruande vormindamine ja saatmine (1 tund). See on neli tundi nädalas ehk umbes 200 tundi aastas. See on ühe inimese peaaegu kuu aega tööaega.

Automatiseeritud pipeline teeb sama töö alla minutiga. Andmete hankimine API kaudu võtab 10 sekundit, töötlemine ja RFM-arvutused 30 sekundit, eksport ja logimine 5 sekundit. Ja see toimub automaatselt, ilma inimese sekkumiseta, iga esmaspäev täpselt kell 9:00.

Aga ajakokkuhoid on ainult üks aspekt. Teine on täpsus ja usaldusväärsus. Manuaalses protsessis on vigu: vale valem Excelis, kogemata kustutatud rida, unustatud filter, kopeerimise viga. Pipeline teeb iga kord sama asja, sama viisil, ilma vigadeta. Usaldusväärsus ei ole 87% nagu manuaalse protsessi puhul, vaid 99.8%.

Kolmas aspekt on skaleeritavus. Kui UrbanStyle kasvab ja neil on 10 000 klienti 2 500 asemel, siis manuaalne protsess muutub võimatuks, aga pipeline skaleerub automaatselt: rohkem andmeid tähendab lihtsalt pikemat töötlusaega, mitte rohkem manuaalset tööd.

Kristi Tamm näeb seda strateegilise eelisena investorite pitchis: "Meie andmeanalüütika on automatiseeritud. Me teame oma numbreid reaalajas. Meie konkurendid teevad käsitsi, meie teeme automaatselt. See on see, mis eristab meid."

## Keskkonna Turvalisus ja Konfigureerimine

Enne kui pipeline käivitatakse, tuleb lahendada üks kriitiline küsimus: turvalisus. Supabase API-key ei tohi kunagi olla otse koodis. See on reegel, mida Toomas rõhutab eriti: "Kui API-key lekib GitHubi, on see nagu maja võtme jätmine uksemati alla. Kõik näevad seda."

Lahendus on `.env`-fail koos `python-dotenv` teegiga. Sa lood `.env`-faili, mis sisaldab `SUPABASE_URL` ja `SUPABASE_KEY` väärtuseid. See fail lisatakse `.gitignore`-sse, nii et see ei jõua kunagi GitHubi. Koodis loed sa väärtuseid: `load_dotenv()` ja `os.getenv("SUPABASE_URL")`. Nii on saladused turvalised.

Aga turvalisus ei piirdu ainult API-võtmetega. Ka väljundfailid võivad sisaldada tundlikke andmeid: klientide nimed, e-postiaadressid, ostusummad. Seega peavad ka `output/` kaust ja logifailid olema `.gitignore`-s. Toomas on selles osas äärmiselt range: "Andmekaitse ei ole valikuline. See on kohustuslik. GDPR kehtib."

Hea tava on luua `.env.example` fail, mis näitab, millised muutujad on vajalikud, aga ei sisalda tegelikke väärtuseid: `SUPABASE_URL=your_url_here` ja `SUPABASE_KEY=your_key_here`. Nii teab iga kolleeg, mida ta vajab, ilma et keegi peaks küsima.

## Tegelaste Reaktsioonid

Sel nädalal toimub oluline pööre iga tegelase jaoks. See on nädal, kus usaldus saavutatakse täielikult.

**Marko** on muutunud passiivsest andmete kasutajast aktiivseks süsteemide nõudjaks. Ta ei rahuldu enam ühekordsete analüüsidega. Ta näeb automatiseerimise potentsiaali ja tahab laiendada: mitte ainult RFM, vaid ka iganädalane müügiraport, churn risk alert, inventory dashboard ja weekly leaderboard. Ta ütleb: "Automatiseerimine pole laiskus. See on skaleeritavus." Tema areng on olnud programmi üks suurimaid üllatusi: tootejuhist on saanud andmejuht.

**Toomas** teeb oma suurima pöörde kogu programmi jooksul. Kogu kümne nädala jooksul on ta olnud skeptiline ja kriitiline, alati küsinud: "Kas see töötab tootmises? Kas see on testitud? Kas see on dokumenteeritud?" Nüüd ta näeb, et DataDriven meeskond vastab kõigile neile küsimustele jaatavalt. Tema palve koolitada IT-meeskonda on täieliku usalduse märk. "Production-grade analytics tähendab automatiseeritud, testitud ja dokumenteeritud. Te olete selle saavutanud." See on Toomase lõplik kinnitus: ta usaldab meeskonda piisavalt, et lasta neil tema enda inimesi koolitada.

**Anna** on kannatamatu, aga positiivselt. Ta on oodanud nädalaid automaatseid segmenteerimisandmeid. Nüüd, kui pipeline on valmis, saab ta lõpuks planeerida personaalseid kampaaniaid VIP-klientidele ja re-engagement kampaaniaid at-risk klientidele. "Esmaspäeval kell 9:00 on minu email inbox-is fresh VIP list! Ma saan kohe alustada!" Anna näeb kohe praktilist väärtust: iga automatiseeritud raport on üks turunduskampaania võimalus.

**Kristi** näeb suurt pilti. Automatiseerimine ei ole lihtsalt mugavus, see on konkurentsieelis. Investorite pitchis saab ta öelda: "Meie andmeanalüütika on automatiseeritud. Me teame oma numbreid reaalajas." See on argument, mis eristab UrbanStyle'i konkurentidest, kes teevad ikka käsitsi. Kristi on kogu programmi jooksul kasvanud intuitiivne juhist andmepõhise juhiks ja see nädal on selle transformatsiooni kinnitus.

## Kokkuvõte

Sel nädalal sa ei kirjutanud lihtsalt koodi. Sa ehitasid süsteemi, mis töötab sinu eest. See on oluline erinevus: kood on ühekordne, süsteem on pidev. Marko saab oma iganädalase VIP-listi, Toomas saab oma varude hoiatused, Anna saab turundussegmendid ja Kristi saab reaalajas numbrid. Ja sina said kogemuse, mis eristab sind teistest andmeanalüütiku kandidaatidest: sa ei oska ainult analüüsida, vaid ka automatiseerida.

See nädal oli pöördepunkt: sa oled muutunud analüütikust inseneriks. Ja see on oskus, mida tööandjad hindavad kõrgelt, sest see tähendab, et sa lood püsivat väärtust, mitte ainult ühekordseid raporteid.

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist. Optimeeritud NotebookLM audio genereerimiseks.*

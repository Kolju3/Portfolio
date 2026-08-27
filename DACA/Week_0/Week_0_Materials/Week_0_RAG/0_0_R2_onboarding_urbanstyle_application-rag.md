# UrbanStyle'i Esimene Päev: Andmekaosest Esimese Päringuni

## Sissejuhatus

Kujuta ette, et sa astud esimest korda UrbanStyle.ltd kontorisse Tallinna Rotermanni kvartalis. Kristi Tamm, tegevjuht, tervitab sind ja ütleb: "Tere tulemast! Meil on suur ambitsioon, aga meie andmed on kaoses. Te olete meie võti tulevikku." Toomas Kask, IT direktor, seisab kõrval ja lisab: "Enne kui midagi analüüsida, peame andmed korda tegema."

See on sinu lähtekoht DACA programmis. Sa ei alusta tühja koha pealt ega teoreelliste harjutustega. Sa alustad päris ettevõtte päris probleemidega. Selles dokumendis vaatame, millised on UrbanStyle'i konkreetsed andmeprobleemid, kuidas sa oma töökeskkonna üles sead ja milline näeb välja sinu esimene kontakt andmebaasiga.

---

## UrbanStyle'i Andmeprobleemid: Mida Sa Leiad

Kui sa avad UrbanStyle'i andmebaasi, avastad kiiresti, et ettevõtte andmed ei ole kaugeltki korras. Toomas Kask on tuvastanud mitu kriitilist probleemi ja sa kohtud nendega juba esimesel nädalal.

Esimene probleem on duplikaadid. Sama klient võib olla andmebaasis mitu korda, erinevate nimedega ja erinevate e-mailiaadressidega. Näiteks on üks klient kirjas nii "Maria Tamm" kui "M. Tamm" ning tema e-mail on kord maria.tamm@gmail.com ja kord mariatamm@gmail.com. Müügitabelis on üle 5000 duplikeeritud rea, mis tähendab, et müügiaruanded näitavad suuremaid numbreid kui tegelikkus.

Teine probleem on NULL väärtused ehk puuduvad andmed. Paljude klientide e-mailid on tühjad, mõnel tootel puudub hind ja varude tabelis on kirjeid, mida pole kuid uuendatud. NULL ei ole sama mis null. NULL tähendab, et andmed lihtsalt puuduvad. See on nagu tühi koht tabelis, kust keegi unustas info sisestada.

Kolmas probleem on ebakonsistentsus. Toote hinnad ei klapi alati müügitabeli ja tootetabeli vahel. Kuupäevad on mõnikord vales formaadis ja veebikülastuste logides on anomaalseid kirjeid, nagu 0-sekundilised sessioonid.

Need probleemid ei ole juhuslikud. Need on tahtlikult andmebaasi sisse ehitatud, et õpetada sulle andmepuhastust ja kvaliteedikontrolli. Päris maailmas näed sa täpselt samu probleeme igas ettevõttes.

---

## Supabase'i Seadistamine: Sinu Andmebaasi Kodu

Supabase on pilveplatvorm, kus asub PostgreSQL andmebaas, ja see on sinu peamine töökeskkond DACA programmis. Supabase on sada protsenti tasuta meie kasutuse jaoks ja see annab sulle juurdepääsu professionaalsele andmebaasile ilma keerulise installeerimiseta.

Seadistamine on lihtne. Sa lood konto supabase.com lehel, kasutades oma GitHub kontot. Siis lood uue projekti nimega urbanstyle-datadriven ja valid regiooni eu-central-1, mis asub Frankfurdis ja on meile Euroopas kõige kiirem. Andmebaasi salasõna tuleb kindlasti turvaliselt salvestada, näiteks paroolihaldurisse. Ära kunagi pane salasõna GitHubi!

Kui projekt on loodud, avad SQL Editori, mis on vasakul menüüs. See on koht, kus sa kirjutad SQL päringuid. See näeb välja nagu lihtne tekstiredaktor, kuhu sa kirjutad päringu ja vajutad rohelist "Run" nuppu. Tulemus ilmub alla tabelina.

Proovi oma esimest päringut. Kirjuta SQL Editorisse:

```sql
SELECT 'Tere, UrbanStyle!' AS tervitus, NOW() AS aeg;
```

Vajuta "Run". Sa näed tabelit ühe rea ja kahe veeruga: tervitus ja aeg. See on sinu esimene andmepäring. Lihtne, aga see on algus.

---

## GitHubi Portfoolio: Sinu Professionaalne Vitriinkapp

GitHub on koht, kus sa hoiad kogu oma tööd. Mõtle sellele kui digitaalsele portfooliokaustale, mis on avalik ja mida tööandjad saavad vaadata. Iga nädal lisad sinna uue projekti ja programmi lõpuks on sul muljetavaldav kogu.

Esimene samm on luua oma GitHub konto ja seejärel repository nimega daca-portfolio. See on sinu peamine kaust, kuhu kõik läheb. Repository peab olema public ehk avalik, sest see on sinu portfoolio, mida tööandjad näevad.

Esimene fail, mille sa lood, on README.md. See on Markdown formaadis fail, mis kirjeldab sinu portfooliot. Sa kirjutad sinna oma nime, lühikese tutvustuse, DACA programmi eesmärgi ja mida sa loodad õppida. See on nagu su portfoolio kaaneleht.

Siis teed oma esimese commit'i. Commit on nagu salvestusnupp, mis fikseerib sinu töö hetkeseisu. Iga commit'iga lisad selge sõnumi, mis kirjeldab, mida sa muutsid. Näiteks "Add README with personal introduction". See on oluline harjumus, sest päris andmeanalüütiku töös pead sa alati dokumenteerima, mida ja miks sa tegid.

Portfoolio struktuur kasvab iga nädalaga:

```
daca-portfolio/
├── README.md              ← Portfoolio ülevaade
├── week-1/individual/     ← Sinu SQL päringud
├── week-2/individual/     ← Andmete puhastamine
├── ...
└── week-10/individual/    ← Lõpuprojekt
```

Programmi lõpuks on sul 8 kuni 10 projekti, mis näitavad SQL oskusi, andmete puhastamist, visualiseerimist ja äriarusaamist. See on sinu CV.

---

## Esimene Pilk Andmetele: UrbanStyle'i Tabelid

Kui sa avad UrbanStyle'i andmebaasi, leiad sealt mitu tabelit. Need on UrbanStyle'i äriandmete digitaalne peegeldus ja iga tabel vastab ühele äriprotsessile.

Müügitabel ehk sales sisaldab kõiki müügitehinguid. Iga rida on üks müügitehing: millal see toimus, kes ostis, mida ostis, kui palju maksis ja kas tehing toimus veebis või poes. Selles tabelis on üle 15 000 rea ja nagu Toomas avastanud, ka üle 5000 duplikaadi.

Klientide tabel ehk customers sisaldab infot UrbanStyle'i klientide kohta: nimi, e-mail, telefon, linn, registreerimise kuupäev ja lojaalsuse tase. Lojaalsuse tasemed on bronze, silver ja gold. Aga paljudel klientidel on e-mail tühi ja mõned kliendid on kirjas mitu korda.

Toodete tabel ehk products kirjeldab kõiki tooteid, mida UrbanStyle müüb. Seal on toote nimi, kategooria nagu naiste riided, aksessuaarid ja meeste riided, tarnija, soetusmaksumus, jaemüügi hind ja kas toode on jätkusuutlikkuse sertifikaadiga ehk eco_certified.

Varude tabel ehk inventory näitab, kui palju iga toodet on igas asukohas. Asukohad on Tallinn, Tartu, Pärnu ja ladu. Aga paljud kirjed on aegunud ja varude numbrid ei pruugi vastata tegelikkusele.

Veebikülastuste tabel ehk web_logs logib kõiki e-poe külastusi. Iga kirje näitab, kes külastas, millal, millist lehte vaatas, millise seadmega ja kui kaua viibis. Aga logides on lünki ja anomaalseid kirjeid.

---

## Kristi Tamm ja Tema Visioon

Kristi Tamm on UrbanStyle'i asutaja ja tegevjuht. Ta on 38-aastane strateegiline mõtleja, kes asutas ettevõtte 2020. aasta kevadel, keset COVID-19 pandeemiat. Ta nägi võimalust Eesti moeturul ja otsustas luua brändi, mis ühendab kaasaegse disaini ja jätkusuutlikkuse.

Kristi visioon on selge: ta tahab, et UrbanStyle saaks Balti juhtivaks jätkusuutliku moe brändiks. Aga selle saavutamiseks vajab ta andmepõhiseid otsuseid. Praegu teeb ta paljud otsused kõhutunde järgi ja see ei ole jätkusuutlik.

Investorite kohtumine on 10 nädala pärast. See on täpselt DACA programmi pikkus. Investorid tahavad näha täpseid müügitrende kuude, kanalite ja toodete kaupa, klientide segmentatsiooni ja lojaalsuse analüüsi, turunduse ROI't, varude käibekordajat ja prognoose tuleviku kohta.

Kristi kommunikatsioonistiil on otsene ja konkreetne. Ta eelistab lühidust, maksimum 3 kuni 5 minutit presentatsioonideks. Ta tahab näha graafikuid ja numbreid, mitte pikki tekste. Ja ta tahab soovitusi, mitte ainult fakte. "Mida ma peaksin selle info põhjal tegema?" on tema lemmikküsimus.

---

## Toomas Kask ja IT Infrastruktuuri Väljakutsed

Toomas Kask on UrbanStyle'i IT direktor. Ta on 42-aastane ja konservatiivne, eelistab dokumentatsiooni ja süsteemset lähenemist. Ta on olnud pisut skeptiline uue DataDriven meeskonna suhtes, aga ta mõistab, et abi on vaja.

Toomas on see inimene, kes teab kõige paremini, kui halvasti andmetega tegelikult on. Tema on tuvastanud need 5000+ duplikaati müügitabelis, puuduvad e-mailid klientide tabelis ja ebakonsistentsed hinnad. Ta on proovinud probleeme üksi lahendada, aga andmemaht on liiga suur ja tal pole piisavalt aega.

Toomas suhtleb formaalselt ja ootab sama teistelt. Ta tahab detailset dokumentatsiooni, täpseid numbreid ja selgeid selgitusi. Kui sa esitad talle tulemusi, pane kõik kirja: mitu rida, millised veerud, millised probleemid. Ära ütle "paljud" -- ütle "234 rida" või "15,3 protsenti".

Nädala 0 lõpus ütleb Toomas: "Hea algus. Nüüd kui teil on tööriistad paigas, saame järgmisel nädalal päriselt andmetega tööle hakata. Valmistuge, meie sales tabel ootab teid."

---

## NotebookLM Seadistamine: Sinu AI Õppekaaslane

Nädala 0 oluline osa on NotebookLM notebook'i seadistamine. Sa avad notebooklm.google.com, logid sisse Google kontoga ja lood uue notebook'i.

Esimene samm on 4 CORE RAG faili üles laadimine. Need failid sisaldavad UrbanStyle'i ettevõtte profiili, tegelaste kirjeldusi, DACA programmi raamistikku ja tööriistade juhendit. Kui need on üles laetud, on NotebookLM nende teemade ekspert.

Proovi genereerida Audio Overview. NotebookLM loob 5 kuni 15 minutilise podcasti, kus kaks AI vestlejat arutavad sinu materjalide sisu. See on suurepärane viis materjali kuulata autoga sõites või jalutades.

Küsi NotebookLM-ilt küsimusi nagu "Kes on Toomas Kask ja mis on tema roll UrbanStyle'is?" või "Mis on DACA programmi 4 komponenti?" Vastused tulevad sinu materjalide põhjal, mitte AI üldistest teadmistest. See on RAG'i tugevus: AI otsib vastuse üles ja tsiteerib allikat, mitte ei mõtle välja.

Iga nädal lisad 2 uut RAG faili ja sinu AI õppekaaslane muutub järjest targemaks. Nädala 10 lõpuks on tal 26 faili ja ta teab kõike, mida sa oled programmi jooksul õppinud.

---

## Esimene Meeskonnatöö: Töökeskkonna Seadistamine

Nädala 0 teine sessioon on grupitöö, kus moodustatakse meeskonnad ja tehakse esimene ühisülesanne. Iga meeskond saab UrbanStyle.ltd osakonna nime: Sales Analytics, Customer Insights, Operations Intelligence, Marketing Data, Product Analytics või Executive Reporting.

Meeskond jagab rollid: üks seadistab GitHub repo, teine Supabase projekti, kolmas NotebookLM notebook'i ja neljas koostab Team Charter'i. Igaüks töötab oma ülesandega ja siis näitate üksteisele tulemusi. See on esimene kokkupuude JAGA-TEE-KOGU-ESITLE mustriga, mida kasutate kogu programmi jooksul.

Toomas Kask annab meeskonnale esimese väljakutse: "Iga meeskonnaliige seadistab ühe tööriista ja seejärel näitate üksteisele, kuidas see töötab. Mina ootan teie esimest raportit!"

---

## Kokkuvõte: Su Esimene Nädal UrbanStyle'is

Nädala 0 lõpuks on sul kõik tööriistad paigas ja sa oled valmis päriselt andmetega tööle hakkama. Sul on toimiv GitHub konto esimese commit'iga, Supabase projekt ühendatud andmebaasiga, Power BI või Python seadistatud ja NotebookLM notebook CORE RAG failidega.

Sa tead nüüd, et UrbanStyle on kiiresti kasvav moeettevõte, mille andmed on kaoses. Sa tead, et Kristi vajab andmepõhist äriplaani investoritele ja Toomas vajab abi andmete korrastamisel. Sa tead, millised tabelid andmebaasis on ja millised probleemid seal varitsevad.

Järgmisel nädalal saadab Toomas sulle e-maili pealkirjaga "URGENT - Sales tabeli probleem". Ta on avastandud, et müügitabelis on üle 5000 duplikaadi ja ta vajab sinu abi. Sa hakkad kirjutama päris SQL päringuid päris andmetega. Valmis?

---

*See dokument on osa DACA andmeanalüütiku kiirendi õppematerjalist ja on optimeeritud NotebookLM audio genereerimiseks.*

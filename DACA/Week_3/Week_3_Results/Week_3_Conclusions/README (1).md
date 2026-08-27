# Nädal 3 – SQL JOINid

**Autor:** Kalju  
**Roll:** Roll D – müügikanalite ja kliendilinnade analüüs  
**Töökeskkond:** Supabase / PostgreSQL  

## Ülesanne

UrbanStyle.ltd müügi-, kliendi- ja tooteandmed paiknesid eri tabelites. Minu ülesanne oli kasutada SQL JOIN-lauseid, et analüüsida:

- müügi ja käibe jaotust müügikohtade vahel;
- klientide linnade ja ostukohtade seoseid;
- tootekategooriate osakaalu kliendiga seotud müügis;
- kliendiandmetega seostamata tehinguid.

## Kasutatud SQL-võtted

- `INNER JOIN`
- tabelite aliased
- `COUNT()` ja `COUNT(DISTINCT ...)`
- `SUM()`
- `GROUP BY`
- CTE-d ja aknafunktsioonid
- `NULLIF()` ja `ROLLUP`

## Peamised tulemused

| Näitaja | Tulemus |
|---|---:|
| Müügitehinguid kokku | 10 118 |
| Müügikäive kokku | 2 898 513,90 € |
| Suurim müügikoht | Tallinn |
| Suuruselt teine kanal | Online |
| Kliendiga seostamata tehinguid | 984 ehk 9,73% |
| Suurim tootekategooria | Jalanõud |

Tallinn ja online-kanal annavad kokku üle 72% tehingutest ja käibest. Ligikaudu kümnendikku müügist ei saa kliendiandmetega seostada. Analüüs näitas ka, et kliendi linn ei määra üheselt ostukohta: näiteks Tartu kliendid tegid rohkem oste Tallinna kauplusest ja online-kanalist kui Tartu kauplusest.

## Soovitused

- parandada kliendi tuvastamist müügiprotsessis;
- hoida turunduse põhifookus Tallinnal ja online-kanalil;
- uurida Pärnu madalama keskmise tehingu põhjuseid;
- valideerida kliendi linna ja ostukoha ristostmise muster;
- lisada järgmises analüüsis ajamõõde.

## Failid

- [Detailne analüüs](./Week_3_Detailanalysis.md)
- [SQL-koodi kaust](./Week_3_Code/)
- [Tulemuste kaust](./Week_3_Results/)
- [Week3_results.xlsx](./Week_3_Results/Week3_results.xlsx)
- [Analyze for Anna](./Week_3_Results/Analyze%20for%20Anna)
- [Nädal 3 grupitöö README ja esitlus](https://github.com/Kolju3/DACA-group/tree/main/week-3/group)

## Õpikogemus

Nädala keskne õppetund oli, et JOIN ei ole ainult tabelite tehniline ühendamine. Selle abil muutuvad tabelites olevad ID-d inimesteks, toodeteks, asukohtadeks ja otsuseid toetavaks infoks.

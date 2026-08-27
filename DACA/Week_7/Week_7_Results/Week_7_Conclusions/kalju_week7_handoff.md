# Week 7 — kiire tööülevaade Kaljule

## Mis on valmis?

- Roll A laadib Supabase'ist kõik read 1000 rea kaupa.
- Laaditi 10 118 müügirida ja 3 150 kliendirida.
- Roll B puhastas ühendatud andmestiku 8 950 reani.
- Roll C koostas 2 540 kliendiga RFM-tabeli.
- RFM-tulemused on failis `week-7/group/rfm_segments.csv`.
- Roll D visualiseeringud ja lõplik äritõlgendus on veel puudu.

## Peamised tulemused

| Segment | Kliente | Osakaal | Kogukulutuse osakaal |
|---|---:|---:|---:|
| VIP Champions | 455 | 17,91% | 42,82% |
| Loyal | 679 | 26,73% | 29,75% |
| Potential | 759 | 29,88% | 19,49% |
| At Risk | 529 | 20,83% | 7,18% |
| Lost | 118 | 4,65% | 0,76% |

VIP + Loyal moodustavad 44,65% klientidest ja 72,57% analüüsitud kogukulutusest.

## Mida Roll D-s teha?

1. Segmentide jaotuse tulpdiagramm.
2. Recency–Monetary hajuvusdiagramm:
   - X = `recency_days`
   - Y = `monetary_value`
   - värv = `Segment`
   - suurus = `frequency`
3. TOP 10 VIP-klienti `monetary_value` järgi.
4. KPI-d:
   - 2 540 klienti;
   - 455 VIP-klienti;
   - VIP osakaal 17,91%;
   - VIP kogukulutus 1 146 295,15 €;
   - VIP käibeosakaal 42,82%;
   - 529 At Risk klienti.

## Enne lõplikku visualiseerimist

Notebook kasutab RFM-viitekuupäeva `2025-02-28`, aga andmed ulatuvad `2026-06-28`-ni. CSV-s on 25 negatiivse Recency väärtusega klienti. Meeskonnal tuleb enne lõppgraafikuid kinnitada, kas:

- viitekuupäev viiakse andmestiku lõpust ühe päeva võrra edasi; või
- pärast 2025-02-28 olevad müügid loetakse vigasteks ja eemaldatakse.

Praeguste segmentide põhiloos kasuta veergu `Segment`, mitte `Advanced_Segment`, et vältida kahe segmentatsiooniloogika segamist.

## Esialgne äriline sõnum

VIP-klientide hoidmine on esimene prioriteet. Loyal- ja Potential-klientide puhul on suurim võimalus kasvatada lojaalsust. At Risk on arvukas, kuid praeguse jaotuse järgi madalama rahalise osakaaluga, seega tasub win-back tegevus suunata eelkõige kõrgema väärtusega klientidele.

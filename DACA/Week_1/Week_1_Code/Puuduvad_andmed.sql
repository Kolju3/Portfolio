SELECT COUNT (*) - COUNT (first_name) AS "Puuduvad_eesnimed", --SELECT valib siin kõik klientide read ja siis lahutab neist maha kõik, kellel on eesnimi, et saada puuduvate eesnimede arv.
         COUNT (*) - COUNT (last_name) AS "Puuduvad_perekonnanimed", --SELECT valib siin kõik klientide read ja siis lahutab neist maha kõik, kellel on perekonnanimi, et saada puuduvate perekonnanimede arv.
         COUNT (*) - COUNT (email) AS "Puuduvad_emailid" --SELECT valib siin kõik klientide read ja siis lahutab neist maha kõik, kellel on email, et saada puuduvate emailide arv.
FROM "Customers";

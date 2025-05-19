Listázzuk ki a vendégek felhasználónevét, és e-mail címét!

Csak azok kerüljenek be a listába, akiknek az e-mail címe biztosan meg van adva
Egy új oszlopban adjuk meg az email-cím hosszát
Egy másik új oszlopban adjuk meg, hogy hány éves a vendég

SELECT USERNEV,EMAIL,
LEN(EMAIL) AS 'Emailcím hossza',
DATEDIFF(YEAR, SZUL_DAT, GETDATE()) AS 'Vendég életkora'
FROM Vendeg
--WHERE IS NOT NULL
WHERE EMAIL LIKE '%@%'


Listázzuk, hogy melyik szálláshelynek összesen hány vendége volt!

Csak azokat a szálláshelyeket vegyük figyelembe, ahol a szálláshely legalább 3 csillagos!

SELECT sz.SZALLAS_NEV,
SUM(f.FELNOTT_SZAM + f.GYERMEK_SZAM) AS 'Vendégek száma'
FROM Foglalas f JOIN Szoba ON f.SZOBA_FK = SZOBA.SZOBA_ID JOIN Szallashely sz ON SZOBA.SZALLAS_FK = sz.SZALLAS_ID
-- F 
WHERE sz.CSILLAGOK_SZAMA >= 3
GROUP BY sz.SZALLAS_NEV


Listázd ki a vendégek nevét, e-mail címét, a szállás nevét, és hány napra szól a foglalás!

Szűrjünk a legalább 3 napos, de 5 napnál rövidebb foglalásokra!

SELECT v.NEV, v.EMAIL, 
sz.SZALLAS_NEV, 
DATEDIFF(DAY, f.METTOL, f.MEDDIG) AS 'Hány napra'
FROM Vendeg v JOIN Foglalas f on v.USERNEV = f.UGYFEL_FK JOIN SZOBA ON f.SZOBA_FK = SZOBA.SZOBA_ID JOIN Szallashely sz ON SZOBA.SZALLAS_FK = sz.SZALLAS_ID
WHERE DATEDIFF(DAY, f.METTOL, f.MEDDIG) BETWEEN 3 AND 5




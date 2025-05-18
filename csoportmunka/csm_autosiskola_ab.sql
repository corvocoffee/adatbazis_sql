--1. AB, Táblák létrehozása
--CREATE DATABASE autosiskola;

--USE autosiskola; GO

CREATE TABLE AUTOK(
    RENDSZAM VARCHAR(8) NOT NULL,
    AUTO_ID NUMERIC(3) PRIMARY KEY,
    TIPUS VARCHAR(64),
    EV VARCHAR(4),
    TELEPHELY VARCHAR(64)
);

CREATE TABLE OKTATOK(
    OKTATO_ID NUMERIC(3) PRIMARY KEY,
    OKTATO_NEV VARCHAR(64) NOT NULL,
    SZUL_DATUM DATE NOT NULL,
    IG_SZAM VARCHAR(32) NOT NULL UNIQUE, 
    TELSZAM VARCHAR(32) NOT NULL,
    EMAIL VARCHAR(64) CHECK (EMAIL LIKE '%@%'),
    AUTO_ID NUMERIC(3) NOT NULL 
    CONSTRAINT FK_OKTATOK_AUTOK FOREIGN KEY (AUTO_ID) REFERENCES AUTOK(AUTO_ID)  
    
);

CREATE TABLE TANULOK (
    TANULO_ID NUMERIC(10) PRIMARY KEY IDENTITY(1,1),
    TANULO_NEV VARCHAR(64) NOT NULL,
    SZUL_DATUM DATE NOT NULL,
    IG_SZAM VARCHAR(32)NOT NULL UNIQUE, 
    TELSZAM VARCHAR(32) NOT NULL,
    EMAIL VARCHAR(64) CHECK (EMAIL LIKE '%@%'),
    BEIRATKOZAS_DATUM DATE DEFAULT GETDATE(),
    OKTATO_ID NUMERIC(3, 0) 
    CONSTRAINT FK_TANULOK_OKTATOK FOREIGN KEY (OKTATO_ID) REFERENCES OKTATOK(OKTATO_ID),
    KRESZ_STATUSZ BIT DEFAULT 0,
    EU_STATUSZ BIT DEFAULT 0,
    VETT_ORAK INT DEFAULT 0,
    JOGOSITVANY VARCHAR(32)
);

CREATE TABLE ARLISTA(
    TETEL_ID NUMERIC(3) NOT NULL PRIMARY KEY,
    TETEL_NEV VARCHAR(64) NOT NULL,
    AR NUMERIC(11,3) NOT NULL
);

CREATE TABLE FIZETESEK(
    TRANZAKCIO_ID NUMERIC(12) PRIMARY KEY IDENTITY(1,1),
    TANULO_ID NUMERIC(10, 0) NOT NULL 
    CONSTRAINT FK_FIZETESEK_TANULOK FOREIGN KEY (TANULO_ID) REFERENCES TANULOK(TANULO_ID),
    TRANZAKCIO_DATUM DATE DEFAULT GETDATE(),
    TETEL_ID NUMERIC(3, 0) NOT NULL REFERENCES ARLISTA(TETEL_ID),
    FIZ_OSSZEG NUMERIC(11, 3) NOT NULL
);

/*DELETE FROM FIZETESEK;
DELETE FROM TANULOK;
DELETE FROM OKTATOK;
DELETE FROM AUTOK;
DELETE FROM ARLISTA;*/ 


INSERT INTO AUTOK(RENDSZAM, AUTO_ID, TIPUS, EV, TELEPHELY)
VALUES
    ('SQL-123', '1', 'TOYOTA YARIS 1.3 Sol', '2007', 'A'),
    ('DBS-123', '2', 'RENAULT CLIO 1.5 dCi Energy Intens S&S', '2014', 'B'),
    ('SQL-999', '3', 'RENAULT CLIO 1.4 16V RT', '2000', 'B');

INSERT INTO OKTATOK(OKTATO_ID, OKTATO_NEV, SZUL_DATUM, IG_SZAM, TELSZAM, EMAIL, AUTO_ID)
VALUES
    ('1', 'Nagy Kristóf Károly', '1970-10-02', 'DACFHS12', '+36302145990', 'nagykristofvezetes@gmail.co ', '2'),
    ('2', 'Füredi István', '1982-03-04', 'HALISA23', '+36209023512', 'istvanfuredi@freemail.hu', '3'),
    ('3', 'Lovász Mihály', '1972-05-06', 'HJLOSQ11', '+36704412317', 'lovaszm.autossuli@gmail.com', '1');

INSERT INTO TANULOK (TANULO_NEV, SZUL_DATUM, IG_SZAM, TELSZAM, EMAIL, BEIRATKOZAS_DATUM, OKTATO_ID, KRESZ_STATUSZ, EU_STATUSZ, VETT_ORAK, JOGOSITVANY)

VALUES
('Nagy Anna', '2000-02-23', 'ABCDEF12', '+36200247819', 'annaanna@freemail.hu', '2023-03-02', '1','1', '1', '55', 'Jogosítványt szerzett'),
('Kiss Anett', '2002-03-01', 'FACGBS34', '+36305491423', 'anettka3@gmail.com', '2023-03-12', '2', '1', '1', '70', 'Jogosítványt szerzett'),
('Nagy Géza', '2005-11-01', 'TGHJKKO23', '+36700241578', 'gezafiok@freemail.hu', '2023-05-01', '1', '1', '1', '61', 'Jogosítványt szerzett'),
('Erdei Karolina', '1998-10-08', 'FSCWTE56', '+36206563261', 'ekarolina@gmail.com', '2023-05-09', '3','1', '1', '45', 'Jogosítványt szerzett'),
('Márkus Ádám', '1985-01-01', 'RETFDA22', '+36307765489','azadammarkus@freemail.hu',  '2023-08-23', '3', '1', '1', '100', 'Jogosítványt szerzett'),
('Tiszai Boglárka', '2004-04-02', 'LOKJUZ44', '+36205243679', 'tiszaibog134@gmail.com', '2024-03-29', '2','1', '1', '83', 'Jogosítványt szerzett'),
('Szücs Máté Bence', '1999-09-01', 'GFVDBH23', '+36300134785', 'szucsmbence@gmail.com', '2024-04-27', '1', '1', '1', '82', 'Jogosítványt szerzett'),
('Németh Sámuel', '1989-02-03', 'HNCXYA54', '+36205270561', 'nemethsamu89@gmail.com', '2024-08-22', '1', '1', '1', '23', ''),
('Földi Mátyás László', '1994-11-28', 'FSNIUO51', '+36700213568', 'foldimatyi1234@gmail.com', '2024-11-02', '3', '1', '0', '42', ''),
('Kovács Péter István', '2000-05-04', 'GDNALO83', '+36209898765', 'petiistipisti@gmail.com', '2025-01-01', '3', '0', '1', '0', ''),
('Pusztai Imola Katalin', '2003-03-27', 'GDNSMI21', '+36204231335', 'pimolapimola@gmail.com', '2025-02-28', '2', '0', '0', '0', ''),
('Vásárhelyi Csenge', '2006-07-17', 'GDNSLO27', '+36201245769', 'csenge.vasarhelyi@gmail.com', '2025-03-14', '1', '1', '0', '0', '' );

INSERT INTO ARLISTA(TETEL_ID, TETEL_NEV, AR)
VALUES
    ('1', 'Kresz tanfolyam', '42000'),
    ('2', 'Kresz vizsga', '4600'),
    ('3', 'Eü. tanfolyam', '16000'),
    ('4', 'Eü. vizsga', '12000'),
    ('5', 'Vezetési óra', '8500'),
    ('6', 'Forgalmi vizsga', '11000');

SELECT TANULO_ID FROM TANULOK;

INSERT INTO FIZETESEK(TANULO_ID, TRANZAKCIO_DATUM, TETEL_ID, FIZ_OSSZEG)
--néhány frissebb tranzakció
VALUES
('6', '2024-01-05', '5', '25500'),
('8', '2025-01-07', '5', '85000'),
('9', '2025-02-01', '5', '85000'),
('11', '2025-03-03', '1', '42000'),
('11', '2025-03-03', '2', '4600'),
('9', '2025-03-09', '5', '17000'),
('11', '2025-03-10', '3', '16000'),
('8', '2025-03-12', '3', '12000'),
('12', '2025-03-14', '1', '42000'),
('11', '2025-03-31', '4', '12000'),
('12', '2025-04-02', '2', '4600')


--3. Lekérdezések

--1. Átlagosan hány óra vételére van szükség ahhoz, hogy egy diák átmenjen a forgalmi vizsgán? Hogyan változik ez az adat telephelyenként, oktatónként?

SELECT COALESCE(a.TELEPHELY, 'Összesen') AS 'Telephely', COALESCE(o.OKTATO_NEV, 'Összesen') AS 'Oktató', AVG(t.VETT_ORAK) AS "Vett órák átlagos száma"
FROM AUTOK a join OKTATOK o on a.AUTO_ID = o.AUTO_ID join TANULOK t ON o.OKTATO_ID = t.OKTATO_ID 
WHERE t.JOGOSITVANY = 'Jogosítványt szerzett'
GROUP BY ROLLUP (a.TELEPHELY, o.OKTATO_NEV)


--2. Minimum mennyibe kerul az jogosítvány megszerzése ebben az autosiskolában, ha 40 órát kell venni a vizsgához?

SELECT CAST(
            SUM(CASE
                    WHEN TETEL_NEV = 'Vezetési óra' THEN AR * 40
                    ELSE AR
                    END)
            AS VARCHAR) + 'Ft' AS 'A jogosítványszerzés minimális költsége'

FROM ARLISTA 


--3. Az oktatók a vezetési órák díjának 67%-át kapják meg. Mennyit kerestek az itt látható diákok óráiból?

SELECT o.OKTATO_NEV, SUM(t.VETT_ORAK) * (SELECT ar.AR FROM ARLISTA ar WHERE ar.TETEL_NEV = 'Vezetési óra') * 0.67 AS 'Kifizetés oktatóknak'
FROM OKTATOK o JOIN TANULOK t ON o.OKTATO_ID = t.OKTATO_ID 
GROUP BY o.OKTATO_NEV

--4. Milyen rendszámú autóval vezet a legtöbb diák?

SELECT TOP 1 a.RENDSZAM,
COUNT(t.TANULO_ID) AS 'Tanulók száma'
FROM TANULOK t
JOIN OKTATOK O ON t.OKTATO_ID =o.OKTATO_ID JOIN AUTOK a ON o.AUTO_ID = a.AUTO_ID
GROUP BY a.RENDSZAM
ORDER BY 'Tanulók száma' DESC


--5. Azok a tanulók, akik még nem kaptak jogosítványt mennyi pénzt fizettek be az autósiskolának, és ez az általuk befizetendő minimális összeg hány százaléka?

SELECT 
t.TANULO_NEV AS 'Tanuló',
CAST(SUM(f.FIZ_OSSZEG) AS VARCHAR) + 'Ft' AS 'Befizetett összeg',
CAST(SUM(f.FIZ_OSSZEG) / 426500 *100 AS VARCHAR) + '%' AS 'Várt teljes összeg százaléka'
FROM TANULOK t JOIN FIZETESEK f ON t.TANULO_ID = F.TANULO_ID JOIN ARLISTA ar on f.TETEL_ID = ar.TETEL_ID
WHERE t.JOGOSITVANY = ''
GROUP BY t.TANULO_NEV

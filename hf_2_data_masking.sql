--UGYFEL tabla
--EMAIL email masking
--LOGIN, NEV partial
--SZULEV random

CREATE TABLE UGYFEL_MASKED (
    LOGIN VARCHAR(32) MASKED WITH (FUNCTION = 'partial(1, "xxx", 1)'),   
    EMAIL VARCHAR(64) MASKED WITH (FUNCTION = 'email()'),                
    NEV VARCHAR(64) MASKED WITH (FUNCTION = 'partial(2, "xxx", 2)'),                                                     
    SZULEV NUMERIC(4) MASKED WITH (FUNCTION = 'random(1900, 9999)'),    
    NEM VARCHAR(1),                                                      
);

INSERT INTO UGYFEL_MASKED (LOGIN, EMAIL, NEV, SZULNEV, NEM, CIM)
SELECT LOGIN, EMAIL, NEV, SZULNEV, NEM, CIM
FROM UGYFEL;

CREATE USER masked_user WITHOUT LOGIN;
GRANT SELECT ON UGYFEL_MASKED TO masked_user;

--SELECT * FROM UGYFEL_MASKED

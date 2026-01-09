CREATE TABLE tblValues(Val int)

INSERT INTO tblValues(val) VALUES(100)
INSERT INTO tblValues(val) VALUES(200)
INSERT INTO tblValues(val) VALUES(null)
INSERT INTO tblValues(val) VALUES('')

SELECT * FROM tblValues

SELECT AVG(VAL) FROM tblValues


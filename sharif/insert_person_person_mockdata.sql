-- Mock data inserts for Person.Person (50 rows)
-- Columns: PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate
SET NOCOUNT ON;
BEGIN TRANSACTION;

INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, 'Mr.', 'John1', 'A.', 'Smith', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, 'Ms.', 'Jane2', 'B.', 'Johnson', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Michael3', 'C.', 'Williams', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 1, NULL, 'Mary4', 'D.', 'Brown', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, 'Dr.', 'Robert5', 'E.', 'Jones', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Patricia6', 'F.', 'Garcia', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'William7', 'G.', 'Miller', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 1, 'Mrs.', 'Linda8', 'H.', 'Davis', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'David9', 'I.', 'Rodriguez', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Barbara10', 'J.', 'Martinez', NULL, 1, NEWID(), GETDATE());

INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, 'Mr.', 'Richard11', 'K.', 'Hernandez', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Susan12', 'L.', 'Lopez', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Joseph13', 'M.', 'Gonzalez', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 1, NULL, 'Karen14', 'N.', 'Wilson', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, 'Dr.', 'Thomas15', 'O.', 'Anderson', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Nancy16', 'P.', 'Thomas', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Charles17', 'Q.', 'Taylor', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 1, NULL, 'Lisa18', 'R.', 'Moore', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Christopher19', 'S.', 'Jackson', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Margaret20', 'T.', 'Martin', NULL, 2, NEWID(), GETDATE());

INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Daniel21', 'U.', 'Lee', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, 'Ms.', 'Betty22', 'V.', 'Perez', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Matthew23', 'W.', 'Thompson', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 1, NULL, 'Sandra24', 'X.', 'White', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, 'Mr.', 'Anthony25', 'Y.', 'Harris', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Donna26', 'Z.', 'Sanchez', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Mark27', 'AA.', 'Clark', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 1, NULL, 'Carol28', 'BB.', 'Ramirez', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Steven29', 'CC.', 'Lewis', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Michelle30', 'DD.', 'Lee', NULL, 1, NEWID(), GETDATE());

INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Kenneth31', 'EE.', 'Walker', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 1, NULL, 'Dorothy32', 'FF.', 'Hall', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Brian33', 'GG.', 'Allen', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Emily34', 'HH.', 'Young', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, 'Dr.', 'Ronald35', 'II.', 'Hernandez', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Sharon36', 'JJ.', 'King', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Jason37', 'KK.', 'Wright', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 1, NULL, 'Cynthia38', 'LL.', 'Lopez', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Ryan39', 'MM.', 'Hill', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Anna40', 'NN.', 'Scott', NULL, 2, NEWID(), GETDATE());

INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Gary41', 'OO.', 'Green', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Rebecca42', 'PP.', 'Adams', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 1, NULL, 'Nicholas43', 'QQ.', 'Baker', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Julie44', 'RR.', 'Nelson', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Eric45', 'SS.', 'Carter', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Angela46', 'TT.', 'Mitchell', NULL, 1, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 0, NULL, 'Stephen47', 'UU.', 'Perez', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('IN', 1, NULL, 'Kelly48', 'VV.', 'Roberts', NULL, 2, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, NULL, 'Benjamin49', 'WW.', 'Turner', NULL, 0, NEWID(), GETDATE());
INSERT INTO Person.Person (PersonType, NameStyle, Title, FirstName, MiddleName, LastName, Suffix, EmailPromotion, rowguid, ModifiedDate) VALUES ('EM', 0, 'Ms.', 'Laura50', 'XX.', 'Phillips', NULL, 1, NEWID(), GETDATE());

COMMIT TRANSACTION;
PRINT 'Inserted 50 mock Person.Person rows.';

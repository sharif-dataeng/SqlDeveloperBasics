create database training;

create table VITS(
    StudentName varchar(50),
    ID int,
    Branch varchar(50),
    DateofBirth date,
    Gender char(1),
    HomeTown varchar(50),
    Mobile varchar(10)
);


insert into VITS(StudentName, ID, Branch, DateofBirth, Gender, HomeTown, Mobile) values
('Tharun', 1215, 'Electronics', '2000-01-26', 'M', 'Kavali', '7028472748'),
('Faizan', 1216, 'Electronics', '1999-11-23', 'M', 'Kavali', '8472702748'),
('Lavanya', 1217, 'Electronics', '2000-06-18', 'F', 'Nellore', '9108477538'),
('Prasad', 1218, 'Electronics', '1999-01-12', 'M', 'Guntur', '9748772028'),
('Kishore', 1219, 'Electrical', '1998-07-09', 'M', 'Nellore', '8472770108'),
('Kelvin', 1220, 'Computer Science', '2001-06-08', 'M', 'Chennai', '7472028748'),
('Rohit', 1221, 'Computer Science', '2000-11-30', 'M', 'Tirupati', '8702947174'),
('Sandhya', 1222, 'Computer Science', '1999-05-19', 'F', 'Nellore', '902345743'),
('Chandra', 1223, 'Electrical', '2000-08-02', 'M', 'Kakinada', '7274870284'),
('Kiara', 1224, 'Electronics', '2000-06-04', 'F', 'Viayawada', '9027459203'),
('Aishwarya', 1225, 'Electronics', '1999-09-15', 'F', 'ongole', '8193583962'),
('Chaitanya', 1226, 'Computer Science', '2000-12-25', 'M', 'Kavali', '8300275193');
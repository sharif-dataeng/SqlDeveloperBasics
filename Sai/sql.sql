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




use training;
create table Employee(
EmployeeID int primary key,
FirstName varchar(50),
LastName varchar(50),
Department varchar(20),
Hiredate date
);
Insert into Employee
(EmployeeID, FirstName, LastName, Department, Hiredate)
values
(211, 'John', 'Smith', 'HR', '2020-01-15'),
(212, 'Priya', 'Reddy', 'IT', '2019-03-22'),
(213, 'Ahmed', 'Khan', 'Finance', '2021-07-10'),
(214, 'Maria', 'Lopez', 'Marketing', '2022-11-05'),
(215, 'Chen', 'Wei', 'IT', '2018-09-30');
create table Products(
ProductID int primary key,
ProductName varchar(50),
Category varchar(50),
Price float,
PurchasedBy int,
Foreign key (PurchasedBy) References Employee(EmployeeID)
);
insert into Products
(ProductID, ProductName, Category, Price, PurchasedBy)
values
(101, 'Laptop', 'Electronics', 75000.00, 212),
(102, 'Chair', 'Furniture', 1500.50, 214),
(103, 'Coffee Maker', 'Appliances', 250400.80, 215),
(104, 'Smart Phone', 'Electronics', 32000.00, 211),
(105, 'Desk', 'Furniture', 8500.90, 213);
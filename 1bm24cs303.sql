create database bankdetails;
use bankdetails;
-- Creating the Branch table
CREATE TABLE Branch (
    BranchName VARCHAR(30) PRIMARY KEY,
    BranchCity VARCHAR(30),
    Assets INT
);

-- Inserting values into Branch
INSERT INTO Branch VALUES
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);

-- Creating the BankAccount table
CREATE TABLE BankAccount (
    AccNo INT PRIMARY KEY,
    BranchName VARCHAR(30),
    Balance INT,
    FOREIGN KEY (BranchName) REFERENCES Branch(BranchName)
);

-- Inserting values into BankAccount
INSERT INTO BankAccount VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParlimentRoad', 1000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(7, 'SBI_ResidencyRoad', 4000),
(8, 'SBI_ParlimentRoad', 3000),
(9, 'SBI_ResidencyRoad', 5000),
(10, 'SBI_ParlimentRoad', 3000),
(11, 'SBI_Jantarmantar', 2000);

-- Creating the BankCustomer table
CREATE TABLE BankCustomer (
    CustomerName VARCHAR(30) PRIMARY KEY,
    CustomerStreet VARCHAR(50),
    CustomerCity VARCHAR(30)
);

-- Inserting values into BankCustomer
INSERT INTO BankCustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannerghatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikhil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

-- Creating the Deposit table
CREATE TABLE Deposit (
    CustomerName VARCHAR(30),
    AccNo INT,
    FOREIGN KEY (CustomerName) REFERENCES BankCustomer(CustomerName),
    FOREIGN KEY (AccNo) REFERENCES BankAccount(AccNo)
);

-- Inserting values into Deposit
INSERT INTO Deposit VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikhil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikhil', 9),
('Dinesh', 10),
('Nikhil', 11);

-- Creating the Loan table
CREATE TABLE Loan (
    LoanNumber INT PRIMARY KEY,
    BranchName VARCHAR(30),
    Amount INT,
    FOREIGN KEY (BranchName) REFERENCES Branch(BranchName)
);

-- Inserting values into Loan
INSERT INTO Loan VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);
SELECT d.CustomerName
FROM Deposit d
JOIN BankAccount ba ON d.AccNo = ba.AccNo
JOIN Branch b ON ba.BranchName = b.BranchName
WHERE b.BranchCity = 'Delhi'
GROUP BY d.CustomerName
HAVING COUNT(DISTINCT ba.BranchName) = (
    SELECT COUNT(*) 
    FROM Branch 
    WHERE BranchCity = 'Delhi'
);



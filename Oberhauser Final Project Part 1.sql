Use Master;
GO

--Drop database if it exists
DROP DATABASE if exists TechMartDB
GO

--Create TechMartDB database
CREATE DATABASE TechMartDB
GO

--Use TechMartDB
USE TechMartDB
GO

--Table 1: Territory
CREATE TABLE Territory (
    TerritoryID INTEGER PRIMARY KEY,
    TerritoryName VARCHAR(100),
    Quota INTEGER
);
GO

--Insert data into Territory table
INSERT INTO Territory (TerritoryID, TerritoryName, Quota)
VALUES 
    (1, 'East', 100000),
    (2, 'West', 120000);
GO

--Table 2: SalesRep
CREATE TABLE SalesRep (
    EmployeeID INTEGER PRIMARY KEY,
    MonthToDateSales NUMERIC(10, 2),
    YearToDateSales NUMERIC(10, 2),
    MonthToDateCommission NUMERIC(10, 2),
    YearToDateCommission NUMERIC(10, 2),
    CommissionRate NUMERIC(5, 2),
    TerritoryID INTEGER FOREIGN KEY REFERENCES Territory(TerritoryID)
);
GO

--Insert data into SalesRep table
INSERT INTO SalesRep (EmployeeID, MonthToDateSales, YearToDateSales, MonthToDateCommission, YearToDateCommission, CommissionRate, TerritoryID)
VALUES 
    (101, 50000.00, 120000.00, 5000.00, 15000.00, 0.10, 1),
    (102, 60000.00, 140000.00, 6000.00, 18000.00, 0.12, 2);
GO

--Table 3: Employee
CREATE TABLE Employee (
    EmployeeID INTEGER PRIMARY KEY,
    EmployeeFName VARCHAR(100),
    EmployeeLName VARCHAR(100),
    EmplyeeAddress1 VARCHAR(100),
    EmployeeAddress2 VARCHAR(100),
    EmployeeCity VARCHAR(100),
    EmployeeState VARCHAR(100),
    EmployeeZip VARCHAR(10),
    EmployeePhone VARCHAR(20),
    JobTitle VARCHAR(100),
    PayRate NUMERIC(10, 2)
);
GO

--Insert data into Employee table
INSERT INTO Employee (EmployeeID, EmployeeFName, EmployeeLName, EmplyeeAddress1, EmployeeAddress2, EmployeeCity, EmployeeState, EmployeeZip, EmployeePhone, JobTitle, PayRate)
VALUES 
    (101, 'John', 'Doe', '123 Main St', '', 'New York', 'NY', '10001', '555-123-4567', 'Actuary', 100000.00),
    (102, 'Jane', 'Smith', '456 Oak St', '', 'Los Angeles', 'CA', '90001', '555-987-6543', 'Personal Trainer', 40000.00);
GO

--Table 4: Customer
CREATE TABLE Customer (
    CustomerID INTEGER PRIMARY KEY,
    CustomerFName VARCHAR(100),
    CustomerLName VARCHAR(100),
    CustomerAddress1 VARCHAR(100),
    CustomerAddress2 VARCHAR(100),
    CustomerCity VARCHAR(100),
    CustomerState VARCHAR(100),
    CustomerZipCode VARCHAR(10),
    CustomerPhoneNum VARCHAR(20),
    MTDSales NUMERIC(10, 2),
    YTDSales NUMERIC(10, 2),
    CurrentBalance NUMERIC(10, 2),
    CreditLimit NUMERIC(10, 2),
    ShipName VARCHAR(100),
    ShipAddress1 VARCHAR(100),
    ShipAddress2 VARCHAR(100),
    ShipCity VARCHAR(100),
    ShipState VARCHAR(100),
    ShipZipCode VARCHAR(10),
    CurrentInvoiceTotoal NUMERIC(10, 2),
    CurrentPaymentTotal NUMERIC(10, 2),
    CurrentAmount NUMERIC(10, 2),
    PreviousBalance NUMERIC(10, 2),
    EmployeeID INTEGER FOREIGN KEY REFERENCES SalesRep(EmployeeID)
);
GO

--Insert data into Customer table
INSERT INTO Customer (CustomerID, CustomerFName, CustomerLName, CustomerAddress1, CustomerAddress2, CustomerCity, CustomerState, CustomerZipCode, CustomerPhoneNum, MTDSales, YTDSales, CurrentBalance, CreditLimit, ShipName, ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZipCode, CurrentInvoiceTotoal, CurrentPaymentTotal, CurrentAmount, PreviousBalance, EmployeeID)
VALUES 
    (1001, 'James', 'Johnson', '789 Elm St', '', 'Chicago', 'IL', '60601', '555-111-2222', 5000.00, 15000.00, 500.00, 1000.00, 'James Johnson', '789 Elm St', '', 'Chicago', 'IL', '60601', 500.00, 0.00, 500.00, 0.00, 101),
    (1002, 'Bob', 'Bobbler', '321 Pine St', '', 'Austin', 'TX', '73301', '555-333-4444', 7000.00, 20000.00, 1000.00, 2000.00, 'Bob Bobber', '321 Pine St', '', 'Austin', 'TX', '73301', 1000.00, 0.00, 1000.00, 0.00, 102);
GO

--Table 5: Vendor
CREATE TABLE Vendor (
    VendorID INTEGER PRIMARY KEY,
    VendorName VARCHAR(100),
    VendorAddress VARCHAR(100),
    VendorCity VARCHAR(100),
    VendorState VARCHAR(100),
    VendorZipCode VARCHAR(10),
    VendorPhoneNumber VARCHAR(20),
    CreditLimit NUMERIC(10, 2)
);
GO

--Insert data into Vendor table
INSERT INTO Vendor (VendorID, VendorName, VendorAddress, VendorCity, VendorState, VendorZipCode, VendorPhoneNumber, CreditLimit)
VALUES 
    (1, 'TechVendor1', '123 Tech St', 'TechCity', 'TechState', '12345', '555-111-2222', 5000.00),
    (2, 'TechVendor2', '456 Tech St', 'TechCity', 'TechState', '67890', '555-333-4444', 7000.00);
GO


--Table 6: Part
CREATE TABLE Part (
    PartID INTEGER PRIMARY KEY,
    VendorID INTEGER FOREIGN KEY REFERENCES Vendor(VendorID),
    PartDescription VARCHAR(100),
    UnitPrice NUMERIC(10, 2),
    MTDSales NUMERIC(10, 2),
    YTDSales NUMERIC(10, 2),
    UnitsOnHand INTEGER,
    UnitsAllocated INTEGER,
    ReorderPoint INTEGER,
    VendorPrice NUMERIC(10, 2),
    MinimumOrderQuality INTEGER,
    ExpectedLeatTime TIME
);
GO

--Insert data into Part table
INSERT INTO Part (PartID, VendorID, PartDescription, UnitPrice, MTDSales, YTDSales, UnitsOnHand, UnitsAllocated, ReorderPoint, VendorPrice, MinimumOrderQuality, ExpectedLeatTime)
VALUES 
    (10001, 1, 'Laptop', 800.00, 2000.00, 10000.00, 50, 10, 20, 700.00, 5, '3 days'),
    (10002, 2, 'Smartphone', 600.00, 1500.00, 8000.00, 30, 5, 10, 550.00, 5, '2 days');
GO

--Table 7: Orders
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    OrderDate DATETIME,
    CustomerID INTEGER FOREIGN KEY REFERENCES Customer(CustomerID),
    CustomerPONumber INTEGER,
    OrderTotal NUMERIC(10, 2),
    OderStatus INTEGER,
    OrderSpecialChanges NUMERIC(10, 2),
    OrderSpecialChangesDescription VARCHAR(255),
    ShipName VARCHAR(100),
    ShipAddress1 VARCHAR(100),
    ShipAddress2 VARCHAR(100),
    ShipCity VARCHAR(100),
    ShipState VARCHAR(100),
    ShipZip VARCHAR(10)
);
GO

--Insert data into Orders table
INSERT INTO Orders (OrderID, OrderDate, CustomerID, CustomerPONumber, OrderTotal, OderStatus, OrderSpecialChanges, OrderSpecialChangesDescription, ShipName, ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZip)
VALUES 
    (2001, '2024-05-01', 1001, 12345, 1500.00, 1, 50.00, 'Special handling', 'James Johnson', '789 Elm St', '', 'Chicago', 'IL', '60601'),
    (2002, '2024-05-02', 1002, 54321, 2000.00, 1, 0.00, '', 'Bob Bobbler', '321 Pine St', '', 'Austin', 'TX', '73301');
GO

--Table 8: Order Details
CREATE TABLE OrderDetails (
    OrderDetailID INTEGER PRIMARY KEY,
    OrderID INTEGER FOREIGN KEY REFERENCES Orders(OrderID),
    SEQNumber INTEGER,
    PartID INTEGER FOREIGN KEY REFERENCES Part(PartID),
    VendorID INTEGER FOREIGN KEY REFERENCES Vendor(VendorID),
    NumberOrdered INTEGER,
    QuotedPrice NUMERIC(10, 2),
    LineTotal NUMERIC(10, 2),
    Comments VARCHAR(100)
);
GO

--Insert data into OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, SEQNumber, PartID, VendorID, NumberOrdered, QuotedPrice, LineTotal, Comments)
VALUES 
    (3001, 2001, 1, 10001, 1, 5, 800.00, 4000.00, 'None'),
    (3002, 2002, 1, 10002, 2, 3, 600.00, 1800.00, 'Special request');
GO

--Table 9: Invoice
CREATE TABLE Invoice (
    InvoiceID INTEGER PRIMARY KEY,
    ShipDate DATETIME,
    FreightCost NUMERIC(10, 2),
    ShipStatus INTEGER
);
GO

--Insert data into Invoice table
INSERT INTO Invoice (InvoiceID, ShipDate, FreightCost, ShipStatus)
VALUES 
    (4001, '2024-05-05', 50.00, 1),
    (4002, '2024-05-06', 75.00, 1);
GO

--Table 10: Invoice Detail
CREATE TABLE InvoiceDetail (
    InvoiceDetailID INTEGER PRIMARY KEY,
    InvoiceID INTEGER FOREIGN KEY REFERENCES Invoice(InvoiceID),
    OrderID INTEGER FOREIGN KEY REFERENCES Orders(OrderID),
    SEQNumber INTEGER,
    QuantityShipped INTEGER
);
GO

--Insert data into InvoiceDetail table
INSERT INTO InvoiceDetail (InvoiceDetailID, InvoiceID, OrderID, SEQNumber, QuantityShipped)
VALUES 
    (5001, 4001, 2001, 1, 5),
    (5002, 4002, 2002, 1, 3);
GO

--Table 11: Payment
CREATE TABLE Payment (
    PaymentID INTEGER PRIMARY KEY,
    CustomerID INTEGER FOREIGN KEY REFERENCES Customer(CustomerID),
    PaymentDate DATETIME,
    PaymentAmount NUMERIC(10, 2)
);
GO

--Insert data into Payment table
INSERT INTO Payment (PaymentID, CustomerID, PaymentDate, PaymentAmount)
VALUES 
    (6001, 1001, '2024-05-05', 500.00),
    (6002, 1002, '2024-05-06', 1000.00);
GO

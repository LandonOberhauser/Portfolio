
-- 19. Create a View utilizing one of the tables within your database.
CREATE VIEW CustomerDetails AS
SELECT CustomerID, CustomerFName, CustomerLName, CustomerCity, CustomerState, CustomerPhoneNum
FROM Customer;
GO

--1
INSERT INTO Customer (CustomerID, CustomerFName, CustomerLName, CustomerAddress1, CustomerAddress2, CustomerCity, CustomerState, CustomerZipCode, CustomerPhoneNum, MTDSales, YTDSales, CurrentBalance, CreditLimit, ShipName, ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZipCode, CurrentInvoiceTotoal, CurrentPaymentTotal, CurrentAmount, PreviousBalance, EmployeeID)
VALUES (1003, 'Mary', 'Smith', '789 Elm St', '', 'Chicago', 'IL', '60601', '555-555-5555', 0.00, 0.00, 0.00, 0.00, 'Mary Smith', '789 Elm St', '', 'Chicago', 'IL', '60601', 0.00, 0.00, 0.00, 0.00, 101);

--2
UPDATE Customer
SET CustomerFName = 'Michelle'
WHERE CustomerFName = 'Mary';

--3
UPDATE Customer
SET CustomerCity = 'Milwaukee', CustomerZipCode = '53201'
WHERE CustomerFName = 'Michelle';

--4
DELETE FROM Customer
WHERE CustomerFName = 'Michelle';

--5
UPDATE SalesRep
SET CommissionRate = 0.17;

--6
ALTER TABLE Vendor
ADD Status INT;

--7
SELECT CustomerFName + ' ' + CustomerLName AS CustomerName, CustomerPhoneNum
FROM Customer
ORDER BY CustomerFName, CustomerLName;

--8
SELECT CustomerLName, CustomerFName
FROM Customer
WHERE CreditLimit >= 800.00;

--9
SELECT OrderID
FROM Orders
WHERE OrderDate = '2023-12-01' AND CustomerID = 124;

--10
SELECT PartID, PartDescription, (UnitsOnHand * UnitPrice) AS InventoryValue
FROM Part
WHERE ReorderPoint > 10;

--11
SELECT CustomerID, CustomerFName, CustomerLName, (CustomerFName + ' ' + CustomerLName) AS Name
FROM Customer
WHERE CustomerFName LIKE 'S%';

--12
SELECT PartID, PartDescription, UnitsOnHand
FROM Part
WHERE UnitsOnHand > (SELECT AVG(UnitsOnHand) FROM Part);

--13
SELECT TOP 1 PartID, PartDescription, UnitPrice
FROM Part
ORDER BY UnitPrice DESC;

--14
SELECT COUNT(*) AS TotalCustomers
FROM Customer;

--15
SELECT c.EmployeeID, SUM(CurrentBalance) AS TotalBalance
FROM Customer c
GROUP BY c.EmployeeID
ORDER BY c.EmployeeID;

--16
SELECT o.OrderID, o.OrderDate, c.CustomerID, c.CustomerLName, c.CustomerFName
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate = '2022-12-22';

--17
SELECT o.OrderID, o.OrderDate, od.PartID, p.PartDescription, od.NumberOrdered
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Part p ON od.PartID = p.PartID
ORDER BY o.OrderID ASC;

--18
SELECT PartID, PartDescription, UnitPrice, UnitsOnHand
FROM Part
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Part);

-- Query for add a new character functionality with dollar sign $ character being used to 
-- denote the variables that will have data from the backend programming language.
SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM MenuItems;
SELECT * FROM OrderItems WHERE orderID = $orderID;
SELECT * FROM Orders;
SELECT * FROM Phones;
SELECT * FROM Positions;
SELECT * FROM StorePositions WHERE storeID = $storeID;
SELECT * FROM Stores;

INSERT INTO Customers (firstName, lastName, email, loyaltyPoints) VALUES
($firstName, $lastName, $email, $loyaltyPoints);

INSERT INTO Employees (storeID, firstName, lastName, positionID, hireDate) VALUES
($storeID, $firstName, $lastName, $positionID, $hireDate);

INSERT INTO MenuItems (itemName, description, price, category) VALUES
($itemName, $description, $price, $category);

INSERT INTO OrderItems (orderID, menuID, quantity, itemPrice) VALUES
($orderID, $menuID, $quantity, $itemPrice);

INSERT INTO Orders (storeID, customerID, orderDate, totalAmount, orderStatus) VALUES
($storeID, $customerID, $orderDate, $totalAmount, $orderStatus);

INSERT INTO Phones (customerID, phoneCountryCode, phoneAreaCode, phoneNumber) VALUES
($customerID, $phoneCountryCode, $phoneAreaCode, $phoneNumber);

INSERT INTO Positions (positionName) VALUES 
($positionName);

INSERT INTO StorePositions (storeID, positionID) VALUES
($storeID, $positionID);

INSERT INTO Stores (streetAddress, city, state, zipCode, phoneNumber) VALUES
($streetAddress, $city, $state, $zipCode, $phoneNumber);

UPDATE StorePositions
SET positionID = NULL
WHERE storeID = $selected_store;

DELETE FROM StorePositions WHERE storeID = $storeID AND positionID = $positionID LIMIT 1;


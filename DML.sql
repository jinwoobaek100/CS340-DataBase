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
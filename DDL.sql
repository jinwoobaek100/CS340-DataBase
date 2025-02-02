CREATE TABLE Stores (
    storeID INT AUTO_INCREMENT PRIMARY KEY,
    storeName VARCHAR(100) NOT NULL,
    streetAddress VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zipCode VARCHAR(20) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE MenuItems (
    menuID INT AUTO_INCREMENT PRIMARY KEY,
    itemName VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category ENUM('Ramen', 'Side', 'Beverage') NOT NULL
);

CREATE TABLE Orders (
    orderID INT AUTO_INCREMENT PRIMARY KEY,
    storeID INT NOT NULL,
    customerID INT NOT NULL,
    orderDate DATETIME NOT NULL,
    totalAmount DECIMAL(10,2) NOT NULL,
    orderStatus ENUM('Preparing', 'Completed', 'Cancelled') NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Stores(storeID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

CREATE TABLE Phones (
    phoneID INT AUTO_INCREMENT PRIMARY KEY,
    customerID INT NOT NULL,
    phoneCountryCode VARCHAR(5),
    phoneAreaCode VARCHAR(5),
    phoneNumber VARCHAR(15),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

CREATE TABLE Customers (
    customerID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    loyaltyPoints INT DEFAULT 0
);

CREATE TABLE OrderItems (
    orderItemID INT AUTO_INCREMENT PRIMARY KEY,
    orderID INT NOT NULL,
    menuID INT NOT NULL,
    quantity INT NOT NULL,
    itemPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (menuID) REFERENCES MenuItems(menuID)
);

CREATE TABLE Positions (
    positionID INT AUTO_INCREMENT PRIMARY KEY,
    positionName VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Employees (
    employeeID INT AUTO_INCREMENT PRIMARY KEY,
    storeID INT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    positionID INT NOT NULL,
    hireDate DATE NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Stores(storeID),
    FOREIGN KEY (positionID) REFERENCES Positions(positionID)
);

CREATE TABLE StorePositions (
    storePositionID INT AUTO_INCREMENT PRIMARY KEY,
    storeID INT NOT NULL,
    positionID INT NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Stores(storeID),
    FOREIGN KEY (positionID) REFERENCES Positions(positionID),
    UNIQUE (storeID, positionID)
);

INSERT INTO Positions (positionName) VALUES ('Manager'), ('Chef'), ('Server');

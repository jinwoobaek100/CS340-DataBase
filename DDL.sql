SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS StorePositions;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Phones;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS MenuItems;
DROP TABLE IF EXISTS Stores;
DROP TABLE IF EXISTS Positions;

CREATE OR REPLACE TABLE Stores (
    storeID INT AUTO_INCREMENT PRIMARY KEY,
    streetAddress VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zipCode VARCHAR(20) NOT NULL,
    phoneNumber VARCHAR(20) NOT NULL
);

CREATE OR REPLACE TABLE Customers (
    customerID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    loyaltyPoints INT DEFAULT 0
);

CREATE OR REPLACE TABLE MenuItems (
    menuID INT AUTO_INCREMENT PRIMARY KEY,
    itemName VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category ENUM('Ramen', 'Side', 'Beverage') NOT NULL
);

CREATE OR REPLACE TABLE Orders (
    orderID INT AUTO_INCREMENT PRIMARY KEY,
    storeID INT NOT NULL,
    customerID INT NOT NULL,
    orderDate DATETIME NOT NULL,
    totalAmount DECIMAL(10,2) NOT NULL,
    orderStatus ENUM('Preparing', 'Completed', 'Cancelled') NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Stores(storeID) ON DELETE CASCADE,
    FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE CASCADE
);

CREATE OR REPLACE TABLE Phones (
    phoneID INT AUTO_INCREMENT PRIMARY KEY,
    customerID INT NOT NULL,
    phoneCountryCode VARCHAR(5),
    phoneAreaCode VARCHAR(5),
    phoneNumber VARCHAR(15),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID) ON DELETE CASCADE
);


CREATE OR REPLACE TABLE OrderItems (
    orderItemID INT AUTO_INCREMENT PRIMARY KEY,
    orderID INT NOT NULL,
    menuID INT NOT NULL,
    quantity INT NOT NULL,
    itemPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE,
    FOREIGN KEY (menuID) REFERENCES MenuItems(menuID) ON DELETE CASCADE
);

CREATE OR REPLACE TABLE Positions (
    positionID INT AUTO_INCREMENT PRIMARY KEY,
    positionName VARCHAR(50) UNIQUE NOT NULL
);

CREATE OR REPLACE TABLE Employees (
    employeeID INT AUTO_INCREMENT PRIMARY KEY,
    storeID INT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    positionID INT NOT NULL,
    hireDate DATE NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Stores(storeID) ON DELETE CASCADE,
    FOREIGN KEY (positionID) REFERENCES Positions(positionID) ON DELETE CASCADE
);

CREATE OR REPLACE TABLE StorePositions (
    storePositionID INT AUTO_INCREMENT PRIMARY KEY,
    storeID INT NOT NULL,
    positionID INT NOT NULL,
    FOREIGN KEY (storeID) REFERENCES Stores(storeID) ON DELETE CASCADE,
    FOREIGN KEY (positionID) REFERENCES Positions(positionID) ON DELETE CASCADE,
    UNIQUE (storeID, positionID)
);

INSERT INTO Positions (positionName) VALUES ('Manager'), ('Chef'), ('Server');

INSERT INTO Stores (streetAddress, city, state, zipCode, phoneNumber) VALUES
('1768 Crystal Lake Dr', 'Corvallis', 'OR', '97201', '503-555-0101'),
('2518 SW Coho St', 'Seattle', 'WA', '98101', '206-555-0202'),
('7799 SW Taylor Avenue', 'San Francisco', 'CA', '94103', '415-555-0303'),
('1011 Noodle Way', 'Los Angeles', 'CA', '90012', '213-555-0404');

INSERT INTO MenuItems (itemName, description, price, category) VALUES
('Tonkotsu Ramen', 'Rich pork bone broth', 12.99, 'Ramen'),
('Gyoza', 'Pan-fried dumplings', 6.99, 'Side'),
('Matcha Latte', 'Green tea latte', 4.50, 'Beverage'),
('Shoyu Ramen', 'Soy sauce base broth', 13.99, 'Ramen'),
('Vegetarian Ramen', 'Seasonal vegetable broth', 14.50, 'Ramen'),
('Karaage Chicken', 'Japanese fried chicken', 8.99, 'Side'),
('Edamame', 'Steamed soybeans', 4.99, 'Side'),
('Sapporo Beer', 'Imported Japanese beer', 5.99, 'Beverage'),
('Calpico Soda', 'Refreshing yogurt drink', 3.99, 'Beverage');

INSERT INTO Customers (firstName, lastName, email, loyaltyPoints) VALUES
('John', 'Doe', 'john.doe@email.com', 150),
('Jane', 'Smith', 'jane.smith@email.com', 75),
('Michael', 'Chen', 'michael.chen@email.com', 200),
('Sarah', 'Johnson', 'sarah.j@email.com', 50),
('Carlos', 'Gomez', 'c.gomez@email.com', 0);

INSERT INTO Phones (customerID, phoneCountryCode, phoneAreaCode, phoneNumber) VALUES
(1, '+1', '503', '555-0123'),
(2, '+1', '206', '555-0456'),
(3, '+1', '415', '555-0678'),
(4, '+1', '213', '555-0990'),
(5, '+1', '310', '555-1122');

INSERT INTO Employees (storeID, firstName, lastName, positionID, hireDate) VALUES
(1, 'Takeshi', 'Yamada', 1, '2023-01-15'),
(1, 'Aiko', 'Sato', 3, '2023-02-01'),
(3, 'Kenji', 'Tanaka', 1, '2024-03-01'),
(3, 'Mariko', 'Kobayashi', 2, '2024-03-15'),
(4, 'Emily', 'Rodriguez', 1, '2024-04-01'),
(2, 'David', 'Kim', 3, '2024-02-01');

INSERT INTO StorePositions (storeID, positionID) VALUES
(1, 1), (1, 2),
(1, 3), (2, 1),
(3, 1), (3, 2), (3, 3),
(4, 1), (4, 2), (4, 3);

INSERT INTO Orders (storeID, customerID, orderDate, totalAmount, orderStatus) VALUES
(1, 1, '2023-10-01 12:30:00', 26.97, 'Completed'),
(1, 2, '2023-10-01 13:15:00', 18.49, 'Preparing'),
(3, 3, '2024-03-20 18:45:00', 38.97, 'Completed'),
(2, 4, '2024-04-01 12:15:00', 27.98, 'Preparing'),
(4, 5, '2024-04-02 19:30:00', 22.49, 'Preparing');

INSERT INTO OrderItems (orderID, menuID, quantity, itemPrice) VALUES
(1, 1, 2, 12.99),
(1, 2, 1, 6.99),
(2, 1, 1, 12.99),
(2, 3, 1, 4.50),
(3, 6, 1, 8.99),
(4, 1, 1, 12.99),
(4, 5, 2, 5.99),
(5, 5, 1, 14.50),
(5, 7, 1, 4.99);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
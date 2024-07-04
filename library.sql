CREATE DATABASE Library;
USE Library;
   CREATE TABLE Books1 (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Genre VARCHAR(100),
    Year INT,
    Copies INT NOT NULL
);
INSERT INTO Books1 (Title, Author, Genre, Year, Copies) VALUES
('1984', 'George Orwell', 'Dystopian', 1949, 5),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 3),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 4),
('Moby Dick', 'Herman Melville', 'Adventure', 1851, 2),
('War and Peace', 'Leo Tolstoy', 'Historical', 1869, 3);
SELECT * FROM Books1;
CREATE TABLE Members1 (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    JoinDate DATE
);
INSERT INTO Members1 (FirstName, LastName, Email, Phone, JoinDate) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '098-765-4321', '2023-02-20'),
('Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567', '2023-03-05'),
('Bob', 'Williams', 'bob.williams@example.com', '555-987-6543', '2023-04-10'),
('Charlie', 'Brown', 'charlie.brown@example.com', '555-321-4321', '2023-05-25');

SELECT * FROM Members1;
CREATE TABLE Transactions1(
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID)
        REFERENCES Members1 (MemberID),
    FOREIGN KEY (BookID)
        REFERENCES Books1 (BookID)
);
INSERT INTO Transactions1 (MemberID, BookID, BorrowDate, ReturnDate) VALUES
(1, 1, '2023-06-01', NULL),
(2, 2, '2023-06-05', '2023-06-15'),
(3, 3, '2023-06-10', '2023-06-20'),
(4, 4, '2023-06-15', NULL),
(5, 5, '2023-06-20', NULL);
SELECT * FROM Transactions1;
/*update data*/
UPDATE Books1
SET Copies = 4
WHERE BookID = 1;

UPDATE Members1
SET Phone = '555-000-0000'
WHERE MemberID = 1;

/*delete */
DELETE FROM Books1
WHERE BookID = 5;

DELETE FROM Members1
WHERE MemberID = 5;
-- Retrieve books borrowed by a specific member
SELECT Books1.Title, Transactions1.BorrowDate, Transactions1.ReturnDate
FROM Transactions1
JOIN Books1 ON Transactions1.BookID = Books1.BookID
WHERE Transactions1.MemberID = 1;

-- Retrieve the list of books currently borrowed (not returned)
SELECT Books1.Title, Members1.FirstName, Members1.LastName, Transactions1.BorrowDate
FROM Transactions1
JOIN Books1 ON Transactions1.BookID = Books1.BookID
JOIN Members1 ON Transactions1.MemberID = Members1.MemberID
WHERE Transactions1.ReturnDate IS NULL;
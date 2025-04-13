-- Create a new database
CREATE DATABASE BookStore;

-- Use the newly created database
USE BookStore;

-- Create a table to store book information
CREATE TABLE Books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    description TEXT,
    published_year INT,
    price DECIMAL(10, 2)
);

-- Insert some sample data into the Books table
INSERT INTO Books (title, author, description, published_year, price) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'A novel set in the 1920s that explores themes of wealth, love, and the American Dream.', 1925, 10.99),
('To Kill a Mockingbird', 'Harper Lee', 'A story about racial injustice in the Deep South, seen through the eyes of a young girl.', 1960, 7.99),
('1984', 'George Orwell', 'A dystopian novel that explores the dangers of totalitarianism and government surveillance.', 1949, 8.99),
('Pride and Prejudice', 'Jane Austen', 'A romantic novel that also critiques social class and marriage in early 19th-century England.', 1813, 5.99);

-- Query to retrieve all books
SELECT * FROM Books;

-- Query to retrieve books written by a specific author
SELECT * FROM Books WHERE author = 'George Orwell';

-- Query to find books with price greater than 8.00
SELECT * FROM Books WHERE price > 8.00;

-- Query to update the price of a book
UPDATE Books SET price = 12.99 WHERE title = '1984';

-- Query to delete a book
DELETE FROM Books WHERE title = 'Pride and Prejudice';


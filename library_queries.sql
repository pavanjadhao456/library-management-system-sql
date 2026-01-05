--- 1) REETRIEVE ALL BOOKS IN THE "FICTION" GENRE:
SELECT * FROM Books 
WHERE genre = "fiction";

--- 2) FIND BOOKS PUBLISHED AFTER THE YEAR 1950:
SELECT * FROM Books 
WHERE Published_year > 1950;

--- 3) LIST ALL THE CUSTOMERS FROM THE CANADA:
SELECT * FROM CUSTOMERS 
WHERE Country = "Canada";

--- 4) SHOW ORDERS PLACED IN NOVEMBER 2023:
SELECT * FROM Orders
WHERE Order_date BETWEEN '2023-11-01' AND '2023-11-30';

--- 5) RETRIEVE THE TOTAL STOCK OF BOOKS AVAILABLE:
SELECT SUM(Stock) 
FROM Books;

--- 6) FIND THE DETAILS OF THE MOST EXPENSIVE BOOK:
SELECT * FROM Books
ORDER BY Price DESC ;

--- 7) SHOW ALL CUSTOMERS WHO ORDERED MORE THAN 1 QUANTITY OF A BOOK:
SELECT * FROM Orders
WHERE Quantity > 1;

--- 8) RETRIEVE ALL ORDERS WHERE THE TOTAL AMOUNT EXCEEDS $20:
SELECT * FROM Orders
WHERE Total_amount > 20;

--- 9) LIST ALL THE GENRE AVAILABLE IN THE BOOKS TABLE:
SELECT DISTINCT genre FROM Books;

--- 10) FIND THE BOOKS WITH THE LOWEST STOCK:
SELECT * FROM Books
ORDER BY Stock ASC LIMIT 1;

--- 11) CALCULATE THE TOTAL RECENUE GENERATED FROM ALL ORDERS:
SELECT SUM(Total_amount)
FROM Orders;

--- ADVANCE QUERIES --------
--- 1) RETRIEVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE:
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o 
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

--- 2) FIND THE AVERAGE PRICE OF BOOKS IN THE "FANTASY" GENRE:
SELECT AVG(price)
FROM Books
WHERE Genre = "Fantasy";

--- 3) LIST CUSTOMERS WHO HAVE PLACED AT LEAST 2 ORDERS:
SELECT c.Customer_ID, c.Name, COUNT(o.Order_ID) AS total_orders
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

--- 4) Find the most frequently ordered book
SELECT b.Book_ID, b.Title, COUNT(o.Order_ID) AS order_count
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY order_count DESC
LIMIT 1;

--- 5) Show the top 3 most expensive books of 'Fantasy' Genre 
SELECT Book_ID, Title, Price
FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

--- 6) Retrieve the total quantity of books sold by each author
SELECT b.Author, SUM(o.Quantity) AS total_quantity_sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

--- 7) List the cities where customers who spent over $30 are located
SELECT DISTINCT c.City
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.City
HAVING SUM(o.Total_Amount) > 30;

--- 8) Find the customer who spent the most on orders
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY total_spent DESC
LIMIT 1;

--- 9) Calculate the stock remaining after fulfilling all orders
SELECT 
  b.Book_ID,
  b.Title,
  b.Stock - COALESCE(SUM(o.Quantity), 0) AS stock_remaining
FROM Books b
LEFT JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;

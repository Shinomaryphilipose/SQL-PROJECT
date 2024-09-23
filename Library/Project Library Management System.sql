CREATE DATABASE LIBRARY;
USE LIBRARY;


# Creating Table Branch. 
CREATE TABLE Branch (Branch_no INT PRIMARY KEY,
   Manager_Id INT,Branch_address VARCHAR(25),
   Contact_no CHAR(10));
   
   DESC Branch;
   
 # Creating Table Employee.
CREATE TABLE Employee(Emp_Id INT PRIMARY KEY,
      Emp_name VARCHAR(30), Position VARCHAR(25),
	  Salary DECIMAL(10,2), Branch_no INT,
      FOREIGN KEY(Branch_no)REFERENCES
       Branch(Branch_no)) ;
DESC Employee ;

# Creating Table Books. 
CREATE TABLE Books(ISBN VARCHAR(30) PRIMARY KEY,
       Book_title VARCHAR(50),Category VARCHAR(30),
       Status ENUM('Yes','No'),Author VARCHAR(30),
       Publisher VARCHAR(30)) ;
       
  DESC Books ;
 ALTER TABLE Books ADD COLUMN Rental_price DECIMAL(8,2); 
 
 # Creating Table Customer. 
 CREATE TABLE Customer(Customer_Id INT PRIMARY KEY,
        Customer_name VARCHAR(30),
        Customer_address VARCHAR(50),
        Reg_date DATE ) ;
        
  DESC Customer ; 
  
# Creating Table Issue Status. 
CREATE TABLE IssueStatus(Issue_Id INT PRIMARY KEY,
          Issued_cust INT,FOREIGN KEY(Issued_cust) REFERENCES Customer(Customer_Id),
          Issued_book_name VARCHAR (30),Issue_date DATE,
          Isbn_book VARCHAR(30),FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));
          
  DESC IssueStatus ;
  
# Creating Table ReturnStatus. 
CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY,
          Return_cust VARCHAR(30),
          Return_book_name VARCHAR(30),Return_date DATE,
		  Isbn_book2 VARCHAR(30),FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)) ;
          
  DESC ReturnStatus ;  
  
  SHOW TABLES;
  
INSERT INTO Branch (Branch_no ,Manager_Id,Branch_address,Contact_no)VALUES(
     001,1001,'001 Main St',123456789),
     (002,1002,'002 Out St',123456799),
     (003,1003,'13 Alma St',123456788),
     (004,1004,'14 Pine St',123456777) ;
 SELECT *FROM Branch ;
 
 INSERT INTO Employee( Emp_Id ,Emp_name , Position ,
	            Salary, Branch_no) VALUES(
            101,'John Bob','Manager',80000.00,001),
            (102,'Emy Linz','Assistant',40000.00,001),
            (103,'Sara John','Librarian',70000.00,001),
            (104,'Mike Turner','Clerk',35000.00,001),
            (105,'Emil Joe','Assistant',45000.00,001),
            (106,'Daniel Spencer','Clerk',50000.00,001),
            (107,'Christopher','Manager',80000.00,002),
            (108,'Hazel Lee','Assistant',35000.00,002),
            (109,'Emily Johnson','Librarian',67000.00,002),
            (110,'Ben Fenny','Manager',77000.00,003),
            (111,'Brown Lee','Librarian',68000.00,003),
            (112,'Mark Tyson','Manager',75000.00,004),
            (113,'Laura Fen','Librarian',45000.00,004),
            (114,'Philip Glen','Clerk',35000.00,004);
            
  SELECT* FROM Employee ;
  
  
INSERT INTO Books (ISBN,Book_title,Category,Rental_price,Status ,Author,Publisher)VALUES(
'978-0-44-03837-41','A Study Of History','History',17.50,'Yes','Arnold J Tonynbee','Oxford University Press'),
('978-0-19-250651-1','The Guns of August','History',27.00,'Yes','Barbara Tuchman','Presidio Press'),
('978-1-42-810832-5','Pride and Prejudice','Classic',15.50,'No','Jane Austin','Dover Publications'),
('978-1-25-023078-2','The Slient Patient','Psychology',26.00,'Yes','Alex Michaelidas','Michaelidas Publications'),
('978-0-07-553632-1','Anna Karenina','Classic',15.00,'No','Leo Tolstoy','Russian Messenger'),
('978-0-30-777366-1','Plagues and Peoples','History',15.00,'No','William H McNeill','McNeill Publishers'),
('978-6-94-52444-0','The Alchemist','Classic',25.00,'Yes','Paulo Coelho','Harper Collins Publishers'),
('978-0-55-329698-3','The Diary of a Young Girl','History',26.00,'Yes','Anna Frank','Bantam');

SELECT * FROM Books ;

INSERT INTO Customer(Customer_Id,Customer_name ,Customer_address,Reg_date )Values(

        1,'Alice Turner','12 Alma St','2021-12-04'),
        (2,'Bob Johns','32 Oak St','2021-09-18'),
        (3,'Hazel Joe','345 Walnut St','2022-09-05'),
        (4,'Henry Anderson','Perch county','2022-08-08'),
        (5,'Ben Jefferson','10 North St','2022-07-25'),
        (6,'Linz Turner','456 Elim St','2022-11-26'),
        (7,'Jack Wilson','34 Cedar St','2022-01-01'),
        (8,'Brown Fen','577 Maddi St', '2021-11-28') ;
      
 SELECT* FROM Customer ;
 
 INSERT INTO IssueStatus(Issue_Id,Issued_cust ,Issued_book_name ,
                        Issue_date,Isbn_book) VALUES(
   01,2, 'A Study Of History','2021-09-25','978-0-44-03837-41'),
  (02,3, 'The Guns of August','2022-09-10', '978-0-19-250651-1' ),
  (03,4,'The Slient Patient','2022-08-10','978-1-25-023078-2'),
  (04,5,'The Alchemist','2022-07-25','978-6-94-52444-0'),
  (05,6,'The Diary of a Young Girl','2023-06-06','978-0-55-329698-3') ;
  
SELECT * FROM IssueStatus ;

INSERT INTO ReturnStatus(Return_Id,Return_cust ,Return_book_name,
                    Return_date ,Isbn_book2)VALUES(
         '1001',2,'A Study Of History','2021-11-25','978-0-44-03837-41' ),
         ('1002',3,'The Guns of August','2022-09-30', '978-0-19-250651-1'),
         ('1003',4,'The Slient Patient','2022-09-11','978-1-25-023078-2'),
         ('1004',5,'The Alchemist','2022-08-25','978-6-94-52444-0'),
         ('1005',6,'The Diary of a Young Girl','2023-06-26','978-0-55-329698-3');
         
SELECT * FROM ReturnStatus ;

#QUERIES
#1.Retrieve the book title,Category,and rental price of all available books. 
SELECT Book_title,Category,Rental_price FROM Books WHERE Status = 'Yes';

#2.List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name,Salary FROM Employee ORDER BY Salary DESC;

#3.Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT IssueStatus.Issued_book_name,Customer.Customer_name FROM IssueStatus
INNER JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id ;

#4. Display the total count of books in each category. 
SELECT Category,COUNT(Book_title) FROM Books GROUP BY Category ;

#5.Retrieve the employee names and their positions for the employees whose salaries are above Rs.50000 . 
SELECT Emp_name,Position FROM Employee WHERE Salary > 50000 ;

#6.List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT Customer_name FROM Customer WHERE Reg_date < '2022-01-01' AND 
Customer_Id NOT IN(SELECT Issued_cust FROM IssueStatus) ;

#7.Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no,COUNT(Emp_Id) FROM Employee GROUP BY Branch_no ;

#8.Display the names of customers who have issued books in the month of June2023. 
SELECT Customer.Customer_name FROM Customer INNER JOIN IssueStatus ON
Customer.Customer_Id = IssueStatus.Issued_cust WHERE IssueStatus.Issue_date >= '2023-06-01' 
AND IssueStatus.Issue_date <= '2023-06-30';

#9.Retrieve book title from book table containing History. 
SELECT Book_title FROM Books WHERE Category = 'History';

#10.Retrieve the branch numbers along with the count of employees for branches having more than 
# 5 employees. 
SELECT Branch_no,COUNT(Emp_Id) FROM Employee GROUP BY Branch_no 
                            HAVING COUNT(Emp_Id) > 5 ;
                            
                            
#11.Retrieve the names of employees who manage branches and their respective addresses.
                            
 SELECT Branch.Branch_address,Employee.Emp_name,Position = 'Manager' FROM Branch
 INNER JOIN Employee ON Branch.Branch_no = Employee.Branch_no ;
 
 #12.Dislpay the names of customers who have issued books with a rental price 
 #higher than Rs25. 
 SELECT IssueStatus.Issued_book_name,Customer.Customer_name FROM IssueStatus
INNER JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id 
INNER JOIN Books ON IssueStatus.Isbn_book = Books.ISBN WHERE Books.Rental_price > 25 ;

##### PROJECT COMPLETED ######
         
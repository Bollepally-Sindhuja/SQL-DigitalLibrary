CREATE DATABASE library_db;
USE library_db;
Create table Books (
    BookID int primary key,
    Title varchar(100),
    Author varchar(100),
    Category varchar(50)
);
Create table Students(student_id int primary key,
student_name varchar(100),email varchar(100), join_date Date);

Create table IssuedBooks(issue_id int primary key,BookID int,
student_id int,issue_date Date,return_date Date,
foreign key(BookID) references Books(BookID),
foreign key(student_id) references Students(student_id));

insert into Books(BookID,Title,Author,Category) values
(1,'Basics of Python','Ravi','Technology'),
(2,'Space Guide','Anita','Science'),
(3,'World History','John','History'),
(4,'Coding Tips','Sneha','Technology'),
(5,'Short Stories','Arjun','Fiction'),
(6,'Java Basics','Kiran','Technology'),
(7,'Physics Intro','Meena','Science'),
(8,'Ancient India','Rahul','History'),
(9,'Web Design','Pooja','Technology'),
(10,'English Poems','Vikram','Fiction'),
(11,'Data Structures','Suresh','Technology'),
(12,'Biology Guide','Neha','Science'),
(13,'Modern History','Amit','History'),
(14,'C Programming','Divya','Technology'),
(15,'Story Book','Kavya','Fiction');

insert into Students(student_id,student_name,email,join_date) values
(101,'Ravi Kumar','ravi@gmail.com','2021-06-10'),
(102,'Anita Sharma','anita@gmail.com','2022-01-15'),
(103,'John','john@gmail.com','2020-03-20'),
(104,'Sneha Reddy','sneha@gmail.com','2019-11-05'),
(105,'Arjun','arjun@gmail.com','2018-08-25'),
(106,'Kiran Kumar','kiran@gmail.com','2021-09-12'),
(107,'Meena','meena@gmail.com','2023-02-18'),
(108,'Rahul','rahul@gmail.com','2020-07-25'),
(109,'Pooja Verma','pooja@gmail.com','2022-11-30'),
(110,'Vikram Rao','vikram@gmail.com','2019-05-14'),
(111,'Suresh Babu','suresh@gmail.com','2018-12-01'),
(112,'Neha Singh','neha@gmail.com','2023-06-20'),
(113,'Amit','amit@gmail.com','2021-03-10'),
(114,'Divya Sharma','divya@gmail.com','2022-08-05'),
(115,'Kavya Reddy','kavya@gmail.com','2020-10-22');

insert into IssuedBooks(issue_id,BookID,student_id,issue_date,return_date) values
(1001, 1, 101, '2026-03-28', '2026-04-10'), 
(1002, 2, 102, '2026-04-07', NULL),
(1003, 3, 103, '2025-03-18', '2025-03-23'),
(1004, 4, 104, '2026-03-08', NULL),
(1005, 5, 101, '2026-04-12', NULL),
(1006, 1, 102, '2026-02-16', '2026-02-26'),
(1007, 2, 103, '2026-04-02', NULL),
(1008, 6, 106, '2026-03-23', NULL),
(1009, 7, 107, '2026-04-10', NULL),
(1010, 8, 108, '2025-02-26', '2025-03-08'),
(1011, 1, 112, '2026-02-20', '2026-04-10'),
(1012, 5, 105, '2019-01-10', '2019-01-14');
select * from Books;

select * from Students;

select * from IssuedBooks;


-- Overdue books are identified by checking if the return date is NULL and the issue date is older than 14 days.
Select s.student_id,s.student_name,b.Title,ib.issue_date
from IssuedBooks ib
JOIN Students s ON ib.student_id=s.student_id
JOIN Books b ON ib.BookID=b.BookID
Where ib.return_date IS NULL
AND ib.issue_date < CURDATE() - INTERVAL 14 DAY;

-- Genre that borrowed the most
SELECT b.Category,
COUNT(*) AS Borrow_Count
from IssuedBooks ib JOIN Books b ON ib.BookID=b.BookID
GROUP BY b.Category ORDER BY Borrow_Count DESC;

SELECT b.Category,
COUNT(*) AS Borrow_Count
from IssuedBooks ib JOIN Books b ON ib.BookID=b.BookID
GROUP BY b.Category ORDER BY Borrow_Count DESC Limit 1;

Alter Table Students Add Status Varchar(20);

UPDATE Students SET Status = 'Active';

-- Inactive accounts
Update Students Set Status = 'Inactive'
WHERE student_id NOT IN(
Select distinct student_id
from IssuedBooks where issue_date >= CURDATE() - INTERVAL 3 YEAR
);

SELECT student_id, student_name,Status
FROM Students
WHERE Status = 'Inactive';

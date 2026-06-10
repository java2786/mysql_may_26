# 02_SQL_Practice_Workbook.md

# MySQL SQL Practice Workbook

## School Examination Management System

### Objective

In this workbook, you will practice SQL using:

- SELECT
- WHERE
- ORDER BY
- LIMIT
- Aggregate Functions
  - COUNT()
  - SUM()
  - AVG()
  - MIN()
  - MAX()
- GROUP BY
- HAVING
- Nested Subqueries

Rules:

- Do NOT use JOINs.
- Do NOT use Window Functions.
- Try solving each problem before looking at solutions.
- Focus on understanding the logic rather than memorizing queries.

---

# PART A - DATABASE SETUP

## Create Database

```sql
CREATE DATABASE SchoolExamDB;

USE SchoolExamDB;
```

---

## Create Tables

```sql
CREATE TABLE Students (
    id INT PRIMARY KEY,
    roll_number INT UNIQUE NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    class VARCHAR(10) NOT NULL
);

CREATE TABLE Subjects (
    id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL
);

CREATE TABLE Scores (
    std_id INT,
    sub_id INT,
    marks INT,
    PRIMARY KEY(std_id, sub_id),
    FOREIGN KEY(std_id) REFERENCES Students(id),
    FOREIGN KEY(sub_id) REFERENCES Subjects(id)
);
```

---

## Insert Sample Data

```sql
INSERT INTO Students VALUES
(1,101,'Rahul Sharma','9A'),
(2,102,'Priya Verma','9A'),
(3,103,'Amit Patel','9B'),
(4,104,'Neha Gupta','10A'),
(5,105,'Karan Singh','10B'),
(6,106,'Riya Shah','10B'),
(7,107,'Mohit Jain','9A');

INSERT INTO Subjects VALUES
(1,'Mathematics'),
(2,'Science'),
(3,'English'),
(4,'Social Studies'),
(5,'Computer');

INSERT INTO Scores VALUES

(1,1,85),
(1,2,78),
(1,3,92),
(1,4,81),
(1,5,88),

(2,1,65),
(2,2,72),
(2,3,75),
(2,4,68),
(2,5,70),

(3,1,95),
(3,2,91),
(3,3,89),
(3,4,93),
(3,5,97),

(4,1,58),
(4,2,61),
(4,3,66),
(4,4,55),
(4,5,60),

(5,1,82),
(5,2,84),
(5,3,79),
(5,4,88),
(5,5,90),

(6,1,73),
(6,2,77),
(6,3,69),
(6,4,80),
(6,5,74);
```

---

# PART B - BASIC FILTERING (15 QUESTIONS)

### Question 1

Display all students.

---

### Question 2

Display all subjects.

---

### Question 3

Display all score records.

---

### Question 4

Display students from Class 9A.

---

### Question 5

Display students from Class 10B.

---

### Question 6

Display the student having Roll Number 103.

---

### Question 7

Display the subject having Subject ID 3.

---

### Question 8

Display score records having marks greater than 80.

---

### Question 9

Display score records having marks less than 60.

---

### Question 10

Display score records having marks between 70 and 90.

---

### Question 11

Display students whose name starts with 'R'.

---

### Question 12

Display students whose name ends with 'a'.

---

### Question 13

Display students sorted by name.

---

### Question 14

Display subjects sorted alphabetically.

---

### Question 15

Display score records sorted by marks descending.

---

# PART C - ORDER BY AND LIMIT (10 QUESTIONS)

### Question 16

Display the top 5 highest score records.

---

### Question 17

Display the lowest 3 score records.

---

### Question 18

Display the highest score recorded in the database.

---

### Question 19

Display the second highest score recorded in the database.

---

### Question 20

Display the third highest score recorded in the database.

---

### Question 21

Display the top 3 students based on Roll Number.

---

### Question 22

Display the latest 2 inserted students based on ID.

---

### Question 23

Display the highest scoring subject entry.

---

### Question 24

Display the lowest scoring subject entry.

---

### Question 25

Display top 10 score records sorted by marks.

---

# PART D - AGGREGATE FUNCTIONS (10 QUESTIONS)

### Question 26

Count total students.

---

### Question 27

Count total subjects.

---

### Question 28

Count total score records.

---

### Question 29

Find highest marks.

---

### Question 30

Find lowest marks.

---

### Question 31

Find average marks.

---

### Question 32

Find total marks scored in the database.

---

### Question 33

Find total marks scored by Student ID 1.

---

### Question 34

Find average marks in Mathematics.

---

### Question 35

Find total students belonging to Class 9A.

---

# PART E - GROUP BY (15 QUESTIONS)

### Question 36

Find total marks scored by each student.

---

### Question 37

Find average marks scored by each student.

---

### Question 38

Find highest marks scored by each student.

---

### Question 39

Find lowest marks scored by each student.

---

### Question 40

Count score records for each student.

---

### Question 41

Find average marks for each subject.

---

### Question 42

Find highest marks for each subject.

---

### Question 43

Find lowest marks for each subject.

---

### Question 44

Count students appearing in each subject.

---

### Question 45

Count students in each class.

---

### Question 46

Find total marks for each subject.

---

### Question 47

Find subjects where average marks exceed 75.

---

### Question 48

Find students whose average marks exceed 80.

---

### Question 49

Find students having more than 4 score records.

---

### Question 50

Find subjects having at least 5 score records.

---

# PART F - HAVING CLAUSE (10 QUESTIONS)

### Question 51

Find students whose total marks exceed 400.

---

### Question 52

Find students whose average marks exceed 80.

---

### Question 53

Find students whose lowest marks are below 70.

---

### Question 54

Find students whose highest marks exceed 90.

---

### Question 55

Find subjects whose average marks exceed 80.

---

### Question 56

Find subjects whose maximum marks exceed 90.

---

### Question 57

Find students who never scored below 70.

---

### Question 58

Find students who scored below 75 in more than one subject.

---

### Question 59

Find subjects having at least 6 score records.

---

### Question 60

Find classes having more than one student.

---

# PART G - NESTED SUBQUERY CHALLENGES (20 QUESTIONS)

### Question 61

Find students whose total marks are greater than the average total marks of all students.

---

### Question 62

Find subjects whose average marks are below the overall average marks.

---

### Question 63

Find the subject having the highest average marks.

---

### Question 64

Find the subject having the lowest average marks.

---

### Question 65

Find students who scored higher than the maximum score in Mathematics.

---

### Question 66

Find students who appeared in every subject.

---

### Question 67

Find students who have exactly one score record.

---

### Question 68

Find subjects that never received a score above 80.

---

### Question 69

Find students whose highest and lowest marks differ by at least 15.

---

### Question 70

Find the second-highest mark in the database.

---

### Question 71

Find all records having the second-highest mark.

---

### Question 72

Find students who scored below 75 in more than one subject.

---

### Question 73

Find subjects having the same number of score entries as Science.

---

### Question 74

Find students who have never appeared for any examination.

---

### Question 75

Find top 3 students based on total marks.

---

### Question 76

Find subjects having at least three score entries and display them in descending subject-name order.

---

### Question 77

Find students whose total marks are greater than the average total marks of their own class.

---

### Question 78

Find subjects whose average marks are greater than the average marks of Mathematics.

---

### Question 79

Find students whose average marks are greater than the overall average marks.

---

### Question 80

Find the class whose average student performance is highest.

---

# Completion Checklist

Before moving to JOINs, ensure you can confidently solve:

- WHERE
- ORDER BY
- LIMIT
- COUNT
- SUM
- AVG
- MIN
- MAX
- GROUP BY
- HAVING
- Scalar Subqueries
- Aggregate Subqueries
- Top-N Problems
- Relational Division Problems

If you can solve most of the 80 questions without help, you are ready to learn:

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- SELF JOIN
- Multiple Table Reporting Queries
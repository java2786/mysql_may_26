# Window Functions in MySQL - Made Simple  
  
## What Are Window Functions?  
  
Imagine you're looking through a window at a group of people standing in a line. You can see each person individually, but you can also see information about the whole group or sections of the group. That's exactly what window functions do with data!  
  
**Key Difference from GROUP BY:**  
- **GROUP BY**: Collapses rows into groups (you lose individual row details)  
- **Window Functions**: Keep all individual rows while adding group-level information  
  
Think of it this way:  
- GROUP BY is like taking a class photo where you only see the group  
- Window Functions are like a video where you see each student AND their class rank  
  
---  
  
## Setup: Simple Employee Salary Table  
  
```sql  
CREATE DATABASE company_db;  
USE company_db;  
  
CREATE TABLE employees (  
    emp_id INT PRIMARY KEY,  
    emp_name VARCHAR(50),  
    department VARCHAR(30),  
    salary INT  
);  
  
INSERT INTO employees VALUES  
(1, 'Suresh', 'Sales', 50000),  
(2, 'Ramesh', 'Sales', 60000),  
(3, 'Mahesh', 'IT', 70000),  
(4, 'Dinesh', 'IT', 65000),  
(5, 'Mukesh', 'HR', 45000),  
(6, 'Kamlesh', 'Sales', 55000),  
(7, 'Nitesh', 'IT', 80000),  
(8, 'Hitesh', 'HR', 48000);  
```  
  
---  
  
## Basic Syntax  
  
```sql  
<window_function>() OVER (  
    [PARTITION BY column]  -- Optional: Divide data into groups  
    [ORDER BY column]      -- Optional: Define row order  
)  
```  
  
---  
  
## 1. ROW_NUMBER() - Give Each Row a Unique Number  
  
### Without PARTITION (Entire Table)  
  
**Question:** Give a serial number to all employees.  
  
```sql  
SELECT emp_name, department, salary,  
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num  
FROM employees;  
```  
  
**Output:**  
```  
emp_name  | department | salary | row_num  
----------|------------|--------|--------  
Nitesh    | IT         | 80000  | 1  
Mahesh    | IT         | 70000  | 2  
Dinesh    | IT         | 65000  | 3  
Ramesh    | Sales      | 60000  | 4  
Kamlesh   | Sales      | 55000  | 5  
Suresh    | Sales      | 50000  | 6  
Hitesh    | HR         | 48000  | 7  
Mukesh    | HR         | 45000  | 8  
```  
  
**What happened?**  
- Each employee gets a unique number  
- Numbers go from 1 to 8 (total employees)  
- Ordered by salary (highest first)  
  
### With PARTITION (Separate Groups)  
  
**Question:** Give a serial number to employees within each department.  
  
```sql  
SELECT emp_name, department, salary,  
       ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_row_num  
FROM employees;  
```  
  
**Output:**  
```  
emp_name  | department | salary | dept_row_num  
----------|------------|--------|-------------  
Hitesh    | HR         | 48000  | 1  
Mukesh    | HR         | 45000  | 2  
Nitesh    | IT         | 80000  | 1  
Mahesh    | IT         | 70000  | 2  
Dinesh    | IT         | 65000  | 3  
Ramesh    | Sales      | 60000  | 1  
Kamlesh   | Sales      | 55000  | 2  
Suresh    | Sales      | 50000  | 3  
```  
  
**What happened?**  
- Numbers restart for each department (HR: 1-2, IT: 1-3, Sales: 1-3)  
- PARTITION BY creates separate "windows" for each department  
- Within each department, rows are numbered by salary  
  
**Real-Life Use:** Find the top 2 earners in each department.  
  
```sql  
SELECT * FROM (  
    SELECT emp_name, department, salary,  
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn  
    FROM employees  
) AS ranked  
WHERE rn <= 2;  
```  
  
---  
  
## 2. RANK() - Ranking with Gaps  
  
### Sample Data with Ties  
  
```sql  
-- Let's add employees with same salaries  
INSERT INTO employees VALUES  
(9, 'Ratnesh', 'Sales', 60000),   -- Same as Ramesh  
(10, 'Himesh', 'IT', 70000);       -- Same as Mahesh  
```  
  
**Question:** Rank employees by salary (show ties and gaps).  
  
```sql  
SELECT emp_name, salary,  
       RANK() OVER (ORDER BY salary DESC) AS salary_rank  
FROM employees;  
```  
  
**Output:**  
```  
emp_name  | salary | salary_rank  
----------|--------|------------  
Nitesh    | 80000  | 1  
Mahesh    | 70000  | 2  
Himesh    | 70000  | 2  ← Tie (both get rank 2)  
Dinesh    | 65000  | 4  ← Gap! (skipped rank 3)  
Ramesh    | 60000  | 5  
Ratnesh   | 60000  | 5  ← Tie again  
Kamlesh   | 55000  | 7  ← Gap! (skipped rank 6)  
Suresh    | 50000  | 8  
Hitesh    | 48000  | 9  
Mukesh    | 45000  | 10  
```  
  
**Key Point:**   
- When 2 people tie for rank 2, the next rank is 4 (not 3)  
- Rank 3 is "skipped" or has a "gap"  
- Think of Olympic medals: If two people win silver, next is bronze (no in-between)  
  
---  
  
## 3. DENSE_RANK() - Ranking without Gaps  
  
**Question:** Rank employees by salary (no gaps even with ties).  
  
```sql  
SELECT emp_name, salary,  
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_salary_rank  
FROM employees;  
```  
  
**Output:**  
```  
emp_name  | salary | dense_salary_rank  
----------|--------|------------------  
Nitesh    | 80000  | 1  
Mahesh    | 70000  | 2  
Himesh    | 70000  | 2  ← Tie  
Dinesh    | 65000  | 3  ← No gap! (rank 3 follows 2)  
Ramesh    | 60000  | 4  
Ratnesh   | 60000  | 4  ← Tie  
Kamlesh   | 55000  | 5  ← No gap! (rank 5 follows 4)  
Suresh    | 50000  | 6  
Hitesh    | 48000  | 7  
Mukesh    | 45000  | 8  
```  
  
**Key Point:**  
- No gaps in ranking  
- Sequential numbers: 1, 2, 2, 3, 4, 4, 5, 6, 7, 8  
  
### Quick Comparison  
  
```sql  
SELECT emp_name, salary,  
       RANK() OVER (ORDER BY salary DESC) AS rank_with_gaps,  
       DENSE_RANK() OVER (ORDER BY salary DESC) AS rank_no_gaps,  
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS unique_row_num  
FROM employees;  
```  
  
**Output:**  
```  
emp_name  | salary | rank_with_gaps | rank_no_gaps | unique_row_num  
----------|--------|----------------|--------------|---------------  
Nitesh    | 80000  | 1              | 1            | 1  
Mahesh    | 70000  | 2              | 2            | 2  
Himesh    | 70000  | 2              | 2            | 3  ← Always unique  
Dinesh    | 65000  | 4              | 3            | 4  ← Notice gaps  
Ramesh    | 60000  | 5              | 4            | 5  
Ratnesh   | 60000  | 5              | 4            | 6  
Kamlesh   | 55000  | 7              | 5            | 7  
```  
  
**When to Use What?**  
- **ROW_NUMBER()**: When you need strictly unique numbers (pagination, ID assignment)  
- **RANK()**: When you want to show ties but maintain traditional ranking (sports leaderboards)  
- **DENSE_RANK()**: When you want consecutive ranks without gaps (competitive exams, grade distribution)  
  
---  
  
## 4. Aggregate Window Functions  
  
### Sample Sales Data  
  
```sql  
CREATE TABLE sales (  
    sale_id INT PRIMARY KEY,  
    salesperson VARCHAR(50),  
    month_name VARCHAR(20),  
    sale_amount INT  
);  
  
INSERT INTO sales VALUES  
(1, 'Suresh', 'January', 10000),  
(2, 'Suresh', 'February', 15000),  
(3, 'Suresh', 'March', 12000),  
(4, 'Ramesh', 'January', 8000),  
(5, 'Ramesh', 'February', 9000),  
(6, 'Ramesh', 'March', 11000);  
```  
  
### Running Total (Cumulative Sum)  
  
**Question:** Show each sale with a running total for each salesperson.  
  
```sql  
SELECT salesperson, month_name, sale_amount,  
       SUM(sale_amount) OVER (  
           PARTITION BY salesperson   
           ORDER BY sale_id  
       ) AS running_total  
FROM sales;  
```  
  
**Output:**  
```  
salesperson | month_name | sale_amount | running_total  
------------|------------|-------------|---------------  
Suresh      | January    | 10000       | 10000  
Suresh      | February   | 15000       | 25000  ← (10000 + 15000)  
Suresh      | March      | 12000       | 37000  ← (25000 + 12000)  
Ramesh      | January    | 8000        | 8000  
Ramesh      | February   | 9000        | 17000  ← (8000 + 9000)  
Ramesh      | March      | 11000       | 28000  ← (17000 + 11000)  
```  
  
**What happened?**  
- Each salesperson's total accumulates month by month  
- PARTITION BY separates calculations per person  
- ORDER BY ensures chronological accumulation  
  
### Average Comparison  
  
**Question:** Show each sale compared to the person's average.  
  
```sql  
SELECT salesperson, month_name, sale_amount,  
       AVG(sale_amount) OVER (PARTITION BY salesperson) AS person_avg,  
       sale_amount - AVG(sale_amount) OVER (PARTITION BY salesperson) AS diff_from_avg  
FROM sales;  
```  
  
**Output:**  
```  
salesperson | month_name | sale_amount | person_avg | diff_from_avg  
------------|------------|-------------|------------|---------------  
Suresh      | January    | 10000       | 12333      | -2333  
Suresh      | February   | 15000       | 12333      | +2667  
Suresh      | March      | 12000       | 12333      | -333  
Ramesh      | January    | 8000        | 9333       | -1333  
Ramesh      | February   | 9000        | 9333       | -333  
Ramesh      | March      | 11000       | 9333       | +1667  
```  
  
**Real-Life Use:** Identify performance above or below personal average.  
  
---  
  
## 5. Moving Average (Advanced)  
  
**Question:** Calculate 2-month moving average for each salesperson.  
  
```sql  
SELECT salesperson, month_name, sale_amount,  
       AVG(sale_amount) OVER (  
           PARTITION BY salesperson   
           ORDER BY sale_id   
           ROWS BETWEEN 1 PRECEDING AND CURRENT ROW  
       ) AS moving_avg_2_months  
FROM sales;  
```  
  
**Output:**  
```  
salesperson | month_name | sale_amount | moving_avg_2_months  
------------|------------|-------------|--------------------  
Suresh      | January    | 10000       | 10000  ← Only current row  
Suresh      | February   | 15000       | 12500  ← (10000+15000)/2  
Suresh      | March      | 12000       | 13500  ← (15000+12000)/2  
Ramesh      | January    | 8000        | 8000  
Ramesh      | February   | 9000        | 8500   ← (8000+9000)/2  
Ramesh      | March      | 11000       | 10000  ← (9000+11000)/2  
```  
  
**What is ROWS BETWEEN?**  
- `1 PRECEDING`: Look at 1 row before current row  
- `CURRENT ROW`: Include current row  
- Together: Average of current and previous row  
  
---  
  
## 6. Real-World Student Marks Example  
  
```sql  
CREATE TABLE student_marks (  
    student_id INT PRIMARY KEY,  
    student_name VARCHAR(50),  
    class VARCHAR(10),  
    subject VARCHAR(20),  
    marks INT  
);  
  
INSERT INTO student_marks VALUES  
(1, 'Suresh', '10A', 'Math', 85),  
(2, 'Ramesh', '10A', 'Math', 90),  
(3, 'Mahesh', '10A', 'Math', 78),  
(4, 'Dinesh', '10B', 'Math', 88),  
(5, 'Mukesh', '10B', 'Math', 92),  
(6, 'Suresh', '10A', 'Science', 80),  
(7, 'Ramesh', '10A', 'Science', 85),  
(8, 'Mahesh', '10A', 'Science', 75);  
```  
  
### Find Class Toppers  
  
**Question:** Rank students in each class for each subject.  
  
```sql  
SELECT student_name, class, subject, marks,  
       RANK() OVER (  
           PARTITION BY class, subject   
           ORDER BY marks DESC  
       ) AS class_rank  
FROM student_marks;  
```  
  
**Output:**  
```  
student_name | class | subject | marks | class_rank  
-------------|-------|---------|-------|------------  
Ramesh       | 10A   | Math    | 90    | 1  ← Topper  
Suresh       | 10A   | Math    | 85    | 2  
Mahesh       | 10A   | Math    | 78    | 3  
Ramesh       | 10A   | Science | 85    | 1  ← Topper  
Suresh       | 10A   | Science | 80    | 2  
Mahesh       | 10A   | Science | 75    | 3  
Mukesh       | 10B   | Math    | 92    | 1  ← Topper  
Dinesh       | 10B   | Math    | 88    | 2  
```  
  
### Get Only Toppers (Rank 1)  
  
```sql  
SELECT * FROM (  
    SELECT student_name, class, subject, marks,  
           RANK() OVER (PARTITION BY class, subject ORDER BY marks DESC) AS class_rank  
    FROM student_marks  
) AS ranked_students  
WHERE class_rank = 1;  
```  
  
**Output:**  
```  
student_name | class | subject | marks | class_rank  
-------------|-------|---------|-------|------------  
Ramesh       | 10A   | Math    | 90    | 1  
Ramesh       | 10A   | Science | 85    | 1  
Mukesh       | 10B   | Math    | 92    | 1  
```  
  
---  
  
## 7. Understanding PARTITION BY vs GROUP BY  
  
### Using GROUP BY (Collapses Rows)  
  
```sql  
SELECT department, AVG(salary) AS avg_salary  
FROM employees  
GROUP BY department;  
```  
  
**Output:**  
```  
department | avg_salary  
-----------|------------  
HR         | 46500  
IT         | 71250  
Sales      | 56250  
```  
  
**You lose individual employee details!**  
  
### Using Window Function (Keeps All Rows)  
  
```sql  
SELECT emp_name, department, salary,  
       AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary  
FROM employees;  
```  
  
**Output:**  
```  
emp_name  | department | salary | dept_avg_salary  
----------|------------|--------|----------------  
Mukesh    | HR         | 45000  | 46500  
Hitesh    | HR         | 48000  | 46500  
Dinesh    | IT         | 65000  | 71250  
Mahesh    | IT         | 70000  | 71250  
Himesh    | IT         | 70000  | 71250  
Nitesh    | IT         | 80000  | 71250  
Suresh    | Sales      | 50000  | 56250  
Kamlesh   | Sales      | 55000  | 56250  
Ramesh    | Sales      | 60000  | 56250  
Ratnesh   | Sales      | 60000  | 56250  
```  
  
**Now you can see:**  
- Individual employee names and salaries  
- Department average for each employee  
- Easy to compare: "Is this employee above or below department average?"  
  
---  
  
## Common Patterns and Use Cases  
  
### Pattern 1: Top N per Group  
  
**Use Case:** Find top 3 earners in each department.  
  
```sql  
SELECT * FROM (  
    SELECT emp_name, department, salary,  
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn  
    FROM employees  
) AS ranked  
WHERE rn <= 3;  
```  
  
### Pattern 2: Percentage of Total  
  
**Use Case:** Show each employee's salary as percentage of total department salary.  
  
```sql  
SELECT emp_name, department, salary,  
       SUM(salary) OVER (PARTITION BY department) AS dept_total,  
       ROUND((salary * 100.0) / SUM(salary) OVER (PARTITION BY department), 2) AS pct_of_dept  
FROM employees;  
```  
  
### Pattern 3: Compare with Previous Row  
  
**Use Case:** Show month-over-month sales growth.  
  
```sql  
SELECT salesperson, month_name, sale_amount,  
       LAG(sale_amount) OVER (PARTITION BY salesperson ORDER BY sale_id) AS prev_month_sale,  
       sale_amount - LAG(sale_amount) OVER (PARTITION BY salesperson ORDER BY sale_id) AS growth  
FROM sales;  
```  
  
---  
  
## Key Concepts Summary  
  
### 1. **Window = Frame of Reference**  
Think of OVER() as creating a "view" or "window" through which you look at data.  
  
### 2. **PARTITION BY = Create Groups**  
- Divides data into separate buckets  
- Calculations restart for each bucket  
- Like creating mini-tables within your query  
  
### 3. **ORDER BY = Define Sequence**  
- Determines the order for ranking and running totals  
- Critical for functions like ROW_NUMBER, RANK, cumulative SUM  
  
### 4. **All Rows Preserved**  
- Unlike GROUP BY, you see every original row  
- Each row gets additional calculated information  
  
---  
  
## Practice Exercises  
  
### Exercise 1  
Create a query to rank products by price within each category.  
  
```sql  
CREATE TABLE products (  
    product_id INT PRIMARY KEY,  
    product_name VARCHAR(50),  
    category VARCHAR(30),  
    price INT  
);  
  
INSERT INTO products VALUES  
(1, 'iPhone 15', 'Mobile', 80000),  
(2, 'Samsung S24', 'Mobile', 75000),  
(3, 'OnePlus 12', 'Mobile', 65000),  
(4, 'Dell XPS', 'Laptop', 120000),  
(5, 'HP Pavilion', 'Laptop', 55000),  
(6, 'MacBook Pro', 'Laptop', 180000);  
  
-- Your query here  
```  
  
<details>  
<summary>Solution</summary>  
  
```sql  
SELECT product_name, category, price,  
       RANK() OVER (PARTITION BY category ORDER BY price DESC) AS price_rank  
FROM products;  
```  
</details>  
  
### Exercise 2  
Find the 2nd highest salary in each department.  
  
<details>  
<summary>Solution</summary>  
  
```sql  
SELECT * FROM (  
    SELECT emp_name, department, salary,  
           DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank  
    FROM employees  
) AS ranked  
WHERE salary_rank = 2;  
```  
</details>  
  
### Exercise 3  
Calculate running total of sales for each salesperson month by month.  
  
<details>  
<summary>Solution</summary>  
  
```sql  
SELECT salesperson, month_name, sale_amount,  
       SUM(sale_amount) OVER (PARTITION BY salesperson ORDER BY sale_id) AS running_total  
FROM sales;  
```  
</details>  
  
---  
  
## Quick Reference Card  
  
| Function | Purpose | Example Use |  
|----------|---------|-------------|  
| ROW_NUMBER() | Unique sequential number | Pagination, unique IDs |  
| RANK() | Ranking with gaps | Sports rankings, leaderboards |  
| DENSE_RANK() | Ranking without gaps | Grade distribution, exam ranks |  
| SUM() OVER | Running total | Cumulative sales, account balance |  
| AVG() OVER | Average in partition | Compare to department average |  
| LAG() | Previous row value | Month-over-month comparison |  
| LEAD() | Next row value | Forecasting, predictions |  
  
---  
  
## Common Mistakes to Avoid  
  
### Mistake 1: Forgetting ORDER BY for Rankings  
  
```sql  
-- Wrong: No clear order  
SELECT emp_name, salary,  
       RANK() OVER () AS rank  
FROM employees;  
  
-- Correct: Always specify ORDER BY  
SELECT emp_name, salary,  
       RANK() OVER (ORDER BY salary DESC) AS rank  
FROM employees;  
```  
  
### Mistake 2: Using GROUP BY When Window Function Needed  
  
```sql  
-- Wrong: Loses individual rows  
SELECT department, AVG(salary) AS avg_sal  
FROM employees  
GROUP BY department;  
  
-- Correct: Keeps all rows with average  
SELECT emp_name, department, salary,  
       AVG(salary) OVER (PARTITION BY department) AS dept_avg  
FROM employees;  
```  
  
### Mistake 3: Confusing PARTITION BY with WHERE  
  
```sql  
-- PARTITION BY divides for calculation (not filtering)  
-- WHERE filters which rows to show  
  
-- This shows all IT employees with their department's average  
SELECT emp_name, salary,  
       AVG(salary) OVER (PARTITION BY department) AS dept_avg  
FROM employees  
WHERE department = 'IT';  
```  
  
---  
  
## Remember  
  
1. **Window functions do not reduce rows** (unlike GROUP BY)  
2. **OVER() is mandatory** for window functions  
3. **PARTITION BY is optional** (without it, entire table is one window)  
4. **ORDER BY matters** for rankings and running calculations  
5. **Practice with real data** to build intuition  
  
---  
  
## Next Steps  
  
1. Try all examples in your MySQL environment  
2. Create your own tables with Indian context (cricket scores, e-commerce orders)  
3. Combine window functions with JOIN operations  
4. Explore LAG() and LEAD() for time-series analysis  
5. Use window functions in complex reports  
  
**Happy Learning! Practice makes perfect!**
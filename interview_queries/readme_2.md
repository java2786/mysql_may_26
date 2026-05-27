# MySQL Basics - Part 2  
  
## Update Queries  
  
### Update marks of a student  
```sql  
update Students  
set marks = 91  
where name = 'Ramesh';  
```  
  
### Update class of a student  
```sql  
update Students  
set class = '10A'  
where name = 'Suresh';  
```  
  
### Increase marks by 5 for all students  
```sql  
update Students  
set marks = marks + 5;  
```  
  
### Increase marks by 2 for only class 9A students  
```sql  
update Students  
set marks = marks + 2  
where class = '9A';  
```  
  
---  
  
# Delete Queries  
  
## Delete a student using roll number  
```sql  
delete from Students  
where roll = 3;  
```  
  
## Delete all students from class 8A  
```sql  
delete from Students  
where class = '8A';  
```  
  
## Delete students with marks less than 80  
```sql  
delete from Students  
where marks < 80;  
```  
  
---  
  
# More Insert Queries  
  
## Insert one student  
```sql  
insert into Students(name, class, marks)  
values('Naresh', '10B', 87);  
```  
  
## Insert multiple students  
```sql  
insert into Students(name, class, marks)  
values  
('Rajesh', '8B', 67),  
('Kamlesh', '10A', 92),  
('Vikas', '9C', 81);  
```  
  
---  
  
# Select Queries with Multiple Conditions  
  
## Find students from class 9A with marks greater than 85  
```sql  
select * from Students  
where class = '9A'  
and marks > 85;  
```  
  
## Find students from class 9A or 9B  
```sql  
select * from Students  
where class = '9A'  
or class = '9B';  
```  
  
## Find students whose marks are exactly 89  
```sql  
select * from Students  
where marks = 89;  
```  
  
## Find students whose marks are not equal to 89  
```sql  
select * from Students  
where marks != 89;  
```  
  
---  
  
# LIKE Operator Examples  
  
## Find students whose name starts with M  
```sql  
select * from Students  
where name like 'M%';  
```  
  
## Find students whose name ends with h  
```sql  
select * from Students  
where name like '%h';  
```  
  
## Find students whose name contains es  
```sql  
select * from Students  
where name like '%es%';  
```  
  
## Find students whose class starts with 10  
```sql  
select * from Students  
where class like '10%';  
```  
  
---  
  
# ORDER BY Examples  
  
## Display students in ascending order of marks  
```sql  
select * from Students  
order by marks asc;  
```  
  
## Display students in descending order of marks  
```sql  
select * from Students  
order by marks desc;  
```  
  
## Display students sorted by name  
```sql  
select * from Students  
order by name;  
```  
  
## Display top scoring students first  
```sql  
select * from Students  
order by marks desc;  
```  
  
---  
  
# LIMIT Examples  
  
## Display first 3 students  
```sql  
select * from Students  
limit 3;  
```  
  
## Display top 2 scoring students  
```sql  
select * from Students  
order by marks desc  
limit 2;  
```  
  
## Display lowest scoring student  
```sql  
select * from Students  
order by marks asc  
limit 1;  
```  
  
---  
  
# BETWEEN Operator  
  
## Find students with marks between 80 and 90  
```sql  
select * from Students  
where marks between 80 and 90;  
```  
  
## Find students from roll number 2 to 5  
```sql  
select * from Students  
where roll between 2 and 5;  
```  
  
---  
  
# IN Operator  
  
## Find students from class 9A and 10A  
```sql  
select * from Students  
where class in ('9A', '10A');  
```  
  
## Find students with marks 78, 88, or 95  
```sql  
select * from Students  
where marks in (78, 88, 95);  
```  
  
---  
  
# DISTINCT Keyword  
  
## Display all unique classes  
```sql  
select distinct class from Students;  
```  
  
## Display unique marks  
```sql  
select distinct marks from Students;  
```  
  
---  
  
# Interview Questions  
  
- Find all students whose name starts with S  
- Find all students whose name ends with sh  
- Display students in descending order of marks  
- Display top 3 students based on marks  
- Find all students between roll number 2 and 5  
- Find all students from class 9A and 10A  
- Increase marks of all students by 10  
- Delete students who scored below 70  
- Find all unique classes  
- Find students whose marks are between 85 and 95  
- Find students whose class starts with 10  
- Find students whose marks are not equal to 89  
  
---  
  
# Solutions  
  
## Find all students whose name starts with S  
```sql  
select * from Students  
where name like 'S%';  
```  
  
## Find all students whose name ends with sh  
```sql  
select * from Students  
where name like '%sh';  
```  
  
## Display students in descending order of marks  
```sql  
select * from Students  
order by marks desc;  
```  
  
## Display top 3 students based on marks  
```sql  
select * from Students  
order by marks desc  
limit 3;  
```  
  
## Find all students between roll number 2 and 5  
```sql  
select * from Students  
where roll between 2 and 5;  
```  
  
## Find all students from class 9A and 10A  
```sql  
select * from Students  
where class in ('9A', '10A');  
```  
  
## Increase marks of all students by 10  
```sql  
update Students  
set marks = marks + 10;  
```  
  
## Delete students who scored below 70  
```sql  
delete from Students  
where marks < 70;  
```  
  
## Find all unique classes  
```sql  
select distinct class from Students;  
```  
  
## Find students whose marks are between 85 and 95  
```sql  
select * from Students  
where marks between 85 and 95;  
```  
  
## Find students whose class starts with 10  
```sql  
select * from Students  
where class like '10%';  
```  
  
## Find students whose marks are not equal to 89  
```sql  
select * from Students  
where marks != 89;  
```
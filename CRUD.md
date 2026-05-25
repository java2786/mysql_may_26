## 1. Entry into database server / mysql server
> open your cmd and type any below command
```bash
mysql --host localhost --port 3306 -u root -p
mysql --host localhost -u root -p
mysql --port 3306 -u root -p
mysql -P 3306 -u root -p
mysql -u root -p

mysql -u root -proot

```

## 2. Create database and get into it

```sql
drop database if exists tutorial;
create database if not exists tutorial;

show databases;
select database();
use tutorial;
```

## 3. Create table

```sql
show tables;

create table students(
    name varchar(30),
    course varchar(30),
    dob date,  -- yyyy-mm-dd
    email varchar(30),
    score int
);

show tables;

```




## Read data from table

```sql
select * from students;
```

## Store data into table

```sql
desc students;

insert into students values("Dinesh", "Java");  -- error
insert into students values("Dinesh", "Java", "2011-07-23", "din@gmail.com",78);  
insert into students values("Ganesh@gmail.com", "Ganesh", "2011-07-23", "Python",78);  

insert into students(name, dob, email) 
values("Ramesh", "2012-11-21", "ram@gmail.com");


```

## Delete from table

```sql
delete from students where course = "Ganesha";
```

## Update table data

```sql
update students set course="DSA" where name = "Ramesh";
```


## Update table

### delete and create table again

```sql
drop table students;

create table students(
    name varchar(30),
    course varchar(50),
    dob date,  -- yyyy-mm-dd
    email varchar(30),
    phone varchar(10),
    score int
);


-- OR better way

alter table students add column phone varchar(10);
alter table students modify column course varchar(50);
```

## Constraints 

```sql
drop table students;

create table students(
    name varchar(30),
    course varchar(30),
    dob date not null,  -- yyyy-mm-dd
    roll int primary key auto_increment,
    email varchar(30) not null unique,
    score int default 100,
    gendar enum('Male', 'Female') default 'Male'
);
desc students;

insert into students(name, course, email, gendar, dob) values
("Ram", "java", "ram@123.com", "male", "2012-08-24"),
("Rama", "python", "rama@123.com", "Female", "2012-12-12");

```
drop database tutorial;
create database tutorial;
use tutorial;

CREATE TABLE students (
	id INT AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	course_id INT,
	PRIMARY KEY (id),
	foreign key(course_id) references courses(id)
);

CREATE TABLE courses (
	id INT AUTO_INCREMENT,
	course_name VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);

insert into students(name, course_id) values("Ramesh", 114);


insert into courses(course_name) values
("Java"),
("Mern"),
("Mobile App Dev"),
("Data Analysis");

insert into students(name, course_id) values("Ramesh", 4);
insert into students(name, course_id) values("Dinesh", 1);
insert into students(name, course_id) values("Mukesh", 3);
insert into students(name, course_id) values("Ganesh", 3);
insert into students(name, course_id) values("Mahesh", 4);


select * from courses;
select * from students;

select * from courses where id = (select course_id from students where name = "Ramesh");



------------



CREATE TABLE courses (
	course_id INT AUTO_INCREMENT,
	course_name VARCHAR(100) NOT NULL,
	credits INT DEFAULT 3,
	PRIMARY KEY (course_id)
);

CREATE TABLE students (
	student_id INT AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	course_id INT,
	PRIMARY KEY (student_id),
	FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

select id from courses where course_name = "Data Analysis";

select * from students where course_id = (select id from courses where course_name = "Data Analysis");





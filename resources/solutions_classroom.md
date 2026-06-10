drop database if exists tutorial;
create database tutorial;
use tutorial;

create table Students(
    id int primary key auto_increment, -- PK
    roll int unique not null,
    name varchar(20) not null,
    class enum('6A', '6B','6C', '7A', '7B','7C', '8A', '8B','8C', '9A', '9B','9C', '10A', '11B','11C', '12A', '12B','12C') not null
    -- sub_id int,
    -- foreign key(sub_id) references Subjects(id) -- FK
);

create table Subjects(
    id int primary key auto_increment, -- PK
    name varchar(20) not null unique
);

create table Scores(
    marks int not null,
    sub_id int,
    std_id int,
    foreign key(sub_id) references Subjects(id), -- FK
    foreign key(std_id) references Students(id), -- FK
    primary key (sub_id, std_id) 
);


select * from Students;
select * from Subjects;
select * from Scores;


insert into Subjects(name) values("Math"),("Sanskrit"),("Science"),("English");

insert into Students(roll, name, class) values
(325, 'Ramesh', '6A'),
(761, 'Suresh', '7C'),
(946, 'Mukesh', '10A'),
(548, 'Mahesh', '8C'),
(162, 'Dinesh', '6B');



insert into Scores(marks, std_id, sub_id) values(78, 1, 2);

-- find name of student who scored 78
select * from Students where id = (select std_id from Scores where marks = 78);



insert into Scores(marks, std_id, sub_id) values(78, 2, 3);

-- error
insert into Scores(marks, std_id, sub_id) values(82, 2, 3);
-- update
update scores set marks = 82 where std_id = 2 and sub_id=3;

select * from Scores;


insert into Scores(marks, std_id, sub_id) values(78, 3, 3);



select * from Students where id = (select std_id from Scores where marks = 78); -- error if multiple records found

select * from Students where id in (select std_id from Scores where marks = 78);





insert 10 records in Scores table
insert into Scores(marks, std_id, sub_id) values(61, 1, 3);
insert into Scores(marks, std_id, sub_id) values(65, 2, 2);
insert into Scores(marks, std_id, sub_id) values(78, 3, 1);
insert into Scores(marks, std_id, sub_id) values(81, 4, 3);
insert into Scores(marks, std_id, sub_id) values(83, 5, 2);
insert into Scores(marks, std_id, sub_id) values(82, 1, 1);
insert into Scores(marks, std_id, sub_id) values(61, 3, 2);
insert into Scores(marks, std_id, sub_id) values(62, 4, 2);
insert into Scores(marks, std_id, sub_id) values(65, 2, 1);
insert into Scores(marks, std_id, sub_id) values(74, 5, 1);
insert into Scores(marks, std_id, sub_id) values(68, 5, 3);



Display students sorted by name
select * from Students order by name;


Display score records having marks greater than 80.
select * from Scores where marks > 80;

Display score records having marks less than 60.
select * from Scores where marks < 60;

Display score records having marks between 70 and 90.
select * from Scores where marks >= 80 and marks<=82;


Display score records sorted by marks ascending.
select * from Scores order by marks asc;


Display score records sorted by marks descending.
select * from Scores order by marks desc;

Display score records for Subject ID 1.
select * from Scores where sub_id = 1;


Display score records for Student ID 2.
select * from Scores where std_id = 2;

Which students scored above 80 marks?

select * from Students where id in (1,5,2,4);

select * from Students where id in (select std_id from Scores where marks > 80);


Show all subject having marks in scores table
select name from Subjects where id in (select sub_id from Scores);





Show students who scored above average

select name from Students where id in (
    select std_id from Scores where marks > (
        select avg(marks) from Scores
    )
);


Show students who scored above average in only maths subject
select name from Students where id in (
    select std_id from Scores where marks > (
        select avg(marks) from Scores where sub_id = (select id from Subjects where name = "Math")
    )
);



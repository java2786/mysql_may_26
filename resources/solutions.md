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



select * from Students where id = (select std_id from Scores where marks = 78);
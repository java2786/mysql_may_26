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
    PRIMARY KEY (std_id, sub_id),
    FOREIGN KEY (std_id) REFERENCES Students (id),
    FOREIGN KEY (sub_id) REFERENCES Subjects (id)
);

INSERT INTO
    Students
VALUES (1, 101, 'Rahul Sharma', '9A'),
    (2, 102, 'Priya Verma', '9A'),
    (3, 103, 'Amit Patel', '9B'),
    (4, 104, 'Neha Gupta', '10A'),
    (5, 105, 'Karan Singh', '10B'),
    (6, 106, 'Riya Shah', '10B');

INSERT INTO
    Subjects
VALUES (1, 'Mathematics'),
    (2, 'Science'),
    (3, 'English'),
    (4, 'Social Studies'),
    (5, 'Computer');

INSERT INTO
    Scores
VALUES (1, 1, 85),
    (1, 2, 78),
    (1, 3, 92),
    (1, 4, 81),
    (1, 5, 88),
    (2, 1, 65),
    (2, 2, 72),
    (2, 3, 75),
    (2, 4, 68),
    (2, 5, 70),
    (3, 1, 95),
    (3, 2, 91),
    (3, 3, 89),
    (3, 4, 93),
    (3, 5, 97),
    (4, 1, 58),
    (4, 2, 61),
    (4, 3, 66),
    (4, 4, 55),
    (4, 5, 60),
    (5, 1, 82),
    (5, 2, 84),
    (5, 3, 79),
    (5, 4, 88),
    (5, 5, 90);
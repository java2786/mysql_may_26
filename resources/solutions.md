# MySQL Composite Primary Key Example (Students, Subjects, Scores)

## Objective

Learn:

- Primary Key (PK)
- Foreign Key (FK)
- Composite Primary Key
- Subqueries
- INSERT
- UPDATE
- Constraints
- One-to-Many Relationships

---

## Step 1: Create Database

```sql
DROP DATABASE IF EXISTS tutorial;

CREATE DATABASE tutorial;

USE tutorial;
```

---

## Step 2: Create Students Table

```sql
CREATE TABLE Students
(
    id INT PRIMARY KEY AUTO_INCREMENT,      -- PK

    roll INT UNIQUE NOT NULL,

    name VARCHAR(20) NOT NULL,

    class ENUM(
        '6A','6B','6C',
        '7A','7B','7C',
        '8A','8B','8C',
        '9A','9B','9C',
        '10A',
        '11B','11C',
        '12A','12B','12C'
    ) NOT NULL

    -- sub_id INT,
    -- FOREIGN KEY(sub_id) REFERENCES Subjects(id)
);
```

### Verify Structure

```sql
DESC Students;
```

---

## Step 3: Create Subjects Table

```sql
CREATE TABLE Subjects
(
    id INT PRIMARY KEY AUTO_INCREMENT,      -- PK

    name VARCHAR(20) NOT NULL UNIQUE
);
```

### Verify Structure

```sql
DESC Subjects;
```

---

## Step 4: Create Scores Table

### Important

A student can have only one score for a particular subject.

For example:

| Student | Subject | Marks |
|----------|----------|--------|
| Ramesh | Math | 80 |
| Ramesh | Science | 90 |
| Ramesh | English | 70 |

The combination of:

```text
(student_id + subject_id)
```

must be unique.

Therefore we create a Composite Primary Key.

```sql
CREATE TABLE Scores
(
    marks INT NOT NULL,

    sub_id INT,

    std_id INT,

    FOREIGN KEY(sub_id)
        REFERENCES Subjects(id),

    FOREIGN KEY(std_id)
        REFERENCES Students(id),

    PRIMARY KEY(sub_id, std_id)
);
```

### Verify Structure

```sql
DESC Scores;
```

---

## Step 5: View Empty Tables

```sql
SELECT * FROM Students;

SELECT * FROM Subjects;

SELECT * FROM Scores;
```

---

## Step 6: Insert Subjects

```sql
INSERT INTO Subjects(name)
VALUES
("Math"),
("Sanskrit"),
("Science"),
("English");
```

### Verify

```sql
SELECT * FROM Subjects;
```

---

## Step 7: Insert Students

```sql
INSERT INTO Students(roll, name, class)
VALUES
(325, 'Ramesh', '6A'),
(761, 'Suresh', '7C'),
(946, 'Mukesh', '10A'),
(548, 'Mahesh', '8C'),
(162, 'Dinesh', '6B');
```

### Verify

```sql
SELECT * FROM Students;
```

---

## Step 8: Insert First Score

```sql
INSERT INTO Scores(marks, std_id, sub_id)
VALUES
(78, 1, 2);
```

### Verify

```sql
SELECT * FROM Scores;
```

Output:

| marks | sub_id | std_id |
|---------|---------|---------|
| 78 | 2 | 1 |

---

## Step 9: Find Student Who Scored 78

### Using Subquery

```sql
SELECT *
FROM Students
WHERE id =
(
    SELECT std_id
    FROM Scores
    WHERE marks = 78
);
```

### Explanation

Inner Query:

```sql
SELECT std_id
FROM Scores
WHERE marks = 78;
```

Result:

```text
1
```

Outer Query:

```sql
SELECT *
FROM Students
WHERE id = 1;
```

Result:

```text
Ramesh
```

---

## Step 10: Insert Another Score

```sql
INSERT INTO Scores(marks, std_id, sub_id)
VALUES
(78, 2, 3);
```

### Verify

```sql
SELECT * FROM Scores;
```

---

## Step 11: Composite Primary Key Error

Try inserting:

```sql
INSERT INTO Scores(marks, std_id, sub_id)
VALUES
(82, 2, 3);
```

### Error

```text
Duplicate entry for PRIMARY KEY
```

### Why?

Because:

```text
std_id = 2
sub_id = 3
```

already exists.

Composite Primary Key:

```sql
PRIMARY KEY(sub_id, std_id)
```

does not allow duplicate combinations.

Current Record:

| marks | sub_id | std_id |
|---------|---------|---------|
| 78 | 3 | 2 |

Trying to insert:

| marks | sub_id | std_id |
|---------|---------|---------|
| 82 | 3 | 2 |

is not allowed.

---

## Step 12: Correct Way - Update Existing Score

```sql
UPDATE Scores
SET marks = 82
WHERE std_id = 2
AND sub_id = 3;
```

### Verify

```sql
SELECT * FROM Scores;
```

---

## Step 13: Insert Third Score

```sql
INSERT INTO Scores(marks, std_id, sub_id)
VALUES
(78, 3, 3);
```

### Verify

```sql
SELECT * FROM Scores;
```

---

## Step 14: Problem with Subquery

Now execute:

```sql
SELECT *
FROM Students
WHERE id =
(
    SELECT std_id
    FROM Scores
    WHERE marks = 78
);
```

### Error

```text
Subquery returns more than 1 row
```

### Why?

Because now:

```sql
SELECT std_id
FROM Scores
WHERE marks = 78;
```

returns:

```text
1
3
```

Multiple rows cannot be compared using:

```sql
=
```

---

## Step 15: Correct Solution Using IN

```sql
SELECT *
FROM Students
WHERE id IN
(
    SELECT std_id
    FROM Scores
    WHERE marks = 78
);
```

### Output

```text
Ramesh
Mukesh
```

---

## Key Concepts Learned

### Primary Key

```sql
PRIMARY KEY(id)
```

- Unique
- Not NULL
- Identifies each row

---

### Foreign Key

```sql
FOREIGN KEY(sub_id)
REFERENCES Subjects(id)
```

```sql
FOREIGN KEY(std_id)
REFERENCES Students(id)
```

- Maintains relationship between tables
- Prevents invalid references

---

### Composite Primary Key

```sql
PRIMARY KEY(sub_id, std_id)
```

- Combination must be unique
- Individual columns may repeat
- Pair cannot repeat

Example:

Allowed:

| sub_id | std_id |
|---------|---------|
| 1 | 1 |
| 1 | 2 |
| 2 | 1 |

Not Allowed:

| sub_id | std_id |
|---------|---------|
| 1 | 1 |
| 1 | 1 |

---

### Subquery

```sql
SELECT *
FROM Students
WHERE id =
(
    SELECT std_id
    FROM Scores
    WHERE marks = 78
);
```

Query inside another query.

---

### IN Operator

```sql
SELECT *
FROM Students
WHERE id IN
(
    SELECT std_id
    FROM Scores
    WHERE marks = 78
);
```

Used when subquery returns multiple rows.

---

## Final Table Queries

```sql
SELECT * FROM Students;

SELECT * FROM Subjects;

SELECT * FROM Scores;
```
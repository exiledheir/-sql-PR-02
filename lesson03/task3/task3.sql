CREATE TABLE students
(
    student_id INT PRIMARY KEY,
    full_name  VARCHAR(100),
    age        INT,
    group_id   INT
);

CREATE TABLE groups
(
    group_id   INT PRIMARY KEY,
    group_name VARCHAR(50)
);

CREATE TABLE subjects
(
    subject_id   INT PRIMARY KEY,
    subject_name VARCHAR(50)
);

CREATE TABLE grades
(
    grade_id   INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    grade      INT,
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects (subject_id)
);

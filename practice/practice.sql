CREATE TABLE IF NOT EXISTS students
(
    email      VARCHAR(100) PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    sex        VARCHAR(10)  NOT NULL,
    dob        DATE         NOT NULL,
    country    VARCHAR(20)  NOT NULL,
    department VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP    NOT NULL
);

INSERT INTO students (email, name, sex, dob, country, department, created_at, updated_at)
VALUES ('alice@example.com', 'Alice Tan', 'Female', '2000-04-15', 'Singapore', 'Computer Science', NOW(), NOW()),
       ('bob@example.com', 'Bob Lim', 'Male', '1999-11-02', 'Malaysia', 'Mathematics', NOW(), NOW()),
       ('cindy@example.com', 'Cindy Goh', 'Female', '2001-07-23', 'Indonesia', 'Physics', NOW(), NOW()),
       ('david@example.com', 'David Lee', 'Male', '2000-01-30', 'Singapore', 'Engineering', NOW(), NOW()),
       ('eva@example.com', 'Eva Tan', 'Female', '1998-12-12', 'Thailand', 'Business', NOW(), NOW()),
       ('felix@example.com', 'Felix Teo', 'Male', '2002-03-17', 'Vietnam', 'Computer Science', NOW(), NOW());

DROP PROCEDURE IF EXISTS total;

delimiter //

CREATE PROCEDURE total(in country_ varchar(10), out n int)
begin
    SELECT count(*) into n FROM students WHERE country = country_;
end //
delimiter ;

DROP PROCEDURE IF EXISTS studentsFrom;

delimiter //

CREATE PROCEDURE studentsFrom(in country_ varchar(10))
begin
    IF country_ IS NOT NULL THEN
        SELECT * FROM students WHERE country = country_;
    ELSE
        SELECT * FROM students;
    END IF;
end //
delimiter ;

DROP PROCEDURE IF EXISTS updateSession;

delimiter //

CREATE PROCEDURE updateSession()
begin
    SET @var = @var * 5;
end//
delimiter ;

CREATE TABLE IF NOT EXISTS results
(
    email VARCHAR(100) REFERENCES students (email),
    score int
);

INSERT INTO results(email, score)
VALUES ('alice@example.com', 100);
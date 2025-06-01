/*******************

  Create the schema

********************/

CREATE TABLE IF NOT EXISTS book (
title VARCHAR(256) NOT NULL,
format CHAR(9) CONSTRAINT format CHECK(format = 'paperback' OR format='hardcover'),
pages INT,
language VARCHAR(32),
authors VARCHAR(256) NOT NULL,
publisher VARCHAR(64),
year DATE,
ISBN10 CHAR(10) NOT NULL UNIQUE,
ISBN13 CHAR(14) PRIMARY KEY,
check(regexp_like(isbn13, '[0-9]{3}\-[0-9]{10}'))
);

CREATE TABLE IF NOT EXISTS student (
name VARCHAR(32) NOT NULL,
email VARCHAR(256) PRIMARY KEY,
year DATE NOT NULL,
faculty VARCHAR(62) NOT NULL,
department VARCHAR(32) NOT NULL,
graduate DATE,
CHECK(graduate >= year)
);

CREATE TABLE IF NOT EXISTS  copy (
owner VARCHAR(256),
book CHAR(14),
copy INT CHECK(copy>0),
available VARCHAR(5) CHECK(available = 'TRUE' OR available='FALSE'),
FOREIGN KEY (owner) REFERENCES student(email) ON DELETE NO ACTION,
FOREIGN KEY (book) REFERENCES book(ISBN13) ON DELETE NO ACTION,
PRIMARY KEY (owner, book, copy)
);

CREATE TABLE IF NOT EXISTS loan (
borrower VARCHAR(256) REFERENCES student(email) ON DELETE NO ACTION,
owner VARCHAR(256),
book CHAR(14),
copy INT,
borrowed DATE NOT NULL,
returned DATE,
FOREIGN KEY (owner, book, copy) REFERENCES copy(owner, book, copy)  ON DELETE NO ACTION,
PRIMARY KEY (borrowed, borrower, owner, book, copy),
CHECK(returned >= borrowed)
);

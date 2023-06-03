CREATE DATABASE student;

USE student

--- student table

CREATE TABLE student(
 id INT unsigned NOT NULL AUTO_INCREMENT,
 name VARCHAR(200) NOT NULL,
 last_name VARCHAR(200) NOT NULL,
 birthdate DATE NOT NULL,
 gender VARCHAR (10) NOT NULL ,
 city VARCHAR (20 ) NOT NULL,
  PRIMARY KEY (id)
  
 )
DROP TABLE IF EXISTS course
CREATE TABLE course(
 id INT unsigned NOT NULL AUTO_INCREMENT,
 age INT unsigned NOT NULL,
course VARCHAR(200) NOT NULL,
fees INT unsigned NOT NULL,
course_id INT,
PRIMARY KEY (id)
 )

CREATE TABLE score (
course_id INT NOT NULL,
email VARCHAR(255) NOT NULL,
continent VARCHAR(255) NOT NULL,
score INT NOT NULL,
PRIMARY KEY (course_id) )

INSERT INTO student(name, last_name, birthdate, gender, city)
	VALUE('Christ', 'Fisher', '2000-01-20', 'Male', 'Cape town' ),
		('Chaerle', 'Walke', '1989-05-01', 'Male', 'Wymberg' ),
         ('	John', 'Talovam', '1990-01-7', 'Male', 'Cape town' ),
         ('Helene', 'Tambwe', '1999-07-12', 'Female', 'Toronto' ),
         ('Ashley', 'Johnson', '1994-04-11', 'Male', 'Albany' ),
         ('Janice', 'Rocky', '1997-03-17', 'Female', 'Paris' ),
         ('Zoe', 'Kab', '2000-05-22', 'Female', 'New york' ),
         ('Sarah', 'Monro', '2003-04-05', 'Female', 'Montreal' ),
         ('William', 'Peterson', '1998-09-29', 'Male', 'Chicago' ),
         ('Matthew', 'Josue', '2005-06-20', 'Male', 'Texas' )
         
         
INSERT INTO course(age, course, fees, course_id)
	VALUE('23', 'Data science', '17000', '501' ),
		('34', 'Statistic', '15000', '502' ),
        ('33', 'Philosophy', '9800', '503' ),
        ('24', 'Data analyst', '15000', '504' ),
        ('29', 'Data mining', '12000', '505' ),
        ('26', 'IT ', '11500', '506' ),
        ('22', 'Science', '17800', '507' ),
        ('20', 'Programming ', '8500', '508' ),
        ('25', 'Data Engeering', '10500', '509' ),
        ('18', 'Physics', '11800', '510' )
        
INSERT INTO score(course_id, email, Continent, score)
	VALUE('501', 'info@hou.com', 'Africa', '69' ),
    ('502', 'indf@gmail.com', 'Africa', '73' ),
    ('503', 'info@gmail.com', 'Africa', '89' ),
    ('504', 'ghs@hahoo.com', 'Canada', '75' ),
    ('505', 'yull@gmail.com', 'USA', '87' ),
    ('506', 'info@outlook.com', 'Europ', '79' ),
    ('507', 'ind@gmail.com', 'USA', '77' ),
    ('508', 'mai@gmai.com', 'Canada', '86' ),
    ('509', 'info@out.com', 'USA', '81' ),
    ('510', 'info@gmail.com', 'USA', '78' )
		

SELECT *
FROM score
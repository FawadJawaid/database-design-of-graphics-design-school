--
-- GROUP MEMBERS: 11k-2116, 11k-2282, 11k-2181 (Section B)
--
-- SCHEMA NAME
--    Nexus Graphics School.sql
--
-- SCHEMA DESCRIPTION
--   This script creates the SQL*Plus tables of our Project (Nexus Graphics School).
--   Its a normalized schema script upto 3NF
--   To remove the tables use the "DB Project Drop.sql" script.
--   To insert tuples in this schema use 'DB Project Data File.sql'



CREATE TABLE Admin 
 (SSN INTEGER CHECK(SSN>0) NOT NULL,
  Name VARCHAR(20) NULL,
  Cell_Number INTEGER CHECK(Cell_Number>0) NULL,
  PRIMARY KEY(SSN));



CREATE TABLE Instructor 
 (Instructor_id INTEGER CHECK(Instructor_id>0) NOT NULL,
  Email VARCHAR(20) NOT NULL,  
  DateofBirth DATE NULL,
  Cell_Number INTEGER CHECK(Cell_Number>0) NULL,
  Expertise VARCHAR(20) NULL,
  Salary INTEGER CHECK(Salary>0) NOT NULL,
  PRIMARY KEY(Instructor_id));

CREATE TABLE Instructor_Name
 (Instructor_id INTEGER CHECK(Instructor_id>0) NOT NULL,
  Fname  VARCHAR(20) NULL,
  Lname VARCHAR(20) NULL,
  PRIMARY KEY(Instructor_id, Fname),
  CONSTRAINT Instructor_NameFK FOREIGN KEY(Instructor_id) REFERENCES Instructor(Instructor_id));

CREATE TABLE Instructor_Address
 (Instructor_id INTEGER CHECK(Instructor_id>0) NOT NULL,
  Address_PostalCode VARCHAR(20) NOT NULL,
  Address_City VARCHAR(20) NOT NULL,
  Address_Province VARCHAR(20) NULL,
  Address_HouseNo VARCHAR(10) NOT NULL,
  Address_StreetNo VARCHAR(20) NULL,
  PRIMARY KEY(Instructor_id, Address_PostalCode),
  CONSTRAINT Instructor_AddFK FOREIGN KEY(Instructor_id) REFERENCES Instructor(Instructor_id)); 



CREATE TABLE Admin_hire_Instructor 
 (Admin_SSN INTEGER CHECK(Admin_SSN>0) NOT NULL,
  Instructor_id INTEGER CHECK(Instructor_id>0) NOT NULL,
  HireDate DATE NULL,
  PRIMARY KEY(Admin_SSN, Instructor_id),
  CONSTRAINT Admin_has_Instructor_FK1 FOREIGN KEY(Admin_SSN) REFERENCES Admin(SSN),
  CONSTRAINT Admin_has_Instructor_FK2 FOREIGN KEY(Instructor_id) REFERENCES Instructor(Instructor_id));



CREATE TABLE Student 
 (Student_id INTEGER CHECK(Student_id>0) NOT NULL,
  Admin_SSN INTEGER CHECK(Admin_SSN>0) NOT NULL,
  Email VARCHAR(20) NULL,
  DateofBirth DATE NULL,
  PreviousEducation VARCHAR(50) NULL,
  PRIMARY KEY(Student_id),
  CONSTRAINT Student_FK1 FOREIGN KEY(Admin_SSN) REFERENCES Admin(SSN));

CREATE TABLE Student_Name
 (Student_id INTEGER CHECK(Student_id>0) NOT NULL,
  Fname VARCHAR(20) NULL,
  Lname VARCHAR(20) NULL,
  PRIMARY KEY(Student_id, Fname),
  CONSTRAINT Student_NameFK FOREIGN KEY (Student_id) REFERENCES Student(Student_id));
  
CREATE TABLE Student_Address 
 (Student_id INTEGER CHECK(Student_id>0) NOT NULL,
  Address_PostalCode VARCHAR(20) NOT NULL,
  Address_City VARCHAR(20) NOT NULL,
  Address_Province VARCHAR(20) NULL,
  Address_HouseNo VARCHAR(10) NOT NULL,
  Address_StreetNo VARCHAR(20) NULL,
  PRIMARY KEY(Student_id, Address_PostalCode),
  CONSTRAINT Student_AddFK FOREIGN KEY (Student_id) REFERENCES Student(Student_id));



CREATE TABLE Course 
 (Course_Id VARCHAR(10) NOT NULL,
  Admin_SSN INTEGER CHECK(Admin_SSN>0) NOT NULL,
  Student_id INTEGER CHECK(Student_id>0) NOT NULL,
  Instructor_id INTEGER CHECK(Instructor_id>0) NOT NULL,
  Course_Name VARCHAR(20) NOT NULL,
  Description VARCHAR(20) NULL,
  Credit_hours INTEGER CHECK(Credit_hours>0) NOT NULL,
  PRIMARY KEY(Course_Id),
  CONSTRAINT Course_FK1 FOREIGN KEY(Instructor_id) REFERENCES Instructor(Instructor_id),
  CONSTRAINT Course_FK2 FOREIGN KEY(Student_id) REFERENCES Student(Student_id),
  CONSTRAINT Course_FK3 FOREIGN KEY(Admin_SSN) REFERENCES Admin(SSN));



CREATE TABLE Assignment 
 (Assignment_Id INTEGER CHECK(Assignment_Id>0) NOT NULL,
  Course_Id VARCHAR(10) NOT NULL,
  Due_Date DATE NOT NULL,
  PRIMARY KEY(Assignment_Id),
  CONSTRAINT Assignment_FK1 FOREIGN KEY(Course_Id) REFERENCES Course(Course_Id));



CREATE TABLE Course_Material 
 (Topics VARCHAR(20) NOT NULL,
  Course_Id VARCHAR(10) NOT NULL,
  Instructor_id INTEGER CHECK(Instructor_id>0) NOT NULL,
  Duration VARCHAR(20) NOT NULL,
  PRIMARY KEY(course_Id),
  CONSTRAINT Course_Material_FK1 FOREIGN KEY(Instructor_id) REFERENCES Instructor(Instructor_id),
  CONSTRAINT Course_Material_FK2 FOREIGN KEY(Course_Id) REFERENCES Course(Course_Id));



CREATE TABLE PreRequiste 
 (PreRequiste_Id VARCHAR(10) NOT NULL,
  Course_Id VARCHAR(10) NOT NULL,
  PreRequiste_Name VARCHAR(40) NOT NULL,
  Credit_hours INTEGER CHECK(Credit_hours>0) NOT NULL,
  PRIMARY KEY(PreRequiste_Id),
  CONSTRAINT PreRequiste_FK1 FOREIGN KEY(Course_Id) REFERENCES Course(Course_Id));



CREATE TABLE Student_Previous_Courses 
 (Previous_Courses_id VARCHAR(20) NOT NULL,
  Student_id INTEGER CHECK(Student_id>0) NOT NULL,
  PrevCourses_Name VARCHAR(20) NOT NULL,
  Credit_hours INTEGER CHECK(Credit_hours>0) NOT NULL,
  Grade CHAR NULL,
  PRIMARY KEY(Previous_Courses_id, Student_id),
  CONSTRAINT Std_Prev_Courses_FK1 FOREIGN KEY(Student_id) REFERENCES Student(Student_id));



CREATE TABLE Project 
 (Project_id INTEGER CHECK(Project_id>0) NOT NULL,
  Instructor_id INTEGER CHECK(Instructor_id>0) NOT NULL,
  Subject VARCHAR(40) NULL,
  Format VARCHAR(10) NULL,
  PRIMARY KEY(Project_id),
  CONSTRAINT Project_FK1 FOREIGN KEY(Instructor_id) REFERENCES Instructor(Instructor_id));



CREATE TABLE Student_Submits_Project 
 (Student_id INTEGER CHECK(Student_id>0) NOT NULL,
  Project_id INTEGER CHECK(Project_id>0) NOT NULL,
  Submission_Date DATE NOT NULL,
  PRIMARY KEY(Student_id, Project_id),
  CONSTRAINT Student_has_Project_FK1 FOREIGN KEY(Student_id) REFERENCES Student(Student_id),
  CONSTRAINT Student_has_Project_FK2 FOREIGN KEY(Project_id) REFERENCES Project(Project_id));


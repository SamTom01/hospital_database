CREATE DATABASE Hospital;

USE Hospital;

CREATE TABLE department_T(
departmentid int(11) auto_increment NOT NULL,
departmentname varchar(30) NOT NULL,
departmentlocation varchar(30) NOT NULL,
CONSTRAINT department_pk PRIMARY KEY (departmentid)
);

CREATE TABLE department_facility_T(
departmentid int(11) NOT NULL,
departmentfacility varchar(30) NOT NULL,
CONSTRAINT department_facility_pk PRIMARY KEY(departmentid,departmentfacility),
CONSTRAINT department_facility_fk FOREIGN KEY (departmentid) 
REFERENCES department_T(departmentid)
on update cascade on delete cascade
);

 

CREATE TABLE doctor_T(
doctorid int(11) auto_increment NOT NULL,
doctorname varchar(30) NOT NULL,
qualification varchar(30) NOT NULL,
phonenumber int(11) NOT NULL,
doctortype varchar(30) NOT NULL,
departmentid int(11) NOT NULL,
CONSTRAINT doctor_pk PRIMARY KEY (doctorid),
CONSTRAINT doctor_fk FOREIGN KEY (departmentid)
REFERENCES department_T(departmentid)
on update cascade on delete cascade
);


CREATE TABLE callondoctor_T(
cdoctorid int(11) NOT NULL,
feepercall double NOT NULL,
paymentdue int(11),
contactaddress varchar(30),
CONSTRAINT callondoctor_pk PRIMARY KEY (cdoctorid),
CONSTRAINT callondoctor_fk FOREIGN KEY (cdoctorid)
REFERENCES doctor_T(doctorid)
on update cascade on delete cascade
);



CREATE TABLE regulardoctor_T(
rdoctorid int(11) NOT NULL,
officeaddress varchar(30),
salary double NOT NULL,
dateofjoining date NOT NULL,
CONSTRAINT regulardoctor_pk PRIMARY KEY (rdoctorid),
constraint regulardoctor_fk FOREIGN KEY (rdoctorid)
REFERENCES doctor_T(doctorid)
on update cascade on delete cascade
);



CREATE TABLE patient_T(
patientmembershipid int(11) auto_increment NOT NULL,
patientlastname varchar(30),
patientmiddlename varchar(30), 
patientfirstname varchar(30) NOT NULL,
dateofbirth date NOT NULL,
gender varchar(11),
rdoctorid int(11) NOT NULL,
CONSTRAINT patient_pk PRIMARY KEY (patientmembershipid),
CONSTRAINT patient_fk FOREIGN KEY (rdoctorid)
REFERENCES regulardoctor_T(rdoctorid)
on update cascade on delete cascade
);



CREATE TABLE patientmembershiptype_T(
patientmembershipid int(11) NOT NULL,
membershiptype varchar(30) NOT NULL,
CONSTRAINT patientmembershiptype_pk PRIMARY KEY (patientmembershipid,membershiptype),
CONSTRAINT patientmembershiptype_fk FOREIGN KEY (patientmembershipid)
REFERENCES patient_T(patientmembershipid)
on update cascade on delete cascade
);



CREATE TABLE patientappointment_T(
appointmentconfirmationnumber int(11) auto_increment NOT NULL,
appointmentdate date NOT NULL,
appointmentlocation varchar(30) NOT NULL,
doctorname varchar(30) NOT NULL,
rdoctorid int(11) NOT NULL,
patientmembershipid int(11) NOT NULL,
CONSTRAINT patientappointment_pk PRIMARY KEY (appointmentconfirmationnumber),
CONSTRAINT patientappointment_fk FOREIGN KEY (rdoctorid)
REFERENCES regulardoctor_T(rdoctorid),
CONSTRAINT patientappointment_fk1 FOREIGN KEY (patientmembershipid)
REFERENCES patient_T(patientmembershipid)
on update cascade on delete cascade
);



/*department_T Table Values*/
INSERT INTO department_T (departmentid, departmentname, departmentlocation) VALUES
(101, 'medicine', '20 Orchard Rd.'),
(102, 'surgery', '40 West'),
(103, 'gynaecology', '19 Charmagne Lane'),
(104, 'obstetrics', '302 Lakeland'),
(105, 'paediatrics', '500 Coplin Ave.'),
(106, 'ENT', '250 Rivendell Dr.');

INSERT INTO department_facility_T (departmentid, departmentfacility) VALUES
(106, 'Xray'),
(105, 'MRI'),
(102, 'CTscan'),
(104, 'Acute Care'),
(103, 'ICU'),
(101, 'Longterm Care');

INSERT INTO doctor_T(doctorid,doctorname ,qualification ,phonenumber,doctortype ,departmentid) VALUES
(200, 'Mistry','Doctoral Degree',786-618-7814,'Emergency physicians',104),
(201, 'Brick Wall','Doctoral Degree',480-529-5140,'Neurologists',103),
(202, 'Ether','Doctoral Degree',620-872-5704,'Radiologists',102),
(203, 'Tranquilli','Doctoral Degree',731-425-0894,'Anesthesiologists',106),
(204, 'Ken Hurt','Doctoral Degree',801-314-0643,'Emergency physicians',105),
(205, 'Johnathan Paine','Doctoral Degree',734-833-6605,'Pediatricians',101);

INSERT INTO callondoctor_T (cdoctorid, feepercall, contactaddress,paymentdue) VALUES
(200, 500, '20 Orchard Rd.', 50),
(201, 1000, '40 West', 40),
(202, 550, '19 Charmagne Lane', 55);


INSERT INTO regulardoctor_T (rdoctorid,officeaddress, salary, dateofjoining) VALUES
(203,'15 Burning Memory', '4000','1990-09-01'),
(204,'50 Browntown Rd.', '5890','1990-09-01'),
(205,'129 Happy Ave.', '5700','1990-09-01');

INSERT INTO patient_T(patientmembershipid,patientlastname,patientmiddlename,patientfirstname,dateofbirth,gender,rdoctorid) VALUES
(1, 'Wesley','Aliana','Darwin','1997-09-01','Male',203),
(2, 'Jayce','Allan','Bray','1997-02-01','Female',203),
(3, 'Ether','Juana','Clarissa','1998-02-01','Male',203),
(4, 'Tranquilli','Neeley','Rafferty','1998-03-01','Male',204),
(5, 'Ken','Hasan','Bowen','1999-03-01','Female',204),
(6, 'Pierce','Rosen','Lockwood','2000-03-01','Female',204),
(7, 'Gardner','Greyson','Mercedez','2002-03-01','Male',205),
(8, 'Bradshaw','Galindo','Benedict','2002-03-01','Male',205),
(9, 'Fuller','Shivani','Garret','2002-03-01','Male',205),
(10, 'Jasiah','Dupree','Stubblefield','1998-03-01','Male',204);

INSERT INTO patientmembershiptype_T(patientmembershipid,membershiptype) VALUES
(1, 'Gold'),
(2, 'Bronze'),
(3, 'Silver'),
(4, 'Gold'),
(5, 'Silver'),
(6, 'Bronze');


INSERT INTO patientappointment_T(appointmentconfirmationnumber,appointmentdate,appointmentlocation,doctorname,rdoctorid,patientmembershipid) VALUES
(10, '2022-09-01','20 Orchard Rd.','Tranquilli',203,1),
(20, '2022-09-02','20 Orchard Rd.','Tranquilli',203,2),
(30, '2022-09-03','20 Orchard Rd.','Ken Hurt',204,3),
(40, '2022-09-04','20 Orchard Rd.','Ken Hurt',204,6),
(50, '2022-09-05','20 Orchard Rd.','Johnathan Paine',205,7);

SELECT * FROM callondoctor_T;
SELECT * FROM department_facility_T;
SELECT * FROM department_T;
SELECT * FROM doctor_T;
SELECT * FROM patientappointment_T;
SELECT * FROM patientmembershiptype_T;
SELECT * FROM patient_T;
SELECT * FROM regulardoctor_T;

/* Q3 */
SELECT patient_T.* 
FROM patient_T,patientappointment_T 
WHERE patient_T.patientmembershipid = patientappointment_T.patientmembershipid
AND patientappointment_T.doctorname = 'Ken Hurt' AND patientappointment_T.appointmentdate='2022-09-03';

/* Q4 */
SELECT doctor_T.*, regulardoctor_T.*
FROM regulardoctor_T INNER JOIN
doctor_T INNER JOIN department_T
ON regulardoctor_T.rdoctorid = doctor_T.doctorid
AND doctor_T.departmentid= department_T.departmentid
WHERE doctor_T.doctorname LIKE "J%" AND department_T.departmentname = "medicine" ;

/* Q5 */
SELECT *
FROM department_T LEFT JOIN department_facility_T 
ON department_T.departmentid = department_facility_T.departmentid ;

/* Q6 */
SELECT cdoctorid
FROM callondoctor_T
UNION
SELECT rdoctorid
FROM regulardoctor_T;

/*Q7*/
CREATE VIEW v_patinet_info AS
SELECT patient_T.* 
FROM patient_T INNER JOIN regulardoctor_T
ON patient_T.rdoctorid = regulardoctor_T.rdoctorid
WHERE regulardoctor_T.salary > 5000 ;

SELECT * FROM v_patinet_info;



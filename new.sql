-- Commom Errors that found in my quesries/programs:

/*********
mysql> insert into employee
values(Abhinav,NULL,Saxena,123456789,1994-08-13,"Maya Enclave, Near Hari Nagar Clock Tower, New Delhi","M",50000,333445555,5);
-> ERROR 1054 (42S22): Unknown column 'Abhinav' in 'field list'

 The error is there because of invisible garbage characters in my query. Check here that Abhinav and Saxena should be in quotes but are not
*********/

/***********
How to drop a foreign key


**************/



/***********

Drop a table command

************/

/********
How to Alter Constraint?? Alter or change let us say foreign key or unique constraint

Ans> You can not alter constraints ever but you can drop them and then recreate.
Have look on this

ALTER TABLE your_table DROP CONSTRAINT ACTIVEPROG_FKEY1;

and then recreate it with ON DELETE CASCADE like this

ALTER TABLE your_table
add CONSTRAINT ACTIVEPROG_FKEY1 FOREIGN KEY(ActiveProgCode) REFERENCES PROGRAM(ActiveProgCode)
    ON DELETE CASCADE;
************/

/************
How to remove not null constraint in mysql using query? (very Imp)

ALTER TABLE testTable MODIFY COLUMN colA int null; -- Note that this would only work in mysql and not any other sql

Important to note that this also automatically sets the default vaulue of column as null.. Try something like
intsert into eployee values("0"asdasda,asdas,asdasdas,asdasdas,adad, DEFAULT etc.);
************/

/***********
 ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`final_12036282003`.`employee`, CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`superssn`) REFERENCES `employee` (`ssn`))

This error is due to referential constraints. We are trying to add entries to the foreign key which references to the primary key. Since there was no record with the ssn 888665555, we got an error when adding it to the superssn. The best way that is out of this would be to have the DEFALT NULL values in the column and later update then individually.

Try,
  insert into employee
values("Franklin","T","Wong",333445555,1955-12-08,"638 Voss, Houston, TX","M",40000,DEFAULT,5);

and it works!!
******/

/**********

Date : The data-type for dates
Syntax: create table table_name (Bdate date not null);
Format: YYYY-MM-DD

**********/

/** Note that values for the foreign key column can have null values **/

/*********************************
Error: mysql>  alter table works_on add constraint foreign key(pno) references project(pnumber);

ERROR 1005 (HY000): Can't create table 'final_12036282003.#sql-4f5_48' (errno: 150)

When creating a foreign key constraint, MySQL requires a usable index on both the referencing table and also on the referenced table. The index on the referencing table is created automatically if one doesn't exist, but the one on the referenced table needs to be created manually (Source). Yours appears to be missing.

Test case:

CREATE TABLE tbl_a (
    id int PRIMARY KEY,
    some_other_id int,
    value int
) ENGINE=INNODB;
Query OK, 0 rows affected (0.10 sec)

CREATE TABLE tbl_b (
    id int PRIMARY KEY,
    a_id int,
    FOREIGN KEY (a_id) REFERENCES tbl_a (some_other_id)
) ENGINE=INNODB;
ERROR 1005 (HY000): Can't create table 'e.tbl_b' (errno: 150)
But if we add an index on some_other_id:

CREATE INDEX ix_some_id ON tbl_a (some_other_id);
Query OK, 0 rows affected (0.11 sec)
Records: 0  Duplicates: 0  Warnings: 0

CREATE TABLE tbl_b (
    id int PRIMARY KEY,
    a_id int,
    FOREIGN KEY (a_id) REFERENCES tbl_a (some_other_id)
) ENGINE=INNODB;
Query OK, 0 rows affected (0.06 sec)
This is often not an issue in most situations, since the referenced field is often the primary key of the referenced table, and the primary key is indexed automatically.


Following the above guide, when I added the index on project(pnumber), it worked!!
mysql> create index ix_some on project(pnumber);
Query OK, 0 rows affected (0.17 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>  alter table works_on add constraint foreign key(pno) references project(pnumber);
Query OK, 16 rows affected (0.23 sec)
Records: 16  Duplicates: 0  Warnings: 0

*************************************/
-- How to update column records in database?
-- update `table_name` set `column_name` ='value'
/****************************************/
-- order by is always written at last
-- Union does not work with update

/************************* Creation of tables and insertion queries examples **************************************/

-- Creation of dept_locations table
create table dept_locations(dnumber int not null,dlocation varchar(80) not null, primary key(dnumber,dlocation));
--  Example of insertion of vaules in that column
insert into dept_locations values(1,"Houston");
-- Later
    alter table dept_locations
    add foreign key(dnumber) referneces employee(dno);

-- Creation of table Department
create table department(dname varchar(80), dnumber int not null,mgrssn int null, mgrstartdate date not null);

-- Adding primary key
alter table department
add primary key(dnumber);

-- Inserting a row into department table
insert into department
    values("Headquaters",1,888665555,1981-06-19);

-- And Sooooo.... oonnnnnn

--  Q1. Create tables with relevant foreign key constraints :: DONE
-- Q2. Populate the tables with data :: DONE

    *****************************************************************************************************************************************

-- Q3. Perform the following queries on the database :
--  1: Display all the details of all employees working in the company. :: DONE
select * from employee;
--  2: Display ssn, lname, fname, address of employees who work in department no 7. :: DONE
select ssn,lname,fname,address from employee where dno=7;
--  3: Retrieve the birthdate and address of the employee whose name is 'Franklin T.
--  Wong' :: DONE
select bdate,address from employee where fname="Franklin" and mname="T";
--  4: Retrieve the name and salary of every employee :: DONE
select fname,mname,lname,salary from employee;
--  5: Retrieve all distinct salary values :: DONE
select distinct salary from employee;

--  6: Retrieve all employee names whose address is in ‘Bellaire’ :: Imp Revise
select * from employee where address like "%Bellaire%";

--  7: Retrieve all employees who were born during the 1950s :: Revise Wrong Redo
select * from employee where bdate>='1940-01-01' and bdate<='1960-01-01';
--  8: Retrieve all employees in department 5 whose salary is between 50,000 and
--  60,000(inclusive)

--  9: Retrieve the names of all employees who do not have supervisors
select * from employee where superssn is null;
-- 10: Retrieve SSN and department name for all employees
select ssn,dname from employee, department where employee.dno=department.dnumber;
-- 11: Retrieve the name and address of all employees who work for the 'Research'
--  department
select fname,mname,lname,address from employee,department where employee.dno=department.dnumber and department.dname="Research";
-- 12: For every project located in 'Stafford', list the project number, the controlling
--  department number, and the department manager's last name, address, and birthdate.

 select  pnumber,dnum,lname,address,bdate from employee,department,project where project.dnum=department.dnumber and department.mgrssn=employee.ssn and project.plocation="Stafford"; -- Problems with bdate check

 --  13: For each employee, retrieve the employee's name, and the name of his or her
 --  immediate supervisor.
 select e.fname,e.mname,e.lname,s.fname as superviser_fname,s.mname as superviser_mname,s.lname as superviser_lname from employee as e, employee as s where e.ssn=s.superssn group by e.ssn;

 -- 14: Retrieve all combinations of Employee Name and Department Name
 select fname,mname,lname,dname from employee,department;

 -- 15: Make a list of all project numbers for projects that involve an employee whose last
 --  name is 'Narayan’ either as a worker or as a manager of the department that controls
 --  the project.
 select pnumber from project,works_on,employee where project.pnumber=works_on.pno and works_on.essn=employee.ssn and employee.lname="Narayan"
 union
select pnumber from project,department,employee where project.dnum=department.dnumber and department.mgrssn=employee.ssn and employee.lname="Narayan";
-- 16: Increase the salary of all employees working on the 'ProductX' project by 15% .
--  Retrieve employee name and increased salary of these employees.
update employee,project,works_on
set salary=salary*1.15
where project.pnumber=works_on.pno and works_on.essn=employee.ssn and project.pname="ProductX"

select fname,mname,lname,salary from employee,project,works_on where project.pnumber=works_on.pno and works_on.essn=employee.ssn and project.pname="ProductX";
-- Note that union does not work with update
-- update employee,project,works_on
-- set salary=salary*1.15
-- where project.pnumber=works_on.pno and works_on.essn=employee.ssn and project.pname="ProductX"
-- union all (select fname,mname,lname,salary from employee,project,works_on where project.pnumber=works_on.pno and works_on.essn=employee.ssn and project.pname="ProductX");

-- 17: Retrieve a list of employees and the project name each works in, ordered by the
--  employee's department, and within each department ordered alphabetically by
--  employee first name.
    ::MUST LEARN::

select distinct fname,lname,pname from employee,works_on,project
where project.pnumber=works_on.pno and works_on.essn=employee.ssn
group by pno
order by dno,fname;


-- 18: Select the names of employees whose salary does not match with salary of any
--  employee in department 10
    :: Imporatant learn ::
Select fname, minit, lname from employee where salary not in (select distinct salary from employee where dno=10);

-- 19: Retrieve the name of each employee who has a dependent with the same first name
--  and same sex as the employee
select fname,mname,lname from employee,dependent where dependent.essn=employee.ssn and employee.fname=dependent.dependent_name and employee.sex=dependent.sex;

-- 20: Retrieve the employee numbers of all employees who work on project located in
--  Bellaire, Houston, or Stafford
select ssn from employee,project,works_on where pnumber=pno and essn=ssn and plocation in ("Bellaire","Houston","Stafford");
-- 21: Find the sum of the salaries of all employees, the maximum salary, the minimum
--  salary, and the average salary. Display with proper headings
select sum(salary) as sum_salary,max(salary) as max_salary,min(salary) as min_salary,avg(salary) as average_salary from employee;
-- 22: Find the sum of the salaries and number of employees of all employees of the
--  ‘Marketing’ department, as well as the maximum salary, the minimum salary, and
--  the average salary in this department
select sum(salary),max(salary),min(salary) from employee,department where dno=dnumber and dname="Marketing";
-- 23: Select the names of employees whose salary is greater than the average salary of all
--  employees in department 10
:: Important ::
select fname,mname,lname from employee where salary>(select avg(salary) from employee where dno=10);
-- 24: For each department, retrieve the department number, the number of employees in
--  the department, and their average salary
select dno,count(ssn),avg(salary) from employee group by dno;
-- 25: For each project, retrieve the project number, the project name, and the number of
--  employees who work on that project
select pnumber,pname,count(*) from project,works_on where pnumber=pno group by pnumber;
--  26: Change the location and controlling department number for all projects having more
--  than 5 employees to ‘Bellaire’ and 6 respectively

    :: Very Important ::
update project
set plocation="Bellaire" and dnum=6
where pnumber=(select pno from works_on group by pno having count(essn)>5);

-- 27: For each department having more than 10 employees, retrieve the department no, no of
--  employees drawing more than 40,000 as salary

:: My answer ::
select dno,count(*) from employee where salary>40000 group by dno having count(ssn)>10;

:: Himanshu ::
Select dnumber, count(*) from department, employee where dnumber=dno and salary>40000 and dno in (select dno from employee group by dno having count(*) > 10);

--  Note that if the tables included is just 1 then empty set is returned. In case of join a table is returned with null and 0 values

-- 28: Insert a record in Project table which violates refrential integrity constraint with respect
--  to Department number. Now remove the violation by making necessary insertion in the
--  Department table.
insert into project values("Project Rise",40,"Delhi",3);
--  The above satement gives the referenctial integrity error as there is no department with dnumber 3
-- Adding dept 3 to department table
insert into department values("Marketing",3,123456789,1994-08-13);

--  29: Delete all dependents of employee whose ssn is ‘123456789’
:: Important ::
delete from dependent where essn=123456789;

--  30: Delete an employee from Employee table with ssn = ‘12345’( make sure that this
--  employee has some dependents, is working on some project, is a manager of some
--  department and is supervising some employees). Check and display the cascading
--  effect on Dependent and Works on table. In Department table MGRSSN should be
--  set to default value and in Employee table SUPERSSN should be set to NULL

    /** Inserting data into tables logically **/
insert into employee values("John",NULL,"Doe",12345,1986-06-04,"Lajpat Nagar,New Delhi","M",32000,123456789,4);
insert into department
    values("HR",2,12345,1968-02-02);
insert into dependent
values(12345,"Patricia","F",1996-08-12,"Wife");
insert into project values("Assassination",50,"Dubai",2);
insert into works_on values(12345,2,15);
    /**** Data inserted ****/

    Now here, the parent table is say employee and the child table is works_on table. Since works_on table has a foreign key references to primary key ssn from employee table. If we delete a record from employee table then there would be no value in the foreign key that references to primary key of the table. Hence we use cascade

    How can I add ON DELETE constraint on the table?
ans> Use ALTER TABLE+ADD CONSTRAINT. E.g. if you want to link tables members and profiles by member_id and cascade delete profiles each time the member is deleted, you can write something like this:

ALTER TABLE profiles
   ADD CONSTRAINT `fk_test`
   FOREIGN KEY (`member_id` )
   REFERENCES `members` (`member_id` )
   ON DELETE CASCADE
If you will need to update that constraint - you'll have to remove it at then create again, there's no direct way to alter it.

ALTER TABLE profiles DROP FOREIGN KEY `fk_test`

*******************************************************************************************************

How to determine the index of any foreign key or any constraint??

SHOW CREATE TABLE `works_on`;
Notice the sign around the works_on table. They are tildes not inverted commas.
^^^^ very very important ****

******************************************************************************************************
Hence solution is

-- Drop the foreign key on essn works_on referneces ssn
alter table works_on
drop foreign key works_on_ibfk_1;

-- Drop the forign key essn references dependent essn references ssn employee
    alter table dependent
drop foreign key dependent_ibfk_1;

--  Alter table to remove the constraint foreign key from department
    alter table department
drop foreign key department_ibfk_1;

-- Alter table to insert the on delete cascade option on department table
    alter table department
    add constraint department_ibfk_1
    foreign key(mgrssn) references employee(ssn)
on delete cascade;

-- Similarly apply on project table
    alter table project drop foreign key project_ibfk_1;

-- inserting on cascade on foreeign key
    alter table project add foreign key(dnum) references department(dnumber) on delete cascade;

-- Alter table to insert the on delete cascade option:
    alter table works_on add foreign key(essn) references employee(ssn) on delete cascade;

-- Alter table dependent to insert the on delete cascade option
    alter table dependent add foreign key(essn) references employee(ssn) on delete cascade;

--  Now try deleteing an entry from the parent table:
delete from employee where ssn=12345;

    ^^ It deletes


--  31. Perform a query using alter command to drop/add field and a constraint in Employee
--  table.
    :: Very Important Syntax for add/drop unique constraint ::
/****
To add an unique constraint

ALTER TABLE Persons
ADD CONSTRAINT uc_PersonID UNIQUE (P_Id,LastName)

To drop an unique constraint
ALTER TABLE Persons
DROP INDEX uc_PersonID
**/
-- Adding a unique constaint to column mname
    alter table employee
    add constraint mname_unique unique(mname);
-- Drop an unique constraint
    alter table employee
drop index mname_unique;

    alter table employee
    add constraint unique_bdate unique(bdate);
    alter table employee
    modify bdate date null;
    alter table employee
    add constraint unique_bdate unique(bdate);
    alter table employee
drop index unique_bdate;

    alter table employee
drop index

    show create table `project`;
    alter table project drop index ix_some;
    alter table works_on drop foreign key works_on_ibfk_1;

show create table `

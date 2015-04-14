/*****************************************************************************************
     SQL Queries for Bsc Physical Sciences Computer Science Final Semester 6
*****************************************************************************************/

-- Perform the following queries on database:

-- 1) Display all the details of all employees working in the company.
select * from employee;

- 2) Display ssn, lname, fname, address of employees who work in department no 7.
select ssn,lname,fname,address
from employee
where dno=7;

-- 3) Retrieve the birthdate and address of the employee whose name is 'Franklin T.Wong'
select bdate,address
from employee
where fname="Franklin" and mname="T" and lname="Wong";

-- 4)  Retrieve the name and salary of every employee
select fname,mname,lname,salary
from employee;

-- 5) Retrieve all distinct salary values
select distinct salary
from employee;

-- 6) Retrieve all employee names whose address is in ‘Bellaire’
select fname,mname,lname
from employee
where address="Bellaire";

- 7)  Retrieve all employees who were born during the 1950s (Pending)
select fname
from employee
where bdate between "01-01-50" and "31-12-59";

-- 8)  Retrieve all employees in department 5 whose salary is between 50,000 and 60,000(inclusive)
select *
from employee
where dno=5 and salary >=50000 and salary <=60000;

-- 9)  Retrieve the names of all employees who do not have supervisors
select fname,mname,lname
from employee
where superssn is null;

-- 10)  Retrieve SSN and department name for all employees
select e.ssn, d.dname
from employee e, department d;

-- 11)  Retrieve the name and address of all employees who work for the 'Research'  department
select e.fname,e.address
from employee e, department d
where d.dname="Research";

-- 12) For every project located in 'Stafford', list the project number, the controlling  department number, and the department manager's last name, address, and birthdate
select p.pnumber,p.dnum,e.lname,e.address,e.bdate
from project p, department d, employee e
where p.plocation="Stafford";

-- 13) : For each employee, retrieve the employee's name, and the name of his or her immediate supervisor
select e.fname,e.lname,s.fname,s.lname
from employee as e, employee as s
where s.superssn=e.ssn;

-- 14) Retrieve all combinations of Employee Name and Department Name
select e.fname,e.lname,d.dname
from employee e, department d;

-- 15) Make a list of all project numbers for projects that involve an employee whose last  name is 'Narayan’ either as a worker or as a manager of the department that controls the project
(select distinct pnumber
from project,department,employee
where dnum=dnumber and mgrssn=ssn and lname="Narayan")
union
(select distinct pnumber
from project,works_on,employee
where pnumber=pno and essn=ssn and lname="Narayan");

-- 16) : Increase the salary of all employees working on the 'ProductX' project by 15% .
select fname,lname.1.1*salary as increased_sal
from employee,works_on,project
where ssn=essn and pno=pnumber and pname="productX";

-- 17) Retrieve a list of employees and the project name each works in, ordered by the  employee's department, and within each department ordered alphabetically by  employee first name
select dname,lname,fname,pname
from department,employee,works_on,project
where dnumber=dno and ssn=essn and pno=pnumber
order by dname,lname,fname;

-- 18) Select the names of employees whose salary does not match with salary of any  employee in department 10
select fname
from employee
where salary > all(select salary from employee where dno=5);

-- 19)  Retrieve the name of each employee who has a dependent with the same first name  and same sex as the employee
select e.fname,e.lname
from employee as e
where e.ssn in (select essn from dependent where e.fname=dependent_name and e.sex=sex);

-- 20) Retrieve the employee numbers of all employees who work on project located in  Bellaire, Houston, or Stafford
select ssn
from employee
where ((select pno
        from works_on
        where ssn=essn) contains
        (select pnumber
        from project
        where dnum=5));

-- 21)  Find the sum of the salaries of all employees, the maximum salary, the minimum  salary, and the average salary. Display with proper headings
select sum(salary),max(salary),min(salary),avg(salary)
from employee;

-- 22) Find the sum of the salaries and number of employees of all employees of the  ‘Marketing’ department, as well as the maximum salary, the minimum salary, and  the average salary in this department
select sum(salary),count(*)
from employee, department
where dname like "market%";

-- 23)  Select the names of employees whose salary is greater than the average salary of all  employees in department 10
select fname
from employee
where dno=10
group by salary
having salary>avg(salary);

-- 24) For each department, retrieve the department number, the number of employees in the department, and their average salary
select dno,count(*),avg(salary)
from employee
group by dno;

-- 25) For each project, retrieve the project number, the project name, and the number of  employees who work on that project
select pnumber,pname,count(*)
from project
group by pnumber;

-- 26) Change the location and controlling department number for all projects having more than 5 employees to ‘Bellaire’ and 6 respectively
update project
set plocation="Bellaire", dnum=6
where (select count(essn)
      from works_on
      where pno=pnumber)>5;

  -- 27) : For each department having more than 10 employees, retrieve the department no, no of  employees drawing more than 40,000 as salary
  select dno
  from employee
  where salary>40000
  group by dno
having count(*)>10;

-- 28) Insert a record in Project table which violates refrential integrity constraint with respect to Department number. Now remove the violation by making necessary insertion in the Department table.
insert into project
    values("Research and development",25,"Bhopal",9);
    /* The above query will give an error since there exists no department with department number 9 exixts in the department table */
    /* To remove this error, we create a  record in table department with dnumber as 9 */
insert into department
    values("Research",9,"123","20-08-2012");

-- 29)  Delete all dependents of employee whose ssn is ‘123456789’
delete from dependent
where essn=123456789;

-- 30)  Delete an employee from Employee table with ssn = ‘12345’( make sure that this employee has some dependents, is working on some project, is a manager of some department and is supervising some employees). Check and display the cascading effect on Dependent and Works on table. In Department table MGRSSN should be set to default value and in Employee table SUPERSSN should be set to NULL
delete from employee
where ssn=1234567891 cascade;
    /* ^^ incorrect.. ask */

-- 31) . Perform a query using alter command to drop/add field and a constraint in Employee  table.
    alter table
drop foreign key(superssn);

/*************************************    *END*    *******************************************/

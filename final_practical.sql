/***********************************************************************************
            Fianal Practical Exam
            Bsc (Physical Sciences)
            Database Management Systems
            Date: 27/04/2015
            Semester 6th
***********************************************************************************/

--  Create table book
create table book (bookid int not null, authid int null,title varchar(80) not null,vendorid int null,no_of_copies int null,price int null,publisher varchar(80) not null);
alter table book add primary key(bookid);
alter table book add foreign key(authid) references author(authid);
alter table book add foreign key(vendorid) references vendor(vendorid);

-- Note that if we get an error on indexing, we can create an index to the primary key that is being rederences by entrying something like:
create index book_ibfk_1 on author(authid);
create index book_ibfk_2 on vendor(vendorid);

-- Create table author
create table author(authid int not null,aname varchar(80) not null,addrs varchar(80) not null,phone int null,gender varchar(80) null);
alter table author add primary key(authid);

-- Create table vendor
create table vendor(vendorid int not null,vaname varchar(80) not null,street varchar(80) null,city varchar(80) not null,pin int null,phone int null);
alter table vendor add primary key(vendorid);

-- Create table supply
create table supply(vendorid int not null,bookid int not null,no_of_copies int null,date_of_supply date null);
alter table supply add primary key(vendorid,bookid);
alter table supply add foreign key(vendorid) references vendor(vendorid);
alter table supply add foreign key(bookid) references book(bookid);

    /***********************************************************************************/

--  Insertion of Data into tables

-- Inserting data into book
insert into book values(1,101,"Let us C++",201,1000,250,"Oxford");
insert into book values(2,102,"Compilers",202,2000,1250,"Penguin");
insert into book values(3,101,"Databases",203,3000,1300,"Oxford");

-- Inserting data into author
insert into author values(101,"Yashwant Kanetkar","Borivali East, Maharashtra",931323339,"M");
insert into author values(102,"Jennifer Widom","Stanford University, California",3245553456,"F");
insert into author values(103,"Dan Boneh","Redmomd college, California",333390793,"M");
-- Inserting data into vendor
insert into vendor values(201,"Lucky Exports","Noida","Delhi",23,9988334455);
insert into vendor values(202,"Replica Press","GT Karnal Roald","Sonepat",26,9977225577);
insert into vendor values(203,"Pie","Cyberabad","Hyderabad",null,5599002233);
-- Inserting data into supply
insert into supply values(201,1,300,"2014-08-13");
insert into supply values(202,1,400,"2013-07-18");
insert into supply values(202,2,500,"2012-04-12");
insert into supply values(203,3,600,"2015-06-27");

/*****************************************************************************************/
--  Queries:

-- 1) Display all the books of author 'Kanetkar' available in the library
select title from book,author where author.aname like "%Kanetkar%" and book.authid=author.authid;
-- 2) Delete all the vendors who do not have a pin
delete from vendor where pin is null;
-- 3) Display the list of all the vendors in the descending order of their city and then ascending order of their names.
select * from vendor order by city desc,vaname;
-- 4) Display the list of all books whose price is greater than Rs.1000.
select * from book where price > 1000;
-- 5) Display the bookID,book title,no. of copies supplied by the vendor with vendor name.
select bookid,title,no_of_copies,vaname from book,vendor where book.vendorid=vendor.vendorid;

/********************************************************************************************/

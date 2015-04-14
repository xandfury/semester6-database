-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (i686)
--
-- Host: 127.0.0.1    Database: 6sem
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `DNAME` varchar(30) DEFAULT NULL,
  `DNUMBER` int(11) NOT NULL,
  `MGRSSN` int(11) NOT NULL,
  `MGRSTARTDATE` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`DNUMBER`),
  UNIQUE KEY `MGRSSN` (`MGRSSN`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`MGRSSN`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('strategy',1,123,'13-08-00'),('Finance',2,234,'22-04-04'),('Legal',3,345,'15-02-08'),('Human Resources',4,456,'12-08-08'),('Marketing',5,567,'27-01-03'),('accounts',6,678,'03-09-89'),('IT',7,123456,'12-12-12');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependent` (
  `ESSN` int(11) NOT NULL,
  `DEPENDENT_NAME` varchar(30) NOT NULL,
  `SEX` char(3) DEFAULT 'NA',
  `BDATE` varchar(9) DEFAULT 'NA',
  `RELATIONSHIP` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ESSN`,`DEPENDENT_NAME`),
  CONSTRAINT `dependent_ibfk_1` FOREIGN KEY (`ESSN`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES (123,'Dad','M','19-04-55','Father'),(123,'Mom','F','02-11-61','Mother'),(345,'Malti','F','16-08-13','Wife'),(456,'Astha','F','12-05-94','Sister'),(5342,'Walter','M','06-01-13','Husband');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_locations`
--

DROP TABLE IF EXISTS `dept_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_locations` (
  `DNUMBER` int(11) NOT NULL,
  `DLOCATION` varchar(30) NOT NULL,
  PRIMARY KEY (`DNUMBER`,`DLOCATION`),
  CONSTRAINT `dept_locations_ibfk_1` FOREIGN KEY (`DNUMBER`) REFERENCES `department` (`DNUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_locations`
--

LOCK TABLES `dept_locations` WRITE;
/*!40000 ALTER TABLE `dept_locations` DISABLE KEYS */;
INSERT INTO `dept_locations` VALUES (1,'California'),(2,'Dubai'),(3,'New Delhi'),(4,'Mumbai'),(5,'Calcutta'),(6,'Bagalore'),(7,'New Delhi');
/*!40000 ALTER TABLE `dept_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `FNAME` varchar(20) NOT NULL,
  `LNAME` varchar(20) NOT NULL,
  `MNAME` varchar(10) DEFAULT 'NA',
  `SSN` int(11) NOT NULL,
  `BDATE` varchar(8) DEFAULT 'NA',
  `ADDRESS` varchar(40) DEFAULT 'NA',
  `SEX` char(2) NOT NULL DEFAULT 'NA',
  `SALARY` int(11) NOT NULL,
  `DNO` int(11) NOT NULL,
  `SUPERSSN` int(11) DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  KEY `SUPERSSN` (`SUPERSSN`),
  KEY `DNO` (`DNO`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`SUPERSSN`) REFERENCES `employee` (`SSN`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`DNO`) REFERENCES `department` (`DNUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('abhinav','saxena',NULL,123,'13-08-94','New Delhi','M',2147483647,1,123),('himanshu','verma',NULL,234,'11-12-19','Patel Nagar, New Delhi','M',3333,2,234),('ram','prasad',NULL,345,'11-11-11','Laxmi Bai Nagar','M',33,3,345),('swapnil','verma',NULL,456,'31-07-19','Sector-3, R.K.Puram, New Delhi','M',345666,4,456),('prakul','asthana',NULL,567,'27-01-19','Lodhi Colony','M',234566,5,567),('kanika','dhariwal',NULL,678,'15-04-94','Sector-4, R.K.Puram, New Delhi','F',5677669,6,678),('foo','bar','quax',4567,'27-08-19','Patna, Bihar','F',49000,4,4567),('Rama','Narayan','Krishna',4789,'27-12-50','Shimla, Himachal','M',3333,5,4789),('Pamella','Roy',NULL,5342,'19-06-19','Pune, Maharashtra','F',53000,4,5342),('sushma','prasad','koirala',123456,'03-03-03','Bellaire','F',53000,7,123456),('Shyam','Shankar',NULL,1234567891,'01-10-94',NULL,'M',55000,7,1234567891);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `PNAME` varchar(25) NOT NULL,
  `PNUMBER` int(11) NOT NULL,
  `PLOCATION` varchar(25) DEFAULT NULL,
  `DNUM` int(11) NOT NULL,
  PRIMARY KEY (`PNUMBER`),
  KEY `DNUM` (`DNUM`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`DNUM`) REFERENCES `department` (`DNUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('electrification',21,'Stafford',1),('management-consulting',22,'Houston',2),('startegic-consulting',23,'Ballaire',1),('corporate-training',24,'New Delhi',6),('Legal-case',26,'London',3),('HR-policy making',28,'Dubai',7);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `works_on` (
  `ESSN` int(11) NOT NULL,
  `PNO` int(11) NOT NULL,
  `HOURS` int(11) DEFAULT NULL,
  PRIMARY KEY (`ESSN`,`PNO`),
  KEY `PNO` (`PNO`),
  CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`ESSN`) REFERENCES `employee` (`SSN`),
  CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`PNO`) REFERENCES `project` (`PNUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES (123,22,18),(123,23,17),(345,22,6),(567,28,13),(678,23,14),(5342,26,19);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-14 15:29:32

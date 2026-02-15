-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `AppointmentID` int NOT NULL AUTO_INCREMENT,
  `Reason` varchar(255) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Time` time DEFAULT NULL,
  `Status` enum('Scheduled','Completed','Cancelled','No-Show') DEFAULT 'Scheduled',
  `RecID` int DEFAULT NULL,
  `PatID` int DEFAULT NULL,
  `DocID` int DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  UNIQUE KEY `unique_meeting` (`Date`,`Time`,`PatID`),
  UNIQUE KEY `unique_doctor` (`Date`,`Time`,`DocID`),
  KEY `fk_recid` (`RecID`),
  KEY `fk_patid` (`PatID`),
  KEY `fk_docid` (`DocID`),
  CONSTRAINT `fk_docid` FOREIGN KEY (`DocID`) REFERENCES `doctor` (`DoctorID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_patid` FOREIGN KEY (`PatID`) REFERENCES `patient` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_recid` FOREIGN KEY (`RecID`) REFERENCES `medicalrecord` (`RecordID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (1,'Physical Therapy','2025-11-08','13:30:00','Scheduled',2,4,6),(2,'Physical Therapy','2025-11-07','14:00:00','Completed',5,2,6),(3,'Epilepsy Treatment','2025-12-03','15:25:00','Scheduled',4,3,3),(4,'Common Cold','2025-05-04','10:30:00','No-Show',1,5,1),(5,'Tumor Removal','2025-12-05','11:45:00','Scheduled',3,1,7),(6,'Physical Therapy','2025-01-05','11:00:00','Cancelled',5,2,6),(7,'Physical Therapy','2025-03-06','11:30:00','Cancelled',5,2,6),(8,'Physical Therapy','2025-05-10','12:00:00','No-Show',5,2,6),(9,'Coronavirus','2020-10-01','12:00:00','Completed',6,6,1);
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `DepartmentID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(255) DEFAULT NULL,
  `HeadID` int DEFAULT NULL,
  PRIMARY KEY (`DepartmentID`),
  UNIQUE KEY `unique_headid` (`HeadID`),
  UNIQUE KEY `unique_name` (`Name`),
  UNIQUE KEY `unique_phonenumber` (`PhoneNumber`),
  CONSTRAINT `fk_headid` FOREIGN KEY (`HeadID`) REFERENCES `doctor` (`DoctorID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Pediactrics','937-227-1000',1),(2,'Intensive Care Unit','937-227-1001',5),(3,'Radiology','937-227-1002',3),(4,'Physical Therapy','937-227-1003',6),(5,'Medical-Surgical Unit','937-227-1004',7),(6,'Emergency Department','937-227-1005',4),(7,'OB/GYN','937-227-1006',10);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `DoctorID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `Specialization` varchar(255) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `LicenseNumber` int DEFAULT NULL,
  `DepartmentID` int DEFAULT NULL,
  `Salary` int NOT NULL DEFAULT '50000',
  PRIMARY KEY (`DoctorID`),
  UNIQUE KEY `unique_phonenumber` (`PhoneNumber`),
  UNIQUE KEY `unique_email` (`Email`),
  UNIQUE KEY `unique_licensenumber` (`LicenseNumber`),
  KEY `fk_departmentid` (`DepartmentID`),
  CONSTRAINT `fk_departmentid` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`DepartmentID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `salary_greaterthan_50000` CHECK ((`Salary` >= 50000))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'Peta','Attrics','Pediactrics','2012-05-23','937-327-1000','peta@ohclinic.com',1023498981,1,200000),(2,'Aya','Moore-Jenncy','Emergency','2013-08-11','937-327-1001','aya@ohclinic.com',1435658888,6,300000),(3,'Rad','Aulogee','Radiology','2013-08-11','937-327-1002','rad@ohclinic.com',1534898945,3,500000),(4,'Barack','Obama','Emergency','2013-09-11','937-327-1003','barack@ohclinic.com',1893456889,6,400000),(5,'Aycee','Youh','Intensive Care','2014-02-25','937-327-1004','aycee@ohclinic.com',1324789872,2,300000),(6,'Arnold','Peetee','Physical Therapy','2014-03-28','937-327-1005','arnold@ohclinic.com',1976355687,4,120000),(7,'Mehd','Serge-Rey','Medical Surgery','2014-04-23','937-327-1006','mehd@ohclinic.com',1342278657,5,450000),(9,'Aych','Bahmb','Radiology','2008-09-05','937-327-9995','aych@ohclinic.com',1883872345,3,400000),(10,'Boore-rock','Ahbohma','OB/GYN','2008-10-06','937-327-9996','boore@ohclinic.com',1889991113,7,350000),(11,'John','Physical Therapy','Physical Therapy','2009-11-07','937-327-9999','john@ohclinic.com',1929456977,4,100000);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_doctor_salary_before_insert` BEFORE INSERT ON `doctor` FOR EACH ROW BEGIN
    DECLARE head_salary DECIMAL(10,2);
    
    
    SELECT d.Salary INTO head_salary
    FROM Doctor d
    INNER JOIN Department dep ON d.DoctorID = dep.HeadID
    WHERE dep.DepartmentID = NEW.DepartmentID;
    
    IF head_salary IS NOT NULL AND NEW.Salary > head_salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Doctor salary cannot exceed department head salary';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_doctor_salary_before_update` BEFORE UPDATE ON `doctor` FOR EACH ROW BEGIN
    DECLARE head_salary DECIMAL(10,2);
    DECLARE is_head INT;
    DECLARE max_dept_salary DECIMAL(10,2);
    
    SELECT COUNT(*) INTO is_head
    FROM Department
    WHERE HeadID = NEW.DoctorID;
    
    IF is_head > 0 THEN
        SELECT MAX(d.Salary) INTO max_dept_salary
        FROM Doctor d
        INNER JOIN Department dep ON d.DepartmentID = dep.DepartmentID
        WHERE dep.HeadID = NEW.DoctorID
          AND d.DoctorID != NEW.DoctorID;
        
        IF max_dept_salary IS NOT NULL AND NEW.Salary < max_dept_salary THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Department head salary cannot be lower than department doctors';
        END IF;
    ELSE
        SELECT d.Salary INTO head_salary
        FROM Doctor d
        INNER JOIN Department dep ON d.DoctorID = dep.HeadID
        WHERE dep.DepartmentID = NEW.DepartmentID;
        
        IF head_salary IS NOT NULL AND NEW.Salary > head_salary THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Doctor salary cannot exceed department head salary';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `emergencycontacts`
--

DROP TABLE IF EXISTS `emergencycontacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emergencycontacts` (
  `ContactID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `PatientID` int DEFAULT NULL,
  PRIMARY KEY (`ContactID`),
  UNIQUE KEY `unique_number` (`PhoneNumber`),
  KEY `fk_patientid` (`PatientID`),
  CONSTRAINT `fk_patientid` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emergencycontacts`
--

LOCK TABLES `emergencycontacts` WRITE;
/*!40000 ALTER TABLE `emergencycontacts` DISABLE KEYS */;
INSERT INTO `emergencycontacts` VALUES (1,'Geralt','Of-Rivia','787-993-8949',1),(2,'V','Punk','993-484-9870',1),(3,'CD','Projekt','839-789-1000',1),(4,'Tole','Tole','839-890-1001',4),(5,'Opeth','Band','764-901-3001',10),(6,'Bat','Man','111-111-1111',8),(7,'Alfred','Pennyworth','112-111-1111',8),(8,'Santa','Claus','333-333-3334',11);
/*!40000 ALTER TABLE `emergencycontacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicalrecord`
--

DROP TABLE IF EXISTS `medicalrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicalrecord` (
  `RecordID` int NOT NULL AUTO_INCREMENT,
  `Diagnosis` varchar(255) DEFAULT NULL,
  `Treatment` varchar(255) DEFAULT NULL,
  `PID` int DEFAULT NULL,
  `DID` int DEFAULT NULL,
  PRIMARY KEY (`RecordID`),
  KEY `fk_did` (`DID`),
  KEY `fk_pid` (`PID`),
  CONSTRAINT `fk_did` FOREIGN KEY (`DID`) REFERENCES `doctor` (`DoctorID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_pid` FOREIGN KEY (`PID`) REFERENCES `patient` (`PatientID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicalrecord`
--

LOCK TABLES `medicalrecord` WRITE;
/*!40000 ALTER TABLE `medicalrecord` DISABLE KEYS */;
INSERT INTO `medicalrecord` VALUES (1,'Rhinovirus','Medication and Rest',5,1),(2,'Minor Scoliosis','BiWeekly PT Sessions and pain relief medication as needed',4,6),(3,'Grade 1 Glioma','Surgery',1,7),(4,'Epilepsy','Stereotactic Radiosurgery',3,3),(5,'Hip Impingement','PT Sessions',2,6),(6,'Covid-19','Antiviral medication',6,1);
/*!40000 ALTER TABLE `medicalrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `PatientID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `InsuranceInfo` enum('Not Insured','Insured') NOT NULL DEFAULT 'Not Insured',
  PRIMARY KEY (`PatientID`),
  UNIQUE KEY `unique_number` (`PhoneNumber`),
  UNIQUE KEY `unique_email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'Johnny','Silverhand','2003-05-19','447-278-8888','silverhand@gmail.com','Insured'),(2,'Mr','Beast','1998-08-25','442-191-1999','beast@yahoo.com','Not Insured'),(3,'Oh-Long','Johnson','1956-04-23','459-234-3459','johnson@wright.edu','Insured'),(4,'Vro','Meimei','1956-04-24','459-239-3888','vromeimei@yahoo.com','Not Insured'),(5,'John','Dark-Souls','2011-10-04','378-229-3548','miyazaki@gmail.com','Insured'),(6,'John','Halo','2011-10-04','848-929-1283','chief@gmail.com','Insured'),(7,'Syber','Poonk','2008-10-04','838-536-9918','punk77@yahoo.com','Not Insured'),(8,'Bruce','Wayne','1988-11-04','353-292-1818','wayne@wayne.com','Not Insured'),(9,'Ohbama','Obama','2008-11-05','317-272-8888','barack@whitehouse.com','Insured'),(10,'Mikael','Akerfeldt','1999-11-08','888-939-888','sorrow@gmail.com','Insured'),(11,'Last','Christmas','2000-12-25','999-999-9999','gaveyoumyheart@gmail.com','Insured');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `PrescriptionID` int NOT NULL AUTO_INCREMENT,
  `RID` int NOT NULL,
  `MedicationName` varchar(100) DEFAULT NULL,
  `Dosage` varchar(50) DEFAULT NULL,
  `Frequency` varchar(100) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  PRIMARY KEY (`PrescriptionID`),
  UNIQUE KEY `unique_medicine` (`RID`,`MedicationName`,`Dosage`,`Frequency`,`StartDate`),
  CONSTRAINT `fk_prescribedid` FOREIGN KEY (`RID`) REFERENCES `medicalrecord` (`RecordID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_startdate_lessthan_enddate` CHECK ((`StartDate` < `EndDate`)),
  CONSTRAINT `dates_not_equal` CHECK (((`StartDate` <> `EndDate`) or (`EndDate` is null)))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
INSERT INTO `prescription` VALUES (1,4,'Brivaracetam','50 mg','Twice a day','2025-11-07','2026-11-07'),(2,6,'Nirmatrelvir','150 mg','Twice a day','2020-10-01','2020-10-06'),(3,6,'Ritonavir','100 mg','Twice a day','2020-10-01','2020-10-06'),(4,3,'Morphine','2.5 mg','Every four hours','2020-12-05','2020-12-12');
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hospital'
--

--
-- Dumping routines for database 'hospital'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-04 13:44:57

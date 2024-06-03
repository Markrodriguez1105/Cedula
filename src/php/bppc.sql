-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 03, 2024 at 02:06 AM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bppc`
--

-- --------------------------------------------------------

--
-- Table structure for table `cedula`
--

DROP TABLE IF EXISTS `cedula`;
CREATE TABLE IF NOT EXISTS `cedula` (
  `cedula_number` varchar(20) NOT NULL,
  `date_issued` date NOT NULL,
  `place_of_issue` varchar(100) NOT NULL,
  `basic_comm_tax` int NOT NULL,
  `gross_receipts` decimal(10,2) DEFAULT '0.00',
  `gross_amounts` decimal(10,2) DEFAULT '0.00',
  `salaries_receipts` decimal(10,2) DEFAULT '0.00',
  `salaries_amounts` decimal(10,2) DEFAULT '0.00',
  `income_property` decimal(10,2) DEFAULT '0.00',
  `income_amounts` decimal(10,2) DEFAULT '0.00',
  `interest` decimal(10,2) DEFAULT '0.00',
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `lname` varchar(50) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `address` varchar(255) NOT NULL,
  `citizenship` varchar(50) NOT NULL,
  `civil_status` varchar(20) NOT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `birthdate` date NOT NULL,
  `place_of_birth` varchar(100) NOT NULL,
  `occupation` varchar(100) NOT NULL,
  `tin_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cedula_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cedula`
--

INSERT INTO `cedula` (`cedula_number`, `date_issued`, `place_of_issue`, `basic_comm_tax`, `gross_receipts`, `gross_amounts`, `salaries_receipts`, `salaries_amounts`, `income_property`, `income_amounts`, `interest`, `fname`, `mname`, `lname`, `gender`, `address`, `citizenship`, `civil_status`, `height`, `weight`, `birthdate`, `place_of_birth`, `occupation`, `tin_number`) VALUES
('2024005', '2024-06-01', 'Barangay Bonifacio', 5, 30.00, 30000.00, 40.00, 40000.00, 9.00, 9000.00, 300.00, 'Jose', 'D.', 'Martinez', 'Male', '3344 Mabini St., San Fernando, Camarines Sur', 'Filipino', 'Divorced', 180.00, 80.00, '1965-05-15', 'San Fernando, Camarines Sur', 'Businessman', '998877665'),
('2024004', '2024-06-01', 'Barangay Bonifacio', 5, 25.00, 25000.00, 35.00, 35000.00, 8.00, 8000.00, 250.00, 'Ana', 'R.', 'Reyes', 'Female', '1122 Rizal Ave., San Fernando, Camarines Sur', 'Filipino', 'Widowed', 165.00, 65.00, '1975-04-30', 'San Fernando, Camarines Sur', 'Nurse', '556677889'),
('2024003', '2024-06-01', 'Barangay Bonifacio', 5, 20.00, 20000.00, 30.00, 30000.00, 7.00, 7000.00, 200.00, 'Pedro', 'S.', 'Gonzales', 'Male', '9101 Mabini St., San Fernando, Camarines Sur', 'Filipino', 'Single', 175.00, 75.00, '1980-03-25', 'San Fernando, Camarines Sur', 'Farmer', '112233445'),
('2024002', '2024-06-01', 'Barangay Bonifacio', 5, 15.00, 15000.00, 25.00, 25000.00, 6.00, 6000.00, 150.00, 'Maria', 'L.', 'Santos', 'Female', '5678 Rizal Ave., San Fernando, Camarines Sur', 'Filipino', 'Married', 160.00, 60.00, '1985-02-14', 'San Fernando, Camarines Sur', 'Teacher', '987654321'),
('2024001', '2012-06-01', 'Barangay Bonifacio', 5, 10.00, 10000.00, 20.00, 20000.00, 5.00, 5000.00, 100.00, 'Juan', 'M.', 'Dela Cruz', 'Male', '1234 Mabini St., San Fernando, Camarines Sur', 'Filipino', 'Single', 170.00, 70.00, '1990-01-01', 'San Fernando, Camarines Sur', 'Engineer', '123456789');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

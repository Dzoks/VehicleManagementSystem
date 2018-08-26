-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.3.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for vehicle_reservation
DROP DATABASE IF EXISTS `vehicle_reservation`;
CREATE DATABASE IF NOT EXISTS `vehicle_reservation` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vehicle_reservation`;

-- Dumping structure for table vehicle_reservation.company
DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.company: ~4 rows (approximately)
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id`, `name`, `deleted`) VALUES
	(1, 'Telegroup', 0),
	(3, 'Test Kompanijaca', 0),
	(4, 'Kompanijica1', 1),
	(5, 'Test', 1);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.expense
DROP TABLE IF EXISTS `expense`;
CREATE TABLE IF NOT EXISTS `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(8,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `expense_type_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `R_17` (`expense_type_id`),
  KEY `R_18` (`company_id`),
  KEY `R_19` (`vehicle_id`),
  CONSTRAINT `R_17` FOREIGN KEY (`expense_type_id`) REFERENCES `expense_type` (`id`),
  CONSTRAINT `R_18` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `R_19` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.expense: ~0 rows (approximately)
/*!40000 ALTER TABLE `expense` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.expense_type
DROP TABLE IF EXISTS `expense_type`;
CREATE TABLE IF NOT EXISTS `expense_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.expense_type: ~3 rows (approximately)
/*!40000 ALTER TABLE `expense_type` DISABLE KEYS */;
INSERT INTO `expense_type` (`id`, `value`) VALUES
	(1, 'Gorivo'),
	(2, 'Servis'),
	(3, 'Ostalo');
/*!40000 ALTER TABLE `expense_type` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.fuel_type
DROP TABLE IF EXISTS `fuel_type`;
CREATE TABLE IF NOT EXISTS `fuel_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.fuel_type: ~2 rows (approximately)
/*!40000 ALTER TABLE `fuel_type` DISABLE KEYS */;
INSERT INTO `fuel_type` (`id`, `value`) VALUES
	(1, 'Benzin'),
	(3, 'Nafta');
/*!40000 ALTER TABLE `fuel_type` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.location
DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(64) NOT NULL,
  `lat` double NOT NULL,
  `lng` double NOT NULL,
  `company_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `R_11` (`company_id`),
  CONSTRAINT `R_11` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.location: ~7 rows (approximately)
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` (`id`, `label`, `lat`, `lng`, `company_id`, `deleted`) VALUES
	(4, 'Lokacija 22', 5, 5, 3, 0),
	(6, 'Lokacija 22', 5, 5, 3, 1),
	(8, 'Majina kuća', 44.994626, 17.41418329999999, 1, 0),
	(9, 'Banja Luka', 44.77413090075676, 17.21503259277347, 1, 0),
	(10, 'Ilova City', 44.91228411363978, 17.679590702343603, 1, 0),
	(11, 'Hrvacani', 44.79965139999999, 17.138052399999992, 1, 1),
	(12, 'Trn', 44.8243333, 17.171148300000027, 1, 1);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.logger
DROP TABLE IF EXISTS `logger`;
CREATE TABLE IF NOT EXISTS `logger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_type` varchar(128) NOT NULL,
  `action_details` varchar(1024) NOT NULL,
  `table_name` varchar(128) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `atomic` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `R_9` (`user_id`),
  KEY `R_10` (`company_id`),
  CONSTRAINT `R_10` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `R_9` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.logger: ~75 rows (approximately)
/*!40000 ALTER TABLE `logger` DISABLE KEYS */;
INSERT INTO `logger` (`id`, `action_type`, `action_details`, `table_name`, `created`, `atomic`, `user_id`, `company_id`) VALUES
	(1, 'create', 'Kreiran je novi entitet: Company{id=2, name=\'Scout\', deleted=0}', 'Company', '2018-08-16 13:50:30', 1, 1, NULL),
	(2, 'delete', 'Obrisan je entitet: Company{id=2, name=\'Scout\', deleted=0}.', 'Company', '2018-08-16 13:55:30', 1, 1, NULL),
	(3, 'create', 'Kreiran je novi entitet: Company{id=3, name=\'Test Kompanija\', deleted=0}.', 'Company', '2018-08-16 23:37:51', 1, 1, NULL),
	(4, 'update', 'A&#x017E;uriran je entitet: Company{id=3, name=\'Test Kompanijac\', deleted=0} na novu vrijednost: Company{id=3, name=\'Test Kompanijaca\', deleted=0}.', 'Company', '2018-08-16 23:41:28', 1, 1, NULL),
	(5, 'delete', 'Obrisan je entitet: Company{id=3, name=\'Test Kompanijaca\', deleted=1}.', 'Company', '2018-08-17 00:19:40', 1, 1, NULL),
	(6, 'delete', 'Obrisan je entitet: Company{id=3, name=\'Test Kompanijaca\', deleted=1}.', 'Company', '2018-08-17 00:25:04', 1, 1, NULL),
	(7, 'create', 'Kreiran je novi entitet: Company{id=4, name=\'Kompanijica\', deleted=0}.', 'Company', '2018-08-17 09:16:05', 1, 1, NULL),
	(8, 'update', 'A&#x017E;uriran je entitet: Company{id=4, name=\'Kompanijica\', deleted=0} na novu vrijednost: Company{id=4, name=\'Kompanijica1\', deleted=0}.', 'Company', '2018-08-17 09:16:12', 1, 1, NULL),
	(9, 'delete', 'Obrisan je entitet: Company{id=4, name=\'Kompanijica1\', deleted=1}.', 'Company', '2018-08-17 09:16:20', 1, 1, NULL),
	(10, 'create', 'Kreiran je novi entitet: Company{id=5, name=\'Test\', deleted=0}.', 'Company', '2018-08-18 17:54:14', 1, 1, NULL),
	(11, 'delete', 'Obrisan je entitet: Company{id=5, name=\'Test\', deleted=1}.', 'Company', '2018-08-18 17:55:32', 1, 1, NULL),
	(12, 'create', 'Kreiran je novi entitet: com.telegroup_ltd.vehicle_management.model.Manufacturer@20.', 'Manufacturer', '2018-08-18 21:53:44', 1, 1, NULL),
	(13, 'create', 'Kreiran je novi entitet: com.telegroup_ltd.vehicle_management.model.Manufacturer@22.', 'Manufacturer', '2018-08-18 21:54:31', 1, 1, NULL),
	(14, 'update', 'A&#x017E;uriran je entitet: com.telegroup_ltd.vehicle_management.model.Manufacturer@22 na novu vrijednost: com.telegroup_ltd.vehicle_management.model.Manufacturer@22.', 'Manufacturer', '2018-08-18 22:09:35', 1, 1, NULL),
	(15, 'update', 'A&#x017E;uriran je entitet: com.telegroup_ltd.vehicle_management.model.Manufacturer@20 na novu vrijednost: com.telegroup_ltd.vehicle_management.model.Manufacturer@20.', 'Manufacturer', '2018-08-18 22:14:36', 1, 3, 1),
	(16, 'update', 'A&#x017E;uriran je entitet: com.telegroup_ltd.vehicle_management.model.Manufacturer@20 na novu vrijednost: com.telegroup_ltd.vehicle_management.model.Manufacturer@20.', 'Manufacturer', '2018-08-18 22:23:26', 1, 3, 1),
	(17, 'update', 'A&#x017E;uriran je entitet: User{id=3, username=\'admin\', firstName=\'Vladimir\', lastName=\'Putin\', registrationDate=2018-08-17 10:45:58.0, email=\'president@mail.ru\', roleId=2, statusId=2, companyId=1, notificationTypeId=1, locationId=null} na novu vrijednost: User{id=3, username=\'admin\', firstName=\'Vladimir\', lastName=\'Putin\', registrationDate=2018-08-17 10:45:58.0, email=\'president1@mail.ru\', roleId=2, statusId=2, companyId=1, notificationTypeId=1, locationId=null}.', 'User', '2018-08-18 22:25:47', 1, 3, 1),
	(18, 'update', 'A&#x017E;uriran je entitet: Location{id=3, name=\'Lokacija 1\', latitude=5.0, longitude=5.0, companyId=1, deleted=0} na novu vrijednost: Location{id=3, name=\'Lokacija 12\', latitude=5.0, longitude=5.0, companyId=1, deleted=0}.', 'Location', '2018-08-18 22:29:55', 1, 3, 1),
	(19, 'delete', 'Obrisan je entitet: Location{id=3, name=\'Lokacija 12\', latitude=5.0, longitude=5.0, companyId=1, deleted=1}.', 'Location', '2018-08-18 22:30:20', 1, 3, 1),
	(20, 'update', 'A&#x017E;uriran je entitet: Location{id=4, name=\'Lokacija 2\', latitude=5.0, longitude=5.0, companyId=3, deleted=0} na novu vrijednost: Location{id=4, name=\'Lokacija 22\', latitude=5.0, longitude=5.0, companyId=3, deleted=0}.', 'Location', '2018-08-18 22:32:36', 1, 1, NULL),
	(21, 'create', 'Kreiran je novi entitet: User{id=5, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-20 20:54:23.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-20 20:54:24', 1, 1, NULL),
	(22, 'create', 'Kreiran je novi entitet: User{id=6, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-20 20:57:59.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-20 20:57:59', 1, 1, NULL),
	(23, 'create', 'Kreiran je novi entitet: User{id=7, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-20 21:02:54.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=3, notificationTypeId=3, locationId=null}.', 'User', '2018-08-20 21:02:54', 1, 1, NULL),
	(24, 'create', 'Kreiran je novi entitet: User{id=8, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-20 21:54:03.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-20 21:54:03', 1, 1, NULL),
	(25, 'create', 'Kreiran je novi entitet: User{id=9, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-20 22:00:30.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-20 22:00:30', 1, 1, NULL),
	(26, 'create', 'Kreiran je novi entitet: User{id=10, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-20 22:07:56.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=3, notificationTypeId=3, locationId=null}.', 'User', '2018-08-20 22:07:56', 1, 1, NULL),
	(27, 'create', 'Kreiran je novi entitet: User{id=11, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-20 23:43:15.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-20 23:43:15', 1, 1, NULL),
	(28, 'create', 'Kreiran je novi entitet: User{id=12, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-20 23:43:55.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=3, notificationTypeId=3, locationId=null}.', 'User', '2018-08-20 23:43:55', 1, 1, NULL),
	(29, 'create', 'Kreiran je novi entitet: User{id=13, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:23:32.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:23:32', 1, 1, NULL),
	(30, 'delete', 'Obrisan je entitet: User{id=13, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:23:32.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=3, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:24:19', 1, 1, NULL),
	(31, 'create', 'Kreiran je novi entitet: User{id=14, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:25:05.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:25:05', 1, 1, NULL),
	(32, 'create', 'Kreiran je novi entitet: User{id=15, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:26:35.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=3, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:26:35', 1, 1, NULL),
	(33, 'delete', 'Obrisan je entitet: User{id=3, username=\'admin\', firstName=\'Vladimir\', lastName=\'Putin\', registrationDate=2018-08-18 22:46:57.0, email=\'president1@mail.ru\', roleId=2, statusId=3, companyId=1, notificationTypeId=1, locationId=null}.', 'User', '2018-08-21 11:27:34', 1, 1, NULL),
	(34, 'create', 'Kreiran je novi entitet: User{id=16, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:31:30.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:31:30', 1, 1, NULL),
	(35, 'create', 'Kreiran je novi entitet: User{id=17, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:33:50.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=3, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:33:50', 1, 1, NULL),
	(36, 'create', 'Kreiran je novi entitet: User{id=18, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:38:03.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:38:03', 1, 1, NULL),
	(37, 'create', 'Kreiran je novi entitet: User{id=19, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:39:31.0, email=\'turjacanin.djordje@gmail.com\', roleId=3, statusId=2, companyId=3, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:39:31', 1, 1, NULL),
	(38, 'create', 'Kreiran je novi entitet: User{id=20, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:43:45.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:43:45', 1, 1, NULL),
	(39, 'create', 'Kreiran je novi entitet: User{id=21, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:50:24.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=3, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:50:24', 1, 1, NULL),
	(40, 'create', 'Kreiran je novi entitet: User{id=22, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:52:57.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:52:57', 1, 1, NULL),
	(41, 'create', 'Kreiran je novi entitet: User{id=23, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:58:15.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=3, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:58:15', 1, 1, NULL),
	(42, 'create', 'Kreiran je novi entitet: User{id=24, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 11:59:21.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 11:59:21', 1, 1, NULL),
	(43, 'create', 'Kreiran je novi entitet: User{id=25, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 12:03:23.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 12:03:24', 1, 1, NULL),
	(44, 'delete', 'Obrisan je entitet: User{id=25, username=\'admin\', firstName=\'dsfsafd\', lastName=\'dfdasfas\', registrationDate=2018-08-21 12:03:23.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=3, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 12:04:21', 1, 1, NULL),
	(45, 'create', 'Kreiran je novi entitet: User{id=26, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 12:04:34.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 12:04:34', 1, 1, NULL),
	(46, 'delete', 'Obrisan je entitet: User{id=26, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 12:04:34.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=3, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 12:04:39', 1, 1, NULL),
	(47, 'create', 'Kreiran je novi entitet: User{id=27, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-21 13:40:12.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-21 13:40:12', 1, 1, NULL),
	(48, 'create', 'Kreiran je novi entitet: Location{id=7, name=\'Not real Twi Peaks\', latitude=-97.24126719999998, longitude=-97.24126719999998, companyId=1, deleted=0}.', 'Location', '2018-08-22 12:45:21', 1, 3, 1),
	(49, 'create', 'Kreiran je novi entitet: Location{id=8, name=\'Majina kuća\', latitude=17.41418329999999, longitude=17.41418329999999, companyId=1, deleted=0}.', 'Location', '2018-08-22 12:45:51', 1, 3, 1),
	(50, 'create', 'Kreiran je novi entitet: Location{id=9, name=\'Banja Luka\', latitude=17.203359619140656, longitude=17.203359619140656, companyId=1, deleted=0}.', 'Location', '2018-08-22 23:54:59', 1, 3, 1),
	(51, 'create', 'Kreiran je novi entitet: Location{id=10, name=\'Ilova City\', latitude=17.679590702343603, longitude=17.679590702343603, companyId=1, deleted=0}.', 'Location', '2018-08-23 00:04:53', 1, 3, 1),
	(52, 'create', 'Kreiran je novi entitet: Location{id=11, name=\'Hrvacani\', latitude=17.138052399999992, longitude=17.138052399999992, companyId=1, deleted=0}.', 'Location', '2018-08-23 00:28:11', 1, 3, 1),
	(53, 'create', 'Kreiran je novi entitet: Location{id=12, name=\'Trn\', latitude=17.171148300000027, longitude=17.171148300000027, companyId=1, deleted=0}.', 'Location', '2018-08-23 00:29:49', 1, 3, 1),
	(54, 'delete', 'Obrisan je entitet: Location{id=11, name=\'Hrvacani\', latitude=17.138052399999992, longitude=17.138052399999992, companyId=1, deleted=1}.', 'Location', '2018-08-23 00:32:07', 1, 3, 1),
	(55, 'delete', 'Obrisan je entitet: Location{id=12, name=\'Trn\', latitude=17.171148300000027, longitude=17.171148300000027, companyId=1, deleted=1}.', 'Location', '2018-08-23 10:02:17', 1, 3, 1),
	(56, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.203359619140656, longitude=17.203359619140656, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.20129968261722, longitude=17.20129968261722, companyId=1, deleted=0}.', 'Location', '2018-08-26 18:59:54', 1, 3, 1),
	(57, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.20129968261722, longitude=17.20129968261722, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.19855310058597, longitude=17.19855310058597, companyId=1, deleted=0}.', 'Location', '2018-08-26 19:00:12', 1, 3, 1),
	(58, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.19855310058597, longitude=17.19855310058597, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.19855310058597, longitude=17.19855310058597, companyId=1, deleted=0}.', 'Location', '2018-08-26 19:01:06', 1, 3, 1),
	(59, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.19855310058597, longitude=17.19855310058597, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.21503259277347, longitude=17.21503259277347, companyId=1, deleted=0}.', 'Location', '2018-08-26 19:02:55', 1, 3, 1),
	(60, 'create', 'Kreiran je novi entitet: User{id=28, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:02:30.0, email=\'etfbl.dzoks@gmail.com\', roleId=3, statusId=2, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2018-08-26 20:02:30', 1, 3, 1),
	(61, 'delete', 'Obrisan je entitet: User{id=28, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:02:30.0, email=\'etfbl.dzoks@gmail.com\', roleId=3, statusId=3, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2018-08-26 20:06:11', 1, 3, 1),
	(62, 'create', 'Kreiran je novi entitet: User{id=29, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:25:32.0, email=\'etfbl.dzoks@gmail.com\', roleId=3, statusId=2, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-26 20:25:32', 1, 3, 1),
	(63, 'delete', 'Obrisan je entitet: User{id=29, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:25:32.0, email=\'etfbl.dzoks@gmail.com\', roleId=3, statusId=3, companyId=1, notificationTypeId=3, locationId=null}.', 'User', '2018-08-26 20:25:35', 1, 3, 1),
	(64, 'create', 'Kreiran je novi entitet: User{id=30, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:25:51.0, email=\'etfbl.dzoks@gmail.com\', roleId=3, statusId=2, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2018-08-26 20:25:51', 1, 3, 1),
	(65, 'delete', 'Obrisan je entitet: User{id=30, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:25:51.0, email=\'etfbl.dzoks@gmail.com\', roleId=3, statusId=3, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2018-08-26 20:26:00', 1, 3, 1),
	(66, 'create', 'Kreiran je novi entitet: User{id=31, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:27:13.0, email=\'etfbl.dzoks@gmail.com\', roleId=3, statusId=2, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2018-08-26 20:27:13', 1, 3, 1),
	(67, 'create', 'Kreiran je novi entitet: User{id=32, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:29:58.0, email=\'dasd@ds.c\', roleId=2, statusId=2, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2018-08-26 20:29:58', 1, 3, 1),
	(68, 'create', 'Kreiran je novi entitet: User{id=33, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:30:16.0, email=\'sdsd@gd.c\', roleId=3, statusId=2, companyId=1, notificationTypeId=3, locationId=9}.', 'User', '2018-08-26 20:30:16', 1, 3, 1),
	(71, 'create', 'Kreiran je novi entitet: User{id=36, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:41:34.0, email=\'sda@sd.c\', roleId=3, statusId=2, companyId=1, notificationTypeId=3, locationId=9}.', 'User', '2018-08-26 20:41:34', 1, 3, 1),
	(72, 'create', 'Kreiran je novi entitet: User{id=37, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:43:46.0, email=\'dssad@asd.c\', roleId=3, statusId=2, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2018-08-26 20:43:46', 1, 3, 1),
	(73, 'create', 'Kreiran je novi entitet: User{id=38, username=\'null\', firstName=\'null\', lastName=\'null\', registrationDate=2018-08-26 20:44:03.0, email=\'da@aa.c\', roleId=3, statusId=2, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2018-08-26 20:44:03', 1, 3, 1),
	(74, 'create', 'Kreiran je novi entitet: Vehicle{id=3, name=\'Suza\', description=\'1993\', deleted=null, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-064\', fuelTypeId=1, locationId=9}.', 'Vehicle', '2018-08-26 23:58:42', 1, 27, 1),
	(75, 'create', 'Kreiran je novi entitet: Vehicle{id=4, name=\'asd\', description=\'\', deleted=null, model=\'asd\', manufacturer=\'sds\', companyId=1, registration=\'das\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2018-08-27 00:00:47', 1, 27, 1),
	(76, 'delete', 'Obrisan je entitet: Vehicle{id=4, name=\'asd\', description=\'\', deleted=1, model=\'asd\', manufacturer=\'sds\', companyId=1, registration=\'das\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2018-08-27 00:05:02', 1, 27, 1),
	(77, 'delete', 'Obrisan je entitet: Vehicle{id=3, name=\'Suza\', description=\'1993\', deleted=1, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-064\', fuelTypeId=1, locationId=9}.', 'Vehicle', '2018-08-27 00:11:02', 1, 27, 1);
/*!40000 ALTER TABLE `logger` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.notification_type
DROP TABLE IF EXISTS `notification_type`;
CREATE TABLE IF NOT EXISTS `notification_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.notification_type: ~3 rows (approximately)
/*!40000 ALTER TABLE `notification_type` DISABLE KEYS */;
INSERT INTO `notification_type` (`id`, `value`) VALUES
	(1, 'Isključena'),
	(2, 'Za lokaciju'),
	(3, 'Za kompaniju');
/*!40000 ALTER TABLE `notification_type` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.reservation
DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_mileage` int(11) NOT NULL,
  `end_mileage` int(11) DEFAULT NULL,
  `direction` varchar(512) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `company_id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `R_25` (`company_id`),
  KEY `R_26` (`vehicle_id`),
  KEY `R_27` (`user_id`),
  CONSTRAINT `R_25` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `R_26` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`),
  CONSTRAINT `R_27` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.reservation: ~0 rows (approximately)
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.role
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.role: ~3 rows (approximately)
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `value`) VALUES
	(1, 'Administrator sistema'),
	(2, 'Administrator kompanije'),
	(3, 'Korisnik');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.status: ~3 rows (approximately)
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` (`id`, `value`) VALUES
	(1, 'Aktivan'),
	(2, 'Na čekanju'),
	(3, 'Neaktivan');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `first_name` varchar(64) DEFAULT NULL,
  `last_name` varchar(64) DEFAULT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `token` char(64) DEFAULT NULL,
  `email` varchar(64) NOT NULL,
  `role_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `notification_type_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `R_5` (`role_id`),
  KEY `R_6` (`status_id`),
  KEY `R_7` (`company_id`),
  KEY `R_28` (`notification_type_id`),
  KEY `R_29` (`location_id`),
  CONSTRAINT `R_28` FOREIGN KEY (`notification_type_id`) REFERENCES `notification_type` (`id`),
  CONSTRAINT `R_29` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `R_5` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `R_6` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `R_7` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.user: ~3 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `registration_date`, `token`, `email`, `role_id`, `status_id`, `company_id`, `notification_type_id`, `location_id`) VALUES
	(1, 'admin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC', 'Djordje', 'Turjačanin', '2018-08-16 14:46:44', NULL, 'turjacanin.djordje@gmail.com', 1, 1, NULL, 1, NULL),
	(3, 'putin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC', 'Vladimir', 'Putin', '2018-08-26 20:57:16', NULL, 'president1@mail.ru', 2, 1, 1, 1, 10),
	(27, 'admin', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', 'Djordje', 'Turjacanin II', '2018-08-26 20:57:16', NULL, 'turjacanin.djordje@gmail.com', 2, 1, 1, 3, 8);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.vehicle
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `manufacturer` varchar(64) NOT NULL,
  `model` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `company_id` int(11) NOT NULL,
  `registration` varchar(64) NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `fuel_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `R_16` (`company_id`),
  KEY `vehicle_location_id_fk` (`location_id`),
  KEY `vehicle_fuel_type_id_fk` (`fuel_type_id`),
  CONSTRAINT `R_16` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `vehicle_fuel_type_id_fk` FOREIGN KEY (`fuel_type_id`) REFERENCES `fuel_type` (`id`),
  CONSTRAINT `vehicle_location_id_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.vehicle: ~2 rows (approximately)
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` (`id`, `name`, `manufacturer`, `model`, `description`, `deleted`, `company_id`, `registration`, `location_id`, `fuel_type_id`) VALUES
	(1, 'IV 1.9 TDI', 'VW', 'Golf', 'Vozila ga baba iz njemacke', 0, 1, '823-J-231', 8, 1),
	(2, 'Suza', 'Opel', 'Kadet', '', 0, 1, '825-J-064', 10, 1);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

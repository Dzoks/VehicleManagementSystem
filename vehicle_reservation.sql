-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.3.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
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
CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.company: ~5 rows (approximately)
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` (`id`, `name`, `deleted`) VALUES
	(1, 'Telegroup', 0),
	(3, 'Test Kompanijac', 0),
	(4, 'Kompanijica1', 1),
	(5, 'Test', 1),
	(6, 'TEST', 0);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.expense
CREATE TABLE IF NOT EXISTS `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` decimal(8,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `expense_type_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reservation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `R_17` (`expense_type_id`),
  KEY `R_18` (`company_id`),
  KEY `R_19` (`vehicle_id`),
  KEY `FK_expense_reservation` (`reservation_id`),
  CONSTRAINT `FK_expense_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`id`),
  CONSTRAINT `R_17` FOREIGN KEY (`expense_type_id`) REFERENCES `expense_type` (`id`),
  CONSTRAINT `R_18` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `R_19` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.expense: ~20 rows (approximately)
/*!40000 ALTER TABLE `expense` DISABLE KEYS */;
INSERT INTO `expense` (`id`, `value`, `description`, `deleted`, `expense_type_id`, `company_id`, `vehicle_id`, `date`, `reservation_id`) VALUES
	(1, 23.10, NULL, 0, 1, 1, 2, '2018-12-18 15:03:17', NULL),
	(2, 43.10, NULL, 0, 3, 1, 2, '2018-12-18 15:03:10', NULL),
	(3, 10.30, NULL, 0, 2, 1, 2, '2018-12-18 15:03:22', NULL),
	(4, 10.20, '12', 0, 1, 1, 1, '2014-11-13 17:07:00', NULL),
	(5, 1.00, '', 0, 1, 1, 1, '2018-12-11 18:41:00', NULL),
	(6, 10.00, '', 0, 2, 1, 1, '2018-12-26 14:08:00', NULL),
	(7, 10.00, '', 0, 1, 1, 1, '2018-12-27 14:08:00', NULL),
	(8, 11.00, '', 1, 1, 1, 1, '2019-01-03 20:27:00', 9),
	(9, 11.00, '', 0, 1, 1, NULL, '2019-01-04 18:04:00', 2),
	(10, 21.00, '', 0, 2, 1, NULL, '2019-01-02 18:04:00', 2),
	(11, 12.00, '', 1, 1, 1, 1, '2019-01-03 18:06:00', 2),
	(12, 250.00, '', 0, 1, 1, 1, '2019-01-04 18:21:44', 2),
	(13, 12.00, '', 0, 3, 1, 11, '2019-01-04 18:20:22', 2),
	(14, 32.00, '', 1, 2, 1, 1, '2019-01-04 18:20:19', 2),
	(15, 322.00, '', 0, 3, 1, 1, '2019-01-04 18:23:00', 2),
	(16, 12.00, '', 0, 1, 1, 1, '2019-01-04 18:23:25', 2),
	(17, 55.00, '', 0, 1, 1, 1, '2019-01-04 18:20:13', 2),
	(18, 1.00, '', 0, 1, 1, 1, '2019-01-04 18:23:22', 2),
	(19, 5.00, '', 0, 1, 1, 1, '2019-01-03 18:23:00', 2),
	(20, 600.00, '', 1, 1, 1, 1, '2019-01-01 18:44:00', 11);
/*!40000 ALTER TABLE `expense` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.expense_type
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.location: ~9 rows (approximately)
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` (`id`, `label`, `lat`, `lng`, `company_id`, `deleted`) VALUES
	(4, 'Lokacija 22', 5, 5, 3, 0),
	(6, 'Lokacija 22', 5, 5, 3, 1),
	(8, 'SAO Kukulje', 44.994626, 17.41418329999999, 1, 0),
	(9, 'Banja Luka', 44.769743756481915, 17.19100000000003, 1, 0),
	(10, 'Ilova City', 44.90875851580919, 17.660021305370947, 1, 0),
	(11, 'Hrvacani', 44.79965139999999, 17.138052399999992, 1, 1),
	(12, 'Trn', 44.8243333, 17.171148300000027, 1, 1),
	(13, 'AP Laus', 44.77686333088414, 17.17335587260743, 1, 0),
	(14, 'Šrokedopr', 44.9778368, 16.706061599999998, 1, 1);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.logger
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
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.logger: ~195 rows (approximately)
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
	(77, 'delete', 'Obrisan je entitet: Vehicle{id=3, name=\'Suza\', description=\'1993\', deleted=1, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-064\', fuelTypeId=1, locationId=9}.', 'Vehicle', '2018-08-27 00:11:02', 1, 27, 1),
	(78, 'update', 'A&#x017E;uriran je entitet: Location{id=10, name=\'Ilova City\', latitude=17.679590702343603, longitude=17.679590702343603, companyId=1, deleted=0} na novu vrijednost: Location{id=10, name=\'Ilova City\', latitude=17.653498173046728, longitude=17.653498173046728, companyId=1, deleted=0}.', 'Location', '2018-08-27 09:50:25', 1, 27, 1),
	(79, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.21503259277347, longitude=17.21503259277347, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.21228601074222, longitude=17.21228601074222, companyId=1, deleted=0}.', 'Location', '2018-08-27 10:44:05', 1, 27, 1),
	(80, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.21228601074222, longitude=17.21228601074222, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.203359619140656, longitude=17.203359619140656, companyId=1, deleted=0}.', 'Location', '2018-08-27 10:44:16', 1, 27, 1),
	(81, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.203359619140656, longitude=17.203359619140656, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.203359619140656, longitude=17.203359619140656, companyId=1, deleted=0}.', 'Location', '2018-08-27 10:47:26', 1, 27, 1),
	(82, 'create', 'Kreiran je novi entitet: Vehicle{id=11, name=\'ads\', description=\'\', deleted=null, model=\'ads\', manufacturer=\'sd\', companyId=1, registration=\'ads\', fuelTypeId=1, locationId=9}.', 'Vehicle', '2018-12-04 15:34:07', 1, 27, 1),
	(83, 'create', 'Kreiran je novi entitet: Vehicle{id=12, name=\'dasdas\', description=\'dasd\', deleted=null, model=\'adsdasdas\', manufacturer=\'cdsdsa\', companyId=1, registration=\'dasdas\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2018-12-04 15:35:07', 1, 27, 1),
	(84, 'create', 'Kreiran je novi entitet: Vehicle{id=13, name=\'dasdas\', description=\'\', deleted=null, model=\'dadas\', manufacturer=\'saddas\', companyId=1, registration=\'das\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2018-12-04 15:37:24', 1, 27, 1),
	(85, 'create', 'Kreiran je novi entitet: Vehicle{id=14, name=\'Hej\', description=\'as\', deleted=null, model=\'Hej\', manufacturer=\'Hej\', companyId=1, registration=\'Hej\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2018-12-04 15:42:18', 1, 27, 1),
	(86, 'delete', 'Obrisan je entitet: Vehicle{id=14, name=\'Hej\', description=\'as\', deleted=1, model=\'Hej\', manufacturer=\'Hej\', companyId=1, registration=\'Hej\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2018-12-04 15:44:16', 1, 27, 1),
	(87, 'delete', 'Obrisan je entitet: Vehicle{id=12, name=\'dasdas\', description=\'dasd\', deleted=1, model=\'adsdasdas\', manufacturer=\'cdsdsa\', companyId=1, registration=\'dasdas\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2018-12-04 15:44:36', 1, 27, 1),
	(88, 'delete', 'Obrisan je entitet: Vehicle{id=13, name=\'dasdas\', description=\'\', deleted=1, model=\'dadas\', manufacturer=\'saddas\', companyId=1, registration=\'das\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2018-12-04 15:44:44', 1, 27, 1),
	(89, 'delete', 'Obrisan je entitet: Vehicle{id=11, name=\'ads\', description=\'\', deleted=1, model=\'ads\', manufacturer=\'sd\', companyId=1, registration=\'ads\', fuelTypeId=1, locationId=9}.', 'Vehicle', '2018-12-04 15:44:47', 1, 27, 1),
	(90, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.203359619140656, longitude=17.203359619140656, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.197179809570343, longitude=17.197179809570343, companyId=1, deleted=0}.', 'Location', '2018-12-06 17:30:48', 1, 27, 1),
	(91, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.197179809570343, longitude=17.197179809570343, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.20198632812503, longitude=17.20198632812503, companyId=1, deleted=0}.', 'Location', '2018-12-06 17:32:42', 1, 27, 1),
	(92, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=17.20198632812503, longitude=17.20198632812503, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=16.66365625000003, longitude=16.66365625000003, companyId=1, deleted=0}.', 'Location', '2018-12-06 17:34:38', 1, 27, 1),
	(93, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=16.66365625000003, longitude=16.66365625000003, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=16.75429345703128, longitude=16.75429345703128, companyId=1, deleted=0}.', 'Location', '2018-12-06 17:34:53', 1, 27, 1),
	(94, 'update', 'A&#x017E;uriran je entitet: Location{id=10, name=\'Ilova City\', latitude=17.653498173046728, longitude=17.653498173046728, companyId=1, deleted=0} na novu vrijednost: Location{id=10, name=\'Ilova City\', latitude=17.652811527538915, longitude=17.652811527538915, companyId=1, deleted=0}.', 'Location', '2018-12-06 17:43:41', 1, 27, 1),
	(95, 'update', 'A&#x017E;uriran je entitet: Location{id=10, name=\'Ilova City\', latitude=17.652811527538915, longitude=17.652811527538915, companyId=1, deleted=0} na novu vrijednost: Location{id=10, name=\'Ilova City\', latitude=17.660021305370947, longitude=17.660021305370947, companyId=1, deleted=0}.', 'Location', '2018-12-06 17:43:56', 1, 27, 1),
	(96, 'update', 'A&#x017E;uriran je entitet: Company{id=3, name=\'Test Kompanijaca\', deleted=0} na novu vrijednost: Company{id=3, name=\'Test Kompanijac\', deleted=0}.', 'Company', '2018-12-09 17:36:48', 1, 1, NULL),
	(97, 'create', 'Kreiran je novi entitet: Company{id=6, name=\'TEST\', deleted=0}.', 'Company', '2018-12-09 17:36:58', 1, 1, NULL),
	(98, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-231\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljno\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-231\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:17:28', 1, 27, 1),
	(99, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljno\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-231\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena.\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-231\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:18:03', 1, 27, 1),
	(100, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena.\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-231\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-231\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:19:35', 1, 27, 1),
	(101, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-231\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-064\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:28:49', 1, 27, 1),
	(102, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-064\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-065\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:31:02', 1, 27, 1),
	(103, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-065\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-066\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:35:50', 1, 27, 1),
	(104, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-066\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-064\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:35:56', 1, 27, 1),
	(105, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-064\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-065\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:36:06', 1, 27, 1),
	(106, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-065\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-064\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2018-12-17 15:37:07', 1, 27, 1),
	(107, 'create', 'Kreiran je novi entitet: Expense{id=5, value=1.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2018-12-11 18:41:00.0}.', 'Expense', '2018-12-17 18:42:06', 1, 27, 1),
	(108, 'delete', 'Obrisan je entitet: Expense{id=3, value=10.30, description=\'null\', deleted=1, expenseTypeId=2, companyId=1, vehicleId=2, date=2018-12-17 17:07:09.0}.', 'Expense', '2018-12-18 15:00:31', 1, 27, 1),
	(109, 'delete', 'Obrisan je entitet: Expense{id=1, value=23.10, description=\'null\', deleted=1, expenseTypeId=1, companyId=1, vehicleId=2, date=2018-12-17 17:06:16.0}.', 'Expense', '2018-12-18 15:01:13', 1, 27, 1),
	(110, 'delete', 'Obrisan je entitet: Expense{id=2, value=43.10, description=\'null\', deleted=1, expenseTypeId=3, companyId=1, vehicleId=2, date=2018-12-17 17:07:18.0}.', 'Expense', '2018-12-18 15:02:19', 1, 27, 1),
	(111, 'update', 'A&#x017E;uriran je entitet: Expense{id=4, value=10.40, description=\'null\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2018-12-17 17:07:04.0} na novu vrijednost: Expense{id=4, value=10.2, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2023-06-10 17:07:00.0}.', 'Expense', '2018-12-18 15:35:10', 1, 27, 1),
	(112, 'update', 'A&#x017E;uriran je entitet: Expense{id=4, value=10.20, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2023-06-10 17:07:00.0} na novu vrijednost: Expense{id=4, value=10.2, description=\'12\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2015-12-14 17:07:00.0}.', 'Expense', '2018-12-18 15:36:21', 1, 27, 1),
	(113, 'update', 'A&#x017E;uriran je entitet: Expense{id=4, value=10.20, description=\'12\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2015-12-14 17:07:00.0} na novu vrijednost: Expense{id=4, value=10.2, description=\'12\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2018-11-07 17:07:00.0}.', 'Expense', '2018-12-18 15:36:53', 1, 27, 1),
	(114, 'update', 'A&#x017E;uriran je entitet: Expense{id=4, value=10.20, description=\'12\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2018-11-07 17:07:00.0} na novu vrijednost: Expense{id=4, value=10.2, description=\'12\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2014-11-13 17:07:00.0}.', 'Expense', '2018-12-18 15:37:09', 1, 27, 1),
	(115, 'create', 'Kreiran je novi entitet: Expense{id=6, value=10.00, description=\'\', deleted=0, expenseTypeId=2, companyId=1, vehicleId=1, date=2018-12-26 14:08:00.0}.', 'Expense', '2018-12-27 14:08:52', 1, 27, 1),
	(116, 'create', 'Kreiran je novi entitet: Expense{id=7, value=10.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2018-12-26 14:08:00.0}.', 'Expense', '2018-12-27 14:14:53', 1, 27, 1),
	(117, 'update', 'A&#x017E;uriran je entitet: Expense{id=7, value=10.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2018-12-26 14:08:00.0} na novu vrijednost: Expense{id=7, value=10, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2018-12-27 14:08:00.0}.', 'Expense', '2018-12-27 14:18:18', 1, 27, 1),
	(118, 'create', 'Kreiran je novi entitet: Reservation{id=4, startDate=2019-01-04 00:50:00.0, endDate=2019-01-05 00:55:00.0, startMileage=null, endMileage=null, direction=\'bla\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-03 20:17:47', 1, 27, 1),
	(123, 'create', 'Kreiran je novi entitet: Reservation{id=9, startDate=2019-01-10 01:30:00.0, endDate=2019-01-10 18:35:00.0, startMileage=null, endMileage=null, direction=\'SS\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-03 20:28:49', 1, 27, 1),
	(124, 'create', 'Kreiran je novi entitet: Expense{id=8, value=11.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-03 20:27:00.0}.', 'Expense', '2019-01-03 20:28:49', 1, 27, 1),
	(125, 'create', 'Kreiran je novi entitet: Reservation{id=10, startDate=2019-01-07 02:50:00.0, endDate=2019-01-05 14:55:00.0, startMileage=null, endMileage=null, direction=\'Povod\', deleted=0, companyId=1, vehicleId=1, userId=3}.', 'Reservation', '2019-01-03 21:24:20', 1, 3, 1),
	(126, 'create', 'Kreiran je novi entitet: Reservation{id=11, startDate=2019-01-05 10:20:00.0, endDate=2019-01-05 18:25:00.0, startMileage=null, endMileage=null, direction=\'Test\', deleted=0, companyId=1, vehicleId=1, userId=3}.', 'Reservation', '2019-01-03 21:24:52', 1, 3, 1),
	(127, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beograd\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradic\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 17:46:29', 1, 27, 1),
	(128, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradic\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradic\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 17:48:24', 1, 27, 1),
	(129, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradic\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 17:48:35', 1, 27, 1),
	(130, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 17:48:43', 1, 27, 1),
	(131, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-04 22:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 17:48:59', 1, 27, 1),
	(132, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 17:52:51', 1, 27, 1),
	(133, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=1, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 17:53:10', 1, 27, 1),
	(134, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=11, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 17:53:17', 1, 27, 1),
	(135, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:05:52', 1, 27, 1),
	(136, 'create', 'Kreiran je novi entitet: Expense{id=9, value=11.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=null, date=2019-01-04 18:04:00.0}.', 'Expense', '2019-01-04 18:05:52', 1, 27, 1),
	(137, 'create', 'Kreiran je novi entitet: Expense{id=10, value=21.00, description=\'\', deleted=0, expenseTypeId=2, companyId=1, vehicleId=null, date=2019-01-02 18:04:00.0}.', 'Expense', '2019-01-04 18:05:52', 1, 27, 1),
	(138, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:06:51', 1, 27, 1),
	(139, 'create', 'Kreiran je novi entitet: Expense{id=11, value=12.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-03 18:06:00.0}.', 'Expense', '2019-01-04 18:06:51', 1, 27, 1),
	(140, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:07:29', 1, 27, 1),
	(141, 'create', 'Kreiran je novi entitet: Expense{id=12, value=23.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-04 18:06:00.0}.', 'Expense', '2019-01-04 18:07:29', 1, 27, 1),
	(142, 'create', 'Kreiran je novi entitet: Expense{id=13, value=123.00, description=\'\', deleted=0, expenseTypeId=3, companyId=1, vehicleId=1, date=2019-01-02 18:06:00.0}.', 'Expense', '2019-01-04 18:07:29', 1, 27, 1),
	(143, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:08:00', 1, 27, 1),
	(144, 'update', 'A&#x017E;uriran je entitet: Expense{id=12, value=23.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-04 18:06:00.0} na novu vrijednost: Expense{id=12, value=25, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-04 18:06:00.0}.', 'Expense', '2019-01-04 18:08:00', 1, 27, 1),
	(145, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:09:00', 1, 27, 1),
	(146, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:15:15', 1, 27, 1),
	(147, 'delete', 'Obrisan je entitet: Expense{id=11, value=12.00, description=\'\', deleted=1, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-03 18:06:00.0}.', 'Expense', '2019-01-04 18:15:15', 1, 27, 1),
	(148, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:15:25', 1, 27, 1),
	(149, 'update', 'A&#x017E;uriran je entitet: Expense{id=12, value=25.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-04 18:06:00.0} na novu vrijednost: Expense{id=12, value=250, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=null, date=2019-01-04 18:06:00.0}.', 'Expense', '2019-01-04 18:15:25', 1, 27, 1),
	(150, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:15:29', 1, 27, 1),
	(151, 'update', 'A&#x017E;uriran je entitet: Expense{id=12, value=250.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=null, date=2019-01-04 18:06:00.0} na novu vrijednost: Expense{id=12, value=250, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=null, date=2019-01-04 18:06:00.0}.', 'Expense', '2019-01-04 18:15:29', 1, 27, 1),
	(152, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:15:46', 1, 27, 1),
	(153, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:15:53', 1, 27, 1),
	(154, 'create', 'Kreiran je novi entitet: Expense{id=14, value=32.00, description=\'\', deleted=0, expenseTypeId=2, companyId=1, vehicleId=null, date=2019-01-02 18:14:00.0}.', 'Expense', '2019-01-04 18:15:53', 1, 27, 1),
	(155, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:15:59', 1, 27, 1),
	(156, 'create', 'Kreiran je novi entitet: Expense{id=15, value=32.00, description=\'\', deleted=0, expenseTypeId=2, companyId=1, vehicleId=null, date=2019-01-02 18:14:00.0}.', 'Expense', '2019-01-04 18:15:59', 1, 27, 1),
	(157, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:17:44', 1, 27, 1),
	(158, 'create', 'Kreiran je novi entitet: Expense{id=16, value=12.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=null, date=2019-01-03 18:17:00.0}.', 'Expense', '2019-01-04 18:17:44', 1, 27, 1),
	(159, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:18:02', 1, 27, 1),
	(160, 'create', 'Kreiran je novi entitet: Expense{id=17, value=55.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=null, date=2019-01-03 18:17:00.0}.', 'Expense', '2019-01-04 18:18:02', 1, 27, 1),
	(161, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:18:20', 1, 27, 1),
	(162, 'update', 'A&#x017E;uriran je entitet: Expense{id=13, value=123.00, description=\'\', deleted=0, expenseTypeId=3, companyId=1, vehicleId=1, date=2019-01-02 18:06:00.0} na novu vrijednost: Expense{id=13, value=12, description=\'\', deleted=0, expenseTypeId=3, companyId=1, vehicleId=null, date=2019-01-02 18:06:00.0}.', 'Expense', '2019-01-04 18:18:20', 1, 27, 1),
	(163, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:21:00', 1, 27, 1),
	(164, 'update', 'A&#x017E;uriran je entitet: Expense{id=15, value=32.00, description=\'\', deleted=0, expenseTypeId=2, companyId=1, vehicleId=1, date=2019-01-04 18:20:17.0} na novu vrijednost: Expense{id=15, value=320, description=\'\', deleted=0, expenseTypeId=3, companyId=1, vehicleId=2, date=2019-01-04 18:20:00.0}.', 'Expense', '2019-01-04 18:21:00', 1, 27, 1),
	(165, 'create', 'Kreiran je novi entitet: Expense{id=18, value=1.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=2, date=2019-01-01 18:20:00.0}.', 'Expense', '2019-01-04 18:21:00', 1, 27, 1),
	(166, 'delete', 'Obrisan je entitet: Expense{id=16, value=12.00, description=\'\', deleted=1, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-04 18:20:10.0}.', 'Expense', '2019-01-04 18:21:00', 1, 27, 1),
	(167, 'update', 'A&#x017E;uriran je entitet: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27} na novu vrijednost: Reservation{id=2, startDate=2019-01-02 21:14:00.0, endDate=2019-01-05 09:00:00.0, startMileage=10, endMileage=60, direction=\'Banjaluka-Beogradica\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:24:06', 1, 27, 1),
	(168, 'update', 'A&#x017E;uriran je entitet: Expense{id=15, value=320.00, description=\'\', deleted=0, expenseTypeId=3, companyId=1, vehicleId=1, date=2019-01-04 18:23:18.0} na novu vrijednost: Expense{id=15, value=322, description=\'\', deleted=0, expenseTypeId=3, companyId=1, vehicleId=1, date=2019-01-04 18:23:00.0}.', 'Expense', '2019-01-04 18:24:06', 1, 27, 1),
	(169, 'create', 'Kreiran je novi entitet: Expense{id=19, value=5.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-03 18:23:00.0}.', 'Expense', '2019-01-04 18:24:06', 1, 27, 1),
	(170, 'delete', 'Obrisan je entitet: Expense{id=14, value=32.00, description=\'\', deleted=1, expenseTypeId=2, companyId=1, vehicleId=1, date=2019-01-04 18:20:19.0}.', 'Expense', '2019-01-04 18:24:06', 1, 27, 1),
	(171, 'delete', 'Obrisan je entitet: Expense{id=8, value=11.00, description=\'\', deleted=1, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-03 20:27:00.0}.', 'Expense', '2019-01-04 18:44:50', 1, 27, 1),
	(172, 'delete', 'Obrisan je entitet: Reservation{id=9, startDate=2019-01-10 01:30:00.0, endDate=2019-01-10 18:35:00.0, startMileage=null, endMileage=null, direction=\'SS\', deleted=1, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:44:50', 1, 27, 1),
	(173, 'update', 'A&#x017E;uriran je entitet: Reservation{id=11, startDate=2019-01-05 10:20:00.0, endDate=2019-01-05 18:25:00.0, startMileage=null, endMileage=null, direction=\'Test\', deleted=0, companyId=1, vehicleId=1, userId=3} na novu vrijednost: Reservation{id=11, startDate=2019-01-05 10:20:00.0, endDate=2019-01-05 18:25:00.0, startMileage=null, endMileage=null, direction=\'Test\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:45:21', 1, 27, 1),
	(174, 'create', 'Kreiran je novi entitet: Expense{id=20, value=600.00, description=\'\', deleted=0, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-01 18:44:00.0}.', 'Expense', '2019-01-04 18:45:21', 1, 27, 1),
	(175, 'delete', 'Obrisan je entitet: Expense{id=20, value=600.00, description=\'\', deleted=1, expenseTypeId=1, companyId=1, vehicleId=1, date=2019-01-01 18:44:00.0}.', 'Expense', '2019-01-04 18:45:27', 1, 27, 1),
	(176, 'delete', 'Obrisan je entitet: Reservation{id=11, startDate=2019-01-05 10:20:00.0, endDate=2019-01-05 18:25:00.0, startMileage=null, endMileage=null, direction=\'Test\', deleted=1, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 18:45:27', 1, 27, 1),
	(177, 'create', 'Kreiran je novi entitet: Reservation{id=12, startDate=2019-01-06 08:35:00.0, endDate=2019-01-07 08:40:00.0, startMileage=null, endMileage=null, direction=\'Test\', deleted=0, companyId=1, vehicleId=1, userId=39}.', 'Reservation', '2019-01-04 19:26:18', 1, 39, 1),
	(178, 'create', 'Kreiran je novi entitet: Reservation{id=13, startDate=2019-01-09 14:00:00.0, endDate=2019-01-10 13:05:00.0, startMileage=null, endMileage=null, direction=\'Test\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 19:44:31', 1, 27, 1),
	(179, 'create', 'Kreiran je novi entitet: Reservation{id=14, startDate=2019-01-10 19:40:00.0, endDate=2019-01-11 01:45:00.0, startMileage=null, endMileage=null, direction=\'Test2\', deleted=0, companyId=1, vehicleId=1, userId=27}.', 'Reservation', '2019-01-04 19:46:20', 1, 27, 1),
	(180, 'update', 'A&#x017E;uriran je entitet: User{id=27, username=\'admin\', firstName=\'Djordje\', lastName=\'Turjacanin I\', registrationDate=2018-08-26 20:57:16.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=1, companyId=1, notificationTypeId=3, locationId=8} na novu vrijednost: User{id=27, username=\'admin\', firstName=\'Djordje\', lastName=\'Turjacanin I\', registrationDate=2018-08-26 20:57:16.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=1, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2019-01-04 21:16:07', 1, 27, 1),
	(181, 'update', 'A&#x017E;uriran je entitet: User{id=27, username=\'admin\', firstName=\'Djordje\', lastName=\'Turjacanin I\', registrationDate=2018-08-26 20:57:16.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=1, companyId=1, notificationTypeId=1, locationId=8} na novu vrijednost: User{id=27, username=\'admin\', firstName=\'Djordje\', lastName=\'Turjacanin I\', registrationDate=2018-08-26 20:57:16.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=1, companyId=1, notificationTypeId=1, locationId=8}.', 'User', '2019-01-04 21:16:46', 1, 27, 1),
	(182, 'update', 'A&#x017E;uriran je entitet: User{id=27, username=\'admin\', firstName=\'Djordje\', lastName=\'Turjacanin II\', registrationDate=2018-08-26 20:57:16.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=1, companyId=1, notificationTypeId=2, locationId=8} na novu vrijednost: User{id=27, username=\'admin\', firstName=\'Djordje\', lastName=\'Turjacanin II\', registrationDate=2018-08-26 20:57:16.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=1, companyId=1, notificationTypeId=2, locationId=8}.', 'User', '2019-01-04 21:17:34', 1, 27, 1),
	(183, 'update', 'A&#x017E;uriran je entitet: User{id=27, username=\'admin\', firstName=\'Djordje\', lastName=\'Turjacanin III\', registrationDate=2018-08-26 20:57:16.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=1, companyId=1, notificationTypeId=2, locationId=8} na novu vrijednost: User{id=27, username=\'admin\', firstName=\'Djordje\', lastName=\'Turjacanin III\', registrationDate=2018-08-26 20:57:16.0, email=\'turjacanin.djordje@gmail.com\', roleId=2, statusId=1, companyId=1, notificationTypeId=2, locationId=8}.', 'User', '2019-01-04 21:44:45', 1, 27, 1),
	(184, 'update', 'A&#x017E;uriran je entitet: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin II|\', registrationDate=2018-08-26 20:57:16.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=8} na novu vrijednost: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin II|\', registrationDate=2018-08-26 20:57:16.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=8}.', 'User', '2019-01-04 21:49:10', 1, 27, 1),
	(185, 'update', 'A&#x017E;uriran je entitet: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin VI\', registrationDate=2018-08-26 20:57:16.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=9} na novu vrijednost: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin VI\', registrationDate=2018-08-26 20:57:16.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=9}.', 'User', '2019-01-04 21:49:20', 1, 27, 1),
	(186, 'update', 'A&#x017E;uriran je entitet: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin VII\', registrationDate=2018-08-26 20:57:16.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=9} na novu vrijednost: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin VII\', registrationDate=2018-08-26 20:57:16.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=9}.', 'User', '2019-01-04 21:50:01', 1, 1, NULL),
	(187, 'update', 'A&#x017E;uriran je entitet: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin A\', registrationDate=2018-08-26 20:57:16.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=9} na novu vrijednost: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin A\', registrationDate=2018-08-26 20:57:16.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=9}.', 'User', '2019-01-04 21:50:14', 1, 1, NULL),
	(188, 'update', 'A&#x017E;uriran je entitet: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin X\', registrationDate=2019-01-04 21:55:43.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=9} na novu vrijednost: User{id=39, username=\'user\', firstName=\'Djordje\', lastName=\'Turjacanin X\', registrationDate=2019-01-04 21:55:43.0, email=\'etf.ip.dzoks@gmail.com\', roleId=3, statusId=1, companyId=1, notificationTypeId=3, locationId=9}.', 'User', '2019-01-04 21:56:11', 1, 27, 1),
	(189, 'update', 'A&#x017E;uriran je entitet: Location{id=9, name=\'Banja Luka\', latitude=16.75429345703128, longitude=16.75429345703128, companyId=1, deleted=0} na novu vrijednost: Location{id=9, name=\'Banja Luka\', latitude=17.19100000000003, longitude=17.19100000000003, companyId=1, deleted=0}.', 'Location', '2019-01-08 16:44:31', 1, 27, 1),
	(190, 'create', 'Kreiran je novi entitet: Location{id=13, name=\'HRvacani\', latitude=17.461918647265634, longitude=17.461918647265634, companyId=1, deleted=0}.', 'Location', '2019-01-08 16:58:00', 1, 27, 1),
	(191, 'update', 'A&#x017E;uriran je entitet: Location{id=13, name=\'HRvacani\', latitude=17.461918647265634, longitude=17.461918647265634, companyId=1, deleted=0} na novu vrijednost: Location{id=13, name=\'HRvacani\', latitude=17.437886054492196, longitude=17.437886054492196, companyId=1, deleted=0}.', 'Location', '2019-01-08 17:00:55', 1, 27, 1),
	(192, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=2, description=\'\', deleted=0, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-064\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=2, description=\'\', deleted=0, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-066\', fuelTypeId=1, locationId=10}.', 'Vehicle', '2019-01-08 17:02:06', 1, 27, 1),
	(193, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=2, description=\'\', deleted=0, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-066\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=2, description=\'\', deleted=0, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-067\', fuelTypeId=1, locationId=13}.', 'Vehicle', '2019-01-08 17:02:28', 1, 27, 1),
	(194, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=2, description=\'\', deleted=0, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-067\', fuelTypeId=1, locationId=13} na novu vrijednost: Vehicle{id=2, description=\'\', deleted=0, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-067\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2019-01-08 17:28:43', 1, 27, 1),
	(195, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=2, description=\'\', deleted=0, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-067\', fuelTypeId=1, locationId=8} na novu vrijednost: Vehicle{id=2, description=\'\', deleted=0, model=\'Kadet\', manufacturer=\'Opel\', companyId=1, registration=\'825-J-067\', fuelTypeId=1, locationId=13}.', 'Vehicle', '2019-01-08 17:29:05', 1, 27, 1),
	(196, 'update', 'A&#x017E;uriran je entitet: Location{id=13, name=\'HRvacani\', latitude=17.437886054492196, longitude=17.437886054492196, companyId=1, deleted=0} na novu vrijednost: Location{id=13, name=\'HRvacani\', latitude=17.43857270000001, longitude=17.43857270000001, companyId=1, deleted=0}.', 'Location', '2019-01-08 17:31:24', 1, 27, 1),
	(197, 'update', 'A&#x017E;uriran je entitet: Location{id=8, name=\'Majina kuća\', latitude=17.41418329999999, longitude=17.41418329999999, companyId=1, deleted=0} na novu vrijednost: Location{id=8, name=\'SAO Kukulje\', latitude=17.41418329999999, longitude=17.41418329999999, companyId=1, deleted=0}.', 'Location', '2019-01-08 17:39:43', 1, 27, 1),
	(198, 'update', 'A&#x017E;uriran je entitet: Location{id=13, name=\'HRvacani\', latitude=17.43857270000001, longitude=17.43857270000001, companyId=1, deleted=0} na novu vrijednost: Location{id=13, name=\'AP Laus\', latitude=17.17335587260743, longitude=17.17335587260743, companyId=1, deleted=0}.', 'Location', '2019-01-08 17:41:03', 1, 27, 1),
	(199, 'update', 'A&#x017E;uriran je entitet: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-064\', fuelTypeId=1, locationId=10} na novu vrijednost: Vehicle{id=1, description=\'Vozila ga baba iz njemacke. Povoljna cijena. Hello\', deleted=0, model=\'Golf\', manufacturer=\'VW\', companyId=1, registration=\'823-J-064\', fuelTypeId=1, locationId=8}.', 'Vehicle', '2019-01-08 18:10:49', 1, 27, 1),
	(200, 'create', 'Kreiran je novi entitet: Location{id=14, name=\'Šrokedopr\', latitude=16.706061599999998, longitude=16.706061599999998, companyId=1, deleted=0}.', 'Location', '2019-01-08 18:16:54', 1, 27, 1),
	(201, 'delete', 'Obrisan je entitet: Location{id=14, name=\'Šrokedopr\', latitude=16.706061599999998, longitude=16.706061599999998, companyId=1, deleted=1}.', 'Location', '2019-01-08 18:16:59', 1, 27, 1);
/*!40000 ALTER TABLE `logger` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.notification_type
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
CREATE TABLE IF NOT EXISTS `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_mileage` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.reservation: ~7 rows (approximately)
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` (`id`, `start_date`, `end_date`, `start_mileage`, `end_mileage`, `direction`, `deleted`, `company_id`, `vehicle_id`, `user_id`) VALUES
	(1, '2018-12-27 18:37:06', '2018-12-29 18:37:06', 1, 11, 'Banjaluka-Beograd', 0, 1, 1, 27),
	(2, '2019-01-02 21:14:00', '2019-01-05 09:00:00', 10, 60, 'Banjaluka-Beogradica', 0, 1, 1, 27),
	(9, '2019-01-10 01:30:00', '2019-01-10 18:35:00', NULL, NULL, 'SS', 1, 1, 1, 27),
	(11, '2019-01-05 10:20:00', '2019-01-05 18:25:00', NULL, NULL, 'Test', 1, 1, 1, 27),
	(12, '2019-01-06 08:35:00', '2019-01-07 08:40:00', NULL, NULL, 'Test', 0, 1, 1, 39),
	(13, '2019-01-09 14:00:00', '2019-01-10 13:05:00', NULL, NULL, 'Test', 0, 1, 1, 27),
	(14, '2019-01-10 19:40:00', '2019-01-11 01:45:00', NULL, NULL, 'Test2', 0, 1, 1, 27);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.role
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.user: ~4 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `first_name`, `last_name`, `registration_date`, `token`, `email`, `role_id`, `status_id`, `company_id`, `notification_type_id`, `location_id`) VALUES
	(1, 'admin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC', 'Djordje', 'Turjačanin', '2018-08-16 14:46:44', NULL, 'turjacanin.djordje@gmail.com', 1, 1, NULL, 1, NULL),
	(3, 'putin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC', 'Vladimir', 'Putin', '2018-08-26 20:57:16', NULL, 'president1@mail.ru', 2, 1, 1, 1, 10),
	(27, 'admin', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', 'Djordje', 'Turjacanin III', '2018-08-26 20:57:16', NULL, 'turjacanin.djordje@gmail.com', 2, 1, 1, 2, 8),
	(39, 'user', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec', 'Djordje', 'Turjacanin X', '2019-01-04 21:55:43', NULL, 'etf.ip.dzoks@gmail.com', 3, 1, 1, 3, 9);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table vehicle_reservation.vehicle
CREATE TABLE IF NOT EXISTS `vehicle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer` varchar(64) NOT NULL,
  `model` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vehicle_reservation.vehicle: ~6 rows (approximately)
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` (`id`, `manufacturer`, `model`, `description`, `deleted`, `company_id`, `registration`, `location_id`, `fuel_type_id`) VALUES
	(1, 'VW', 'Golf', 'Vozila ga baba iz njemacke. Povoljna cijena. Hello', 0, 1, '823-J-064', 8, 1),
	(2, 'Opel', 'Kadet', '', 0, 1, '825-J-067', 13, 1),
	(11, 'sd', 'ads', '', 1, 1, 'ads', 9, 1),
	(12, 'cdsdsa', 'adsdasdas', 'dasd', 1, 1, 'dasdas', 8, 1),
	(13, 'saddas', 'dadas', '', 1, 1, 'das', 8, 1),
	(14, 'Hej', 'Hej', 'as', 1, 1, 'Hej', 8, 1);
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

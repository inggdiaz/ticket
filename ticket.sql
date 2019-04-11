-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5332
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for ticket
CREATE DATABASE IF NOT EXISTS `ticket` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ticket`;

-- Dumping structure for table ticket.employees
CREATE TABLE IF NOT EXISTS `employees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_id` int(11) NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ticket.employees: ~4 rows (approximately)
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` (`id`, `first_name`, `last_name`, `status_id`, `password`, `created_at`, `updated_at`, `email`) VALUES
	(1, 'Geronimo', 'Diaz', 2, 'e10adc3949ba59abbe56e057f20f883e', '2019-04-09 02:57:40', '2019-04-10 01:33:41', 'ing.geronimodiaz@gmail.com'),
	(2, 'Daniel', 'Nuñez', 1, 'e10adc3949ba59abbe56e057f20f883e', '2019-04-09 02:57:40', '2019-04-10 01:33:31', 'daniel@gmail.com'),
	(3, 'Efrain', 'Paulino', 1, 'e10adc3949ba59abbe56e057f20f883e', '2019-04-09 02:57:40', '2019-04-09 02:57:40', 'efrain@gmail.com'),
	(4, 'Ana Judit', 'Diaz', 1, 'e10adc3949ba59abbe56e057f20f883e', '2019-04-09 02:57:40', '2019-04-10 01:33:17', 'ana@gmail.com');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;

-- Dumping structure for table ticket.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ticket.migrations: ~7 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_04_06_210636_create_employees_table', 1),
	(4, '2019_04_07_002837_create_tickets_table', 1),
	(5, '2019_04_07_004714_create_statuses_table', 1),
	(6, '2019_04_07_004750_create_ticket_employees_table', 2),
	(7, '2019_04_07_004836_create_ticket_times_table', 2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table ticket.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ticket.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table ticket.statuses
CREATE TABLE IF NOT EXISTS `statuses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ticket.statuses: ~2 rows (approximately)
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;
INSERT INTO `statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Open', '2019-04-09 02:57:40', '2019-04-09 02:57:40'),
	(2, 'Complete', '2019-04-09 02:57:40', '2019-04-09 02:57:40');
/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;

-- Dumping structure for table ticket.tickets
CREATE TABLE IF NOT EXISTS `tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ticket.tickets: ~2 rows (approximately)
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` (`id`, `subject`, `description`, `date`, `status_id`, `created_at`, `updated_at`) VALUES
	(2, 'Sub', 'test', '2019-04-09', 1, '2019-04-10 03:09:46', '2019-04-10 03:09:46');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;

-- Dumping structure for table ticket.ticket_employees
CREATE TABLE IF NOT EXISTS `ticket_employees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ticket.ticket_employees: ~6 rows (approximately)
/*!40000 ALTER TABLE `ticket_employees` DISABLE KEYS */;
INSERT INTO `ticket_employees` (`id`, `ticket_id`, `created_at`, `updated_at`, `employee_id`) VALUES
	(6, 4, '2019-04-11 02:21:40', '2019-04-11 02:21:40', 2),
	(8, 4, '2019-04-11 10:29:15', '2019-04-11 10:29:15', 3),
	(11, 2, '2019-04-11 16:42:36', '2019-04-11 16:42:36', 1),
	(12, 2, '2019-04-11 16:42:36', '2019-04-11 16:42:36', 2),
	(13, 2, '2019-04-11 16:42:36', '2019-04-11 16:42:36', 3);
/*!40000 ALTER TABLE `ticket_employees` ENABLE KEYS */;

-- Dumping structure for table ticket.ticket_times
CREATE TABLE IF NOT EXISTS `ticket_times` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from` timestamp NOT NULL,
  `to` timestamp NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ticket.ticket_times: ~3 rows (approximately)
/*!40000 ALTER TABLE `ticket_times` DISABLE KEYS */;
INSERT INTO `ticket_times` (`id`, `from`, `to`, `note`, `created_at`, `updated_at`, `ticket_id`, `employee_id`) VALUES
	(3, '2019-04-11 04:03:57', '2019-04-11 04:03:57', 'Note 2', '2019-04-11 04:04:22', '2019-04-11 04:04:22', 2, 2),
	(6, '2019-04-12 01:00:00', '2019-04-11 16:34:41', 'test', '2019-04-11 16:35:02', '2019-04-11 16:35:02', 4, 3);
/*!40000 ALTER TABLE `ticket_times` ENABLE KEYS */;

-- Dumping structure for table ticket.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table ticket.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

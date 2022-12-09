--
-- cat create_mysql_symfony_session_test_db.sql | sudo mysql
--
DROP USER IF EXISTS 'symfony_session_test_db'@'localhost';
DROP DATABASE IF EXISTS `symfony_session_test_db`;
--
CREATE DATABASE `symfony_session_test_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER 'symfony_session_test_db'@'localhost' IDENTIFIED BY 'symfony_session_test_db';
GRANT ALL PRIVILEGES ON `symfony_session_test_db`.* TO 'symfony_session_test_db'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
--
USE `symfony_session_test_db`;
---
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `sess_id` varbinary(128) NOT NULL,
  `sess_data` blob NOT NULL,
  `sess_lifetime` int(10) unsigned NOT NULL,
  `sess_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sess_id`),
  KEY `EXPIRY` (`sess_lifetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
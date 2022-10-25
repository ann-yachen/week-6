-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: website
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `follower_count` int unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'test2','test','test',0,'2022-10-17 20:28:04'),(2,'Ann','ann','12345678',0,'2022-10-17 20:29:32'),(3,'Bob','bob','87654321',0,'2022-10-17 20:37:22'),(4,'Cathy','cathy','14725836',0,'2022-10-17 20:45:54'),(5,'Derek','derek','63258741',0,'2022-10-17 20:46:45'),(6,'Edmond','edmond','00000000',0,'2022-10-24 20:40:14'),(7,'Frank','frank','14789325',0,'2022-10-24 23:08:52'),(8,'Grey','grey','523698741',0,'2022-10-24 23:27:45'),(9,'Hank','hank','369874125',0,'2022-10-25 00:45:28');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `content` varchar(255) NOT NULL,
  `like_count` int unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,1,'test',0,'2022-10-17 22:20:31'),(2,2,'Hello!',0,'2022-10-17 22:21:31'),(5,2,'Is anyone here?',0,'2022-10-18 20:57:52'),(6,3,'Hi, i\'m here!',0,'2022-10-18 20:59:25'),(7,5,'Hello.',0,'2022-10-18 21:00:16'),(8,4,'I\'m here, too.',0,'2022-10-18 21:02:09'),(9,1,'test test',0,'2022-10-18 21:02:53'),(12,2,'This is test from Ann!',0,'2022-10-25 20:25:21'),(13,3,'Bob is testing.',0,'2022-10-25 20:28:26'),(14,2,'omg it\'s awesome!',0,'2022-10-25 20:46:51'),(15,5,'You really did a great job:)',0,'2022-10-25 20:48:11'),(16,6,'Nice to meet you, Ann.',0,'2022-10-25 20:54:07'),(17,2,'Wow changed cursor setting is successful!',0,'2022-10-25 22:08:53'),(18,2,'Opps... it should be \"was\" :P',0,'2022-10-25 22:09:40');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_like`
--

DROP TABLE IF EXISTS `message_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `message_id` bigint NOT NULL,
  `like_member_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `message_id` (`message_id`),
  CONSTRAINT `message_like_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `message` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_like`
--

LOCK TABLES `message_like` WRITE;
/*!40000 ALTER TABLE `message_like` DISABLE KEYS */;
INSERT INTO `message_like` VALUES (1,2,3),(2,2,4),(3,2,5),(5,5,3);
/*!40000 ALTER TABLE `message_like` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-25 22:11:45

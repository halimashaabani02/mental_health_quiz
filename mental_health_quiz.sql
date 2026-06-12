-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 12, 2026 at 09:16 AM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mental_health_quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
CREATE TABLE IF NOT EXISTS `answers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_id` int NOT NULL,
  `answer_text` varchar(255) NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`id`, `question_id`, `answer_text`, `is_correct`) VALUES
(1, 1, 'Kabisa (Sipati shida)', 1),
(2, 1, 'Siku chache tu', 0),
(3, 1, 'Zaidi ya nusu ya siku hizo', 0),
(4, 1, 'Karibu kila siku', 0),
(5, 2, 'Hapana, najisikia mwenye amani', 1),
(6, 2, 'Mara chache sana', 0),
(7, 2, 'Mara kwa mara', 0),
(8, 2, 'Kila wakati', 0),
(9, 3, 'Hapana, bado nayapenda sana', 1),
(10, 3, 'Kiasi kidogo', 0),
(11, 3, 'Sana, sina hamu tena', 0),
(12, 3, 'Sijishughulishi kabisa na kitu chochote', 0);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE IF NOT EXISTS `questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question_text`, `created_at`) VALUES
(1, 'Je, ni kwa kiasi gani umekuwa ukipata shida ya kukosa usingizi au kulala kupita kiasi katika wiki mbili zilizopita?', '2026-06-10 10:53:11'),
(2, 'Je, unajisikia mwenye hasira, wasiwasi, au upo njiani kulia bila sababu maalumu?', '2026-06-10 10:53:11'),
(3, 'Je, umepoteza hamu ya kufanya mambo ambayo hapo awali ulikuwa ukiyapenda (kama michezo au burudani)?', '2026-06-10 10:53:11');

-- --------------------------------------------------------

--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
CREATE TABLE IF NOT EXISTS `submissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `score` int NOT NULL,
  `feedback` varchar(255) NOT NULL,
  `submitted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `submissions`
--

INSERT INTO `submissions` (`id`, `user_id`, `score`, `feedback`, `submitted_at`) VALUES
(1, 2, 100, 'Hongera sana! Unaonyesha kuwa na afya imara ya akili. Endelea kujitunza!', '2026-06-10 10:54:16');

-- --------------------------------------------------------

--
-- Table structure for table `submission_details`
--

DROP TABLE IF EXISTS `submission_details`;
CREATE TABLE IF NOT EXISTS `submission_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `submission_id` int NOT NULL,
  `question_id` int NOT NULL,
  `selected_answer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `submission_id` (`submission_id`),
  KEY `question_id` (`question_id`),
  KEY `selected_answer_id` (`selected_answer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `submission_details`
--

INSERT INTO `submission_details` (`id`, `submission_id`, `question_id`, `selected_answer_id`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 5),
(3, 1, 3, 9);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'admin_kist', 'admin@kist.ac.tz', 'admin123', 'admin', '2026-06-10 10:48:07'),
(2, 'juma_ally', 'juma@gmail.com', 'user123', 'user', '2026-06-10 10:48:07'),
(7, 'abubakar', 'abubakar@example.com', '$2y$10$jRW2R4scIXbgCv7UNWQDsO8VxDWL6JWokZ66YrQG3OH9uWJvora0u', 'admin', '2026-06-12 08:37:34'),
(8, 'halima', 'halima@example.com', '$2y$10$M0UVZu05Xh90h97TPjR8neu/KWNHZH7dnZxTH87aw8vyKadZ74lc2', 'user', '2026-06-12 08:38:41');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `submissions`
--
ALTER TABLE `submissions`
  ADD CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `submission_details`
--
ALTER TABLE `submission_details`
  ADD CONSTRAINT `submission_details_ibfk_1` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `submission_details_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  ADD CONSTRAINT `submission_details_ibfk_3` FOREIGN KEY (`selected_answer_id`) REFERENCES `answers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

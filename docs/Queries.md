### DATABASE YANGU NI : mental_health_quiz

Zifuatazo ni queries kwa ajili ya tables:
```
-- 1. Kutengeneza Table ya Watumiaji (Users)
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(100) NOT NULL,
  `email` VARCHAR(150) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('admin', 'user') NOT NULL DEFAULT 'user',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Kutengeneza Table ya Maswali (Questions)
CREATE TABLE IF NOT EXISTS `questions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `question_text` TEXT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Kutengeneza Table ya Majibu/Machaguo (Answers)
CREATE TABLE IF NOT EXISTS `answers` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `question_id` INT NOT NULL,
  `answer_text` VARCHAR(255) NOT NULL,
  `is_correct` TINYINT(1) NOT NULL DEFAULT 0,
  FOREIGN KEY (`question_id`) REFERENCES `questions`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Kutengeneza Table ya Mizunguko ya Quiz (Submissions)
CREATE TABLE IF NOT EXISTS `submissions` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `score` INT NOT NULL,
  `feedback` VARCHAR(255) NOT NULL,
  `submitted_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Kutengeneza Table ya Uchambuzi wa Majibu (Submission Details)
CREATE TABLE IF NOT EXISTS `submission_details` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `submission_id` INT NOT NULL,
  `question_id` INT NOT NULL,
  `selected_answer_id` INT NOT NULL,
  FOREIGN KEY (`submission_id`) REFERENCES `submissions`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`question_id`) REFERENCES `questions`(`id`),
  FOREIGN KEY (`selected_answer_id`) REFERENCES `answers`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```



Zifuatazo ni queries za kuingiza data:
```
INSERT INTO `users` (`username`, `email`, `password`, `role`) VALUES
('admin_kist', 'admin@kist.ac.tz', 'admin123', 'admin'),
('juma_ally', 'juma@gmail.com', 'user123', 'user');



INSERT INTO `questions` (`id`, `question_text`) VALUES
(1, 'Je, ni kwa kiasi gani umekuwa ukipata shida ya kukosa usingizi au kulala kupita kiasi katika wiki mbili zilizopita?'),
(2, 'Je, unajisikia mwenye hasira, wasiwasi, au upo njiani kulia bila sababu maalumu?'),
(3, 'Je, umepoteza hamu ya kufanya mambo ambayo hapo awali ulikuwa ukiyapenda (kama michezo au burudani)?');



-- Majibu ya Swali la 1 (id = 1)
INSERT INTO `answers` (`question_id`, `answer_text`, `is_correct`) VALUES
(1, 'Kabisa (Sipati shida)', 1),
(1, 'Siku chache tu', 0),
(1, 'Zaidi ya nusu ya siku hizo', 0),
(1, 'Karibu kila siku', 0);

-- Majibu ya Swali la 2 (id = 2)
INSERT INTO `answers` (`question_id`, `answer_text`, `is_correct`) VALUES
(2, 'Hapana, najisikia mwenye amani', 1),
(2, 'Mara chache sana', 0),
(2, 'Mara kwa mara', 0),
(2, 'Kila wakati', 0);

-- Majibu ya Swali la 3 (id = 3)
INSERT INTO `answers` (`question_id`, `answer_text`, `is_correct`) VALUES
(3, 'Hapana, bado nayapenda sana', 1),
(3, 'Kiasi kidogo', 0),
(3, 'Sana, sina hamu tena', 0),
(3, 'Sijishughulishi kabisa na kitu chochote', 0);



INSERT INTO `submissions` (`id`, `user_id`, `score`, `feedback`) VALUES
(1, 2, 100, 'Hongera sana! Unaonyesha kuwa na afya imara ya akili. Endelea kujitunza!');


INSERT INTO `submission_details` (`submission_id`, `question_id`, `selected_answer_id`) VALUES
(1, 1, 1),  -- Kwenye swali la 1, alichagua jibu lenye ID 1
(1, 2, 5),  -- Kwenye swali la 2, alichagua jibu lenye ID 5
(1, 3, 9);  -- Kwenye swali la 3, alichagua jibu lenye ID 9




```
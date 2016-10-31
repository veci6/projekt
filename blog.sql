-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Úte 25. říj 2016, 21:16
-- Verze serveru: 10.1.9-MariaDB
-- Verze PHP: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `blog`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `article`
--

CREATE TABLE `article` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `released` tinyint(4) NOT NULL DEFAULT '0',
  `released_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `article`
--

INSERT INTO `article` (`id`, `user_id`, `category_id`, `title`, `content`, `released`, `released_date`) VALUES
(1, 1, 1, 'První článek', 'sfs fdsfds safsf asf asf asfsd fsfdsf sfds fsf s fsf sd fsdf sdf sd fds fsd', 1, '2016-10-18 20:27:57'),
(3, 1, 1, 'Druhý článek', 'Odsdfkj kksdfkjhsdkjh kds dsjhfkjsdhkj dhs kdhskj fdskj fkjds', 1, '2016-10-18 20:28:31');

-- --------------------------------------------------------

--
-- Struktura tabulky `article_category`
--

CREATE TABLE `article_category` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `article_category`
--

INSERT INTO `article_category` (`id`, `name`, `description`) VALUES
(1, 'Programové vybavení', 'PVY popis'),
(2, 'Programování', 'PRP text');

-- --------------------------------------------------------

--
-- Struktura tabulky `article_comment`
--

CREATE TABLE `article_comment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `article_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `article_comment`
--

INSERT INTO `article_comment` (`id`, `user_id`, `article_id`, `content`, `date`) VALUES
(1, 1, 3, 'wfdsf ds fdsf sdfassfsd', '2016-10-18 21:10:51'),
(2, 1, 3, 'tretrewt ewret re', '2016-10-18 21:11:39');

-- --------------------------------------------------------

--
-- Struktura tabulky `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(15) NOT NULL,
  `password` varchar(60) NOT NULL,
  `email` varchar(50) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `registration_date` datetime NOT NULL,
  `role` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `user`
--

INSERT INTO `user` (`id`, `name`, `password`, `email`, `ip`, `registration_date`, `role`) VALUES
(1, 'admin', '$2y$10$2bG4oiuByABuk.VXw8wmBeta0YS.bncfycqG0YJKd3UagQLDlPQc.', '', '', '2015-07-23 16:37:39', 2),
(2, 'user', '$2y$10$Q09JYfCeKZ1UXlt4WfYVRelVHuZe876df.PayGKCXgRR6zOL7cdQ.', '', '', '2015-07-23 16:37:39', 1),
(3, 'marek', '$2y$10$IrSLL5fQuFEcVTsF5gSpSuQsBK4wEF1xaowh6ukdveDGewupkhh4e', 'lucny@sspu-opava.cz', '::1', '2016-10-17 19:55:22', 1),
(4, 'osel', '$2y$10$9JVmE4.66FV5p3OehkgkauLUXQiN8KFichlo7bbQ1G.2OgJ7BqKbK', 'osel@email.cz', '::1', '2016-10-17 20:00:41', 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `user_settings`
--

CREATE TABLE `user_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Vypisuji data pro tabulku `user_settings`
--

INSERT INTO `user_settings` (`id`, `user_id`, `description`) VALUES
(1, 1, 'ewrewr'),
(2, 2, '');

--
-- Klíče pro exportované tabulky
--

--
-- Klíče pro tabulku `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Klíče pro tabulku `article_category`
--
ALTER TABLE `article_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Klíče pro tabulku `article_comment`
--
ALTER TABLE `article_comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `article_id` (`article_id`);

--
-- Klíče pro tabulku `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Klíče pro tabulku `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `article`
--
ALTER TABLE `article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pro tabulku `article_category`
--
ALTER TABLE `article_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pro tabulku `article_comment`
--
ALTER TABLE `article_comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pro tabulku `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pro tabulku `user_settings`
--
ALTER TABLE `user_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `article_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `article_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `article_category` (`id`) ON DELETE SET NULL;

--
-- Omezení pro tabulku `article_comment`
--
ALTER TABLE `article_comment`
  ADD CONSTRAINT `article_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `article_comment_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE CASCADE;

--
-- Omezení pro tabulku `user_settings`
--
ALTER TABLE `user_settings`
  ADD CONSTRAINT `user_settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 17. Apr 2021 um 10:59
-- Server-Version: 10.4.17-MariaDB
-- PHP-Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `samp`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `autos`
--

CREATE TABLE `autos` (
  `id` int(11) NOT NULL,
  `besitzer` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `r` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `autos`
--

INSERT INTO `autos` (`id`, `besitzer`, `model`, `x`, `y`, `z`, `r`) VALUES
(8, 3, 400, 189.894, -264.242, 1.51857, 179.889);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `exp`
--

CREATE TABLE `exp` (
  `id` bigint(20) NOT NULL,
  `user` varchar(60) NOT NULL,
  `exp` int(5) UNSIGNED NOT NULL,
  `ts` datetime NOT NULL
) ENGINE=Aria DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `exp`
--

INSERT INTO `exp` (`id`, `user`, `exp`, `ts`) VALUES
(1, 'ioannis_gutenberg', 125, '2021-03-03 09:42:00'),
(2, 'ioannis_gutenberg', 125, '2021-03-03 09:37:00'),
(3, 'ioannis_gutenberg', 450, '2021-03-03 09:23:00'),
(4, 'ioannis_gutenberg', 450, '2021-03-03 09:22:00'),
(5, 'ioannis_gutenberg', 450, '2021-03-03 12:00:00'),
(6, 'ioannis_gutenberg', 450, '2021-03-03 12:44:00'),
(7, 'ioannis_gutenberg', 450, '2021-03-03 12:43:00'),
(8, 'ioannis_gutenberg', 450, '2021-03-03 12:50:00'),
(9, 'ioannis_gutenberg', 450, '2021-03-03 12:54:00'),
(10, 'ioannis_gutenberg', 450, '2021-03-03 12:53:00'),
(11, 'ioannis_gutenberg', 450, '2021-03-03 12:52:00'),
(12, 'Meno', 450, '2021-03-18 15:35:00'),
(13, 'Meno', 450, '2021-03-18 15:23:00'),
(14, 'Meno', 400, '2021-03-18 15:18:00'),
(15, 'Meno', 450, '2021-03-18 15:12:00'),
(16, 'MartyMcFly', 250, '2021-03-18 11:39:00'),
(17, 'byMicha', 210, '2021-03-17 12:31:00'),
(18, 'byMicha', 210, '2021-03-17 12:24:00'),
(19, 'byMicha', 210, '2021-03-17 12:15:00'),
(20, 'byMicha', 210, '2021-03-17 12:08:00'),
(21, 'byMicha', 210, '2021-03-17 12:01:00'),
(22, 'byMicha', 210, '2021-03-17 11:29:00'),
(23, 'byMicha', 210, '2021-03-17 11:22:00'),
(24, 'byMicha', 210, '2021-03-17 11:14:00'),
(25, 'byMicha', 210, '2021-03-17 11:07:00'),
(26, 'byMicha', 210, '2021-03-17 10:58:00'),
(27, 'byMicha', 210, '2021-03-17 10:50:00'),
(28, 'byMicha', 210, '2021-03-17 10:42:00'),
(29, 'byMicha', 210, '2021-03-17 10:34:00'),
(30, 'byMicha', 210, '2021-03-17 10:08:00'),
(31, 'byMicha', 210, '2021-03-17 09:55:00'),
(32, 'byMicha', 170, '2021-03-17 09:45:00'),
(33, 'byMicha', 170, '2021-03-17 09:37:00'),
(34, 'byMicha', 170, '2021-03-17 09:30:00'),
(35, 'byMicha', 170, '2021-03-17 09:22:00'),
(36, 'Meno', 550, '2021-03-16 17:54:00'),
(37, 'Meno', 450, '2021-03-16 17:46:00'),
(38, 'Meno', 450, '2021-03-16 17:38:00'),
(39, 'Meno', 350, '2021-03-16 17:31:00'),
(40, 'Meno', 500, '2021-03-16 17:25:00'),
(41, 'byMicha', 170, '2021-03-15 23:58:00'),
(42, 'byMicha', 170, '2021-03-15 23:50:00'),
(43, 'byMicha', 170, '2021-03-15 23:42:00'),
(44, 'byMicha', 170, '2021-03-15 23:35:00'),
(45, 'byMicha', 170, '2021-03-15 23:28:00'),
(46, 'byMicha', 170, '2021-03-15 23:21:00'),
(47, 'byMicha', 170, '2021-03-15 23:13:00'),
(48, 'byMicha', 170, '2021-03-15 23:05:00'),
(49, 'byMicha', 170, '2021-03-15 20:58:00'),
(50, 'byMicha', 170, '2021-03-15 20:51:00'),
(51, 'byMicha', 170, '2021-03-15 20:44:00'),
(52, 'byMicha', 170, '2021-03-15 20:37:00'),
(53, 'byMicha', 170, '2021-03-15 20:30:00'),
(54, 'byMicha', 170, '2021-03-15 20:22:00'),
(55, 'byMicha', 170, '2021-03-15 20:15:00'),
(56, 'byMicha', 170, '2021-03-15 20:02:00'),
(57, 'byMicha', 170, '2021-03-15 19:54:00'),
(58, 'byMicha', 170, '2021-03-15 19:46:00'),
(59, 'byMicha', 170, '2021-03-15 17:35:00'),
(60, 'Meno', 450, '2021-03-14 13:21:00'),
(61, 'Meno', 500, '2021-03-14 13:11:00'),
(62, 'ioannis_gutenberg', 152, '2021-03-11 11:00:00'),
(63, 'ioannis_gutenberg', 173, '2021-03-11 10:49:00'),
(64, 'ioannis_gutenberg', 73, '2021-03-11 10:43:00'),
(65, 'ioannis_gutenberg', 174, '2021-03-11 10:41:00'),
(66, 'Gehilfe', 250, '2021-03-10 14:27:00'),
(67, 'Gehilfe', 250, '2021-03-10 14:17:00'),
(68, 'Gehilfe', 250, '2021-03-10 14:06:00'),
(69, 'Gehilfe', 250, '2021-03-10 13:56:00'),
(70, 'Gehilfe', 250, '2021-03-10 13:38:00'),
(71, 'Gehilfe', 100, '2021-03-09 21:37:00'),
(72, 'ioannis_gutenberg', 68, '2021-03-08 16:55:00'),
(73, 'ioannis_gutenberg', 87, '2021-03-08 16:54:00'),
(74, 'ioannis_gutenberg', 95, '2021-03-08 16:52:00'),
(75, 'ioannis_gutenberg', 185, '2021-03-08 16:49:00'),
(76, 'ioannis_gutenberg', 156, '2021-03-08 16:43:00'),
(77, 'ioannis_gutenberg', 450, '2021-03-08 07:45:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(35) NOT NULL,
  `passwort` varchar(35) NOT NULL,
  `level` int(11) NOT NULL,
  `money` int(11) NOT NULL,
  `adminlevel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`id`, `username`, `passwort`, `level`, `money`, `adminlevel`) VALUES
(2, 'Ioannis20x', 'dc942192d1ef69bb8a795d9d36dd3efa', 50, 100000, 6),
(3, 'Ioannis_Gutenberg', 'dc942192d1ef69bb8a795d9d36dd3efa', 50, 100000, 6);

-- --------------------------------------------------------

--
-- Stellvertreter-Struktur des Views `view_exp`
-- (Siehe unten für die tatsächliche Ansicht)
--
CREATE TABLE `view_exp` (
`Name` varchar(60)
,`AnzahlFahrten` bigint(21)
,`SummeErfahrung` decimal(32,0)
,`Kalenderwoche` varchar(7)
);

-- --------------------------------------------------------

--
-- Struktur des Views `view_exp`
--
DROP TABLE IF EXISTS `view_exp`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_exp`  AS SELECT `exp`.`user` AS `Name`, count(`exp`.`id`) AS `AnzahlFahrten`, sum(`exp`.`exp`) AS `SummeErfahrung`, concat(substr(if(dayofweek(`exp`.`ts`) = 1 and hour(`exp`.`ts`) >= 12,yearweek(`exp`.`ts` + interval 1 day,3),yearweek(`exp`.`ts`,3)),5,2),'/',substr(if(dayofweek(`exp`.`ts`) = 1 and hour(`exp`.`ts`) >= 12,yearweek(`exp`.`ts` + interval 1 day,3),yearweek(`exp`.`ts`,3)),1,4)) AS `Kalenderwoche` FROM `exp` GROUP BY concat(substr(if(dayofweek(`exp`.`ts`) = 1 and hour(`exp`.`ts`) >= 12,yearweek(`exp`.`ts` + interval 1 day,3),yearweek(`exp`.`ts`,3)),5,2),'/',substr(if(dayofweek(`exp`.`ts`) = 1 and hour(`exp`.`ts`) >= 12,yearweek(`exp`.`ts` + interval 1 day,3),yearweek(`exp`.`ts`,3)),1,4),'/',`exp`.`user`) ORDER BY concat(substr(if(dayofweek(`exp`.`ts`) = 1 and hour(`exp`.`ts`) >= 12,yearweek(`exp`.`ts` + interval 1 day,3),yearweek(`exp`.`ts`,3)),1,4),substr(if(dayofweek(`exp`.`ts`) = 1 and hour(`exp`.`ts`) >= 12,yearweek(`exp`.`ts` + interval 1 day,3),yearweek(`exp`.`ts`,3)),5,2)) DESC, count(`exp`.`id`) DESC, sum(`exp`.`exp`) DESC ;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `autos`
--
ALTER TABLE `autos`
  ADD UNIQUE KEY `id_2` (`id`,`besitzer`,`model`,`x`,`y`,`z`,`r`),
  ADD KEY `id` (`id`,`besitzer`,`model`,`x`,`y`,`z`,`r`);

--
-- Indizes für die Tabelle `exp`
--
ALTER TABLE `exp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_ts` (`user`,`ts`) USING BTREE,
  ADD KEY `user` (`user`),
  ADD KEY `ts` (`ts`);

--
-- Indizes für die Tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `autos`
--
ALTER TABLE `autos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT für Tabelle `exp`
--
ALTER TABLE `exp`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT für Tabelle `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 08, 2024 at 01:23 PM
-- Server version: 10.6.19-MariaDB-log
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_molinami`
--

-- --------------------------------------------------------

--
-- Table structure for table `HurricaneSeasons`
--

CREATE TABLE `HurricaneSeasons` (
  `season_id` year(4) NOT NULL,
  `hurricane_count` int(11) NOT NULL,
  `tropical_storm_count` int(11) NOT NULL,
  `tropical_depression_count` int(11) NOT NULL,
  `first_storm_date` date NOT NULL,
  `last_storm_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `HurricaneSeasons`
--

INSERT INTO `HurricaneSeasons` (`season_id`, `hurricane_count`, `tropical_storm_count`, `tropical_depression_count`, `first_storm_date`, `last_storm_date`) VALUES
('0000', 0, 0, 0, '0000-00-00', '0000-00-00'),
('2019', 2147483647, 2147483647, 1523, '2024-12-12', '2013-12-04'),
('2021', 5, 5, 5, '0000-00-00', '0000-00-00'),
('2022', 8, 14, 333, '2023-06-05', '2023-11-07'),
('2023', 5, 10, 21, '2023-01-16', '2023-10-23'),
('2024', 9, 14, 15, '2024-06-19', '2024-10-22'),
('2025', 8, 4, 4, '2025-01-11', '2025-11-11'),
('2029', 22, 22, 22, '2022-09-01', '2023-09-12');

-- --------------------------------------------------------

--
-- Table structure for table `Impacts`
--

CREATE TABLE `Impacts` (
  `impact_id` int(11) NOT NULL,
  `impact_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `Impacts`
--

INSERT INTO `Impacts` (`impact_id`, `impact_type`) VALUES
(1, 'Floodedd'),
(2, 'Wind Damage'),
(3, 'Storm Surge'),
(4, 'Tornado'),
(5, 'Heavy Rainfall'),
(6, 'bigger tst'),
(7, 'another test pt 2'),
(33, 'a'),
(99, 'test'),
(1141, 'It was no bueno. No good'),
(15154, 'THE BIGGEST HURRICANE YOU HAVE EVER SEEN'),
(235522345, 'MASSIVE IMPACT');

-- --------------------------------------------------------

--
-- Table structure for table `TropicalSystemImpacts`
--

CREATE TABLE `TropicalSystemImpacts` (
  `id` int(11) NOT NULL,
  `season_id` year(4) NOT NULL,
  `system_id` int(11) NOT NULL,
  `impact_id` int(11) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  `localized_impact_desc` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `TropicalSystemImpacts`
--

INSERT INTO `TropicalSystemImpacts` (`id`, `season_id`, `system_id`, `impact_id`, `city`, `state`, `country`, `region`, `localized_impact_desc`) VALUES
(1, '2022', 1, 2, 'Lakeland', 'FL', 'United States', 'Gulf Coast', 'Flooding in Lakeland, FL area'),
(2, '2023', 1, 2, NULL, 'FL', 'United States', 'Gulf Coast', 'Roofs blown off due to wind gusts in Southwest Florida'),
(4, '2024', 1, 5, 'Monterrey', 'NL', 'Mexico', 'Mexico', 'Heavy rainfall in Monterrey, MX'),
(10, '2022', 3, 3, 'Bryan', 'TX', 'United States', 'Gulf Coast', 'Severe flooding in downtown Houston and surrounding areas'),
(26, '2022', 4, NULL, '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `TropicalSystems`
--

CREATE TABLE `TropicalSystems` (
  `season_id` year(4) NOT NULL,
  `system_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `max_category` varchar(2) NOT NULL,
  `land_impact` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `TropicalSystems`
--

INSERT INTO `TropicalSystems` (`season_id`, `system_id`, `name`, `start_date`, `end_date`, `max_category`, `land_impact`) VALUES
('2022', 0, 'fffff', '2022-11-11', '0000-00-00', 'TS', 1),
('2022', 1, 'A', '2022-06-10', '2022-06-11', 'H1', 0),
('2023', 1, 'Arlene', '2023-06-01', '2023-06-03', 'TS', 1),
('2024', 1, 'Alberto', '2024-06-19', '2024-06-20', 'TS', 1),
('2023', 2, 'Bret', '2023-06-19', '2023-06-24', 'TS', 1),
('2022', 3, 'Colinee', '2022-07-01', '2022-07-02', 'TS', 1),
('2023', 3, 'Cindy', '2023-06-22', '2023-06-26', 'TS', 0),
('2022', 4, 'Danielle', '2022-09-01', '2022-09-08', 'H1', 0),
('2023', 4, 'Don', '2023-06-22', '2023-07-14', 'H1', 0),
('2022', 5, 'Emily', '2022-09-01', '2022-09-08', 'H5', 1),
('2029', 99, 'test', '2022-02-02', '2023-03-03', 'H3', 1),
('2029', 100, 'jsf', '2022-02-02', '2023-03-03', 'H1', 1),
('2029', 102, 'fsdf', '0000-00-00', '2023-03-03', 'H1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `TropicalSystemStats`
--

CREATE TABLE `TropicalSystemStats` (
  `stat_id` int(11) NOT NULL,
  `season_id` year(4) NOT NULL,
  `system_id` int(11) NOT NULL,
  `min_pressure` int(11) DEFAULT NULL,
  `max_wind_speed` int(11) NOT NULL,
  `max_rainfall` decimal(8,2) DEFAULT NULL,
  `max_storm_surge` int(11) DEFAULT NULL,
  `death_count` int(11) NOT NULL,
  `injury_count` int(11) DEFAULT NULL,
  `total_cost` decimal(20,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `TropicalSystemStats`
--

INSERT INTO `TropicalSystemStats` (`stat_id`, `season_id`, `system_id`, `min_pressure`, `max_wind_speed`, `max_rainfall`, `max_storm_surge`, `death_count`, `injury_count`, `total_cost`) VALUES
(2, '2023', 1, 998, 40, 9.82, NULL, 80, 105, 99999999.99),
(4, '2024', 2, 934, 165, 15.00, 9, 44, 80, 32000000.00),
(6, '2022', 2, 996, 60, 30.00, 3, 3, 0, 25000000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `HurricaneSeasons`
--
ALTER TABLE `HurricaneSeasons`
  ADD PRIMARY KEY (`season_id`),
  ADD UNIQUE KEY `season_id` (`season_id`);

--
-- Indexes for table `Impacts`
--
ALTER TABLE `Impacts`
  ADD PRIMARY KEY (`impact_id`);

--
-- Indexes for table `TropicalSystemImpacts`
--
ALTER TABLE `TropicalSystemImpacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_impact_id` (`impact_id`),
  ADD KEY `unique_combination` (`season_id`,`system_id`,`impact_id`) USING BTREE;

--
-- Indexes for table `TropicalSystems`
--
ALTER TABLE `TropicalSystems`
  ADD PRIMARY KEY (`system_id`,`season_id`) USING BTREE,
  ADD KEY `season_id` (`season_id`) USING BTREE;

--
-- Indexes for table `TropicalSystemStats`
--
ALTER TABLE `TropicalSystemStats`
  ADD PRIMARY KEY (`stat_id`,`season_id`,`system_id`) USING BTREE,
  ADD KEY `season_id` (`season_id`),
  ADD KEY `system_id` (`system_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `TropicalSystemImpacts`
--
ALTER TABLE `TropicalSystemImpacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `TropicalSystemStats`
--
ALTER TABLE `TropicalSystemStats`
  MODIFY `stat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `TropicalSystemImpacts`
--
ALTER TABLE `TropicalSystemImpacts`
  ADD CONSTRAINT `fk_impact_id` FOREIGN KEY (`impact_id`) REFERENCES `Impacts` (`impact_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_season_id` FOREIGN KEY (`season_id`) REFERENCES `HurricaneSeasons` (`season_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_system_id` FOREIGN KEY (`season_id`,`system_id`) REFERENCES `TropicalSystems` (`season_id`, `system_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TropicalSystems`
--
ALTER TABLE `TropicalSystems`
  ADD CONSTRAINT `TropicalSystems_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `HurricaneSeasons` (`season_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TropicalSystemStats`
--
ALTER TABLE `TropicalSystemStats`
  ADD CONSTRAINT `TropicalSystemStats_ibfk_1` FOREIGN KEY (`season_id`) REFERENCES `HurricaneSeasons` (`season_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `TropicalSystemStats_ibfk_2` FOREIGN KEY (`system_id`) REFERENCES `TropicalSystems` (`system_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

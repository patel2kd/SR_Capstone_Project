-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 25, 2022 at 05:11 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `alarm`
--

-- --------------------------------------------------------

--
-- Table structure for table `alarm_detail`
--

CREATE TABLE `alarm_detail` (
  `id` int(50) NOT NULL,
  `email_ref` varchar(100) NOT NULL,
  `alarm_id` int(50) NOT NULL,
  `status` int(50) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `alarm_tbl`
--

CREATE TABLE `alarm_tbl` (
  `id` int(11) NOT NULL,
  `email_ref` varchar(100) NOT NULL,
  `title` varchar(50) NOT NULL,
  `alarmDateTime` datetime NOT NULL,
  `isPending` int(11) DEFAULT NULL,
  `isOn` int(50) NOT NULL,
  `isActive` int(50) NOT NULL,
  `gradientColorIndex` int(11) DEFAULT NULL,
  `nid` varchar(50) DEFAULT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `eemail` varchar(50) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `econtact` varchar(10) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alarm_detail`
--
ALTER TABLE `alarm_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `alarm_tbl`
--
ALTER TABLE `alarm_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alarm_detail`
--
ALTER TABLE `alarm_detail`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `alarm_tbl`
--
ALTER TABLE `alarm_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

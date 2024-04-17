-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 16, 2023 at 07:18 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bus_management_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `userId` int(11) NOT NULL,
  `locationId` int(11) NOT NULL,
  `pickupdate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bus`
--

CREATE TABLE `bus` (
  `id` int(11) NOT NULL,
  `color` varchar(50) NOT NULL,
  `capacity` int(11) NOT NULL,
  `number_of_plate` varchar(50) NOT NULL,
  `date_of_bus_registration` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `busonlineactivity`
--

CREATE TABLE `busonlineactivity` (
  `busId` int(11) NOT NULL,
  `live_location` varchar(50) NOT NULL,
  `sensor_capacity_availability` int(11) NOT NULL,
  `loaded_capacity` int(11) NOT NULL,
  `last_date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `license` varchar(250) NOT NULL,
  `phone_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `dateOfTrip` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `LocationId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `locationName` varchar(50) NOT NULL,
  `routeId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relationdriverbus`
--

CREATE TABLE `relationdriverbus` (
  `idBus` int(11) NOT NULL,
  `idDriver` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `relationroutesstoppoint`
--

CREATE TABLE `relationroutesstoppoint` (
  `routeId` int(11) NOT NULL,
  `stopPointId` int(11) NOT NULL,
  `relationRoutesStopPointOrder` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stoppoint`
--

CREATE TABLE `stoppoint` (
  `id` int(11) NOT NULL,
  `routeId` int(11) NOT NULL,
  `stopName` varchar(50) NOT NULL,
  `coordinateX` decimal(10,0) NOT NULL,
  `coordinateY` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `distanceA` int(10) NOT NULL,
  `distanceB` int(10) NOT NULL,
  `distanceC` int(10) NOT NULL,
  `trafficA` varchar(10) NOT NULL,
  `trafficB` varchar(10) NOT NULL,
  `trafficC` varchar(10) NOT NULL,
  `nbOfUsersA` int(10) NOT NULL,
  `nbOfUsersB` int(10) NOT NULL,
  `nbOfUsersC` int(10) NOT NULL,
  `result` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`distanceA`, `distanceB`, `distanceC`, `trafficA`, `trafficB`, `trafficC`, `nbOfUsersA`, `nbOfUsersB`, `nbOfUsersC`, `result`) VALUES
(72, 81, 80, 'medium', 'low', 'medium', 31, 29, 34, 'routeC'),
(72, 81, 80, 'high', 'low', 'high', 30, 33, 42, 'routeC'),
(72, 81, 80, 'low', 'medium', 'high', 25, 32, 28, 'routeB'),
(72, 81, 80, 'low', 'low', 'medium', 28, 30, 46, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'medium', 23, 30, 42, 'routeC'),
(72, 81, 80, 'high', 'medium', 'high', 32, 34, 47, 'routeC'),
(72, 81, 80, 'low', 'high', 'medium', 28, 32, 30, 'routeA'),
(72, 81, 80, 'medium', 'medium', 'high', 35, 39, 42, 'routeB'),
(72, 81, 80, 'low', 'low', 'low', 32, 40, 47, 'routeC'),
(72, 81, 80, 'low', 'high', 'high', 26, 32, 41, 'routeC'),
(72, 81, 80, 'high', 'low', 'high', 28, 31, 31, 'routeB'),
(72, 81, 80, 'medium', 'high', 'low', 42, 32, 36, 'routeA'),
(72, 81, 80, 'low', 'high', 'high', 35, 41, 39, 'routeA'),
(72, 81, 80, 'high', 'high', 'medium', 31, 33, 41, 'routeC'),
(72, 81, 80, 'low', 'low', 'medium', 28, 34, 31, 'routeB'),
(72, 81, 80, 'high', 'high', 'high', 27, 29, 33, 'routeC'),
(72, 81, 80, 'medium', 'heigh', 'low', 29, 35, 31, 'routeC'),
(72, 81, 80, 'low', 'high', 'high', 33, 35, 37, 'routeA'),
(72, 81, 80, 'low', 'high', 'low', 29, 33, 28, 'routeA'),
(72, 81, 80, 'low', 'low', 'low', 31, 37, 32, 'routeB'),
(72, 81, 80, 'high', 'medium', 'medium', 43, 33, 30, 'routeA'),
(72, 81, 80, 'medium', 'high', 'low', 40, 39, 38, 'routeC'),
(72, 81, 80, 'low', 'medium', 'low', 37, 42, 31, 'routeA'),
(72, 81, 80, 'low', 'high', 'low', 36, 41, 34, 'routeA'),
(72, 81, 80, 'high', 'low', 'medium', 27, 33, 39, 'routeC'),
(72, 81, 80, 'low', 'low', 'high', 48, 42, 45, 'routeA'),
(72, 81, 80, 'low', 'low', 'low', 43, 37, 45, 'routeC'),
(72, 81, 80, 'medium', 'low', 'medium', 39, 44, 47, 'routeB'),
(72, 81, 80, 'low', 'medium', 'medium', 31, 35, 37, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'high', 37, 42, 41, 'routeB'),
(72, 81, 80, 'high', 'low', 'high', 30, 33, 42, 'routeC'),
(72, 81, 80, 'high', 'high', 'low', 44, 39, 35, 'routeA'),
(72, 81, 80, 'low', 'high', 'low', 28, 34, 47, 'routeC'),
(72, 81, 80, 'high', 'low', 'high', 30, 33, 42, 'routeC'),
(72, 81, 80, 'medium', 'high', 'high', 31, 42, 41, 'routeB'),
(72, 81, 80, 'medium', 'medium', 'low', 50, 36, 43, 'routeA'),
(72, 81, 80, 'low', 'low', 'high', 38, 32, 36, 'routeA'),
(72, 81, 80, 'high', 'low', 'high', 26, 29, 42, 'routeC'),
(72, 81, 80, 'medium', 'low', 'low', 29, 33, 39, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'low', 47, 34, 41, 'routeA'),
(72, 81, 80, 'high', 'medium', 'medium', 41, 36, 41, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'low', 37, 37, 37, 'routeC'),
(72, 81, 80, 'low', 'medium', 'high', 34, 39, 42, 'routeA'),
(72, 81, 80, 'low', 'low', 'high', 41, 22, 37, 'routeA'),
(72, 81, 80, 'high', 'medium', 'high', 36, 43, 48, 'routeC'),
(72, 81, 80, 'low', 'low', 'medium', 50, 43, 49, 'routeA'),
(72, 81, 80, 'medium', 'medium', 'high', 33, 47, 38, 'routeB'),
(72, 81, 80, 'low', 'low', 'high', 50, 42, 50, 'routeA'),
(72, 81, 80, 'medium', 'low', 'high', 28, 35, 31, 'routeB'),
(72, 81, 80, 'low', 'low', 'high', 35, 32, 41, 'routeA'),
(72, 81, 80, 'high', 'medium', 'high', 29, 38, 47, 'routeC'),
(72, 81, 80, 'medium', 'low', 'low', 27, 34, 31, 'routeB'),
(72, 81, 80, 'high', 'high', 'low', 39, 32, 28, 'routeA');

-- --------------------------------------------------------

--
-- Table structure for table `train`
--

CREATE TABLE `train` (
  `distanceA` int(10) NOT NULL,
  `distanceB` int(10) NOT NULL,
  `distanceC` int(10) NOT NULL,
  `trafficA` varchar(100) NOT NULL,
  `trafficB` varchar(100) NOT NULL,
  `trafficC` varchar(100) NOT NULL,
  `nbOfUsersA` int(10) NOT NULL,
  `nbOfUsersB` int(10) NOT NULL,
  `nbOfUsersC` int(10) NOT NULL,
  `result` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `train`
--

INSERT INTO `train` (`distanceA`, `distanceB`, `distanceC`, `trafficA`, `trafficB`, `trafficC`, `nbOfUsersA`, `nbOfUsersB`, `nbOfUsersC`, `result`) VALUES
(72, 81, 80, 'low', 'low', 'high', 35, 32, 41, 'routeA'),
(72, 81, 80, 'high', 'medium', 'high', 29, 38, 47, 'routeC'),
(72, 81, 80, 'medium', 'low', 'low', 27, 34, 31, 'routeB'),
(72, 81, 80, 'low', 'high', 'medium', 33, 42, 35, 'routeB'),
(72, 81, 80, 'medium', 'medium', 'low', 34, 36, 34, 'routeC'),
(72, 81, 80, 'low', 'high', 'high', 35, 33, 31, 'routeA'),
(72, 81, 80, 'low', 'medium', 'low', 29, 34, 27, 'routeA'),
(72, 81, 80, 'medium', 'medium', 'high', 37, 26, 42, 'routeA'),
(72, 81, 80, 'low', 'medium', 'medium', 34, 38, 40, 'routeC'),
(72, 81, 80, 'high', 'high', 'low', 39, 32, 28, 'routeA'),
(72, 81, 80, 'low', 'medium', 'high', 25, 30, 43, 'routeC'),
(72, 81, 80, 'medium', 'high', 'low', 32, 27, 41, 'routeC'),
(72, 81, 80, 'low', 'medium', 'high', 45, 26, 31, 'routeA'),
(72, 81, 80, 'high', 'low', 'low', 27, 32, 25, 'routeB'),
(72, 81, 80, 'low', 'medium', 'high', 50, 30, 26, 'routeA'),
(72, 81, 80, 'low', 'medium', 'high', 42, 50, 30, 'routeB'),
(72, 81, 80, 'low', 'medium', 'high', 31, 25, 42, 'routeA'),
(72, 81, 80, 'low', 'medium', 'high', 49, 33, 27, 'routeA'),
(72, 81, 80, 'high', 'low', 'medium', 33, 25, 40, 'routeC'),
(72, 81, 80, 'high', 'low', 'high', 35, 45, 26, 'routeB'),
(72, 81, 80, 'medium', 'low', 'high', 32, 40, 26, 'routeB'),
(72, 81, 80, 'high', 'low', 'medium', 45, 28, 30, 'routeA'),
(72, 81, 80, 'high', 'low', 'medium', 31, 27, 32, 'routeC'),
(72, 81, 80, 'low', 'medium', 'high', 33, 44, 49, 'routeC'),
(72, 81, 80, 'low', 'medium', 'high', 25, 30, 27, 'routeA'),
(72, 81, 80, 'low', 'medium', 'high', 28, 37, 32, 'routeB'),
(72, 81, 80, 'high', 'low', 'medium', 31, 27, 25, 'routeB'),
(72, 81, 80, 'high', 'low', 'high', 33, 26, 40, 'routeC'),
(72, 81, 80, 'low', 'medium', 'high', 28, 32, 46, 'routeC'),
(72, 81, 80, 'high', 'low', 'medium', 25, 27, 26, 'routeB'),
(72, 81, 80, 'medium', 'low', 'high', 33, 27, 32, 'routeA'),
(72, 81, 80, 'low', 'medium', 'high', 27, 42, 30, 'routeB'),
(72, 81, 80, 'medium', 'low', 'medium', 35, 43, 40, 'routeC'),
(72, 81, 80, 'medium', 'high', 'medium', 31, 27, 33, 'routeC'),
(72, 81, 80, 'high', 'high', 'low', 36, 39, 37, 'routeC'),
(72, 81, 80, 'low', 'medium', 'medium', 42, 35, 27, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 47, 32, 43, 'routeA'),
(72, 81, 80, 'medium', 'low', 'medium', 33, 41, 36, 'routeB'),
(72, 81, 80, 'low', 'high', 'high', 31, 33, 26, 'routeA'),
(72, 81, 80, 'medium', 'low', 'low', 21, 27, 31, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'medium', 23, 41, 30, 'routeB'),
(72, 81, 80, 'low', 'low', 'medium', 50, 43, 49, 'routeA'),
(72, 81, 80, 'medium', 'medium', 'high', 33, 47, 38, 'routeB'),
(72, 81, 80, 'low', 'low', 'high', 50, 42, 50, 'routeA'),
(72, 81, 80, 'medium', 'low', 'high', 42, 41, 44, 'routeB'),
(72, 81, 80, 'low', 'medium', 'low', 29, 32, 35, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'high', 45, 31, 40, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 32, 39, 41, 'routeB'),
(72, 81, 80, 'medium', 'high', 'medium', 49, 39, 43, 'routeA'),
(72, 81, 80, 'high', 'high', 'medium', 30, 37, 34, 'routeB'),
(72, 81, 80, 'medium', 'medium', 'low', 30, 37, 42, 'routeC'),
(72, 81, 80, 'low', 'low', 'medium', 41, 36, 40, 'routeA'),
(72, 81, 80, 'high', 'low', 'high', 37, 29, 47, 'routeC'),
(72, 81, 80, 'low', 'high', 'medium', 30, 32, 34, 'routeA'),
(72, 81, 80, 'medium', 'low', 'high', 28, 35, 31, 'routeB'),
(72, 81, 80, 'low', 'low', 'medium', 39, 43, 50, 'routeC'),
(72, 81, 80, 'medium', 'low', 'medium', 27, 36, 39, 'routeB'),
(72, 81, 80, 'high', 'low', 'medium', 25, 28, 35, 'routeC'),
(72, 81, 80, 'high', 'low', 'medium', 33, 40, 35, 'routeB'),
(72, 81, 80, 'high', 'high', 'low', 50, 30, 26, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 45, 47, 50, 'routeB'),
(72, 81, 80, 'low', 'low', 'medium', 42, 30, 27, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 35, 45, 25, 'routeA'),
(72, 81, 80, 'high', 'low', 'medium', 26, 36, 38, 'routeB'),
(72, 81, 80, 'high', 'low', 'medium', 40, 31, 45, 'routeC'),
(72, 81, 80, 'low', 'low', 'medium', 26, 30, 40, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'low', 35, 40, 26, 'routeB'),
(72, 81, 80, 'high', 'low', 'medium', 29, 30, 50, 'routeC'),
(72, 81, 80, 'high', 'low', 'medium', 30, 41, 44, 'routeB'),
(72, 81, 80, 'high', 'high', 'low', 32, 40, 31, 'routeB'),
(72, 81, 80, 'high', 'high', 'low', 27, 33, 45, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'low', 41, 32, 40, 'routeC'),
(72, 81, 80, 'high', 'high', 'low', 40, 36, 50, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'low', 27, 30, 45, 'routeC'),
(72, 81, 80, 'high', 'high', 'low', 30, 49, 31, 'routeB'),
(72, 81, 80, 'high', 'high', 'low', 33, 40, 35, 'routeC'),
(72, 81, 80, 'high', 'low', 'medium', 32, 50, 34, 'routeB'),
(72, 81, 80, 'high', 'low', 'medium', 37, 42, 50, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'low', 30, 40, 50, 'routeC'),
(72, 81, 80, 'high', 'low', 'high', 30, 37, 27, 'routeB'),
(72, 81, 80, 'medium', 'low', 'low', 36, 29, 37, 'routeC'),
(72, 81, 80, 'high', 'medium', 'high', 28, 41, 43, 'routeB'),
(72, 81, 80, 'low', 'high', 'high', 40, 29, 38, 'routeA'),
(72, 81, 80, 'low', 'medium', 'medium', 27, 31, 29, 'routeA'),
(72, 81, 80, 'medium', 'high', 'high', 42, 37, 50, 'routeC'),
(72, 81, 80, 'high', 'high', 'medium', 46, 34, 43, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 32, 27, 33, 'routeA'),
(72, 81, 80, 'medium', 'high', 'medium', 40, 39, 42, 'routeC'),
(72, 81, 80, 'high', 'high', 'low', 41, 48, 45, 'routeC'),
(72, 81, 80, 'high', 'low', 'high', 31, 40, 41, 'routeB'),
(72, 81, 80, 'low', 'low', 'medium', 29, 35, 37, 'routeB'),
(72, 81, 80, 'medium', 'medium', 'low', 30, 41, 38, 'routeC'),
(72, 81, 80, 'high', 'high', 'low', 39, 26, 31, 'routeA'),
(72, 81, 80, 'medium', 'medium', 'high', 30, 47, 36, 'routeB'),
(72, 81, 80, 'high', 'high', 'low', 32, 41, 50, 'routeC'),
(72, 81, 80, 'low', 'medium', 'low', 50, 38, 32, 'routeA'),
(72, 81, 80, 'medium', 'low', 'high', 47, 39, 45, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 31, 37, 40, 'routeB'),
(72, 81, 80, 'high', 'high', 'low', 50, 32, 43, 'routeA'),
(72, 81, 80, 'medium', 'low', 'low', 32, 28, 35, 'routeC'),
(72, 81, 80, 'low', 'low', 'high', 48, 31, 43, 'routeA'),
(72, 81, 80, 'medium', 'high', 'medium', 27, 37, 33, 'routeC'),
(72, 81, 80, 'low', 'medium', 'low', 31, 48, 36, 'routeB'),
(72, 81, 80, 'medium', 'low', 'low', 46, 32, 40, 'routeA'),
(72, 81, 80, 'low', 'high', 'low', 32, 43, 37, 'routeC'),
(72, 81, 80, 'high', 'low', 'medium', 50, 34, 43, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 35, 32, 45, 'routeC'),
(72, 81, 80, 'medium', 'medium', 'high', 41, 47, 33, 'routeB'),
(72, 81, 80, 'high', 'medium', 'low', 50, 43, 39, 'routeA'),
(72, 81, 80, 'medium', 'high', 'high', 41, 46, 38, 'routeA'),
(72, 81, 80, 'low', 'medium', 'low', 29, 33, 22, 'routeA'),
(72, 81, 80, 'high', 'medium', 'high', 39, 43, 27, 'routeB'),
(72, 81, 80, 'medium', 'medium', 'low', 42, 25, 34, 'routeA'),
(72, 81, 80, 'high', 'high', 'low', 50, 32, 44, 'routeC'),
(72, 81, 80, 'low', 'low', 'medium', 31, 27, 40, 'routeC'),
(72, 81, 80, 'low', 'low', 'medium', 31, 27, 40, 'routeC'),
(72, 81, 80, 'medium', 'low', 'low', 29, 22, 36, 'routeC'),
(72, 81, 80, 'high', 'high', 'medium', 44, 33, 27, 'routeA'),
(72, 81, 80, 'low', 'low', 'high', 32, 41, 23, 'routeB'),
(72, 81, 80, 'medium', 'low', 'high', 42, 31, 33, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 33, 35, 37, 'routeB'),
(72, 81, 80, 'high', 'medium', 'low', 31, 32, 31, 'routeC'),
(72, 81, 80, 'low', 'high', 'high', 42, 44, 47, 'routeA'),
(72, 81, 80, 'medium', 'low', 'medium', 46, 39, 45, 'routeA'),
(72, 81, 80, 'low', 'low', 'medium', 50, 38, 44, 'routeA'),
(72, 81, 80, 'high', 'medium', 'low', 40, 31, 36, 'routeC'),
(72, 81, 80, 'medium', 'high', 'high', 37, 39, 31, 'routeA'),
(72, 81, 80, 'low', 'low', 'high', 38, 43, 40, 'routeB'),
(72, 81, 80, 'low', 'medium', 'low', 38, 41, 27, 'routeA'),
(72, 81, 80, 'high', 'medium', 'low', 29, 27, 25, 'routeC'),
(72, 81, 80, 'low', 'medium', 'high', 50, 47, 38, 'routeA'),
(72, 81, 80, 'high', 'low', 'low', 48, 45, 39, 'routeB'),
(72, 81, 80, 'low', 'high', 'high', 39, 43, 34, 'routeA'),
(72, 81, 80, 'low', 'medium', 'low', 50, 47, 28, 'routeA'),
(72, 81, 80, 'medium', 'low', 'low', 43, 42, 36, 'routeB'),
(72, 81, 80, 'low', 'low', 'low', 22, 27, 26, 'routeB'),
(72, 81, 80, 'low', 'medium', 'medium', 37, 35, 29, 'routeA'),
(72, 81, 80, 'medium', 'high', 'high', 49, 38, 44, 'routeA'),
(72, 81, 80, 'medium', 'medium', 'high', 33, 37, 42, 'routeC'),
(72, 81, 80, 'low', 'low', 'high', 40, 36, 43, 'routeA'),
(72, 81, 80, 'low', 'medium', 'medium', 32, 25, 34, 'routeA'),
(72, 81, 80, 'high', 'high', 'low', 34, 41, 35, 'routeC'),
(72, 81, 80, 'low', 'medium', 'medium', 37, 40, 41, 'routeA'),
(72, 81, 80, 'medium', 'high', 'low', 31, 43, 40, 'routeC'),
(72, 81, 80, 'high', 'medium', 'high', 37, 35, 33, 'routeB'),
(72, 81, 80, 'low', 'low', 'high', 43, 29, 50, 'routeA'),
(72, 81, 80, 'medium', 'high', 'medium', 47, 50, 48, 'routeA'),
(72, 81, 80, 'high', 'medium', 'low', 28, 23, 25, 'routeC'),
(72, 81, 80, 'low', 'low', 'high', 21, 27, 29, 'routeB'),
(72, 81, 80, 'medium', 'low', 'medium', 31, 29, 34, 'routeC'),
(72, 81, 80, 'high', 'medium', 'high', 37, 34, 35, 'routeA'),
(72, 81, 80, 'low', 'low', 'high', 28, 25, 30, 'routeB'),
(72, 81, 80, 'medium', 'medium', 'low', 31, 42, 40, 'routeC'),
(72, 81, 80, 'low', 'medium', 'low', 42, 45, 31, 'routeA'),
(72, 81, 80, 'high', 'low', 'medium', 24, 20, 21, 'routeB'),
(72, 81, 80, 'low', 'medium', 'low', 39, 43, 32, 'routeA'),
(72, 81, 80, 'high', 'high', 'medium', 42, 33, 44, 'routeC');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `active` bit(1) NOT NULL,
  `blocked` bit(1) NOT NULL,
  `approved` bit(1) NOT NULL,
  `levelOfAccess` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `active`, `blocked`, `approved`, `levelOfAccess`) VALUES
(3, 'raja.isssmail@gmail.com', 'raja.isssmail@gmail.com', 'raja.isssmail@gmail.com', b'1', b'0', b'0', 3),
(4, 'test', 'hayssam', 'ahsuasf', b'1', b'0', b'0', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`userId`),
  ADD KEY `locationId` (`locationId`);

--
-- Indexes for table `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `busonlineactivity`
--
ALTER TABLE `busonlineactivity`
  ADD KEY `busId` (`busId`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `LocationId` (`LocationId`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `relationdriverbus`
--
ALTER TABLE `relationdriverbus`
  ADD KEY `idBus` (`idBus`),
  ADD KEY `idDriver` (`idDriver`);

--
-- Indexes for table `relationroutesstoppoint`
--
ALTER TABLE `relationroutesstoppoint`
  ADD KEY `routeId` (`routeId`),
  ADD KEY `stopPointId` (`stopPointId`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stoppoint`
--
ALTER TABLE `stoppoint`
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
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bus`
--
ALTER TABLE `bus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver`
--
ALTER TABLE `driver`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stoppoint`
--
ALTER TABLE `stoppoint`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`locationId`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `busonlineactivity`
--
ALTER TABLE `busonlineactivity`
  ADD CONSTRAINT `busonlineactivity_ibfk_1` FOREIGN KEY (`busId`) REFERENCES `bus` (`id`);

--
-- Constraints for table `driver`
--
ALTER TABLE `driver`
  ADD CONSTRAINT `driver_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`LocationId`) REFERENCES `locations` (`id`),
  ADD CONSTRAINT `history_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `relationdriverbus`
--
ALTER TABLE `relationdriverbus`
  ADD CONSTRAINT `relationdriverbus_ibfk_1` FOREIGN KEY (`idBus`) REFERENCES `bus` (`id`),
  ADD CONSTRAINT `relationdriverbus_ibfk_2` FOREIGN KEY (`idDriver`) REFERENCES `driver` (`id`);

--
-- Constraints for table `relationroutesstoppoint`
--
ALTER TABLE `relationroutesstoppoint`
  ADD CONSTRAINT `relationroutesstoppoint_ibfk_1` FOREIGN KEY (`routeId`) REFERENCES `route` (`id`),
  ADD CONSTRAINT `relationroutesstoppoint_ibfk_2` FOREIGN KEY (`stopPointId`) REFERENCES `stoppoint` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-04-2018 a las 13:06:44
-- Versión del servidor: 10.1.31-MariaDB
-- Versión de PHP: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

CREATE SCHEMA IF NOT EXISTS condor;
USE condor;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `condor`
--

-- --------------------------------------------------------

--
-- Table structure for the table `user_address`
--

CREATE TABLE `user_address` (
  `id_address` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump of data for the table `user_address`
--

INSERT INTO `user_address` (`id_address`, `id_user`) VALUES
(23, 1),
(33, 1),
(345, 1),
(45, 2),
(65, 2);

-- --------------------------------------------------------

--
-- Table structure for the table `user_profile`
--

CREATE TABLE `user_profile` (
  `id_user` int(11) NOT NULL,
  `nm_first` varchar(30) DEFAULT NULL,
  `nm_middle` varchar(100) DEFAULT NULL,
  `nm_last` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump of data for the table `user_profile`
--

INSERT INTO `user_profile` (`id_user`, `nm_first`, `nm_middle`, `nm_last`) VALUES
(1, 'astrid', 'A', NULL),
(2, NULL, 'B', 'berlin');

-- --------------------------------------------------------

--
-- Table structure for the table `user_role`
--

CREATE TABLE `user_role` (
  `id_user` int(11) NOT NULL,
  `cd_role_type` varchar(20) NOT NULL,
  `id_entity` varchar(20) NOT NULL,
  `in_status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump of data for the table `user_role`
--

INSERT INTO `user_role` (`id_user`, `cd_role_type`, `id_entity`, `in_status`) VALUES
(1, 'LICENSEE', '', 0),
(1, 'LIMITED', '', 1);

--
-- Indexes for overturned tables
--

--
-- Indexes of the table `user_address`
--
ALTER TABLE `user_address`
  ADD PRIMARY KEY (`id_address`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes of the table `user_profile`
--
ALTER TABLE `user_profile`
  ADD PRIMARY KEY (`id_user`);

--
-- IIndexes of the table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`cd_role_type`),
  ADD KEY `id_user` (`id_user`);

--
-- Restrictions for overturned tables
--

--
-- Filters for the table `user_address`
--
ALTER TABLE `user_address`
  ADD CONSTRAINT `user_address_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_profile` (`id_user`);

--
-- Filters for the table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_profile` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

/*  QUERY 1 - 

  select
	user_role.cd_role_type as tipo_usuario,
    total_activos,
    user_profile.nm_last as sin_segundo_nombre
  from
	(select id_user, SUM(if(nm_last is null, 1, 0)) as cnt from user_profile group by id_user) as users,
	
    (select cd_role_type, count(id_user) as cnt from user_role where user_role.in_stats = 1 group by cd_role_type) as cnt_activos
  where
	user_role.in_stats = 1  and
    user_role.id_user = user_profile.id_user and
    total_activos.cd_role_type = user_role.cd_role_type
group by user_role.cd_role_type, sin_segundo_nombre
*/


/*          QUERY 2 - Active Licensees With Address Info

    select count(distinct user_role.id_user) as "Licenciatarios activos con informacion de direccion" 
    from user_role, user_address 
    where user_role.cd_role_type = "LICENSEE" or user_role.cd_role_type = "LIMITED" 
          and user_address.id_user = user_role.id_user 
          and user_address.id_address is not null
*/;

/*        QUERY 3 - Non-active Providers

    select count(user_profile.id_user) as "Proveedores no activos" 
    from user_profile, user_role 
    where (user_profile.id_user=user_role.id_user 
            and user_role.cd_role_type="PROVIDER" 
            and user_role.in_status=0)
*/;
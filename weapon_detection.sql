-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 23, 2023 at 01:18 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `weapon_detection`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add image analysis model', 7, 'add_imageanalysismodel'),
(26, 'Can change image analysis model', 7, 'change_imageanalysismodel'),
(27, 'Can delete image analysis model', 7, 'delete_imageanalysismodel'),
(28, 'Can view image analysis model', 7, 'view_imageanalysismodel'),
(29, 'Can add user model', 8, 'add_usermodel'),
(30, 'Can change user model', 8, 'change_usermodel'),
(31, 'Can delete user model', 8, 'delete_usermodel'),
(32, 'Can view user model', 8, 'view_usermodel');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'userapp', 'imageanalysismodel'),
(8, 'userapp', 'usermodel');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-01-23 05:41:30.057348'),
(2, 'auth', '0001_initial', '2023-01-23 05:41:30.538222'),
(3, 'admin', '0001_initial', '2023-01-23 05:41:30.680133'),
(4, 'admin', '0002_logentry_remove_auto_add', '2023-01-23 05:41:30.696126'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-01-23 05:41:30.717111'),
(6, 'contenttypes', '0002_remove_content_type_name', '2023-01-23 05:41:30.813051'),
(7, 'auth', '0002_alter_permission_name_max_length', '2023-01-23 05:41:30.857024'),
(8, 'auth', '0003_alter_user_email_max_length', '2023-01-23 05:41:30.913989'),
(9, 'auth', '0004_alter_user_username_opts', '2023-01-23 05:41:30.928979'),
(10, 'auth', '0005_alter_user_last_login_null', '2023-01-23 05:41:30.990941'),
(11, 'auth', '0006_require_contenttypes_0002', '2023-01-23 05:41:30.997937'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2023-01-23 05:41:31.013926'),
(13, 'auth', '0008_alter_user_username_max_length', '2023-01-23 05:41:31.066894'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2023-01-23 05:41:31.118863'),
(15, 'auth', '0010_alter_group_name_max_length', '2023-01-23 05:41:31.167831'),
(16, 'auth', '0011_update_proxy_permissions', '2023-01-23 05:41:31.184822'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2023-01-23 05:41:31.241786'),
(18, 'sessions', '0001_initial', '2023-01-23 05:41:31.310857'),
(19, 'userapp', '0001_initial', '2023-01-23 05:41:31.359827');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('zdj0ydntolm0e1n7luzecz4dzokudvjk', 'eyJ1c2VyX2lkIjoxfQ:1pJtkm:ByZdAH8UJr8YIINp353mDC22BrD3UHCdpB444uujvq0', '2023-02-06 10:08:40.084470'),
('r6lkk2r53zwcmb4v4af6teswlquva9qm', 'eyJ1c2VyX2lkIjoxfQ:1pJwKn:MF3lSLxQauOHZiIQR7Vk7hubhEJshgG9Ul2qKQZ1rFM', '2023-02-06 12:54:01.867120');

-- --------------------------------------------------------

--
-- Table structure for table `image_analysis`
--

DROP TABLE IF EXISTS `image_analysis`;
CREATE TABLE IF NOT EXISTS `image_analysis` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `upload_image` varchar(100) DEFAULT NULL,
  `modified_image` varchar(100) DEFAULT NULL,
  `upload_video` varchar(100) DEFAULT NULL,
  `labels` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `image_analysis`
--

INSERT INTO `image_analysis` (`id`, `upload_image`, `modified_image`, `upload_video`, `labels`) VALUES
(1, 'uploads/front-view-young-soldier-camouflage-with-gun-white-wall.jpg', 'modified/image7222.jpg', '', NULL),
(2, 'uploads/800px_COLOURBOX27963277.jpg', 'modified/image5564.jpg', '', NULL),
(3, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429.jpg', 'modified/image7644.jpg', '', NULL),
(4, 'uploads/800px_COLOURBOX11474701.jpg', 'modified/image3882.jpg', '', NULL),
(5, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_vY0ol1m.jpg', 'modified/image1875.jpg', '', NULL),
(6, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_0BfDC0W.jpg', 'modified/image8317.jpg', '', NULL),
(7, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_E02ST1g.jpg', 'modified/image9882.jpg', '', NULL),
(8, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_hSp4EOg.jpg', 'modified/image7251.jpg', '', NULL),
(9, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_p4dP2Nx.jpg', 'modified/image6858.jpg', '', NULL),
(10, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_68zsFUx.jpg', 'modified/image6057.jpg', '', NULL),
(11, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_FH89kaD.jpg', 'modified/image265.jpg', '', NULL),
(12, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_4xsbOVW.jpg', 'modified/image4747.jpg', '', NULL),
(13, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_2HFsBXw.jpg', 'modified/image2186.jpg', '', NULL),
(14, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_o5eYhDl.jpg', 'modified/image6887.jpg', '', NULL),
(15, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_M0L8EPj.jpg', 'modified/image4345.jpg', '', NULL),
(16, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_cb53L9m.jpg', 'modified/image9990.jpg', '', NULL),
(17, 'uploads/gun.mp4', '', '', NULL),
(18, '', '', 'uploads/videos/gun.mp4', NULL),
(19, '', '', 'uploads/videos/bike_racing__reading_so_have_bike_stunts_public_place.mp4', NULL),
(20, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_yZrUNYj.jpg', 'modified/image4414.jpg', '', NULL),
(21, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_9WUFnXg.jpg', 'modified/image8974.jpg', '', NULL),
(22, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_dAc7yqB.jpg', 'modified/image9165.jpg', '', NULL),
(23, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_k8J0cXC.jpg', 'modified/image8684.jpg', '', NULL),
(24, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_GcKk6rY.jpg', 'modified/image1784.jpg', '', NULL),
(25, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_VYkM9h7.jpg', 'modified/image7695.jpg', '', NULL),
(26, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_EoFGuye.jpg', 'modified/image3040.jpg', '', NULL),
(27, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_XyD0ITt.jpg', 'modified/image321.jpg', '', NULL),
(28, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_TImydsw.jpg', 'modified/image3311.jpg', '', NULL),
(29, '', '', 'uploads/videos/gun_Trim.mp4', NULL),
(30, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_g8i8Kiu.jpg', 'modified/image9195.jpg', '', NULL),
(31, '', '', 'uploads/videos/gun_Trim_AHSCRu3.mp4', NULL),
(32, 'uploads/stock-photo-masked-man-bomber-aims-with-hand-grenade-127478429_9sgdKX1.jpg', 'modified/image4017.jpg', '', NULL),
(33, '', '', 'uploads/videos/gun_Trim_oG01Nuh.mp4', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
CREATE TABLE IF NOT EXISTS `user_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `mobile` varchar(12) NOT NULL,
  `city` varchar(100) NOT NULL,
  `picture` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`id`, `name`, `email`, `mobile`, `city`, `picture`, `password`) VALUES
(1, 'tanmay', 'tanmay@email.com', '8686238308', 'Hyderabad', 'images/nani.jpg', '12');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

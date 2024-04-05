-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for bookshopdb
CREATE DATABASE IF NOT EXISTS `bookshopdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `bookshopdb`;

-- Dumping structure for table bookshopdb.address
CREATE TABLE IF NOT EXISTS `address` (
  `id` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `houseNumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.address: ~2 rows (approximately)
INSERT INTO `address` (`id`, `userId`, `houseNumber`) VALUES
	(1, 1, '43'),
	(2, 1, '45');

-- Dumping structure for table bookshopdb.cart
CREATE TABLE IF NOT EXISTS `cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_cart_user` (`userId`),
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.cart: ~7 rows (approximately)
INSERT INTO `cart` (`id`, `userId`, `createdAt`, `updatedAt`) VALUES
	(1, 4, '2021-12-30 08:39:19', NULL),
	(2, 5, '2021-12-18 13:35:59', NULL),
	(4, 6, '2024-03-24 12:04:34', NULL),
	(5, 1, '2024-04-04 14:08:47', NULL),
	(6, 1, '2024-04-04 14:11:38', NULL),
	(7, 1, '2024-04-04 14:25:35', NULL),
	(8, 1, '2024-04-04 15:40:17', NULL),
	(9, 1712310114373, '2024-04-05 09:41:52', NULL);

-- Dumping structure for table bookshopdb.cart_item
CREATE TABLE IF NOT EXISTS `cart_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cartId` bigint(20) NOT NULL,
  `productId` bigint(20) NOT NULL,
  `quantity` smallint(6) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_cartId_productId` (`cartId`,`productId`),
  KEY `idx_cart_item_cart` (`cartId`),
  KEY `idx_cart_item_product` (`productId`),
  CONSTRAINT `fk_cart_item_cart` FOREIGN KEY (`cartId`) REFERENCES `cart` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_item_product` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.cart_item: ~14 rows (approximately)
INSERT INTO `cart_item` (`id`, `cartId`, `productId`, `quantity`, `createdAt`, `updatedAt`) VALUES
	(1, 2, 55, 3, '2021-07-13 03:21:51', NULL),
	(2, 2, 36, 2, '2021-07-05 00:21:45', NULL),
	(3, 6, 7, 3, '2024-04-04 15:22:54', NULL),
	(4, 6, 70, 2, '2024-04-04 15:22:53', NULL),
	(6, 6, 27, 4, '2024-04-04 15:22:36', NULL),
	(7, 1, 19, 1, '2024-04-04 15:22:28', NULL),
	(12, 1, 36, 1, '2024-04-04 14:11:38', NULL),
	(13, 1, 57, 1, '2024-04-04 14:25:35', NULL),
	(14, 1, 73, 1, '2024-04-04 15:40:17', NULL),
	(15, 5, 22, 2, '2024-04-05 05:02:01', '2024-04-05 05:02:01'),
	(16, 1, 99, 1, '2024-04-05 09:41:52', NULL),
	(17, 9, 78, 1, '2024-04-05 09:42:01', NULL),
	(18, 9, 41, 1, '2024-04-05 09:42:09', NULL),
	(19, 9, 36, 1, '2024-04-05 09:42:14', NULL),
	(20, 5, 99, 1, '2024-04-05 15:02:10', NULL);

-- Dumping structure for table bookshopdb.category
CREATE TABLE IF NOT EXISTS `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `imageName` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.category: ~15 rows (approximately)
INSERT INTO `category` (`id`, `name`, `description`, `imageName`) VALUES
	(1, 'Sách giáo khoa', 'Cillum nulla non Lorem ut irure fugiat veniam deserunt do.', 'sach-giao-khoa.jpg'),
	(2, 'Sách khoa học', 'Aliqua exercitation ea sint do.', 'sach-khoa-hoc.png'),
	(3, 'Truyện tranh', 'Cillum laboris et nulla nostrud duis consectetur labore cupidatat minim proident.', 'truyen-tranh.png'),
	(4, 'Tiểu thuyết', 'Enim dolore cupidatat tempor sunt amet veniam aute officia est officia.', 'tieu-thuyet.png'),
	(5, 'Truyện ngắn', 'Dolor in pariatur aliqua dolore ea cillum ut consectetur tempor do eu incididunt est.', 'truyen-ngan.png'),
	(6, 'Truyện dài', 'Eiusmod adipisicing consectetur occaecat culpa in ullamco labore velit magna.', 'truyen-dai.png'),
	(7, 'Sách giáo trình', 'In officia ex magna commodo ullamco in magna incididunt esse mollit enim consectetur laboris.', 'sach-giao-trinh.png'),
	(8, 'Báo in', 'Laborum in elit ullamco pariatur laborum magna veniam nostrud eu anim irure deserunt ad sunt.', 'bao-in.png'),
	(9, 'Tạp chí', 'Excepteur qui commodo sint sint irure sunt sunt in nostrud.', 'tap-chi.png'),
	(10, 'Tập san', 'Elit amet proident et cupidatat in eu quis velit tempor sunt labore aute et.', 'tap-san.png'),
	(11, 'Sách nấu ăn', 'Consequat anim officia aute eiusmod dolor.', 'nau-an.png'),
	(12, 'Sách kỹ thuật', 'Veniam pariatur deserunt ea non voluptate sunt do culpa elit esse.', 'sach-ky-thuat.png'),
	(13, 'Sách nông nghiệp', 'Minim deserunt aute ipsum duis ea eiusmod aute sint sint ut.', 'sach-nong-nghiep.png'),
	(14, 'Sách thiếu nhi', 'Ex eu ad adipisicing magna tempor occaecat id cupidatat dolor dolor aliquip dolore.', 'sach-thieu-nhi.png'),
	(15, 'Sách kỹ năng sống', 'Ad exercitation anim in magna qui ipsum ipsum proident magna.', 'sach-ky-nang-song.png');

-- Dumping structure for table bookshopdb.district
CREATE TABLE IF NOT EXISTS `district` (
  `id` bigint(20) NOT NULL,
  `addressId` bigint(20) NOT NULL,
  `districtName` varchar(255) DEFAULT NULL,
  `districtCode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`addressId`),
  KEY `addressId` (`addressId`),
  CONSTRAINT `district_ibfk_1` FOREIGN KEY (`addressId`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.district: ~2 rows (approximately)
INSERT INTO `district` (`id`, `addressId`, `districtName`, `districtCode`) VALUES
	(1, 1, 'Thu Duc', 'TD'),
	(2, 2, 'HN', 'HN');

-- Dumping structure for table bookshopdb.google_user
CREATE TABLE IF NOT EXISTS `google_user` (
  `email` varchar(255) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `userId` (`userId`),
  CONSTRAINT `google_user_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.google_user: ~2 rows (approximately)
INSERT INTO `google_user` (`email`, `userId`) VALUES
	('timkodctk3@gmail.com', 1712310114373),
	('kotimdctk@gmail.com', 1712310499043);

-- Dumping structure for table bookshopdb.log
CREATE TABLE IF NOT EXISTS `log` (
  `id` bigint(20) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `levelLog` int(11) DEFAULT NULL,
  `res` varchar(255) DEFAULT NULL,
  `preValue` text DEFAULT NULL,
  `curValue` text DEFAULT NULL,
  `createAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updateAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.log: ~27 rows (approximately)
INSERT INTO `log` (`id`, `ip`, `levelLog`, `res`, `preValue`, `curValue`, `createAt`, `updateAt`) VALUES
	(1711553190592, '123123', 3, 'Update on table User', '{"id":10,"username":"hiu","password":"111","fullname":"Quang Hieu","email":"","phoneNumber":"123123123","gender":1,"address":"","role":"","createAt":"Mar 27, 2024, 10:25:59 PM"}', '{"id":10,"username":"hiu","password":"111","fullname":"Quang Hieu","email":"","phoneNumber":"123123123","gender":1,"address":"","role":""}', '2024-03-27 15:25:59', '2024-03-27 15:25:59'),
	(1712239775554, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":1,"productId":19,"quantity":1,"createdAt":"Apr 4, 2024, 9:08:47 PM"}', '2024-04-04 14:08:47', '2024-04-04 14:08:47'),
	(1712239818538, '', 2, 'Insert on table Cart', 'null', '{"id":0,"userId":1,"createdAt":"Apr 4, 2024, 9:08:47 PM","listCartItem":[]}', '2024-04-04 14:08:47', '2024-04-04 14:08:47'),
	(1712239928162, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":1,"productId":36,"quantity":1,"createdAt":"Apr 4, 2024, 9:11:38 PM"}', '2024-04-04 14:11:38', '2024-04-04 14:11:38'),
	(1712239959150, '', 2, 'Insert on table Cart', 'null', '{"id":0,"userId":1,"createdAt":"Apr 4, 2024, 9:11:38 PM","listCartItem":[]}', '2024-04-04 14:11:38', '2024-04-04 14:11:38'),
	(1712240765989, '', 2, 'Insert on table Cart', 'null', '{"id":0,"userId":1,"createdAt":"Apr 4, 2024, 9:25:35 PM","listCartItem":[]}', '2024-04-04 14:25:35', '2024-04-04 14:25:35'),
	(1712240778997, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":1,"productId":57,"quantity":1,"createdAt":"Apr 4, 2024, 9:25:35 PM"}', '2024-04-04 14:25:35', '2024-04-04 14:25:35'),
	(1712245224320, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":1,"productId":73,"quantity":1,"createdAt":"Apr 4, 2024, 10:40:17 PM"}', '2024-04-04 15:40:17', '2024-04-04 15:40:17'),
	(1712245275306, '', 2, 'Insert on table Cart', 'null', '{"id":0,"userId":1,"createdAt":"Apr 4, 2024, 10:40:17 PM","listCartItem":[]}', '2024-04-04 15:40:17', '2024-04-04 15:40:17'),
	(1712292202175, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":5,"productId":22,"quantity":1,"createdAt":"Apr 5, 2024, 11:42:40 AM"}', '2024-04-05 04:42:40', '2024-04-05 04:42:40'),
	(1712292205928, '', 2, 'Insert on table ProductReview', 'null', '{"id":0,"userId":1,"productId":36,"ratingScore":3,"content":"123333333333333333","isShow":1,"createdAt":"Apr 5, 2024, 11:41:50 AM"}', '2024-04-05 04:41:50', '2024-04-05 04:41:50'),
	(1712292206015, '', 2, 'Insert on table ProductReview', 'null', '{"id":0,"userId":1,"productId":55,"ratingScore":4,"content":"sssssssssss","isShow":1,"createdAt":"Apr 5, 2024, 11:42:29 AM"}', '2024-04-05 04:42:29', '2024-04-05 04:42:29'),
	(1712293250668, '', 2, 'Insert on table WishListItem', 'null', '{"id":0,"userId":1,"productId":77}', '2024-04-05 05:00:24', '2024-04-05 05:00:24'),
	(1712293277197, '', 2, 'Insert on table WishListItem', 'null', '{"id":0,"userId":1,"productId":77}', '2024-04-05 05:00:26', '2024-04-05 05:00:26'),
	(1712293302777, '', 2, 'Insert on table WishListItem', 'null', '{"id":0,"userId":1,"productId":77}', '2024-04-05 05:00:25', '2024-04-05 05:00:25'),
	(1712293311347, '', 2, 'Insert on table WishListItem', 'null', '{"id":0,"userId":1,"productId":77}', '2024-04-05 05:00:26', '2024-04-05 05:00:26'),
	(1712293407771, '', 3, 'Update on table CartItem', '{"id":15,"cartId":5,"productId":22,"quantity":1,"createdAt":"Apr 5, 2024, 11:42:40 AM"}', '{"id":15,"cartId":5,"productId":22,"quantity":2,"createdAt":"Apr 5, 2024, 11:42:40 AM","updatedAt":"Apr 5, 2024, 12:02:01 PM","product":{"id":22,"name":"Sách Inquala","price":116529.0,"discount":0.0,"quantity":11,"totalBuy":367,"author":"Hilda Crane","pages":238,"publisher":"NXB Đại học Quốc gia Hà Nội","yearPublishing":1998,"description":"Esse ipsum minim voluptate consectetur exercitation dolor. Ex ut anim ad elit non consequat cupidatat anim minim est elit in deserunt Lorem. Est duis minim consectetur sunt duis non.\\r\\nLorem labore proident laborum consequat officia commodo reprehenderit ad Lorem minim incididunt aute in esse. Ex eiusmod ut eiusmod mollit consectetur qui enim sit labore Lorem reprehenderit enim consectetur. Nisi anim veniam sint tempor fugiat pariatur in est sint excepteur.\\r\\n","imageName":"temp-12235989262213754276.jpg","shop":1,"createdAt":"Jan 24, 2022, 8:00:39 AM"}}', '2024-04-05 04:42:40', '2024-04-05 05:02:01'),
	(1712293672632, '', 2, 'Insert on table WishListItem', 'null', '{"id":0,"userId":1,"productId":57}', '2024-04-05 05:07:42', '2024-04-05 05:07:42'),
	(1712293855053, '', 2, 'Insert on table WishListItem', 'null', '{"id":0,"userId":1,"productId":22}', '2024-04-05 05:10:46', '2024-04-05 05:10:46'),
	(1712294369850, '', 2, 'Insert on table ProductReview', 'null', '{"id":0,"userId":1,"productId":78,"ratingScore":2,"content":"sddddddđs3wwd","isShow":1,"createdAt":"Apr 5, 2024, 12:18:58 PM"}', '2024-04-05 05:18:58', '2024-04-05 05:18:58'),
	(1712295022603, '', 2, 'Insert on table ProductReview', 'null', '{"id":0,"userId":1,"productId":22,"ratingScore":3,"content":"11111111111111111111111111","isShow":1,"createdAt":"Apr 5, 2024, 12:29:18 PM"}', '2024-04-05 05:29:18', '2024-04-05 05:29:18'),
	(1712296074822, '', 2, 'Insert on table ProductReview', 'null', '{"id":0,"userId":1,"productId":93,"ratingScore":4,"content":"sddddddddddddddđ","isShow":1,"createdAt":"Apr 5, 2024, 12:46:37 PM"}', '2024-04-05 05:46:37', '2024-04-05 05:46:37'),
	(1712309964811, '', 2, 'Insert on table User', 'null', '{"id":0,"fullname":"Hiếu Ngô Quang","email":"timkodctk3@gmail.com","gender":0,"role":"CUSTOMER"}', '2024-04-05 09:38:05', '2024-04-05 09:38:05'),
	(1712310128446, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":1,"productId":99,"quantity":1,"createdAt":"Apr 5, 2024, 4:41:52 PM"}', '2024-04-05 09:41:52', '2024-04-05 09:41:52'),
	(1712310130441, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":9,"productId":78,"quantity":1,"createdAt":"Apr 5, 2024, 4:42:01 PM"}', '2024-04-05 09:42:01', '2024-04-05 09:42:01'),
	(1712310171399, '', 2, 'Insert on table User', 'null', '{"id":1712310114373,"fullname":"Hiếu Ngô Quang","email":"timkodctk3@gmail.com","gender":0,"role":"CUSTOMER"}', '2024-04-05 09:41:34', '2024-04-05 09:41:34'),
	(1712310180436, '', 2, 'Insert on table Cart', 'null', '{"id":0,"userId":1712310114373,"createdAt":"Apr 5, 2024, 4:41:52 PM","listCartItem":[]}', '2024-04-05 09:41:52', '2024-04-05 09:41:52'),
	(1712310193062, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":9,"productId":41,"quantity":1,"createdAt":"Apr 5, 2024, 4:42:09 PM"}', '2024-04-05 09:42:09', '2024-04-05 09:42:09'),
	(1712310199695, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":9,"productId":36,"quantity":1,"createdAt":"Apr 5, 2024, 4:42:14 PM"}', '2024-04-05 09:42:14', '2024-04-05 09:42:14'),
	(1712310496064, '', 2, 'Insert on table User', 'null', '{"id":1712310499043,"fullname":"Thư Lê","email":"kotimdctk@gmail.com","gender":0,"role":"CUSTOMER"}', '2024-04-05 09:48:09', '2024-04-05 09:48:09'),
	(1712329381599, '', 2, 'Insert on table CartItem', 'null', '{"id":0,"cartId":5,"productId":99,"quantity":1,"createdAt":"Apr 5, 2024, 10:02:10 PM"}', '2024-04-05 15:02:10', '2024-04-05 15:02:10');

-- Dumping structure for table bookshopdb.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `deliveryMethod` tinyint(4) NOT NULL,
  `deliveryPrice` double NOT NULL DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_orders_user` (`userId`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.orders: ~26 rows (approximately)
INSERT INTO `orders` (`id`, `userId`, `status`, `deliveryMethod`, `deliveryPrice`, `createdAt`, `updatedAt`) VALUES
	(1, 4, 3, 1, 10000, '2021-12-01 01:34:38', NULL),
	(2, 5, 2, 2, 50000, '2021-07-05 03:52:51', NULL),
	(3, 4, 1, 1, 10000, '2021-10-11 02:15:13', NULL),
	(4, 5, 3, 2, 50000, '2022-01-06 08:05:11', NULL),
	(5, 4, 2, 1, 10000, '2021-09-25 07:06:36', NULL),
	(6, 4, 3, 2, 50000, '2021-09-17 19:22:12', NULL),
	(7, 5, 1, 1, 10000, '2021-04-08 08:13:25', NULL),
	(8, 4, 3, 2, 50000, '2021-04-06 15:47:57', NULL),
	(9, 5, 3, 1, 10000, '2021-04-03 04:40:27', NULL),
	(10, 4, 2, 2, 50000, '2021-10-22 08:49:15', NULL),
	(11, 5, 2, 1, 10000, '2021-03-28 18:04:10', NULL),
	(12, 4, 2, 2, 50000, '2021-06-11 08:01:12', NULL),
	(13, 4, 3, 1, 10000, '2021-03-09 21:45:49', NULL),
	(14, 5, 1, 2, 50000, '2021-12-06 04:32:16', NULL),
	(15, 4, 3, 1, 10000, '2021-07-01 00:11:33', NULL),
	(16, 5, 3, 2, 50000, '2021-10-24 10:39:58', NULL),
	(17, 4, 1, 1, 10000, '2021-02-17 12:18:55', NULL),
	(18, 4, 3, 2, 50000, '2021-09-11 17:13:50', NULL),
	(19, 4, 2, 1, 10000, '2021-02-18 04:26:18', NULL),
	(20, 5, 1, 2, 50000, '2021-04-11 19:25:34', NULL),
	(21, 4, 1, 1, 10000, '2021-12-17 01:21:32', NULL),
	(22, 5, 1, 2, 50000, '2022-01-28 09:19:00', NULL),
	(23, 4, 1, 1, 10000, '2021-04-14 02:36:21', NULL),
	(24, 5, 1, 2, 50000, '2021-04-05 12:56:13', NULL),
	(25, 4, 2, 1, 10000, '2021-12-08 10:07:23', NULL),
	(26, 6, 1, 1, 15000, '2024-03-24 09:55:53', NULL);

-- Dumping structure for table bookshopdb.order_item
CREATE TABLE IF NOT EXISTS `order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderId` bigint(20) NOT NULL,
  `productId` bigint(20) NOT NULL,
  `price` double NOT NULL DEFAULT 0,
  `discount` double NOT NULL DEFAULT 0,
  `quantity` smallint(6) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_item_orders` (`orderId`),
  KEY `idx_order_item_product` (`productId`),
  CONSTRAINT `fk_order_item_orders` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_item_product` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.order_item: ~61 rows (approximately)
INSERT INTO `order_item` (`id`, `orderId`, `productId`, `price`, `discount`, `quantity`, `createdAt`, `updatedAt`) VALUES
	(1, 1, 78, 286587, 0, 4, '2021-06-26 20:11:05', NULL),
	(2, 2, 21, 29619, 0, 2, '2021-03-26 03:39:47', NULL),
	(3, 3, 69, 299814, 0, 4, '2021-07-31 05:54:03', NULL),
	(4, 4, 2, 181582, 0, 5, '2021-07-15 04:58:11', NULL),
	(5, 5, 79, 355067, 20, 1, '2021-08-28 13:28:16', NULL),
	(6, 6, 41, 116744, 0, 1, '2021-04-09 02:53:33', NULL),
	(7, 7, 3, 276065, 20, 5, '2021-08-16 14:48:06', NULL),
	(8, 8, 87, 421713, 20, 5, '2021-05-15 02:36:10', NULL),
	(9, 9, 90, 480454, 20, 3, '2021-09-17 18:58:18', NULL),
	(10, 10, 82, 280519, 0, 4, '2022-01-08 12:44:56', NULL),
	(11, 11, 22, 422703, 20, 1, '2021-11-30 17:24:12', NULL),
	(12, 12, 99, 89288, 0, 4, '2021-11-14 13:04:04', NULL),
	(13, 13, 52, 192906, 0, 1, '2021-04-07 21:50:44', NULL),
	(14, 14, 84, 380080, 0, 2, '2021-03-02 03:40:10', NULL),
	(15, 15, 5, 274595, 20, 2, '2021-10-24 14:14:35', NULL),
	(16, 16, 14, 51752, 0, 2, '2021-04-02 17:40:34', NULL),
	(17, 17, 20, 61648, 20, 4, '2021-04-23 07:29:56', NULL),
	(18, 18, 42, 252357, 20, 3, '2021-07-11 23:02:37', NULL),
	(19, 19, 3, 230576, 0, 2, '2021-08-15 07:07:26', NULL),
	(20, 20, 12, 186136, 0, 5, '2021-03-10 00:43:13', NULL),
	(21, 21, 88, 237111, 0, 1, '2021-02-28 05:28:58', NULL),
	(22, 22, 17, 418046, 20, 2, '2021-09-23 22:09:52', NULL),
	(23, 23, 59, 104758, 20, 2, '2021-10-24 17:07:51', NULL),
	(24, 24, 79, 392777, 20, 4, '2021-04-01 03:27:29', NULL),
	(25, 25, 38, 51737, 20, 2, '2021-07-30 16:59:07', NULL),
	(26, 1, 17, 403668, 20, 2, '2022-01-28 14:29:04', NULL),
	(27, 2, 38, 273634, 0, 2, '2021-11-30 02:11:39', NULL),
	(28, 3, 64, 317689, 0, 3, '2021-10-26 19:40:41', NULL),
	(29, 4, 23, 462258, 0, 3, '2021-10-04 12:29:23', NULL),
	(30, 5, 11, 213435, 0, 5, '2021-09-01 04:27:24', NULL),
	(31, 6, 74, 392247, 0, 1, '2021-07-08 18:32:06', NULL),
	(32, 7, 53, 295299, 0, 5, '2021-06-08 04:39:39', NULL),
	(33, 8, 8, 20188, 0, 3, '2021-10-25 18:08:36', NULL),
	(34, 9, 100, 328695, 20, 1, '2021-05-14 07:49:13', NULL),
	(35, 10, 42, 404011, 0, 5, '2021-05-08 12:44:21', NULL),
	(36, 11, 91, 452099, 0, 3, '2021-02-14 12:16:30', NULL),
	(37, 12, 31, 80569, 0, 2, '2021-05-05 04:50:48', NULL),
	(38, 13, 66, 124475, 20, 3, '2021-10-02 13:23:16', NULL),
	(39, 14, 65, 27199, 0, 3, '2021-03-29 03:56:01', NULL),
	(40, 15, 64, 126431, 20, 5, '2021-08-12 16:40:45', NULL),
	(41, 16, 59, 214278, 0, 2, '2021-12-30 11:44:16', NULL),
	(42, 17, 86, 263745, 20, 1, '2021-12-16 04:12:31', NULL),
	(43, 18, 93, 56211, 20, 5, '2021-02-24 16:23:00', NULL),
	(44, 19, 79, 205863, 20, 3, '2021-04-20 19:42:36', NULL),
	(45, 20, 33, 31030, 0, 5, '2021-12-19 08:20:50', NULL),
	(46, 21, 59, 169677, 20, 2, '2021-09-11 04:09:16', NULL),
	(47, 22, 6, 244525, 0, 1, '2021-08-23 03:28:37', NULL),
	(48, 23, 73, 116237, 20, 4, '2021-12-14 07:20:58', NULL),
	(49, 24, 22, 258094, 0, 4, '2021-07-08 01:20:25', NULL),
	(50, 25, 82, 489571, 0, 1, '2021-06-20 02:29:40', NULL),
	(51, 1, 60, 327711, 20, 4, '2021-09-24 22:43:46', NULL),
	(52, 2, 8, 400758, 0, 5, '2021-02-20 08:50:49', NULL),
	(53, 3, 78, 216374, 20, 4, '2022-01-12 00:10:44', NULL),
	(54, 4, 46, 380038, 0, 2, '2021-04-28 12:42:30', NULL),
	(55, 5, 4, 268748, 20, 2, '2021-10-02 05:30:30', NULL),
	(56, 6, 64, 408961, 0, 1, '2021-11-21 03:28:47', NULL),
	(57, 7, 36, 465049, 0, 4, '2021-09-20 04:29:11', NULL),
	(58, 8, 96, 342387, 0, 1, '2021-08-19 03:15:44', NULL),
	(59, 9, 52, 38093, 0, 1, '2021-03-07 01:17:41', NULL),
	(60, 10, 8, 230558, 0, 3, '2021-04-25 23:53:11', NULL),
	(61, 26, 93, 215800, 20, 1, '2024-03-24 09:55:53', NULL);

-- Dumping structure for table bookshopdb.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `price` double NOT NULL DEFAULT 0,
  `discount` double NOT NULL DEFAULT 0,
  `quantity` smallint(6) NOT NULL,
  `totalBuy` smallint(6) NOT NULL,
  `author` varchar(50) NOT NULL,
  `pages` smallint(6) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `yearPublishing` year(4) NOT NULL,
  `description` text DEFAULT NULL,
  `imageName` varchar(35) DEFAULT NULL,
  `shop` bit(1) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  `startsAt` timestamp NULL DEFAULT NULL,
  `endsAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.product: ~100 rows (approximately)
INSERT INTO `product` (`id`, `name`, `price`, `discount`, `quantity`, `totalBuy`, `author`, `pages`, `publisher`, `yearPublishing`, `description`, `imageName`, `shop`, `createdAt`, `updatedAt`, `startsAt`, `endsAt`) VALUES
	(1, 'Sách Toyletry', 466183, 0, 86, 86, 'Stafford Hayden', 250, 'NXB Giáo dục', '2013', 'Consequat cupidatat magna nostrud ullamco non commodo esse. Veniam anim ipsum duis cillum cillum exercitation deserunt irure sint eiusmod. Duis consectetur adipisicing aliquip magna eiusmod ullamco ut ad ipsum nostrud dolore id. Ex ullamco nulla Lorem consequat sunt exercitation cillum adipisicing.\r\nProident labore ut qui esse cupidatat deserunt occaecat dolor in. Ad nulla reprehenderit pariatur esse enim ullamco do incididunt anim do excepteur est dolore excepteur. Laboris voluptate cupidatat anim dolore eiusmod in id fugiat est cupidatat pariatur mollit. Mollit irure proident enim consequat irure ipsum proident amet aliqua. Irure ad dolore laboris elit reprehenderit officia ex.\r\n', 'temp-10075522682831764585.jpg', b'0', '2021-03-23 01:22:50', NULL, NULL, NULL),
	(2, 'Sách Sultrax', 26228, 0, 23, 60, 'Diane Nguyen', 305, 'NXB Đại học Sư phạm TP.HCM', '2011', 'Ipsum consequat reprehenderit amet ullamco dolore consectetur non eiusmod dolor irure sit. Lorem nulla officia dolore officia laboris. Excepteur anim consectetur reprehenderit duis duis ea nostrud. Reprehenderit consequat cupidatat enim ea eiusmod nisi. Mollit veniam quis est ex elit proident tempor pariatur sit aute. Eu Lorem irure sunt sit aute nostrud culpa. Voluptate enim sit dolor laborum est nulla eiusmod eu laborum Lorem laborum.\r\nPariatur id proident laborum consectetur pariatur deserunt quis tempor excepteur non tempor. Sit tempor irure id fugiat occaecat. Ex ut veniam nostrud sunt dolore. Veniam cillum incididunt enim tempor ut amet do est pariatur aliqua labore.\r\n', 'temp-17624438115898823949.jpg', b'1', '2021-12-19 08:03:05', NULL, NULL, NULL),
	(3, 'Sách Medcom', 294114, 20, 68, 116, 'Byrd Collier', 457, 'NXB Đại học Sư phạm TP.HCM', '2003', 'Cupidatat ipsum ea laborum nisi veniam nulla dolor labore excepteur ad eu. Commodo Lorem esse veniam sunt in. Voluptate amet commodo est commodo ipsum excepteur aliqua voluptate amet. Sunt elit ut esse proident irure tempor velit quis eu cupidatat pariatur duis ea.\r\nEnim magna esse dolor amet ex nostrud quis consectetur velit. Sunt minim consectetur anim veniam elit proident exercitation sunt commodo veniam magna ad. Sint eu mollit veniam cupidatat occaecat fugiat reprehenderit nisi fugiat cillum. Amet exercitation aute qui eu ullamco non do officia non amet commodo. Minim excepteur nisi mollit reprehenderit ad. Sit consectetur sit sit laboris ipsum dolore ut sit ex aliquip cillum. Aliquip ut ea adipisicing ullamco Lorem nostrud magna qui amet cillum.\r\n', 'temp-6352099207348952932.jpg', b'1', '2021-07-31 03:44:48', NULL, NULL, NULL),
	(4, 'Sách Radiantix', 61888, 20, 46, 195, 'Dodson Wilkinson', 426, 'NXB Đại học Sư phạm TP.HCM', '2019', 'Qui magna ex aute deserunt aliquip mollit labore ad. Ipsum pariatur nostrud magna pariatur labore duis ad consequat magna. Ad cillum dolore exercitation proident elit. Cillum occaecat proident officia sit cillum magna ullamco id occaecat non irure mollit minim.\r\nDeserunt elit velit nostrud id aliqua. Velit pariatur in sint ut irure non laborum eiusmod labore fugiat aliquip eu irure. Deserunt velit qui in elit ipsum Lorem aute tempor ullamco minim fugiat deserunt ut. Commodo proident aliqua nostrud dolor do consequat aliquip dolor officia laboris.\r\n', 'temp-13862094760385571107.jpg', b'0', '2021-07-26 10:44:04', NULL, NULL, NULL),
	(5, 'Sách Prosely', 195442, 0, 52, 178, 'Horne Oneill', 270, 'NXB Giáo dục', '2000', 'Sit cillum ipsum cillum commodo dolor ipsum aliquip id exercitation non proident qui. Veniam tempor labore id exercitation nisi veniam et in non anim ad laborum nostrud fugiat. In ullamco excepteur nostrud esse id nisi eiusmod sint elit aute elit. Amet consectetur commodo amet occaecat. Nostrud labore ad cillum mollit ad fugiat amet.\r\nQui commodo officia ea adipisicing laborum tempor aliqua mollit aliqua. Est sunt amet cupidatat esse id officia qui fugiat eu et et. Cillum tempor esse enim culpa culpa cupidatat labore exercitation aute do voluptate consequat esse.\r\n', 'temp-17624438115898823949.jpg', b'0', '2021-03-03 18:10:28', NULL, NULL, NULL),
	(6, 'Sách Xth', 462713, 0, 13, 212, 'Karin Jackson', 186, 'NXB Đại học Sư phạm TP.HCM', '2008', 'Ut pariatur culpa sint aliqua culpa ullamco laboris duis dolore mollit dolor cillum. Veniam sit consectetur irure anim do. Labore dolore nisi in aliquip ipsum sit eu excepteur sit magna officia consectetur amet.\r\nCulpa consequat magna consequat aliquip sint amet nulla culpa ea mollit pariatur quis deserunt esse. Non sint id non aliqua ipsum id laboris. Magna ullamco est ullamco et nisi ullamco adipisicing. Nisi irure cillum nostrud laborum aute ea incididunt cillum. Qui quis nostrud adipisicing fugiat et incididunt irure Lorem in. Ipsum nulla ea ullamco irure ea dolore et nostrud.\r\n', 'temp-16741118072528735594.jpg', b'1', '2021-06-17 22:55:06', NULL, NULL, NULL),
	(7, 'Sách Liquicom', 488021, 0, 65, 95, 'Johnson Wilkins', 260, 'NXB Đại học Huế', '2003', 'Nostrud minim nostrud duis nostrud cupidatat reprehenderit nostrud dolor amet esse. Anim eiusmod ea ea deserunt. Elit pariatur voluptate esse occaecat sint. Enim reprehenderit ad culpa ad dolor duis elit minim cupidatat Lorem est. Enim exercitation cillum nulla consequat ut et sunt esse cupidatat velit esse enim. Excepteur officia eu voluptate fugiat ad esse irure anim irure eiusmod cupidatat consequat eiusmod occaecat. Tempor voluptate incididunt veniam dolore nisi voluptate adipisicing mollit dolore consequat non nostrud est.\r\nDo irure ut occaecat adipisicing sint Lorem fugiat. Quis et aliqua ipsum in esse sit. Sint laborum eiusmod duis magna. Veniam consectetur nulla deserunt Lorem excepteur. Cillum nisi minim incididunt adipisicing anim eu ipsum reprehenderit non irure ea officia nulla. Ad culpa aliqua sit adipisicing.\r\n', 'temp-6243426685116508297.jpg', b'1', '2021-11-01 13:47:34', NULL, NULL, NULL),
	(8, 'Sách Supremia', 478294, 0, 60, 316, 'Ayala Rich', 359, 'NXB Đại học Sư phạm Hà Nội', '2006', 'Reprehenderit quis exercitation reprehenderit velit et magna. Velit ex cupidatat est mollit eiusmod in mollit aliqua velit laborum adipisicing eiusmod ex. Duis Lorem dolore labore veniam.\r\nSunt esse consectetur culpa nostrud ad id tempor voluptate elit cupidatat. Dolor proident ipsum cillum anim mollit incididunt nisi labore voluptate est sunt magna non. Sit magna eiusmod officia nostrud aliqua exercitation. Aliquip labore cillum commodo labore do ullamco ea tempor ullamco exercitation nostrud officia.\r\n', 'temp-10075522682831764585.jpg', b'0', '2021-08-26 19:56:32', NULL, NULL, NULL),
	(9, 'Sách Cyclonica', 96299, 20, 45, 14, 'Flynn Sanford', 420, 'NXB Đại học Sư phạm Hà Nội', '2013', 'Laborum elit laborum do esse ut id sunt voluptate ut minim sint mollit irure. Amet veniam cupidatat anim minim tempor ipsum dolore tempor aliquip voluptate mollit id velit eu. Proident culpa aliquip ut aliquip tempor commodo occaecat Lorem. Pariatur consequat id eu irure ex culpa elit aliqua in ea sunt id eiusmod non. Non laboris officia pariatur enim sint officia. Ipsum aliquip commodo in dolore. Ullamco consectetur proident dolor nostrud eu cupidatat aliqua dolor sint.\r\nEst pariatur fugiat amet sint ut tempor ut labore ipsum veniam deserunt non occaecat irure. Labore nostrud amet in voluptate. Qui ullamco officia ullamco ipsum cillum. Amet Lorem aliqua dolore sit.\r\n', 'temp-16741118072528735594.jpg', b'1', '2021-08-07 14:11:03', NULL, NULL, NULL),
	(10, 'Sách Envire', 397768, 20, 65, 347, 'Gilda Harris', 321, 'NXB Đại học Sư phạm TP.HCM', '2020', 'Non veniam dolore esse aute officia in nostrud id sint ipsum incididunt qui incididunt. Commodo irure esse sunt ex eu minim sit culpa in mollit. Incididunt id irure ullamco ea. Adipisicing enim sit nisi dolore velit dolore eu deserunt pariatur deserunt eu exercitation ipsum nostrud. Commodo veniam elit duis mollit ut mollit enim. Aliquip labore non ea id cillum qui laboris occaecat quis adipisicing. Elit nulla ut laborum officia occaecat dolore aute commodo voluptate qui incididunt deserunt consectetur.\r\nEiusmod duis nulla occaecat deserunt ut sint consectetur. Nostrud eu velit nulla amet qui consequat labore. Consectetur proident cupidatat occaecat ex dolor dolor sint eiusmod mollit sint.\r\n', 'temp-13862094760385571107.jpg', b'1', '2021-06-07 16:23:46', NULL, NULL, NULL),
	(11, 'Sách Insuresys', 366716, 0, 50, 305, 'Lolita Cochran', 89, 'NXB Đại học Quốc gia Hà Nội', '2007', 'Magna enim veniam consequat minim. Incididunt ea ex minim officia magna culpa. Duis proident voluptate nostrud consectetur dolor adipisicing magna in. Lorem pariatur aliqua incididunt ut aliquip commodo ipsum est dolore exercitation. Pariatur non ad ipsum ut reprehenderit sit nostrud proident et consectetur. Eu amet aute dolor consequat consectetur incididunt fugiat duis ipsum et magna nisi incididunt nulla. Non mollit qui nostrud nostrud pariatur non.\r\nAdipisicing aliquip non commodo sit labore sint voluptate cupidatat anim amet. Non reprehenderit tempor mollit duis in reprehenderit. Est laborum aute eu dolor reprehenderit ut culpa ullamco Lorem qui laborum elit. Esse pariatur eu ex magna excepteur incididunt irure aute nulla eu. Occaecat irure cupidatat et quis consequat eiusmod ad reprehenderit veniam elit nostrud voluptate. Et reprehenderit mollit ullamco laborum tempor elit. Nisi eiusmod ipsum dolore culpa reprehenderit ad quis consequat aliqua anim aute.\r\n', 'temp-10075522682831764585.jpg', b'1', '2021-12-10 06:59:07', NULL, NULL, NULL),
	(12, 'Sách Exostream', 51700, 0, 85, 62, 'Christian Alvarado', 435, 'NXB Đại học Sư phạm Hà Nội', '2018', 'In laborum tempor cupidatat aliqua in pariatur tempor voluptate velit deserunt. Irure proident labore nostrud occaecat aliqua excepteur eiusmod exercitation eiusmod eiusmod. Ex anim do id tempor aute proident proident in irure. Tempor duis esse laboris do. Duis amet qui nisi velit mollit ad. Proident aute ea ullamco qui irure proident.\r\nDolor enim Lorem ea excepteur aliqua. Aute sint aliqua elit pariatur. Ullamco ut occaecat voluptate ut irure qui tempor tempor qui consequat fugiat.\r\n', 'temp-17624438115898823949.jpg', b'0', '2021-12-14 12:28:20', NULL, NULL, NULL),
	(13, 'Sách Fuelton', 122139, 0, 88, 461, 'Gentry Chapman', 18, 'NXB Đại học Quốc gia Hà Nội', '2005', 'Officia anim mollit culpa ea Lorem dolore commodo incididunt eu pariatur occaecat. Ullamco amet est do commodo deserunt magna sint mollit esse. Aliqua ipsum proident anim laboris enim sint ex occaecat labore minim sunt. Ipsum nulla velit in esse eu commodo do Lorem velit laboris duis. Id amet aliquip Lorem ea ullamco ex laborum minim mollit ullamco mollit. Lorem nostrud veniam nulla quis duis occaecat ullamco magna nostrud Lorem deserunt sunt pariatur. Magna aute ad reprehenderit eu amet ullamco irure cillum.\r\nSit anim consequat mollit sint velit ad ea. Ipsum ex veniam officia ea minim labore. Eiusmod pariatur ut velit sit officia cupidatat consectetur. Dolore esse exercitation do sunt veniam amet nisi consequat quis nulla.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-06-16 01:20:52', NULL, NULL, NULL),
	(14, 'Sách Xinware', 247115, 20, 80, 373, 'Sheree Lawson', 124, 'NXB Đại học Sư phạm TP.HCM', '2007', 'Deserunt labore fugiat velit proident proident ex irure incididunt sint anim consequat ipsum dolore dolore. Exercitation proident nulla adipisicing incididunt officia ut labore consequat. Voluptate ex occaecat commodo duis reprehenderit aliqua qui cillum sunt sint esse velit irure. Do Lorem magna tempor adipisicing dolor reprehenderit do in commodo ad anim consectetur.\r\nOccaecat consectetur elit consequat reprehenderit cillum cupidatat duis eiusmod. Commodo esse occaecat aute qui labore exercitation sint. Aliquip Lorem veniam tempor elit esse aliqua commodo. Nulla do fugiat exercitation dolore tempor exercitation irure pariatur Lorem cupidatat labore. Pariatur aliquip veniam Lorem sint. Aliqua nisi laborum ullamco cupidatat anim occaecat fugiat in sint Lorem ex cupidatat. Eu qui fugiat ut ipsum.\r\n', 'temp-16741118072528735594.jpg', b'1', '2021-07-31 08:57:52', NULL, NULL, NULL),
	(15, 'Sách Atomica', 205300, 20, 16, 388, 'Shirley Sawyer', 414, 'NXB Đại học Quốc gia Hà Nội', '2006', 'Eu id sint sunt eiusmod ad magna dolore sint. Ea laboris fugiat eiusmod enim sint do irure ipsum tempor quis aliqua laboris fugiat cillum. Ipsum sint anim et irure labore nulla. Enim culpa officia eiusmod proident mollit aliqua deserunt. Adipisicing voluptate veniam commodo deserunt adipisicing tempor nulla voluptate. Esse fugiat amet enim pariatur eu ad magna labore magna.\r\nSunt et amet nisi dolor nostrud qui commodo culpa. Sunt nisi enim in in quis consequat sunt ullamco pariatur Lorem eu minim. Enim ea dolor elit ut adipisicing incididunt eiusmod. Laboris do minim dolore ut enim voluptate ea ea consequat anim incididunt adipisicing id commodo. Non mollit nisi enim et laboris voluptate. Incididunt ex elit reprehenderit veniam consectetur sunt id pariatur. Elit sunt consequat excepteur est aute amet enim culpa ipsum dolor.\r\n', 'temp-12235989262213754276.jpg', b'0', '2021-04-19 07:39:51', NULL, NULL, NULL),
	(16, 'Sách Quadeebo', 280225, 0, 27, 16, 'Marcia Horne', 486, 'NXB Đại học Sư phạm Hà Nội', '2006', 'Ut exercitation ipsum amet commodo labore duis est excepteur nostrud velit et ex magna. Amet ut proident eu dolor incididunt commodo deserunt duis ea. Proident quis enim proident adipisicing ex dolore consectetur incididunt sit.\r\nUt Lorem excepteur labore ea qui ullamco aliquip in sint pariatur. Esse aliqua aliquip deserunt veniam pariatur commodo Lorem id tempor nostrud elit anim. Consectetur voluptate mollit nostrud ut nisi commodo quis ullamco proident laborum esse consequat. Ipsum esse sint laboris do ad in dolore enim laborum id est id veniam.\r\n', 'temp-10075522682831764585.jpg', b'1', '2021-12-17 02:38:24', NULL, NULL, NULL),
	(17, 'Sách Nexgene', 90044, 20, 96, 165, 'Dixie Middleton', 43, 'NXB Đại học Sư phạm TP.HCM', '2009', 'Veniam qui id occaecat exercitation aliquip occaecat incididunt quis. Anim magna culpa nisi aute aliqua veniam Lorem est elit laborum aliquip. Non aute consequat fugiat minim est sint officia duis proident proident ipsum nulla et. Labore aliquip officia pariatur ut aliqua laboris quis eu fugiat. Occaecat sint dolore ex est laboris. Enim non aute est pariatur eiusmod.\r\nReprehenderit cillum cillum voluptate veniam in. Nostrud ea laborum Lorem duis mollit anim id cillum nisi commodo commodo non est excepteur. Id labore sunt ipsum dolor Lorem laboris deserunt ullamco ullamco nostrud proident aliquip commodo. Nisi incididunt dolore officia eu id ut laborum fugiat sit enim nostrud eiusmod.\r\n', 'temp-10075522682831764585.jpg', b'1', '2022-01-02 16:13:27', NULL, NULL, NULL),
	(18, 'Sách Gaptec', 281613, 0, 93, 279, 'Dorothea Gonzales', 409, 'NXB Đại học Huế', '2020', 'Ea deserunt esse officia consequat ex nisi laborum laborum. Ad ex laboris culpa ullamco cupidatat fugiat enim sunt occaecat elit enim duis. Irure excepteur sunt excepteur sit. Labore minim pariatur elit fugiat commodo eu cupidatat anim non excepteur irure. Esse amet elit velit et deserunt. Laborum qui nulla est duis aute voluptate ea ipsum mollit tempor anim est esse. Dolore cillum occaecat amet enim tempor mollit.\r\nUllamco minim aliquip pariatur dolor culpa ea ad eiusmod. Officia nulla sint cillum consectetur do voluptate occaecat. Aute et irure voluptate exercitation.\r\n', 'temp-13862094760385571107.jpg', b'0', '2021-07-04 05:11:08', NULL, NULL, NULL),
	(19, 'Sách Dadabase', 450859, 20, 90, 474, 'Moore Kim', 113, 'NXB Đại học Sư phạm TP.HCM', '2003', 'Amet laborum do consequat officia cupidatat in nulla occaecat ut aute magna aute eu exercitation. Amet aute aliqua minim dolore cillum sunt non eu nulla anim aute veniam. In occaecat deserunt consequat excepteur. Aliqua et magna duis deserunt duis excepteur ipsum in non do magna quis. Amet pariatur et incididunt in. Qui dolor et occaecat excepteur quis laborum. Ut sint sint officia elit nostrud dolor quis laborum ea.\r\nIncididunt occaecat deserunt consequat in ut aliqua velit ipsum nisi labore ex. Cillum amet consequat fugiat et. Elit cupidatat officia magna aliqua velit laboris ea. Nostrud voluptate in esse minim excepteur pariatur eiusmod voluptate.\r\n', 'temp-7329036107498680084.jpg', b'0', '2021-10-25 02:48:48', NULL, NULL, NULL),
	(20, 'Sách Digial', 187331, 20, 75, 339, 'Laverne Obrien', 194, 'NXB Đại học Huế', '2011', 'Ipsum est amet eiusmod nostrud laborum deserunt consequat qui. Labore aliqua fugiat nulla exercitation amet quis. Laborum consequat in non mollit. Reprehenderit dolor est commodo et fugiat. Nulla aute tempor pariatur cillum Lorem ad consequat magna esse incididunt nulla. Ad officia non excepteur occaecat cillum cillum sunt in.\r\nCupidatat sunt dolor incididunt sint et nisi eu consectetur culpa esse. Pariatur ad veniam cillum sit culpa anim magna ex laboris magna ea tempor. Voluptate in voluptate incididunt labore eiusmod ut magna sunt qui labore sit esse veniam. Anim qui elit duis mollit culpa ullamco do in et. Laboris eiusmod id commodo et et aliqua qui esse ad anim nulla. Qui occaecat consequat in sunt est enim id qui ex reprehenderit.\r\n', 'temp-3015888053636485125.jpg', b'1', '2021-11-11 17:28:22', NULL, NULL, NULL),
	(21, 'Sách Endicil', 396673, 20, 85, 263, 'Hughes Hutchinson', 62, 'NXB Đại học Sư phạm Hà Nội', '2013', 'Cillum non quis sit deserunt dolore laboris enim laboris fugiat reprehenderit id aliqua. Elit ut consequat occaecat aliqua nulla non laboris mollit pariatur nisi sit. Irure cupidatat anim dolor incididunt elit duis labore Lorem in velit fugiat.\r\nEsse aute dolore ullamco sit commodo do qui laboris. Cillum nostrud eu aute nostrud sit anim labore officia quis aliqua veniam consectetur. Proident excepteur aliqua aliqua culpa. Reprehenderit fugiat occaecat irure cupidatat magna consequat.\r\n', 'temp-12235989262213754276.jpg', b'0', '2021-03-26 15:11:02', NULL, NULL, NULL),
	(22, 'Sách Inquala', 116529, 0, 11, 367, 'Hilda Crane', 238, 'NXB Đại học Quốc gia Hà Nội', '1998', 'Esse ipsum minim voluptate consectetur exercitation dolor. Ex ut anim ad elit non consequat cupidatat anim minim est elit in deserunt Lorem. Est duis minim consectetur sunt duis non.\r\nLorem labore proident laborum consequat officia commodo reprehenderit ad Lorem minim incididunt aute in esse. Ex eiusmod ut eiusmod mollit consectetur qui enim sit labore Lorem reprehenderit enim consectetur. Nisi anim veniam sint tempor fugiat pariatur in est sint excepteur.\r\n', 'temp-12235989262213754276.jpg', b'1', '2022-01-24 01:00:39', NULL, NULL, NULL),
	(23, 'Sách Tubalum', 372359, 0, 71, 129, 'Erma Shannon', 15, 'NXB Đại học Sư phạm TP.HCM', '2016', 'Veniam cillum do laboris ipsum incididunt consequat non. Veniam nulla velit elit duis proident nulla. Commodo amet nostrud sit proident amet cillum qui anim.\r\nId enim reprehenderit laboris nulla Lorem. Est amet do labore in fugiat do. Qui consequat dolor consectetur cupidatat magna. Dolore cupidatat ut proident deserunt irure fugiat et exercitation minim quis enim aliqua. Adipisicing proident elit irure pariatur irure magna. Aliqua non velit do veniam ipsum laboris ex ipsum.\r\n', 'temp-6243426685116508297.jpg', b'0', '2021-07-15 13:01:58', NULL, NULL, NULL),
	(24, 'Sách Songlines', 293705, 20, 83, 267, 'Paula Duncan', 284, 'NXB Đại học Huế', '2017', 'Nisi consequat do adipisicing nostrud elit aliqua nostrud sunt laborum reprehenderit culpa labore in ea. Ut nulla voluptate aliqua exercitation consequat mollit anim est ullamco. Nostrud excepteur reprehenderit est amet dolore. Velit dolor eu consectetur excepteur. Cupidatat sit officia anim ex.\r\nSit enim ea proident tempor dolore cupidatat ad labore sint tempor proident aliquip. Enim enim nostrud aliqua ut voluptate elit sunt nulla. Culpa deserunt enim elit consectetur ea pariatur magna in nisi. Aliqua aliqua quis sit ullamco non ex amet reprehenderit cupidatat ad id sint nulla culpa. Irure labore minim adipisicing dolor reprehenderit amet. Nisi esse exercitation commodo cillum eu Lorem.\r\n', 'temp-13862094760385571107.jpg', b'0', '2021-09-08 22:29:49', NULL, NULL, NULL),
	(25, 'Sách Evidends', 122006, 0, 62, 309, 'Briggs Burke', 134, 'NXB Đại học Sư phạm TP.HCM', '2011', 'Tempor laborum duis aute enim eiusmod ipsum et labore sunt qui labore. Fugiat in sit exercitation eu culpa nisi laboris. Ullamco occaecat labore excepteur cupidatat velit tempor occaecat. Eiusmod culpa quis exercitation ut exercitation aliquip enim veniam aute sunt. Duis id aute culpa adipisicing laborum in aliqua cillum deserunt elit cupidatat aute.\r\nSunt incididunt ex ut excepteur id. Ea excepteur irure consectetur aute ea quis sunt dolor. In incididunt id officia nostrud anim sit. Cillum consectetur amet ipsum labore duis ipsum nostrud voluptate sit ut est qui Lorem. Nisi anim ex reprehenderit magna id officia ea culpa. Laborum do quis tempor ea cillum consectetur velit id voluptate dolore anim culpa. Anim ullamco deserunt irure magna Lorem non qui deserunt occaecat.\r\n', 'temp-13064240004351430671.jpg', b'1', '2021-12-10 19:13:04', NULL, NULL, NULL),
	(26, 'Sách Buzzworks', 131272, 20, 47, 418, 'Wood Franks', 147, 'NXB Đại học Sư phạm Hà Nội', '1996', 'Consequat culpa ad excepteur in ut officia do. Ad nisi mollit ut aliqua aliquip velit incididunt. Ipsum do nisi culpa id nulla sint quis laborum voluptate et aliqua irure ea. Proident officia dolore ex enim culpa. Eiusmod dolor sunt amet in excepteur id.\r\nOfficia reprehenderit eiusmod tempor anim laboris reprehenderit et dolor commodo irure. Excepteur magna ad id in dolore non nostrud ad veniam reprehenderit amet nulla. Aliquip ipsum proident non sit officia adipisicing dolor proident consectetur. Est aute et laborum mollit consectetur sunt voluptate voluptate laborum. Ipsum veniam ipsum anim nostrud eu id amet do eiusmod do tempor amet excepteur. Nostrud magna tempor in proident non magna sit enim minim elit cupidatat.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-02-01 17:42:02', NULL, NULL, NULL),
	(27, 'Sách Zilla', 45254, 0, 40, 41, 'Imogene Horton', 67, 'NXB Đại học Huế', '2008', 'Voluptate est reprehenderit nostrud deserunt qui ullamco tempor quis officia pariatur ipsum. Veniam exercitation fugiat velit commodo. Adipisicing ad officia eu pariatur amet nulla amet eiusmod commodo irure enim ut eiusmod. Eiusmod officia Lorem ex commodo magna eu dolor aliquip esse officia esse culpa. Ad excepteur ipsum occaecat proident consectetur incididunt officia adipisicing laboris cupidatat cillum qui laboris mollit. Elit excepteur cupidatat dolor eu aliquip veniam occaecat ipsum sint adipisicing sint excepteur occaecat sit.\r\nLaboris culpa minim adipisicing pariatur anim nostrud voluptate ut ea id cillum aute. Non cillum dolor nulla ea laboris dolor duis fugiat id proident aute anim qui. Adipisicing qui occaecat tempor do deserunt fugiat. Ipsum aliquip sunt ullamco non do officia mollit nisi sit aliquip enim eiusmod. Commodo exercitation minim nisi esse occaecat ad aliqua veniam sit excepteur. Magna amet nisi proident velit Lorem aliqua enim eu id amet aliqua nostrud sit enim.\r\n', 'temp-8262627340495498759.jpg', b'0', '2021-04-26 04:20:50', NULL, NULL, NULL),
	(28, 'Sách Fangold', 36717, 20, 19, 407, 'Frankie Mccarthy', 85, 'NXB Giáo dục', '2015', 'Incididunt elit consectetur magna nisi. Occaecat sint ullamco anim ex nulla ea Lorem duis ea. Commodo Lorem ut tempor sunt enim aliquip sint reprehenderit ut tempor ullamco nisi elit. Proident ipsum ea ad exercitation esse enim deserunt veniam aliquip.\r\nDuis non minim ut aliquip veniam deserunt minim ullamco adipisicing proident nostrud consectetur dolore irure. Dolor nisi deserunt velit nostrud incididunt excepteur elit reprehenderit est. Laborum commodo veniam sint commodo. Velit commodo exercitation in nostrud cillum pariatur ea. Incididunt consectetur aute voluptate anim ea in enim. Culpa exercitation id excepteur Lorem consectetur pariatur pariatur veniam ipsum aliquip amet. Cupidatat cupidatat ullamco occaecat est sunt exercitation tempor amet esse.\r\n', 'temp-18128511448457962576.jpg', b'0', '2021-03-08 00:28:18', NULL, NULL, NULL),
	(29, 'Sách Immunics', 260516, 0, 87, 176, 'Wheeler Carpenter', 49, 'NXB Đại học Sư phạm TP.HCM', '2012', 'Deserunt excepteur fugiat nisi adipisicing amet esse duis pariatur dolor deserunt dolor mollit. Ut anim minim dolore veniam duis tempor tempor commodo aliquip nulla incididunt. Reprehenderit sint sunt eiusmod non labore. Magna anim mollit dolor consequat. Sit velit laborum Lorem eiusmod nisi minim ex non dolor labore id. Enim ad laborum ad ex quis adipisicing ex excepteur esse id est et proident voluptate. Excepteur enim et irure reprehenderit eu ad velit anim minim aute.\r\nOfficia pariatur aliqua esse est ad ad dolore dolor adipisicing commodo. Tempor dolor incididunt excepteur eu eiusmod in cupidatat adipisicing duis mollit. Id pariatur nulla quis officia commodo consequat in qui. Eu laborum consequat pariatur incididunt aliquip.\r\n', 'temp-14438611480196141526.jpg', b'0', '2021-10-14 15:48:40', NULL, NULL, NULL),
	(30, 'Sách Zillacom', 318403, 0, 12, 71, 'Natalia Wilder', 271, 'NXB Đại học Sư phạm TP.HCM', '2007', 'Id sunt incididunt eiusmod dolore pariatur. Non in cillum sunt sint. Id est nisi amet dolore. Sit mollit esse quis enim.\r\nIncididunt deserunt exercitation qui dolor incididunt proident deserunt dolor proident amet duis. Minim mollit ipsum ea non eiusmod aute non ullamco. Excepteur elit et Lorem Lorem ea cillum. Lorem magna est excepteur culpa laborum laboris velit amet et excepteur enim quis proident. Adipisicing eiusmod officia aliqua nisi quis elit labore commodo occaecat voluptate. Eiusmod esse culpa sint sit occaecat do magna elit ad eu laborum et.\r\n', 'temp-12235989262213754276.jpg', b'0', '2021-12-18 19:05:00', NULL, NULL, NULL),
	(31, 'Sách Katakana', 231331, 20, 71, 336, 'Linda Stevens', 285, 'NXB Đại học Sư phạm TP.HCM', '2001', 'Elit ad nulla officia fugiat nisi et ex nostrud elit ut. Mollit ut officia ea esse aute in occaecat est exercitation magna duis. Sit consectetur ad in eiusmod. Velit nisi dolore pariatur commodo eiusmod minim ullamco anim reprehenderit velit commodo qui.\r\nDo ex amet minim anim consequat anim ullamco veniam consequat. Eiusmod ea cillum ad ut anim qui sint officia mollit proident qui. Lorem velit minim veniam nisi aute dolor nulla laboris commodo dolor laboris qui. Laboris cillum non culpa anim ea quis. Commodo adipisicing est quis do cupidatat ullamco incididunt pariatur anim cillum elit magna laboris dolor. Elit pariatur dolor velit do exercitation consequat eu eu sunt.\r\n', 'temp-13862094760385571107.jpg', b'1', '2022-01-01 16:10:09', NULL, NULL, NULL),
	(32, 'Sách Artiq', 313493, 0, 49, 48, 'Tucker Sargent', 341, 'NXB Đại học Sư phạm TP.HCM', '1997', 'Sit sint sit adipisicing aliqua fugiat eiusmod amet sunt cupidatat laboris cillum. Anim consequat laborum et cupidatat occaecat laborum aute dolor ipsum. Velit ex pariatur cillum non et quis minim excepteur irure id officia irure consectetur tempor. Sunt reprehenderit exercitation adipisicing laborum anim non pariatur.\r\nReprehenderit commodo nisi magna officia proident cillum do laboris laboris officia ullamco mollit duis nostrud. Labore ad proident fugiat nisi nisi deserunt voluptate aliquip dolore officia. Non reprehenderit commodo dolore do occaecat nostrud nostrud officia esse do officia reprehenderit qui. Ullamco nostrud do consequat magna incididunt. Eu velit occaecat amet ut magna ad ea voluptate est consectetur adipisicing tempor mollit.\r\n', 'temp-6352099207348952932.jpg', b'0', '2021-12-07 19:56:41', NULL, NULL, NULL),
	(33, 'Sách Omnigog', 155599, 20, 19, 316, 'Mullins Thomas', 255, 'NXB Đại học Huế', '2009', 'Cillum amet culpa Lorem elit. Aliquip labore mollit est minim elit. Ex dolor eiusmod non exercitation enim aute excepteur. Voluptate occaecat dolore duis elit eu cillum non labore qui.\r\nMinim eu magna nostrud sunt laborum nulla in mollit duis dolore. Incididunt reprehenderit pariatur ut ea. Qui voluptate ad ea aliqua. Mollit aute sint culpa elit dolor adipisicing culpa sint irure aliqua. Do fugiat deserunt reprehenderit fugiat.\r\n', 'temp-8262627340495498759.jpg', b'1', '2021-11-05 19:48:40', NULL, NULL, NULL),
	(34, 'Sách Elita', 298548, 0, 65, 439, 'Amber Spence', 262, 'NXB Đại học Huế', '1998', 'Quis fugiat aliqua sit laborum proident ea. Ullamco velit est eiusmod pariatur incididunt. Est Lorem velit nostrud ipsum nostrud. Non in nostrud aliquip velit excepteur nisi non ipsum id sit ea ut. Officia do in Lorem enim occaecat et occaecat ex exercitation aliquip deserunt.\r\nEst ex in qui qui deserunt anim irure consequat ut cillum irure et incididunt esse. Cillum ipsum tempor qui eu do eiusmod ea consectetur dolor. Reprehenderit do Lorem laboris culpa eiusmod irure ullamco ex nisi esse minim.\r\n', 'temp-18128511448457962576.jpg', b'1', '2021-03-24 16:12:25', NULL, NULL, NULL),
	(35, 'Sách Hopeli', 461236, 20, 51, 350, 'Wooten Johnston', 355, 'NXB Đại học Huế', '2018', 'Cupidatat fugiat do minim qui dolor deserunt anim. Sit elit sit ex velit nisi laborum. Anim officia nisi ipsum irure velit labore eu commodo in sit aute excepteur sit mollit.\r\nMagna tempor est enim consectetur eu nulla fugiat sit tempor mollit exercitation eu. Exercitation ea voluptate laborum incididunt occaecat id in. Lorem dolor irure aute amet cillum. Pariatur ex ullamco quis quis.\r\n', 'temp-12235989262213754276.jpg', b'1', '2021-10-05 01:08:19', NULL, NULL, NULL),
	(36, 'Sách Vendblend', 495547, 20, 48, 22, 'Mayra Moon', 364, 'NXB Đại học Sư phạm Hà Nội', '1995', 'Aute eiusmod deserunt ipsum eu. Pariatur nisi labore aliquip velit esse sint veniam quis. Sunt anim in ad labore non irure consequat deserunt adipisicing consequat irure pariatur. Id do ad qui et anim in irure est anim ut enim.\r\nAnim adipisicing ea irure elit ut eiusmod adipisicing enim velit aliqua veniam commodo. In minim deserunt tempor eu voluptate sint reprehenderit fugiat excepteur. Adipisicing sint consequat deserunt occaecat adipisicing occaecat consequat.\r\n', 'temp-6352099207348952932.jpg', b'1', '2022-01-07 19:42:25', NULL, NULL, NULL),
	(37, 'Sách Zensure', 288319, 20, 16, 440, 'Hickman Moses', 62, 'NXB Đại học Sư phạm TP.HCM', '2007', 'Minim cillum pariatur ea voluptate laborum dolore duis. Lorem mollit eu ad tempor irure sint ex nulla reprehenderit exercitation. Cupidatat sit excepteur et duis cillum deserunt duis nostrud dolore labore.\r\nEa ad nisi amet et nulla anim et laborum sit eiusmod laborum ullamco. Velit dolore laborum eu consequat cupidatat elit reprehenderit. Duis in amet adipisicing incididunt sit veniam sunt labore incididunt consequat do ad.\r\n', 'temp-8476700387786158058.jpg', b'0', '2021-05-10 18:50:10', NULL, NULL, NULL),
	(38, 'Sách Quilk', 183383, 20, 81, 14, 'Elnora Pearson', 326, 'NXB Đại học Huế', '2013', 'Laborum sunt laborum reprehenderit cupidatat esse. Ex ex ullamco elit commodo ipsum anim est nostrud ut exercitation. Exercitation non ex ipsum nisi deserunt occaecat fugiat in. Ipsum sunt culpa laborum proident adipisicing magna sit mollit velit tempor. Consequat esse duis esse amet consequat ad amet duis in. Tempor consectetur consequat eu sunt irure Lorem adipisicing anim ea enim Lorem minim commodo.\r\nLorem consequat laboris aliqua enim pariatur amet fugiat et incididunt. Ut anim esse ut amet voluptate in excepteur non est labore cupidatat incididunt nisi consequat. Adipisicing ipsum eu in ex.\r\n', 'temp-10075522682831764585.jpg', b'1', '2021-11-05 13:54:31', NULL, NULL, NULL),
	(39, 'Sách Schoolio', 176598, 0, 48, 208, 'Isabella Mcbride', 401, 'NXB Đại học Huế', '2013', 'Consequat amet deserunt qui adipisicing amet id laboris magna reprehenderit ea nisi amet magna. Culpa ut duis culpa nostrud ea. Mollit ex esse in nostrud magna fugiat cillum qui cupidatat eiusmod laboris elit ullamco nisi. Eiusmod cupidatat esse amet proident quis officia eiusmod ut reprehenderit id magna. Deserunt veniam sit eiusmod sit cillum in aliquip nostrud. Sint ea dolor anim magna proident aliqua cillum magna eiusmod laboris. Nulla sit adipisicing do sunt ut reprehenderit adipisicing irure.\r\nSint magna proident ea culpa commodo do nulla tempor magna mollit. Cillum Lorem exercitation occaecat minim amet. Tempor exercitation sunt in laborum deserunt velit eiusmod dolor sunt aliquip aliqua.\r\n', 'temp-10075522682831764585.jpg', b'1', '2021-12-27 08:36:00', NULL, NULL, NULL),
	(40, 'Sách Neocent', 228132, 0, 91, 66, 'Tanya Shaw', 57, 'NXB Đại học Quốc gia Hà Nội', '2000', 'Ea adipisicing ullamco cupidatat do elit nulla officia. Adipisicing quis reprehenderit mollit labore aliquip. Non sunt nisi anim ut occaecat consectetur cillum cillum do aute sit reprehenderit Lorem. Mollit proident enim aute pariatur velit dolor ex.\r\nAd sint adipisicing do officia excepteur dolor deserunt aliquip non aliquip labore. Enim labore nulla eiusmod est labore proident esse aliquip cillum excepteur occaecat et aliquip eiusmod. Dolore elit ullamco id ea enim culpa proident nostrud enim esse exercitation. Fugiat velit ea tempor exercitation. Voluptate laboris anim est nulla voluptate qui qui labore in dolore et velit quis. Fugiat elit sint magna laborum ad officia irure. Laboris non eu dolore pariatur.\r\n', 'temp-7329036107498680084.jpg', b'1', '2021-06-13 07:22:51', NULL, NULL, NULL),
	(41, 'Sách Isotrack', 387298, 20, 78, 202, 'Noemi Norris', 179, 'NXB Đại học Quốc gia Hà Nội', '2013', 'Eiusmod in dolor excepteur culpa ipsum eu sint culpa exercitation est qui. Commodo proident deserunt in velit proident voluptate dolore sit minim velit do dolor eiusmod nulla. Labore consectetur aliqua adipisicing labore exercitation adipisicing.\r\nDolor voluptate in ea qui irure qui. Anim voluptate duis cillum eiusmod ipsum non. Lorem incididunt ut ipsum cillum culpa consectetur officia. Eiusmod et laborum officia sint eiusmod non exercitation. Irure ipsum cupidatat id culpa magna in fugiat nostrud. Dolor ad quis duis in excepteur anim consectetur.\r\n', 'temp-7329036107498680084.jpg', b'0', '2022-01-03 08:33:27', NULL, NULL, NULL),
	(42, 'Sách Bedlam', 274131, 20, 28, 391, 'Josefa Allison', 31, 'NXB Đại học Huế', '2000', 'Culpa velit pariatur proident exercitation commodo labore exercitation anim dolore qui fugiat. Ipsum adipisicing consequat sunt elit cupidatat laborum laboris. Laborum consectetur aliquip eiusmod dolore anim fugiat commodo id ex irure occaecat excepteur consectetur. Irure do laboris mollit aute ex reprehenderit in eu eu veniam irure laborum cupidatat duis.\r\nIn commodo enim voluptate ex aute consequat aute labore pariatur magna do. Cillum cillum aliquip fugiat elit qui veniam aute minim occaecat sint ad. Nisi consectetur voluptate id eu tempor ea eu ad culpa aliquip elit ex.\r\n', 'temp-14438611480196141526.jpg', b'1', '2021-07-20 18:40:24', NULL, NULL, NULL),
	(43, 'Sách Eternis', 68882, 20, 45, 380, 'Betty Marsh', 63, 'NXB Đại học Sư phạm TP.HCM', '2020', 'Non sint laboris anim elit ipsum. Ut aute tempor nisi cillum esse. Lorem aliqua ut commodo cupidatat eu ullamco sint eiusmod do voluptate mollit adipisicing. Sint ea occaecat minim eu aliquip. Dolor enim adipisicing est labore anim laborum veniam. Duis consectetur dolor ad est nisi mollit occaecat exercitation eiusmod ad cillum fugiat elit. Mollit consequat nisi veniam eiusmod excepteur dolor enim incididunt minim deserunt minim excepteur.\r\nProident aute sint tempor et do occaecat eu nisi mollit ullamco excepteur sunt reprehenderit. Duis aliquip id magna anim do. Dolore irure minim consequat sint esse sint sint consectetur. Amet esse ullamco fugiat do officia tempor. Consectetur occaecat ipsum pariatur sint mollit nisi adipisicing Lorem tempor voluptate duis sunt eu. Excepteur culpa velit dolore cillum quis reprehenderit ad.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-06-09 14:58:26', NULL, NULL, NULL),
	(44, 'Sách Manufact', 71997, 20, 36, 343, 'Whitney Underwood', 293, 'NXB Đại học Sư phạm Hà Nội', '2013', 'Excepteur nisi minim in eu ad enim duis cillum sit tempor qui irure aliqua. Dolore laboris non id nisi ea aliqua id est incididunt excepteur est fugiat eiusmod. Nostrud eiusmod qui consectetur Lorem est officia tempor consectetur consequat enim ex aliqua ea culpa. Voluptate magna enim excepteur commodo excepteur incididunt labore. Commodo commodo sint eiusmod incididunt. Ullamco laboris ullamco nostrud amet dolore ipsum in aliquip enim fugiat.\r\nVeniam ipsum voluptate consequat magna magna sint. Nisi do Lorem irure est id labore anim eiusmod. Do est est nisi aliqua nisi duis. Laboris quis amet esse nulla cupidatat sit. Exercitation occaecat est commodo ad irure Lorem aute non exercitation veniam anim. Ex consequat non et culpa anim ipsum eiusmod.\r\n', 'temp-3015888053636485125.jpg', b'1', '2021-03-29 18:29:57', NULL, NULL, NULL),
	(45, 'Sách Golistic', 252810, 0, 99, 358, 'Valencia Kent', 166, 'NXB Giáo dục', '2006', 'Laboris est ea incididunt cupidatat. Id veniam laboris in sunt laborum ullamco aute esse sit officia labore aute dolore ad. Sit aliquip nisi ad cupidatat ullamco do Lorem pariatur labore irure. Ea elit culpa duis cillum reprehenderit laboris mollit in sit nulla laborum amet.\r\nLabore consequat voluptate deserunt nostrud eu elit culpa est laboris. Commodo nisi mollit sit nisi id sit pariatur quis anim cillum enim fugiat. Pariatur minim nostrud irure cupidatat. Consequat amet occaecat aliquip sint adipisicing occaecat quis labore esse minim. Reprehenderit mollit anim labore adipisicing. Sunt laborum fugiat eu cillum. Ipsum ut dolor ex deserunt pariatur ullamco nostrud laborum amet cillum enim et incididunt.\r\n', 'temp-13862094760385571107.jpg', b'0', '2021-06-07 00:01:21', NULL, NULL, NULL),
	(46, 'Sách Dognosis', 384754, 20, 58, 484, 'Alisa Waters', 129, 'NXB Đại học Sư phạm TP.HCM', '1997', 'Do qui cillum sint in aute tempor. Nisi velit amet do incididunt consequat proident qui nisi exercitation eiusmod excepteur aliqua deserunt. Esse exercitation cupidatat officia id sint irure dolore nisi. Deserunt ex velit id aliqua consectetur. Magna aute ad laboris aliquip irure esse velit ipsum nostrud est sint in voluptate aliqua.\r\nIn exercitation culpa dolore in duis laboris cillum eiusmod enim ullamco incididunt Lorem. Anim amet ut ea anim minim magna ad dolor proident ut cupidatat in exercitation ex. Exercitation nisi irure nisi mollit irure exercitation magna reprehenderit mollit dolore irure reprehenderit nisi deserunt. Consectetur do excepteur enim sunt anim nulla culpa incididunt ipsum. Lorem in proident quis irure sunt adipisicing amet ullamco excepteur consectetur laboris id sunt. Elit nulla veniam id ea ipsum qui consequat incididunt labore qui veniam.\r\n', 'temp-8262627340495498759.jpg', b'0', '2022-01-13 13:55:09', NULL, NULL, NULL),
	(47, 'Sách Magneato', 62859, 20, 76, 213, 'Bell Anthony', 439, 'NXB Đại học Sư phạm TP.HCM', '2002', 'Commodo nisi sint nulla et duis nostrud sunt nulla. Consequat ad ad excepteur sit aliqua non. Laborum et culpa commodo qui veniam sunt labore nostrud ut est laboris in non. Anim id duis pariatur esse excepteur. Aute ullamco do commodo labore ut consectetur aute pariatur ea Lorem deserunt consequat ex ea.\r\nAliquip proident commodo eu velit veniam mollit ipsum reprehenderit quis. Ullamco duis est esse aliqua officia laborum minim incididunt aliqua. Do mollit ipsum dolor culpa non proident et amet nulla elit consectetur ex tempor. Voluptate qui laborum officia et. Sint magna do aliqua officia aliqua dolor dolor. Commodo deserunt irure qui est nulla. Enim duis aliqua ex do tempor minim.\r\n', 'temp-7329036107498680084.jpg', b'0', '2021-09-01 13:00:43', NULL, NULL, NULL),
	(48, 'Sách Comdom', 320796, 0, 41, 221, 'Bowen Blackburn', 127, 'NXB Giáo dục', '1999', 'Adipisicing laborum fugiat quis et. Laboris sint magna exercitation Lorem elit enim eiusmod consequat aliqua pariatur duis. Ad est dolor aliquip occaecat commodo. Commodo nisi incididunt voluptate cupidatat cillum nisi qui ex aute occaecat exercitation. Ut officia quis cupidatat sint veniam enim consequat deserunt voluptate dolor nisi. In dolore ea nisi aliquip aliqua ea reprehenderit ex culpa Lorem cupidatat ullamco.\r\nConsequat ea in nisi eu quis minim nulla consequat cillum magna laboris quis Lorem. Culpa laborum pariatur nostrud officia eu est amet excepteur tempor ex ad. Nostrud cupidatat ea fugiat velit in ipsum dolore anim voluptate do. Exercitation dolore officia mollit nostrud excepteur qui enim velit duis.\r\n', 'temp-3984373128647845854.jpg', b'1', '2021-02-17 19:21:04', NULL, NULL, NULL),
	(49, 'Sách Cognicode', 397947, 0, 75, 225, 'Strickland Flores', 166, 'NXB Đại học Huế', '2016', 'Dolor exercitation incididunt ea voluptate Lorem irure proident quis ullamco occaecat adipisicing incididunt. Proident aliqua est deserunt nostrud est. Ipsum mollit ad sit magna minim cupidatat minim fugiat velit sint est ea id ad.\r\nMollit enim nostrud deserunt voluptate aute id velit et nulla ex ipsum. Deserunt et aliqua labore ipsum sit ullamco ipsum do. Consequat officia commodo dolor adipisicing do ea mollit id ullamco exercitation incididunt aliquip.\r\n', 'temp-13064240004351430671.jpg', b'0', '2021-07-30 02:38:48', NULL, NULL, NULL),
	(50, 'Sách Lyrichord', 118039, 0, 34, 392, 'Mcconnell Case', 284, 'NXB Đại học Sư phạm Hà Nội', '1996', 'Ea nostrud enim est eu pariatur velit laborum commodo. Reprehenderit pariatur magna nulla eu. Incididunt anim ipsum id ea laborum ad duis amet proident. Nisi do commodo esse nulla ea esse laboris. Sint excepteur laboris veniam incididunt aliquip nulla consequat labore enim culpa. Minim Lorem dolor consequat occaecat ullamco sunt eiusmod adipisicing id.\r\nNostrud in eu reprehenderit et veniam ex non veniam ad. Commodo mollit irure sit eu dolore tempor adipisicing ipsum elit exercitation labore quis dolor velit. Ut voluptate qui adipisicing cillum est excepteur exercitation consectetur sit elit laborum. Amet reprehenderit sit mollit qui pariatur laborum in et id adipisicing. Consectetur dolore nulla ad duis fugiat reprehenderit dolor aliquip sint cillum. Sunt laborum incididunt nisi velit amet ullamco.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-05-14 21:03:30', NULL, NULL, NULL),
	(51, 'Sách Comtext', 134415, 20, 72, 480, 'Kristine Weiss', 95, 'NXB Giáo dục', '2021', 'Deserunt exercitation in laborum velit non commodo adipisicing excepteur culpa. Adipisicing consequat nostrud esse labore proident dolor reprehenderit eiusmod deserunt nulla fugiat ad magna proident. Dolor deserunt pariatur ex duis nulla excepteur nisi. Ullamco nostrud minim mollit culpa sit consectetur dolor esse aliquip mollit enim eu ad pariatur. Qui commodo anim est Lorem. Eiusmod dolor occaecat sunt ex enim eu duis ullamco commodo dolor. Irure minim nostrud amet irure exercitation laboris.\r\nId fugiat minim incididunt excepteur excepteur voluptate ad duis. Velit qui amet sit laboris qui dolor ex aute consequat nisi fugiat. Ipsum anim officia sunt ex nulla eu ullamco. Reprehenderit excepteur occaecat dolor laborum non exercitation amet dolor veniam cillum sint nulla. Culpa tempor elit laboris enim id incididunt.\r\n', 'temp-13862094760385571107.jpg', b'1', '2021-09-13 12:22:19', NULL, NULL, NULL),
	(52, 'Sách Myopium', 349335, 20, 57, 482, 'Mooney Freeman', 71, 'NXB Giáo dục', '2008', 'Eu aliqua exercitation laborum irure ea id officia. Do laboris reprehenderit anim exercitation pariatur consequat ut nostrud. Ad esse qui eiusmod mollit qui nostrud voluptate sit.\r\nNostrud velit ea non veniam reprehenderit eiusmod. Nisi labore sint duis ipsum cupidatat do. Culpa cillum minim velit deserunt. Irure quis cupidatat occaecat veniam reprehenderit nisi sunt exercitation amet consequat ea consectetur pariatur consequat. Consectetur et ex non commodo dolor proident.\r\n', 'temp-7329036107498680084.jpg', b'1', '2021-07-08 05:49:12', NULL, NULL, NULL),
	(53, 'Sách Bittor', 388247, 20, 76, 270, 'Foley Payne', 486, 'NXB Giáo dục', '2016', 'Quis fugiat eiusmod deserunt duis eu qui aliqua magna Lorem magna et culpa. Velit sunt aliquip officia sunt mollit enim enim laboris. Anim consectetur ullamco quis ut consequat laborum ullamco sit excepteur elit laborum. Voluptate est proident ullamco consectetur excepteur dolor aliqua. Id eiusmod esse dolore anim deserunt aliquip enim occaecat pariatur consequat ipsum amet minim. Do culpa excepteur ea non dolor minim voluptate.\r\nNisi occaecat incididunt aliqua reprehenderit. Laborum pariatur esse dolore incididunt eu aute mollit cillum. Sint mollit aliqua tempor sit irure anim incididunt adipisicing voluptate irure duis commodo officia anim. Laborum pariatur exercitation laboris est labore officia do elit id. Nisi aute do duis eu ea cillum ex eiusmod sunt veniam esse velit culpa. Et laboris non sit duis deserunt sint incididunt mollit sit eiusmod esse exercitation.\r\n', 'temp-18128511448457962576.jpg', b'0', '2021-12-13 20:59:32', NULL, NULL, NULL),
	(54, 'Sách Chillium', 144536, 20, 81, 417, 'Wynn Poole', 73, 'NXB Đại học Quốc gia Hà Nội', '1998', 'Eiusmod pariatur aliquip aliqua duis Lorem nisi duis ullamco. Esse adipisicing fugiat exercitation laboris reprehenderit excepteur. Amet magna anim amet anim tempor culpa aliqua nostrud nulla Lorem. Cillum do minim voluptate deserunt nisi ex commodo. Eiusmod commodo ut exercitation reprehenderit Lorem cupidatat aute culpa amet excepteur nulla laboris. Ex sint nulla amet officia elit in minim ad veniam sunt aliqua. Est excepteur non in occaecat laborum consectetur.\r\nEa cupidatat velit Lorem exercitation adipisicing in in nulla cupidatat labore Lorem ea aute ut. Lorem laboris id laboris ut ea tempor eiusmod laboris labore nostrud ut. Tempor eiusmod tempor est veniam ipsum quis veniam ut fugiat aliquip. Nisi duis id est anim amet do veniam laboris et aliquip consequat esse duis amet. Nulla id eu incididunt cupidatat id non cillum consequat. Nisi laborum occaecat ex anim id fugiat incididunt. Elit duis sint qui culpa aliquip duis fugiat adipisicing dolor cillum cillum voluptate.\r\n', 'temp-12235989262213754276.jpg', b'0', '2021-08-14 08:42:55', NULL, NULL, NULL),
	(55, 'Sách Ronelon', 201895, 20, 32, 451, 'Frederick Gilliam', 51, 'NXB Đại học Quốc gia Hà Nội', '2020', 'Ex commodo consectetur proident elit tempor in minim nostrud elit nostrud. Voluptate laborum tempor ullamco non dolore aliquip dolore voluptate voluptate. Dolore enim minim et nostrud ex labore officia sunt. Enim esse voluptate exercitation tempor laborum velit. In magna culpa labore ex consectetur amet pariatur fugiat tempor eu pariatur. Do anim eu dolor ut proident. Ipsum mollit non magna ut mollit mollit ut nulla laboris ad aute aliquip sunt sint.\r\nEsse sit dolor qui nulla dolor magna. Fugiat voluptate dolore esse voluptate irure duis fugiat duis ea fugiat. Id amet qui ea veniam. Aliqua tempor culpa ea minim labore nulla proident eu aute eu in quis consectetur. Culpa fugiat anim sunt cupidatat elit eu deserunt voluptate et. Sit voluptate laboris id culpa cupidatat. Ut qui Lorem ipsum id in nulla eu ad aliqua in laboris eu culpa.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-06-08 19:42:51', NULL, NULL, NULL),
	(56, 'Sách Roughies', 124514, 0, 31, 196, 'Pat Atkinson', 50, 'NXB Giáo dục', '2004', 'Aute aliqua dolore qui quis veniam pariatur. Aliquip ut anim qui duis proident consectetur occaecat ut est. Veniam incididunt occaecat veniam culpa culpa enim tempor et.\r\nEst consequat nulla amet ullamco labore incididunt. Ex aliqua duis ad amet culpa occaecat magna laboris ex sunt. Id ea tempor irure non ullamco nulla aliquip ipsum anim magna. Exercitation fugiat ex officia pariatur in anim aute veniam. Eiusmod aliqua cupidatat quis ea occaecat eu proident. Eiusmod magna labore incididunt velit aliquip est fugiat in laborum cillum incididunt.\r\n', 'temp-12235989262213754276.jpg', b'1', '2021-05-12 06:14:00', NULL, NULL, NULL),
	(57, 'Sách Printspan', 153427, 0, 32, 234, 'Bartlett Hampton', 122, 'NXB Đại học Huế', '2013', 'Aliqua reprehenderit consectetur incididunt elit ullamco veniam tempor tempor incididunt labore elit. Exercitation quis pariatur pariatur ipsum ex minim. Commodo laborum qui irure ut commodo ipsum laborum Lorem occaecat excepteur in occaecat. Do ex occaecat officia ad pariatur. Sunt elit ullamco quis cillum nostrud nostrud pariatur. Ad velit officia commodo ea eiusmod exercitation aliquip et anim deserunt. Labore cillum commodo ex elit quis minim ea voluptate consequat.\r\nVelit et duis commodo cillum mollit incididunt labore. Anim ad deserunt commodo qui ea excepteur culpa qui eiusmod consequat amet. Amet do ullamco nulla laborum sit mollit aute sit ipsum fugiat adipisicing sit eu eiusmod. Dolor in nulla dolor esse consectetur voluptate ea duis fugiat commodo esse ipsum veniam qui.\r\n', 'temp-18128511448457962576.jpg', b'0', '2021-12-27 22:25:08', NULL, NULL, NULL),
	(58, 'Sách Quantalia', 101367, 20, 90, 305, 'Cherry Hopper', 409, 'NXB Giáo dục', '2019', 'Ex sunt elit minim commodo minim reprehenderit consectetur ea dolor. Sit reprehenderit velit labore deserunt ea incididunt aute pariatur ex. Est adipisicing veniam dolore ut in ad magna sint.\r\nAd qui cillum nulla pariatur mollit ipsum duis labore officia dolor ullamco aliquip mollit. Aliqua labore occaecat tempor commodo eu sunt magna proident duis. Eu magna officia aute minim ex aliquip irure et sunt anim pariatur excepteur sit laboris. Occaecat laborum est voluptate velit. Quis id aliquip eiusmod deserunt nostrud ullamco qui deserunt pariatur eiusmod ea consequat. Officia consectetur ipsum ea dolore magna. Lorem ut mollit magna amet labore id officia veniam ea id est aliqua.\r\n', 'temp-14438611480196141526.jpg', b'0', '2021-06-24 00:23:29', NULL, NULL, NULL),
	(59, 'Sách Fortean', 243231, 0, 94, 444, 'Tabitha Shepherd', 357, 'NXB Đại học Quốc gia Hà Nội', '2008', 'Amet et elit labore fugiat magna ullamco proident ut excepteur ea elit commodo. Nisi anim laborum nisi irure eiusmod labore. Consectetur sit enim ex veniam eiusmod mollit nulla irure voluptate.\r\nCommodo exercitation sit quis sit officia commodo voluptate aliqua minim. Et dolor non occaecat amet enim ex elit. Amet nisi laborum exercitation duis culpa irure duis eu laborum cupidatat duis excepteur laboris Lorem. Commodo dolore cillum esse ullamco. Enim excepteur elit voluptate ex laboris ut qui. Eiusmod duis veniam dolore dolore enim fugiat. Aliqua adipisicing nulla duis anim esse nostrud in et pariatur.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-09-21 04:22:31', NULL, NULL, NULL),
	(60, 'Sách Kengen', 262167, 20, 15, 473, 'Cooke Barber', 79, 'NXB Đại học Quốc gia Hà Nội', '1997', 'Proident sint quis culpa do id eiusmod mollit in culpa ut anim. Exercitation tempor laboris ea ex. Pariatur elit eu duis reprehenderit reprehenderit aliquip magna sunt cupidatat laborum officia esse. Occaecat aliqua qui pariatur minim dolore. Aliquip exercitation reprehenderit nostrud elit cupidatat. Aliqua ex commodo dolore nulla voluptate mollit.\r\nMollit proident est aliquip esse qui minim dolor deserunt mollit. Qui est excepteur voluptate in irure nostrud qui. Reprehenderit Lorem enim labore aliquip magna do nulla amet.\r\n', 'temp-3984373128647845854.jpg', b'0', '2021-11-22 09:02:54', NULL, NULL, NULL),
	(61, 'Sách Dyno', 422493, 20, 50, 32, 'Laura Simpson', 354, 'NXB Đại học Quốc gia Hà Nội', '1997', 'Proident pariatur ullamco elit aliquip mollit magna sunt ad eiusmod. Ad qui do occaecat do laboris est. Dolor nisi ea exercitation magna ex tempor est reprehenderit magna officia.\r\nLaboris aute mollit incididunt tempor eu aliqua amet sit. Eiusmod aute commodo reprehenderit eiusmod ea consectetur eu. Labore eiusmod nulla ullamco elit adipisicing esse sit proident nostrud magna. Sunt aute et minim consectetur cupidatat dolor aliqua do reprehenderit occaecat id nisi aliqua. Id duis labore sunt sunt aliquip veniam.\r\n', 'temp-13064240004351430671.jpg', b'1', '2021-09-15 23:34:31', NULL, NULL, NULL),
	(62, 'Sách Geekmosis', 396421, 0, 96, 210, 'Gayle Castillo', 354, 'NXB Đại học Huế', '2006', 'Anim proident et ex ut irure cillum magna non incididunt ipsum dolor. Dolore consectetur amet eiusmod officia veniam. Officia aliquip aute excepteur eiusmod enim non Lorem amet. Duis eiusmod cupidatat eu in fugiat cupidatat enim irure ullamco aliqua. Adipisicing consequat minim officia ex tempor.\r\nExercitation velit ea cillum est sunt ea sit mollit. Reprehenderit adipisicing et nulla velit fugiat pariatur deserunt incididunt ipsum qui veniam est. Pariatur ex ad deserunt incididunt laborum laboris incididunt commodo.\r\n', 'temp-10075522682831764585.jpg', b'1', '2021-02-19 22:53:34', NULL, NULL, NULL),
	(63, 'Sách Earbang', 162841, 20, 21, 47, 'Elliott Pace', 150, 'NXB Đại học Sư phạm TP.HCM', '2017', 'Amet veniam voluptate consequat adipisicing officia et fugiat cillum ut ullamco elit ea do sit. Ipsum incididunt elit laboris Lorem nostrud duis ipsum sunt id ullamco qui commodo consectetur. Officia elit ad voluptate occaecat consectetur magna do deserunt. Do eu Lorem laborum proident Lorem adipisicing incididunt occaecat ut deserunt dolor. Proident et ea fugiat est incididunt sint id dolor enim laborum laborum officia id. Excepteur anim cillum dolor irure consectetur incididunt do sunt culpa nisi excepteur sit cupidatat.\r\nExercitation adipisicing ipsum magna ex exercitation consequat ullamco. Sunt excepteur nisi do eiusmod aute exercitation labore amet. Pariatur magna est aute id. Est ad tempor sint amet anim.\r\n', 'temp-8262627340495498759.jpg', b'1', '2021-09-02 00:50:35', NULL, NULL, NULL),
	(64, 'Sách Rodeology', 473815, 0, 10, 370, 'Chelsea Wong', 396, 'NXB Giáo dục', '2009', 'Ipsum magna laborum do officia non quis duis sunt est ipsum. Eu nulla irure aliquip anim minim elit aliqua officia do culpa enim in. Ex qui esse dolor nulla occaecat mollit laborum sunt laboris laboris. Laboris nostrud cillum cupidatat do reprehenderit voluptate elit eu fugiat consectetur. Duis aute labore ea aliqua proident nisi amet aliquip Lorem irure amet veniam aute. Non ea esse duis eiusmod sint nisi et consectetur aliqua consequat cillum ad eu.\r\nNulla Lorem anim aute exercitation consectetur pariatur occaecat exercitation eu commodo. Esse culpa esse enim labore dolore sit deserunt. Ea et qui in Lorem.\r\n', 'temp-14438611480196141526.jpg', b'0', '2021-07-17 20:36:32', NULL, NULL, NULL),
	(65, 'Sách Locazone', 466018, 0, 58, 196, 'Katina Terrell', 294, 'NXB Đại học Quốc gia Hà Nội', '1996', 'Deserunt cillum culpa in anim voluptate quis quis laborum in non. Irure aliqua laboris exercitation veniam eu. Excepteur enim dolore incididunt magna ad ea anim elit ullamco eiusmod sit incididunt. Ut eiusmod proident sint est non culpa nulla tempor adipisicing.\r\nEiusmod elit occaecat magna nostrud sit. Et in dolore ipsum et cillum reprehenderit voluptate. Sint velit proident commodo ullamco elit esse exercitation exercitation nostrud qui.\r\n', 'temp-6352099207348952932.jpg', b'1', '2021-12-08 16:10:27', NULL, NULL, NULL),
	(66, 'Sách Zentime', 8106, 20, 25, 162, 'Alfreda Randolph', 161, 'NXB Đại học Sư phạm Hà Nội', '2021', 'Quis aliquip minim irure nisi. Sint in quis adipisicing eu aliqua ex id consectetur aliquip excepteur duis adipisicing duis. Labore eu duis eu consectetur qui ipsum nisi excepteur quis minim duis. Consectetur aute ipsum ipsum anim dolore esse proident do magna adipisicing ipsum qui. Occaecat reprehenderit consequat ad fugiat reprehenderit dolore cillum nulla et.\r\nUt dolor est reprehenderit duis. Excepteur tempor anim fugiat eu aliquip enim nisi anim pariatur. Sint pariatur cillum laborum id duis voluptate ipsum labore quis voluptate tempor fugiat laborum. Anim officia id Lorem reprehenderit elit minim Lorem voluptate id minim velit ipsum. Fugiat Lorem cupidatat duis id id fugiat fugiat occaecat.\r\n', 'temp-13862094760385571107.jpg', b'0', '2021-12-13 04:25:39', NULL, NULL, NULL),
	(67, 'Sách Xelegyl', 117223, 0, 40, 270, 'Helene Campbell', 340, 'NXB Đại học Huế', '2013', 'Veniam et et fugiat cillum veniam consectetur dolor laborum ipsum aliquip in commodo. Occaecat nisi proident et est dolor voluptate commodo. Sit culpa do commodo nulla ut ad excepteur quis. Voluptate cillum cillum labore non consectetur. Pariatur in ea ex veniam ad veniam in fugiat commodo. Veniam consequat culpa anim aliqua sit nostrud et fugiat esse non non commodo commodo quis.\r\nCillum ut aliquip mollit Lorem ea exercitation. Sit ullamco quis exercitation pariatur. Exercitation dolore magna aliquip laborum occaecat sit. Laboris velit sunt nisi occaecat aliquip qui exercitation ut irure amet cupidatat. Minim officia exercitation consequat ad. Nostrud nisi aute sit ut ad irure ullamco.\r\n', 'temp-8476700387786158058.jpg', b'0', '2021-09-10 18:01:32', NULL, NULL, NULL),
	(68, 'Sách Oatfarm', 299156, 0, 43, 90, 'Joyner Jarvis', 10, 'NXB Đại học Huế', '2017', 'Dolore aliquip ullamco id ut cupidatat exercitation nulla non veniam adipisicing do elit id. Ea dolor dolor duis esse ex. Irure pariatur aute minim qui veniam in amet nostrud. Dolor labore magna incididunt id mollit sit aute minim nisi amet veniam magna mollit. Excepteur ut cillum veniam labore non enim excepteur eu. Eiusmod cupidatat fugiat cillum cillum. Tempor eu adipisicing consectetur dolor non.\r\nElit voluptate veniam veniam consequat adipisicing duis amet id laboris cillum eiusmod laborum eu. Magna reprehenderit laborum laborum enim qui in aliquip. Officia cillum tempor consectetur pariatur eu veniam non magna elit. Velit aute do amet ad laboris do dolore reprehenderit do ex consectetur excepteur.\r\n', 'temp-3984373128647845854.jpg', b'0', '2021-06-18 10:25:37', NULL, NULL, NULL),
	(69, 'Sách Dymi', 382118, 20, 50, 381, 'Deirdre Hatfield', 442, 'NXB Giáo dục', '2020', 'Eiusmod anim exercitation aliquip et cupidatat id consectetur exercitation nostrud enim irure mollit non. Excepteur nisi et quis duis ad anim minim. Tempor consectetur id consectetur tempor id culpa amet culpa esse velit laborum veniam est proident. Ipsum proident ullamco ex ullamco velit exercitation. Eiusmod culpa eiusmod aute velit velit veniam tempor esse aliqua. Non nisi Lorem quis id sit consectetur qui magna magna quis ex. Aliqua incididunt adipisicing id tempor.\r\nOccaecat sint elit reprehenderit amet. Esse do sint id magna et nulla. Ipsum cupidatat mollit mollit labore consequat excepteur tempor do sint laborum sit adipisicing id reprehenderit. Do ea consectetur adipisicing do consectetur laborum. Amet elit laborum voluptate ipsum mollit adipisicing Lorem nisi labore ea tempor eiusmod amet.\r\n', 'temp-13064240004351430671.jpg', b'0', '2021-02-12 08:13:38', NULL, NULL, NULL),
	(70, 'Sách Injoy', 444695, 20, 71, 176, 'Patty Caldwell', 79, 'NXB Đại học Quốc gia Hà Nội', '2001', 'Quis aute occaecat fugiat mollit eu est sunt eu ipsum do excepteur culpa. Quis id adipisicing culpa Lorem pariatur sit amet ut fugiat. Sit aliquip adipisicing et reprehenderit. Do consectetur commodo et commodo exercitation consectetur aliquip sit quis pariatur reprehenderit magna consequat cupidatat. Cupidatat ea adipisicing ex velit reprehenderit dolor sunt. Velit elit officia ut fugiat cupidatat aute consequat culpa. Do excepteur adipisicing non ipsum ullamco.\r\nIpsum occaecat deserunt eiusmod exercitation commodo velit id ut aliquip cillum laborum do nulla reprehenderit. Ut deserunt voluptate ex mollit. Elit proident ex in velit. Cillum culpa dolor in elit adipisicing aute magna anim qui sunt.\r\n', 'temp-13862094760385571107.jpg', b'0', '2021-11-16 15:29:49', NULL, NULL, NULL),
	(71, 'Sách Globoil', 375062, 0, 25, 59, 'Steele Henson', 362, 'NXB Đại học Sư phạm Hà Nội', '2016', 'Eiusmod do laboris magna ex eiusmod laboris nostrud aliqua anim. Non esse quis amet officia ea enim. Excepteur id incididunt aliquip labore velit fugiat Lorem ad dolor ipsum est ex. Quis qui ex nulla ipsum cillum ad id dolor ex eu. Consequat sunt et tempor deserunt duis ex mollit commodo.\r\nUllamco elit amet id sit pariatur quis sint anim nulla. Cupidatat ullamco ex anim magna adipisicing veniam anim duis ipsum deserunt magna aliqua. Elit pariatur ullamco est qui esse cillum. Adipisicing adipisicing ipsum occaecat consequat do pariatur irure ad. Reprehenderit magna sit nostrud anim quis est laboris deserunt ut esse duis. Exercitation non elit aliqua minim eu ipsum do sint do officia minim.\r\n', 'temp-16741118072528735594.jpg', b'1', '2021-12-22 05:50:21', NULL, NULL, NULL),
	(72, 'Sách Daido', 170140, 20, 47, 398, 'Dotson Lloyd', 136, 'NXB Đại học Quốc gia Hà Nội', '2012', 'Dolore ipsum occaecat in magna elit Lorem est. Quis eu anim minim non sit minim. Officia adipisicing sit ullamco sunt mollit pariatur ullamco sint sint consectetur est qui. Fugiat cillum incididunt amet adipisicing ullamco ea Lorem voluptate est consectetur quis enim ipsum. Cillum dolore cupidatat et labore excepteur exercitation non sunt nostrud laborum non. Nostrud et enim aute enim ipsum dolore occaecat occaecat nostrud nulla aliquip aliquip sit.\r\nCupidatat veniam aute cillum commodo aliquip quis aliquip eu adipisicing minim ipsum. Sit enim aliqua excepteur cupidatat. Enim consequat adipisicing excepteur in sint veniam esse officia ex Lorem sint ad do.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-06-24 21:03:26', NULL, NULL, NULL),
	(73, 'Sách Coash', 443683, 20, 59, 367, 'Lillie Hurst', 67, 'NXB Đại học Sư phạm TP.HCM', '2008', 'Veniam duis cupidatat adipisicing sunt sit. Enim laboris eu veniam nulla nulla enim. Et velit sunt pariatur dolore et quis reprehenderit consectetur eiusmod fugiat et nisi elit dolor. Est aliqua commodo irure quis est do culpa quis officia culpa nostrud. Anim velit dolore amet magna excepteur amet commodo aliqua consectetur voluptate ut consectetur.\r\nQui ipsum nulla ex pariatur eu in cupidatat. Voluptate in ipsum officia do aliqua ipsum nostrud officia consequat proident excepteur laborum. Exercitation ex aute elit duis ad eiusmod. Tempor ullamco qui nostrud ipsum enim sit. Mollit ullamco in dolore ullamco magna proident qui qui laborum.\r\n', 'temp-3984373128647845854.jpg', b'0', '2021-12-12 17:50:17', NULL, NULL, NULL),
	(74, 'Sách Automon', 109059, 0, 70, 60, 'Melissa Hayes', 301, 'NXB Đại học Sư phạm Hà Nội', '2009', 'Dolor ex commodo Lorem fugiat. Ullamco dolor proident mollit consequat ex irure adipisicing. Ut enim fugiat deserunt cupidatat sunt officia reprehenderit dolore sint qui culpa.\r\nDolor minim incididunt pariatur minim qui commodo veniam cupidatat. Exercitation culpa do commodo voluptate dolor amet aute eiusmod veniam aute aute pariatur adipisicing veniam. Est voluptate anim anim enim aliqua dolore ad ex ex et et. Exercitation Lorem amet sit in ex culpa incididunt irure. Enim sunt duis dolore cupidatat. Dolor eiusmod consectetur incididunt officia nostrud qui amet.\r\n', 'temp-10075522682831764585.jpg', b'0', '2021-05-21 22:34:50', NULL, NULL, NULL),
	(75, 'Sách Genmom', 118544, 0, 79, 119, 'Delores Johnson', 418, 'NXB Giáo dục', '2007', 'Commodo eiusmod est eu eu. Cillum deserunt aliquip amet cupidatat Lorem sint. Cillum mollit pariatur ullamco excepteur dolor incididunt Lorem duis laboris irure ipsum sunt irure. In amet sunt pariatur mollit mollit sint amet. Elit reprehenderit veniam mollit laboris fugiat proident fugiat occaecat elit nostrud minim. Lorem exercitation reprehenderit id nisi do. Veniam reprehenderit nulla sint id cillum est eu irure eiusmod nisi aute.\r\nEiusmod id nostrud magna culpa laboris in duis exercitation elit nulla consequat in quis non. Veniam proident exercitation nisi et sint tempor. Do incididunt ea officia officia ut. Est amet irure qui consectetur eiusmod ut elit aliqua elit exercitation quis.\r\n', 'temp-18128511448457962576.jpg', b'0', '2021-02-10 06:36:37', NULL, NULL, NULL),
	(76, 'Sách Idetica', 27956, 0, 69, 50, 'Veronica Coffey', 104, 'NXB Giáo dục', '2014', 'Aliquip enim commodo dolore nulla dolore mollit exercitation fugiat eu ex commodo. Incididunt ipsum amet incididunt Lorem. Consequat magna amet sint nisi labore nisi. Aute laborum mollit aute reprehenderit ad. Ut nostrud fugiat laborum officia anim dolore incididunt dolore adipisicing consequat nostrud duis ea.\r\nSint sint minim eiusmod nisi. Veniam culpa aute dolor sint elit proident do. Labore magna nulla laboris aute labore et excepteur nisi aliqua.\r\n', 'temp-6352099207348952932.jpg', b'0', '2021-02-12 17:56:55', NULL, NULL, NULL),
	(77, 'Sách Enerforce', 364658, 0, 89, 207, 'Spencer Marshall', 475, 'NXB Đại học Sư phạm TP.HCM', '1999', 'Id laborum aute duis id excepteur exercitation nostrud ad qui sit. Occaecat non veniam qui non velit cupidatat. Non Lorem culpa cillum enim et amet pariatur id pariatur ea sint ea. Pariatur voluptate quis culpa occaecat dolor id consequat quis commodo aliquip deserunt. Consequat elit consequat labore veniam est laboris esse esse. Duis commodo sint voluptate sint mollit esse labore officia reprehenderit laborum irure id.\r\nSunt eu enim labore anim mollit sint ipsum labore cillum consequat cupidatat velit. Culpa commodo irure enim consequat velit reprehenderit nostrud reprehenderit sunt. Exercitation nisi sit id amet duis ullamco officia dolor ea consequat adipisicing minim enim. Cupidatat Lorem cupidatat officia aute et mollit ad irure elit ut.\r\n', 'temp-7329036107498680084.jpg', b'0', '2022-01-04 12:49:25', NULL, NULL, NULL),
	(78, 'Sách Kenegy', 104405, 0, 92, 406, 'Carrie Boone', 150, 'NXB Đại học Sư phạm TP.HCM', '2011', 'Pariatur ex labore deserunt non deserunt aliqua non reprehenderit elit fugiat elit officia reprehenderit laboris. Irure veniam veniam fugiat aliqua officia ullamco ex sit. Qui esse consequat ipsum sunt et aliqua exercitation Lorem deserunt tempor sunt ullamco. Esse fugiat laborum ut Lorem ad fugiat reprehenderit. Exercitation consequat cupidatat anim sint exercitation est dolor mollit ut cillum non eiusmod eu voluptate. Labore elit sunt labore velit ad anim. Dolor id aliquip et anim sint sint proident duis in sint.\r\nUllamco ad id deserunt reprehenderit deserunt ad laborum ad. Laboris id amet dolor ad ex ut id. Exercitation et velit duis amet elit.\r\n', 'temp-7329036107498680084.jpg', b'1', '2022-01-04 03:35:13', NULL, NULL, NULL),
	(79, 'Sách Krag', 293321, 20, 84, 31, 'Isabelle Justice', 346, 'NXB Đại học Sư phạm TP.HCM', '2008', 'Aute irure consectetur sunt do incididunt. Nostrud labore excepteur ea tempor esse id. Fugiat esse pariatur tempor labore in consequat in ea duis laboris tempor Lorem enim fugiat. Irure proident excepteur proident cillum voluptate ex. Laborum minim eu do nisi nostrud quis quis aliquip qui magna. Commodo adipisicing reprehenderit consectetur fugiat ex sint magna cillum veniam proident occaecat adipisicing consequat id. Ullamco voluptate enim velit do laboris cillum irure amet adipisicing culpa cupidatat laboris adipisicing.\r\nElit deserunt incididunt incididunt sint occaecat do. Eu nulla dolor sunt laborum mollit deserunt eu aute. Et minim Lorem commodo cillum excepteur quis amet aliquip deserunt. Sunt aliquip tempor adipisicing consectetur quis voluptate exercitation. Anim cillum proident tempor in incididunt fugiat proident amet aliqua esse.\r\n', 'temp-3015888053636485125.jpg', b'0', '2021-10-25 08:41:19', NULL, NULL, NULL),
	(80, 'Sách Sealoud', 380540, 0, 73, 268, 'Adele Martinez', 499, 'NXB Đại học Huế', '2019', 'Ut esse aliquip proident excepteur et fugiat ullamco fugiat dolor et velit fugiat sit. Occaecat nisi cillum ex consequat deserunt irure sint laborum. Ut dolor qui et do enim. Quis anim id cillum quis minim ad culpa. Mollit Lorem ut aute ex et enim. Enim nostrud labore cillum laboris nisi laborum duis irure laboris cillum deserunt proident. Deserunt ex ut dolor ex reprehenderit est.\r\nIpsum laborum cupidatat cillum qui magna reprehenderit anim do velit nostrud quis ipsum pariatur velit. Consectetur commodo excepteur mollit in do officia veniam. Proident id occaecat dolore aliqua Lorem ea officia veniam commodo Lorem elit tempor eu.\r\n', 'temp-7329036107498680084.jpg', b'0', '2021-08-01 12:32:05', NULL, NULL, NULL),
	(81, 'Sách Isologics', 268413, 20, 32, 384, 'Jewell Whitfield', 381, 'NXB Đại học Sư phạm Hà Nội', '2010', 'Ut sit fugiat reprehenderit ipsum aliqua incididunt consequat reprehenderit. Consequat eiusmod minim cupidatat anim id veniam voluptate eu tempor nisi proident quis elit. Elit consequat voluptate aliqua consectetur.\r\nLaboris pariatur sit eiusmod quis culpa. Duis ea commodo consectetur ad enim sit id nulla minim. Exercitation elit nostrud voluptate Lorem officia magna excepteur veniam officia sunt voluptate ullamco consequat. Adipisicing tempor labore sit ad eiusmod ipsum veniam occaecat velit exercitation occaecat enim aute ad. Irure dolore velit culpa pariatur eiusmod velit laborum reprehenderit esse commodo magna aliquip officia et. Irure nulla id consequat aute cupidatat ad ipsum.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-11-28 09:51:08', NULL, NULL, NULL),
	(82, 'Sách Exiand', 187140, 20, 54, 320, 'Giles Mcdowell', 280, 'NXB Giáo dục', '2020', 'Consequat reprehenderit reprehenderit aliquip amet aliqua fugiat duis eiusmod est in in nostrud. Nostrud occaecat adipisicing incididunt anim esse sint quis irure officia minim. Voluptate labore elit occaecat nostrud qui.\r\nId adipisicing aliqua consequat aliquip ad consectetur ut fugiat. Aliquip est laboris dolor amet aute sunt enim irure nostrud. Quis deserunt nulla deserunt tempor. Eiusmod laboris incididunt do minim sit anim incididunt incididunt id minim in.\r\n', 'temp-13862094760385571107.jpg', b'0', '2021-11-13 19:53:14', NULL, NULL, NULL),
	(83, 'Sách Terragen', 103129, 0, 51, 388, 'Jackson Fernandez', 264, 'NXB Đại học Quốc gia Hà Nội', '2009', 'Irure deserunt duis ut commodo consequat esse officia. Non laboris enim nostrud veniam. Tempor proident esse consectetur nostrud ea enim in Lorem deserunt. Nisi ullamco consequat officia dolor.\r\nVoluptate qui ipsum id cupidatat ad consequat dolore sunt. Dolor sit id deserunt fugiat sint esse consectetur sit elit incididunt. Voluptate adipisicing irure cillum tempor laborum do. Laborum proident magna mollit aute culpa. Ullamco dolor non amet laboris. Elit proident nisi consequat aliquip.\r\n', 'temp-16741118072528735594.jpg', b'0', '2021-10-29 08:47:05', NULL, NULL, NULL),
	(84, 'Sách Accidency', 44192, 20, 69, 128, 'Blackburn West', 357, 'NXB Đại học Huế', '2020', 'Nisi esse excepteur sit id adipisicing do voluptate cupidatat voluptate in. Sunt fugiat anim laborum reprehenderit ad consequat ullamco eu mollit occaecat adipisicing laboris. Anim veniam exercitation sint in qui ea duis eiusmod sint qui.\r\nEiusmod mollit non deserunt do. Ex et est non laborum nostrud culpa qui magna adipisicing qui sint labore sit cillum. Id duis laborum velit amet. Proident culpa anim incididunt eu ad labore labore aliquip dolor voluptate officia aute laborum. Tempor exercitation pariatur cillum fugiat sint irure est et esse anim occaecat nulla excepteur sunt.\r\n', 'temp-13862094760385571107.jpg', b'1', '2021-02-06 19:11:02', NULL, NULL, NULL),
	(85, 'Sách Hairport', 367922, 20, 96, 422, 'Harris Zamora', 328, 'NXB Đại học Sư phạm Hà Nội', '2003', 'Est enim veniam proident ad excepteur cillum ex irure magna duis enim exercitation aliquip fugiat. Esse et magna excepteur ea quis consequat magna do dolore velit sint consectetur nisi. Ex consequat sint sint ullamco quis qui irure id velit incididunt duis laboris culpa.\r\nEa sit eiusmod deserunt sint officia esse velit. Esse irure ex laborum et. Do est labore aute sunt anim do quis minim aute commodo incididunt consequat eu proident. Ex irure eiusmod pariatur consectetur dolore pariatur sint pariatur magna non pariatur.\r\n', 'temp-13862094760385571107.jpg', b'0', '2021-10-24 02:47:35', NULL, NULL, NULL),
	(86, 'Sách Shepard', 215739, 20, 85, 134, 'Elsie Peters', 198, 'NXB Đại học Huế', '2007', 'Voluptate duis mollit aliquip culpa sint pariatur cillum Lorem. Ullamco ex exercitation sint duis eiusmod aliqua est elit. Adipisicing cupidatat esse deserunt sint occaecat nisi elit ex quis incididunt sunt. Pariatur irure laborum aute consequat dolore proident dolore tempor labore minim fugiat consequat. Sit laboris aliquip sit laboris nostrud duis incididunt dolore cillum nisi nostrud ea cupidatat. Tempor ipsum dolor aliqua magna ea ipsum occaecat dolor laboris labore. Magna labore deserunt proident dolore deserunt anim aliqua.\r\nIncididunt veniam exercitation dolor ullamco sit est. Ex in adipisicing eiusmod pariatur voluptate do. Elit dolor ea consectetur mollit. Incididunt nisi nostrud id do officia duis non ex ea velit. Est anim magna est aliquip ea quis qui dolor laboris culpa. Et sunt officia veniam anim ipsum ea aute reprehenderit occaecat proident duis.\r\n', 'temp-3015888053636485125.jpg', b'1', '2021-04-21 02:30:10', NULL, NULL, NULL),
	(87, 'Sách Pigzart', 91054, 20, 16, 420, 'Roach Nielsen', 279, 'NXB Đại học Sư phạm Hà Nội', '2005', 'Excepteur aute Lorem proident excepteur magna sit. Labore ex qui amet esse cupidatat nulla exercitation sint culpa deserunt fugiat ut nulla. Ex officia Lorem commodo cillum ad duis do magna sint. Amet esse Lorem laboris mollit dolore consectetur consequat pariatur.\r\nEx sint adipisicing culpa consectetur id aute aliquip amet esse. Ipsum est anim elit nostrud irure id pariatur in. Incididunt commodo ex ea ut amet magna esse sint. Adipisicing dolore id officia aliqua. Eu Lorem aute excepteur qui in est nulla enim est aliqua cupidatat consequat aliquip. Reprehenderit voluptate et ut culpa minim fugiat ex velit ex duis duis. Et Lorem laboris dolore magna pariatur proident ut.\r\n', 'temp-13064240004351430671.jpg', b'1', '2021-03-31 00:39:02', NULL, NULL, NULL),
	(88, 'Sách Orbaxter', 270543, 0, 54, 140, 'Diaz Howard', 156, 'NXB Đại học Huế', '2000', 'Do aute occaecat qui velit pariatur sit aute Lorem ea fugiat enim ullamco sunt cillum. Excepteur excepteur aliquip exercitation laborum veniam excepteur amet eiusmod amet id commodo. Proident sint ex laborum consequat est irure magna magna nulla pariatur tempor et incididunt. Nostrud tempor officia est cillum sunt excepteur do cupidatat velit. Commodo id ad ex elit aliquip commodo ea proident officia fugiat deserunt aliqua. Eiusmod adipisicing dolore est Lorem consectetur cupidatat velit laboris nulla. Est id non incididunt consectetur elit exercitation magna reprehenderit velit qui.\r\nMagna sunt fugiat velit eiusmod excepteur cillum occaecat. Ipsum et tempor consequat elit nulla est. Non exercitation proident exercitation elit.\r\n', 'temp-8476700387786158058.jpg', b'1', '2021-06-15 07:51:43', NULL, NULL, NULL),
	(89, 'Sách Cowtown', 29992, 20, 49, 318, 'Mitzi Koch', 191, 'NXB Đại học Sư phạm Hà Nội', '1998', 'Qui elit irure sunt esse voluptate ex laborum. Lorem elit commodo voluptate labore et laboris consectetur. Sunt ut consectetur mollit et.\r\nId excepteur ad velit eiusmod ut eiusmod culpa quis ad. Dolor cillum laborum nisi irure. Excepteur nulla magna anim occaecat minim dolor reprehenderit deserunt officia qui magna occaecat. Anim aute et officia excepteur culpa qui culpa aliquip enim cillum.\r\n', 'temp-6243426685116508297.jpg', b'0', '2021-12-21 04:16:02', NULL, NULL, NULL),
	(90, 'Sách Makingway', 205442, 20, 85, 380, 'Cynthia Rasmussen', 346, 'NXB Đại học Quốc gia Hà Nội', '2015', 'Nisi qui amet ipsum ea nulla dolor nulla. Consectetur et culpa dolore quis aliqua nulla consequat consequat laborum et. Cillum ex cupidatat dolor cillum sit. Lorem tempor voluptate cillum minim magna sit quis reprehenderit.\r\nEnim Lorem officia quis anim nulla pariatur labore eu minim fugiat esse sint. Cillum duis eu do voluptate laborum id id. Duis nostrud consectetur dolore deserunt. Occaecat velit duis voluptate officia officia duis minim consequat nulla officia non labore nulla. Fugiat irure quis irure fugiat quis ut velit cillum do anim nulla. Incididunt nisi incididunt ullamco voluptate amet dolore adipisicing pariatur cillum.\r\n', 'temp-7329036107498680084.jpg', b'1', '2021-09-01 20:01:38', NULL, NULL, NULL),
	(91, 'Sách Lunchpad', 129694, 20, 26, 133, 'Bryant Ball', 318, 'NXB Đại học Sư phạm TP.HCM', '2009', 'Quis mollit ipsum ad laboris velit sit est anim ullamco sunt esse. Est esse occaecat sunt tempor tempor tempor id quis ipsum. Ullamco sint eiusmod anim laborum proident deserunt aliquip quis esse aute quis sint minim adipisicing. Labore mollit ex deserunt pariatur nostrud dolore ad labore ex ullamco mollit cupidatat sit. Aliqua ipsum amet nostrud anim.\r\nCupidatat ad veniam esse tempor incididunt pariatur cillum ea dolore irure. Qui ut mollit nisi velit elit. Aliquip ullamco elit velit consectetur commodo excepteur ea non tempor ipsum mollit qui. Id Lorem velit do minim deserunt pariatur nulla proident et sunt pariatur fugiat sint. Eu anim ut consectetur reprehenderit consectetur minim dolor et deserunt sunt exercitation enim veniam. Ad aute labore non eiusmod. Pariatur exercitation Lorem enim elit.\r\n', 'temp-6352099207348952932.jpg', b'1', '2021-03-25 04:05:04', NULL, NULL, NULL),
	(92, 'Sách Mediot', 216835, 20, 78, 114, 'Rosemary Sampson', 321, 'NXB Đại học Quốc gia Hà Nội', '1998', 'Ut deserunt esse excepteur aliqua commodo Lorem ad et. Non officia Lorem amet qui. Ea cillum qui est ex ea mollit. Voluptate ad id est eiusmod esse officia voluptate sint aute do aute. Labore non ullamco aute ut velit proident ullamco velit veniam non amet.\r\nMinim sunt enim esse cillum. Aliqua dolor velit nostrud ipsum consequat nisi incididunt qui. Pariatur mollit ex ullamco nulla. Ipsum pariatur qui nostrud Lorem deserunt eu ipsum. Est fugiat cillum pariatur adipisicing laborum velit elit qui quis exercitation est officia commodo. Exercitation culpa nulla reprehenderit culpa consectetur Lorem quis aute amet occaecat.\r\n', 'temp-6352099207348952932.jpg', b'0', '2021-05-17 06:49:26', NULL, NULL, NULL),
	(93, 'Sách Plasto', 215800, 20, 55, 85, 'Santiago Levine', 267, 'NXB Đại học Quốc gia Hà Nội', '2001', 'Amet aliquip sunt in commodo excepteur esse ea aliqua laboris in. Lorem consequat tempor reprehenderit amet occaecat proident deserunt voluptate elit elit excepteur nisi in. Lorem commodo aliquip proident fugiat proident Lorem qui incididunt consectetur nostrud cupidatat quis deserunt. Nulla deserunt commodo nostrud nostrud veniam id proident laborum in in. Qui laboris consectetur cupidatat tempor amet in in in. Laborum ipsum consectetur laboris dolore magna laborum laboris deserunt proident nulla. Elit proident amet minim adipisicing.\r\nSit dolore ullamco mollit veniam ullamco consectetur reprehenderit occaecat. Est incididunt ea laborum labore enim aute aliquip laboris aute. Pariatur exercitation aute in magna. Exercitation est nulla ex fugiat. Magna nostrud proident reprehenderit et laboris. Dolore reprehenderit nulla deserunt quis proident do exercitation do reprehenderit. Qui proident excepteur commodo nostrud minim commodo exercitation.\r\n', 'temp-13064240004351430671.jpg', b'1', '2022-01-27 14:49:53', NULL, NULL, NULL),
	(94, 'Sách Geekola', 332072, 20, 42, 165, 'Austin Cain', 274, 'NXB Đại học Sư phạm TP.HCM', '2010', 'Duis veniam ad nisi nostrud aliquip ex aliquip laboris ipsum eu velit dolor dolor in. Pariatur dolore amet laborum deserunt aute veniam cillum. Laborum incididunt in duis minim consequat voluptate non dolore fugiat nisi. Ex labore consequat et nostrud sunt enim eu cillum.\r\nEa non voluptate exercitation reprehenderit. Nisi sint enim enim adipisicing enim exercitation sit minim pariatur officia ipsum aliquip. Consectetur nulla Lorem fugiat eu anim pariatur Lorem elit ad adipisicing. Enim sint Lorem tempor ipsum eiusmod duis. Amet proident ipsum irure adipisicing officia ipsum labore consequat veniam fugiat. Est labore irure in eiusmod irure cillum officia cupidatat aute.\r\n', 'temp-14438611480196141526.jpg', b'0', '2021-04-27 23:56:06', NULL, NULL, NULL),
	(95, 'Sách Gracker', 268831, 0, 49, 248, 'Vasquez Gallegos', 230, 'NXB Giáo dục', '2006', 'Consequat sunt non aute irure voluptate reprehenderit enim consectetur sit sint sit. Qui ullamco officia id commodo mollit velit nulla sint laboris amet voluptate. Exercitation aliquip reprehenderit enim ut eiusmod sit ullamco non. Officia aute sit tempor amet ea non incididunt. Ex est deserunt commodo dolore magna exercitation eu irure sint minim. Eiusmod dolor officia nulla deserunt ex eiusmod dolor labore nisi labore et excepteur non elit.\r\nEt pariatur excepteur nulla eu dolore irure. In in velit quis reprehenderit aliqua excepteur magna et ullamco ad. Pariatur id consectetur fugiat dolor pariatur labore ipsum nulla voluptate cupidatat incididunt. Ex do elit minim est id laborum officia. Eiusmod laborum ullamco officia do amet aliqua elit ex cupidatat commodo culpa. Aliquip magna ullamco amet dolor aliqua elit excepteur. Nisi magna enim duis ea labore.\r\n', 'temp-12235989262213754276.jpg', b'1', '2021-10-24 22:55:27', NULL, NULL, NULL),
	(96, 'Sách Housedown', 307111, 0, 83, 233, 'Haynes Riggs', 390, 'NXB Đại học Huế', '2020', 'Quis magna tempor laboris adipisicing. Aliquip laboris sunt minim enim velit dolor Lorem veniam fugiat excepteur voluptate ea. Nostrud sunt labore sint nulla. Commodo occaecat proident deserunt et adipisicing commodo cillum sint elit elit duis elit reprehenderit duis.\r\nConsectetur exercitation voluptate laboris velit eu sit incididunt enim dolore sunt. Nulla exercitation aliqua sunt consequat minim ullamco enim culpa anim ex deserunt veniam laborum. Nisi in sint reprehenderit ut.\r\n', 'temp-8476700387786158058.jpg', b'1', '2021-04-16 23:11:57', NULL, NULL, NULL),
	(97, 'Sách Zillan', 108354, 0, 81, 307, 'Hood Nieves', 192, 'NXB Đại học Sư phạm TP.HCM', '2012', 'Incididunt labore minim enim qui minim cillum est voluptate veniam eu. Aliqua magna labore consectetur irure veniam ex ad do aliquip id voluptate. Eu enim labore enim ipsum Lorem. Do proident esse consectetur excepteur commodo. Ut sint officia aliqua nostrud eiusmod est sit amet sint nostrud. Veniam do aute anim consequat tempor quis culpa.\r\nEa ullamco est officia ipsum excepteur dolore voluptate aliqua excepteur culpa proident irure adipisicing. Fugiat cupidatat irure cillum excepteur ea do consequat commodo fugiat nulla fugiat magna. Tempor excepteur nostrud in in culpa ex. Adipisicing pariatur cillum commodo velit et do deserunt nulla occaecat fugiat veniam occaecat. Commodo voluptate laboris in culpa Lorem. Dolore sunt in consectetur nostrud dolor consectetur.\r\n', 'temp-8262627340495498759.jpg', b'1', '2021-07-02 22:51:31', NULL, NULL, NULL),
	(98, 'Sách Lovepad', 477477, 20, 18, 120, 'Foster Sims', 91, 'NXB Đại học Sư phạm Hà Nội', '2015', 'Anim do laboris duis aute laboris aliquip amet do nulla aliqua. Excepteur quis dolor proident mollit tempor consectetur ex cupidatat laboris consequat. Et Lorem sint pariatur in qui irure nostrud culpa do amet amet et irure laborum.\r\nSit minim quis dolore tempor exercitation ullamco nulla. Laborum quis labore reprehenderit occaecat adipisicing duis ullamco ullamco ex duis. Aute sunt eu aliqua consectetur quis elit ea. Ad tempor elit consectetur est adipisicing ad exercitation culpa laborum amet ipsum do nulla. Lorem dolore aliqua velit magna laboris in ex laboris sint magna fugiat sit mollit cupidatat.\r\n', 'temp-3984373128647845854.jpg', b'1', '2021-07-09 12:58:01', NULL, NULL, NULL),
	(99, 'Sách Ontagene', 199763, 20, 51, 86, 'Weeks Charles', 71, 'NXB Đại học Huế', '2009', 'Do in sunt sunt in tempor tempor proident dolor officia irure consequat cupidatat incididunt nulla. Id tempor duis dolore aute Lorem dolor ipsum aliqua fugiat ea. Lorem ullamco non reprehenderit cupidatat qui. Commodo pariatur qui labore anim aute anim tempor eiusmod eiusmod nulla dolor culpa. Voluptate commodo eiusmod tempor ipsum ut culpa sunt minim id laboris commodo ad ullamco in.\r\nEa ad aliquip aliquip tempor. Dolore reprehenderit duis aliquip minim sit duis exercitation labore nisi ad. Deserunt quis nostrud exercitation sunt consectetur aliquip in pariatur.\r\n', 'temp-8476700387786158058.jpg', b'1', '2022-01-22 08:29:03', NULL, NULL, NULL),
	(100, 'Sách Spacewax', 171403, 20, 34, 198, 'Sadie Logan', 85, 'NXB Đại học Huế', '2014', 'Esse non qui dolor consectetur magna consectetur excepteur exercitation nisi eiusmod laboris nulla laborum. Aliquip adipisicing do adipisicing esse. Nostrud nostrud amet culpa commodo officia.\r\nLaborum id ad veniam nulla incididunt amet mollit pariatur cupidatat amet. Laborum ut veniam ullamco sit velit do magna. Reprehenderit proident nisi incididunt anim. Nostrud magna ut quis exercitation ut ut culpa Lorem cillum deserunt pariatur. Amet commodo duis incididunt non do non. Qui Lorem elit nulla quis in exercitation tempor.\r\n', 'temp-12235989262213754276.jpg', b'1', '2021-08-14 12:14:31', NULL, NULL, NULL);

-- Dumping structure for table bookshopdb.product_category
CREATE TABLE IF NOT EXISTS `product_category` (
  `productId` bigint(20) NOT NULL,
  `categoryId` bigint(20) NOT NULL,
  PRIMARY KEY (`productId`,`categoryId`),
  KEY `idx_product_category_product` (`productId`),
  KEY `idx_product_category_category` (`categoryId`),
  CONSTRAINT `fk_product_category_category` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_category_product` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.product_category: ~100 rows (approximately)
INSERT INTO `product_category` (`productId`, `categoryId`) VALUES
	(1, 2),
	(2, 14),
	(3, 5),
	(4, 5),
	(5, 5),
	(6, 3),
	(7, 7),
	(8, 6),
	(9, 7),
	(10, 11),
	(11, 13),
	(12, 6),
	(13, 9),
	(14, 15),
	(15, 14),
	(16, 15),
	(17, 9),
	(18, 2),
	(19, 3),
	(20, 10),
	(21, 13),
	(22, 15),
	(23, 8),
	(24, 14),
	(25, 7),
	(26, 1),
	(27, 7),
	(28, 14),
	(29, 9),
	(30, 2),
	(31, 8),
	(32, 1),
	(33, 10),
	(34, 7),
	(35, 2),
	(36, 7),
	(37, 12),
	(38, 1),
	(39, 12),
	(40, 1),
	(41, 9),
	(42, 4),
	(43, 5),
	(44, 5),
	(45, 3),
	(46, 12),
	(47, 3),
	(48, 7),
	(49, 6),
	(50, 6),
	(51, 11),
	(52, 5),
	(53, 9),
	(54, 4),
	(55, 1),
	(56, 10),
	(57, 10),
	(58, 3),
	(59, 8),
	(60, 9),
	(61, 12),
	(62, 10),
	(63, 14),
	(64, 8),
	(65, 6),
	(66, 11),
	(67, 14),
	(68, 5),
	(69, 13),
	(70, 8),
	(71, 13),
	(72, 14),
	(73, 2),
	(74, 1),
	(75, 13),
	(76, 2),
	(77, 2),
	(78, 8),
	(79, 3),
	(80, 8),
	(81, 14),
	(82, 2),
	(83, 1),
	(84, 9),
	(85, 13),
	(86, 14),
	(87, 5),
	(88, 13),
	(89, 1),
	(90, 10),
	(91, 4),
	(92, 2),
	(93, 4),
	(94, 15),
	(95, 11),
	(96, 8),
	(97, 11),
	(98, 10),
	(99, 15),
	(100, 8);

-- Dumping structure for table bookshopdb.product_import
CREATE TABLE IF NOT EXISTS `product_import` (
  `id` bigint(20) NOT NULL,
  `productId` bigint(20) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `importAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `quanlity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productId` (`productId`),
  KEY `userId` (`userId`),
  CONSTRAINT `product_import_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`),
  CONSTRAINT `product_import_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.product_import: ~5 rows (approximately)
INSERT INTO `product_import` (`id`, `productId`, `userId`, `importAt`, `quanlity`) VALUES
	(1, 84, 6, '2024-04-02 03:20:14', 1000),
	(2, 36, 1, '2024-04-02 03:36:04', 2000),
	(3, 70, 1, '2024-04-02 03:41:47', 1111),
	(4, 55, 10, '2024-04-02 03:36:02', 3333),
	(5, 55, 6, '2024-04-02 03:42:28', 123);

-- Dumping structure for table bookshopdb.product_review
CREATE TABLE IF NOT EXISTS `product_review` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `productId` bigint(20) NOT NULL,
  `ratingScore` tinyint(4) NOT NULL,
  `content` text NOT NULL,
  `isShow` bit(1) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_product_review_user` (`userId`),
  KEY `idx_product_review_product` (`productId`),
  CONSTRAINT `fk_product_review_product` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_review_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.product_review: ~150 rows (approximately)
INSERT INTO `product_review` (`id`, `userId`, `productId`, `ratingScore`, `content`, `isShow`, `createdAt`, `updatedAt`) VALUES
	(1, 4, 23, 4, 'Deserunt enim ullamco occaecat pariatur magna fugiat. Dolore nostrud cupidatat quis culpa sint fugiat. Anim ipsum id enim quis esse.', b'1', '2021-06-21 01:29:23', NULL),
	(2, 1, 89, 2, 'Nostrud aliquip culpa commodo esse. Veniam aute quis fugiat anim veniam non esse reprehenderit reprehenderit do Lorem. Voluptate cupidatat nostrud laborum proident esse sunt consequat consectetur excepteur ipsum deserunt pariatur fugiat.', b'1', '2021-03-05 21:03:45', NULL),
	(3, 4, 48, 5, 'In duis fugiat labore cillum labore ad pariatur adipisicing ipsum culpa duis sunt nostrud adipisicing. Dolor commodo culpa non dolor. Quis ea quis irure ut eu excepteur velit qui magna laborum ad.', b'1', '2021-02-21 19:36:33', NULL),
	(4, 3, 79, 3, 'Labore magna pariatur consectetur dolore voluptate aliquip Lorem ut adipisicing nostrud consectetur. Ullamco ut irure aute velit in veniam. Dolor sit magna duis laboris nisi.', b'1', '2021-05-18 12:49:12', NULL),
	(5, 1, 95, 1, 'Consectetur laboris aliqua ipsum aute exercitation reprehenderit reprehenderit ullamco nisi anim incididunt esse. Laboris veniam mollit mollit eiusmod eiusmod eu pariatur sunt velit voluptate quis sit. Incididunt sit do Lorem eu eiusmod et cupidatat aliquip ipsum ipsum cillum exercitation qui culpa.', b'1', '2021-10-17 19:21:32', NULL),
	(6, 4, 75, 5, 'Ullamco consectetur irure minim voluptate enim nisi non eu deserunt ea cupidatat cillum. Consectetur ex amet enim veniam cupidatat Lorem nostrud irure anim consectetur. Commodo ad anim veniam commodo ad et est amet sint sit elit eiusmod.', b'1', '2021-04-13 22:48:32', NULL),
	(7, 2, 53, 3, 'Deserunt occaecat aliqua pariatur nostrud dolor ullamco reprehenderit deserunt tempor culpa ad aute. Ea sit incididunt mollit anim ullamco commodo sint irure ut exercitation in ullamco minim elit. Sunt cupidatat veniam do cupidatat do exercitation in consectetur minim incididunt.', b'1', '2021-06-28 10:16:49', NULL),
	(8, 5, 64, 4, 'Eiusmod aliqua exercitation nulla veniam ut veniam incididunt dolore occaecat occaecat eiusmod dolor non enim. Nisi veniam exercitation eu cupidatat ad excepteur sint proident dolor duis deserunt. Cillum deserunt pariatur duis enim enim sit proident pariatur sint aliqua magna.', b'1', '2021-03-20 13:02:01', NULL),
	(9, 5, 53, 1, 'Do sit commodo enim sunt ullamco et. Labore eiusmod aliqua nulla reprehenderit officia excepteur magna proident excepteur dolor elit ullamco. Aliqua adipisicing eu ullamco aliquip consectetur irure exercitation ea mollit enim eu minim esse esse.', b'1', '2021-03-08 23:20:41', NULL),
	(10, 2, 71, 3, 'Commodo aute qui minim eiusmod ipsum culpa sint veniam dolore mollit. Lorem consectetur esse ad do mollit enim mollit qui enim tempor ullamco elit ipsum. Consequat laborum et cupidatat labore excepteur cillum.', b'1', '2021-06-04 06:49:47', NULL),
	(11, 3, 92, 2, 'Voluptate ipsum elit cillum ad cillum consectetur amet anim sint exercitation. Aute ullamco reprehenderit adipisicing sit magna. Dolore exercitation exercitation fugiat ullamco.', b'1', '2021-03-11 09:35:14', NULL),
	(12, 1, 38, 3, 'Amet est enim labore occaecat commodo sit eiusmod duis laboris sint occaecat dolor. Consequat qui reprehenderit consequat nostrud nisi deserunt sit ex occaecat irure adipisicing sit laboris. Consequat irure nisi Lorem dolor aliqua.', b'1', '2021-07-29 23:26:43', NULL),
	(13, 2, 80, 3, 'Ipsum occaecat duis nostrud dolore do commodo ex. Minim irure cupidatat nulla anim mollit fugiat est ex reprehenderit enim velit. Aliqua voluptate ea pariatur minim tempor ullamco anim officia nulla sint laborum elit in.', b'1', '2021-07-07 18:17:45', NULL),
	(14, 1, 36, 5, 'Proident et sunt nulla consectetur eiusmod. Non culpa nisi in qui ullamco ullamco commodo. Magna culpa cillum sint mollit.', b'1', '2021-02-17 05:39:28', NULL),
	(15, 3, 42, 1, 'Eiusmod exercitation irure nisi aute consectetur ipsum ullamco excepteur do occaecat eu est. Veniam velit deserunt eu consequat laboris anim exercitation enim in sint incididunt esse. Veniam sit Lorem aliqua sunt veniam cillum et pariatur ea ex anim cillum.', b'1', '2021-09-28 21:06:08', NULL),
	(16, 5, 30, 5, 'Magna incididunt anim ut nostrud magna cupidatat sit. Reprehenderit quis consectetur in amet enim esse dolor non quis sit voluptate laborum. Fugiat veniam id mollit qui qui sunt voluptate commodo anim excepteur labore culpa ullamco.', b'1', '2021-02-22 16:10:04', NULL),
	(17, 4, 50, 3, 'Mollit magna cillum culpa nulla. Ad est culpa id culpa est commodo quis enim et magna. Non ullamco tempor id commodo ad laborum magna nisi ut pariatur incididunt proident occaecat amet.', b'1', '2022-01-08 14:10:10', NULL),
	(18, 2, 54, 3, 'Officia non est qui ad. Incididunt quis deserunt amet qui. Ea amet deserunt et ex.', b'1', '2021-03-02 16:33:39', NULL),
	(19, 5, 54, 4, 'Nostrud ad occaecat incididunt ex incididunt veniam duis esse ut tempor mollit commodo esse. Anim eu anim laboris eiusmod labore non quis mollit nisi enim. Occaecat veniam et do mollit eu culpa excepteur ad laborum est.', b'1', '2021-03-23 19:11:05', NULL),
	(20, 3, 88, 5, 'Lorem id id nostrud quis. Nulla aute ad aute pariatur in. Pariatur consequat culpa proident excepteur reprehenderit esse qui cillum ex labore excepteur ad amet et.', b'1', '2021-11-24 03:02:51', NULL),
	(21, 5, 93, 2, 'Duis consequat cupidatat enim elit in sint culpa reprehenderit labore excepteur mollit. Pariatur elit dolor et reprehenderit pariatur. Culpa laboris excepteur veniam eiusmod id ut aute pariatur.', b'1', '2021-11-13 18:04:47', NULL),
	(22, 3, 19, 2, 'Anim qui est et laborum irure pariatur deserunt in nulla sint qui. Aliquip eiusmod consectetur culpa labore veniam nulla aliquip officia non eu minim Lorem. Adipisicing esse ea aliquip elit nisi ea pariatur officia sit labore minim eu laborum occaecat.', b'1', '2022-01-23 05:52:13', NULL),
	(23, 3, 54, 2, 'Duis est officia non non aute eiusmod cupidatat ad consectetur amet esse est. Qui cillum aliquip voluptate magna anim anim consectetur cillum duis mollit. Id eiusmod sit nisi ea enim tempor.', b'1', '2021-07-20 07:52:16', NULL),
	(24, 1, 97, 3, 'Pariatur laboris officia voluptate tempor consequat adipisicing. Velit culpa officia id quis consectetur duis veniam. Sunt esse amet irure cupidatat.', b'1', '2021-04-27 12:05:33', NULL),
	(25, 4, 8, 5, 'Voluptate amet deserunt amet laboris eu nisi labore deserunt excepteur laboris aute dolore minim exercitation. Ea duis et minim sint anim ullamco in do labore. Enim nostrud laboris non elit commodo pariatur est minim exercitation nulla mollit commodo deserunt fugiat.', b'1', '2021-09-21 13:55:21', NULL),
	(26, 4, 51, 5, 'Et deserunt exercitation cillum cupidatat Lorem excepteur sit pariatur est id minim minim. In culpa culpa amet anim est fugiat consequat do. Dolore excepteur incididunt est dolore tempor dolor cupidatat amet tempor Lorem dolor.', b'1', '2021-06-14 10:26:50', NULL),
	(27, 2, 11, 5, 'Nisi voluptate ex officia sit ea ea labore. Mollit esse sunt ad commodo nulla. Ullamco dolor laboris aliquip ipsum sint commodo ad nisi aute esse non anim nostrud.', b'1', '2021-08-15 20:13:02', NULL),
	(28, 5, 20, 5, 'Esse quis incididunt fugiat ut elit voluptate tempor ullamco elit sunt ex aliquip laborum. Id ipsum ex consequat dolore nostrud nostrud dolor commodo dolore. Dolor eiusmod consectetur veniam minim et consequat eu ullamco proident est incididunt ut pariatur.', b'1', '2021-09-20 14:45:32', NULL),
	(29, 3, 49, 4, 'Minim duis labore velit laborum. Et nisi commodo anim consectetur. Occaecat cupidatat elit officia est id nulla excepteur cillum eu sunt amet irure magna.', b'1', '2021-10-11 08:45:33', NULL),
	(30, 5, 100, 5, 'Officia cupidatat et aliqua laboris excepteur nostrud occaecat tempor voluptate laboris culpa eiusmod. Officia adipisicing enim laboris consequat dolore sunt labore proident ullamco adipisicing cupidatat aliquip. Ullamco labore nulla consectetur aliquip mollit esse ad ipsum do fugiat nulla do.', b'1', '2021-07-31 00:49:01', NULL),
	(31, 1, 74, 2, 'Esse est pariatur excepteur commodo cillum deserunt laborum culpa. Deserunt qui fugiat amet deserunt eu minim. In ea tempor ipsum ad reprehenderit commodo consectetur tempor elit amet amet ipsum.', b'1', '2021-06-30 00:09:58', NULL),
	(32, 5, 46, 3, 'Minim commodo sint ex elit in. Laborum velit magna eu aliqua deserunt velit aliquip eu in amet quis. Aute aliqua ad Lorem anim voluptate occaecat ad amet dolor.', b'1', '2021-07-13 16:00:20', NULL),
	(33, 3, 38, 5, 'Anim ullamco incididunt duis occaecat commodo excepteur Lorem ipsum nostrud sunt. Deserunt nulla veniam duis dolor consectetur occaecat excepteur esse ipsum et ad tempor esse. Dolor irure velit in et ea.', b'1', '2021-11-25 08:12:50', NULL),
	(34, 3, 57, 2, 'Sunt dolor aliquip labore in dolore. Id aliquip consectetur quis ex ullamco et aliquip nostrud. In enim fugiat dolore ipsum velit ex.', b'1', '2021-03-18 16:49:52', NULL),
	(35, 2, 92, 2, 'Laborum ipsum sint culpa in. Laboris incididunt et irure Lorem id cillum fugiat et nulla voluptate sunt. Eiusmod incididunt enim qui eu elit.', b'1', '2021-10-10 15:41:18', NULL),
	(36, 1, 47, 3, 'Nisi esse aute minim fugiat cupidatat mollit. Dolore deserunt ex sunt enim veniam mollit est nulla adipisicing dolore enim in. Mollit esse enim esse pariatur duis ad ipsum eu laboris cupidatat in est commodo.', b'1', '2021-04-28 08:29:44', NULL),
	(37, 1, 98, 1, 'Ipsum consectetur dolor labore consequat magna cillum nostrud esse irure nisi Lorem. Consequat cillum magna do exercitation do eiusmod deserunt sint proident mollit proident culpa Lorem ipsum. Reprehenderit sunt Lorem velit nulla fugiat id duis et veniam laborum esse ut.', b'1', '2021-03-10 02:40:00', NULL),
	(38, 4, 24, 2, 'Sunt duis excepteur Lorem aute enim deserunt laboris occaecat et labore aliquip sunt dolore laboris. Fugiat ad consequat magna sint enim mollit cupidatat incididunt tempor ad ad consectetur culpa. Duis exercitation culpa pariatur consequat tempor et velit veniam.', b'1', '2021-08-06 13:17:49', NULL),
	(39, 2, 12, 1, 'Nulla proident magna mollit labore. Proident et ea ex occaecat ad adipisicing aliquip labore anim Lorem enim. Pariatur id tempor cupidatat laborum culpa elit consequat sint officia sint et veniam.', b'1', '2021-05-01 18:40:44', NULL),
	(40, 1, 52, 2, 'Exercitation dolor ex officia aliqua esse minim culpa enim occaecat officia reprehenderit. In veniam amet laborum nostrud consectetur non. Ipsum pariatur amet dolor nisi ipsum Lorem labore excepteur commodo minim mollit officia.', b'1', '2021-09-20 14:34:52', NULL),
	(41, 3, 34, 4, 'Esse nisi dolor irure eu nulla. Cillum elit sunt et pariatur. Veniam et ea adipisicing est ipsum sunt exercitation aute et.', b'1', '2021-05-21 06:32:40', NULL),
	(42, 3, 49, 5, 'Est sunt et cupidatat non nisi aliqua. Irure incididunt enim incididunt Lorem aliqua deserunt. Veniam laborum velit reprehenderit ullamco duis commodo excepteur eu esse consequat.', b'1', '2021-04-24 02:39:36', NULL),
	(43, 5, 25, 3, 'Quis reprehenderit anim ullamco eu officia occaecat sint dolor excepteur eiusmod. Ipsum excepteur esse excepteur aliquip voluptate reprehenderit. Exercitation voluptate proident dolore cupidatat incididunt eu exercitation voluptate commodo consectetur excepteur laboris.', b'1', '2021-11-08 02:19:05', NULL),
	(44, 1, 95, 2, 'Minim voluptate aute ea veniam ipsum ad nostrud deserunt magna quis ea ullamco nostrud sit. Nisi aliquip cupidatat minim nostrud adipisicing pariatur reprehenderit ex labore duis. Velit laborum adipisicing veniam excepteur laborum occaecat anim excepteur quis enim sit.', b'1', '2021-08-18 06:25:56', NULL),
	(45, 4, 94, 2, 'Duis ea sunt proident adipisicing tempor irure. Aliquip non id eiusmod minim sint anim Lorem in est velit elit. Nostrud consequat nulla nulla id ex in irure duis nisi irure fugiat sit mollit.', b'1', '2021-04-27 01:10:30', NULL),
	(46, 2, 48, 3, 'Consequat laboris irure id laboris ea cupidatat occaecat. Ex nostrud ipsum et excepteur ullamco nisi officia eiusmod duis nostrud nulla sint ipsum. Eiusmod excepteur anim eu exercitation id est ad ea quis enim.', b'1', '2021-05-24 20:52:56', NULL),
	(47, 2, 1, 3, 'Non in dolor non aliquip elit Lorem ipsum tempor mollit commodo aliquip veniam. Esse velit exercitation nostrud aliquip ullamco elit enim laborum sit tempor amet aliqua eiusmod pariatur. Eu laboris Lorem minim ullamco consequat pariatur cillum excepteur est irure veniam.', b'1', '2021-11-16 04:56:13', NULL),
	(48, 5, 13, 1, 'In sint et laborum culpa nostrud ea eu eu esse aliquip culpa nisi dolor. Aute culpa esse cillum ad do voluptate do laborum sit proident dolor sint duis elit. Cupidatat eiusmod incididunt sunt ea qui laborum fugiat occaecat.', b'1', '2021-12-14 23:31:00', NULL),
	(49, 4, 80, 2, 'Fugiat commodo dolore elit incididunt nisi aliqua ea aliqua. Aliquip consectetur do esse non veniam minim cupidatat id exercitation quis cillum. Ea incididunt nulla ea laboris esse ex culpa ullamco duis velit commodo adipisicing occaecat.', b'1', '2021-03-16 10:13:55', NULL),
	(50, 4, 63, 4, 'Deserunt est incididunt nostrud Lorem aliquip. Fugiat qui incididunt proident mollit nisi non cillum voluptate sunt ullamco Lorem aute ad occaecat. Sint esse sit consequat esse nostrud labore id excepteur excepteur elit fugiat exercitation dolore magna.', b'1', '2021-05-01 09:32:04', NULL),
	(51, 5, 39, 1, 'Ex fugiat eiusmod amet labore ad commodo enim. Laborum nostrud ad ullamco ex in. Nulla do commodo excepteur incididunt in ullamco in aliquip magna.', b'1', '2022-01-18 00:58:58', NULL),
	(52, 2, 18, 5, 'In sit occaecat esse magna mollit cupidatat ex eu non eiusmod et sit deserunt. Velit do commodo voluptate id exercitation laborum irure ad aute. Pariatur reprehenderit dolor id aliqua est minim adipisicing aute ex aliqua.', b'1', '2021-12-30 23:39:01', NULL),
	(53, 5, 69, 1, 'Commodo sint ipsum labore qui voluptate dolor id laborum adipisicing cillum. Excepteur est sit non officia aliquip labore. Cupidatat esse nostrud culpa et.', b'1', '2021-07-20 06:53:30', NULL),
	(54, 4, 100, 5, 'Pariatur consequat consectetur magna nostrud aliqua irure dolor. Aute esse exercitation officia et cillum incididunt est nisi et ut in Lorem. Qui commodo et irure sint aute.', b'1', '2022-01-17 00:42:11', NULL),
	(55, 1, 52, 3, 'Amet eu non dolor ex officia laboris quis eu qui excepteur sit do. Eu commodo amet non velit ipsum commodo excepteur duis. Incididunt quis magna velit labore ullamco non fugiat laboris tempor in.', b'1', '2021-08-22 08:50:47', NULL),
	(56, 5, 58, 3, 'Fugiat enim consequat eu duis proident cillum nostrud cillum minim adipisicing eiusmod. Non dolor qui ad dolore eiusmod labore excepteur labore anim deserunt. Deserunt laborum occaecat ad sunt officia reprehenderit sit pariatur dolore amet Lorem.', b'1', '2021-10-27 12:23:11', NULL),
	(57, 5, 44, 5, 'Eu reprehenderit proident officia dolor sunt qui eiusmod ad eiusmod exercitation occaecat adipisicing. Cillum culpa sint tempor labore adipisicing et aute irure incididunt consectetur occaecat. Non minim Lorem id anim mollit incididunt culpa anim.', b'1', '2021-06-07 20:26:15', NULL),
	(58, 2, 36, 2, 'Dolor esse Lorem id veniam elit. Dolore nulla ullamco aliqua dolor dolor eiusmod veniam eu qui qui ex est qui. Amet qui voluptate ullamco magna officia amet veniam veniam.', b'1', '2021-11-15 13:15:04', NULL),
	(59, 2, 51, 1, 'In qui nostrud et exercitation. Ut et consectetur laboris dolor anim exercitation ipsum nisi aliquip ipsum ex cillum. Duis anim sit pariatur commodo dolor enim aute.', b'1', '2021-04-11 00:42:46', NULL),
	(60, 4, 3, 5, 'Labore anim non consequat velit id ea pariatur deserunt adipisicing. Nulla labore pariatur ut qui occaecat. Anim occaecat pariatur nisi veniam irure irure veniam nisi ut.', b'1', '2021-07-14 01:56:52', NULL),
	(61, 4, 61, 1, 'Tempor amet ipsum Lorem est mollit magna quis aliqua excepteur adipisicing consectetur id. Aute in aliquip nulla duis irure consequat elit commodo ut. Elit nulla esse elit excepteur nostrud incididunt ut veniam eiusmod in anim eiusmod ad.', b'1', '2021-07-29 02:22:28', NULL),
	(62, 3, 83, 3, 'Commodo tempor incididunt nisi exercitation elit ex mollit. Laboris anim cillum do labore occaecat ullamco eu amet non id ea incididunt deserunt. Excepteur irure deserunt in do labore.', b'1', '2021-03-15 08:48:58', NULL),
	(63, 3, 41, 1, 'Pariatur et non nostrud minim est aliqua. Consectetur sunt tempor ea nulla duis Lorem est culpa ullamco. Tempor ipsum nostrud proident ullamco irure tempor quis officia veniam aliqua officia duis proident.', b'1', '2021-12-22 11:46:26', NULL),
	(64, 3, 38, 4, 'Est tempor nulla pariatur cillum occaecat quis. Irure ipsum amet mollit qui qui consectetur ea cupidatat sit velit nulla Lorem. Nostrud eu officia in duis occaecat minim proident enim sint irure dolor.', b'1', '2021-11-04 07:06:53', NULL),
	(65, 4, 61, 1, 'Laboris quis sunt ad sint velit ut Lorem non. Culpa labore fugiat incididunt labore laborum reprehenderit velit Lorem sint aliquip proident. Nostrud duis do aliquip consectetur ea consequat cillum aliquip magna laborum.', b'1', '2021-10-09 03:45:50', NULL),
	(66, 3, 45, 1, 'Labore magna pariatur ex mollit labore excepteur ex. In laboris et proident voluptate proident culpa est adipisicing amet amet cupidatat eu esse. Officia enim aliqua qui amet.', b'1', '2021-08-16 00:06:22', NULL),
	(67, 1, 31, 2, 'Ad elit nulla mollit do nulla non non nisi ipsum laboris anim occaecat dolor Lorem. Amet veniam dolor cupidatat id velit do magna tempor sit. Aliquip id velit aute do et tempor qui occaecat non irure labore aliquip incididunt fugiat.', b'1', '2021-05-29 15:13:23', NULL),
	(68, 2, 3, 5, 'Occaecat do ipsum nisi culpa ipsum culpa dolore duis reprehenderit exercitation consequat anim. Deserunt veniam dolore tempor enim minim elit ad consequat cupidatat cupidatat dolor eu Lorem. Sit minim quis id aliqua.', b'1', '2021-02-13 02:48:17', NULL),
	(69, 1, 7, 2, 'Pariatur eiusmod aliqua qui excepteur excepteur velit ut ipsum pariatur commodo fugiat. Mollit incididunt ullamco consectetur voluptate cillum pariatur cillum id amet laboris occaecat. Velit Lorem occaecat quis est Lorem.', b'1', '2021-03-16 01:29:14', NULL),
	(70, 4, 95, 5, 'Labore qui proident ut amet occaecat eiusmod et. Nisi dolore eu nostrud cupidatat ad non consequat quis aliqua excepteur velit commodo. Id ut elit ullamco ea est cillum.', b'1', '2021-08-17 21:22:17', NULL),
	(71, 4, 32, 4, 'Lorem excepteur cillum et esse velit enim culpa elit dolore ut nisi ad. Exercitation irure labore ex non duis sint. Adipisicing qui non veniam ut.', b'1', '2021-05-29 11:18:29', NULL),
	(72, 4, 7, 3, 'Anim ullamco consectetur anim ullamco esse incididunt aute velit velit cillum minim velit ullamco. Ad non cillum sit commodo nostrud reprehenderit in reprehenderit. Magna et tempor elit sit excepteur sunt.', b'1', '2021-04-17 19:03:58', NULL),
	(73, 5, 28, 3, 'Dolore fugiat amet dolore fugiat eu enim quis magna. Amet ad mollit proident consequat veniam aliquip. Mollit ut nisi duis excepteur est irure nostrud proident.', b'1', '2021-06-13 11:37:11', NULL),
	(74, 1, 30, 2, 'Consectetur labore laborum elit proident dolor. Lorem sint esse ullamco in proident irure consectetur aliquip cupidatat sunt occaecat ipsum qui. Exercitation nisi dolor anim commodo culpa qui culpa.', b'1', '2021-11-08 03:50:08', NULL),
	(75, 5, 77, 4, 'Commodo incididunt elit in ipsum eiusmod laborum velit deserunt pariatur pariatur. Voluptate eiusmod excepteur minim elit. Occaecat quis id in sit.', b'1', '2021-06-14 11:40:34', NULL),
	(76, 1, 93, 4, 'Mollit esse laboris aliqua consequat culpa velit. Et fugiat aliqua id nostrud proident. Exercitation incididunt proident cillum minim anim incididunt.', b'1', '2021-09-08 22:08:15', NULL),
	(77, 4, 27, 4, 'Minim duis nulla do culpa eu fugiat nisi Lorem duis nisi magna eiusmod. Occaecat minim consequat laboris nulla exercitation duis ut ipsum non aliqua anim do ex. Nostrud amet aliquip velit irure exercitation quis minim officia sit nulla.', b'1', '2021-10-11 19:01:52', NULL),
	(78, 1, 4, 2, 'Laborum amet voluptate pariatur aliqua. Nostrud magna et mollit magna sit Lorem dolore ex quis Lorem consequat culpa. Nulla et velit dolore elit velit sint Lorem elit occaecat adipisicing dolor ut.', b'1', '2021-08-26 05:28:57', NULL),
	(79, 2, 54, 1, 'Nulla laboris elit commodo consequat commodo incididunt in exercitation. Sunt dolore minim consequat laboris ea ad deserunt incididunt aliquip dolor do. Culpa culpa proident ex ea culpa ex labore esse adipisicing voluptate culpa consequat aliqua.', b'1', '2021-06-24 20:21:42', NULL),
	(80, 2, 26, 1, 'Culpa ipsum proident sint eu labore aliquip sit. Anim culpa in minim id labore anim duis pariatur eu consectetur ullamco eiusmod occaecat occaecat. Esse officia proident eiusmod consequat do magna nisi exercitation nulla ex amet velit elit.', b'1', '2021-11-19 05:31:15', NULL),
	(81, 5, 72, 1, 'Id reprehenderit officia ea aliquip. Sit amet sint laborum labore. Occaecat ullamco in sunt nulla laboris ut.', b'1', '2021-06-05 12:17:14', NULL),
	(82, 5, 85, 1, 'Occaecat ea labore cillum ullamco. Commodo aliquip id culpa nulla ex consequat Lorem reprehenderit nostrud sit sunt duis ex. Eiusmod aliqua irure nostrud nostrud.', b'1', '2021-12-12 18:42:22', NULL),
	(83, 1, 86, 4, 'Qui exercitation cillum dolore labore nostrud mollit aliqua pariatur ad nulla cupidatat non. Amet consequat aute nostrud ea excepteur voluptate amet laborum anim dolor Lorem aliquip Lorem consectetur. Lorem ea enim qui eiusmod Lorem minim do.', b'1', '2021-03-22 13:45:11', NULL),
	(84, 4, 32, 5, 'Irure exercitation sunt ex id officia dolore exercitation aliquip sunt incididunt. Veniam Lorem quis ut dolor commodo dolor exercitation amet. Reprehenderit sunt sunt laborum qui exercitation id reprehenderit tempor tempor.', b'1', '2022-01-17 09:26:09', NULL),
	(85, 5, 9, 1, 'Anim laborum ea pariatur id et fugiat nisi exercitation eu aliquip. Quis incididunt cillum ipsum magna elit et sit ipsum cillum eiusmod labore nulla irure aliquip. Tempor et voluptate reprehenderit qui adipisicing est adipisicing incididunt ad est.', b'1', '2021-08-12 03:30:41', NULL),
	(86, 3, 10, 1, 'Veniam consequat dolore labore duis ullamco nostrud est. Excepteur qui amet adipisicing tempor eiusmod. Proident eiusmod deserunt occaecat laborum commodo sit quis adipisicing enim non culpa.', b'1', '2021-12-04 14:16:47', NULL),
	(87, 4, 44, 2, 'Enim ex laborum ullamco eu proident occaecat. Cupidatat non dolore adipisicing labore nulla labore cupidatat. Cupidatat ex aute amet adipisicing commodo.', b'1', '2021-05-18 23:21:03', NULL),
	(88, 5, 38, 4, 'Dolore nostrud amet nulla mollit amet est et et. Nulla laborum voluptate reprehenderit consectetur. Laborum laboris eu eiusmod anim.', b'1', '2021-06-27 21:10:34', NULL),
	(89, 4, 98, 3, 'Ad excepteur nulla et sint adipisicing sit culpa et non consequat. Eiusmod mollit enim excepteur veniam quis. Elit ad ex excepteur proident dolor deserunt qui labore fugiat labore ullamco.', b'1', '2021-06-27 09:33:32', NULL),
	(90, 3, 89, 5, 'Officia in Lorem voluptate eiusmod velit cillum eu minim ullamco voluptate quis pariatur. Deserunt enim consectetur tempor quis est magna velit reprehenderit minim voluptate et laborum do. Dolore id anim nulla elit eiusmod ipsum deserunt elit anim culpa reprehenderit id elit.', b'1', '2021-02-13 14:42:58', NULL),
	(91, 3, 91, 5, 'Eu dolore qui minim Lorem mollit anim Lorem irure aliquip velit commodo. Do deserunt aute consequat non aute sit minim sint reprehenderit velit pariatur ipsum sunt cillum. Commodo mollit culpa incididunt pariatur fugiat enim nostrud Lorem deserunt ut quis nostrud.', b'1', '2021-08-19 09:12:43', NULL),
	(92, 5, 3, 4, 'Dolor aute aliqua labore qui aliquip nulla excepteur minim duis. Consequat esse occaecat laboris culpa cillum irure qui adipisicing et. Fugiat nisi veniam id anim aliquip.', b'1', '2022-01-28 06:15:21', NULL),
	(93, 1, 13, 4, 'Nulla sint culpa ex exercitation cupidatat commodo enim ullamco pariatur sint. Id ad deserunt sint laborum cupidatat magna. Reprehenderit officia ut eiusmod ad eu et consectetur pariatur esse aliquip officia.', b'1', '2021-03-07 03:01:45', NULL),
	(94, 5, 49, 5, 'Laboris et laboris aliqua minim elit magna nostrud dolor nisi irure ea ea et pariatur. Quis occaecat ipsum culpa qui incididunt tempor sint non. Consectetur incididunt cupidatat id veniam.', b'1', '2021-06-16 15:06:26', NULL),
	(95, 3, 14, 3, 'Voluptate cillum aliqua in in cupidatat qui. Deserunt incididunt irure sit est et nisi excepteur eiusmod reprehenderit. Reprehenderit aliqua labore voluptate tempor ad voluptate reprehenderit.', b'1', '2021-02-14 12:24:01', NULL),
	(96, 1, 10, 5, 'Eu nostrud commodo mollit laborum. Anim aute in quis nulla tempor deserunt nulla. Reprehenderit Lorem labore consequat eu pariatur tempor tempor exercitation ipsum mollit.', b'1', '2021-07-16 03:49:39', NULL),
	(97, 3, 83, 1, 'Officia occaecat sunt et mollit id esse duis nostrud sint veniam nisi cupidatat nulla quis. Reprehenderit consectetur tempor eu labore velit anim do incididunt. Consectetur exercitation consequat est ipsum sint ex consequat magna cillum est voluptate ea.', b'1', '2021-05-24 14:41:47', NULL),
	(98, 1, 11, 2, 'Sit mollit nisi pariatur aliqua proident amet non incididunt. Et non sint officia ullamco ut est. Do cillum aliquip laboris aute aute voluptate nisi voluptate magna sint ut dolor culpa nulla.', b'1', '2021-03-21 19:30:42', NULL),
	(99, 4, 97, 1, 'Magna ipsum velit sit sunt duis velit. Consequat exercitation nostrud officia esse deserunt consequat aliquip ad Lorem anim labore. Reprehenderit et sit aliqua dolore.', b'1', '2021-03-18 12:39:24', NULL),
	(100, 1, 33, 5, 'Reprehenderit duis aliquip deserunt voluptate labore. Ea laboris commodo exercitation ullamco eu elit proident. Adipisicing amet deserunt irure duis exercitation occaecat quis.', b'1', '2021-07-16 20:23:09', NULL),
	(101, 5, 77, 4, 'Enim fugiat cillum in dolor deserunt voluptate fugiat non in proident reprehenderit incididunt. Ea anim enim excepteur duis nisi eiusmod sit voluptate incididunt eu ullamco minim. Magna pariatur aute non enim laboris est aliquip deserunt veniam adipisicing.', b'1', '2021-03-05 20:45:16', NULL),
	(102, 3, 9, 1, 'Consequat sit fugiat irure elit Lorem et. Ipsum non culpa mollit enim ut sint minim duis velit. Aliquip ipsum quis ullamco et cupidatat magna excepteur magna.', b'1', '2021-11-06 15:22:17', NULL),
	(103, 4, 95, 5, 'Nisi mollit elit excepteur ipsum deserunt exercitation eiusmod deserunt dolore. Minim ad irure elit laboris consectetur in. Consectetur eu velit tempor veniam proident amet commodo ut cupidatat.', b'1', '2021-03-02 08:14:30', NULL),
	(104, 4, 21, 4, 'Fugiat aliqua ipsum minim sunt incididunt aliquip amet et nisi amet veniam voluptate elit anim. Veniam ipsum commodo non occaecat magna magna commodo do consequat sit. Exercitation ut qui dolore id cupidatat velit aliquip duis et.', b'1', '2022-01-05 08:15:16', NULL),
	(105, 1, 40, 4, 'Anim veniam nostrud laboris tempor ullamco ea elit aute amet aute elit quis est. Ullamco id eiusmod minim irure. Magna deserunt elit deserunt consequat aliqua et labore.', b'1', '2021-03-06 02:13:52', NULL),
	(106, 4, 12, 2, 'Elit incididunt fugiat laborum adipisicing. Ipsum ut ut commodo occaecat ut ut dolore aute eiusmod ad deserunt commodo eu non. Duis sunt fugiat reprehenderit do dolor dolor sint consectetur magna exercitation sunt.', b'1', '2021-08-26 22:50:18', NULL),
	(107, 3, 75, 2, 'Elit nostrud duis proident nostrud occaecat do nisi culpa deserunt. Reprehenderit elit elit mollit exercitation eiusmod cillum amet et incididunt enim nulla. Proident commodo fugiat elit proident est aliquip ad laborum laborum.', b'1', '2021-09-21 05:07:35', NULL),
	(108, 4, 76, 5, 'Cillum nostrud irure magna veniam Lorem amet sint. Aliquip non dolor anim ea non non ad ipsum dolor aute adipisicing. Pariatur eiusmod ad esse anim consectetur ea tempor dolor ex deserunt esse nostrud velit.', b'1', '2021-04-28 08:25:37', NULL),
	(109, 4, 17, 1, 'Id magna irure anim ut non aute ut nulla nostrud. Voluptate sunt aliquip cupidatat sit pariatur irure sunt excepteur anim duis excepteur irure sint. Adipisicing cupidatat occaecat veniam veniam cupidatat ea consectetur ipsum dolore laborum.', b'1', '2021-11-21 07:37:04', NULL),
	(110, 5, 79, 3, 'Deserunt amet exercitation culpa labore duis exercitation adipisicing. Fugiat esse ad cillum est officia sit ut adipisicing elit. Incididunt enim commodo eiusmod consectetur cupidatat eiusmod consequat consequat voluptate.', b'1', '2022-01-03 09:07:37', NULL),
	(111, 2, 43, 2, 'Non aliquip veniam consectetur ut magna aute velit sint veniam ut. Aliquip commodo ullamco ea sunt aute nostrud ut veniam enim. Ex consectetur irure magna consequat.', b'1', '2021-08-15 13:54:48', NULL),
	(112, 5, 43, 5, 'Excepteur sint nisi cupidatat aute mollit tempor adipisicing incididunt. Enim veniam quis voluptate est. Amet do excepteur nostrud nostrud.', b'1', '2021-08-17 22:52:08', NULL),
	(113, 5, 97, 5, 'Quis dolore duis exercitation aute ullamco exercitation reprehenderit officia sunt reprehenderit reprehenderit. Duis tempor occaecat in minim magna consectetur voluptate Lorem. Deserunt proident exercitation est sunt.', b'1', '2021-05-05 08:17:07', NULL),
	(114, 1, 11, 5, 'Fugiat labore eiusmod nostrud ea pariatur. Cupidatat officia labore eiusmod commodo ea deserunt fugiat voluptate aliquip id. Sunt nostrud minim ex id minim consequat.', b'1', '2021-05-06 02:00:55', NULL),
	(115, 1, 88, 5, 'Laborum officia ipsum ullamco anim ex elit cillum. Tempor nisi sunt esse ad aliqua culpa ea magna ea Lorem cillum. Nulla tempor occaecat est cillum ad tempor nisi ea ullamco pariatur magna.', b'1', '2021-11-01 21:39:03', NULL),
	(116, 3, 7, 5, 'Est reprehenderit dolor do occaecat non ut non consequat consequat. Aute pariatur laboris amet elit minim velit mollit ullamco exercitation do in do do. Culpa voluptate eu proident aute incididunt eiusmod nisi ut reprehenderit culpa ad mollit ut.', b'1', '2021-06-06 17:24:18', NULL),
	(117, 2, 26, 3, 'Nostrud consectetur voluptate adipisicing veniam nostrud excepteur exercitation. Mollit laboris tempor qui mollit. Adipisicing commodo mollit nulla pariatur consectetur voluptate culpa sunt minim velit.', b'1', '2021-06-17 23:26:37', NULL),
	(118, 2, 53, 1, 'Tempor voluptate qui quis irure. Tempor Lorem in do cillum cupidatat officia culpa. Elit id proident nisi minim magna ipsum.', b'1', '2021-10-05 12:44:06', NULL),
	(119, 5, 47, 5, 'Consequat ut duis laboris mollit amet voluptate mollit cillum velit do Lorem. Nulla tempor et enim nisi adipisicing occaecat tempor eiusmod dolor exercitation excepteur amet laboris ullamco. Laboris veniam in excepteur ipsum aute officia culpa ex anim eiusmod velit cillum incididunt.', b'1', '2021-06-03 15:41:00', NULL),
	(120, 4, 28, 5, 'Elit id qui ad incididunt cupidatat cillum dolore. Velit esse dolor id est aliqua reprehenderit consectetur tempor ex sint ea enim. Aute cillum ea quis ea aute excepteur.', b'1', '2021-04-08 09:49:03', NULL),
	(121, 1, 24, 2, 'Culpa duis minim excepteur aliqua ea. Occaecat occaecat excepteur consectetur magna ut veniam id commodo dolor. Culpa exercitation incididunt incididunt sit excepteur voluptate magna reprehenderit.', b'1', '2021-08-08 22:58:38', NULL),
	(122, 4, 83, 1, 'Labore quis anim eiusmod dolore veniam sunt eiusmod consequat commodo tempor nostrud consectetur. Veniam elit ad eiusmod tempor laborum occaecat dolore velit duis aliqua ut. Do excepteur laboris excepteur dolore esse est elit mollit ipsum Lorem consequat nostrud.', b'1', '2021-12-22 02:13:42', NULL),
	(123, 4, 21, 2, 'Ipsum commodo eu commodo et esse sint est consequat in ea excepteur id dolore. Mollit sunt laboris excepteur tempor ipsum do nulla ipsum cupidatat cillum laborum. Officia tempor velit incididunt tempor non aliqua.', b'1', '2021-06-01 18:16:25', NULL),
	(124, 3, 12, 3, 'Veniam eiusmod magna amet ipsum. Tempor cillum aliquip sit cillum cupidatat. Ut sit Lorem reprehenderit adipisicing sint voluptate eu ipsum exercitation labore sunt dolore labore culpa.', b'1', '2021-07-09 08:59:11', NULL),
	(125, 5, 37, 3, 'Sunt fugiat excepteur deserunt irure irure. Magna exercitation veniam eu consectetur enim ipsum ullamco in cillum elit dolore. Occaecat cillum elit sit incididunt minim.', b'1', '2021-10-13 01:31:39', NULL),
	(126, 4, 86, 5, 'Pariatur officia occaecat occaecat aliquip enim non eiusmod aliquip sint tempor nisi tempor. Qui in aute aliqua reprehenderit minim irure cillum. Irure reprehenderit cupidatat consectetur velit reprehenderit sit veniam excepteur Lorem cillum consequat nulla qui adipisicing.', b'1', '2021-09-07 22:56:29', NULL),
	(127, 3, 99, 4, 'Eu nulla nostrud in qui nisi ut laborum labore cupidatat officia aliqua nostrud dolore. Velit cupidatat laborum Lorem est est ea pariatur ullamco occaecat non reprehenderit ea incididunt. Est ad amet sit dolor commodo.', b'1', '2021-06-11 20:09:05', NULL),
	(128, 2, 95, 1, 'Laboris ullamco et qui ad enim dolore magna. Irure commodo ea laborum reprehenderit anim laborum nostrud dolore adipisicing proident eiusmod adipisicing nulla. Nulla cillum voluptate exercitation voluptate anim magna quis non nostrud dolore esse.', b'1', '2021-09-22 22:38:59', NULL),
	(129, 3, 35, 3, 'Eiusmod velit laboris duis nostrud mollit voluptate mollit deserunt esse anim irure culpa sunt sit. Magna fugiat do eiusmod non amet proident ullamco. Deserunt ipsum aute ipsum laboris consequat aute duis ullamco.', b'1', '2021-11-28 11:36:38', NULL),
	(130, 5, 32, 2, 'Nostrud magna consectetur adipisicing duis incididunt amet id ea labore do aliquip minim et. Deserunt exercitation ullamco enim cillum elit nulla aliquip laboris non mollit id deserunt ut. Proident non aliqua velit id irure esse et laboris cupidatat consectetur.', b'1', '2021-04-14 11:43:43', NULL),
	(131, 3, 39, 3, 'Sunt dolor cillum elit aute eiusmod eu aliquip labore adipisicing magna. Ullamco sit excepteur aliqua ut. Reprehenderit anim nostrud labore nulla velit mollit eu sunt Lorem ad.', b'1', '2021-05-13 00:39:32', NULL),
	(132, 2, 90, 4, 'In incididunt pariatur anim est minim esse incididunt magna sit velit. Ad irure pariatur ullamco magna duis ipsum non consectetur eu magna minim reprehenderit aute nisi. Duis cupidatat laboris exercitation aliqua.', b'1', '2021-12-23 06:41:51', NULL),
	(133, 4, 39, 3, 'Lorem elit enim ea labore eu duis do consectetur reprehenderit eu dolore consequat nulla. Est fugiat Lorem labore laboris do ex mollit ut qui aute id et. Excepteur excepteur eu elit mollit dolore aliquip sint in ea nostrud irure fugiat ut consequat.', b'1', '2021-09-01 18:42:05', NULL),
	(134, 4, 57, 1, 'Cupidatat mollit quis et tempor culpa labore ex eu sint. Sit id velit incididunt enim qui. Enim reprehenderit ut do elit culpa.', b'1', '2022-01-20 00:49:47', NULL),
	(135, 3, 51, 4, 'Nulla fugiat et irure excepteur esse Lorem amet voluptate velit ipsum sunt esse. Excepteur sit amet adipisicing do reprehenderit proident. Tempor voluptate nulla occaecat incididunt ipsum anim pariatur duis.', b'1', '2021-07-01 12:49:46', NULL),
	(136, 3, 17, 4, 'Anim anim eu aliquip irure culpa consequat fugiat. Pariatur et reprehenderit amet ea esse. Excepteur consequat labore quis eiusmod in pariatur.', b'1', '2021-07-16 12:01:27', NULL),
	(137, 4, 61, 1, 'Exercitation laboris minim mollit in deserunt sint in in magna. Anim deserunt pariatur eu elit officia aliquip excepteur proident ullamco eiusmod deserunt duis. Mollit nostrud laboris irure quis magna sunt consequat proident excepteur aliqua cillum.', b'1', '2021-11-17 21:49:00', NULL),
	(138, 3, 68, 3, 'Id non eiusmod sint aute sint reprehenderit eiusmod incididunt eu officia. Irure pariatur velit aute culpa irure. Est occaecat tempor exercitation aute aliqua quis sint est id ea.', b'1', '2021-03-11 15:25:56', NULL),
	(139, 1, 42, 4, 'Magna officia incididunt ut exercitation quis anim duis quis. Eu ipsum irure velit reprehenderit tempor aliqua irure excepteur Lorem voluptate ex. Sint et fugiat sit voluptate tempor ut labore reprehenderit proident.', b'1', '2021-07-21 11:22:13', NULL),
	(140, 1, 65, 5, 'Occaecat nisi pariatur exercitation commodo cillum elit dolor dolor fugiat reprehenderit aliqua aute. Dolore esse ut ad eiusmod pariatur dolor non qui commodo eu amet incididunt ipsum veniam. Sunt amet incididunt elit enim excepteur sit ut mollit quis deserunt aliquip id officia.', b'1', '2021-10-27 06:31:07', NULL),
	(141, 3, 59, 2, 'Laboris ea reprehenderit ad reprehenderit culpa tempor nostrud tempor aute dolore mollit. Aliquip minim pariatur ipsum culpa adipisicing irure fugiat laborum laborum occaecat. In esse dolor laborum irure.', b'1', '2021-12-12 23:04:33', NULL),
	(142, 1, 45, 2, 'Ex tempor cillum eu ex id ullamco pariatur elit dolor ea cillum pariatur. Cillum ad aliqua mollit Lorem incididunt. Fugiat est in consectetur nisi officia dolore ut nulla et ad qui eiusmod laborum.', b'1', '2021-06-22 20:57:14', NULL),
	(143, 3, 28, 5, 'Irure ipsum elit Lorem officia tempor duis qui et adipisicing qui. Dolor in elit qui id ullamco adipisicing ipsum irure exercitation non veniam. Voluptate ipsum anim et sint culpa dolore.', b'1', '2021-02-27 08:12:06', NULL),
	(144, 4, 21, 1, 'Ut irure magna voluptate fugiat nulla esse sit enim consectetur. Esse velit culpa laboris exercitation aliquip eiusmod proident ipsum voluptate ex dolor mollit laborum magna. Esse in dolore elit est consectetur ipsum dolor ut est ex nulla labore irure.', b'1', '2021-11-26 00:35:46', NULL),
	(145, 2, 97, 3, 'Nostrud occaecat in veniam enim cillum ipsum. Commodo enim ex in consectetur consequat aute pariatur culpa. Velit nostrud culpa nostrud esse et elit.', b'1', '2021-12-30 21:06:04', NULL),
	(146, 5, 66, 4, 'Sit commodo culpa sunt ea est sunt do enim magna consectetur do. Cillum ea voluptate anim tempor minim adipisicing dolor ipsum irure exercitation dolor ad. Velit deserunt occaecat qui consequat officia labore irure excepteur eu esse ipsum velit.', b'1', '2021-02-17 00:03:55', NULL),
	(147, 4, 51, 3, 'Et ipsum excepteur consequat excepteur laborum mollit ullamco irure incididunt enim tempor pariatur. Do in fugiat sit tempor ipsum quis id commodo. Mollit pariatur ad anim cupidatat esse.', b'1', '2021-02-28 13:43:43', NULL),
	(148, 3, 12, 4, 'Minim incididunt nostrud excepteur ipsum exercitation eiusmod commodo amet. Cupidatat velit qui incididunt reprehenderit cupidatat sunt voluptate dolore adipisicing laboris. Occaecat eu labore et laborum ut ad Lorem magna mollit.', b'1', '2021-05-26 15:19:40', NULL),
	(149, 2, 81, 3, 'Cupidatat qui magna nisi Lorem sit dolor aliqua. Cupidatat nostrud pariatur quis Lorem consequat laboris anim nostrud anim proident in. Velit qui sint laborum minim exercitation id fugiat cupidatat.', b'1', '2022-01-26 10:46:55', NULL),
	(150, 3, 42, 2, 'Velit aliqua ullamco exercitation est minim nulla occaecat et officia veniam minim voluptate. Commodo sit et proident ex cupidatat. Nulla ad exercitation eiusmod veniam aliqua adipisicing incididunt tempor dolore aute.', b'1', '2021-02-24 05:50:14', NULL),
	(151, 1, 22, 3, '11111111111111111111111111', b'1', '2024-04-05 05:29:18', NULL),
	(152, 1, 93, 4, 'sddddddddddddddđ', b'1', '2024-04-05 05:46:37', NULL);

-- Dumping structure for table bookshopdb.province
CREATE TABLE IF NOT EXISTS `province` (
  `id` bigint(20) NOT NULL,
  `addressId` bigint(20) NOT NULL,
  `provinceName` varchar(255) DEFAULT NULL,
  `provinceCode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`addressId`),
  KEY `addressId` (`addressId`),
  CONSTRAINT `province_ibfk_1` FOREIGN KEY (`addressId`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.province: ~2 rows (approximately)
INSERT INTO `province` (`id`, `addressId`, `provinceName`, `provinceCode`) VALUES
	(1, 1, 'Tp.HCM', 'HCM'),
	(2, 2, 'Hn', 'HN');

-- Dumping structure for table bookshopdb.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(25) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phoneNumber` varchar(11) DEFAULT NULL,
  `gender` bit(1) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `role` varchar(10) DEFAULT NULL,
  `createAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_username` (`username`),
  UNIQUE KEY `uq_email` (`email`),
  UNIQUE KEY `uq_phoneNumber` (`phoneNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=1712310499044 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.user: ~9 rows (approximately)
INSERT INTO `user` (`id`, `username`, `password`, `fullname`, `email`, `phoneNumber`, `gender`, `address`, `role`, `createAt`) VALUES
	(1, 'user1', '202CB962AC59075B964B07152D234B70', 'Dunn Mcpherson', 'dunnmcpherson@recrisys.com', '0989894900', b'0', '8 Virginia Place, Troy, Norway', 'ADMIN', '2024-03-27 14:08:39'),
	(2, 'user2', '202CB962AC59075B964B07152D234B70', 'Foreman Carter', 'foremancarter@recrisys.com', '0993194154', b'0', '28 Richardson Street, Layhill, Netherlands', 'EMPLOYEE', '2024-03-27 14:08:39'),
	(3, 'user3', '202CB962AC59075B964B07152D234B70', 'Felecia Cabrera', 'feleciacabrera@recrisys.com', '0930174351', b'1', '41 Linden Street, Slovan, S. Georgia and S. Sandwich Isls.', 'EMPLOYEE', '2024-03-27 14:08:39'),
	(4, 'user4', '202CB962AC59075B964B07152D234B70', 'Juliette Mcdowell', 'juliettemcdowell@recrisys.com', '0911925643', b'1', '5 Schenck Court, Dana, Cyprus', 'CUSTOMER', '2024-03-27 14:08:39'),
	(5, 'user5', '202CB962AC59075B964B07152D234B70', 'Vilma Spencer', 'vilmaspencer@recrisys.com', '0987509391', b'1', '5 Pooles Lane, Allentown, Zambia', 'CUSTOMER', '2024-03-27 14:08:39'),
	(6, 'hao', '32791E666FEF96B588DB16200D5FDA94', 'Quang Hiu', 'abc@gmail.com', '0123123123', b'0', '12', 'CUSTOMER', '2024-03-27 14:08:39'),
	(10, 'hiu', '111', 'Quang Hieu', '', '123123123', b'1', '', '', '2024-03-27 15:25:59'),
	(1712310114373, NULL, NULL, 'Hiếu Ngô Quang', 'timkodctk3@gmail.com', NULL, b'0', NULL, 'CUSTOMER', '2024-04-05 09:41:34'),
	(1712310499043, NULL, NULL, 'Thư Lê', 'kotimdctk@gmail.com', NULL, b'0', NULL, 'CUSTOMER', '2024-04-05 09:48:09');

-- Dumping structure for table bookshopdb.ward
CREATE TABLE IF NOT EXISTS `ward` (
  `id` bigint(20) NOT NULL,
  `addressId` bigint(20) NOT NULL,
  `wardName` varchar(255) DEFAULT NULL,
  `wardCode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`addressId`),
  KEY `addressId` (`addressId`),
  CONSTRAINT `ward_ibfk_1` FOREIGN KEY (`addressId`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.ward: ~2 rows (approximately)
INSERT INTO `ward` (`id`, `addressId`, `wardName`, `wardCode`) VALUES
	(1, 1, 'Linh Trung', 'LT'),
	(2, 2, 'HN', 'HN');

-- Dumping structure for table bookshopdb.wishlist_item
CREATE TABLE IF NOT EXISTS `wishlist_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `productId` bigint(20) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_userId_productId` (`userId`,`productId`),
  KEY `idx_wishlist_item_user` (`userId`),
  KEY `idx_wishlist_item_product` (`productId`),
  CONSTRAINT `fk_wishlist_item_product` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_wishlist_item_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table bookshopdb.wishlist_item: ~34 rows (approximately)
INSERT INTO `wishlist_item` (`id`, `userId`, `productId`, `createdAt`) VALUES
	(1, 4, 1, '2021-07-20 19:09:42'),
	(2, 4, 2, '2021-04-11 10:08:10'),
	(3, 4, 3, '2021-08-24 14:06:10'),
	(4, 5, 4, '2021-10-25 03:00:44'),
	(5, 5, 5, '2021-06-10 11:29:11'),
	(6, 5, 6, '2021-10-21 21:19:32'),
	(7, 4, 7, '2021-09-22 12:37:18'),
	(8, 4, 8, '2021-04-26 17:52:04'),
	(9, 5, 9, '2021-12-10 11:11:25'),
	(10, 4, 10, '2021-11-16 13:54:23'),
	(11, 4, 11, '2021-06-09 20:54:36'),
	(12, 5, 12, '2022-01-11 16:15:34'),
	(13, 4, 13, '2021-06-03 09:02:59'),
	(14, 5, 14, '2021-11-12 06:26:01'),
	(15, 5, 15, '2021-05-24 21:12:50'),
	(16, 5, 16, '2021-03-04 02:34:08'),
	(17, 5, 17, '2021-07-27 09:00:13'),
	(18, 4, 18, '2021-11-18 21:20:43'),
	(19, 4, 19, '2021-07-30 14:17:17'),
	(20, 5, 20, '2021-03-24 04:46:29'),
	(21, 4, 21, '2021-03-27 01:05:54'),
	(22, 4, 22, '2021-03-19 09:57:13'),
	(23, 4, 23, '2021-12-08 19:19:39'),
	(24, 5, 24, '2021-10-02 08:22:36'),
	(25, 4, 25, '2021-12-19 20:25:18'),
	(26, 5, 26, '2021-02-22 03:32:54'),
	(27, 4, 27, '2021-10-24 07:34:35'),
	(28, 4, 28, '2021-05-04 02:40:17'),
	(29, 4, 29, '2021-03-04 13:11:19'),
	(30, 5, 30, '2021-03-12 05:44:19'),
	(31, 1, 36, '2024-04-05 04:41:50'),
	(32, 1, 55, '2024-04-05 04:42:29'),
	(33, 1, 22, '2024-04-05 05:10:46'),
	(37, 1, 78, '2024-04-05 05:18:58');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 18, 2023 at 01:08 PM
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
-- Database: `ie104_group2`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_login_name` varchar(100) NOT NULL,
  `admin_password` varchar(100) NOT NULL,
  `admin_name` varchar(100) NOT NULL,
  `admin_full_name` varchar(100) NOT NULL,
  `admin_avt_img` varchar(100) DEFAULT NULL,
  `admin_birth` date NOT NULL,
  `admin_sex` tinyint(1) NOT NULL,
  `admin_email` varchar(100) NOT NULL,
  `admin_phone` varchar(10) NOT NULL,
  `admin_address` text DEFAULT NULL,
  `admin_role` varchar(100) DEFAULT 'Owner',
  `admin_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_login_name`, `admin_password`, `admin_name`, `admin_full_name`, `admin_avt_img`, `admin_birth`, `admin_sex`, `admin_email`, `admin_phone`, `admin_address`, `admin_role`, `admin_active`) VALUES
(1, '21522436', '$2a$08$gacaZP8P7lcQeHoiW9fgkOr47/Y0vHv3HOixU1rELCc6rkv0oDw9K', 'Nhung', 'Nguyễn Thị Hồng Nhung', 'admin_1.jpg', '2003-04-02', 1, '21522436@gmail.techtwo.vn', '0987296708', 'Ký túc xá khu A: Đường Tạ Quang Bửu, Khu phố 6, Phường Linh Trung, Thành phố Thủ Đức, Thành phố Hồ Chí Minh', 'Owner', 1);

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `customer_id` int(11) NOT NULL,
  `product_variant_id` int(11) NOT NULL,
  `cart_quantity` int(11) NOT NULL,
  `cart_added_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `category_img` varchar(100) NOT NULL,
  `categorry_type` varchar(50) NOT NULL DEFAULT 'Điện máy',
  `category_added_date` date NOT NULL DEFAULT current_timestamp(),
  `category_is_display` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;


--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `user_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 31),
(12, 32),
(13, 33);

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `discount_id` int(11) NOT NULL,
  `discount_name` varchar(100) NOT NULL,
  `discount_description` text DEFAULT NULL,
  `discount_start_date` date NOT NULL DEFAULT current_timestamp(),
  `discount_end_date` date NOT NULL DEFAULT current_timestamp(),
  `discount_amount` float NOT NULL,
  `discount_is_display` tinyint(1) NOT NULL DEFAULT 1,
  `discount_img` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `discounts`
--

INSERT INTO `discounts` (`discount_id`, `discount_name`, `discount_description`, `discount_start_date`, `discount_end_date`, `discount_amount`, `discount_is_display`, `discount_img`) VALUES
(1, 'Black Friday', 'Chương trình giảm giá Black Friday', '2023-11-23', '2023-11-30', 10, 1, ''),
(2, 'Vui Tết', 'Chương trình giảm giá dịp Tết', '2024-01-01', '2024-03-01', 15, 1, ''),
(3, 'Vui Trung Thu', 'Chương trình giảm giá dịp Trung Thu', '2023-09-25', '2023-09-30', 20, 1, ''),
(4, 'Back to school', 'Chương trình giảm giá cho học sinh, sinh viên back to school', '2023-11-01', '2024-11-30', 12.5, 1, ''),
(5, 'Kỷ niệm 5 năm thành lập', 'Chương trình giảm giá kỷ niệm 5 năm thành lập của TechTwo', '2023-11-01', '2024-02-29', 10, 1, ''),
(6, '05/05', 'Chương trình giảm giá ngày đôi 05/05', '2023-05-01', '2023-05-31', 18, 1, ''),
(7, '06/06', 'Chương trình giảm giá ngày đôi 06/06', '2023-06-01', '2023-06-30', 15, 1, ''),
(8, '09/09', 'Chương trình giảm giá ngày đôi 09/09', '2023-09-01', '2023-09-30', 10, 1, ''),
(9, '10/10', 'Chương trình giảm giá ngày đôi 10/10', '2023-10-01', '2023-12-31', 12, 1, ''),
(10, '11/11', 'Chương trình giảm giá ngày đôi 11/11', '2023-11-01', '2023-12-31', 10, 1, ''),
(11, '12/12', 'Chương trình giảm giá ngày đôi 12/12', '2023-11-30', '2023-12-13', 12, 1, ''),
(12, '1/1', 'Chương trình giảm giá ngày đôi 1/1', '2023-12-27', '2024-01-02', 11, 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE `feedbacks` (
  `feedback_id` int(11) NOT NULL,
  `product_variant_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `feedback_date` date NOT NULL DEFAULT current_timestamp(),
  `feedback_rate` int(11) NOT NULL DEFAULT 5,
  `feedback_content` text DEFAULT 'Bạn chưa để lại lời nhận xét nào',
  `feedback_is_display` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;


--
-- Triggers `feedbacks`
--
DELIMITER $$
CREATE TRIGGER `insert_after_feedbacks` AFTER INSERT ON `feedbacks` FOR EACH ROW BEGIN
    DECLARE avg_rate DECIMAL(10, 1) ;
    DECLARE product_id INT(11) ;
    DECLARE product_variant_id INT(11);
   
    SET product_variant_id = NEW.product_variant_id;
    
    SET product_id = (SELECT product_variants.product_id 
    FROM product_variants 
    WHERE product_variants.product_variant_id = product_variant_id);
    
    SET avg_rate =  (SELECT AVG(feedbacks.feedback_rate) 
     FROM feedbacks, product_variants 
     WHERE feedbacks.product_variant_id = product_variants.product_variant_id 
     AND product_variants.product_id = product_id 
     GROUP BY product_variants.product_id);
    
    UPDATE products 
    SET products.product_rate = avg_rate
    WHERE products.product_id = product_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `feedback_imgs`
--

CREATE TABLE `feedback_imgs` (
  `feedback_img_id` int(11) NOT NULL,
  `feedback_id` int(11) NOT NULL,
  `feedback_img_name` varchar(100) NOT NULL,
  `feedback_img_is_display` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;


-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `notification_type_id` int(11) NOT NULL,
  `notification_title` varchar(100) NOT NULL,
  `notification_subtitle` text DEFAULT NULL,
  `notification_content` text NOT NULL,
  `notification_date` date NOT NULL DEFAULT current_timestamp(),
  `notification_is_display` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `notification_type_id`, `notification_title`, `notification_subtitle`, `notification_content`, `notification_date`, `notification_is_display`) VALUES
(1, 1, 'Đơn hàng mới', 'Bạn có một đơn hàng mới đang chờ xử lý.', 'Đơn hàng mới đã được đặt thành công. Vui lòng kiểm tra và xử lý đơn hàng.', '2023-11-02', 1),
(2, 2, 'Đơn hàng đã được vận chuyển', 'Đơn hàng của bạn đã được vận chuyển và đang trên đường đến tay bạn.', 'Đơn hàng đã được vận chuyển thành công. Bạn có thể theo dõi trạng thái đơn hàng tại đây.', '2023-11-02', 1),
(3, 3, 'Đơn hàng đã được giao', 'Đơn hàng của bạn đã được giao đến địa chỉ của bạn.', 'Đơn hàng đã được giao thành công. Vui lòng kiểm tra và xác nhận đơn hàng.', '2023-11-02', 1),
(4, 4, 'Thanh toán đã được nhận', 'Thanh toán của bạn cho đơn hàng đã được nhận.', 'Thanh toán đã được nhận thành công. Vui lòng kiểm tra email của bạn để biết thêm chi tiết.', '2023-11-02', 1),
(5, 5, 'Phản hồi đã được nhận', 'Bạn đã nhận được phản hồi từ khách hàng.', 'Khách hàng đã phản hồi về sản phẩm của bạn. Vui lòng kiểm tra và xử lý phản hồi này.', '2023-11-02', 1),
(6, 6, 'Giảm giá 50% cho tất cả sản phẩm', 'Cơ hội mua sắm tuyệt vời!', 'Từ ngày 03/11/2023 đến ngày 09/11/2023, chúng tôi giảm giá 50% cho tất cả sản phẩm. Đây là cơ hội tuyệt vời để bạn mua sắm với giá ưu đãi.', '2023-11-02', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notification_types`
--

CREATE TABLE `notification_types` (
  `notification_type_id` int(11) NOT NULL,
  `notification_type_name` varchar(100) NOT NULL,
  `notification_type_img` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `notification_types`
--

INSERT INTO `notification_types` (`notification_type_id`, `notification_type_name`, `notification_type_img`) VALUES
(1, 'Order placed', 'order_placed.jpg'),
(2, 'Order shipped', 'order_shipped.jpg'),
(3, 'Order delivered', 'order_delivered.jpg'),
(4, 'Payment received', 'payment_received.jpg'),
(5, 'Feedback received', 'feedback_received.jpg'),
(6, 'Sale', 'sale.jpg'),
(7, 'Lucky Customer', 'lucky_customer.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL DEFAULT 1,
  `order_name` varchar(100) NOT NULL,
  `order_phone` varchar(10) NOT NULL,
  `order_date` date NOT NULL DEFAULT current_timestamp(),
  `order_delivery_date` date NOT NULL,
  `order_delivery_address` varchar(100) NOT NULL,
  `order_note` text NOT NULL,
  `order_total_before` int(11) DEFAULT 0,
  `order_total_after` int(11) NOT NULL DEFAULT 0,
  `paying_method_id` int(11) NOT NULL DEFAULT 1,
  `order_paying_date` date NOT NULL,
  `order_is_paid` tinyint(1) NOT NULL,
  `order_status` enum('Chờ thanh toán','Đang giao hàng','Hoàn thành','Đã hủy') DEFAULT 'Chờ thanh toán'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_id` int(11) NOT NULL,
  `product_variant_id` int(11) NOT NULL,
  `order_detail_quantity` int(11) NOT NULL,
  `order_detail_price_before` int(11) DEFAULT 0,
  `order_detail_price_after` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Triggers `order_details`
--
DELIMITER $$
CREATE TRIGGER `delete_before_order_details` BEFORE DELETE ON `order_details` FOR EACH ROW BEGIN
    -- Update orders
    UPDATE orders
    SET
        order_total_after = (
            SELECT SUM(order_detail_price_after * order_detail_quantity)
            FROM order_details
            WHERE order_id = OLD.order_id
        ),
        order_total_before = (
            SELECT SUM(order_detail_price_before * order_detail_quantity)
            FROM order_details
            WHERE order_id = OLD.order_id
        )
    WHERE order_id = OLD.order_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_before_order_details` BEFORE INSERT ON `order_details` FOR EACH ROW BEGIN
    -- Calculate new prices
    SET NEW.order_detail_price_before = (
        SELECT product_variant_price
        FROM product_variants
        WHERE product_variant_id = NEW.product_variant_id
    );

    SET NEW.order_detail_price_after = COALESCE(
        (
            SELECT view_product_variants.product_variant_price * (1 - view_product_variants.discount_amount / 100)
            FROM view_product_variants
            WHERE view_product_variants.product_variant_id = NEW.product_variant_id
        ),
        NEW.order_detail_price_before
    );
    
    -- Set default value if order_detail_price_after is NULL
    IF NEW.order_detail_price_after IS NULL THEN
        SET NEW.order_detail_price_after = (
        SELECT product_variant_price
        FROM product_variants
        WHERE product_variant_id = NEW.product_variant_id
    );
    END IF;

    -- Update orders
    UPDATE orders
    SET
        order_total_after = (
            SELECT SUM(NEW.order_detail_price_after * NEW.order_detail_quantity)
            FROM order_details
            WHERE order_id = NEW.order_id
        ),
        order_total_before = (
            SELECT SUM(NEW.order_detail_price_before * NEW.order_detail_quantity)
            FROM order_details
            WHERE order_id = NEW.order_id
        )
    WHERE order_id = NEW.order_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_before_order_details` BEFORE UPDATE ON `order_details` FOR EACH ROW BEGIN
    -- Calculate new prices
    SET NEW.order_detail_price_before = (
        SELECT product_variant_price
        FROM product_variants
        WHERE product_variant_id = NEW.product_variant_id
    );

    SET NEW.order_detail_price_after = COALESCE(
        (
            SELECT view_product_variants.product_variant_price * (1 - view_product_variants.discount_amount / 100)
            FROM view_product_variants
            WHERE view_product_variants.product_variant_id = NEW.product_variant_id
        ),
        NEW.order_detail_price_before
    );
    
    -- Set default value if order_detail_price_after is NULL
    IF NEW.order_detail_price_after IS NULL THEN
        SET NEW.order_detail_price_after = (
        SELECT product_variant_price
        FROM product_variants
        WHERE product_variant_id = NEW.product_variant_id
    );
    END IF;

    -- Update orders
    UPDATE orders
    SET
        order_total_after = (
            SELECT SUM(NEW.order_detail_price_after * NEW.order_detail_quantity)
            FROM order_details
            WHERE order_id = NEW.order_id
        ),
        order_total_before = (
            SELECT SUM(NEW.order_detail_price_before * NEW.order_detail_quantity)
            FROM order_details
            WHERE order_id = NEW.order_id
        )
    WHERE order_id = NEW.order_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `paying_methods`
--

CREATE TABLE `paying_methods` (
  `paying_method_id` int(11) NOT NULL,
  `paying_method_name` varchar(100) NOT NULL,
  `paying_method_is_display` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `paying_methods`
--

INSERT INTO `paying_methods` (`paying_method_id`, `paying_method_name`, `paying_method_is_display`) VALUES
(1, 'Ví điện tử MoMo', 1),
(2, 'Thẻ ngân hàng', 1),
(3, 'Thẻ tín dụng', 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `product_avt_img` varchar(100) NOT NULL,
  `product_rate` float NOT NULL,
  `product_description` text DEFAULT NULL,
  `product_period` int(11) DEFAULT NULL,
  `product_view_count` int(11) DEFAULT NULL,
  `product_is_display` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_details`
--

CREATE TABLE `product_details` (
  `product_detail_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_detail_name` varchar(100) NOT NULL,
  `product_detail_value` text DEFAULT NULL,
  `product_detail_unit` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_imgs`
--

CREATE TABLE `product_imgs` (
  `image_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `image_name` varchar(100) NOT NULL,
  `image_is_display` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `product_variant_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `product_variant_name` varchar(100) NOT NULL,
  `product_variant_price` float NOT NULL,
  `product_variant_available` int(11) NOT NULL,
  `product_variant_is_stock` tinyint(1) DEFAULT NULL,
  `product_variant_is_bestseller` tinyint(1) DEFAULT NULL,
  `product_variant_added_date` date NOT NULL DEFAULT current_timestamp(),
  `product_variant_is_display` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;


-- --------------------------------------------------------

--
-- Table structure for table `staffs`
--

CREATE TABLE `staffs` (
  `staff_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `staff_role` varchar(100) NOT NULL,
  `staff_description` text DEFAULT NULL,
  `staff_added_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `staffs`
--

INSERT INTO `staffs` (`staff_id`, `user_id`, `staff_role`, `staff_description`, `staff_added_date`) VALUES
(1, 11, 'Giám đốc', 'Chịu trách nhiệm quản lý chung công ty', '2023-11-27'),
(2, 12, 'Trưởng phòng kinh doanh', 'Chịu trách nhiệm quản lý hoạt động kinh doanh của công ty', '2023-11-27'),
(3, 13, 'Nhân viên kinh doanh', 'Chịu trách nhiệm bán hàng và phát triển khách hàng', '2023-11-27'),
(4, 14, 'Nhân viên kỹ thuật', 'Chịu trách nhiệm hỗ trợ kỹ thuật cho khách hàng', '2023-11-27'),
(5, 15, 'Nhân viên chăm sóc khách hàng', 'Chịu trách nhiệm chăm sóc khách hàng và giải quyết các vấn đề của khách hàng', '2023-11-27');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `supplier_logo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_login_name` varchar(100) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `user_avt_img` varchar(100) DEFAULT NULL,
  `user_birth` date DEFAULT NULL,
  `user_sex` enum('Nữ','Nam') DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `user_phone` char(10) NOT NULL,
  `user_address` varchar(255) DEFAULT NULL,
  `user_register_date` date NOT NULL DEFAULT current_timestamp(),
  `user_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_login_name`, `user_password`, `user_name`, `user_avt_img`, `user_birth`, `user_sex`, `user_email`, `user_phone`, `user_address`, `user_register_date`, `user_active`) VALUES
(1, '0987654321', '$2a$08$z6uK/g62SytTVamrrt.9J.C3uDPoqNVN.fl0ZVARVuDu.WAtQcuv2', 'Phan Nguyễn Hải Yến', 'user1.png', '2023-12-05', 'Nữ', 'haiyen@gmail.com', '0987654321', 'An Bình, Dĩ An, Bình Dương', '2023-08-01', 1),
(2, '0987654322', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Trần Thị Bình', 'user2.png', '1991-02-02', 'Nữ', 'user2@example.com', '0987654322', 'TP. Hồ Chí Minh', '2023-01-01', 1),
(3, '0987654323', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Lê Quang Yên', 'user3.png', '1990-01-01', 'Nam', 'user3@example.com', '0987654323', 'Hà Nội', '2023-01-01', 1),
(4, '0987654324', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Trương Quang Phú', 'user4.png', '1990-01-01', 'Nam', 'user4@example.com', '0987654324', 'Hải Dương', '2023-01-01', 1),
(5, '0987654325', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Trần Thiên Lộc', 'user5.png', '1990-01-01', 'Nam', 'user5@example.com', '0987654325', 'Hà Nội', '2023-01-01', 1),
(6, '0987654326', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Nguyễn Phú Cường', 'user6.png', '1999-03-03', 'Nam', 'user6@example.com', '0987654326', 'Đà Nẵng', '2023-01-01', 1),
(7, '0987654327', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Phan Thanh Danh', 'user7.png', '1999-03-03', 'Nam', 'user7@example.com', '0987654327', 'Đồng Nai', '2023-01-01', 1),
(8, '0987654328', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Mai Văn Tiên', 'user8.png', '1999-03-03', 'Nam', 'user8@example.com', '0987654328', 'Đà Nẵng', '2023-01-01', 1),
(9, '0987654329', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Tô Thanh Lộc', 'user9.png', '1999-03-03', 'Nam', 'user9@example.com', '0987654329', 'Bình Phước', '2023-01-01', 1),
(10, '0987654330', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Nguyễn Nhựt Tiến', 'user10.png', '1999-03-03', 'Nam', 'user10@example.com', '0987654330', 'Cần Thơ', '2023-01-01', 1),
(11, '0987654331', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Lý Văn Nghĩa', 'user11.png', '1999-03-03', 'Nam', 'user11@example.com', '0987654331', '', '2023-01-01', 1),
(12, '0987654332', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Hồ Thị Mai', 'user12.png', '1999-03-03', 'Nữ', 'user12@example.com', '0987654332', 'Bình Dương', '2023-01-01', 1),
(13, '0987654333', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Lê Bích Tuyền', 'user13.png', '1999-03-03', 'Nữ', 'user13@example.com', '0987654333', 'Bình Dương', '2023-01-01', 1),
(14, '0987654334', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Lê Hồng Bảo Trinh', 'user14.png', '1999-03-03', 'Nữ', 'user14@example.com', '0987654334', 'Bình Dương', '2023-01-01', 1),
(15, '0987654335', '$2a$08$eOIGRuOHME.s5d0c740JCuAtlEMupog/udCJwqHn9PC1jAQXPPX.e', 'Nguyễn Hoàng PHương Linh', 'user15.png', '1999-03-03', 'Nữ', 'user15@example.com', '0987654335', 'Bình Dương', '2023-01-01', 1),
(31, '0987296708', '$2a$08$YzCffpozMPsdIMzoZ21M7.lbdOBdOgCobDdKZaZpU8u6RgUeb9zUm', 'Hồng Nhung', NULL, NULL, NULL, NULL, '0987296708', NULL, '2023-12-15', 1),
(32, '0997654321', '$2a$08$m34kubjtYr2Hd5YufiNuUOTkGX92FjTKJ6dklXfgFKiWdCA7fRc.e', 'Hồng Nhung', NULL, NULL, NULL, NULL, '0997654321', NULL, '2023-12-15', 1),
(33, '0887654321', '$2a$08$EX.tL8w9RDCIXlHXR8/yIuzFkaUFqPDiNuE7vZJCNxzD5u1f5KzcK', 'Linh Phương', NULL, NULL, NULL, NULL, '0887654321', NULL, '2023-12-15', 1);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `after_insert_users` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    INSERT INTO customers (user_id)
    VALUES (NEW.user_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_notification`
--

CREATE TABLE `user_notification` (
  `user_id` int(11) NOT NULL,
  `notification_id` int(11) NOT NULL,
  `user_notification_is_read` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `user_notification`
--

INSERT INTO `user_notification` (`user_id`, `notification_id`, `user_notification_is_read`) VALUES
(1, 1, 0),
(1, 2, 0),
(1, 3, 0),
(1, 4, 0),
(1, 5, 0),
(1, 6, 0),
(2, 1, 0),
(2, 2, 0),
(2, 3, 0),
(2, 4, 0),
(2, 6, 0),
(3, 6, 0),
(4, 6, 0),
(5, 6, 0),
(6, 6, 0),
(7, 6, 0),
(8, 6, 0),
(9, 6, 0),
(10, 6, 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_cart`
-- (See below for the actual view)
--
CREATE TABLE `view_cart` (
`customer_id` int(11)
,`cart_quantity` int(11)
,`product_id` int(11)
,`product_name` varchar(100)
,`product_avt_img` varchar(100)
,`product_rate` float
,`product_view_count` int(11)
,`product_period` int(11)
,`category_id` int(11)
,`category_name` varchar(100)
,`product_variant_id` int(11)
,`product_variant_name` varchar(100)
,`product_variant_price` float
,`product_variant_available` int(11)
,`product_variant_is_bestseller` tinyint(1)
,`discount_amount` float
,`discount_description` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_cate_admin`
-- (See below for the actual view)
--
CREATE TABLE `view_cate_admin` (
`category_id` int(11)
,`category_name` varchar(100)
,`category_img` varchar(100)
,`categorry_type` varchar(50)
,`category_added_date` date
,`category_is_display` tinyint(1)
,`product_count` bigint(21)
,`revenue` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_count_cart`
-- (See below for the actual view)
--
CREATE TABLE `view_count_cart` (
`customer_id` int(11)
,`user_id` int(11)
,`count_cart` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_dashboard`
-- (See below for the actual view)
--
CREATE TABLE `view_dashboard` (
`customer_count` bigint(21)
,`quantity_sold` decimal(42,0)
,`revenue` decimal(54,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_discounts`
-- (See below for the actual view)
--
CREATE TABLE `view_discounts` (
`discount_id` int(11)
,`discount_name` varchar(100)
,`discount_description` text
,`discount_start_date` date
,`discount_end_date` date
,`discount_amount` float
,`discount_is_display` tinyint(1)
,`discount_img` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_getchart_revenue`
-- (See below for the actual view)
--
CREATE TABLE `view_getchart_revenue` (
`year` int(4)
,`month` int(2)
,`order_success` bigint(21)
,`revenue` decimal(32,0)
,`order_cancel` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_getchart_top5_product`
-- (See below for the actual view)
--
CREATE TABLE `view_getchart_top5_product` (
`product_variant_id` int(11)
,`quantity_sold` decimal(32,0)
,`revenue` decimal(42,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_notifications`
-- (See below for the actual view)
--
CREATE TABLE `view_notifications` (
`notification_id` int(11)
,`notification_type_id` int(11)
,`notification_title` varchar(100)
,`notification_subtitle` text
,`notification_content` text
,`notification_date` date
,`notification_is_display` tinyint(1)
,`user_id` int(11)
,`user_notification_is_read` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_order`
-- (See below for the actual view)
--
CREATE TABLE `view_order` (
`order_id` int(11)
,`customer_id` int(11)
,`staff_id` int(11)
,`order_name` varchar(100)
,`order_phone` varchar(10)
,`order_date` date
,`order_delivery_date` date
,`order_delivery_address` varchar(100)
,`order_note` text
,`order_total_before` int(11)
,`order_total_after` int(11)
,`paying_method_id` int(11)
,`order_paying_date` date
,`order_is_paid` tinyint(1)
,`order_status` enum('Chờ thanh toán','Đang giao hàng','Hoàn thành','Đã hủy')
,`paying_method_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_orders`
-- (See below for the actual view)
--
CREATE TABLE `view_orders` (
`order_id` int(11)
,`customer_id` int(11)
,`staff_id` int(11)
,`order_name` varchar(100)
,`order_phone` varchar(10)
,`order_date` date
,`order_delivery_date` date
,`order_delivery_address` varchar(100)
,`order_note` text
,`order_total_before` int(11)
,`order_total_after` int(11)
,`paying_method_id` int(11)
,`order_paying_date` date
,`order_is_paid` tinyint(1)
,`order_status` enum('Chờ thanh toán','Đang giao hàng','Hoàn thành','Đã hủy')
,`paying_method_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_order_detail`
-- (See below for the actual view)
--
CREATE TABLE `view_order_detail` (
`order_id` int(11)
,`product_variant_id` int(11)
,`order_detail_quantity` int(11)
,`order_detail_price_before` int(11)
,`order_detail_price_after` int(11)
,`product_id` int(11)
,`product_name` varchar(100)
,`product_avt_img` varchar(100)
,`product_variant_name` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_products_admin`
-- (See below for the actual view)
--
CREATE TABLE `view_products_admin` (
`product_id` int(11)
,`product_name` varchar(100)
,`product_avt_img` varchar(100)
,`product_rate` float
,`product_view_count` int(11)
,`product_period` int(11)
,`category_id` int(11)
,`category_name` varchar(100)
,`product_variant_id` int(11)
,`product_variant_name` varchar(100)
,`product_variant_price` float
,`product_variant_available` int(11)
,`product_variant_is_bestseller` tinyint(1)
,`discount_amount` float
,`discount_description` text
,`product_count` bigint(21)
,`quantity_sold` decimal(42,0)
,`revenue` decimal(54,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_products_info`
-- (See below for the actual view)
--
CREATE TABLE `view_products_info` (
`product_id` int(11)
,`category_id` int(11)
,`product_name` varchar(100)
,`supplier_id` int(11)
,`product_avt_img` varchar(100)
,`product_rate` float
,`product_description` text
,`product_period` int(11)
,`product_view_count` int(11)
,`product_is_display` tinyint(1)
,`product_variant_id` int(11)
,`discount_id` int(11)
,`product_variant_name` varchar(100)
,`product_variant_price` float
,`product_variant_available` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_products_resume`
-- (See below for the actual view)
--
CREATE TABLE `view_products_resume` (
`product_id` int(11)
,`product_name` varchar(100)
,`product_avt_img` varchar(100)
,`product_rate` float
,`product_view_count` int(11)
,`category_id` int(11)
,`category_name` varchar(100)
,`product_variant_id` int(11)
,`product_variant_is_bestseller` tinyint(1)
,`product_variant_price` float
,`product_lastdate_added` date
,`discount_amount` float
,`discount_description` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_product_feedbacks`
-- (See below for the actual view)
--
CREATE TABLE `view_product_feedbacks` (
`product_variant_name` varchar(100)
,`product_id` int(11)
,`feedback_id` int(11)
,`product_variant_id` int(11)
,`customer_id` int(11)
,`order_id` int(11)
,`feedback_date` date
,`feedback_rate` int(11)
,`feedback_content` text
,`feedback_is_display` tinyint(1)
,`feedback_img_id` int(11)
,`feedback_img_name` varchar(100)
,`user_name` varchar(100)
,`user_avt_img` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_product_variants`
-- (See below for the actual view)
--
CREATE TABLE `view_product_variants` (
`product_id` int(11)
,`product_name` varchar(100)
,`product_avt_img` varchar(100)
,`product_rate` float
,`product_view_count` int(11)
,`product_period` int(11)
,`category_id` int(11)
,`category_name` varchar(100)
,`product_variant_id` int(11)
,`product_variant_name` varchar(100)
,`product_variant_price` float
,`product_variant_available` int(11)
,`product_variant_is_bestseller` tinyint(1)
,`discount_amount` float
,`discount_description` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_product_variant_detail`
-- (See below for the actual view)
--
CREATE TABLE `view_product_variant_detail` (
`product_variant_id` int(11)
,`product_id` int(11)
,`discount_id` int(11)
,`product_variant_name` varchar(100)
,`product_variant_price` float
,`product_variant_available` int(11)
,`product_variant_is_stock` tinyint(1)
,`product_variant_is_bestseller` tinyint(1)
,`product_variant_added_date` date
,`product_variant_is_display` tinyint(1)
,`discount_name` varchar(100)
,`discount_description` text
,`discount_start_date` date
,`discount_end_date` date
,`discount_amount` float
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_user`
-- (See below for the actual view)
--
CREATE TABLE `view_user` (
`user_id` int(11)
,`user_login_name` varchar(100)
,`user_password` varchar(100)
,`user_name` varchar(100)
,`user_avt_img` varchar(100)
,`user_birth` varchar(10)
,`user_sex` enum('Nữ','Nam')
,`user_email` varchar(100)
,`user_phone` char(10)
,`user_address` varchar(255)
,`user_register_date` date
,`user_active` tinyint(1)
,`customer_id` int(11)
,`staff_id` int(11)
,`staff_role` varchar(100)
,`staff_description` text
);

-- --------------------------------------------------------

--
-- Structure for view `view_cart`
--
DROP TABLE IF EXISTS `view_cart`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cart`  AS SELECT `carts`.`customer_id` AS `customer_id`, `carts`.`cart_quantity` AS `cart_quantity`, `view_product_variants`.`product_id` AS `product_id`, `view_product_variants`.`product_name` AS `product_name`, `view_product_variants`.`product_avt_img` AS `product_avt_img`, `view_product_variants`.`product_rate` AS `product_rate`, `view_product_variants`.`product_view_count` AS `product_view_count`, `view_product_variants`.`product_period` AS `product_period`, `view_product_variants`.`category_id` AS `category_id`, `view_product_variants`.`category_name` AS `category_name`, `view_product_variants`.`product_variant_id` AS `product_variant_id`, `view_product_variants`.`product_variant_name` AS `product_variant_name`, `view_product_variants`.`product_variant_price` AS `product_variant_price`, `view_product_variants`.`product_variant_available` AS `product_variant_available`, `view_product_variants`.`product_variant_is_bestseller` AS `product_variant_is_bestseller`, `view_product_variants`.`discount_amount` AS `discount_amount`, `view_product_variants`.`discount_description` AS `discount_description` FROM (`carts` left join `view_product_variants` on(`carts`.`product_variant_id` = `view_product_variants`.`product_variant_id`)) ORDER BY `carts`.`cart_added_date` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `view_cate_admin`
--
DROP TABLE IF EXISTS `view_cate_admin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cate_admin`  AS SELECT `categories`.`category_id` AS `category_id`, `categories`.`category_name` AS `category_name`, `categories`.`category_img` AS `category_img`, `categories`.`categorry_type` AS `categorry_type`, `categories`.`category_added_date` AS `category_added_date`, `categories`.`category_is_display` AS `category_is_display`, coalesce(`product_counts`.`product_count`,0) AS `product_count`, coalesce(sum(`order_details`.`order_detail_price_after`),0) AS `revenue` FROM ((`categories` left join (select `products`.`category_id` AS `category_id`,count(0) AS `product_count` from `products` group by `products`.`category_id`) `product_counts` on(`categories`.`category_id` = `product_counts`.`category_id`)) left join `order_details` on(`order_details`.`product_variant_id` in (select `view_products_resume`.`product_variant_id` from (`view_products_resume` join `orders`) where `view_products_resume`.`category_id` = `categories`.`category_id` and `orders`.`order_id` = `order_details`.`order_id` and `orders`.`order_is_paid` = 1 and `orders`.`order_status` = 'Hoàn thành'))) GROUP BY `categories`.`category_id`, `categories`.`category_name` ;

-- --------------------------------------------------------

--
-- Structure for view `view_count_cart`
--
DROP TABLE IF EXISTS `view_count_cart`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_count_cart`  AS SELECT `customers`.`customer_id` AS `customer_id`, `users`.`user_id` AS `user_id`, count(`carts`.`product_variant_id`) AS `count_cart` FROM ((`users` left join `customers` on(`users`.`user_id` = `customers`.`customer_id`)) left join `carts` on(`carts`.`customer_id` = `customers`.`customer_id`)) GROUP BY `customers`.`customer_id` ;

-- --------------------------------------------------------

--
-- Structure for view `view_dashboard`
--
DROP TABLE IF EXISTS `view_dashboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_dashboard`  AS SELECT `dashboard_customer`.`customer_count` AS `customer_count`, sum(`dashboard_order`.`quantity_sold`) AS `quantity_sold`, sum(`dashboard_order`.`revenue`) AS `revenue` FROM ((select count(0) AS `customer_count` from `customers`) `dashboard_customer` join (select count(0) AS `quantity_sold`,sum(`orders`.`order_total_after`) AS `revenue` from `orders` where `orders`.`order_is_paid` = 1 and `orders`.`order_status` = 'Hoàn thành' group by `orders`.`order_id`) `dashboard_order`) ;

-- --------------------------------------------------------

--
-- Structure for view `view_discounts`
--
DROP TABLE IF EXISTS `view_discounts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_discounts`  AS SELECT `discounts`.`discount_id` AS `discount_id`, `discounts`.`discount_name` AS `discount_name`, `discounts`.`discount_description` AS `discount_description`, `discounts`.`discount_start_date` AS `discount_start_date`, `discounts`.`discount_end_date` AS `discount_end_date`, `discounts`.`discount_amount` AS `discount_amount`, `discounts`.`discount_is_display` AS `discount_is_display`, `discounts`.`discount_img` AS `discount_img` FROM `discounts` WHERE cast(`discounts`.`discount_end_date` as date) > current_timestamp() AND cast(`discounts`.`discount_start_date` as date) < current_timestamp() AND `discounts`.`discount_is_display` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `view_getchart_revenue`
--
DROP TABLE IF EXISTS `view_getchart_revenue`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_getchart_revenue`  AS SELECT `success`.`year` AS `year`, `success`.`month` AS `month`, `success`.`order_success` AS `order_success`, `success`.`revenue` AS `revenue`, `cancel`.`order_cancel` AS `order_cancel` FROM ((select year(`orders`.`order_date`) AS `year`,month(`orders`.`order_date`) AS `month`,count(`orders`.`order_id`) AS `order_success`,sum(`orders`.`order_total_after`) AS `revenue` from `orders` where `orders`.`order_is_paid` = 1 group by year(`orders`.`order_date`),month(`orders`.`order_date`)) `success` left join (select year(`orders`.`order_date`) AS `year`,month(`orders`.`order_date`) AS `month`,count(`orders`.`order_id`) AS `order_cancel` from `orders` where `orders`.`order_status` = 'Đã hủy' group by year(`orders`.`order_date`),month(`orders`.`order_date`)) `cancel` on(`cancel`.`year` = `success`.`year` and `cancel`.`month` = `success`.`month`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_getchart_top5_product`
--
DROP TABLE IF EXISTS `view_getchart_top5_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_getchart_top5_product`  AS SELECT `order_details`.`product_variant_id` AS `product_variant_id`, sum(`order_details`.`order_detail_quantity`) AS `quantity_sold`, sum(`order_details`.`order_detail_price_after` * `order_details`.`order_detail_quantity`) AS `revenue` FROM (`orders` left join `order_details` on(`order_details`.`order_id` = `orders`.`order_id`)) WHERE `orders`.`order_status` = 'Hoàn thành' GROUP BY `order_details`.`product_variant_id` ;

-- --------------------------------------------------------

--
-- Structure for view `view_notifications`
--
DROP TABLE IF EXISTS `view_notifications`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_notifications`  AS SELECT `notifications`.`notification_id` AS `notification_id`, `notifications`.`notification_type_id` AS `notification_type_id`, `notifications`.`notification_title` AS `notification_title`, `notifications`.`notification_subtitle` AS `notification_subtitle`, `notifications`.`notification_content` AS `notification_content`, `notifications`.`notification_date` AS `notification_date`, `notifications`.`notification_is_display` AS `notification_is_display`, `user_notification`.`user_id` AS `user_id`, `user_notification`.`user_notification_is_read` AS `user_notification_is_read` FROM (`notifications` left join `user_notification` on(`notifications`.`notification_id` = `user_notification`.`notification_id`)) WHERE `notifications`.`notification_is_display` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `view_order`
--
DROP TABLE IF EXISTS `view_order`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_order`  AS SELECT `orders`.`order_id` AS `order_id`, `orders`.`customer_id` AS `customer_id`, `orders`.`staff_id` AS `staff_id`, `orders`.`order_name` AS `order_name`, `orders`.`order_phone` AS `order_phone`, `orders`.`order_date` AS `order_date`, `orders`.`order_delivery_date` AS `order_delivery_date`, `orders`.`order_delivery_address` AS `order_delivery_address`, `orders`.`order_note` AS `order_note`, `orders`.`order_total_before` AS `order_total_before`, `orders`.`order_total_after` AS `order_total_after`, `orders`.`paying_method_id` AS `paying_method_id`, `orders`.`order_paying_date` AS `order_paying_date`, `orders`.`order_is_paid` AS `order_is_paid`, `orders`.`order_status` AS `order_status`, `paying_methods`.`paying_method_name` AS `paying_method_name` FROM (`orders` left join `paying_methods` on(`orders`.`paying_method_id` = `paying_methods`.`paying_method_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_orders`
--
DROP TABLE IF EXISTS `view_orders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_orders`  AS SELECT `orders`.`order_id` AS `order_id`, `orders`.`customer_id` AS `customer_id`, `orders`.`staff_id` AS `staff_id`, `orders`.`order_name` AS `order_name`, `orders`.`order_phone` AS `order_phone`, `orders`.`order_date` AS `order_date`, `orders`.`order_delivery_date` AS `order_delivery_date`, `orders`.`order_delivery_address` AS `order_delivery_address`, `orders`.`order_note` AS `order_note`, `orders`.`order_total_before` AS `order_total_before`, `orders`.`order_total_after` AS `order_total_after`, `orders`.`paying_method_id` AS `paying_method_id`, `orders`.`order_paying_date` AS `order_paying_date`, `orders`.`order_is_paid` AS `order_is_paid`, `orders`.`order_status` AS `order_status`, `paying_methods`.`paying_method_name` AS `paying_method_name` FROM (`orders` left join `paying_methods` on(`orders`.`paying_method_id` = `paying_methods`.`paying_method_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_order_detail`
--
DROP TABLE IF EXISTS `view_order_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_order_detail`  AS SELECT `order_details`.`order_id` AS `order_id`, `order_details`.`product_variant_id` AS `product_variant_id`, `order_details`.`order_detail_quantity` AS `order_detail_quantity`, `order_details`.`order_detail_price_before` AS `order_detail_price_before`, `order_details`.`order_detail_price_after` AS `order_detail_price_after`, `view_product_variants`.`product_id` AS `product_id`, `view_product_variants`.`product_name` AS `product_name`, `view_product_variants`.`product_avt_img` AS `product_avt_img`, `view_product_variants`.`product_variant_name` AS `product_variant_name` FROM (`order_details` left join `view_product_variants` on(`order_details`.`product_variant_id` = `view_product_variants`.`product_variant_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_products_admin`
--
DROP TABLE IF EXISTS `view_products_admin`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_products_admin`  AS SELECT `view_product_variants`.`product_id` AS `product_id`, `view_product_variants`.`product_name` AS `product_name`, `view_product_variants`.`product_avt_img` AS `product_avt_img`, `view_product_variants`.`product_rate` AS `product_rate`, `view_product_variants`.`product_view_count` AS `product_view_count`, `view_product_variants`.`product_period` AS `product_period`, `view_product_variants`.`category_id` AS `category_id`, `view_product_variants`.`category_name` AS `category_name`, `view_product_variants`.`product_variant_id` AS `product_variant_id`, `view_product_variants`.`product_variant_name` AS `product_variant_name`, `view_product_variants`.`product_variant_price` AS `product_variant_price`, `view_product_variants`.`product_variant_available` AS `product_variant_available`, `view_product_variants`.`product_variant_is_bestseller` AS `product_variant_is_bestseller`, `view_product_variants`.`discount_amount` AS `discount_amount`, `view_product_variants`.`discount_description` AS `discount_description`, count(`view_product_variants`.`product_variant_id`) AS `product_count`, sum(`r`.`quantity_sold`) AS `quantity_sold`, sum(`r`.`revenue`) AS `revenue` FROM (`view_product_variants` left join (select `order_details`.`product_variant_id` AS `product_variant_id`,count(`order_details`.`product_variant_id`) AS `quantity_sold`,sum(`order_details`.`order_detail_price_after`) AS `revenue` from (`orders` left join `order_details` on(`orders`.`order_id` = `order_details`.`order_id`)) where `orders`.`order_is_paid` <> 0 and `orders`.`order_status` = 'Hoàn thành' group by `order_details`.`product_variant_id`) `r` on(`view_product_variants`.`product_variant_id` = `r`.`product_variant_id`)) GROUP BY `view_product_variants`.`product_id` ORDER BY sum(`r`.`revenue`) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `view_products_info`
--
DROP TABLE IF EXISTS `view_products_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_products_info`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`category_id` AS `category_id`, `products`.`product_name` AS `product_name`, `products`.`supplier_id` AS `supplier_id`, `products`.`product_avt_img` AS `product_avt_img`, `products`.`product_rate` AS `product_rate`, `products`.`product_description` AS `product_description`, `products`.`product_period` AS `product_period`, `products`.`product_view_count` AS `product_view_count`, `products`.`product_is_display` AS `product_is_display`, `product_variants`.`product_variant_id` AS `product_variant_id`, `product_variants`.`discount_id` AS `discount_id`, `product_variants`.`product_variant_name` AS `product_variant_name`, `product_variants`.`product_variant_price` AS `product_variant_price`, `product_variants`.`product_variant_available` AS `product_variant_available` FROM (`products` join `product_variants`) WHERE `products`.`product_id` = `product_variants`.`product_id` AND `product_variants`.`product_variant_is_stock` = 1 AND `product_variants`.`product_variant_is_display` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `view_products_resume`
--
DROP TABLE IF EXISTS `view_products_resume`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_products_resume`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`product_name` AS `product_name`, `products`.`product_avt_img` AS `product_avt_img`, `products`.`product_rate` AS `product_rate`, `products`.`product_view_count` AS `product_view_count`, `categories`.`category_id` AS `category_id`, `categories`.`category_name` AS `category_name`, `a`.`product_variant_id` AS `product_variant_id`, `c`.`product_variant_is_bestseller` AS `product_variant_is_bestseller`, `a`.`min_price` AS `product_variant_price`, `b`.`max_date` AS `product_lastdate_added`, `view_discounts`.`discount_amount` AS `discount_amount`, `view_discounts`.`discount_description` AS `discount_description` FROM (((select `product_variants`.`product_id` AS `product_id`,max(`product_variants`.`product_variant_added_date`) AS `max_date` from `product_variants` group by `product_variants`.`product_id`) `b` left join (((`products` left join (select `product_variants`.`product_id` AS `product_id`,`product_variants`.`discount_id` AS `discount_id`,`product_variants`.`product_variant_id` AS `product_variant_id`,min(`product_variants`.`product_variant_price`) AS `min_price` from `product_variants` group by `product_variants`.`product_id`) `a` on(`products`.`product_id` = `a`.`product_id`)) left join `view_discounts` on(`a`.`discount_id` = `view_discounts`.`discount_id`)) left join `categories` on(`categories`.`category_id` = `products`.`category_id`)) on(`products`.`product_id` = `b`.`product_id`)) left join (select `product_variants`.`product_id` AS `product_id`,`product_variants`.`product_variant_is_bestseller` AS `product_variant_is_bestseller` from `product_variants` where `product_variants`.`product_variant_is_bestseller` = 1 group by `product_variants`.`product_id`) `c` on(`products`.`product_id` = `c`.`product_id`)) WHERE `products`.`product_is_display` = 1 GROUP BY `products`.`product_id` ;

-- --------------------------------------------------------

--
-- Structure for view `view_product_feedbacks`
--
DROP TABLE IF EXISTS `view_product_feedbacks`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product_feedbacks`  AS SELECT `product_variants`.`product_variant_name` AS `product_variant_name`, `product_variants`.`product_id` AS `product_id`, `feedbacks`.`feedback_id` AS `feedback_id`, `feedbacks`.`product_variant_id` AS `product_variant_id`, `feedbacks`.`customer_id` AS `customer_id`, `feedbacks`.`order_id` AS `order_id`, `feedbacks`.`feedback_date` AS `feedback_date`, `feedbacks`.`feedback_rate` AS `feedback_rate`, `feedbacks`.`feedback_content` AS `feedback_content`, `feedbacks`.`feedback_is_display` AS `feedback_is_display`, `feedback_imgs`.`feedback_img_id` AS `feedback_img_id`, `feedback_imgs`.`feedback_img_name` AS `feedback_img_name`, `view_user`.`user_name` AS `user_name`, `view_user`.`user_avt_img` AS `user_avt_img` FROM (((`product_variants` left join `feedbacks` on(`product_variants`.`product_variant_id` = `feedbacks`.`product_variant_id`)) left join `feedback_imgs` on(`feedbacks`.`feedback_id` = `feedback_imgs`.`feedback_id`)) left join `view_user` on(`view_user`.`customer_id` = `feedbacks`.`customer_id`)) WHERE `feedbacks`.`feedback_is_display` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `view_product_variants`
--
DROP TABLE IF EXISTS `view_product_variants`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product_variants`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`product_name` AS `product_name`, `products`.`product_avt_img` AS `product_avt_img`, `products`.`product_rate` AS `product_rate`, `products`.`product_view_count` AS `product_view_count`, `products`.`product_period` AS `product_period`, `categories`.`category_id` AS `category_id`, `categories`.`category_name` AS `category_name`, `product_variants`.`product_variant_id` AS `product_variant_id`, `product_variants`.`product_variant_name` AS `product_variant_name`, `product_variants`.`product_variant_price` AS `product_variant_price`, `product_variants`.`product_variant_available` AS `product_variant_available`, `product_variants`.`product_variant_is_bestseller` AS `product_variant_is_bestseller`, `view_discounts`.`discount_amount` AS `discount_amount`, `view_discounts`.`discount_description` AS `discount_description` FROM (((`products` left join `product_variants` on(`products`.`product_id` = `product_variants`.`product_id`)) left join `view_discounts` on(`product_variants`.`discount_id` = `view_discounts`.`discount_id`)) left join `categories` on(`categories`.`category_id` = `products`.`category_id`)) WHERE `categories`.`category_id` = `products`.`category_id` AND `products`.`product_is_display` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `view_product_variant_detail`
--
DROP TABLE IF EXISTS `view_product_variant_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_product_variant_detail`  AS SELECT `product_variants`.`product_variant_id` AS `product_variant_id`, `product_variants`.`product_id` AS `product_id`, `product_variants`.`discount_id` AS `discount_id`, `product_variants`.`product_variant_name` AS `product_variant_name`, `product_variants`.`product_variant_price` AS `product_variant_price`, `product_variants`.`product_variant_available` AS `product_variant_available`, `product_variants`.`product_variant_is_stock` AS `product_variant_is_stock`, `product_variants`.`product_variant_is_bestseller` AS `product_variant_is_bestseller`, `product_variants`.`product_variant_added_date` AS `product_variant_added_date`, `product_variants`.`product_variant_is_display` AS `product_variant_is_display`, `view_discounts`.`discount_name` AS `discount_name`, `view_discounts`.`discount_description` AS `discount_description`, `view_discounts`.`discount_start_date` AS `discount_start_date`, `view_discounts`.`discount_end_date` AS `discount_end_date`, `view_discounts`.`discount_amount` AS `discount_amount` FROM (`product_variants` left join `view_discounts` on(`product_variants`.`discount_id` = `view_discounts`.`discount_id`)) WHERE `product_variants`.`product_variant_is_display` = 1 ;

-- --------------------------------------------------------

--
-- Structure for view `view_user`
--
DROP TABLE IF EXISTS `view_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_user`  AS SELECT `users`.`user_id` AS `user_id`, `users`.`user_login_name` AS `user_login_name`, `users`.`user_password` AS `user_password`, `users`.`user_name` AS `user_name`, `users`.`user_avt_img` AS `user_avt_img`, date_format(`users`.`user_birth`,'%d/%m/%Y') AS `user_birth`, `users`.`user_sex` AS `user_sex`, `users`.`user_email` AS `user_email`, `users`.`user_phone` AS `user_phone`, `users`.`user_address` AS `user_address`, `users`.`user_register_date` AS `user_register_date`, `users`.`user_active` AS `user_active`, `customers`.`customer_id` AS `customer_id`, `staffs`.`staff_id` AS `staff_id`, `staffs`.`staff_role` AS `staff_role`, `staffs`.`staff_description` AS `staff_description` FROM ((`users` left join `customers` on(`users`.`user_id` = `customers`.`user_id`)) left join `staffs` on(`users`.`user_id` = `staffs`.`user_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `admin_login_name` (`admin_login_name`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`customer_id`,`product_variant_id`),
  ADD KEY `fk_carts_product_variants` (`product_variant_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `fk_customers_users` (`user_id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`discount_id`);

--
-- Indexes for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `fk_order_id` (`order_id`),
  ADD KEY `fk_customer_id` (`customer_id`),
  ADD KEY `fk_product_variant_id` (`product_variant_id`);

--
-- Indexes for table `feedback_imgs`
--
ALTER TABLE `feedback_imgs`
  ADD PRIMARY KEY (`feedback_img_id`),
  ADD KEY `fk_feedback_id` (`feedback_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `fk_notifications_notification_types` (`notification_type_id`);

--
-- Indexes for table `notification_types`
--
ALTER TABLE `notification_types`
  ADD PRIMARY KEY (`notification_type_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_customers` (`customer_id`),
  ADD KEY `fk_orders_staffs` (`staff_id`),
  ADD KEY `fk_paying_method_id` (`paying_method_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_id`,`product_variant_id`),
  ADD KEY `fk_order_details_product_variants` (`product_variant_id`);

--
-- Indexes for table `paying_methods`
--
ALTER TABLE `paying_methods`
  ADD PRIMARY KEY (`paying_method_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_products_categories` (`category_id`),
  ADD KEY `fk_products_suppliers` (`supplier_id`);

--
-- Indexes for table `product_details`
--
ALTER TABLE `product_details`
  ADD PRIMARY KEY (`product_detail_id`,`product_id`),
  ADD KEY `fk_product_details_products` (`product_id`);

--
-- Indexes for table `product_imgs`
--
ALTER TABLE `product_imgs`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `fk_product_id` (`product_id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`product_variant_id`,`product_id`) USING BTREE,
  ADD KEY `fk_product_variants_products` (`product_id`),
  ADD KEY `fk_products_variants_discounts` (`discount_id`);

--
-- Indexes for table `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `fk_staffs_users` (`user_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_notification`
--
ALTER TABLE `user_notification`
  ADD PRIMARY KEY (`user_id`,`notification_id`),
  ADD KEY `fk_user_notification_notifications` (`notification_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `discount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=761;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `notification_types`
--
ALTER TABLE `notification_types`
  MODIFY `notification_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `paying_methods`
--
ALTER TABLE `paying_methods`
  MODIFY `paying_method_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `product_details`
--
ALTER TABLE `product_details`
  MODIFY `product_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=581;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `product_variant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `fk_carts_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_carts_product_variants` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`product_variant_id`);

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `fk_customers_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_product_variant_id` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`product_variant_id`);

--
-- Constraints for table `feedback_imgs`
--
ALTER TABLE `feedback_imgs`
  ADD CONSTRAINT `fk_feedback_id` FOREIGN KEY (`feedback_id`) REFERENCES `feedbacks` (`feedback_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_notification_types` FOREIGN KEY (`notification_type_id`) REFERENCES `notification_types` (`notification_type_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_orders_staffs` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`staff_id`),
  ADD CONSTRAINT `fk_paying_method_id` FOREIGN KEY (`paying_method_id`) REFERENCES `paying_methods` (`paying_method_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_order_details_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_order_details_product_variants` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`product_variant_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  ADD CONSTRAINT `fk_products_suppliers` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

--
-- Constraints for table `product_details`
--
ALTER TABLE `product_details`
  ADD CONSTRAINT `fk_product_details_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `product_imgs`
--
ALTER TABLE `product_imgs`
  ADD CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `fk_product_variants_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `fk_products_variants_discounts` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`discount_id`);

--
-- Constraints for table `staffs`
--
ALTER TABLE `staffs`
  ADD CONSTRAINT `fk_staffs_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `user_notification`
--
ALTER TABLE `user_notification`
  ADD CONSTRAINT `fk_user_notification_notifications` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`notification_id`),
  ADD CONSTRAINT `fk_user_notification_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

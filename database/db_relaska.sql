-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Jul 2026 pada 02.05
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_relaska`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `builds`
--

CREATE TABLE `builds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(100) NOT NULL DEFAULT 'Rakitan User',
  `category` varchar(50) DEFAULT NULL,
  `total_price` decimal(15,2) DEFAULT NULL,
  `status` enum('draft','waiting_approval','paid','rejected') NOT NULL DEFAULT 'draft',
  `type` enum('build','order') NOT NULL DEFAULT 'build',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `builds`
--

INSERT INTO `builds` (`id`, `user_id`, `name`, `category`, `total_price`, `status`, `type`, `created_at`, `updated_at`) VALUES
(12, 14, 'Asus ROG Strix B650-A', NULL, 4237000.00, 'draft', 'order', '2026-06-30 03:28:13', '2026-06-30 03:28:13'),
(13, 14, 'G.Skill Ripjaws V 32GB (2x16)', NULL, 1637000.00, 'waiting_approval', 'order', '2026-06-30 03:31:51', '2026-06-30 03:31:51'),
(14, 14, 'MSI A520M-A PRO', NULL, 987000.00, 'waiting_approval', 'order', '2026-06-30 05:54:04', '2026-06-30 05:54:04'),
(15, 14, 'Intel Core i9-13900K', NULL, 9237000.00, 'waiting_approval', 'order', '2026-07-01 08:10:46', '2026-07-01 08:10:46'),
(16, 14, 'AMD Ryzen 7 5800X3D', NULL, 5237000.00, 'waiting_approval', 'order', '2026-07-05 08:40:00', '2026-07-05 08:40:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `build_items`
--

CREATE TABLE `build_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `build_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price_at_purchase` int(11) DEFAULT NULL,
  `is_recommended` tinyint(1) NOT NULL DEFAULT 0,
  `is_initial` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `build_items`
--

INSERT INTO `build_items` (`id`, `build_id`, `product_id`, `quantity`, `price_at_purchase`, `is_recommended`, `is_initial`) VALUES
(12, 12, 28, 1, 4200000, 0, 0),
(13, 13, 44, 1, 1600000, 0, 0),
(14, 14, 21, 1, 950000, 0, 0),
(15, 15, 10, 1, 9200000, 0, 0),
(16, 16, 3, 1, 5200000, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`) VALUES
(1, 'Processor', 'processor'),
(2, 'Motherboard', 'motherboard'),
(3, 'RAM', 'ram'),
(4, 'VGA', 'vga'),
(5, 'Storage', 'storage'),
(6, 'Power Supply', 'psu'),
(7, 'Casing', 'case'),
(8, 'CPU Cooler', 'cooler');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_05_28_072201_create_categories_table', 1),
(5, '2026_05_28_072207_create_products_table', 1),
(6, '2026_05_28_072215_create_builds_table', 1),
(7, '2026_05_28_072222_create_build_items_table', 1),
(8, '2026_07_01_144708_create_product_price_histories_table', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `price` decimal(15,2) NOT NULL,
  `tier` int(11) NOT NULL DEFAULT 1,
  `capacity` int(11) NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `socket_type` varchar(50) DEFAULT NULL,
  `memory_type` varchar(20) DEFAULT NULL,
  `wattage` int(11) DEFAULT NULL,
  `form_factor` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `stock`, `price`, `tier`, `capacity`, `image`, `description`, `brand`, `socket_type`, `memory_type`, `wattage`, `form_factor`, `created_at`, `updated_at`) VALUES
(1, 1, 'AMD Ryzen 5 5500', 10, 1400000.00, 1, 0, NULL, 'Budget King AM4', NULL, 'AM4', '', 65, '', '2025-12-21 12:06:00', '2026-01-11 13:08:31'),
(2, 1, 'AMD Ryzen 5 5600X', 10, 2300000.00, 2, 0, NULL, 'Mid-range Gaming AM4', 'AMD', 'AM4', NULL, 65, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(3, 1, 'AMD Ryzen 7 5800X3D', 10, 5200000.00, 3, 0, NULL, 'Best Gaming AM4', 'AMD', 'AM4', NULL, 105, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(4, 1, 'AMD Ryzen 5 7600X', 10, 3800000.00, 2, 0, NULL, 'Next Gen Mid-range', 'AMD', 'AM5', NULL, 105, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(5, 1, 'AMD Ryzen 9 7900X', 10, 7200000.00, 3, 0, NULL, 'High-end Workstation', 'AMD', 'AM5', NULL, 170, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(6, 1, 'Intel Core i3-13100F', 10, 1750000.00, 1, 0, NULL, 'Entry Level Gen 13', 'Intel', 'LGA1700', NULL, 60, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(7, 1, 'Intel Core i5-13400F', 10, 3200000.00, 2, 0, NULL, 'Mid-range Hybrid Gen 13', 'Intel', 'LGA1700', NULL, 65, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(8, 1, 'Intel Core i5-13600KF', 10, 4500000.00, 3, 0, NULL, 'Performance Gen 13', 'Intel', 'LGA1700', NULL, 125, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(9, 1, 'Intel Core i7-13700K', 10, 6500000.00, 3, 0, NULL, 'High-end Gen 13', 'Intel', 'LGA1700', NULL, 125, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(10, 1, 'Intel Core i9-13900K', 10, 9200000.00, 3, 0, NULL, 'Extreme Gen 13', 'Intel', 'LGA1700', NULL, 150, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(11, 1, 'AMD Ryzen 3 4100', 10, 1100000.00, 1, 0, NULL, 'Basic AM4', 'AMD', 'AM4', NULL, 65, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(12, 1, 'AMD Ryzen 5 4500', 10, 1250000.00, 1, 0, NULL, 'Entry AM4 6-core', 'AMD', 'AM4', NULL, 65, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(13, 1, 'Intel Core i3-14100', 10, 2100000.00, 1, 0, NULL, 'Latest Entry Gen 14', 'Intel', 'LGA1700', NULL, 60, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(14, 1, 'Intel Core i5-14400F', 10, 3500000.00, 2, 0, NULL, 'Latest Mid Gen 14', 'Intel', 'LGA1700', NULL, 65, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(15, 1, 'Intel Core i7-14700K', 10, 7200000.00, 3, 0, NULL, 'High-end Gen 14', 'Intel', 'LGA1700', NULL, 125, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(16, 1, 'Intel Core i9-14900KS', 10, 11500000.00, 3, 0, NULL, 'Limited Edition Gen 14', 'Intel', 'LGA1700', NULL, 150, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(17, 1, 'AMD Ryzen 5 7500F', 10, 2600000.00, 2, 0, NULL, 'Value AM5 DDR5', 'AMD', 'AM5', NULL, 65, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(18, 1, 'AMD Ryzen 7 7700X', 10, 4800000.00, 3, 0, NULL, 'Performance AM5', 'AMD', 'AM5', NULL, 105, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(19, 1, 'AMD Ryzen 9 7950X', 10, 8500000.00, 3, 0, NULL, 'Extreme AM5', 'AMD', 'AM5', NULL, 170, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(20, 1, 'Intel Core i5-12600K', 10, 3800000.00, 2, 0, NULL, 'Unlocked Gen 12', 'Intel', 'LGA1700', NULL, 125, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(21, 2, 'MSI A520M-A PRO', 10, 950000.00, 1, 0, NULL, 'Entry AM4', 'MSI', 'AM4', 'DDR4', NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(22, 2, 'Gigabyte B450M DS3H', 10, 1100000.00, 1, 0, NULL, 'Classic AM4', 'Gigabyte', 'AM4', 'DDR4', NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(23, 2, 'Asus Prime B550M-K', 10, 1650000.00, 1, 0, NULL, 'Solid AM4', 'Asus', 'AM4', 'DDR4', NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(24, 2, 'MSI MPG B550 Gaming Plus', 10, 2500000.00, 2, 0, NULL, 'Gaming AM4', 'MSI', 'AM4', 'DDR4', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(25, 2, 'ASRock X570 Steel Legend', 10, 3200000.00, 2, 0, NULL, 'Premium AM4', 'ASRock', 'AM4', 'DDR4', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(26, 2, 'Gigabyte A620M Gaming X', 10, 1800000.00, 1, 0, NULL, 'Entry AM5', 'Gigabyte', 'AM5', 'DDR5', NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(27, 2, 'MSI PRO B650-P WiFi', 10, 2900000.00, 2, 0, NULL, 'Mid AM5 WiFi', 'MSI', 'AM5', 'DDR5', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(28, 2, 'Asus ROG Strix B650-A', 10, 4200000.00, 3, 0, NULL, 'White Theme AM5', 'Asus', 'AM5', 'DDR5', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(29, 2, 'MSI MEG X670E Godlike', 10, 15000000.00, 3, 0, NULL, 'God Tier AM5', 'MSI', 'AM5', 'DDR5', NULL, 'E-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(30, 2, 'Asrock H610M-HVS', 10, 1050000.00, 1, 0, NULL, 'Budget LGA1700', 'Asrock', 'LGA1700', 'DDR4', NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(31, 2, 'Gigabyte B760M DS3H WiFi', 10, 2100000.00, 2, 0, NULL, 'LGA1700 WiFi DDR4', 'Gigabyte', 'LGA1700', 'DDR4', NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(32, 2, 'MSI MAG B760 Tomahawk', 10, 3500000.00, 2, 0, NULL, 'LGA1700 DDR5 ATX', 'MSI', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(33, 2, 'Asus Prime Z790-P', 10, 4200000.00, 3, 0, NULL, 'Entry Z790', 'Asus', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(34, 2, 'MSI MPG Z790 Carbon WiFi', 10, 7500000.00, 3, 0, NULL, 'Premium Z790', 'MSI', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(35, 2, 'Asrock Z790 Taichi', 10, 9200000.00, 3, 0, NULL, 'Top Tier Z790', 'Asrock', 'LGA1700', 'DDR5', NULL, 'E-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(36, 2, 'Asus ROG Maximus Z790 Apex', 10, 12500000.00, 3, 0, NULL, 'OC Beast LGA1700', 'Asus', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(37, 2, 'Gigabyte Z690 Gaming X', 10, 3600000.00, 2, 0, NULL, 'Z690 DDR4', 'Gigabyte', 'LGA1700', 'DDR4', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(38, 2, 'MSI PRO Z790-A WiFi', 10, 4800000.00, 3, 0, NULL, 'Professional Z790', 'MSI', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(39, 2, 'Asrock B760 Pro RS', 10, 2600000.00, 2, 0, NULL, 'Silver Theme LGA1700', 'Asrock', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(40, 2, 'Biostar H610MH', 10, 980000.00, 1, 0, NULL, 'Cheapest LGA1700', 'Biostar', 'LGA1700', 'DDR4', NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(41, 3, 'Team Elite Plus 8GB 3200', 10, 320000.00, 1, 8, NULL, 'Standard DDR4', 'TeamGroup', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(42, 3, 'Kingston Fury Beast 16GB (2x8)', 10, 850000.00, 1, 16, NULL, 'Reliable DDR4', 'Kingston', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(43, 3, 'Corsair Vengeance RGB Pro 16GB', 10, 1100000.00, 2, 16, NULL, 'RGB DDR4', 'Corsair', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(44, 3, 'G.Skill Ripjaws V 32GB (2x16)', 10, 1600000.00, 2, 32, NULL, 'Performance DDR4', 'G.Skill', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(45, 3, 'Crucial Pro 16GB 5600', 10, 1150000.00, 1, 16, NULL, 'Entry DDR5', 'Crucial', NULL, 'DDR5', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(46, 3, 'Adata XPG Lancer RGB 32GB', 10, 2400000.00, 2, 32, NULL, 'Fast DDR5', 'Adata', NULL, 'DDR5', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(47, 3, 'G.Skill Trident Z5 RGB 32GB 6000', 10, 2800000.00, 3, 32, NULL, 'Top Speed DDR5', 'G.Skill', NULL, 'DDR5', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(48, 3, 'Team T-Force Delta 32GB 6400', 10, 2650000.00, 3, 32, NULL, 'High Frequency DDR5', 'TeamGroup', NULL, 'DDR5', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(49, 3, 'Corsair Dominator Titanium 64GB', 10, 6200000.00, 3, 64, NULL, 'Luxury DDR5', 'Corsair', NULL, 'DDR5', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(50, 3, 'Lexar Thor 16GB (2x8)', 10, 720000.00, 1, 16, NULL, 'Low Profile DDR4', 'Lexar', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(51, 3, 'PNY XLR8 Gaming 16GB', 10, 880000.00, 1, 16, NULL, 'Gamer DDR4', 'PNY', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(52, 3, 'Patriot Viper Steel 32GB', 10, 1500000.00, 2, 32, NULL, 'Stability DDR4', 'Patriot', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(53, 3, 'Klevv Cras X RGB 16GB', 10, 920000.00, 1, 16, NULL, 'Aura Sync DDR4', 'Klevv', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(54, 3, 'Geil Orion 16GB', 10, 780000.00, 1, 16, NULL, 'Red Theme DDR4', 'Geil', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(55, 3, 'Galax HOF OC Lab 16GB', 10, 1950000.00, 3, 16, NULL, 'OC Record DDR4', 'Galax', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(56, 3, 'Netac Shadow II 32GB 6000', 10, 1850000.00, 2, 32, NULL, 'Value DDR5', 'Netac', NULL, 'DDR5', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(57, 3, 'V-Color Prism Pro 32GB', 10, 1550000.00, 2, 32, NULL, 'Jewel Design DDR4', 'V-Color', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(58, 3, 'OLOy Blade RGB 32GB', 10, 2100000.00, 2, 32, NULL, 'Sleek DDR5', 'OLOy', NULL, 'DDR5', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(59, 3, 'Silicon Power Xpower 16GB', 10, 820000.00, 1, 16, NULL, 'Budget Performance', 'Silicon Power', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(60, 3, 'Crucial Ballistix 16GB 3600', 10, 1250000.00, 2, 16, NULL, 'Legendary OC DDR4', 'Crucial', NULL, 'DDR4', NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(61, 4, 'Nvidia GTX 1650 4GB', 10, 2100000.00, 1, 0, NULL, 'Entry 1080p', 'Nvidia', NULL, NULL, 75, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(62, 4, 'AMD RX 6500 XT', 10, 2450000.00, 1, 0, NULL, 'Entry Radeon', 'AMD', NULL, NULL, 107, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(63, 4, 'Nvidia RTX 3050 8GB', 10, 3600000.00, 1, 0, NULL, 'RTX Starter', 'Nvidia', NULL, NULL, 130, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(64, 4, 'AMD RX 6600 8GB', 10, 3150000.00, 2, 0, NULL, 'Radeon 1080p King', 'AMD', NULL, NULL, 132, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(65, 4, 'Nvidia RTX 3060 12GB', 10, 4500000.00, 2, 0, NULL, 'VRAM King Mid', 'Nvidia', NULL, NULL, 170, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(66, 4, 'AMD RX 6700 XT 12GB', 10, 5800000.00, 2, 0, NULL, '1440p Radeon', 'AMD', NULL, NULL, 230, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(67, 4, 'Nvidia RTX 4060 8GB', 10, 4850000.00, 2, 0, NULL, 'Power Efficient Mid', 'Nvidia', NULL, NULL, 115, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(68, 4, 'Nvidia RTX 4060 Ti 8GB', 10, 6500000.00, 2, 0, NULL, 'High FPS 1080p', 'Nvidia', NULL, NULL, 160, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(69, 4, 'AMD RX 7600 8GB', 10, 4400000.00, 2, 0, NULL, 'Modern 1080p Radeon', 'AMD', NULL, NULL, 165, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(70, 4, 'Nvidia RTX 4070 12GB', 10, 9600000.00, 3, 0, NULL, '1440p King', 'Nvidia', NULL, NULL, 200, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(71, 4, 'AMD RX 7800 XT 16GB', 10, 9200000.00, 3, 0, NULL, 'High VRAM Radeon', 'AMD', NULL, NULL, 263, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(72, 4, 'Nvidia RTX 4070 Ti Super', 10, 14500000.00, 3, 0, NULL, '4K Starter', 'Nvidia', NULL, NULL, 285, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(73, 4, 'AMD RX 7900 XT 20GB', 10, 13800000.00, 3, 0, NULL, 'Premium Radeon', 'AMD', NULL, NULL, 315, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(74, 4, 'Nvidia RTX 4080 Super', 10, 18500000.00, 3, 0, NULL, 'Extreme 4K', 'Nvidia', NULL, NULL, 320, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(75, 4, 'Nvidia RTX 4090 24GB', 10, 32000000.00, 3, 0, NULL, 'Absolute Beast', 'Nvidia', NULL, NULL, 450, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(76, 4, 'Intel Arc A750', 10, 3600000.00, 2, 0, NULL, 'Intel GPU Challenger', 'Intel', NULL, NULL, 225, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(77, 4, 'Intel Arc A770 16GB', 10, 5200000.00, 2, 0, NULL, 'Top Intel Arc', 'Intel', NULL, NULL, 225, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(78, 4, 'AMD RX 7900 XTX 24GB', 10, 16500000.00, 3, 0, NULL, 'Top Radeon', 'AMD', NULL, NULL, 355, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(79, 4, 'Nvidia RTX 4070 Super', 10, 10800000.00, 3, 0, NULL, 'Super 1440p', 'Nvidia', NULL, NULL, 220, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(80, 4, 'Nvidia GTX 1660 Super', 10, 3200000.00, 1, 0, NULL, 'Classic 1080p', 'Nvidia', NULL, NULL, 125, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(81, 5, 'Samsung 970 EVO Plus 1TB', 10, 1650000.00, 2, 1000, NULL, 'NVMe Gen3 Raja Speed', 'Samsung', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(82, 5, 'Samsung 980 Pro 1TB NVMe', 10, 2200000.00, 3, 1000, NULL, 'NVMe Gen4 High Speed', 'Samsung', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(83, 5, 'WD Black SN770 1TB', 10, 1450000.00, 2, 1000, NULL, 'NVMe Gen4 Mid-Range', 'WD', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(84, 5, 'Crucial P3 Plus 1TB', 10, 1150000.00, 1, 1000, NULL, 'NVMe Gen4 Value', 'Crucial', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(85, 5, 'Adata Legend 710 512GB', 10, 580000.00, 1, 512, NULL, 'NVMe Gen3 Entry', 'Adata', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(86, 5, 'Lexar NM790 1TB', 10, 1400000.00, 3, 1000, NULL, 'NVMe Gen4 7400MB/s', 'Lexar', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(87, 5, 'Team T-Force Z440 1TB', 10, 1500000.00, 3, 1000, NULL, 'Gen4 with Heatspreader', 'Team', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(88, 5, 'Samsung 870 EVO 500GB', 10, 850000.00, 1, 500, NULL, 'Best SATA SSD', 'Samsung', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(89, 5, 'WD Blue 2TB HDD', 10, 950000.00, 1, 2000, NULL, 'Standard HDD', 'WD', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(90, 5, 'Seagate SkyHawk 4TB', 10, 1600000.00, 1, 4000, NULL, 'Large Storage', 'Seagate', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(91, 5, 'Hikvision C100 240GB', 10, 280000.00, 1, 240, NULL, 'SSD SATA Budget', 'Hikvision', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(92, 5, 'Team Elite GX2 512GB', 10, 550000.00, 1, 512, NULL, 'SATA SSD Value', 'Team', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(93, 5, 'Kingston A400 960GB', 10, 980000.00, 1, 960, NULL, 'Budget Large SSD', 'Kingston', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(94, 5, 'Crucial MX500 1TB', 10, 1300000.00, 1, 1000, NULL, 'Reliable SATA SSD', 'Crucial', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(95, 5, 'Samsung 990 Pro 2TB', 10, 4200000.00, 3, 2000, NULL, 'Ultimate Gen4 SSD', 'Samsung', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(96, 5, 'WD Blue SN580 1TB', 10, 1100000.00, 1, 1000, NULL, 'Efficient Gen4', 'WD', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(97, 5, 'Seagate FireCuda 530 1TB', 10, 2500000.00, 3, 1000, NULL, 'Premium Gen4', 'Seagate', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(98, 5, 'Toshiba P300 1TB', 10, 650000.00, 1, 1000, NULL, 'HDD 7200RPM', 'Toshiba', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(99, 5, 'Kingston NV2 2TB', 10, 1750000.00, 1, 2000, NULL, 'Gen4 SSD Value', 'Kingston', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(100, 5, 'MSI Spatium M480 2TB', 10, 3800000.00, 3, 2000, NULL, 'Extreme Performance', 'MSI', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(101, 6, 'Deepcool DN450 80+', 10, 480000.00, 1, 0, NULL, 'Entry Level', 'Deepcool', NULL, NULL, 450, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(102, 6, 'FSP HV PRO 550W Bronze', 10, 650000.00, 1, 0, NULL, 'Solid Budget', 'FSP', NULL, NULL, 550, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(103, 6, 'Cooler Master MWE 550W', 10, 780000.00, 1, 0, NULL, 'Reliable Bronze', 'Cooler Master', NULL, NULL, 550, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(104, 6, 'MSI MAG A650BN', 10, 850000.00, 1, 0, NULL, 'Tier C Bronze', 'MSI', NULL, NULL, 650, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(105, 6, 'Corsair CV650 80+', 10, 950000.00, 1, 0, NULL, 'Standard PSU', 'Corsair', NULL, NULL, 650, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(106, 6, 'Corsair RM750e Gold', 10, 1850000.00, 3, 0, NULL, 'Full Modular ATX 3.0', 'Corsair', NULL, NULL, 750, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(107, 6, 'Asus ROG Loki 850W', 10, 3200000.00, 3, 0, NULL, 'Premium SFX PSU', 'Asus', NULL, NULL, 850, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(108, 6, 'Aerocool United 500W', 10, 520000.00, 1, 0, NULL, 'Budget White', 'Aerocool', NULL, NULL, 500, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(109, 6, 'Silverstone ST50F 500W', 10, 580000.00, 1, 0, NULL, 'Stable Entry', 'Silverstone', NULL, NULL, 500, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(110, 6, 'Deepcool PK650D', 10, 820000.00, 1, 0, NULL, 'Reliable Bronze', 'Deepcool', NULL, NULL, 650, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(111, 6, 'Seasonic B12 650W', 10, 1100000.00, 2, 0, NULL, 'High Reliability', 'Seasonic', NULL, NULL, 650, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(112, 6, 'Corsair RM650 Gold', 10, 1650000.00, 2, 0, NULL, 'Tier A Gold', 'Corsair', NULL, NULL, 650, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(113, 6, 'MSI MPG A750GF', 10, 1850000.00, 2, 0, NULL, 'Full Modular', 'MSI', NULL, NULL, 750, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(114, 6, 'Super Flower 750W Gold', 10, 1550000.00, 2, 0, NULL, 'Semi Modular', 'Super Flower', NULL, NULL, 750, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(115, 6, 'Seasonic Focus GX-750', 10, 2100000.00, 3, 0, NULL, 'Legendary Gold', 'Seasonic', NULL, NULL, 750, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(116, 6, 'MSI MPG A850G PCIE5', 10, 2400000.00, 3, 0, NULL, 'ATX 3.0 Gold', 'MSI', NULL, NULL, 850, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(117, 6, 'Asus ROG Thor 850P', 10, 4500000.00, 3, 0, NULL, 'OLED Platinum', 'Asus', NULL, NULL, 850, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(118, 6, 'Thermaltake GF3 1000W', 10, 2800000.00, 3, 0, NULL, 'High Wattage', 'Thermaltake', NULL, NULL, 1000, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(119, 6, 'FSP Hydro G Pro 1000W', 10, 2600000.00, 3, 0, NULL, 'Robust 1000W', 'FSP', NULL, NULL, 1000, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(120, 6, 'Corsair HX1200 Platinum', 10, 4800000.00, 3, 0, NULL, 'Extreme Power', 'Corsair', NULL, NULL, 1200, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(121, 7, 'Paradox Gaming Trickster', 10, 350000.00, 1, 0, NULL, 'Budget Case', 'Paradox', NULL, NULL, NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(122, 7, 'Cube Gaming Weiss', 10, 420000.00, 1, 0, NULL, 'Value Case', 'Cube', NULL, NULL, NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(123, 7, 'Tecware Forge M2', 10, 580000.00, 1, 0, NULL, 'Mesh Front', 'Tecware', NULL, NULL, NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(124, 7, 'DarkFlash DLM21 Mesh', 10, 650000.00, 1, 0, NULL, 'Compact Case', 'DarkFlash', NULL, NULL, NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(125, 7, 'Montech Air 100 Lite', 10, 680000.00, 1, 0, NULL, 'Solid Airflow', 'Montech', NULL, NULL, NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(126, 7, 'Deepcool CC560', 10, 750000.00, 1, 0, NULL, 'Standard ATX', 'Deepcool', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(127, 7, 'NZXT H5 Flow', 10, 1350000.00, 2, 0, NULL, 'Minimalist Flow', 'NZXT', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(128, 7, 'Lian Li O11 Dynamic', 10, 2600000.00, 3, 0, NULL, 'Aquarium King', 'Lian Li', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(129, 7, 'MSI MAG Forge 100R', 10, 950000.00, 1, 0, NULL, 'RGB ATX', 'MSI', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(130, 7, 'Corsair 4000D Airflow', 10, 1650000.00, 2, 0, NULL, 'Premium Airflow', 'Corsair', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(131, 7, 'Phanteks Eclipse G360A', 10, 1600000.00, 2, 0, NULL, 'Performance Case', 'Phanteks', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(132, 7, 'Be Quiet! Base 500DX', 10, 1850000.00, 2, 0, NULL, 'Silent & Cool', 'Be Quiet!', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(133, 7, 'NZXT H7 Flow', 10, 2200000.00, 3, 0, NULL, 'Large Airflow', 'NZXT', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(134, 7, 'Fractal Design North', 10, 2800000.00, 3, 0, NULL, 'Wooden Aesthetic', 'Fractal', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(135, 7, 'Hyte Y60', 10, 3500000.00, 3, 0, NULL, 'Panoramic View', 'Hyte', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(136, 7, 'Lian Li O11 EVO XL', 10, 450000.00, 3, 0, NULL, 'Massive Aesthetic', 'Lian Li', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(137, 7, 'Cooler Master HAF 700', 10, 8500000.00, 3, 0, NULL, 'Performance Beast', 'Cooler Master', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(138, 7, 'Asus ROG Helios', 10, 5500000.00, 3, 0, NULL, 'ROG Flagship', 'Asus', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(139, 7, 'Antec Torque', 10, 6200000.00, 3, 0, NULL, 'Open Frame', 'Antec', NULL, NULL, NULL, 'ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(140, 7, 'VenomRx Arasaka', 10, 480000.00, 1, 0, NULL, 'Local Value', 'VenomRx', NULL, NULL, NULL, 'M-ATX', '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(141, 8, 'Deepcool AG400', 10, 350000.00, 1, 0, NULL, 'Standard Air', 'Deepcool', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(142, 8, 'ID-Cooling SE-224-XTS', 10, 420000.00, 1, 0, NULL, 'Solid Air Cooler', 'ID-Cooling', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(143, 8, 'Noctua NH-D15 Black', 10, 1950000.00, 3, 0, NULL, 'Air Cooler King', 'Noctua', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(144, 8, 'NZXT Kraken 240 RGB', 10, 2300000.00, 3, 0, NULL, 'Premium AIO', 'NZXT', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(145, 8, 'Deepcool Gammaxx 400', 10, 280000.00, 1, 0, NULL, 'Classic Budget', 'Deepcool', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(146, 8, 'Thermalright Assassin King', 10, 450000.00, 1, 0, NULL, 'High Value Air', 'Thermalright', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(147, 8, 'Arctic Freezer 34 DUO', 10, 850000.00, 2, 0, NULL, 'Performance Air', 'Arctic', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(148, 8, 'Be Quiet! Dark Rock 4', 10, 1600000.00, 3, 0, NULL, 'Silent King', 'Be Quiet!', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(149, 8, 'ID-Cooling Zoomflow 240', 10, 980000.00, 1, 0, NULL, 'Entry AIO', 'ID-Cooling', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(150, 8, 'Deepcool LS520 240mm', 10, 1250000.00, 2, 0, NULL, 'Modern AIO', 'Deepcool', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(151, 8, 'Arctic Liquid Freezer 240', 10, 1750000.00, 3, 0, NULL, 'Performance AIO', 'Arctic', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(152, 8, 'Corsair H100x RGB', 10, 1650000.00, 2, 0, NULL, 'Standard RGB AIO', 'Corsair', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(153, 8, 'Lian Li Galahad II LCD', 10, 4800000.00, 3, 0, NULL, 'LCD Premium AIO', 'Lian Li', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(154, 8, 'Asus Ryujin III 360', 10, 6500000.00, 3, 0, NULL, 'The Ultimate AIO', 'Asus', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(155, 8, 'Cooler Master ML360L', 10, 1550000.00, 2, 0, NULL, 'Solid 360mm AIO', 'Cooler Master', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(156, 8, 'Thermalright Peerless Assassin', 10, 650000.00, 2, 0, NULL, 'Value Dual Tower', 'Thermalright', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(157, 8, 'Noctua NH-U12S Redux', 10, 950000.00, 2, 0, NULL, 'Silent Single Tower', 'Noctua', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(158, 8, 'MSI CoreLiquid M240', 10, 1350000.00, 2, 0, NULL, 'M-Series AIO', 'MSI', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(159, 8, 'Deepcool LT720 360mm', 10, 2100000.00, 3, 0, NULL, 'Top Tier 360 AIO', 'Deepcool', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11'),
(160, 8, 'ID-Cooling DASHFLOW 360', 10, 1850000.00, 2, 0, NULL, 'White Theme AIO', 'ID-Cooling', NULL, NULL, NULL, NULL, '2025-12-21 12:06:00', '2026-01-11 07:35:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `product_price_histories`
--

CREATE TABLE `product_price_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `price` decimal(15,2) NOT NULL,
  `recorded_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `product_price_histories`
--

INSERT INTO `product_price_histories` (`id`, `product_id`, `price`, `recorded_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1260000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(2, 1, 1526000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(3, 1, 1470000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(4, 1, 1414000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(5, 1, 1330000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(6, 1, 1470000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(7, 2, 2392000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(8, 2, 2346000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(9, 2, 2369000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(10, 2, 2507000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(11, 2, 2116000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(12, 2, 2461000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(13, 3, 5460000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(14, 3, 5512000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(15, 3, 5460000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(16, 3, 4888000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(17, 3, 4680000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(18, 3, 5044000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(19, 4, 4028000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(20, 4, 3800000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(21, 4, 3534000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(22, 4, 3458000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(23, 4, 4142000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(24, 4, 3496000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(25, 5, 7848000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(26, 5, 6480000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(27, 5, 7416000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(28, 5, 6480000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(29, 5, 7416000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(30, 5, 7848000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(31, 6, 1592500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(32, 6, 1785000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(33, 6, 1802500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(34, 6, 1820000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(35, 6, 1785000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(36, 6, 1767500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(37, 7, 3008000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(38, 7, 3104000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(39, 7, 3072000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(40, 7, 3136000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(41, 7, 3360000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(42, 7, 3072000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(43, 8, 4275000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(44, 8, 4275000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(45, 8, 4725000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(46, 8, 4950000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(47, 8, 4455000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(48, 8, 4185000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(49, 9, 6370000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(50, 9, 6565000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(51, 9, 7085000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(52, 9, 5915000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(53, 9, 6370000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(54, 9, 6565000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(55, 10, 9568000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(56, 10, 8372000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(57, 10, 8464000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(58, 10, 9108000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(59, 10, 9660000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(60, 10, 9844000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(61, 11, 1078000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(62, 11, 1144000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(63, 11, 1133000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(64, 11, 1089000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(65, 11, 1199000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(66, 11, 1144000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(67, 12, 1150000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(68, 12, 1175000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(69, 12, 1237500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(70, 12, 1312500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(71, 12, 1350000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(72, 12, 1187500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(73, 13, 1974000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(74, 13, 1974000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(75, 13, 2184000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(76, 13, 2079000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(77, 13, 2205000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(78, 13, 1974000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(79, 14, 3290000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(80, 14, 3605000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(81, 14, 3500000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(82, 14, 3360000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(83, 14, 3640000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(84, 14, 3220000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(85, 15, 7416000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(86, 15, 6624000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(87, 15, 7272000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(88, 15, 6912000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(89, 15, 7848000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(90, 15, 6840000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(91, 16, 11385000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(92, 16, 10580000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(93, 16, 11385000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(94, 16, 10810000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(95, 16, 10695000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(96, 16, 10925000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(97, 17, 2574000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(98, 17, 2652000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(99, 17, 2366000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(100, 17, 2834000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(101, 17, 2470000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(102, 17, 2834000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(103, 18, 4992000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(104, 18, 4512000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(105, 18, 4704000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(106, 18, 4848000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(107, 18, 5280000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(108, 18, 4560000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(109, 19, 8415000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(110, 19, 8670000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(111, 19, 7650000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(112, 19, 7905000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(113, 19, 8670000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(114, 19, 8075000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(115, 20, 3990000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(116, 20, 3686000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(117, 20, 3534000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(118, 20, 3800000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(119, 20, 3914000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(120, 20, 3914000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(121, 21, 1007000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(122, 21, 1045000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(123, 21, 997500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(124, 21, 855000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(125, 21, 969000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(126, 21, 978500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(127, 22, 1133000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(128, 22, 1166000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(129, 22, 1133000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(130, 22, 1045000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(131, 22, 1056000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(132, 22, 1144000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(133, 23, 1485000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(134, 23, 1518000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(135, 23, 1782000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(136, 23, 1534500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(137, 23, 1798500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(138, 23, 1600500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(139, 24, 2300000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(140, 24, 2600000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(141, 24, 2425000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(142, 24, 2375000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(143, 24, 2750000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(144, 24, 2675000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(145, 25, 3232000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(146, 25, 3296000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(147, 25, 3040000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(148, 25, 3520000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(149, 25, 3104000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(150, 25, 2976000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(151, 26, 1656000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(152, 26, 1638000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(153, 26, 1890000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(154, 26, 1944000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(155, 26, 1818000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(156, 26, 1782000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(157, 27, 3074000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(158, 27, 2668000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(159, 27, 3074000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(160, 27, 3074000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(161, 27, 2987000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(162, 27, 2958000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(163, 28, 4452000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(164, 28, 3822000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(165, 28, 4158000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(166, 28, 4494000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(167, 28, 3990000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(168, 28, 4326000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(169, 29, 15900000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(170, 29, 14400000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(171, 29, 14100000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(172, 29, 13650000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(173, 29, 13800000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(174, 29, 16500000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(175, 30, 997500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(176, 30, 1039500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(177, 30, 955500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(178, 30, 997500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(179, 30, 1008000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(180, 30, 1060500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(181, 31, 1932000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(182, 31, 2079000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(183, 31, 2121000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(184, 31, 2079000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(185, 31, 2268000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(186, 31, 2163000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(187, 32, 3535000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(188, 32, 3220000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(189, 32, 3605000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(190, 32, 3640000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(191, 32, 3185000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(192, 32, 3150000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(193, 33, 4368000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(194, 33, 3948000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(195, 33, 4494000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(196, 33, 3906000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(197, 33, 3906000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(198, 33, 4452000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(199, 34, 6750000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(200, 34, 7275000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(201, 34, 7275000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(202, 34, 6900000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(203, 34, 7875000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(204, 34, 7800000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(205, 35, 8372000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(206, 35, 9936000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(207, 35, 9476000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(208, 35, 9936000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(209, 35, 8832000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(210, 35, 9476000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(211, 36, 12500000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(212, 36, 12000000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(213, 36, 13750000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(214, 36, 13375000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(215, 36, 12250000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(216, 36, 13500000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(217, 37, 3960000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(218, 37, 3384000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(219, 37, 3888000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(220, 37, 3960000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(221, 37, 3528000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(222, 37, 3240000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(223, 38, 4560000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(224, 38, 4368000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(225, 38, 4896000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(226, 38, 4368000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(227, 38, 5136000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(228, 38, 4704000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(229, 39, 2548000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(230, 39, 2808000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(231, 39, 2392000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(232, 39, 2860000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(233, 39, 2366000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(234, 39, 2496000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(235, 40, 1078000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(236, 40, 1029000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(237, 40, 960400.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(238, 40, 960400.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(239, 40, 980000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(240, 40, 1068200.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(241, 41, 310400.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(242, 41, 288000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(243, 41, 313600.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(244, 41, 326400.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(245, 41, 332800.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(246, 41, 342400.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(247, 42, 909500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(248, 42, 918000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(249, 42, 926500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(250, 42, 884000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(251, 42, 884000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(252, 42, 765000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(253, 43, 1133000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(254, 43, 1144000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(255, 43, 1144000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(256, 43, 1177000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(257, 43, 1122000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(258, 43, 1100000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(259, 44, 1440000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(260, 44, 1712000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(261, 44, 1600000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(262, 44, 1536000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(263, 44, 1520000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(264, 44, 1472000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(265, 45, 1081000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(266, 45, 1058000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(267, 45, 1184500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(268, 45, 1184500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(269, 45, 1207500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(270, 45, 1173000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(271, 46, 2568000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(272, 46, 2448000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(273, 46, 2304000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(274, 46, 2568000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(275, 46, 2160000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(276, 46, 2232000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(277, 47, 2968000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(278, 47, 2632000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(279, 47, 3052000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(280, 47, 2744000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(281, 47, 2828000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(282, 47, 2856000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(283, 48, 2676500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(284, 48, 2517500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(285, 48, 2782500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(286, 48, 2491000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(287, 48, 2570500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(288, 48, 2623500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(289, 49, 5580000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(290, 49, 6262000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(291, 49, 6572000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(292, 49, 6634000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(293, 49, 6262000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(294, 49, 6386000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(295, 50, 763200.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(296, 50, 770400.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(297, 50, 705600.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(298, 50, 691200.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(299, 50, 691200.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(300, 50, 784800.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(301, 51, 897600.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(302, 51, 924000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(303, 51, 800800.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(304, 51, 844800.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(305, 51, 924000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(306, 51, 950400.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(307, 52, 1380000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(308, 52, 1635000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(309, 52, 1515000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(310, 52, 1560000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(311, 52, 1365000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(312, 52, 1590000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(313, 53, 892400.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(314, 53, 975200.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(315, 53, 910800.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(316, 53, 966000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(317, 53, 947600.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(318, 53, 901600.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(319, 54, 709800.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(320, 54, 819000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(321, 54, 819000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(322, 54, 772200.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(323, 54, 764400.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(324, 54, 850200.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(325, 55, 2145000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(326, 55, 2106000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(327, 55, 2008500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(328, 55, 2106000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(329, 55, 1755000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(330, 55, 1852500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(331, 56, 1702000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(332, 56, 1794500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(333, 56, 1831500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(334, 56, 1683500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(335, 56, 1979500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(336, 56, 1942500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(337, 57, 1674000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(338, 57, 1643000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(339, 57, 1596500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(340, 57, 1658500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(341, 57, 1658500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(342, 57, 1519000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(343, 58, 2016000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(344, 58, 1995000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(345, 58, 1932000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(346, 58, 2016000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(347, 58, 2100000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(348, 58, 2142000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(349, 59, 861000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(350, 59, 861000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(351, 59, 820000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(352, 59, 836400.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(353, 59, 738000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(354, 59, 852800.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(355, 60, 1375000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(356, 60, 1275000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(357, 60, 1275000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(358, 60, 1175000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(359, 60, 1200000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(360, 60, 1375000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(361, 61, 2100000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(362, 61, 2142000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(363, 61, 2310000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(364, 61, 2226000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(365, 61, 2184000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(366, 61, 2289000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(367, 62, 2352000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(368, 62, 2303000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(369, 62, 2695000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(370, 62, 2401000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(371, 62, 2499000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(372, 62, 2352000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(373, 63, 3312000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(374, 63, 3816000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(375, 63, 3888000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(376, 63, 3672000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(377, 63, 3672000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(378, 63, 3276000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(379, 64, 3213000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(380, 64, 3213000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(381, 64, 2835000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(382, 64, 3370500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(383, 64, 3118500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(384, 64, 2929500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(385, 65, 4275000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(386, 65, 4545000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(387, 65, 4860000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(388, 65, 4905000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(389, 65, 4815000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(390, 65, 4230000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(391, 66, 5336000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(392, 66, 5742000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(393, 66, 6322000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(394, 66, 5278000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(395, 66, 5510000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(396, 66, 5336000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(397, 67, 4607500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(398, 67, 4898500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(399, 67, 4947000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(400, 67, 4462000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(401, 67, 5189500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(402, 67, 4656000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(403, 68, 6500000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(404, 68, 6435000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(405, 68, 7020000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(406, 68, 6825000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(407, 68, 6565000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(408, 68, 6305000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(409, 69, 4092000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(410, 69, 4664000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(411, 69, 4400000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(412, 69, 4136000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(413, 69, 4136000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(414, 69, 4840000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(415, 70, 9984000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(416, 70, 10464000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(417, 70, 10560000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(418, 70, 10464000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(419, 70, 9408000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(420, 70, 9984000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(421, 71, 8924000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(422, 71, 10120000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(423, 71, 9660000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(424, 71, 9936000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(425, 71, 8832000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(426, 71, 8924000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(427, 72, 15660000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(428, 72, 15950000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(429, 72, 14645000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(430, 72, 13195000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(431, 72, 15080000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(432, 72, 13340000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(433, 73, 13248000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(434, 73, 13938000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(435, 73, 12420000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(436, 73, 13386000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(437, 73, 12696000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(438, 73, 13524000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(439, 74, 17205000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(440, 74, 18315000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(441, 74, 19610000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(442, 74, 19425000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(443, 74, 17390000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(444, 74, 19980000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(445, 75, 32320000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(446, 75, 32960000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(447, 75, 29120000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(448, 75, 32960000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(449, 75, 32000000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(450, 75, 30720000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(451, 76, 3636000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(452, 76, 3276000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(453, 76, 3888000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(454, 76, 3348000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(455, 76, 3744000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(456, 76, 3420000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(457, 77, 5148000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(458, 77, 5668000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(459, 77, 5668000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(460, 77, 5408000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(461, 77, 4784000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(462, 77, 5356000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(463, 78, 16005000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(464, 78, 16665000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(465, 78, 15840000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(466, 78, 17325000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(467, 78, 15675000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(468, 78, 15345000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(469, 79, 10368000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(470, 79, 11556000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(471, 79, 11232000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(472, 79, 11340000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(473, 79, 11664000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(474, 79, 11340000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(475, 80, 3488000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(476, 80, 3360000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(477, 80, 2912000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(478, 80, 2880000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(479, 80, 3040000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(480, 80, 3296000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(481, 81, 1518000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(482, 81, 1699500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(483, 81, 1518000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(484, 81, 1765500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(485, 81, 1765500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(486, 81, 1798500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(487, 82, 2420000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(488, 82, 2046000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(489, 82, 2266000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(490, 82, 2420000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(491, 82, 2090000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(492, 82, 2002000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(493, 83, 1493500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(494, 83, 1392000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(495, 83, 1580500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(496, 83, 1595000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(497, 83, 1435500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(498, 83, 1580500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(499, 84, 1035000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(500, 84, 1046500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(501, 84, 1069500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(502, 84, 1104000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(503, 84, 1092500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(504, 84, 1230500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(505, 85, 603200.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(506, 85, 574200.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(507, 85, 591600.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(508, 85, 539400.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(509, 85, 638000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(510, 85, 527800.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(511, 86, 1330000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(512, 86, 1260000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(513, 86, 1288000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(514, 86, 1302000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(515, 86, 1330000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(516, 86, 1414000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(517, 87, 1365000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(518, 87, 1575000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(519, 87, 1455000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(520, 87, 1650000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(521, 87, 1485000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(522, 87, 1425000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(523, 88, 901000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(524, 88, 901000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(525, 88, 782000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(526, 88, 892500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(527, 88, 824500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(528, 88, 765000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(529, 89, 912000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(530, 89, 1045000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(531, 89, 921500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(532, 89, 1007000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(533, 89, 997500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(534, 89, 1035500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(535, 90, 1584000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(536, 90, 1584000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(537, 90, 1488000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(538, 90, 1504000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(539, 90, 1472000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(540, 90, 1616000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(541, 91, 268800.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(542, 91, 274400.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(543, 91, 274400.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(544, 91, 280000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(545, 91, 271600.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(546, 91, 308000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(547, 92, 522500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(548, 92, 605000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(549, 92, 605000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(550, 92, 561000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(551, 92, 555500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(552, 92, 550000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(553, 93, 970200.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(554, 93, 911400.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(555, 93, 921200.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(556, 93, 1038800.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(557, 93, 1038800.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(558, 93, 940800.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(559, 94, 1222000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(560, 94, 1248000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(561, 94, 1209000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(562, 94, 1235000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(563, 94, 1287000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(564, 94, 1261000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(565, 95, 4326000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(566, 95, 4074000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(567, 95, 4452000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(568, 95, 3990000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(569, 95, 4032000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(570, 95, 4032000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(571, 96, 1023000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(572, 96, 990000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(573, 96, 1056000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(574, 96, 1166000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(575, 96, 1111000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(576, 96, 1100000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(577, 97, 2575000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(578, 97, 2600000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(579, 97, 2450000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(580, 97, 2575000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(581, 97, 2250000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(582, 97, 2650000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(583, 98, 630500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(584, 98, 624000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(585, 98, 663000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(586, 98, 656500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(587, 98, 663000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(588, 98, 624000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(589, 99, 1592500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(590, 99, 1610000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(591, 99, 1732500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(592, 99, 1785000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(593, 99, 1767500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(594, 99, 1697500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(595, 100, 3458000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(596, 100, 4142000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(597, 100, 3952000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(598, 100, 3610000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(599, 100, 3572000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(600, 100, 4028000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(601, 101, 508800.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(602, 101, 456000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(603, 101, 441600.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(604, 101, 465600.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(605, 101, 494400.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(606, 101, 508800.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(607, 102, 604500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(608, 102, 656500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(609, 102, 624000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(610, 102, 585000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(611, 102, 611000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(612, 102, 650000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(613, 103, 803400.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(614, 103, 850200.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(615, 103, 717600.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(616, 103, 811200.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(617, 103, 819000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(618, 103, 819000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48');
INSERT INTO `product_price_histories` (`id`, `product_id`, `price`, `recorded_date`, `created_at`, `updated_at`) VALUES
(619, 104, 875500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(620, 104, 833000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(621, 104, 858500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(622, 104, 799000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(623, 104, 884000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(624, 104, 909500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(625, 105, 893000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(626, 105, 893000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(627, 105, 1007000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(628, 105, 1045000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(629, 105, 893000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(630, 105, 902500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(631, 106, 1850000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(632, 106, 1979500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(633, 106, 1924000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(634, 106, 1739000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(635, 106, 1720500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(636, 106, 1757500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(637, 107, 3360000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(638, 107, 3456000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(639, 107, 3264000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(640, 107, 3232000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(641, 107, 2880000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(642, 107, 3072000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(643, 108, 504400.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(644, 108, 468000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(645, 108, 540800.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(646, 108, 530400.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(647, 108, 520000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(648, 108, 483600.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(649, 109, 603200.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(650, 109, 638000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(651, 109, 603200.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(652, 109, 551000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(653, 109, 533600.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(654, 109, 603200.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(655, 110, 902000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(656, 110, 820000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(657, 110, 844600.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(658, 110, 754400.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(659, 110, 762600.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(660, 110, 738000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(661, 111, 1034000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(662, 111, 1122000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(663, 111, 1188000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(664, 111, 1155000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(665, 111, 1166000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(666, 111, 1155000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(667, 112, 1600500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(668, 112, 1815000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(669, 112, 1485000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(670, 112, 1749000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(671, 112, 1732500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(672, 112, 1716000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(673, 113, 1665000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(674, 113, 1961000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(675, 113, 1794500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(676, 113, 1868500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(677, 113, 1942500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(678, 113, 1794500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(679, 114, 1488000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(680, 114, 1627500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(681, 114, 1410500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(682, 114, 1565500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(683, 114, 1426000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(684, 114, 1457000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(685, 115, 2268000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(686, 115, 2289000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(687, 115, 2100000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(688, 115, 2121000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(689, 115, 2268000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(690, 115, 2205000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(691, 116, 2520000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(692, 116, 2352000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(693, 116, 2448000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(694, 116, 2232000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(695, 116, 2280000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(696, 116, 2616000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(697, 117, 4545000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(698, 117, 4095000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(699, 117, 4095000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(700, 117, 4050000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(701, 117, 4545000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(702, 117, 4365000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(703, 118, 2688000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(704, 118, 3024000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(705, 118, 2912000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(706, 118, 2884000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(707, 118, 2604000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(708, 118, 2940000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(709, 119, 2548000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(710, 119, 2548000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(711, 119, 2808000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(712, 119, 2834000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(713, 119, 2782000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(714, 119, 2756000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(715, 120, 5088000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(716, 120, 5232000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(717, 120, 4896000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(718, 120, 5280000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(719, 120, 4464000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(720, 120, 4416000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(721, 121, 346500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(722, 121, 315000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(723, 121, 346500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(724, 121, 350000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(725, 121, 385000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(726, 121, 357000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(727, 122, 403200.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(728, 122, 411600.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(729, 122, 436800.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(730, 122, 441000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(731, 122, 403200.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(732, 122, 420000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(733, 123, 556800.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(734, 123, 626400.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(735, 123, 568400.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(736, 123, 574200.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(737, 123, 562600.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(738, 123, 632200.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(739, 124, 624000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(740, 124, 604500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(741, 124, 650000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(742, 124, 585000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(743, 124, 669500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(744, 124, 624000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(745, 125, 680000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(746, 125, 680000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(747, 125, 734400.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(748, 125, 646000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(749, 125, 659600.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(750, 125, 618800.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(751, 126, 742500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(752, 126, 795000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(753, 126, 727500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(754, 126, 780000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(755, 126, 765000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(756, 126, 727500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(757, 127, 1485000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(758, 127, 1417500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(759, 127, 1431000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(760, 127, 1269000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(761, 127, 1282500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(762, 127, 1269000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(763, 128, 2548000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(764, 128, 2652000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(765, 128, 2652000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(766, 128, 2444000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(767, 128, 2704000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(768, 128, 2444000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(769, 129, 997500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(770, 129, 893000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(771, 129, 940500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(772, 129, 1035500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(773, 129, 940500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(774, 129, 988000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(775, 130, 1633500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(776, 130, 1600500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(777, 130, 1782000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(778, 130, 1650000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(779, 130, 1716000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(780, 130, 1683000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(781, 131, 1760000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(782, 131, 1568000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(783, 131, 1504000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(784, 131, 1664000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(785, 131, 1472000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(786, 131, 1712000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(787, 132, 2035000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(788, 132, 2035000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(789, 132, 2035000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(790, 132, 1961000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(791, 132, 2035000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(792, 132, 1942500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(793, 133, 2376000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(794, 133, 2398000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(795, 133, 2090000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(796, 133, 2068000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(797, 133, 1980000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(798, 133, 2332000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(799, 134, 2632000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(800, 134, 2660000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(801, 134, 3080000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(802, 134, 2884000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(803, 134, 2856000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(804, 134, 2660000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(805, 135, 3815000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(806, 135, 3535000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(807, 135, 3395000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(808, 135, 3675000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(809, 135, 3290000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(810, 135, 3535000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(811, 136, 441000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(812, 136, 472500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(813, 136, 450000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(814, 136, 463500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(815, 136, 427500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(816, 136, 409500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(817, 137, 9265000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(818, 137, 9095000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(819, 137, 8670000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(820, 137, 8245000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(821, 137, 8925000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(822, 137, 8670000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(823, 138, 5665000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(824, 138, 5885000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(825, 138, 5170000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(826, 138, 5665000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(827, 138, 5940000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(828, 138, 4950000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(829, 139, 6572000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(830, 139, 6076000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(831, 139, 5828000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(832, 139, 6696000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(833, 139, 6386000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(834, 139, 6696000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(835, 140, 508800.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(836, 140, 475200.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(837, 140, 494400.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(838, 140, 460800.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(839, 140, 508800.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(840, 140, 480000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(841, 141, 381500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(842, 141, 339500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(843, 141, 350000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(844, 141, 325500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(845, 141, 357000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(846, 141, 367500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(847, 142, 445200.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(848, 142, 453600.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(849, 142, 462000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(850, 142, 449400.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(851, 142, 457800.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(852, 142, 432600.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(853, 143, 1989000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(854, 143, 2047500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(855, 143, 1813500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(856, 143, 1774500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(857, 143, 2008500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(858, 143, 1833000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(859, 144, 2231000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(860, 144, 2507000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(861, 144, 2461000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(862, 144, 2093000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(863, 144, 2507000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(864, 144, 2507000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(865, 145, 291200.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(866, 145, 280000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(867, 145, 254800.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(868, 145, 291200.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(869, 145, 257600.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(870, 145, 277200.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(871, 146, 423000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(872, 146, 423000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(873, 146, 450000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(874, 146, 414000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(875, 146, 495000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(876, 146, 454500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(877, 147, 790500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(878, 147, 901000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(879, 147, 935000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(880, 147, 909500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(881, 147, 901000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(882, 147, 909500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(883, 148, 1504000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(884, 148, 1712000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(885, 148, 1632000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(886, 148, 1440000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(887, 148, 1680000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(888, 148, 1696000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(889, 149, 1078000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(890, 149, 970200.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(891, 149, 911400.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(892, 149, 970200.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(893, 149, 970200.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(894, 149, 960400.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(895, 150, 1225000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(896, 150, 1337500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(897, 150, 1150000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(898, 150, 1162500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(899, 150, 1262500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(900, 150, 1237500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(901, 151, 1872500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(902, 151, 1645000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(903, 151, 1575000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(904, 151, 1610000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(905, 151, 1872500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(906, 151, 1890000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(907, 152, 1633500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(908, 152, 1798500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(909, 152, 1501500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(910, 152, 1765500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(911, 152, 1815000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(912, 152, 1617000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(913, 153, 4368000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(914, 153, 4944000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(915, 153, 4944000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(916, 153, 4752000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(917, 153, 4896000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(918, 153, 4512000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(919, 154, 6565000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(920, 154, 6955000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(921, 154, 6110000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(922, 154, 6305000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(923, 154, 6760000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(924, 154, 6240000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(925, 155, 1643000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(926, 155, 1472500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(927, 155, 1596500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(928, 155, 1534500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(929, 155, 1503500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(930, 155, 1519000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(931, 156, 682500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(932, 156, 643500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(933, 156, 591500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(934, 156, 617500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(935, 156, 624000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(936, 156, 669500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(937, 157, 997500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(938, 157, 1035500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(939, 157, 902500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(940, 157, 912000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(941, 157, 921500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(942, 157, 883500.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(943, 158, 1228500.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(944, 158, 1296000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(945, 158, 1458000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(946, 158, 1390500.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(947, 158, 1377000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(948, 158, 1296000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(949, 159, 2142000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(950, 159, 2310000.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(951, 159, 2016000.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(952, 159, 2163000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(953, 159, 1890000.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(954, 159, 2289000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(955, 160, 1887000.00, '2026-01-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(956, 160, 1905500.00, '2026-02-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(957, 160, 1905500.00, '2026-03-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(958, 160, 1924000.00, '2026-04-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(959, 160, 1757500.00, '2026-05-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48'),
(960, 160, 1924000.00, '2026-06-01', '2026-07-01 07:48:48', '2026-07-01 07:48:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `phone` varchar(20) DEFAULT NULL,
  `gender` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `role`, `phone`, `gender`, `dob`, `address`, `profile_pic`, `created_at`, `updated_at`) VALUES
(1, 'RakaAdmin', '$2y$10$tnjGUDUJvzCVQiUnKygA9evA/ykqPReo3bYhq4NChqdbTdoP6TPkW', 'Nakeshya Raka', 'admin', NULL, NULL, NULL, NULL, NULL, '2025-12-29 08:23:55', NULL),
(4, 'RakaDesu', '$2y$10$m0OQ4josMA2aDJYcmlHBmOBatzmd.22pkymQfa1QEmq69cPZ87q2.', 'Nakeshya Raka', 'user', NULL, NULL, NULL, NULL, NULL, '2026-01-11 14:19:53', NULL),
(5, 'tutorial', '$2y$10$PjlgdkOvc4XUW2PgGmgNSurkN9QpHRUnbT99DJkGWoKA44UCaHRPu', 'Falaah Hamid', 'user', NULL, NULL, NULL, NULL, NULL, '2026-01-11 16:17:50', NULL),
(7, 'RRQFIFA', '$2y$10$IgbGIf2pAsw79lbD5r/naegkWpcx8F1DEBCZW0bemoMUTB.f7KUp2', 'Falaah Hamid', 'user', NULL, NULL, NULL, NULL, NULL, '2026-01-11 16:18:09', NULL),
(8, 'Relaska', '$2y$10$PLAi7Hb83FWSjbsn0xkq0.FTFAVfWK0ZyqAPPmAK6maXaGMF/SOsK', 'Relaska', 'user', NULL, NULL, NULL, NULL, NULL, '2026-01-12 07:26:06', NULL),
(10, 'BrodyJago', '$2y$10$vfD1M44XKnQf6CpJiv6YGe9p.ZWoG9jt.0ZfBxRp.W8o1KX2TxPAy', 'Brody', 'user', '87181201280192', 'Laki-laki', '2000-01-11', 'Jalan Pisangan Mangga ', NULL, '2026-01-16 09:06:17', NULL),
(11, '123456', '$2y$10$7RpwCVr1en8XDwoUnvElCO3dfSce4PYEaTUOF2sV3NXz3Ai7Bx1F.', 'Falaah Hamid', 'user', NULL, NULL, NULL, NULL, NULL, '2026-01-18 03:20:23', NULL),
(12, 'RAKA123', '$2y$10$1kMQQespIam9hPg/G95hse2NEolRtGZXFF44ExYrQ3pILo5t73ACO', 'RAKA', 'user', NULL, NULL, NULL, NULL, NULL, '2026-01-20 08:08:29', NULL),
(13, 'Onic', '$2y$10$prDuLxsXD3TWjqBpSpAuou5Ln26xTXYq5zd5AA9cVDqZPaH/oGp2u', 'Onic#7', 'user', NULL, 'Laki-laki', '2000-01-14', NULL, '1769413266_557199e10d44a0852fd6.jpg', '2026-01-26 07:29:24', NULL),
(14, 'FALL', '$2y$12$dz511zeJiSPBQyNCAuNBJ.hdSGWTWtA9/HDnqe5FmmkbJ6tl5aY6W', 'FALL', 'user', '9890234023', 'Laki-laki', '2004-02-03', 'YANG PENTING SUKSESSS AMINN', '1783228382_channels4_profile.jpg', NULL, '2026-07-05 08:41:07');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `builds`
--
ALTER TABLE `builds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `builds_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `build_items`
--
ALTER TABLE `build_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `build_items_build_id_foreign` (`build_id`),
  ADD KEY `build_items_product_id_foreign` (`product_id`);

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Indeks untuk tabel `product_price_histories`
--
ALTER TABLE `product_price_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_price_histories_product_id_foreign` (`product_id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `builds`
--
ALTER TABLE `builds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `build_items`
--
ALTER TABLE `build_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT untuk tabel `product_price_histories`
--
ALTER TABLE `product_price_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=961;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `builds`
--
ALTER TABLE `builds`
  ADD CONSTRAINT `builds_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `build_items`
--
ALTER TABLE `build_items`
  ADD CONSTRAINT `build_items_build_id_foreign` FOREIGN KEY (`build_id`) REFERENCES `builds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `build_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Ketidakleluasaan untuk tabel `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `product_price_histories`
--
ALTER TABLE `product_price_histories`
  ADD CONSTRAINT `product_price_histories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

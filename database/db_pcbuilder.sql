INSERT INTO `categories` (`id`, `name`, `slug`) VALUES
(1, 'Processor', 'processor'),
(2, 'Motherboard', 'motherboard'),
(3, 'RAM', 'ram'),
(4, 'VGA', 'vga'),
(5, 'Storage', 'storage'),
(6, 'Power Supply', 'psu'),
(7, 'Casing', 'case'),
(8, 'CPU Cooler', 'cooler'),
(9, 'Case Fan', 'fan'),
(10, 'Monitor', 'monitor'),
(11, 'Keyboard', 'keyboard'),
(12, 'Mouse', 'mouse'),
(13, 'Headset', 'headset');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` int(11) UNSIGNED NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `price` decimal(15,2) NOT NULL,
  `tier` int(11) DEFAULT 1,
  `capacity` int(11) DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `socket_type` varchar(50) DEFAULT NULL,
  `memory_type` varchar(20) DEFAULT NULL,
  `wattage` int(11) DEFAULT NULL,
  `form_factor` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `stock`, `price`, `tier`, `capacity`, `image`, `description`, `brand`, `socket_type`, `memory_type`, `wattage`, `form_factor`, `created_at`, `updated_at`) VALUES
(1, 1, 'AMD Ryzen 5 5500', 10, 1400000.00, 1, 0, NULL, 'Budget King AM4', NULL, 'AM4', '', 65, '', '2025-12-21 19:06:00', '2026-01-11 20:08:31'),
(2, 1, 'AMD Ryzen 5 5600X', 10, 2300000.00, 2, 0, NULL, 'Mid-range Gaming AM4', 'AMD', 'AM4', NULL, 65, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(3, 1, 'AMD Ryzen 7 5800X3D', 10, 5200000.00, 3, 0, NULL, 'Best Gaming AM4', 'AMD', 'AM4', NULL, 105, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(4, 1, 'AMD Ryzen 5 7600X', 10, 3800000.00, 2, 0, NULL, 'Next Gen Mid-range', 'AMD', 'AM5', NULL, 105, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(5, 1, 'AMD Ryzen 9 7900X', 10, 7200000.00, 3, 0, NULL, 'High-end Workstation', 'AMD', 'AM5', NULL, 170, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(6, 1, 'Intel Core i3-13100F', 10, 1750000.00, 1, 0, NULL, 'Entry Level Gen 13', 'Intel', 'LGA1700', NULL, 60, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(7, 1, 'Intel Core i5-13400F', 10, 3200000.00, 2, 0, NULL, 'Mid-range Hybrid Gen 13', 'Intel', 'LGA1700', NULL, 65, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(8, 1, 'Intel Core i5-13600KF', 10, 4500000.00, 3, 0, NULL, 'Performance Gen 13', 'Intel', 'LGA1700', NULL, 125, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(9, 1, 'Intel Core i7-13700K', 10, 6500000.00, 3, 0, NULL, 'High-end Gen 13', 'Intel', 'LGA1700', NULL, 125, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(10, 1, 'Intel Core i9-13900K', 10, 9200000.00, 3, 0, NULL, 'Extreme Gen 13', 'Intel', 'LGA1700', NULL, 150, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(11, 1, 'AMD Ryzen 3 4100', 10, 1100000.00, 1, 0, NULL, 'Basic AM4', 'AMD', 'AM4', NULL, 65, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(12, 1, 'AMD Ryzen 5 4500', 10, 1250000.00, 1, 0, NULL, 'Entry AM4 6-core', 'AMD', 'AM4', NULL, 65, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(13, 1, 'Intel Core i3-14100', 10, 2100000.00, 1, 0, NULL, 'Latest Entry Gen 14', 'Intel', 'LGA1700', NULL, 60, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(14, 1, 'Intel Core i5-14400F', 10, 3500000.00, 2, 0, NULL, 'Latest Mid Gen 14', 'Intel', 'LGA1700', NULL, 65, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(15, 1, 'Intel Core i7-14700K', 10, 7200000.00, 3, 0, NULL, 'High-end Gen 14', 'Intel', 'LGA1700', NULL, 125, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(16, 1, 'Intel Core i9-14900KS', 10, 11500000.00, 3, 0, NULL, 'Limited Edition Gen 14', 'Intel', 'LGA1700', NULL, 150, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(17, 1, 'AMD Ryzen 5 7500F', 10, 2600000.00, 2, 0, NULL, 'Value AM5 DDR5', 'AMD', 'AM5', NULL, 65, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(18, 1, 'AMD Ryzen 7 7700X', 10, 4800000.00, 3, 0, NULL, 'Performance AM5', 'AMD', 'AM5', NULL, 105, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(19, 1, 'AMD Ryzen 9 7950X', 10, 8500000.00, 3, 0, NULL, 'Extreme AM5', 'AMD', 'AM5', NULL, 170, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(20, 1, 'Intel Core i5-12600K', 10, 3800000.00, 2, 0, NULL, 'Unlocked Gen 12', 'Intel', 'LGA1700', NULL, 125, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(21, 2, 'MSI A520M-A PRO', 10, 950000.00, 1, 0, NULL, 'Entry AM4', 'MSI', 'AM4', 'DDR4', NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(22, 2, 'Gigabyte B450M DS3H', 10, 1100000.00, 1, 0, NULL, 'Classic AM4', 'Gigabyte', 'AM4', 'DDR4', NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(23, 2, 'Asus Prime B550M-K', 10, 1650000.00, 1, 0, NULL, 'Solid AM4', 'Asus', 'AM4', 'DDR4', NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(24, 2, 'MSI MPG B550 Gaming Plus', 10, 2500000.00, 2, 0, NULL, 'Gaming AM4', 'MSI', 'AM4', 'DDR4', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(25, 2, 'ASRock X570 Steel Legend', 10, 3200000.00, 2, 0, NULL, 'Premium AM4', 'ASRock', 'AM4', 'DDR4', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(26, 2, 'Gigabyte A620M Gaming X', 10, 1800000.00, 1, 0, NULL, 'Entry AM5', 'Gigabyte', 'AM5', 'DDR5', NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(27, 2, 'MSI PRO B650-P WiFi', 10, 2900000.00, 2, 0, NULL, 'Mid AM5 WiFi', 'MSI', 'AM5', 'DDR5', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(28, 2, 'Asus ROG Strix B650-A', 10, 4200000.00, 3, 0, NULL, 'White Theme AM5', 'Asus', 'AM5', 'DDR5', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(29, 2, 'MSI MEG X670E Godlike', 10, 15000000.00, 3, 0, NULL, 'God Tier AM5', 'MSI', 'AM5', 'DDR5', NULL, 'E-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(30, 2, 'Asrock H610M-HVS', 10, 1050000.00, 1, 0, NULL, 'Budget LGA1700', 'Asrock', 'LGA1700', 'DDR4', NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(31, 2, 'Gigabyte B760M DS3H WiFi', 10, 2100000.00, 2, 0, NULL, 'LGA1700 WiFi DDR4', 'Gigabyte', 'LGA1700', 'DDR4', NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(32, 2, 'MSI MAG B760 Tomahawk', 10, 3500000.00, 2, 0, NULL, 'LGA1700 DDR5 ATX', 'MSI', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(33, 2, 'Asus Prime Z790-P', 10, 4200000.00, 3, 0, NULL, 'Entry Z790', 'Asus', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(34, 2, 'MSI MPG Z790 Carbon WiFi', 10, 7500000.00, 3, 0, NULL, 'Premium Z790', 'MSI', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(35, 2, 'Asrock Z790 Taichi', 10, 9200000.00, 3, 0, NULL, 'Top Tier Z790', 'Asrock', 'LGA1700', 'DDR5', NULL, 'E-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(36, 2, 'Asus ROG Maximus Z790 Apex', 10, 12500000.00, 3, 0, NULL, 'OC Beast LGA1700', 'Asus', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(37, 2, 'Gigabyte Z690 Gaming X', 10, 3600000.00, 2, 0, NULL, 'Z690 DDR4', 'Gigabyte', 'LGA1700', 'DDR4', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(38, 2, 'MSI PRO Z790-A WiFi', 10, 4800000.00, 3, 0, NULL, 'Professional Z790', 'MSI', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(39, 2, 'Asrock B760 Pro RS', 10, 2600000.00, 2, 0, NULL, 'Silver Theme LGA1700', 'Asrock', 'LGA1700', 'DDR5', NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(40, 2, 'Biostar H610MH', 10, 980000.00, 1, 0, NULL, 'Cheapest LGA1700', 'Biostar', 'LGA1700', 'DDR4', NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(41, 3, 'Team Elite Plus 8GB 3200', 10, 320000.00, 1, 8, NULL, 'Standard DDR4', 'TeamGroup', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(42, 3, 'Kingston Fury Beast 16GB (2x8)', 10, 850000.00, 1, 16, NULL, 'Reliable DDR4', 'Kingston', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(43, 3, 'Corsair Vengeance RGB Pro 16GB', 10, 1100000.00, 2, 16, NULL, 'RGB DDR4', 'Corsair', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(44, 3, 'G.Skill Ripjaws V 32GB (2x16)', 10, 1600000.00, 2, 32, NULL, 'Performance DDR4', 'G.Skill', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(45, 3, 'Crucial Pro 16GB 5600', 10, 1150000.00, 1, 16, NULL, 'Entry DDR5', 'Crucial', NULL, 'DDR5', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(46, 3, 'Adata XPG Lancer RGB 32GB', 10, 2400000.00, 2, 32, NULL, 'Fast DDR5', 'Adata', NULL, 'DDR5', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(47, 3, 'G.Skill Trident Z5 RGB 32GB 6000', 10, 2800000.00, 3, 32, NULL, 'Top Speed DDR5', 'G.Skill', NULL, 'DDR5', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(48, 3, 'Team T-Force Delta 32GB 6400', 10, 2650000.00, 3, 32, NULL, 'High Frequency DDR5', 'TeamGroup', NULL, 'DDR5', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(49, 3, 'Corsair Dominator Titanium 64GB', 10, 6200000.00, 3, 64, NULL, 'Luxury DDR5', 'Corsair', NULL, 'DDR5', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(50, 3, 'Lexar Thor 16GB (2x8)', 10, 720000.00, 1, 16, NULL, 'Low Profile DDR4', 'Lexar', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(51, 3, 'PNY XLR8 Gaming 16GB', 10, 880000.00, 1, 16, NULL, 'Gamer DDR4', 'PNY', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(52, 3, 'Patriot Viper Steel 32GB', 10, 1500000.00, 2, 32, NULL, 'Stability DDR4', 'Patriot', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(53, 3, 'Klevv Cras X RGB 16GB', 10, 920000.00, 1, 16, NULL, 'Aura Sync DDR4', 'Klevv', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(54, 3, 'Geil Orion 16GB', 10, 780000.00, 1, 16, NULL, 'Red Theme DDR4', 'Geil', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(55, 3, 'Galax HOF OC Lab 16GB', 10, 1950000.00, 3, 16, NULL, 'OC Record DDR4', 'Galax', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(56, 3, 'Netac Shadow II 32GB 6000', 10, 1850000.00, 2, 32, NULL, 'Value DDR5', 'Netac', NULL, 'DDR5', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(57, 3, 'V-Color Prism Pro 32GB', 10, 1550000.00, 2, 32, NULL, 'Jewel Design DDR4', 'V-Color', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(58, 3, 'OLOy Blade RGB 32GB', 10, 2100000.00, 2, 32, NULL, 'Sleek DDR5', 'OLOy', NULL, 'DDR5', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(59, 3, 'Silicon Power Xpower 16GB', 10, 820000.00, 1, 16, NULL, 'Budget Performance', 'Silicon Power', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(60, 3, 'Crucial Ballistix 16GB 3600', 10, 1250000.00, 2, 16, NULL, 'Legendary OC DDR4', 'Crucial', NULL, 'DDR4', NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(61, 4, 'Nvidia GTX 1650 4GB', 10, 2100000.00, 1, 0, NULL, 'Entry 1080p', 'Nvidia', NULL, NULL, 75, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(62, 4, 'AMD RX 6500 XT', 10, 2450000.00, 1, 0, NULL, 'Entry Radeon', 'AMD', NULL, NULL, 107, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(63, 4, 'Nvidia RTX 3050 8GB', 10, 3600000.00, 1, 0, NULL, 'RTX Starter', 'Nvidia', NULL, NULL, 130, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(64, 4, 'AMD RX 6600 8GB', 10, 3150000.00, 2, 0, NULL, 'Radeon 1080p King', 'AMD', NULL, NULL, 132, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(65, 4, 'Nvidia RTX 3060 12GB', 10, 4500000.00, 2, 0, NULL, 'VRAM King Mid', 'Nvidia', NULL, NULL, 170, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(66, 4, 'AMD RX 6700 XT 12GB', 10, 5800000.00, 2, 0, NULL, '1440p Radeon', 'AMD', NULL, NULL, 230, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(67, 4, 'Nvidia RTX 4060 8GB', 10, 4850000.00, 2, 0, NULL, 'Power Efficient Mid', 'Nvidia', NULL, NULL, 115, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(68, 4, 'Nvidia RTX 4060 Ti 8GB', 10, 6500000.00, 2, 0, NULL, 'High FPS 1080p', 'Nvidia', NULL, NULL, 160, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(69, 4, 'AMD RX 7600 8GB', 10, 4400000.00, 2, 0, NULL, 'Modern 1080p Radeon', 'AMD', NULL, NULL, 165, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(70, 4, 'Nvidia RTX 4070 12GB', 10, 9600000.00, 3, 0, NULL, '1440p King', 'Nvidia', NULL, NULL, 200, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(71, 4, 'AMD RX 7800 XT 16GB', 10, 9200000.00, 3, 0, NULL, 'High VRAM Radeon', 'AMD', NULL, NULL, 263, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(72, 4, 'Nvidia RTX 4070 Ti Super', 10, 14500000.00, 3, 0, NULL, '4K Starter', 'Nvidia', NULL, NULL, 285, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(73, 4, 'AMD RX 7900 XT 20GB', 10, 13800000.00, 3, 0, NULL, 'Premium Radeon', 'AMD', NULL, NULL, 315, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(74, 4, 'Nvidia RTX 4080 Super', 10, 18500000.00, 3, 0, NULL, 'Extreme 4K', 'Nvidia', NULL, NULL, 320, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(75, 4, 'Nvidia RTX 4090 24GB', 10, 32000000.00, 3, 0, NULL, 'Absolute Beast', 'Nvidia', NULL, NULL, 450, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(76, 4, 'Intel Arc A750', 10, 3600000.00, 2, 0, NULL, 'Intel GPU Challenger', 'Intel', NULL, NULL, 225, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(77, 4, 'Intel Arc A770 16GB', 10, 5200000.00, 2, 0, NULL, 'Top Intel Arc', 'Intel', NULL, NULL, 225, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(78, 4, 'AMD RX 7900 XTX 24GB', 10, 16500000.00, 3, 0, NULL, 'Top Radeon', 'AMD', NULL, NULL, 355, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(79, 4, 'Nvidia RTX 4070 Super', 10, 10800000.00, 3, 0, NULL, 'Super 1440p', 'Nvidia', NULL, NULL, 220, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(80, 4, 'Nvidia GTX 1660 Super', 10, 3200000.00, 1, 0, NULL, 'Classic 1080p', 'Nvidia', NULL, NULL, 125, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(81, 5, 'Samsung 970 EVO Plus 1TB', 10, 1650000.00, 2, 1000, NULL, 'NVMe Gen3 Raja Speed', 'Samsung', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(82, 5, 'Samsung 980 Pro 1TB NVMe', 10, 2200000.00, 3, 1000, NULL, 'NVMe Gen4 High Speed', 'Samsung', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(83, 5, 'WD Black SN770 1TB', 10, 1450000.00, 2, 1000, NULL, 'NVMe Gen4 Mid-Range', 'WD', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(84, 5, 'Crucial P3 Plus 1TB', 10, 1150000.00, 1, 1000, NULL, 'NVMe Gen4 Value', 'Crucial', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(85, 5, 'Adata Legend 710 512GB', 10, 580000.00, 1, 512, NULL, 'NVMe Gen3 Entry', 'Adata', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(86, 5, 'Lexar NM790 1TB', 10, 1400000.00, 3, 1000, NULL, 'NVMe Gen4 7400MB/s', 'Lexar', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(87, 5, 'Team T-Force Z440 1TB', 10, 1500000.00, 3, 1000, NULL, 'Gen4 with Heatspreader', 'Team', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(88, 5, 'Samsung 870 EVO 500GB', 10, 850000.00, 1, 500, NULL, 'Best SATA SSD', 'Samsung', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(89, 5, 'WD Blue 2TB HDD', 10, 950000.00, 1, 2000, NULL, 'Standard HDD', 'WD', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(90, 5, 'Seagate SkyHawk 4TB', 10, 1600000.00, 1, 4000, NULL, 'Large Storage', 'Seagate', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(91, 5, 'Hikvision C100 240GB', 10, 280000.00, 1, 240, NULL, 'SSD SATA Budget', 'Hikvision', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(92, 5, 'Team Elite GX2 512GB', 10, 550000.00, 1, 512, NULL, 'SATA SSD Value', 'Team', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(93, 5, 'Kingston A400 960GB', 10, 980000.00, 1, 960, NULL, 'Budget Large SSD', 'Kingston', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(94, 5, 'Crucial MX500 1TB', 10, 1300000.00, 1, 1000, NULL, 'Reliable SATA SSD', 'Crucial', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(95, 5, 'Samsung 990 Pro 2TB', 10, 4200000.00, 3, 2000, NULL, 'Ultimate Gen4 SSD', 'Samsung', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(96, 5, 'WD Blue SN580 1TB', 10, 1100000.00, 1, 1000, NULL, 'Efficient Gen4', 'WD', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(97, 5, 'Seagate FireCuda 530 1TB', 10, 2500000.00, 3, 1000, NULL, 'Premium Gen4', 'Seagate', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(98, 5, 'Toshiba P300 1TB', 10, 650000.00, 1, 1000, NULL, 'HDD 7200RPM', 'Toshiba', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(99, 5, 'Kingston NV2 2TB', 10, 1750000.00, 1, 2000, NULL, 'Gen4 SSD Value', 'Kingston', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(100, 5, 'MSI Spatium M480 2TB', 10, 3800000.00, 3, 2000, NULL, 'Extreme Performance', 'MSI', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(101, 6, 'Deepcool DN450 80+', 10, 480000.00, 1, 0, NULL, 'Entry Level', 'Deepcool', NULL, NULL, 450, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(102, 6, 'FSP HV PRO 550W Bronze', 10, 650000.00, 1, 0, NULL, 'Solid Budget', 'FSP', NULL, NULL, 550, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(103, 6, 'Cooler Master MWE 550W', 10, 780000.00, 1, 0, NULL, 'Reliable Bronze', 'Cooler Master', NULL, NULL, 550, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(104, 6, 'MSI MAG A650BN', 10, 850000.00, 1, 0, NULL, 'Tier C Bronze', 'MSI', NULL, NULL, 650, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(105, 6, 'Corsair CV650 80+', 10, 950000.00, 1, 0, NULL, 'Standard PSU', 'Corsair', NULL, NULL, 650, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(106, 6, 'Corsair RM750e Gold', 10, 1850000.00, 3, 0, NULL, 'Full Modular ATX 3.0', 'Corsair', NULL, NULL, 750, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(107, 6, 'Asus ROG Loki 850W', 10, 3200000.00, 3, 0, NULL, 'Premium SFX PSU', 'Asus', NULL, NULL, 850, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(108, 6, 'Aerocool United 500W', 10, 520000.00, 1, 0, NULL, 'Budget White', 'Aerocool', NULL, NULL, 500, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(109, 6, 'Silverstone ST50F 500W', 10, 580000.00, 1, 0, NULL, 'Stable Entry', 'Silverstone', NULL, NULL, 500, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(110, 6, 'Deepcool PK650D', 10, 820000.00, 1, 0, NULL, 'Reliable Bronze', 'Deepcool', NULL, NULL, 650, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(111, 6, 'Seasonic B12 650W', 10, 1100000.00, 2, 0, NULL, 'High Reliability', 'Seasonic', NULL, NULL, 650, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(112, 6, 'Corsair RM650 Gold', 10, 1650000.00, 2, 0, NULL, 'Tier A Gold', 'Corsair', NULL, NULL, 650, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(113, 6, 'MSI MPG A750GF', 10, 1850000.00, 2, 0, NULL, 'Full Modular', 'MSI', NULL, NULL, 750, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(114, 6, 'Super Flower 750W Gold', 10, 1550000.00, 2, 0, NULL, 'Semi Modular', 'Super Flower', NULL, NULL, 750, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(115, 6, 'Seasonic Focus GX-750', 10, 2100000.00, 3, 0, NULL, 'Legendary Gold', 'Seasonic', NULL, NULL, 750, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(116, 6, 'MSI MPG A850G PCIE5', 10, 2400000.00, 3, 0, NULL, 'ATX 3.0 Gold', 'MSI', NULL, NULL, 850, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(117, 6, 'Asus ROG Thor 850P', 10, 4500000.00, 3, 0, NULL, 'OLED Platinum', 'Asus', NULL, NULL, 850, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(118, 6, 'Thermaltake GF3 1000W', 10, 2800000.00, 3, 0, NULL, 'High Wattage', 'Thermaltake', NULL, NULL, 1000, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(119, 6, 'FSP Hydro G Pro 1000W', 10, 2600000.00, 3, 0, NULL, 'Robust 1000W', 'FSP', NULL, NULL, 1000, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(120, 6, 'Corsair HX1200 Platinum', 10, 4800000.00, 3, 0, NULL, 'Extreme Power', 'Corsair', NULL, NULL, 1200, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(121, 7, 'Paradox Gaming Trickster', 10, 350000.00, 1, 0, NULL, 'Budget Case', 'Paradox', NULL, NULL, NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(122, 7, 'Cube Gaming Weiss', 10, 420000.00, 1, 0, NULL, 'Value Case', 'Cube', NULL, NULL, NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(123, 7, 'Tecware Forge M2', 10, 580000.00, 1, 0, NULL, 'Mesh Front', 'Tecware', NULL, NULL, NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(124, 7, 'DarkFlash DLM21 Mesh', 10, 650000.00, 1, 0, NULL, 'Compact Case', 'DarkFlash', NULL, NULL, NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(125, 7, 'Montech Air 100 Lite', 10, 680000.00, 1, 0, NULL, 'Solid Airflow', 'Montech', NULL, NULL, NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(126, 7, 'Deepcool CC560', 10, 750000.00, 1, 0, NULL, 'Standard ATX', 'Deepcool', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(127, 7, 'NZXT H5 Flow', 10, 1350000.00, 2, 0, NULL, 'Minimalist Flow', 'NZXT', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(128, 7, 'Lian Li O11 Dynamic', 10, 2600000.00, 3, 0, NULL, 'Aquarium King', 'Lian Li', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(129, 7, 'MSI MAG Forge 100R', 10, 950000.00, 1, 0, NULL, 'RGB ATX', 'MSI', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(130, 7, 'Corsair 4000D Airflow', 10, 1650000.00, 2, 0, NULL, 'Premium Airflow', 'Corsair', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(131, 7, 'Phanteks Eclipse G360A', 10, 1600000.00, 2, 0, NULL, 'Performance Case', 'Phanteks', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(132, 7, 'Be Quiet! Base 500DX', 10, 1850000.00, 2, 0, NULL, 'Silent & Cool', 'Be Quiet!', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(133, 7, 'NZXT H7 Flow', 10, 2200000.00, 3, 0, NULL, 'Large Airflow', 'NZXT', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(134, 7, 'Fractal Design North', 10, 2800000.00, 3, 0, NULL, 'Wooden Aesthetic', 'Fractal', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(135, 7, 'Hyte Y60', 10, 3500000.00, 3, 0, NULL, 'Panoramic View', 'Hyte', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(136, 7, 'Lian Li O11 EVO XL', 10, 450000.00, 3, 0, NULL, 'Massive Aesthetic', 'Lian Li', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(137, 7, 'Cooler Master HAF 700', 10, 8500000.00, 3, 0, NULL, 'Performance Beast', 'Cooler Master', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(138, 7, 'Asus ROG Helios', 10, 5500000.00, 3, 0, NULL, 'ROG Flagship', 'Asus', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(139, 7, 'Antec Torque', 10, 6200000.00, 3, 0, NULL, 'Open Frame', 'Antec', NULL, NULL, NULL, 'ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(140, 7, 'VenomRx Arasaka', 10, 480000.00, 1, 0, NULL, 'Local Value', 'VenomRx', NULL, NULL, NULL, 'M-ATX', '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(141, 8, 'Deepcool AG400', 10, 350000.00, 1, 0, NULL, 'Standard Air', 'Deepcool', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(142, 8, 'ID-Cooling SE-224-XTS', 10, 420000.00, 1, 0, NULL, 'Solid Air Cooler', 'ID-Cooling', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(143, 8, 'Noctua NH-D15 Black', 10, 1950000.00, 3, 0, NULL, 'Air Cooler King', 'Noctua', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(144, 8, 'NZXT Kraken 240 RGB', 10, 2300000.00, 3, 0, NULL, 'Premium AIO', 'NZXT', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(145, 8, 'Deepcool Gammaxx 400', 10, 280000.00, 1, 0, NULL, 'Classic Budget', 'Deepcool', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(146, 8, 'Thermalright Assassin King', 10, 450000.00, 1, 0, NULL, 'High Value Air', 'Thermalright', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(147, 8, 'Arctic Freezer 34 DUO', 10, 850000.00, 2, 0, NULL, 'Performance Air', 'Arctic', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(148, 8, 'Be Quiet! Dark Rock 4', 10, 1600000.00, 3, 0, NULL, 'Silent King', 'Be Quiet!', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(149, 8, 'ID-Cooling Zoomflow 240', 10, 980000.00, 1, 0, NULL, 'Entry AIO', 'ID-Cooling', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(150, 8, 'Deepcool LS520 240mm', 10, 1250000.00, 2, 0, NULL, 'Modern AIO', 'Deepcool', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(151, 8, 'Arctic Liquid Freezer 240', 10, 1750000.00, 3, 0, NULL, 'Performance AIO', 'Arctic', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(152, 8, 'Corsair H100x RGB', 10, 1650000.00, 2, 0, NULL, 'Standard RGB AIO', 'Corsair', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(153, 8, 'Lian Li Galahad II LCD', 10, 4800000.00, 3, 0, NULL, 'LCD Premium AIO', 'Lian Li', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(154, 8, 'Asus Ryujin III 360', 10, 6500000.00, 3, 0, NULL, 'The Ultimate AIO', 'Asus', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(155, 8, 'Cooler Master ML360L', 10, 1550000.00, 2, 0, NULL, 'Solid 360mm AIO', 'Cooler Master', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(156, 8, 'Thermalright Peerless Assassin', 10, 650000.00, 2, 0, NULL, 'Value Dual Tower', 'Thermalright', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(157, 8, 'Noctua NH-U12S Redux', 10, 950000.00, 2, 0, NULL, 'Silent Single Tower', 'Noctua', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(158, 8, 'MSI CoreLiquid M240', 10, 1350000.00, 2, 0, NULL, 'M-Series AIO', 'MSI', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(159, 8, 'Deepcool LT720 360mm', 10, 2100000.00, 3, 0, NULL, 'Top Tier 360 AIO', 'Deepcool', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11'),
(160, 8, 'ID-Cooling DASHFLOW 360', 10, 1850000.00, 2, 0, NULL, 'White Theme AIO', 'ID-Cooling', NULL, NULL, NULL, NULL, '2025-12-21 19:06:00', '2026-01-11 14:35:11');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `created_at` datetime DEFAULT current_timestamp(),
  `phone` varchar(20) DEFAULT NULL,
  `gender` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `role`, `created_at`, `phone`, `gender`, `dob`, `address`, `profile_pic`) VALUES
(1, 'RakaAdmin', '$2y$10$tnjGUDUJvzCVQiUnKygA9evA/ykqPReo3bYhq4NChqdbTdoP6TPkW', 'Nakeshya Raka', 'admin', '2025-12-29 15:23:55', NULL, NULL, NULL, NULL, NULL),
(4, 'RakaDesu', '$2y$10$m0OQ4josMA2aDJYcmlHBmOBatzmd.22pkymQfa1QEmq69cPZ87q2.', 'Nakeshya Raka', 'user', '2026-01-11 21:19:53', NULL, NULL, NULL, NULL, NULL),
(5, 'tutorial', '$2y$10$PjlgdkOvc4XUW2PgGmgNSurkN9QpHRUnbT99DJkGWoKA44UCaHRPu', 'Falaah Hamid', 'user', '2026-01-11 23:17:50', NULL, NULL, NULL, NULL, NULL),
(7, 'RRQFIFA', '$2y$10$IgbGIf2pAsw79lbD5r/naegkWpcx8F1DEBCZW0bemoMUTB.f7KUp2', 'Falaah Hamid', 'user', '2026-01-11 23:18:09', NULL, NULL, NULL, NULL, NULL),
(8, 'Relaska', '$2y$10$PLAi7Hb83FWSjbsn0xkq0.FTFAVfWK0ZyqAPPmAK6maXaGMF/SOsK', 'Relaska', 'user', '2026-01-12 14:26:06', NULL, NULL, NULL, NULL, NULL),
(10, 'BrodyJago', '$2y$10$vfD1M44XKnQf6CpJiv6YGe9p.ZWoG9jt.0ZfBxRp.W8o1KX2TxPAy', 'Brody', 'user', '2026-01-16 16:06:17', '87181201280192', 'Laki-laki', '2000-01-11', 'Jalan Pisangan Mangga ', NULL),
(11, '123456', '$2y$10$7RpwCVr1en8XDwoUnvElCO3dfSce4PYEaTUOF2sV3NXz3Ai7Bx1F.', 'Falaah Hamid', 'user', '2026-01-18 10:20:23', NULL, NULL, NULL, NULL, NULL),
(12, 'RAKA123', '$2y$10$1kMQQespIam9hPg/G95hse2NEolRtGZXFF44ExYrQ3pILo5t73ACO', 'RAKA', 'user', '2026-01-20 15:08:29', NULL, NULL, NULL, NULL, NULL),
(13, 'Onic', '$2y$10$prDuLxsXD3TWjqBpSpAuou5Ln26xTXYq5zd5AA9cVDqZPaH/oGp2u', 'Onic#7', 'user', '2026-01-26 14:29:24', NULL, 'Laki-laki', '2000-01-14', NULL, '1769413266_557199e10d44a0852fd6.jpg');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `builds`
--
ALTER TABLE `builds`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `build_items`
--
ALTER TABLE `build_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `build_id` (`build_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `builds`
--
ALTER TABLE `builds`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `build_items`
--
ALTER TABLE `build_items`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `build_items`
--
ALTER TABLE `build_items`
  ADD CONSTRAINT `build_items_ibfk_1` FOREIGN KEY (`build_id`) REFERENCES `builds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `build_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

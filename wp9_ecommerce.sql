-- MySQL dump 10.13  Distrib 5.7.24, for osx11.1 (x86_64)
--
-- Host: localhost    Database: wp9_ecommerce
-- ------------------------------------------------------
-- Server version	9.5.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED='cf470e0a-ea3a-11f0-b2d0-e820e622f772:1-70';

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `category` varchar(60) NOT NULL DEFAULT 'Serum',
  `image_url` varchar(500) DEFAULT NULL,
  `image_filename` varchar(255) DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `name`, `description`, `price`, `created_at`, `category`, `image_url`, `image_filename`) VALUES (8,'SKIN1004 - Madagascar Centella Hyalu-Cica Water-Fit Sun Serum','Fitted with SPF50+ PA++++, this organic sunscreen is made with a golden ratio of hyaluronic acid and centella asiatica extract to soothe and hydrate skin without leaving a white cast.',9.36,'2026-01-12 11:48:44','Sunscreen',NULL,'XXL_p0175333259.jpg.webp'),(9,'numbuzin - No.9 NAD+ PDRN Glow Boosting Toner','With NAD+, salmon PDRN and 50 types of peptides, this toner boosts skin elasticity and revitalizes skin to reveal a radiant glow from within. The formula’s all-natural violet, shimmery hue is derived from Vitamin B12 and ceramides.',16.00,'2026-01-12 11:50:45','Toner',NULL,'XXL_p0219611591.jpg.webp'),(10,'medicube - PDRN Pink Niacinamide Milky Toner','medicube offers solutions for sensitive and acne-prone skin through its different product lines targeting skin concerns like dryness, dullness and pore care. ',19.69,'2026-01-12 11:52:07','Toner',NULL,'XXL_p0218112396.jpg.webp'),(11,'Anua - Rice 70 Glow Milky Toner','This nourishing toner is anchored in rice bran water and niacinamide to brighten skin, plus ceramide NP and sodium hyaluronate to up moisture levels. all skin types',14.30,'2026-01-12 11:53:53','Toner',NULL,'XXL_p0218879045.jpg.webp'),(12,'SOME BY MI - AHA, BHA, PHA 30 Days Miracle Toner 150ml','This toner works wonder on your skin in just 30 days! Suitable for sensitive and acne-prone skin, the toner is infused with AHA to slough off dead skin cells, BHA to remove excess sebum, PHA to prevent moisture loss, and tea tree to combat acne.',16.66,'2026-01-12 11:54:55','Toner',NULL,'XXL_p0089879932.jpg.webp'),(13,'Purito SEOUL - Wonder Releaf Centella Toner Unscented','Formerly the Centella Unscented Toner, this newly repackaged version of PURITO’s beloved formula is anchored in cica, panthenol and sodium hyaluronate to calm irritation, lock in moisture and strengthen the skin barrier. The clinically tested product is fragrance-free.',12.51,'2026-01-12 11:56:13','Toner',NULL,'XXL_p0205087591.png.webp'),(14,'celimax - Dual Barrier Creamy Toner','Coming in a milky formula, this vegan toner is infused with ceramides, aquatide and panthenol to boost skin’s moisture levels and promote healthy skin barrier function. Suitable for dry and sensitive skin.',16.80,'2026-01-12 11:57:12','Toner',NULL,'XXL_p0147677597.jpg.webp'),(15,'Anua - Niacinamide 10 TXA TXA 4 Serum - Siero Viso Illuminante Anti-Macchie',' With a mighty brightening combo of 10% niacinamide and 4% tranexamic acid, the serum is serious about banishing dark spots and post-acne marks.',18.98,'2026-01-13 10:48:22','Serum',NULL,'XXL_p0202543058.jpg'),(16,'Dr. Althea - Vitamin C Boosting Serum','The vegan formula contains eight types of hyaluronic acid to keep hydration levels high, as well as allantoin and tocopherol to combat signs of aging.',17.27,'2026-01-13 10:52:49','Serum',NULL,'XXL_p0201258393.png.webp'),(17,'d\'Alba - White Truffle First Spray Serum','Eight plant-derived oils in the formula keep skin nourished and moisturized all day. Shake well before use. Spray after cleansing skin to lock in moisture, or before makeup to get that dewy base. Suitable for sensitive skin.',26.00,'2026-01-13 10:57:27','Serum',NULL,'XXL_p0220007693.jpg.webp'),(18,'COSRX - The 6 Peptide Skin Booster','This do-it-all serum is infused with 6 Peptide Complex to enhance skin elasticity and refine skin texture while providing pore care. ',21.00,'2026-01-13 10:59:38','Serum',NULL,'XXL_p0220018315.jpg.webp'),(19,'JUMISO - Niacinamide 20 Serum','Packed with brightening agents like niacinamide, tranexamic acid and glutathione, this serum combats hyperpigmentation and uneven skin tone for clear and radiant skin',14.39,'2026-01-13 11:01:57','Serum',NULL,'XXL_p0220175856.jpg.webp'),(20,'kr-flag numbuzin - No.5+ Glutathione Vitamin Concentrated Serum','Revitalize dull skin with this serum packed with antioxidant-rich vitamins to help restore skin’s natural glow. Additional brightening agents including glutathione, niacinamide and alpha-arbutin offer a major radiance boost.',18.00,'2026-01-13 11:03:23','Serum',NULL,'XXL_p0198508660.jpg.webp'),(21,'SKIN1004 - Madagascar Centella Poremizing Deep Cleansing Foam','Featuring papain and kaolin powder to buff away dead skin cells and refine rough skin texture. Can use on sensitive skin',8.88,'2026-01-13 13:08:44','Cleanser',NULL,'XXL_p0180240777.jpg.webp'),(22,'Anua - 8 Hyaluronic Acid Hydrating Gentle Foaming Cleanser','Formulated with eight types of hyaluronic acid to moisturize skin as well as panthenol to strengthen the skin barrier, this foaming cleanser delivers superb cleansing power while producing a well-hydrated finish. ',11.98,'2026-01-13 13:10:44','Cleanser',NULL,'XXL_p0209734752.jpg.webp'),(23,'APLB - Glutathione Niacinamide Facial Cleanser','Cleanse away impurities on skin with this facial cleanser. It contains glutathione, niacinamide, hydrolyzed collagen and squalane to improve skin elasticity and brighten skin.',8.80,'2026-01-13 13:12:04','Cleanser',NULL,'XXL_p0196016931.jpg.webp'),(24,'medicube - PDRN Pink Collagen Capsule Cream','This elasticity-boosting capsule cream containing salmon PDRN, collagen and niacinamide evens out skin tone, firms sagging skin and strengthens the skin barrier. The gentle and non-comedogenic product is suitable for all skin types including sensitive and acne-prone skin.',20.55,'2026-01-13 13:13:44','Moisturizer',NULL,'XXL_p0217815190.jpg.webp'),(25,'medicube - PDRN Pink Collagen Gel Mask Set','Collagen gel mask packed with elasticity-boosting ingredients such as Salmon PDRN, hydrolyzed collagen and peptides reduce fine lines and wrinkles and smooth skin texture. The gel mask’s soft gel texture tightly hugs the face while delivering hydrating and cooling effects. This product is hypoallergenic and safe to use on sensitive skin.',18.82,'2026-01-13 13:15:50','Mask',NULL,'L_p0217436747.png.webp'),(26,'Anua - YesStyle Exclusive Double Cleansing Duo Set','No more excuses! It’s time to take your double cleansing routine seriously with Anua’s duo that’s perfect for sensitive and acne-prone skin.',25.24,'2026-01-13 13:18:22','Cleanser',NULL,'XXL_p0221142610.jpg.webp'),(27,'Beauty of Joseon - Matte Sun Stick','Those who prefer to use sun protection in a fuss-free sun stick format will love this version from Beauty of Joseon fitted with SPF50 PA++++.',14.40,'2026-01-13 13:20:56','Sunscreen',NULL,'XXL_p0188313813.jpg.webp'),(28,'Dr.Melaxin - Peel Shot Exfoliating Black Rice Ampoule','his ampoule removes blackheads, unclogs pores and regulates sebum production while boosting skin radiance. It’s enriched with rice bran water and PENTAVITIN to gently exfoliate skin for a smooth and supple finish.',18.71,'2026-01-13 13:22:49','Serum',NULL,'XXL_p0212878750.jpg.webp'),(29,'Purito SEOUL - Mighty Bamboo Panthenol Cream','Repair a damaged skin barrier with this rich cream infused with Korean Damyang bamboo extract and 100,000ppm of soothing panthenol. ',9.81,'2026-01-13 13:44:02','Moisturizer',NULL,'XXL_p0211004986.png.webp'),(30,'Beauty of Joseon - Red Bean Water Gel','This lightweight water gel easily absorbs into skin to refresh and hydrate. Ideal for oily skin, it maintains skin’s water-oil balance by absorbing sebum with 44% red bean extract. Also infused with peptide complex to improve wrinkles',16.20,'2026-01-13 13:48:53','Moisturizer',NULL,'XXL_p0184489867.jpg.webp'),(31,'SKIN1004 - Madagascar Centella Probio-Cica Enrich Cream Bundle Set','Formulated with macadamia ternifolia seed oil and moringa oleifera seed oil, the cream moisturizes dry skin. Fragrance-free formula is safe to use on sensitive skin.',20.61,'2026-01-13 13:50:02','Moisturizer',NULL,'XXL_p0219527684.jpg.webp'),(32,'kr-flag Beauty of Joseon - Relief Sun Aqua-fresh','The chemical sunscreen boasts SPF 50+ PA++++ sun protection. It’s formulated with 30% rice seed water, along with colloidal oatmeal and panthenol to soothe and revitalize skin. Suitable for all skin types.',14.40,'2026-01-13 13:51:47','Sunscreen',NULL,'XXL_p0211178027.jpg.webp');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (6,'Admin','admin@gmail.com','scrypt:32768:8:1$8MOLsK9p7UUEXVPm$bb30ecd66707e368dcd7d03e5244537bc66be6b11d83fca2783d457ea59ccb63ecd13ebce84477aa100d62dcbae348c5c00b4366bd5fb3a145f9bad8f3eb75e9','admin','2026-01-10 18:01:36'),(7,'USER1 ','user1@gmail.com','scrypt:32768:8:1$8uLqsqAaWBmzsEyg$6329de5172f654caf3317da2ac2959395e1bc960175b3900930eaa20dd85c7068fd9e2a58ac8090f1852cfa7da03ad774a635203cb26c8fe75df1176301c17a8','user','2026-01-10 18:02:25'),(8,'user','user@gmail.com','scrypt:32768:8:1$lAzwzFr5MIsvFxLb$935704553d54c9d61110cbbe06384047cf74c9a32ef4045593c1ed50432a574c57372d67b28daf81b3fd0e10ec92f7fced2081f9a1639744b76c08a7f171921f','user','2026-01-12 10:35:17'),(9,'meruyert','meruert@gmail.com','scrypt:32768:8:1$xL97a0mjBHtcgMlz$8b100984e90d69d0f0e0e948c1a8f8f475d13c41c2d1321eeb625b5afc6937f4643fcaf5d730b120f737d59b8837fe22ed583254ab51b197e3d3a65ce29de1bb','user','2026-01-13 12:13:28'),(10,'a_utegenova','aygerim@mail.com','scrypt:32768:8:1$k6nbFg6kULn00mWX$1958a2e5706b0f909d58715a63d91a984d853419568a8bb33b4c0c97bdec3bf84e0e2383539a860374e682fc81929eacc29f3644531f791b0308770201cfebb0','user','2026-02-01 16:27:07');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-14  0:10:19

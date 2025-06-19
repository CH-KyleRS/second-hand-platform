-- MySQL dump 10.13  Distrib 8.3.0, for Win64 (x86_64)
--
-- Host: localhost    Database: x-mall
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `link_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系人',
  `link_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系地址',
  `link_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `user_id` bigint DEFAULT NULL COMMENT '所属用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='收货地址';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (7,'feng','雁栖湖校区西区','123456789',25),(8,'huang','雁栖湖校区东区','1398888777',27),(9,'zhang','雁栖湖校区西区','1398888777',28);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片地址',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联url',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='轮播图';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES (6,'http://localhost:9999/files/1748244350406','#'),(7,'http://localhost:9999/files/1748244339631','#'),(8,'http://localhost:9999/files/1748243836387','#毕业季 ');
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `goods_id` bigint DEFAULT NULL COMMENT '商品id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `count` int DEFAULT NULL COMMENT '商品数量',
  `create_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `goods_user` (`goods_id`,`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='购物车';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (12,38,25,1,'2025-06-17 03:43:03');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类名称',
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分类编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (10,'二手图书','1'),(11,'数码产品','2'),(12,'学习文具','3'),(14,'体育用品','5'),(16,'生活用品','4');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect`
--

DROP TABLE IF EXISTS `collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collect` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品图片',
  `goods_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品id',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户id',
  `create_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect`
--

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;
INSERT INTO `collect` VALUES (9,'计算机体系机构','http://localhost:9999/files/1749987963232','39','25','2025-06-15 19:59:22'),(10,'骑行头盔','http://localhost:9999/files/1748244802391','37','27','2025-06-16 16:46:15'),(11,'骑行头盔','http://localhost:9999/files/1748244802391','37','28','2025-06-16 16:55:44'),(12,'骑行头盔','http://localhost:9999/files/1748244802391','37','25','2025-06-16 22:08:24');
/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品描述',
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品编号',
  `price` decimal(10,2) DEFAULT NULL COMMENT '原价',
  `discount` double(10,2) DEFAULT NULL COMMENT '折扣',
  `store` int DEFAULT NULL COMMENT '库存',
  `praise` int DEFAULT '0' COMMENT '点赞数',
  `sales` int DEFAULT '0' COMMENT '销量',
  `category_id` bigint DEFAULT NULL COMMENT '分类id',
  `imgs` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品图片',
  `create_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建时间',
  `recommend` tinyint(1) DEFAULT NULL COMMENT '是否推荐：0不推荐，1推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (36,'C++ premier plus','清华大学出版社 学期结束出书','40',79.00,0.20,6,1,1,10,'[\"http://localhost:9999/files/1749998256691\"]','2025-05-26 15:07:05',0),(37,'骑行头盔','CIGNA骑行头盔 无磕碰','37',120.00,0.50,4,0,3,14,'[\"http://localhost:9999/files/1748244802391\"]','2025-05-26 15:33:24',1),(38,'教父2','人民文学出版社',NULL,100.00,0.15,9,0,1,10,'[\"http://localhost:9999/files/1749987813098\"]','2025-06-15 19:43:34',NULL),(39,'计算机体系机构','胡伟武老师版','39',50.00,0.50,8,1,0,10,'[\"http://localhost:9999/files/1749987963232\"]','2025-06-15 19:47:01',1),(40,'数字集成电路测试','99新','40',59.00,0.20,7,0,0,10,'[\"http://localhost:9999/files/1749998514503\"]','2025-06-15 22:42:27',1),(41,'钢笔','百乐钢笔','41',200.00,0.50,4,0,0,12,'[\"http://localhost:9999/files/1750006400425\"]','2025-06-16 00:53:24',1),(42,'足球鞋','adidas足球鞋','42',300.00,0.60,3,0,0,14,'[\"http://localhost:9999/files/1750006441250\"]','2025-06-16 00:54:05',NULL),(43,'网球拍','迪卡侬网球拍 2024年购入，保存良好','43',200.00,0.75,4,0,1,14,'[\"http://localhost:9999/files/1750006496045\"]','2025-06-16 00:54:59',1),(44,'iphone12','2022年购买，背板有裂痕','44',5000.00,0.10,1,0,2,11,'[\"http://localhost:9999/files/1750006553987\"]','2025-06-16 00:55:55',1),(45,'键盘','雷蛇机械键盘','44',288.00,0.40,3,0,0,11,'[\"http://localhost:9999/files/1750006620144\",\"http://localhost:9999/files/1750006651058\"]','2025-06-16 00:57:33',1),(46,'无线耳机','雷蛇无线耳机 粉色','45',360.00,0.30,3,0,0,11,'[\"http://localhost:9999/files/1750006713108\"]','2025-06-16 00:58:34',NULL),(47,'无线鼠标','雷蛇蝰蛇v2专业版 白色','46',500.00,0.40,3,0,0,11,'[\"http://localhost:9999/files/1750006787577\"]','2025-06-16 00:59:49',1),(48,'回形针','多余的回形针，已开封','47',5.00,0.20,4,0,0,12,'[\"http://localhost:9999/files/1750006849194\"]','2025-06-16 01:00:50',NULL),(49,'文件袋','国科大文件袋','49',6.00,0.50,6,0,0,12,'[\"http://localhost:9999/files/1750006901339\"]','2025-06-16 01:01:42',NULL),(50,'签字笔','全新黑色签字笔',NULL,5.00,0.20,4,0,0,12,'[\"http://localhost:9999/files/1750064278813\"]','2025-06-16 16:58:01',NULL);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_goods`
--

DROP TABLE IF EXISTS `order_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_goods` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `order_id` bigint DEFAULT NULL COMMENT '订单id',
  `goods_id` bigint DEFAULT NULL COMMENT '商品id',
  `count` int DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='订单商品关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_goods`
--

LOCK TABLES `order_goods` WRITE;
/*!40000 ALTER TABLE `order_goods` DISABLE KEYS */;
INSERT INTO `order_goods` VALUES (18,12,35,1),(19,12,32,1),(20,13,26,1),(21,14,37,1),(22,15,36,1),(23,17,38,1),(24,18,43,1),(25,19,37,1),(26,20,37,1),(27,21,44,1),(28,22,44,1);
/*!40000 ALTER TABLE `order_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_log`
--

DROP TABLE IF EXISTS `t_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作人',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ip',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_log`
--

LOCK TABLES `t_log` WRITE;
/*!40000 ALTER TABLE `t_log` DISABLE KEYS */;
INSERT INTO `t_log` VALUES (307,'用户 admin 登录系统','2022-12-02 11:36:44','admin','127.0.0.1'),(308,'更新用户：tom ','2022-12-02 11:46:21','tom','0:0:0:0:0:0:0:1'),(309,'用户 fw 注册账号成功','2025-05-26 12:33:28','fw','0:0:0:0:0:0:0:1'),(310,'用户 fw 登录系统','2025-05-26 12:33:42','fw','0:0:0:0:0:0:0:1'),(311,'用户 fw 登录系统','2025-05-26 13:48:11','fw','0:0:0:0:0:0:0:1'),(312,'用户 fw 登录系统','2025-05-26 13:54:01','fw','0:0:0:0:0:0:0:1'),(313,'用户 fw 登录系统','2025-05-26 14:05:34','fw','0:0:0:0:0:0:0:1'),(314,'用户 admin 登录系统','2025-05-26 14:38:28','admin','0:0:0:0:0:0:0:1'),(315,'用户 fw 登录系统','2025-05-26 14:43:12','fw','0:0:0:0:0:0:0:1'),(316,'用户 admin 登录系统','2025-05-26 14:44:23','admin','0:0:0:0:0:0:0:1'),(317,'用户 fw 登录系统','2025-05-26 15:34:46','fw','0:0:0:0:0:0:0:1'),(318,'用户 admin 登录系统','2025-05-26 16:00:11','admin','0:0:0:0:0:0:0:1'),(319,'用户 fw 登录系统','2025-05-26 16:09:41','fw','0:0:0:0:0:0:0:1'),(320,'用户 admin 登录系统','2025-05-26 16:14:39','admin','0:0:0:0:0:0:0:1'),(321,'用户 fw 登录系统','2025-05-26 17:37:58','fw','0:0:0:0:0:0:0:1'),(322,'用户 admin 登录系统','2025-05-26 17:40:54','admin','0:0:0:0:0:0:0:1'),(323,'用户 fw 登录系统','2025-05-26 17:41:09','fw','0:0:0:0:0:0:0:1'),(324,'用户 admin 登录系统','2025-05-26 19:26:53','admin','0:0:0:0:0:0:0:1'),(325,'用户 admin 登录系统','2025-05-26 21:03:07','admin','0:0:0:0:0:0:0:1'),(326,'删除用户 tom ','2025-05-26 21:08:03','admin','0:0:0:0:0:0:0:1'),(327,'删除用户 hello ','2025-05-26 21:08:07','admin','0:0:0:0:0:0:0:1'),(328,'删除用户 jack ','2025-05-26 21:08:09','admin','0:0:0:0:0:0:0:1'),(329,'删除用户 jerry ','2025-05-26 21:08:19','admin','0:0:0:0:0:0:0:1'),(330,'更新用户：fw ','2025-05-26 21:09:17','admin','0:0:0:0:0:0:0:1'),(331,'更新用户：Tom ','2025-05-26 21:10:36','admin','0:0:0:0:0:0:0:1'),(332,'更新用户：Tom ','2025-05-26 21:10:44','admin','0:0:0:0:0:0:0:1'),(333,'用户 fw 登录系统','2025-05-27 01:24:28','fw','0:0:0:0:0:0:0:1'),(334,'用户 admin 登录系统','2025-05-27 01:31:19','admin','0:0:0:0:0:0:0:1'),(335,'用户 fw 登录系统','2025-06-15 16:00:03','fw','0:0:0:0:0:0:0:1'),(336,'用户 fw 登录系统','2025-06-15 16:29:44','fw','0:0:0:0:0:0:0:1'),(337,'用户 admin 登录系统','2025-06-15 16:30:27','admin','0:0:0:0:0:0:0:1'),(338,'用户 admin 登录系统','2025-06-15 16:30:44','admin','0:0:0:0:0:0:0:1'),(339,'更新角色：普通用户','2025-06-15 16:31:17','admin','0:0:0:0:0:0:0:1'),(340,'更新角色：普通用户','2025-06-15 16:31:39','admin','0:0:0:0:0:0:0:1'),(341,'更新角色：普通用户','2025-06-15 16:31:44','admin','0:0:0:0:0:0:0:1'),(342,'更新角色：普通用户','2025-06-15 16:31:47','admin','0:0:0:0:0:0:0:1'),(343,'用户 fw 登录系统','2025-06-15 16:46:58','fw','0:0:0:0:0:0:0:1'),(344,'用户 admin 登录系统','2025-06-15 16:47:13','admin','0:0:0:0:0:0:0:1'),(345,'更新用户：fw ','2025-06-15 16:47:27','admin','0:0:0:0:0:0:0:1'),(346,'更新用户：fw ','2025-06-15 16:47:28','admin','0:0:0:0:0:0:0:1'),(347,'更新用户：fw ','2025-06-15 16:47:30','admin','0:0:0:0:0:0:0:1'),(348,'更新用户：fw ','2025-06-15 16:47:31','admin','0:0:0:0:0:0:0:1'),(349,'用户 fw 登录系统','2025-06-15 16:48:16','fw','0:0:0:0:0:0:0:1'),(350,'用户 fw 登录系统','2025-06-15 17:07:48','fw','0:0:0:0:0:0:0:1'),(351,'用户 admin 登录系统','2025-06-15 17:08:11','admin','0:0:0:0:0:0:0:1'),(352,'更新角色：普通用户','2025-06-15 17:08:42','admin','0:0:0:0:0:0:0:1'),(353,'更新角色：普通用户','2025-06-15 17:08:44','admin','0:0:0:0:0:0:0:1'),(354,'更新角色：普通用户','2025-06-15 17:08:45','admin','0:0:0:0:0:0:0:1'),(355,'更新角色：普通用户','2025-06-15 17:08:46','admin','0:0:0:0:0:0:0:1'),(356,'更新角色：普通用户','2025-06-15 17:08:48','admin','0:0:0:0:0:0:0:1'),(357,'更新角色：普通用户','2025-06-15 17:08:49','admin','0:0:0:0:0:0:0:1'),(358,'更新角色：普通用户','2025-06-15 17:08:51','admin','0:0:0:0:0:0:0:1'),(359,'用户 fw 登录系统','2025-06-15 17:09:14','fw','0:0:0:0:0:0:0:1'),(360,'用户 admin 登录系统','2025-06-15 17:17:42','admin','0:0:0:0:0:0:0:1'),(361,'更新角色：普通用户','2025-06-15 17:19:31','admin','0:0:0:0:0:0:0:1'),(362,'更新角色：普通用户','2025-06-15 17:19:32','admin','0:0:0:0:0:0:0:1'),(363,'更新角色：普通用户','2025-06-15 17:19:32','admin','0:0:0:0:0:0:0:1'),(364,'更新角色：普通用户','2025-06-15 17:19:42','admin','0:0:0:0:0:0:0:1'),(365,'更新角色：普通用户','2025-06-15 17:19:43','admin','0:0:0:0:0:0:0:1'),(366,'更新角色：普通用户','2025-06-15 17:19:51','admin','0:0:0:0:0:0:0:1'),(367,'更新角色：普通用户','2025-06-15 17:19:55','admin','0:0:0:0:0:0:0:1'),(368,'用户 fw 登录系统','2025-06-15 17:20:07','fw','0:0:0:0:0:0:0:1'),(369,'用户 admin 登录系统','2025-06-15 19:36:44','admin','0:0:0:0:0:0:0:1'),(370,'用户 fw 登录系统','2025-06-15 19:41:05','fw','0:0:0:0:0:0:0:1'),(371,'用户 admin 登录系统','2025-06-15 19:45:23','admin','0:0:0:0:0:0:0:1'),(372,'用户 fw 登录系统','2025-06-15 19:47:46','fw','0:0:0:0:0:0:0:1'),(373,'用户 fw 登录系统','2025-06-15 19:59:13','fw','0:0:0:0:0:0:0:1'),(374,'用户 admin 登录系统','2025-06-15 20:13:33','admin','0:0:0:0:0:0:0:1'),(375,'用户 fw 登录系统','2025-06-15 20:21:11','fw','0:0:0:0:0:0:0:1'),(376,'用户 fw 登录系统','2025-06-15 21:31:57','fw','0:0:0:0:0:0:0:1'),(377,'更新用户账户：fw ','2025-06-15 22:09:57','fw','0:0:0:0:0:0:0:1'),(378,'用户 admin 登录系统','2025-06-16 00:13:09','admin','0:0:0:0:0:0:0:1'),(379,'用户 admin 登录系统','2025-06-16 01:02:39','admin','0:0:0:0:0:0:0:1'),(380,'更新用户：admin ','2025-06-16 01:28:22','admin','0:0:0:0:0:0:0:1'),(381,'用户 fw 登录系统','2025-06-16 01:29:31','fw','0:0:0:0:0:0:0:1'),(382,'用户 fw 登录系统','2025-06-16 14:43:26','fw','0:0:0:0:0:0:0:1'),(383,'用户 fw 登录系统','2025-06-16 14:43:51','fw','0:0:0:0:0:0:0:1'),(384,'用户 admin 登录系统','2025-06-16 14:53:00','admin','0:0:0:0:0:0:0:1'),(385,'更新用户：fw ','2025-06-16 14:56:31','admin','0:0:0:0:0:0:0:1'),(386,'用户 fw 登录系统','2025-06-16 14:59:45','fw','0:0:0:0:0:0:0:1'),(387,'用户 admin 登录系统','2025-06-16 15:25:29','admin','0:0:0:0:0:0:0:1'),(388,'更新用户：fw ','2025-06-16 15:25:55','admin','0:0:0:0:0:0:0:1'),(389,'用户 wang 注册账号成功','2025-06-16 16:41:54','wang','0:0:0:0:0:0:0:1'),(390,'用户 wang 登录系统','2025-06-16 16:42:05','wang','0:0:0:0:0:0:0:1'),(391,'用户 huang 注册账号成功','2025-06-16 16:44:55','huang','0:0:0:0:0:0:0:1'),(392,'用户 huang 登录系统','2025-06-16 16:45:06','huang','0:0:0:0:0:0:0:1'),(393,'用户 fw 登录系统','2025-06-16 16:46:58','fw','0:0:0:0:0:0:0:1'),(394,'用户 huang 登录系统','2025-06-16 16:51:10','huang','0:0:0:0:0:0:0:1'),(395,'用户 admin 登录系统','2025-06-16 16:52:44','admin','0:0:0:0:0:0:0:1'),(396,'用户 zhang 注册账号成功','2025-06-16 16:54:35','zhang','0:0:0:0:0:0:0:1'),(397,'用户 zhang 登录系统','2025-06-16 16:54:43','zhang','0:0:0:0:0:0:0:1'),(398,'用户 fw 登录系统','2025-06-16 16:56:18','fw','0:0:0:0:0:0:0:1'),(399,'用户 admin 登录系统','2025-06-16 16:58:36','admin','0:0:0:0:0:0:0:1'),(400,'用户 zhang 登录系统','2025-06-16 17:10:17','zhang','0:0:0:0:0:0:0:1'),(401,'用户 fw 登录系统','2025-06-16 22:00:54','fw','0:0:0:0:0:0:0:1'),(402,'用户 zhang 登录系统','2025-06-16 23:18:05','zhang','0:0:0:0:0:0:0:1'),(403,'用户 admin 登录系统','2025-06-17 01:16:39','admin','0:0:0:0:0:0:0:1'),(404,'用户 fw 登录系统','2025-06-17 01:21:38','fw','0:0:0:0:0:0:0:1'),(405,'用户 zhang 登录系统','2025-06-17 01:39:52','zhang','0:0:0:0:0:0:0:1'),(406,'更新用户：zhang ','2025-06-17 01:40:30','zhang','0:0:0:0:0:0:0:1'),(407,'更新用户：fw ','2025-06-17 01:45:28','fw','0:0:0:0:0:0:0:1'),(408,'删除用户 huang ','2025-06-17 01:49:15','admin','0:0:0:0:0:0:0:1'),(409,'用户 Tom 登录系统','2025-06-17 01:50:37','Tom','0:0:0:0:0:0:0:1'),(410,'用户 fw 登录系统','2025-06-17 03:41:11','fw','0:0:0:0:0:0:0:1'),(411,'用户 admin 登录系统','2025-06-17 03:47:17','admin','0:0:0:0:0:0:0:1'),(412,'用户 admin 登录系统','2025-06-17 03:47:21','admin','0:0:0:0:0:0:0:1'),(413,'用户 admin 登录系统','2025-06-17 03:47:51','admin','0:0:0:0:0:0:0:1'),(414,'用户 admin 登录系统','2025-06-17 03:47:51','admin','0:0:0:0:0:0:0:1'),(415,'用户 admin 登录系统','2025-06-17 03:51:59','admin','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `t_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_message`
--

DROP TABLE IF EXISTS `t_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '内容',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论人',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '评论时间',
  `parent_id` bigint DEFAULT NULL COMMENT '父ID',
  `foreign_id` bigint DEFAULT '0' COMMENT '关联id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='留言表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_message`
--

LOCK TABLES `t_message` WRITE;
/*!40000 ALTER TABLE `t_message` DISABLE KEYS */;
INSERT INTO `t_message` VALUES (1,'保存良好','fw','2025-05-26 17:38:40',NULL,26),(3,'很好的商品','zhang','2025-06-17 01:19:06',NULL,44);
/*!40000 ALTER TABLE `t_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_notice`
--

DROP TABLE IF EXISTS `t_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_notice`
--

LOCK TABLES `t_notice` WRITE;
/*!40000 ALTER TABLE `t_notice` DISABLE KEYS */;
INSERT INTO `t_notice` VALUES (6,'收显示器','收一个2k显示器','2025-06-16 14:56:01'),(7,'收自行车','雁栖湖校区收一辆公路车，车况良好','2025-06-17 01:32:37'),(8,'收一包烟','如题，什么都可以','2025-06-17 02:40:25');
/*!40000 ALTER TABLE `t_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order`
--

DROP TABLE IF EXISTS `t_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '序号',
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单编号',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总价',
  `user_id` bigint DEFAULT NULL COMMENT '下单人id',
  `link_user` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系人',
  `link_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `link_address` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '送货地址',
  `state` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '待付款' COMMENT '状态',
  `create_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order`
--

LOCK TABLES `t_order` WRITE;
/*!40000 ALTER TABLE `t_order` DISABLE KEYS */;
INSERT INTO `t_order` VALUES (20,'20250616165559608737',60.00,28,'zhang','1398888777','雁栖湖校区西区','已完成','2025-06-16 16:55:59'),(22,'20250617011727466354',500.00,28,'zhang','1398888777','雁栖湖校区西区','已完成','2025-06-17 01:17:27');
/*!40000 ALTER TABLE `t_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_permission`
--

DROP TABLE IF EXISTS `t_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '描述',
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '菜单路径',
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT 's-data' COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='权限菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_permission`
--

LOCK TABLES `t_permission` WRITE;
/*!40000 ALTER TABLE `t_permission` DISABLE KEYS */;
INSERT INTO `t_permission` VALUES (1,'首页','首页','/home','s-home'),(2,'用户管理','用户管理','/user','user-solid'),(3,'角色管理','角色管理','/role','s-cooperation'),(4,'菜单管理','菜单管理','/permission','menu'),(5,'求购管理','求购管理','/notice','data-board'),(6,'日志管理','日志管理','/log','notebook-2'),(8,'轮播图管理','轮播图管理','/banner','picture'),(9,'商品分类管理','商品分类管理','/category','tickets'),(11,'商品管理','商品管理','/goods','s-goods'),(12,'订单管理','订单管理','/order','s-data'),(13,'收货地址管理','收货地址管理','/address','s-data');
/*!40000 ALTER TABLE `t_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role`
--

DROP TABLE IF EXISTS `t_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '描述',
  `permission` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '权限列表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role`
--

LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` VALUES (1,'超级管理员','所有权限','[1,2,3,4,5,6,8,9,11,12,13]'),(2,'普通用户','部分权限','[1,5,11,12]');
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `age` int DEFAULT NULL COMMENT '年龄',
  `account` decimal(10,2) DEFAULT NULL COMMENT '账户余额',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `username` (`username`,`nick_name`,`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'admin','admin','管理员','111124444','13978786565','1622102316280','[1]','北京',20,0.00),(24,'Tom','123456','huahua','1234@mail.com','呼呼','1645016842715','[2]','中关村校区',22,0.00),(25,'fw','123456','vivi','1234@qq,com','123456789','1750095928580','[2]','雁栖湖校区西区',20,5659.20),(26,'wang','123456',NULL,NULL,'123456789',NULL,'[2]',NULL,NULL,0.00),(28,'zhang','123456',NULL,NULL,'139888777','1750095630239','[2]',NULL,NULL,-1060.00);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-18 18:32:58

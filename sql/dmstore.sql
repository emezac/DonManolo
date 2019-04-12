-- MySQL dump 10.11
--
-- Host: localhost    Database: dmstore
-- ------------------------------------------------------
-- Server version	5.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL auto_increment,
  `code` int(11) NOT NULL default '0',
  `description` varchar(50) NOT NULL,
  `tipo` char(1) default 'A',
  `category` char(1) default NULL,
  `customer_vendor` char(1) default NULL,
  `link` varchar(30) default NULL,
  `gifi` varchar(20) default NULL,
  `debit` decimal(9,2) default NULL,
  `credit` decimal(9,2) default NULL,
  `parent_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `accounts_ibfk_parent_id` (`parent_id`),
  CONSTRAINT `accounts_ibfk_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=970029 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (100,100,'ASSETS','G','A','',NULL,'',NULL,NULL,NULL),(200,200,'LIABILITIES','G','L','',NULL,'',NULL,NULL,NULL),(300,300,'EQUITY','G','Q','',NULL,'',NULL,NULL,NULL),(400,400,'REVENUE','G','I','',NULL,'',NULL,NULL,NULL),(500,500,'EXPENSES','G','E','',NULL,'',NULL,NULL,NULL),(1000,1000,'CURRENT ASSETS','H','A',NULL,'','',NULL,NULL,100),(1060,1060,'Checking Account','A','A',NULL,'AR_paid:AP_paid','',NULL,NULL,1000),(1065,1065,'Petty Cash','A','A',NULL,'AR_paid:AP_paid','',NULL,NULL,1000),(1200,1200,'Accounts Receivables','A','A',NULL,'AR','',NULL,NULL,1000),(1205,1205,'Allowance for doubtful accounts','A','A',NULL,'','',NULL,NULL,1000),(1230,1230,'Purchase VAT','A','L','',NULL,'',NULL,NULL,1000),(1500,1500,'INVENTORY ASSETS','H','A',NULL,'','',NULL,NULL,100),(1520,1520,'Inventory / General','A','A',NULL,'IC','',NULL,NULL,1500),(1530,1530,'Inventory / Aftermarket Parts','A','A',NULL,'IC','',NULL,NULL,1500),(1800,1800,'CAPITAL ASSETS','H','A',NULL,'','',NULL,NULL,100),(1820,1820,'Office Furniture & Equipment','A','A',NULL,'','',NULL,NULL,1800),(1825,1825,'Accum. Amort. -Furn. & Equip.','A','A',NULL,'','',NULL,NULL,1800),(1840,1840,'Vehicle','A','A',NULL,'','',NULL,NULL,1800),(1845,1845,'Accum. Amort. -Vehicle','A','A',NULL,'','',NULL,NULL,1800),(2000,2000,'CURRENT LIABILITIES','H','L',NULL,'','',NULL,NULL,200),(2100,2100,'Accounts Payable','A','L',NULL,'AP','',NULL,NULL,2000),(2160,2160,'Corporate Taxes Payable','A','L',NULL,'','',NULL,NULL,2000),(2190,2190,'Federal Income Tax Payable','A','L',NULL,'','',NULL,NULL,2000),(2210,2210,'Workers Comp Payable','A','L',NULL,'','',NULL,NULL,2000),(2220,2220,'Vacation Pay Payable','A','L',NULL,'','',NULL,NULL,2000),(2250,2250,'Pension Plan Payable','A','L',NULL,'','',NULL,NULL,2000),(2260,2260,'Employment Insurance Payable','A','L',NULL,'','',NULL,NULL,2000),(2280,2280,'Payroll Taxes Payable','A','L',NULL,'','',NULL,NULL,2000),(2310,2310,'Sales VAT','A','L',NULL,'AR_tax:AP_tax:IC_taxpart:IC_ta','','0.00','15.04',2000),(2600,2600,'LONG TERM LIABILITIES','H','L',NULL,'','',NULL,NULL,200),(2620,2620,'Bank Loans','A','L',NULL,'','',NULL,NULL,2600),(2680,2680,'Loans from Shareholders','A','L',NULL,'AP_paid','',NULL,NULL,2600),(3300,3300,'SHARE CAPITAL','H','Q',NULL,'','',NULL,NULL,300),(3350,3350,'Common Shares','A','Q',NULL,'','',NULL,NULL,3300),(4000,4000,'SALES REVENUE','H','I',NULL,'','',NULL,NULL,400),(4020,4020,'Sales / General','A','I',NULL,'AR_amount:IC_sale','','0.00','67.71',4000),(4030,4030,'Sales / Aftermarket Parts','A','I',NULL,'AR_amount:IC_sale','','0.00','13.00',4000),(4300,4300,'CONSULTING REVENUE','H','I',NULL,'','',NULL,NULL,400),(4320,4320,'Consulting','A','I',NULL,'AR_amount:IC_income','',NULL,NULL,4300),(4400,4400,'OTHER REVENUE','H','I',NULL,'','',NULL,NULL,400),(4430,4430,'Shipping & Handling','A','I',NULL,'IC_income','',NULL,NULL,4400),(4440,4440,'Interest','A','I',NULL,'','',NULL,NULL,4400),(4450,4450,'Foreign Exchange Gain','A','I',NULL,'','',NULL,NULL,4400),(5000,5000,'COST OF GOODS SOLD','H','E',NULL,'','',NULL,NULL,500),(5010,5010,'Purchases','A','E',NULL,'AP_amount:IC_cogs:IC_expense','',NULL,NULL,5000),(5020,5020,'COGS / General','A','E',NULL,'AP_amount:IC_cogs','',NULL,NULL,5000),(5030,5030,'COGS / Aftermarket Parts','A','E',NULL,'AP_amount:IC_cogs','',NULL,NULL,5000),(5100,5100,'Freight','A','E',NULL,'AP_amount:IC_expense','',NULL,NULL,5000),(5400,5400,'PAYROLL EXPENSES','H','E',NULL,'','',NULL,NULL,500),(5410,5410,'Wages & Salaries','A','E',NULL,'','',NULL,NULL,5400),(5420,5420,'Employment Insurance Expense','A','E',NULL,'','',NULL,NULL,5400),(5430,5430,'Pension Plan Expense','A','E',NULL,'','',NULL,NULL,5400),(5440,5440,'Workers Comp Expense','A','E',NULL,'','',NULL,NULL,5400),(5470,5470,'Employee Benefits','A','E',NULL,'','',NULL,NULL,5400),(5600,5600,'GENERAL & ADMINISTRATIVE EXPENSES','H','E',NULL,'','',NULL,NULL,500),(5610,5610,'Accounting & Legal','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5615,5615,'Advertising & Promotions','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5620,5620,'Bad Debts','A','E',NULL,'','',NULL,NULL,5600),(5650,5650,'Capital Cost Allowance Expense','A','E',NULL,'','',NULL,NULL,5600),(5660,5660,'Amortization Expense','A','E',NULL,'','',NULL,NULL,5600),(5680,5680,'Income Taxes','A','E',NULL,'','',NULL,NULL,5600),(5685,5685,'Insurance','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5690,5690,'Interest & Bank Charges','A','E',NULL,'','',NULL,NULL,5600),(5700,5700,'Office Supplies','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5760,5760,'Rent','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5765,5765,'Repair & Maintenance','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5780,5780,'Telephone','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5785,5785,'Travel & Entertainment','A','E',NULL,'','',NULL,NULL,5600),(5790,5790,'Utilities','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5795,5795,'Registrations','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5800,5800,'Licenses','A','E',NULL,'AP_amount','',NULL,NULL,5600),(5810,5810,'Foreign Exchange Loss','A','E',NULL,'','',NULL,NULL,5600),(970020,1900,'CUSTOMERS','H','A','C',NULL,'',NULL,NULL,100),(970022,2024,'John Smith','A','A',NULL,NULL,NULL,'31.70','0.00',970020),(970023,2121,'La Baguette','A','A',NULL,NULL,NULL,'64.05','0.00',970020),(970024,1921,'OpenFoods','A','A',NULL,NULL,NULL,NULL,NULL,970020),(970025,2900,'VENDORS','H','L','V',NULL,'',NULL,NULL,200),(970026,2905,'ACME SPA','A','L',NULL,NULL,NULL,NULL,NULL,970025),(970027,2907,'John Smith','A','L',NULL,NULL,NULL,NULL,NULL,970025),(970028,2915,'Zeta kappa','A','L',NULL,NULL,NULL,NULL,NULL,970025);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
CREATE TABLE `banks` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `abi_code` int(11) default NULL,
  `cab_code` int(11) default NULL,
  `address` varchar(50) default NULL,
  `city` varchar(50) default NULL,
  `state` varchar(20) default NULL,
  `branch` varchar(50) default NULL,
  `iban` varchar(34) default NULL,
  `bic` varchar(11) default NULL,
  `bank_account` varchar(20) default NULL,
  `phone` varchar(30) default NULL,
  `fax` varchar(30) default NULL,
  `contact` varchar(50) default NULL,
  `type` varchar(255) default 'Bank',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` VALUES (17,'Blank Bank',555,8888,'','Denver','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Bank'),(18,'Antana',NULL,NULL,'','','','','','',NULL,'','','','Bank');
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
CREATE TABLE `branches` (
  `id` int(11) NOT NULL auto_increment,
  `partner_id` int(11) default NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) default NULL,
  `city` varchar(50) default NULL,
  `zipcode` varchar(10) default NULL,
  `state` varchar(50) default NULL,
  `country` varchar(50) default NULL,
  `contact` varchar(64) default NULL,
  `phone` varchar(20) default NULL,
  `fax` varchar(20) default NULL,
  `email` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `branches_ibfk_partner_id` (`partner_id`),
  CONSTRAINT `branches_ibfk_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (16,1,'Main','Street 92','Baltimora','','','','','','',''),(17,2,'aaaaa','3434324','324324','','','','','','','');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carriers`
--

DROP TABLE IF EXISTS `carriers`;
CREATE TABLE `carriers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `phone` varchar(20) default NULL,
  `notes` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `carriers`
--

LOCK TABLES `carriers` WRITE;
/*!40000 ALTER TABLE `carriers` DISABLE KEYS */;
/*!40000 ALTER TABLE `carriers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashpayments`
--

DROP TABLE IF EXISTS `cashpayments`;
CREATE TABLE `cashpayments` (
  `id` varchar(40) NOT NULL default '0',
  `amount` float NOT NULL default '0',
  `clientid` tinyint(4) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cashpayments`
--

LOCK TABLES `cashpayments` WRITE;
/*!40000 ALTER TABLE `cashpayments` DISABLE KEYS */;
INSERT INTO `cashpayments` VALUES ('200711100813123',52,1),('200711100907200',26,1),('200711101106556',16.4,1),('200711110104053',39,1),('200711110104271',110,1),('200711120352365',26,1),('200711120352471',30.25,1),('200711121033114',26,1),('200711121034437',26,1),('200711121038375',26,1),('200711121041093',73.75,1),('200711121043417',13,1),('200711121045106',13,1),('200711121046352',13,1),('200711121048205',52.625,1),('200711121050038',38,1),('200711121053396',26,1),('200711121055216',38,1),('200711121058165',38,1),('200711121059572',38,1),('200711121102201',38,1);
/*!40000 ALTER TABLE `cashpayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Bimbo'),(2,'Refrescos'),(3,'Productos por peso o gramo/Granular'),(4,'Cigarros'),(5,'Frituras'),(7,'Abarrotes en general'),(8,'Consumibles de computo'),(9,'Carnes frÃ­as'),(11,'Granos'),(12,'Farmacos'),(13,'Perecederos');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clerks`
--

DROP TABLE IF EXISTS `clerks`;
CREATE TABLE `clerks` (
  `id` smallint(5) NOT NULL default '0',
  `employeenum` smallint(5) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clerks`
--

LOCK TABLES `clerks` WRITE;
/*!40000 ALTER TABLE `clerks` DISABLE KEYS */;
/*!40000 ALTER TABLE `clerks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` mediumint(4) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL default '',
  `address` varchar(40) NOT NULL default '',
  `taxid_rfc` varchar(20) NOT NULL default '',
  `points` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Desconocido','Desconocido','DDDDDDD',127),(2,'Enrique Meza CosteÃ±o','Totonacas 55 3 Col. Ajusco','MECE670315QH7',100),(3,'Juventino Meza CosteÃ±o','Totonacas 553 Col. Ajusco','MECJ701305XM0',20),(4,'Irene Meza CosteÃ±o','Totonacas 55 3 Col. Ajusco','MECI712011XM0',5);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
CREATE TABLE `configurations` (
  `id` tinyint(4) NOT NULL auto_increment,
  `bussinessname` varchar(40) NOT NULL,
  `flaglevel` tinyint(3) NOT NULL,
  `otherdiscount` float NOT NULL,
  `language_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_languages_config` (`language_id`),
  CONSTRAINT `fk_languages_config` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `configurations`
--

LOCK TABLES `configurations` WRITE;
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
INSERT INTO `configurations` VALUES (1,'Abarrotes la vencedora',4,0.2,1);
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons` (
  `id` tinyint(3) NOT NULL default '0',
  `points` smallint(4) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credititems`
--

DROP TABLE IF EXISTS `credititems`;
CREATE TABLE `credititems` (
  `item` varchar(40) NOT NULL default '',
  `price` mediumint(5) NOT NULL default '0',
  `qty` mediumint(4) NOT NULL default '0',
  `date_to_pay` datetime NOT NULL default '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `credititems`
--

LOCK TABLES `credititems` WRITE;
/*!40000 ALTER TABLE `credititems` DISABLE KEYS */;
/*!40000 ALTER TABLE `credititems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creditpayments`
--

DROP TABLE IF EXISTS `creditpayments`;
CREATE TABLE `creditpayments` (
  `id` varchar(40) NOT NULL default '0',
  `amount` float NOT NULL default '0',
  `clientid` tinyint(4) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `creditpayments`
--

LOCK TABLES `creditpayments` WRITE;
/*!40000 ALTER TABLE `creditpayments` DISABLE KEYS */;
INSERT INTO `creditpayments` VALUES ('200711100906560',26,1),('200711100907080',25,1),('200711101106468',48,1),('200711110104127',50.5,1);
/*!40000 ALTER TABLE `creditpayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_rows`
--

DROP TABLE IF EXISTS `doc_rows`;
CREATE TABLE `doc_rows` (
  `id` int(11) NOT NULL auto_increment,
  `doc_id` int(11) default '0',
  `row_type` int(11) default NULL,
  `item_id` int(11) default NULL,
  `description` varchar(100) default NULL,
  `unit` char(3) NOT NULL,
  `quantity` decimal(6,1) NOT NULL default '0.0',
  `price` decimal(6,2) default NULL,
  `discount` decimal(3,1) NOT NULL default '0.0',
  `tax_rate_id` int(11) default NULL,
  `account_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `doc_rows_ibfk_doc_id` (`doc_id`),
  KEY `doc_rows_ibfk_item_id` (`item_id`),
  KEY `doc_rows_ibfk_tax_rate_id` (`tax_rate_id`),
  KEY `doc_rows_ibfk_account_id` (`account_id`),
  CONSTRAINT `doc_rows_ibfk_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `doc_rows_ibfk_doc_id` FOREIGN KEY (`doc_id`) REFERENCES `docs` (`id`),
  CONSTRAINT `doc_rows_ibfk_tax_rate_id` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doc_rows`
--

LOCK TABLES `doc_rows` WRITE;
/*!40000 ALTER TABLE `doc_rows` DISABLE KEYS */;
INSERT INTO `doc_rows` VALUES (1,1,0,13,'OpenCola','','1.0','1.10','0.0',7,4020),(2,1,0,14,'Pizza Napoletana','','1.0','2.30','5.0',7,4020),(3,2,0,14,'Pizza Napoletana','','1.0','2.30','0.0',7,4020),(4,2,3,NULL,'Another item','','0.0','4.00','0.0',8,4030),(5,3,0,14,'Pizza Napoletana','','1.0','2.30','0.0',7,4020),(6,3,3,NULL,'Another item','','0.0','4.00','0.0',8,4030),(7,3,2,NULL,'Descriptive,\r\n multiline\r\n  row','','0.0',NULL,'0.0',NULL,NULL),(8,4,0,15,'Red wine','','20.0','2.40','7.0',7,4020),(9,4,1,NULL,'packing','','0.0','2.00','0.0',NULL,4030),(10,5,2,NULL,'Delivery n. 1 in date 2006-11-05','','0.0',NULL,'0.0',NULL,NULL),(11,5,0,15,'Red wine','','20.0','2.40','7.0',7,4020),(12,5,1,NULL,'packing','','0.0','2.00','0.0',NULL,4030),(13,6,0,14,'Pizza Napoletana','','3.0','2.30','0.0',7,4020),(14,6,0,13,'OpenCola','','2.0','1.10','0.0',7,4020),(15,6,0,15,'Red wine','','1.0','1.60','0.0',7,4020),(16,7,0,13,'OpenCola','','10.0','1.10','0.0',7,4020),(17,7,3,NULL,'No-vat expense','','0.0','7.00','0.0',9,4030);
/*!40000 ALTER TABLE `doc_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_types`
--

DROP TABLE IF EXISTS `doc_types`;
CREATE TABLE `doc_types` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(5) NOT NULL,
  `name` varchar(45) NOT NULL,
  `family` char(3) NOT NULL,
  `pdf_template` varchar(45) NOT NULL,
  `to_invoice` char(1) NOT NULL,
  `to_record` char(1) NOT NULL,
  `batch_invoice` char(1) NOT NULL,
  `update_warehouse` int(11) default '0',
  `generate_maturities` int(11) default '0',
  `number_sequence` int(11) default NULL,
  `account_exchange_id` int(11) default NULL,
  `tran_type_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `doc_types_ibfk_tran_type_id` (`tran_type_id`),
  CONSTRAINT `doc_types_ibfk_tran_type_id` FOREIGN KEY (`tran_type_id`) REFERENCES `tran_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doc_types`
--

LOCK TABLES `doc_types` WRITE;
/*!40000 ALTER TABLE `doc_types` DISABLE KEYS */;
INSERT INTO `doc_types` VALUES (1,'INV','Invoice','inv','invoice','0','1','0',1,1,5,NULL,2),(2,'BIN','Batch Invoice','inv','invoice','0','1','1',0,0,5,NULL,2),(3,'DEL','Delivery','del','delivery','1','0','0',1,0,1,NULL,NULL),(4,'DNI','Delivery not to invoice','del','delivery','0','0','0',1,0,1,NULL,NULL),(5,'QUO','Quote','quo','invoice','0','0','0',0,0,2,NULL,NULL),(6,'ORD','Order','ord','invoice','0','0','0',0,0,3,NULL,NULL),(7,'CRN','Credit note','inv','invoice','0','1','0',1,0,5,541006,3),(8,'DCN','Discount credit note','inv','invoice','0','1','0',0,0,5,541007,3),(9,'DBN','Debit note','inv','invoice','0','1','0',0,0,5,541001,2);
/*!40000 ALTER TABLE `doc_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docs`
--

DROP TABLE IF EXISTS `docs`;
CREATE TABLE `docs` (
  `id` int(11) NOT NULL auto_increment,
  `doc_number` int(11) NOT NULL default '0',
  `recerence_number` int(11) default NULL,
  `invoice_number` int(11) default NULL,
  `date` date default NULL,
  `partner_id` int(11) default NULL,
  `payment_id` int(11) default NULL,
  `bank_id` int(11) default NULL,
  `carrier_id` int(11) default NULL,
  `listino` int(11) NOT NULL default '0',
  `forwarding_id` int(11) default NULL,
  `carriage_id` int(11) default NULL,
  `packing_id` int(11) default NULL,
  `transport_expenses` decimal(4,2) NOT NULL default '0.00',
  `discount` decimal(4,2) NOT NULL default '0.00',
  `transport_date` datetime default NULL,
  `tran_id` int(11) default NULL,
  `status` char(1) NOT NULL,
  `doc_type_id` int(11) NOT NULL default '0',
  `reference_doc_id` int(11) default NULL,
  `reference_doc_info` varchar(15) default NULL,
  `amount` decimal(7,2) default '0.00',
  `branch_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `docs_ibfk_partner_id` (`partner_id`),
  KEY `docs_ibfk_payment_id` (`payment_id`),
  KEY `docs_ibfk_bank_id` (`bank_id`),
  KEY `docs_ibfk_carrier_id` (`carrier_id`),
  KEY `docs_ibfk_forwarding_id` (`forwarding_id`),
  KEY `docs_ibfk_packing_id` (`packing_id`),
  KEY `docs_ibfk_tran_id` (`tran_id`),
  KEY `docs_ibfk_doc_type_id` (`doc_type_id`),
  KEY `docs_ibfk_branch_id` (`branch_id`),
  KEY `docs_ibfk_reference_doc_id` (`reference_doc_id`),
  CONSTRAINT `docs_ibfk_bank_id` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`),
  CONSTRAINT `docs_ibfk_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `docs_ibfk_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `carriers` (`id`),
  CONSTRAINT `docs_ibfk_doc_type_id` FOREIGN KEY (`doc_type_id`) REFERENCES `doc_types` (`id`),
  CONSTRAINT `docs_ibfk_forwarding_id` FOREIGN KEY (`forwarding_id`) REFERENCES `lookup_items` (`id`),
  CONSTRAINT `docs_ibfk_packing_id` FOREIGN KEY (`packing_id`) REFERENCES `lookup_items` (`id`),
  CONSTRAINT `docs_ibfk_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`),
  CONSTRAINT `docs_ibfk_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
  CONSTRAINT `docs_ibfk_reference_doc_id` FOREIGN KEY (`reference_doc_id`) REFERENCES `docs` (`id`),
  CONSTRAINT `docs_ibfk_tran_id` FOREIGN KEY (`tran_id`) REFERENCES `trans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `docs`
--

LOCK TABLES `docs` WRITE;
/*!40000 ALTER TABLE `docs` DISABLE KEYS */;
INSERT INTO `docs` VALUES (1,1,NULL,NULL,'2006-11-05',1,NULL,NULL,NULL,1,2,NULL,4,'0.00','0.00','2006-11-05 11:14:22',NULL,'',5,NULL,NULL,'3.95',NULL),(2,1,NULL,NULL,'2006-11-05',2,4,NULL,NULL,1,NULL,NULL,NULL,'0.00','0.00','2006-11-05 11:15:31',NULL,'P',6,3,'INV N.1','7.16',NULL),(3,1,NULL,NULL,'2006-11-05',2,4,NULL,NULL,1,NULL,NULL,NULL,'0.00','0.00','2006-11-05 11:16:07',1,'B',1,NULL,NULL,'7.16',NULL),(4,1,NULL,2,'2006-11-05',2,4,NULL,NULL,1,NULL,NULL,NULL,'3.00','5.00','2006-11-05 11:19:57',NULL,'I',3,5,'BIN N.2','56.89',NULL),(5,2,NULL,NULL,'2006-11-05',2,4,NULL,NULL,1,NULL,NULL,NULL,'3.00','5.00','2006-11-05 11:19:57',2,'B',2,NULL,NULL,'56.89',NULL),(6,2,NULL,NULL,'2006-11-05',1,NULL,NULL,NULL,1,2,NULL,4,'0.00','0.00','2006-11-05 11:50:27',NULL,'',6,NULL,NULL,'12.84',16),(7,3,NULL,NULL,'2006-11-05',1,2,NULL,NULL,1,2,NULL,4,'0.00','0.00','2006-11-05 11:54:04',NULL,'',1,NULL,NULL,'20.20',NULL);
/*!40000 ALTER TABLE `docs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `id` smallint(4) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `store_id` smallint(4) NOT NULL default '0',
  `cashier` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `fk_employees_stores` (`store_id`),
  CONSTRAINT `fk_employees_stores` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Enrique Meza C.',1,1),(21,'Empleado sin autorizaciÃ³n',1,1),(22,'undesconocido',1,0);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firms`
--

DROP TABLE IF EXISTS `firms`;
CREATE TABLE `firms` (
  `id` int(11) NOT NULL auto_increment,
  `business_name` varchar(50) default NULL,
  `address` varchar(50) default NULL,
  `cap` varchar(5) default NULL,
  `city` varchar(50) default NULL,
  `zipcode` varchar(10) default NULL,
  `phone` varchar(20) default NULL,
  `tax_number` varchar(16) default NULL,
  `business_number` varchar(11) default NULL,
  `e_mail` varchar(50) default NULL,
  `transport_expenses_account_id` int(11) default NULL,
  `account_exchange_id` int(11) default NULL,
  `state` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `fax` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `firms_ibfk_account_exchange_id` (`account_exchange_id`),
  KEY `firms_ibfk_transport_expenses_account_id` (`transport_expenses_account_id`),
  CONSTRAINT `firms_ibfk_account_exchange_id` FOREIGN KEY (`account_exchange_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `firms_ibfk_transport_expenses_account_id` FOREIGN KEY (`transport_expenses_account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `firms`
--

LOCK TABLES `firms` WRITE;
/*!40000 ALTER TABLE `firms` DISABLE KEYS */;
INSERT INTO `firms` VALUES (1,'AD.D. Software SAS','Via S.Paolo, 96','15076','Ovada','AL','0101-82111','','02032160067','',NULL,4020,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `firms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gifi`
--

DROP TABLE IF EXISTS `gifi`;
CREATE TABLE `gifi` (
  `id` int(11) NOT NULL auto_increment,
  `accno` varchar(20) default NULL,
  `description` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gifi`
--

LOCK TABLES `gifi` WRITE;
/*!40000 ALTER TABLE `gifi` DISABLE KEYS */;
INSERT INTO `gifi` VALUES (47,'1','ATTIVO'),(48,'1.A','CREDITI VERSO I SOCI PER VERSAMENTI ANCORA DOVUTI'),(49,'1.B','IMMOBILIZZAZIONI'),(50,'1.B.I','Immobilizzazioni immateriali'),(51,'1.B.I.1','costi di impianto e di ampliamento'),(52,'1.B.I.2','costi di ricerca, di sviluppo e di pubblicita\''),(53,'1.B.I.3','diritti di brevetto industriale e diritti di utilizzazione delle opere dell\'ingegno'),(54,'1.B.I.4','concessioni, licenze, marchi e diritti simili'),(55,'1.B.I.5','avviamento'),(56,'1.B.I.6','immobilizzazioni immateriali in corso e acconti'),(57,'1.B.I.7','altre immobilizzazioni immateriali'),(58,'1.B.II','Immobilizzazioni materiali'),(59,'1.B.II.1','terreni e fabbricati'),(60,'1.B.II.2','impianti e macchinario'),(61,'1.B.II.3','attrezzature industriali e commerciali'),(62,'1.B.II.4','altri beni materiali'),(63,'1.B.II.5','immobilizzazioni in corso e acconti'),(64,'1.B.III','Immobilizzazioni finanziarie'),(65,'1.B.III.1','partecipazioni'),(66,'1.B.III.1.a','partecipazioni in imprese controllate'),(67,'1.B.III.1.b','partecipazioni in imprese collegate'),(68,'1.B.III.1.c','partecipazioni in imprese controllanti'),(69,'1.B.III.1.d','partecipazioni in altre imprese'),(70,'1.B.III.2','crediti'),(71,'1.B.III.2.a','crediti verso imprese controllate'),(72,'1.B.III.2.b','crediti verso imprese collegate'),(73,'1.B.III.2.c','crediti verso controllanti'),(74,'1.B.III.2.d','crediti verso altri'),(75,'1.B.III.3','Altri titoli'),(76,'1.B.III.4','Azioni proprie immobilizzate'),(77,'1.C','ATTIVO CIRCOLANTE'),(78,'1.C.I','Rimanenze'),(79,'1.C.I.1','rimanenze: materie prime, sussidiarie e di consumo'),(80,'1.C.I.2','rimanenze: prodotti in corso di lavorazione e semilavorati'),(81,'1.C.I.3','rimanenze: lavori in corso su ordinazione'),(82,'1.C.I.4','rimanenze: prodotti finiti e merci'),(83,'1.C.I.5','rimanenze: acconti'),(84,'1.C.II','Crediti'),(85,'1.C.II.1','crediti verso i clienti'),(86,'1.C.II.2','crediti verso imprese controllate'),(87,'1.C.II.3','crediti verso imprese collegate'),(88,'1.C.II.4','crediti verso imprese controllanti'),(89,'1.C.II.5','crediti verso altri'),(90,'1.C.III','Attivita\' finanziarie che non costituiscono immobilizzazioni'),(91,'1.C.III.1','partecipazioni in imprese controllate'),(92,'1.C.III.2','partecipazioni in imprese collegate'),(93,'1.C.III.3','partecipazioni in imprese controllanti'),(94,'1.C.III.4','altre partecipazioni'),(95,'1.C.III.5','azioni proprie per investimento temporaneo'),(96,'1.C.III.6','altri titoli'),(97,'1.C.IV','Disponibilita\' liquide'),(98,'1.C.IV.1','depositi bancari e postali'),(99,'1.C.IV.2','assegni'),(100,'1.C.IV.3','denaro e valori in cassa'),(101,'1.D','RATEI E RISCONTI ATTIVI'),(102,'2','PASSIVO'),(103,'2.A','PATRIMONIO NETTO'),(104,'2.A.I','Capitale'),(105,'2.A.II','Riserva da sovrapprezzo delle azioni'),(106,'2.A.III','Riserva di rivalutazione'),(107,'2.A.IV','Riserva legale'),(108,'2.A.V','Riserva per azioni proprie in portafoglio'),(109,'2.A.VI','Riserve statutarie'),(110,'2.A.VII','Altre riserve'),(111,'2.A.VIII','Utili (perdite) portati a nuovo'),(112,'2.A.IX','Utile (perdita) dell\'esercizio'),(113,'2.B','FONDI PER RISCHI E ONERI'),(114,'2.B.1','fondo per trattamento di quiescenza e obblighi simili'),(115,'2.B.2','fondo per imposte'),(116,'2.B.3','altri fondi per rischi e oneri futuri'),(117,'2.C','TRATTAMENTO DI FINE RAPPORTO DI LAVORO SUBORDINATO'),(118,'2.D','DEBITI'),(119,'2.D.1','obbligazioni non convertibili'),(120,'2.D.2','obbligazioni convertibili'),(121,'2.D.3','debiti verso banche'),(122,'2.D.4','debiti verso altri finanziatori'),(123,'2.D.5','debiti: acconti'),(124,'2.D.6','debiti verso fornitori'),(125,'2.D.7','debiti rappresentati da titoli di credito'),(126,'2.D.8','debiti verso imprese controllate'),(127,'2.D.9','debiti verso imprese collegate'),(128,'2.D.10','debiti verso controllanti'),(129,'2.D.11','debiti tributari'),(130,'2.D.12','debiti verso istituti di previdenza e di sicurezza sociale'),(131,'2.D.13','altri debiti'),(132,'2.E','RATEI E RISCONTI PASSIVI'),(133,'3','CONTO ECONOMICO'),(134,'3.A','VALORE DELLA PRODUZIONE'),(135,'3.A.1','ricavi delle vendite e delle prestazioni'),(136,'3.A.2','variazione rimanenze prodotti in lavorazione, semilavorati e finiti'),(137,'3.A.3','variazione dei lavori in corso su ordinazione'),(138,'3.A.4','incrementi di immobilizzazioni per lavori interni'),(139,'3.A.5','altri ricavi e proventi'),(140,'3.B','COSTI DELLA PRODUZIONE'),(141,'3.B.6','acquisti materie prime, sussidiarie, di consumo e di merci'),(142,'3.B.7','spese per prestazione di servizi'),(143,'3.B.8','spese per godimento di beni di terzi'),(144,'3.B.9','costi del personale'),(145,'3.B.9.a','salari e stipendi'),(146,'3.B.9.b','oneri sociali'),(147,'3.B.9.c','accantonamento al TFRL'),(148,'3.B.9.d','accantonamento per trattamento di quiescenza e simili'),(149,'3.B.9.e','altri costi del personale'),(150,'3.B.10','ammortamenti e svalutazioni'),(151,'3.B.10.a','ammortamento delle immobilizzazioni immateriali'),(152,'3.B.10.b','ammortamento delle immobilizzazioni materiali'),(153,'3.B.10.c','altre svalutazioni delle immobilizzazioni'),(154,'3.B.10.d','svalutazioni dell\'attivo circolante e delle disponibilita\' liquide'),(155,'3.B.11','variazioni rimanenze materie prime, sussidiarie, di consumo e merci'),(156,'3.B.12','accantonamento per rischi'),(157,'3.B.13','altri accantonamenti'),(158,'3.B.14','oneri diversi di gestione'),(159,'3.C','PROVENTI E ONERI FINANZIARI'),(160,'3.C.15','proventi da partecipazioni'),(161,'3.C.16','altri proventi finanziari'),(162,'3.C.16.a','proventi da crediti iscritti nelle immobilizzazioni'),(163,'3.C.16.b','proventi da titoli iscritti nelle immobilizzazioni che non costituiscono partecipazioni'),(164,'3.C.16.c','proventi da titoli iscritti all\'attivo circolante che non costituiscono partecipazioni'),(165,'3.C.16.d','proventi diversi dai precedenti'),(166,'3.C.17','Interessi e altri oneri finanziari'),(167,'3.D','RETTIFICHE DI VALORE DI ATTIVITA\' FINANZIARIE'),(168,'3.D.18','rivalutazioni'),(169,'3.D.18.a','rettifiche di partecipazioni'),(170,'3.D.18.b','rettifiche di immobilizzazioni finanziarie che non costituiscono partecipazioni'),(171,'3.D.18.c','rettifiche da titoli iscritti all\'attivo circolante che non costituiscono partecipazioni'),(172,'3.D.19','svalutazioni'),(173,'3.D.19.a','svalutazioni di partecipazioni'),(174,'3.D.19.b','svalutazioni di immobilizzazioni finanziarie che non costituiscono partecipazioni'),(175,'3.D.19.c','svalutazioni di titoli iscritti all\'attivo circolante che non costituiscono partecipazioni'),(176,'3.E','PROVENTI E ONERI STRAORDINARI'),(177,'3.E.20','proventi straordinari'),(178,'3.E.21','oneri straordinari'),(179,'3.E.22','Imposte sul reddito dell\'esercizio'),(180,'3.E.26','Utile o perdita di esercizio');
/*!40000 ALTER TABLE `gifi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historicpayments`
--

DROP TABLE IF EXISTS `historicpayments`;
CREATE TABLE `historicpayments` (
  `id` varchar(40) NOT NULL default '0',
  `amount` float NOT NULL default '0',
  `clientid` tinyint(4) NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `historicpayments`
--

LOCK TABLES `historicpayments` WRITE;
/*!40000 ALTER TABLE `historicpayments` DISABLE KEYS */;
/*!40000 ALTER TABLE `historicpayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historicpurchases`
--

DROP TABLE IF EXISTS `historicpurchases`;
CREATE TABLE `historicpurchases` (
  `id` int(11) NOT NULL auto_increment,
  `barcode` varchar(40) NOT NULL,
  `price` float NOT NULL default '0',
  `cost_price` float NOT NULL,
  `qty_purchased` mediumint(4) NOT NULL default '0',
  `expiration_date` datetime NOT NULL,
  `date_purchased` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `historicpurchases`
--

LOCK TABLES `historicpurchases` WRITE;
/*!40000 ALTER TABLE `historicpurchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `historicpurchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historicsales`
--

DROP TABLE IF EXISTS `historicsales`;
CREATE TABLE `historicsales` (
  `id` smallint(4) NOT NULL auto_increment,
  `idsale` varchar(40) NOT NULL,
  `qty` decimal(10,3) NOT NULL default '0.000',
  `item_id` varchar(40) NOT NULL,
  `price` float NOT NULL default '0',
  `client_id` mediumint(4) NOT NULL default '0',
  `cashier_id` smallint(4) NOT NULL,
  `total` float NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `historicsales`
--

LOCK TABLES `historicsales` WRITE;
/*!40000 ALTER TABLE `historicsales` DISABLE KEYS */;
INSERT INTO `historicsales` VALUES (1,'200711100813123','1.000','1001',13,1,21,13),(2,'200711100813123','1.000','1001',13,1,21,13),(3,'200711100813123','1.000','1001',13,1,21,13),(4,'200711100813123','1.000','1001',13,1,21,13),(5,'200711100906560','1.000','1001',13,1,21,13),(6,'200711100906560','1.000','2001',13,1,21,13),(7,'200711100907080','1.000','2001',13,1,21,13),(8,'200711100907080','1.000','213',12,1,21,12),(9,'200711100907200','1.000','1001',13,1,21,13),(10,'200711100907200','1.000','2001',13,1,21,13),(11,'200711101106468','1.000','213',12,1,21,12),(12,'200711101106468','1.000','213',12,1,21,12),(13,'200711101106468','1.000','213',12,1,21,12),(14,'200711101106468','1.000','213',12,1,21,12),(15,'200711101106556','200.000','1',0.017,1,21,3.4),(16,'200711101106556','1.000','1001',13,1,21,13),(17,'200711110104053','1.000','1001',13,1,21,13),(18,'200711110104053','1.000','1001',13,1,21,13),(19,'200711110104053','1.000','1001',13,1,21,13),(20,'200711110104127','500.000','23',0.075,1,21,37.5),(21,'200711110104127','1.000','2001',13,1,21,13),(22,'200711110104271','1.000','1001',13,1,21,13),(23,'200711110104271','1.000','2001',13,1,21,13),(24,'200711110104271','7.000','213',12,1,21,84),(25,'200711120352365','1.000','1001',13,1,21,13),(26,'200711120352365','1.000','2001',13,1,21,13),(27,'200711120352471','1.000','1001',13,1,21,13),(28,'200711120352471','1.000','2001',13,1,21,13),(29,'200711120352471','250.000','1',0.017,1,21,4.25);
/*!40000 ALTER TABLE `historicsales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_aliases`
--

DROP TABLE IF EXISTS `item_aliases`;
CREATE TABLE `item_aliases` (
  `id` tinyint(4) NOT NULL auto_increment,
  `item_id` varchar(40) NOT NULL,
  `name` varchar(40) NOT NULL,
  `alternate_cost_price` float NOT NULL,
  `qty` mediumint(4) NOT NULL,
  `wmsystem_id` tinyint(2) NOT NULL,
  `expiration_date` datetime default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item_aliases`
--

LOCK TABLES `item_aliases` WRITE;
/*!40000 ALTER TABLE `item_aliases` DISABLE KEYS */;
INSERT INTO `item_aliases` VALUES (1,'1','JamÃ³n serrano ENERO',11,12,1,'2007-10-12 20:08:00'),(2,'3','Jabones la costeÃ±a',12,12,1,'2007-10-14 19:57:00');
/*!40000 ALTER TABLE `item_aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_purchaseds`
--

DROP TABLE IF EXISTS `item_purchaseds`;
CREATE TABLE `item_purchaseds` (
  `id` int(11) NOT NULL auto_increment,
  `barcode` varchar(40) NOT NULL,
  `price` float NOT NULL default '0',
  `cost_price` float NOT NULL,
  `qty_purchased` mediumint(4) NOT NULL default '0',
  `expiration_date` datetime NOT NULL,
  `date_purchased` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item_purchaseds`
--

LOCK TABLES `item_purchaseds` WRITE;
/*!40000 ALTER TABLE `item_purchaseds` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_purchaseds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemreturns`
--

DROP TABLE IF EXISTS `itemreturns`;
CREATE TABLE `itemreturns` (
  `id` smallint(4) NOT NULL auto_increment,
  `idsale` varchar(40) NOT NULL default '',
  `qty` int(4) NOT NULL default '0',
  `item` varchar(40) NOT NULL default '',
  `price` float NOT NULL default '0',
  `clientid` mediumint(4) NOT NULL default '0',
  `total` float NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `itemreturns`
--

LOCK TABLES `itemreturns` WRITE;
/*!40000 ALTER TABLE `itemreturns` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemreturns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` int(11) NOT NULL auto_increment,
  `barcode` varchar(40) NOT NULL,
  `description` varchar(40) NOT NULL default '',
  `price` float NOT NULL default '0',
  `cost_price` float NOT NULL,
  `qty` mediumint(4) NOT NULL default '0',
  `expiration_date` datetime NOT NULL,
  `minimum_stock` decimal(10,0) NOT NULL,
  `wmsystem_id` tinyint(2) NOT NULL,
  `category_id` int(11) NOT NULL,
  `itemalias_id` tinyint(4) NOT NULL default '0',
  `notes` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'1001','Pascual de a litro y medio',13,12,194,'2007-10-24 00:00:00','25',1,2,0,''),(3,'734646120623','Cartucho de Tinta negra lexmark',222,111,17,'2007-10-23 18:39:00','10',1,7,0,''),(4,'2001','Cerveza de 10 litros',13,12,73,'2007-10-23 18:04:00','98',1,2,0,''),(5,'213','Donas de 4',12,10,16,'2007-11-03 11:36:00','25',1,1,0,''),(6,'1','Croquetas para perro',0.017,0.013,4750,'2007-10-23 23:35:00','25000',1,3,0,''),(7,'23','JamÃ³n',0.075,0.06,2500,'2007-11-01 17:46:00','6000',2,3,0,''),(8,'232','nuevo producto',11,10,11,'2007-10-29 14:28:00','5',3,5,0,'un producto mÃ¡s');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'es_MX'),(2,'en_US');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookup_categories`
--

DROP TABLE IF EXISTS `lookup_categories`;
CREATE TABLE `lookup_categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `description` varchar(200) default NULL,
  `is_tree` int(11) default NULL,
  `is_hardcoded` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lookup_categories`
--

LOCK TABLES `lookup_categories` WRITE;
/*!40000 ALTER TABLE `lookup_categories` DISABLE KEYS */;
INSERT INTO `lookup_categories` VALUES (1,'Forwardings','',0,1),(2,'Packing','',0,1),(3,'Carriages','',0,1),(4,'Item categories','',0,1);
/*!40000 ALTER TABLE `lookup_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookup_items`
--

DROP TABLE IF EXISTS `lookup_items`;
CREATE TABLE `lookup_items` (
  `id` int(11) NOT NULL auto_increment,
  `category_id` int(11) NOT NULL default '0',
  `code` varchar(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `parent_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `lookup_items_ibfk_category_id` (`category_id`),
  CONSTRAINT `lookup_items_ibfk_category_id` FOREIGN KEY (`category_id`) REFERENCES `lookup_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lookup_items`
--

LOCK TABLES `lookup_items` WRITE;
/*!40000 ALTER TABLE `lookup_items` DISABLE KEYS */;
INSERT INTO `lookup_items` VALUES (1,1,'mail','By mail',NULL),(2,1,'car','By carrier',NULL),(3,1,'air','By air',NULL),(4,2,'01','Paper',NULL),(5,2,'02','Not returnable',NULL),(6,2,'03','Excluded',NULL),(7,3,'01','Free',NULL),(8,4,'P_','Products',NULL),(9,4,'S_','Services',NULL),(10,4,'FD','Foods',NULL),(11,4,'BV','Beverages',NULL);
/*!40000 ALTER TABLE `lookup_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maturities`
--

DROP TABLE IF EXISTS `maturities`;
CREATE TABLE `maturities` (
  `id` int(11) NOT NULL auto_increment,
  `date` date NOT NULL default '0000-00-00',
  `amount` double(6,2) default NULL,
  `doc_info` varchar(15) default NULL,
  `doc_id` int(11) default NULL,
  `payment_id` int(11) default NULL,
  `status` int(11) default NULL,
  `notes` varchar(50) default NULL,
  `partner_type` char(1) default 'C',
  `partner_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `maturities_ibfk_doc_id` (`doc_id`),
  KEY `maturities_ibfk_payment_id` (`payment_id`),
  KEY `maturities_ibfk_partner_id` (`partner_id`),
  CONSTRAINT `maturities_ibfk_doc_id` FOREIGN KEY (`doc_id`) REFERENCES `docs` (`id`),
  CONSTRAINT `maturities_ibfk_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `partners` (`id`),
  CONSTRAINT `maturities_ibfk_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `maturities`
--

LOCK TABLES `maturities` WRITE;
/*!40000 ALTER TABLE `maturities` DISABLE KEYS */;
INSERT INTO `maturities` VALUES (2,'2006-11-05',7.16,'INV N.1',3,4,NULL,NULL,'C',2),(3,'2007-01-31',10.10,'INV N.3',7,2,NULL,NULL,'C',1),(4,'2007-02-28',10.10,'INV N.3',7,2,NULL,NULL,'C',1);
/*!40000 ALTER TABLE `maturities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outcomeaccounts`
--

DROP TABLE IF EXISTS `outcomeaccounts`;
CREATE TABLE `outcomeaccounts` (
  `id` smallint(5) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `description` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `outcomeaccounts`
--

LOCK TABLES `outcomeaccounts` WRITE;
/*!40000 ALTER TABLE `outcomeaccounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `outcomeaccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outcometransactions`
--

DROP TABLE IF EXISTS `outcometransactions`;
CREATE TABLE `outcometransactions` (
  `id` smallint(4) NOT NULL auto_increment,
  `idsale` varchar(40) NOT NULL default '',
  `qty` int(4) NOT NULL default '0',
  `item` varchar(40) NOT NULL default '',
  `price` float NOT NULL default '0',
  `clientid` mediumint(4) NOT NULL default '0',
  `total` float NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `outcometransactions`
--

LOCK TABLES `outcometransactions` WRITE;
/*!40000 ALTER TABLE `outcometransactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `outcometransactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partners`
--

DROP TABLE IF EXISTS `partners`;
CREATE TABLE `partners` (
  `id` int(11) NOT NULL auto_increment,
  `code` int(11) NOT NULL default '0',
  `name` varchar(50) NOT NULL,
  `address` varchar(50) default NULL,
  `city` varchar(50) default NULL,
  `zipcode` varchar(10) default NULL,
  `state` varchar(50) default NULL,
  `country` varchar(50) default NULL,
  `legal_address` varchar(50) default NULL,
  `legal_city` varchar(50) default NULL,
  `legal_zipcode` varchar(10) default NULL,
  `contact` varchar(64) default NULL,
  `phone` varchar(20) default NULL,
  `fax` varchar(20) default NULL,
  `email` varchar(50) default NULL,
  `tax_number` varchar(16) default NULL,
  `business_number` varchar(11) default NULL,
  `list_price` int(11) default NULL,
  `discount` decimal(3,2) default NULL,
  `group_docs` char(1) default NULL,
  `payment_id` int(11) default NULL,
  `forwarding_id` int(11) default NULL,
  `packing_id` int(11) default NULL,
  `bank_id` int(11) default NULL,
  `carriage_id` int(11) default NULL,
  `tax_rate_id` int(11) default NULL,
  `account_id` int(11) default NULL,
  `ledger_id` int(11) default NULL,
  `status` varchar(10) default NULL,
  `notes` varchar(200) default NULL,
  `type` varchar(20) NOT NULL,
  `bank_account` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `partners_ibfk_payment_id` (`payment_id`),
  KEY `partners_ibfk_bank_id` (`bank_id`),
  KEY `partners_ibfk_forwarding_id` (`forwarding_id`),
  KEY `partners_ibfk_packing_id` (`packing_id`),
  KEY `partners_ibfk_carriage_id` (`carriage_id`),
  KEY `partners_ibfk_account_id` (`account_id`),
  KEY `partners_ibfk_ledger_id` (`ledger_id`),
  KEY `partners_ibfk_tax_rate_id` (`tax_rate_id`),
  CONSTRAINT `partners_ibfk_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `partners_ibfk_bank_id` FOREIGN KEY (`bank_id`) REFERENCES `banks` (`id`),
  CONSTRAINT `partners_ibfk_carriage_id` FOREIGN KEY (`carriage_id`) REFERENCES `lookup_items` (`id`),
  CONSTRAINT `partners_ibfk_forwarding_id` FOREIGN KEY (`forwarding_id`) REFERENCES `lookup_items` (`id`),
  CONSTRAINT `partners_ibfk_ledger_id` FOREIGN KEY (`ledger_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `partners_ibfk_packing_id` FOREIGN KEY (`packing_id`) REFERENCES `lookup_items` (`id`),
  CONSTRAINT `partners_ibfk_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
  CONSTRAINT `partners_ibfk_tax_rate_id` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `partners`
--

LOCK TABLES `partners` WRITE;
/*!40000 ALTER TABLE `partners` DISABLE KEYS */;
INSERT INTO `partners` VALUES (1,124,'John Smith','Main Street, 123','New York','','','USA',NULL,NULL,NULL,NULL,'','','','','13 44',1,NULL,'0',NULL,2,4,NULL,NULL,NULL,970022,970020,NULL,NULL,'Customer',NULL),(2,221,'La Baguette','Rue de seine','Paris','12','paris','France',NULL,NULL,NULL,'','11123','','','','552211',1,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,970023,970020,NULL,NULL,'Customer',''),(3,21,'OpenFoods','Via dei bazar','Genova','12345','AL','Italia',NULL,NULL,NULL,NULL,'','','','13444','12344567',1,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,970024,970020,NULL,NULL,'Customer',NULL),(8,5,'ACME SPA','','','','','',NULL,NULL,NULL,NULL,'','','','','',1,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,970026,970025,NULL,NULL,'Vendor',NULL),(9,7,'John Smith','','Macondo','','','',NULL,NULL,NULL,NULL,'777','','','','',1,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,970027,970025,NULL,NULL,'Vendor',NULL),(10,15,'Zeta kappa','','Abano Terme','','','Italia',NULL,NULL,NULL,NULL,'','','','','',1,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,970028,970025,NULL,NULL,'Vendor',NULL),(12,0,'Bond','','London','','','',NULL,NULL,NULL,NULL,'','','','','',1,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agent',NULL);
/*!40000 ALTER TABLE `partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_types`
--

DROP TABLE IF EXISTS `payment_types`;
CREATE TABLE `payment_types` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `receipts_expenses` decimal(6,2) NOT NULL default '0.00',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payment_types`
--

LOCK TABLES `payment_types` WRITE;
/*!40000 ALTER TABLE `payment_types` DISABLE KEYS */;
INSERT INTO `payment_types` VALUES (1,'CASH','By cash','0.00'),(2,'CC','Credit Card','0.00'),(3,'BANK','Bank receipt','0.75');
/*!40000 ALTER TABLE `payment_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(50) default NULL,
  `payment_type_id` int(11) NOT NULL default '0',
  `instanments` int(11) default '1',
  `first_due` int(11) default '0',
  `due_type` int(11) default NULL,
  `other_dues` int(11) default '0',
  `month_excluded` int(11) default NULL,
  `notes` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `payments_ibfk_payment_type_id` (`payment_type_id`),
  CONSTRAINT `payments_ibfk_payment_type_id` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,'By bank 60gg i.d. e.m.',3,1,60,100,0,NULL,NULL),(2,'By bank 60/90gg i.d. e.m.',3,2,60,100,30,8,NULL),(3,'by bank 30/60/90/120/150',3,5,0,100,30,8,NULL),(4,'By cash',1,1,0,0,0,NULL,NULL),(5,'By credit card',2,1,0,0,0,NULL,NULL);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promopayments`
--

DROP TABLE IF EXISTS `promopayments`;
CREATE TABLE `promopayments` (
  `id` varchar(40) NOT NULL default '0',
  `amount` float NOT NULL default '0',
  `clientid` tinyint(4) NOT NULL default '0',
  `discount` float NOT NULL default '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `promopayments`
--

LOCK TABLES `promopayments` WRITE;
/*!40000 ALTER TABLE `promopayments` DISABLE KEYS */;
INSERT INTO `promopayments` VALUES ('200711100548004',37.5,1,0.1),('200711100558147',23.4,1,0.1),('200711100600367',165.75,1,0.15),('200711100602552',17,1,0.1),('200711100612520',75.4,1,0.1),('200711100614213',23.4,1,0.1);
/*!40000 ALTER TABLE `promopayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
CREATE TABLE `providers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `address` varchar(60) default NULL,
  `taxid_rfc` varchar(20) default NULL,
  `category_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `fk_providers_categories` (`category_id`),
  CONSTRAINT `fk_providers_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES (1,'Cocacola TaxqueÃ±a','Av. TaxqueÃ±a No. 24. Col. Prados de TasqueÃ±a','COCA88780',4),(2,'Cerveza la Corona','Av. de los briag no 3','CORONA88282882',5);
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salereturns`
--

DROP TABLE IF EXISTS `salereturns`;
CREATE TABLE `salereturns` (
  `id` smallint(4) NOT NULL auto_increment,
  `idsale` varchar(40) NOT NULL default '',
  `total` float NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `salereturns`
--

LOCK TABLES `salereturns` WRITE;
/*!40000 ALTER TABLE `salereturns` DISABLE KEYS */;
INSERT INTO `salereturns` VALUES (1,'200711100612520',75.4);
/*!40000 ALTER TABLE `salereturns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales` (
  `id` smallint(4) NOT NULL auto_increment,
  `idsale` varchar(8) NOT NULL,
  `total` float NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'20071110',32.75),(2,'20071110',26),(3,'20071110',37.5),(4,'20071110',23.4),(5,'20071110',165.75),(6,'20071110',17),(8,'20071110',23.4),(9,'20071110',12.25),(10,'20071110',23.4),(11,'20071110',126),(12,'20071110',91),(13,'20071110',65),(14,'20071110',33.5),(15,'20071110',38),(16,'20071110',26),(17,'20071110',52),(18,'20071110',65),(19,'20071110',65),(20,'20071110',65),(21,'20071110',52),(22,'20071110',52),(23,'20071110',26),(24,'20071110',25),(25,'20071110',26),(26,'20071110',48),(27,'20071110',16.4),(28,'20071111',39),(29,'20071111',50.5),(30,'20071111',110),(31,'20071112',26),(32,'20071112',30.25),(33,'20071112',26),(34,'20071112',26),(35,'20071112',26),(36,'20071112',73.75),(37,'20071112',13),(38,'20071112',13),(39,'20071112',13),(40,'20071112',52.625),(41,'20071112',38),(42,'20071112',26),(43,'20071112',38),(44,'20071112',38),(45,'20071112',38),(46,'20071112',38);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saletransactions`
--

DROP TABLE IF EXISTS `saletransactions`;
CREATE TABLE `saletransactions` (
  `id` smallint(4) NOT NULL auto_increment,
  `idsale` varchar(40) NOT NULL default '',
  `qty` decimal(10,3) NOT NULL default '0.000',
  `item` varchar(40) NOT NULL default '',
  `price` float NOT NULL default '0',
  `clientid` mediumint(4) NOT NULL default '0',
  `cashierid` smallint(4) NOT NULL,
  `total` float NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saletransactions`
--

LOCK TABLES `saletransactions` WRITE;
/*!40000 ALTER TABLE `saletransactions` DISABLE KEYS */;
INSERT INTO `saletransactions` VALUES (6,'200711121033114','1.000','1001',13,1,21,13),(7,'200711121033114','1.000','2001',13,1,21,13),(8,'200711121034437','1.000','1001',13,1,21,13),(9,'200711121034437','1.000','2001',13,1,21,13),(10,'200711121038375','1.000','1001',13,1,21,13),(11,'200711121038375','1.000','2001',13,1,21,13),(12,'200711121041093','1.000','1001',13,1,21,13),(13,'200711121041093','1.000','2001',13,1,21,13),(14,'200711121041093','1.000','213',12,1,21,12),(15,'200711121041093','750.000','1',0.017,1,21,12.75),(16,'200711121041093','306.667','23',0.075,1,21,23),(17,'200711121043417','1.000','1001',13,1,21,13),(18,'200711121045106','1.000','1001',13,1,21,13),(19,'200711121046352','1.000','1001',13,1,21,13),(20,'200711121048205','1.000','1001',13,1,21,13),(21,'200711121048205','1.000','2001',13,1,21,13),(22,'200711121048205','1.000','213',12,1,21,12),(23,'200711121048205','750.000','1',0.017,1,21,12.75),(24,'200711121048205','25.000','23',0.075,1,21,1.875),(25,'200711121050038','1.000','1001',13,1,21,13),(26,'200711121050038','1.000','2001',13,1,21,13),(27,'200711121050038','1.000','213',12,1,21,12),(28,'200711121053396','1.000','1001',13,1,21,13),(29,'200711121053396','1.000','2001',13,1,21,13),(30,'200711121055216','1.000','1001',13,1,21,13),(31,'200711121055216','1.000','2001',13,1,21,13),(32,'200711121055216','1.000','213',12,1,21,12),(33,'200711121058165','1.000','1001',13,1,21,13),(34,'200711121058165','1.000','2001',13,1,21,13),(35,'200711121058165','1.000','213',12,1,21,12),(36,'200711121059572','1.000','1001',13,1,21,13),(37,'200711121059572','1.000','213',12,1,21,12),(38,'200711121059572','1.000','2001',13,1,21,13),(39,'200711121102201','1.000','1001',13,1,21,13),(40,'200711121102201','1.000','2001',13,1,21,13),(41,'200711121102201','1.000','213',12,1,21,12);
/*!40000 ALTER TABLE `saletransactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_info`
--

LOCK TABLES `schema_info` WRITE;
/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
INSERT INTO `schema_info` VALUES (2);
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) default NULL,
  `data` text,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `sessions_session_id_index` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'447b0ff76b61dab9a632a5b40d04d689','BAh7BzoMdXNlcl9pZG86CVVzZXIGOhBAYXR0cmlidXRlc3sOIglzYWx0IiAt\nNjExNDc0MjA4MC41MTI5MDM3NzI2Mzc3ODQiCW5hbWUiCmFkbWluIhBkYXRl\nX2Zvcm1hdCIAIg1sYW5ndWFnZSIGMSIUaGFzaGVkX3Bhc3N3b3JkIi02ZTE3\nZTA5NWVmODdmODQ1OGZkYWFkZDg3YTJjNjI0NzliMDU4MmY1IgphZG1pbiIG\nMSIHaWQiBzE4Ig9maXJzdF9uYW1lIgphZG1pbiIObGFzdF9uYW1lIgphZG1p\nbiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNoSGFz\naHsABjoKQHVzZWR7AA==\n','2007-11-11 01:59:50'),(2,'0e6522619e64de6af74716f907cbb324','BAh7BzoMdXNlcl9pZG86CVVzZXIGOhBAYXR0cmlidXRlc3sOIgluYW1lIgph\nZG1pbiIJc2FsdCIgLTYxMTQ3NDIwODAuNTEyOTAzNzcyNjM3Nzg0IhBkYXRl\nX2Zvcm1hdCIAIhRoYXNoZWRfcGFzc3dvcmQiLTZlMTdlMDk1ZWY4N2Y4NDU4\nZmRhYWRkODdhMmM2MjQ3OWIwNTgyZjUiDWxhbmd1YWdlIgYxIgphZG1pbiIG\nMSIHaWQiBzE4Ig9maXJzdF9uYW1lIgphZG1pbiIObGFzdF9uYW1lIgphZG1p\nbiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNoSGFz\naHsABjoKQHVzZWR7AA==\n','2007-11-11 20:17:05'),(3,'337ef02a6f7f35adb7aef07b0f782839','BAh7BzoMdXNlcl9pZG86CVVzZXIGOhBAYXR0cmlidXRlc3sOIgluYW1lIgph\nZG1pbiIJc2FsdCIgLTYxMTQ3NDIwODAuNTEyOTAzNzcyNjM3Nzg0IhBkYXRl\nX2Zvcm1hdCIAIhRoYXNoZWRfcGFzc3dvcmQiLTZlMTdlMDk1ZWY4N2Y4NDU4\nZmRhYWRkODdhMmM2MjQ3OWIwNTgyZjUiDWxhbmd1YWdlIgYxIgphZG1pbiIG\nMSIHaWQiBzE4Ig9maXJzdF9uYW1lIgphZG1pbiIObGFzdF9uYW1lIgphZG1p\nbiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNoSGFz\naHsABjoKQHVzZWR7AA==\n','2007-11-12 21:54:02');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
CREATE TABLE `stations` (
  `id` smallint(3) NOT NULL auto_increment,
  `ubication` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stations`
--

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
INSERT INTO `stations` VALUES (1,'Men Department'),(2,'Women Departmen');
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
CREATE TABLE `stores` (
  `id` smallint(4) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL default '',
  `address` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES (1,'Abarrotes y MercancÃ­as S.A.','Moliere 222 Col. Polanco'),(2,'Farmacias Sana FÃ¡cil','Av. de los Remedios 123');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
CREATE TABLE `tax_rates` (
  `id` int(11) NOT NULL auto_increment,
  `percent` decimal(3,1) default NULL,
  `description` varchar(50) default NULL,
  `code` int(11) default NULL,
  `percent_no_ded` decimal(3,1) default '0.0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tax_rates`
--

LOCK TABLES `tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_rates` DISABLE KEYS */;
INSERT INTO `tax_rates` VALUES (7,'20.0','20% VAT',20,'0.0'),(8,'10.0','10% VAT',10,'0.0'),(9,'0.0','No VAT',8,'0.0'),(10,'20.0','20% VAT(not ded.50%)',21,'50.0'),(11,'0.0','No, because ...',15,'0.0');
/*!40000 ALTER TABLE `tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tran_rows`
--

DROP TABLE IF EXISTS `tran_rows`;
CREATE TABLE `tran_rows` (
  `id` int(11) NOT NULL auto_increment,
  `tran_id` int(11) NOT NULL default '0',
  `account_id` int(11) default NULL,
  `debit` decimal(10,2) default NULL,
  `credit` decimal(10,2) default NULL,
  `tax_rate_id` int(11) default NULL,
  `tipo` char(1) NOT NULL,
  `debit_credit` char(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `tran_rows_ibfk_tran_id` (`tran_id`),
  KEY `tran_rows_ibfk_account_id` (`account_id`),
  KEY `tran_rows_ibfk_tax_rate_id` (`tax_rate_id`),
  CONSTRAINT `tran_rows_ibfk_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `tran_rows_ibfk_tax_rate_id` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`),
  CONSTRAINT `tran_rows_ibfk_tran_id` FOREIGN KEY (`tran_id`) REFERENCES `trans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tran_rows`
--

LOCK TABLES `tran_rows` WRITE;
/*!40000 ALTER TABLE `tran_rows` DISABLE KEYS */;
INSERT INTO `tran_rows` VALUES (1,1,970023,'7.16','0.00',NULL,'A','D'),(2,1,2310,'0.00','0.86',NULL,'V','C'),(3,1,4020,'0.00','2.30',7,'E','C'),(4,1,4030,'0.00','4.00',8,'E','C'),(5,2,970023,'56.89','0.00',NULL,'A','D'),(6,2,2310,'0.00','9.48',NULL,'V','C'),(7,2,4020,'0.00','45.41',7,'E','C'),(8,2,4030,'0.00','2.00',7,'E','C'),(9,3,970022,'31.70','0.00',NULL,'A','D'),(10,3,2310,'0.00','4.70',NULL,'V','C'),(11,3,4020,NULL,'20.00',7,'E','C'),(12,3,4030,NULL,'7.00',8,'E','C');
/*!40000 ALTER TABLE `tran_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tran_types`
--

DROP TABLE IF EXISTS `tran_types`;
CREATE TABLE `tran_types` (
  `id` int(11) NOT NULL auto_increment,
  `code` char(3) NOT NULL,
  `description` varchar(50) NOT NULL,
  `ask_doc_info` char(1) default NULL,
  `is_vat` char(1) default NULL,
  `vat_register_id` int(11) default NULL,
  `is_negative` char(1) default NULL,
  `account0_code` int(11) default NULL,
  `account0_debit_credit` char(1) default NULL,
  `account1_code` int(11) default NULL,
  `account1_debit_credit` char(1) default NULL,
  `account2_code` int(11) default NULL,
  `account2_debit_credit` char(1) default NULL,
  `account0_vat` int(11) default '0',
  `account1_vat` int(11) default '0',
  `account2_vat` int(11) default '0',
  PRIMARY KEY  (`id`),
  KEY `tran_types_ibfk_vat_register_id` (`vat_register_id`),
  KEY `tran_types_ibfk_account0_code` (`account0_code`),
  KEY `tran_types_ibfk_account1_code` (`account1_code`),
  KEY `tran_types_ibfk_account2_code` (`account2_code`),
  CONSTRAINT `tran_types_ibfk_account0_code` FOREIGN KEY (`account0_code`) REFERENCES `accounts` (`id`),
  CONSTRAINT `tran_types_ibfk_account1_code` FOREIGN KEY (`account1_code`) REFERENCES `accounts` (`id`),
  CONSTRAINT `tran_types_ibfk_account2_code` FOREIGN KEY (`account2_code`) REFERENCES `accounts` (`id`),
  CONSTRAINT `tran_types_ibfk_vat_register_id` FOREIGN KEY (`vat_register_id`) REFERENCES `vat_registers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tran_types`
--

LOCK TABLES `tran_types` WRITE;
/*!40000 ALTER TABLE `tran_types` DISABLE KEYS */;
INSERT INTO `tran_types` VALUES (2,'SIn','Sales Invoice','1','1',1,'0',4020,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'CCN','Customer credit note','1','1',1,'1',4020,NULL,NULL,NULL,NULL,NULL,7,NULL,NULL),(4,'VCN','Vendor credit note','1','1',2,'1',5010,NULL,NULL,NULL,NULL,NULL,7,NULL,NULL),(5,'fr','Free','0','0',NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,0,0,0),(8,'VPa','Vendor payment','0','0',NULL,'0',970025,'D',NULL,'C',NULL,NULL,0,0,0);
/*!40000 ALTER TABLE `tran_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trans`
--

DROP TABLE IF EXISTS `trans`;
CREATE TABLE `trans` (
  `id` int(11) NOT NULL auto_increment,
  `date` date NOT NULL default '0000-00-00',
  `tran_type_id` int(11) default '0',
  `description` varchar(50) default NULL,
  `doc_number` varchar(10) default NULL,
  `doc_date` date default NULL,
  `doc_reference_number` int(11) default '0',
  PRIMARY KEY  (`id`),
  KEY `trans_ibfk_tran_type_id` (`tran_type_id`),
  CONSTRAINT `trans_ibfk_tran_type_id` FOREIGN KEY (`tran_type_id`) REFERENCES `tran_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trans`
--

LOCK TABLES `trans` WRITE;
/*!40000 ALTER TABLE `trans` DISABLE KEYS */;
INSERT INTO `trans` VALUES (1,'2006-11-05',2,'Recorded invoice n. 1','1','2006-11-05',0),(2,'2006-11-05',2,'Recorded invoice n. 2','2','2006-11-05',0),(3,'2006-11-05',2,'Sales Invoice','12','2006-10-11',22);
/*!40000 ALTER TABLE `trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uemployees`
--

DROP TABLE IF EXISTS `uemployees`;
CREATE TABLE `uemployees` (
  `id` tinyint(2) NOT NULL,
  `employee_id` tinyint(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `uemployees`
--

LOCK TABLES `uemployees` WRITE;
/*!40000 ALTER TABLE `uemployees` DISABLE KEYS */;
INSERT INTO `uemployees` VALUES (1,1),(18,21),(19,21);
/*!40000 ALTER TABLE `uemployees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) default NULL,
  `hashed_password` char(40) default NULL,
  `first_name` varchar(255) default NULL,
  `last_name` varchar(255) default NULL,
  `language` tinyint(2) default '1',
  `date_format` varchar(10) default NULL,
  `admin` tinyint(1) default '0',
  `salt` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'emeza','bd11d5f61d5440a455d3b2535fd8fdf2d6d21ea5','Enrique','Meza',1,'',1,'-6118052380.917741211304414'),(18,'admin','6e17e095ef87f8458fdaadd87a2c62479b0582f5','admin','admin',1,'',1,'-6114742080.512903772637784'),(19,'nuevo','1975f0cca1a45aaca2682dea84277def9898ebf5','nuevo','nuevo',1,'',0,'-6127505180.938733971617085'),(21,'unomas','eef71cc88d947b9990e5476de58e633a59cf2272','unomas','unomas',1,'',0,'-6118417580.388379555895641');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vat_registers`
--

DROP TABLE IF EXISTS `vat_registers`;
CREATE TABLE `vat_registers` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) default NULL,
  `account_id` int(11) default NULL,
  `tipo` char(1) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `vat_registers_ibfk_account_id` (`account_id`),
  CONSTRAINT `vat_registers_ibfk_account_id` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vat_registers`
--

LOCK TABLES `vat_registers` WRITE;
/*!40000 ALTER TABLE `vat_registers` DISABLE KEYS */;
INSERT INTO `vat_registers` VALUES (1,'Sales','',2310,'C'),(2,'Purchase','',1230,'V');
/*!40000 ALTER TABLE `vat_registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wmsystems`
--

DROP TABLE IF EXISTS `wmsystems`;
CREATE TABLE `wmsystems` (
  `id` mediumint(2) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wmsystems`
--

LOCK TABLES `wmsystems` WRITE;
/*!40000 ALTER TABLE `wmsystems` DISABLE KEYS */;
INSERT INTO `wmsystems` VALUES (1,'PEPS/FIFO'),(2,'UEPS/LIFO'),(3,'PROMEDIO/AVERAGE');
/*!40000 ALTER TABLE `wmsystems` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2007-11-13 17:41:26

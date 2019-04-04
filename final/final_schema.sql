CREATE DATABASE  IF NOT EXISTS `final_schema`;
USE `final_schema`;

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `staff` varchar(50),
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES ('admin','password','yes');
INSERT INTO `users` VALUES ('test','test','no');
UNLOCK TABLES;

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `itemid` int,
  `username` varchar(50),
  `category` varchar(50) NOT NULL,
  `brand` varchar(50),
  `year` varchar(50),
  `type` varchar(50),
  PRIMARY KEY (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `auctions`;

CREATE TABLE `auctions` (
  `username` varchar(50),
  `itemid` int,
  

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bids`;

CREATE TABLE `bids` (
  `username` varchar(50),
  `itemid` int,


) ENGINE=InnoDB DEFAULT CHARSET=latin1;
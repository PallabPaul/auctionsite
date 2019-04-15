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
INSERT INTO `users` VALUES ('cr','cr','yes');
INSERT INTO `users` VALUES ('test','test','no');
UNLOCK TABLES;

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `auctionid` int,
  `username` varchar(50),
  `category` varchar(50) NOT NULL,
  `brand` varchar(50),
  `year` varchar(50),
  `type` varchar(50)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `auctions`;

CREATE TABLE `auctions` (
  `username` varchar(50),
  `auctionid` int,
  `startPrice` double,
  `curPrice` double,
  `endPrice` double,
  `reserve` double,
  `increment` double,
  `startTime` datetime,
  `endTime` datetime,
  `currBidder` varchar(50),
  `winner` varchar(50),
  PRIMARY KEY (`auctionid`) 

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `bidhistory`;

CREATE TABLE `bidhistory` (
  `bidder` varchar(50),
  `auctionid` int,
  `timeofbid` datetime,
  `currentprice` double,
  `priceofbid` double,
  `upperLimit` double

) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `requests`;

CREATE TABLE `requests` (
  `questionID` int,
  `username` varchar(50),
  `reqSubject` varchar(100),
  `message` TEXT,
  `response` TEXT,
  PRIMARY KEY (`questionID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

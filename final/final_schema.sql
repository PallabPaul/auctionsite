CREATE DATABASE  IF NOT EXISTS `final_schema`;
USE `final_schema`;

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `username` varchar(50),
  `category` varchar(50) NOT NULL,
  `brand` varchar(50),
  `year` varchar(50),
  `type` varchar(50),
  PRIMARY KEY (`username`,`category`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
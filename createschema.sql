create database contactlist1;
use contactlist1;

CREATE TABLE `contact` (                                                                                                                                                                                 
`contact_id` int(11) NOT NULL AUTO_INCREMENT,
`fname` varchar(255) DEFAULT NULL,
`mname` varchar(255) DEFAULT NULL,
`lname` varchar(255) DEFAULT NULL,
PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

 
CREATE TABLE `address` (
`address_id` int(11) NOT NULL AUTO_INCREMENT,
`contact_id` int(11) NOT NULL,
`address_type` varchar(60) DEFAULT NULL,
`address` varchar(255) DEFAULT NULL,
`city` varchar(60) DEFAULT NULL,
`state` varchar(60) DEFAULT NULL,                                                                                                       
 `zip` varchar(60) DEFAULT NULL,
 PRIMARY KEY (`address_id`),
 KEY `contact_id` (`contact_id`),
 CONSTRAINT `address_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE CASCADE
 )ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `phone` (
`phone_id` int(11) NOT NULL AUTO_INCREMENT,
`contact_id` int(11) NOT NULL,
`phone_type` varchar(60) DEFAULT NULL,
`area_code` varchar(20) DEFAULT NULL,
`number` varchar(60) DEFAULT NULL,
PRIMARY KEY (`phone_id`),
KEY `contact_id` (`contact_id`),
CONSTRAINT `phone_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `date` (
`date_id` int(11) NOT NULL AUTO_INCREMENT,
`contact_id` int(11) NOT NULL,
`date_type` varchar(60) DEFAULT NULL,
`date` bigint(8) DEFAULT NULL,
PRIMARY KEY (`date_id`),
KEY `contact_id` (`contact_id`),
CONSTRAINT `date_ibfk_1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
 
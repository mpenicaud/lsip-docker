-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: SIP
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.14.04.1-log

create database SIP;
use SIP;
SET FOREIGN_KEY_CHECKS=0;
 DROP TABLE IF EXISTS `Users`;

 CREATE TABLE `Users` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `nom` varchar(45) DEFAULT NULL,
   `prenom` varchar(45) DEFAULT NULL,
   `profil` varchar(45) NOT NULL,
   `login` varchar(45) NOT NULL,
   `password` varchar(45) NOT NULL,
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


--
-- Table structure for table `Sources`
--

 DROP TABLE IF EXISTS `Sources`;

 CREATE TABLE `Sources` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `name` varchar(45) NOT NULL,
   `passphrase` varchar(45) DEFAULT NULL,
   `admin` int(11) NOT NULL,
   `webapp` int(11) NOT NULL,
   PRIMARY KEY (`id`),
  KEY `fk_Sources_1_idx` (`admin`),
   KEY `fk_Sources_2_idx` (`webapp`),
   CONSTRAINT `fk_Sources_1` FOREIGN KEY (`admin`) REFERENCES `Users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
   CONSTRAINT `fk_Sources_2` FOREIGN KEY (`webapp`) REFERENCES `Users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Patients`;

CREATE TABLE `Patients` (
  `id` int(10) NOT NULL,
  `birthName` varchar(100) NOT NULL,
  `useName` varchar(100) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `birthDate` datetime NOT NULL,
  `source` int(11) NOT NULL,
  `sex` varchar(45) NOT NULL,
`birthPlace` varchar(45) default NULL,
  `sourceId` varchar(45) DEFAULT '0',
`shKey` varchar(100) default NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Patients_Sources1_idx` (`source`),
  CONSTRAINT `fk_Patients_Sources1` FOREIGN KEY (`source`) REFERENCES `Sources` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `Rapprochement`;

CREATE TABLE `Rapprochement` (
  `idRapprochement` int(11) NOT NULL AUTO_INCREMENT,
  `idPat1` int(11) NOT NULL,
  `idPat2` int(11) NOT NULL,
  `validated` enum('0','1','2') NOT NULL DEFAULT '0',
  PRIMARY KEY (`idRapprochement`),
  KEY `fk_Rapprochement_Patients1_idx` (`idPat1`),
  KEY `fk_Rapprochement_Patients2_idx` (`idPat2`),
  CONSTRAINT `fk_Rapprochement_Patients1` FOREIGN KEY (`idPat1`) REFERENCES `Patients` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rapprochement_Patients2` FOREIGN KEY (`idPat2`) REFERENCES `Patients` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


DROP PROCEDURE IF EXISTS `detect_rapprochement2`;

DELIMITER $$
CREATE PROCEDURE `detect_rapprochement2`(
IN id int
,IN birthName varchar(45)
, IN useName varchar (255)
, IN firstName varchar (255)
, IN birthDate datetime
, IN origine int
, IN sex varchar (255)
, IN sourceId varchar(45)

)
BEGIN
DROP temporary table  if exists tempPat;
DROP temporary table  if exists   tempPat2;
#5 criteres
create temporary table tempPat as
select * from Patients p where(
p.birthName = birthName
AND p.useName = useName
AND p.firstName = firstName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
AND p.sex = sex
)
# 4 criteres
UNION
select * from Patients p where (
p.useName = useName
AND p.firstName = firstName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
AND p.sex = sex
)
UNION
select * from Patients p where (
p.birthName = birthName

AND p.firstName = firstName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
AND p.sex = sex
)
UNION
select * from Patients p where (
p.birthName = birthName
AND p.useName = useName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
AND p.sex = sex
)
UNION
select * from Patients p where (
p.birthName = birthName
AND p.useName = useName
AND p.firstName = firstName
AND p.sex = sex
)
UNION
select * from Patients p where (
p.birthName = birthName
AND p.useName = useName
AND p.firstName = firstName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
)
#3 criteres
UNION
select  * from Patients p where (
p.firstName = firstName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
AND p.sex = sex
)
UNION
select * from Patients p where (
p.useName = useName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
AND p.sex = sex
)
UNION
select * from Patients p where (
 p.useName = useName
AND p.firstName = firstName
AND p.sex = sex
)
UNION
select * from Patients p where (
 p.useName = useName
AND p.firstName = firstName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
)
UNION
select * from Patients p where (
p.birthName = birthName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
AND p.sex = sex
)
UNION
select * from Patients p where (
p.birthName = birthName
AND p.firstName = firstName
AND p.sex = sex
)
UNION
select * from Patients p where (
p.birthName = birthName
AND p.firstName = firstName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
)
#UNION
#select * from Patients p where (
#p.birthName = birthName
#AND p.useName = useName
#AND p.sex = sex
#)
UNION
select * from Patients p where (
p.birthName = birthName
AND p.useName = useName
AND YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
)
UNION
select * from Patients p where (
p.birthName = birthName
AND p.useName = useName
AND p.firstName = firstName
)
;
/*
select  id from Patients p where (p.source!=source AND
YEAR(p.birthDate) = YEAR(birthdate) AND MONTH(p.birthDate) = MONTH(birthDate)
);
*/

create temporary table   tempPat2 as
select tp.id from tempPat tp where tp.id not in (select idPat1 from Rapprochement where idPat2=id union select idPat2 from Rapprochement where idPat1 = id union select id from Patients p where p.id = id);

insert into Rapprochement (idPat1, idPat2) (select tp2.id,id from   tempPat2 tp2);
END$$
DELIMITER ;


SET FOREIGN_KEY_CHECKS=1;


-- init system admin user
INSERT INTO `Users` ( `id`,`profil`, `login`, `password`) VALUES ('1','1','admin','lsip');

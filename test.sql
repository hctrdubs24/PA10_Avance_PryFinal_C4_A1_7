SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `ahhhh` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci;
USE `ahhhh`;

CREATE TABLE IF NOT EXISTS `capellid` (
  `CvApellid` int(3) NOT NULL AUTO_INCREMENT,
  `DsApellid` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvApellid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `capellid` (`CvApellid`, `DsApellid`) VALUES
(1, 'Rosado'),
(2, 'Ruedas'),
(3, 'Rodas'),
(4, 'Manchado'),
(5, 'Calles'),
(6, 'Moreno'),
(7, 'Ortiz'),
(8, 'Menchaca'),
(9, 'Alfaro'),
(10, 'Urias');

CREATE TABLE IF NOT EXISTS `ccalle` (
  `CvCalle` int(3) NOT NULL AUTO_INCREMENT,
  `DsCalle` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvCalle`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `ccalle` (`CvCalle`, `DsCalle`) VALUES
(1, 'Benito Juarez'),
(2, 'Reforma'),
(3, 'Peñarol'),
(4, 'Conde Garay');

CREATE TABLE IF NOT EXISTS `ccolon` (
  `CvColon` int(3) NOT NULL AUTO_INCREMENT,
  `DsColon` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvColon`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `ccolon` (`CvColon`, `DsColon`) VALUES
(1, 'Xalpa'),
(2, 'Cosmopolita'),
(3, 'Santa lucia'),
(4, 'La libertad');

CREATE TABLE IF NOT EXISTS `cestado` (
  `CvEstado` int(3) NOT NULL AUTO_INCREMENT,
  `DsEstado` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `cestado` (`CvEstado`, `DsEstado`) VALUES
(1, 'Sinaloa'),
(2, 'Chiapas'),
(3, 'Veracuz'),
(4, 'Puebla');

CREATE TABLE IF NOT EXISTS `cgenero` (
  `CvGenero` int(3) NOT NULL AUTO_INCREMENT,
  `DsGenero` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvGenero`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `cgenero` (`CvGenero`, `DsGenero`) VALUES
(1, 'Masculino'),
(2, 'Femenino');

CREATE TABLE IF NOT EXISTS `cmunic` (
  `CvMunic` int(3) NOT NULL AUTO_INCREMENT,
  `DsMunic` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvMunic`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `cmunic` (`CvMunic`, `DsMunic`) VALUES
(1, 'San cristobal'),
(2, 'Soltepec'),
(3, 'Novalto'),
(4, 'Cordoba');

CREATE TABLE IF NOT EXISTS `cnombre` (
  `CvNombre` int(3) NOT NULL AUTO_INCREMENT,
  `DsNombre` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvNombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `cnombre` (`CvNombre`, `DsNombre`) VALUES
(1, 'Juan'),
(2, 'Rosalia'),
(3, 'Rosario'),
(4, 'Apolinar'),
(5, 'Guadalupe');

CREATE TABLE IF NOT EXISTS `ctipoperso` (
  `CvTipoPerso` int(3) NOT NULL AUTO_INCREMENT,
  `DsTipoPerso` varchar(20) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvTipoPerso`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `ctipoperso` (`CvTipoPerso`, `DsTipoPerso`) VALUES
(1, 'Empleado'),
(2, 'Administrador'),
(3, 'Proveedor'),
(4, 'Cliente');

CREATE TABLE IF NOT EXISTS `mdirecc` (
  `CvDirecc` int(3) NOT NULL AUTO_INCREMENT,
  `CvCalle` int(3) NOT NULL,
  `CvColon` int(3) NOT NULL,
  `CvMunic` int(3) NOT NULL,
  `CvEstado` int(3) NOT NULL,
  `NumExt` varchar(6) COLLATE latin1_spanish_ci DEFAULT NULL,
  `CP` varchar(5) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`CvDirecc`),
  KEY `D_fk_cCalle` (`CvCalle`),
  KEY `D_fk_cColon` (`CvColon`),
  KEY `D_fk_cMunic` (`CvMunic`),
  KEY `D_fk_cEstado` (`CvEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `mdirecc` (`CvDirecc`, `CvCalle`, `CvColon`, `CvMunic`, `CvEstado`, `NumExt`, `CP`) VALUES
(1, 2, 4, 3, 1, '17', '89238'),
(2, 1, 2, 1, 2, '475', '51363'),
(3, 4, 3, 2, 4, '78', '30232'),
(4, 3, 1, 4, 3, '398', '30083');

CREATE TABLE IF NOT EXISTS `mperso` (
  `CvPerso` int(3) NOT NULL AUTO_INCREMENT,
  `CvTipoPerso` int(3) NOT NULL,
  `CvNombre` int(3) NOT NULL,
  `CvApePat` int(3) NOT NULL,
  `CvApeMat` int(3) NOT NULL,
  `CvGenero` int(3) NOT NULL,
  `FecNac` date NOT NULL,
  `Edad` int(5) NOT NULL,
  `RFC` varchar(13) COLLATE latin1_spanish_ci DEFAULT NULL,
  `CURP` varchar(18) COLLATE latin1_spanish_ci NOT NULL,
  `Telefono` varchar(13) COLLATE latin1_spanish_ci NOT NULL,
  `Correo` varchar(80) COLLATE latin1_spanish_ci DEFAULT NULL,
  `CvDirecc` int(3) DEFAULT NULL,
  PRIMARY KEY (`CvPerso`),
  KEY `Per_fk_cNombre` (`CvNombre`),
  KEY `Per_fk_cTipoPerso` (`CvTipoPerso`),
  KEY `Per_fk_cApePat` (`CvApePat`),
  KEY `Per_fk_cApeMat` (`CvApeMat`),
  KEY `Per_fk_cGenero` (`CvGenero`),
  KEY `Per_fk_mDirecc` (`CvDirecc`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `mperso` (`CvPerso`, `CvTipoPerso`, `CvNombre`, `CvApePat`, `CvApeMat`, `CvGenero`, `FecNac`, `Edad`, `RFC`, `CURP`, `Telefono`, `Correo`, `CvDirecc`) VALUES
(1, 2, 1, 1, 4, 1, '1990-09-09', 32, 'XDF1889654778', 'SDF188965477887LA7', '963-143-76-88', 'esteañoeselbueno@hotmail.com', 1),
(2, 3, 2, 2, 5, 1, '1980-09-09', 25, 'SDF1889654778', 'WEF188965477887LA2', '963-113-45-54', 'daskjs@outlook.com', 2),
(3, 2, 1, 3, 8, 1, '1970-09-09', 26, 'ASF1889654778', 'AHF188965477887LA8', '963-114-67-73', 'jfkMaster@hotmail.com', 3),
(4, 1, 3, 4, 2, 2, '1990-08-08', 23, 'HFF1889654778', 'HTF188965477887LA3', '963-117-43-56', 'fgmovil@gmail.com', 4),
(5, 1, 4, 5, 1, 1, '1980-08-08', 25, 'ngvgvfcwfdc d', 'd<medjbehdved v cd', '7854692561', '4@test.com', 4),
(6, 2, 3, 9, 10, 2, '1970-08-08', 68, ',enj fbeh bf', 'mjs djbsj db', '9865357458', '5test@uwu.com', 1),
(7, 2, 5, 7, 9, 1, '1990-07-07', 98, 'fu efyvefyv e', 'sndhv d v', '7854698523', 'miku@ahhhh.com', 4),
(8, 4, 2, 5, 10, 1, '1990-05-05', 56, 'bg fr rx r', 'iwe uheg eynv', '9657458769', 'correo@correo@correo.dev', 2),
(9, 2, 3, 10, 2, 1, '1980-05-05', 22, 'jwnugdydbwtdb', 'kwjdunydgby', '9635897456', 'hagowebs@enwordpress.com', 1);

CREATE TABLE IF NOT EXISTS `musuario` (
  `CvUser` int(3) NOT NULL AUTO_INCREMENT,
  `CvPerso` int(3) NOT NULL,
  `NomUser` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `Contrasena` varchar(10) COLLATE latin1_spanish_ci NOT NULL,
  `FechaIni` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `EdoCta` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`CvUser`),
  KEY `Usr_fk_cPerso` (`CvPerso`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

INSERT INTO `musuario` (`CvUser`, `CvPerso`, `NomUser`, `Contrasena`, `FechaIni`, `FechaFin`, `EdoCta`) VALUES
(1, 2, 'Rosalia', 'chalia', '2022-10-10', '2022-10-19', 0),
(2, 6, 'Rosario', 'charis', '2022-10-11', '2022-10-21', 0),
(3, 7, 'Guadalupe', 'lupe', '2022-11-01', '2022-11-30', 1),
(4, 9, 'admin', 'admin1', '2022-10-22', '2022-12-02', 1),
(23, 1, 'Rosado', 'lupe', '2022-11-08', '2022-11-13', 1);

ALTER TABLE `mdirecc`
  ADD CONSTRAINT `D_fk_cCalle` FOREIGN KEY (`CvCalle`) REFERENCES `ccalle` (`CvCalle`),
  ADD CONSTRAINT `D_fk_cColon` FOREIGN KEY (`CvColon`) REFERENCES `ccolon` (`CvColon`),
  ADD CONSTRAINT `D_fk_cEstado` FOREIGN KEY (`CvEstado`) REFERENCES `cestado` (`CvEstado`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `D_fk_cMunic` FOREIGN KEY (`CvMunic`) REFERENCES `cmunic` (`CvMunic`);

ALTER TABLE `mperso`
  ADD CONSTRAINT `Per_fk_cApeMat` FOREIGN KEY (`CvApeMat`) REFERENCES `capellid` (`CvApellid`),
  ADD CONSTRAINT `Per_fk_cApePat` FOREIGN KEY (`CvApePat`) REFERENCES `capellid` (`CvApellid`),
  ADD CONSTRAINT `Per_fk_cGenero` FOREIGN KEY (`CvGenero`) REFERENCES `cgenero` (`CvGenero`),
  ADD CONSTRAINT `Per_fk_cNombre` FOREIGN KEY (`CvNombre`) REFERENCES `cnombre` (`CvNombre`),
  ADD CONSTRAINT `Per_fk_cTipoPerso` FOREIGN KEY (`CvTipoPerso`) REFERENCES `ctipoperso` (`CvTipoPerso`),
  ADD CONSTRAINT `Per_fk_mDirecc` FOREIGN KEY (`CvDirecc`) REFERENCES `mdirecc` (`CvDirecc`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `musuario`
  ADD CONSTRAINT `Usr_fk_cPerso` FOREIGN KEY (`CvPerso`) REFERENCES `mperso` (`CvPerso`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

-- MySQL Script generated by MySQL Workbench
-- lun. 11 nov. 2019 09:31:28 GMT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_doc_administrative
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bd_doc_administrative
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_doc_administrative` ;
USE `bd_doc_administrative` ;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`reference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`reference` (
  `idreference` INT NOT NULL AUTO_INCREMENT,
  `libelle_reference` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idreference`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`confirmation_paiement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`confirmation_paiement` (
  `idconfirmation_paiement` INT NOT NULL AUTO_INCREMENT,
  `numero_tel` VARCHAR(45) NULL,
  `code_confirmation` VARCHAR(45) NULL,
  `valide` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idconfirmation_paiement`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`paiement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`paiement` (
  `idpaiement` INT NOT NULL AUTO_INCREMENT,
  `fk_idreference` INT NOT NULL,
  `fk_idconfirmation_paiement` INT NOT NULL,
  PRIMARY KEY (`idpaiement`, `fk_idreference`, `fk_idconfirmation_paiement`),
  INDEX `fk_paiement_type_paiement1_idx` (`fk_idreference` ASC),
  INDEX `fk_paiement_confirmation_paiement1_idx` (`fk_idconfirmation_paiement` ASC),
  CONSTRAINT `fk_paiement_type_paiement1`
    FOREIGN KEY (`fk_idreference`)
    REFERENCES `bd_doc_administrative`.`reference` (`idreference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paiement_confirmation_paiement1`
    FOREIGN KEY (`fk_idconfirmation_paiement`)
    REFERENCES `bd_doc_administrative`.`confirmation_paiement` (`idconfirmation_paiement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`date` (
  `iddate` INT NOT NULL,
  `date_complet` DATE NULL,
  `jour` VARCHAR(45) NULL,
  `mois` VARCHAR(45) NULL,
  `annee` VARCHAR(45) NULL,
  PRIMARY KEY (`iddate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`category_demande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`category_demande` (
  `idcategory_demande` INT NOT NULL AUTO_INCREMENT,
  `libelle_category` VARCHAR(50) NULL,
  PRIMARY KEY (`idcategory_demande`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`personne`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`personne` (
  `idpersonne` INT NOT NULL AUTO_INCREMENT,
  `prenom` VARCHAR(100) NOT NULL,
  `nom` VARCHAR(100) NOT NULL,
  `age` INT NOT NULL,
  `telephone` VARCHAR(45) NOT NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idpersonne`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`type_document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`type_document` (
  `idtype_document` INT NOT NULL AUTO_INCREMENT,
  `libelle_document` VARCHAR(45) NULL,
  PRIMARY KEY (`idtype_document`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`etat_civil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`etat_civil` (
  `idetat_civil` INT NOT NULL AUTO_INCREMENT,
  `libelle_etat_civil` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idetat_civil`))
ENGINE = InnoDB ;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`document`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`document` (
  `iddocument` INT NOT NULL AUTO_INCREMENT,
  `numero_registre` VARCHAR(45) NOT NULL,
  `annee_enregistrement` VARCHAR(45) NOT NULL,
  `fk_idtype_document` INT NOT NULL,
  `fk_idetat_civil_document` INT NOT NULL,
  PRIMARY KEY (`iddocument`, `fk_idtype_document`, `fk_idetat_civil_document`),
  INDEX `fk_document_type_document1_idx` (`fk_idtype_document` ASC),
  INDEX `fk_document_etat_civil1_idx` (`fk_idetat_civil_document` ASC),
  CONSTRAINT `fk_document_type_document1`
    FOREIGN KEY (`fk_idtype_document`)
    REFERENCES `bd_doc_administrative`.`type_document` (`idtype_document`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_document_etat_civil1`
    FOREIGN KEY (`fk_idetat_civil_document`)
    REFERENCES `bd_doc_administrative`.`etat_civil` (`idetat_civil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`demande`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`demande` (
  `iddemande` INT NOT NULL AUTO_INCREMENT,
  `nombre_copie` INT NOT NULL,
  `fk_idpaiement` INT NOT NULL,
  `fk_iddate` INT NOT NULL,
  `fk_idcategory_demande` INT NOT NULL,
  `fk_idpersonne` INT NOT NULL,
  `fk_iddocument` INT NOT NULL,
  PRIMARY KEY (`iddemande`, `fk_idpaiement`, `fk_iddate`, `fk_idcategory_demande`, `fk_idpersonne`, `fk_iddocument`),
  INDEX `fk_demande_paiement1_idx` (`fk_idpaiement` ASC),
  INDEX `fk_demande_date1_idx` (`fk_iddate` ASC),
  INDEX `fk_demande_category_demande1_idx` (`fk_idcategory_demande` ASC),
  INDEX `fk_demande_personne1_idx` (`fk_idpersonne` ASC),
  INDEX `fk_demande_document1_idx` (`fk_iddocument` ASC),
  CONSTRAINT `fk_demande_paiement1`
    FOREIGN KEY (`fk_idpaiement`)
    REFERENCES `bd_doc_administrative`.`paiement` (`idpaiement`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_demande_date1`
    FOREIGN KEY (`fk_iddate`)
    REFERENCES `bd_doc_administrative`.`date` (`iddate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_demande_category_demande1`
    FOREIGN KEY (`fk_idcategory_demande`)
    REFERENCES `bd_doc_administrative`.`category_demande` (`idcategory_demande`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_demande_personne1`
    FOREIGN KEY (`fk_idpersonne`)
    REFERENCES `bd_doc_administrative`.`personne` (`idpersonne`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_demande_document1`
    FOREIGN KEY (`fk_iddocument`)
    REFERENCES `bd_doc_administrative`.`document` (`iddocument`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = armscii8;


-- -----------------------------------------------------
-- Table `bd_doc_administrative`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_doc_administrative`.`admin` (
  `idadmin` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `privilege` VARCHAR(45) NOT NULL,
  `fk_idpersonne` INT NOT NULL,
  `fk_idetat_civil_admin` INT NOT NULL,
  PRIMARY KEY (`idadmin`, `fk_idpersonne`, `fk_idetat_civil_admin`),
  INDEX `fk_admin_personne1_idx` (`fk_idpersonne` ASC),
  INDEX `fk_admin_etat_civil1_idx` (`fk_idetat_civil_admin` ASC),
  CONSTRAINT `fk_admin_personne1`
    FOREIGN KEY (`fk_idpersonne`)
    REFERENCES `bd_doc_administrative`.`personne` (`idpersonne`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admin_etat_civil1`
    FOREIGN KEY (`fk_idetat_civil_admin`)
    REFERENCES `bd_doc_administrative`.`etat_civil` (`idetat_civil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Script generated by MySQL Workbench
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ecommerce` ;

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`category` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`category` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`customer` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`customer` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `cc_number` VARCHAR(19) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`customer_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`customer_order` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`customer_order` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(6,2) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmation_number` INT(10) UNSIGNED NOT NULL,
  `customer_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_order_customer` (`customer_id` ASC) INVISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`product` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`product` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `description` TINYTEXT NULL DEFAULT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_category` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `ecommerce`.`category` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`ordered_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`ordered_product` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`ordered_product` (
  `customer_order_id` INT(10) UNSIGNED NOT NULL,
  `product_id` INT(10) UNSIGNED NOT NULL,
  `quantity` INT(10) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`customer_order_id`, `product_id`),
  INDEX `fk_ordered_product_product` (`product_id` ASC) INVISIBLE,
  INDEX `fk_ordered_product_customer_order` (`customer_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_ordered_product_customer_order`
    FOREIGN KEY (`customer_order_id`)
    REFERENCES `ecommerce`.`customer_order` (`id`),
  CONSTRAINT `fk_ordered_product_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecommerce`.`product` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `ecommerce`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ecommerce`.`user` ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`user` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Insert some data into product table
-- -----------------------------------------------------

INSERT INTO `product` (`name`, price, description, category_id) VALUES ('milk', 1.70, 'semi skimmed (1L)', 1);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('cheese', 2.39, 'mild cheddar (330g)', 1);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('butter', 1.09, 'unsalted (250g)', 1);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('free range eggs', 1.76, 'medium-sized (6 eggs)', 1);

INSERT INTO `product` (`name`, price, description, category_id) VALUES ('organic meat patties', 2.29, 'rolled in fresh herbs<br>2 patties (250g)', 2);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('parma ham', 3.49, 'matured, organic (70g)', 2);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('chicken leg', 2.59, 'free range (250g)', 2);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('sausages', 3.55, 'reduced fat, pork<br>3 sausages (350g)', 2);

INSERT INTO `product` (`name`, price, description, category_id) VALUES ('sunflower seed loaf', 1.89, '600g', 3);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('sesame seed bagel', 1.19, '4 bagels', 3);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('pumpkin seed bun', 1.15, '4 buns', 3);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('chocolate cookies', 2.39, 'contain peanuts<br>(3 cookies)', 3);

INSERT INTO `product` (`name`, price, description, category_id) VALUES ('corn on the cob', 1.59, '2 pieces', 4);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('red currants', 2.49, '150g', 4);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('broccoli', 1.29, '500g', 4);
INSERT INTO `product` (`name`, price, description, category_id) VALUES ('seedless watermelon', 1.49, '250g', 4);
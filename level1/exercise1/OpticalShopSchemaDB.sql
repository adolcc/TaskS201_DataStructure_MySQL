-- Configuration to start.

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, 
SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Database: optical_shop_db
-- Drop the database if it already exists to ensure a clean start.
DROP SCHEMA IF EXISTS `optical_shop_db` ;

-- Creating schema from scratch.
CREATE SCHEMA IF NOT EXISTS `optical_shop_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

-- Selecting the correct database.
USE `optical_shop_db`;

-- Table: Supplier
-- Drop the Supplier table if it already exists. For a clean start.
DROP TABLE IF EXISTS `Supplier` ;

-- Create the Supplier table.
CREATE TABLE IF NOT EXISTS `Supplier` (
  `id_supplier` INT NOT NULL AUTO_INCREMENT, 
  `name` VARCHAR(100) NOT NULL,              
  `street` VARCHAR(100) NULL,                
  `number` VARCHAR(10) NULL,                 
  `floor` VARCHAR(10) NULL,                  
  `door` VARCHAR(10) NULL,                   
  `city` VARCHAR(50) NULL,                   
  `postal_code` VARCHAR(10) NULL,            
  `country` VARCHAR(50) NULL,                
  `phone` VARCHAR(20) NULL,                  
  `fax` VARCHAR(20) NULL,                    
  `nif` VARCHAR(20) NOT NULL UNIQUE,         
  PRIMARY KEY (`id_supplier`)                
)
ENGINE = InnoDB; 

-- Data for Table `Supplier`
-- Inserting sample data into the Supplier table.
-- Supplier with all data.
INSERT INTO `Supplier`(
    `name`, `street`, `number`, `floor`, `door`, `city`, `postal_code`, `country`, `phone`, `fax`, `nif`
) VALUES (
    'Bna Glasses', 'Gaudi Street', '29', '7', '2', 'Barcelona', '08740', 'Spain', '651000000', '651000000', 'B12345678'
);

-- Supplier with less data.
INSERT INTO `Supplier`(
    `name`, `city`, `country`, `phone`, `nif`
) VALUES (
    'Caracas Glass', 'Caracas', 'Venezuela', '0414000000', 'C12345678'
);

-- Another supplier for practice
INSERT INTO `Supplier`(
    `name`, `country`, `phone`, `nif`
) VALUES (
    'Bio Glass', 'Argentina', '+54 11 4321-5678', 'D99887766' 
);

-- Table: Glasses
-- Drop the Glasses table if it already exists. For clena start.
DROP TABLE IF EXISTS `Glasses` ; 

-- Create the Glasses table.
CREATE TABLE IF NOT EXISTS `Glasses` (
  `id_glasses` INT NOT NULL AUTO_INCREMENT, 
  `brand` VARCHAR(50) NOT NULL,
  `left_lens_prescription` DECIMAL(4,2) NULL, 
  `right_lens_prescription` DECIMAL(4,2) NULL, 
  `frame_type` ENUM('floating', 'pasta', 'metallic') NOT NULL, 
  `frame_color` VARCHAR(30) NULL,             
  `left_lens_color` VARCHAR(30) NULL,         
  `right_lens_color` VARCHAR(30) NULL,        
  `price` DECIMAL(10,2) NOT NULL,

  `id_supplier` INT NOT NULL, 

  PRIMARY KEY (`id_glasses`), 

  -- Define the Foreign Key constraint:

  CONSTRAINT `fk_glasses_supplier`
    FOREIGN KEY (`id_supplier`) 
    REFERENCES `Supplier` (`id_supplier`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION  
)
ENGINE = InnoDB; 

-- Data for Table `Glasses`
-- Inserting sample data into the Glasses table.
-- Glasses "Bna Glasses" 
INSERT INTO `Glasses` (
    `brand`, `left_lens_prescription`, `right_lens_prescription`,
    `frame_type`, `frame_color`, `left_lens_color`, `right_lens_color`,
    `price`, `id_supplier`
) VALUES (
    'Oakley', 1.25, 1.00,
    'metallic', 'Black', 'Clear', 'Clear',
    120.00, 1
);

-- Glasses "Caracas Glass" 
INSERT INTO `Glasses` (
    `brand`, `left_lens_prescription`, `right_lens_prescription`,
    `frame_type`, `frame_color`, `left_lens_color`, `right_lens_color`,
    `price`, `id_supplier`
) VALUES (
    'Ray-Ban', NULL, NULL, -- Gafas de sol, sin graduación
    'pasta', 'Brown', 'Dark', 'Dark',
    95.50, 2
);

-- Glasses "Bio Glass" 
INSERT INTO `Glasses` (
    `brand`, `left_lens_prescription`, `right_lens_prescription`,
    `frame_type`, `frame_color`, `left_lens_color`, `right_lens_color`,
    `price`, `id_supplier`
) VALUES (
    'Minimalist', NULL, NULL, -- Sin graduación, campos NULL
    'pasta', 'Transparent', 'Clear', 'Clear',
    80.00, 3
);


-- Table: Client

-- Drop the Client table if it already exists. Clean start.
DROP TABLE IF EXISTS `Client` ;

-- Creating the Client table.
CREATE TABLE IF NOT EXISTS `Client` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `street` VARCHAR(100) NULL,
  `number` VARCHAR(10) NULL,
  `floor` VARCHAR(10) NULL,
  `door` VARCHAR(10) NULL,
  `city` VARCHAR(50) NULL,
  `postal_code` VARCHAR(10) NULL,
  `country` VARCHAR(50) NULL,
  `phone` VARCHAR(20) NULL,
  `email` VARCHAR(100) UNIQUE NULL, 
  `registration_date` DATE NOT NULL, 
  `referred_by_id_client` INT NULL, 
  PRIMARY KEY (`id_client`),

  -- Foreign Key for clients referred by another client 
  CONSTRAINT `fk_client_referred_by`
    FOREIGN KEY (`referred_by_id_client`)
    REFERENCES `Client` (`id_client`)
    ON DELETE SET NULL 
    ON UPDATE CASCADE 
)
ENGINE = InnoDB;

-- Data for Table `Client`

-- Client 1: Complete details
INSERT INTO `Client` (
    `name`, `street`, `number`, `floor`, `door`,
    `city`, `postal_code`, `country`, `phone`, `email`, `registration_date`
) VALUES (
    'Adolfo Caicaguare', 'Diagonal Avenue', '345', '3', '1A',
    'Barcelona', '08470', 'Spain', '651000000', 'adolfo@example.com', '2023-01-15'
);

-- Client 2: Referred by Client 1
INSERT INTO `Client` (
    `name`, `street`, `number`,
    `city`, `postal_code`, `country`, `phone`, `email`, `registration_date`, `referred_by_id_client`
) VALUES (
    'Juan Perez', 'Major Street', '10',
    'Madrid', '28001', 'Spain', '611222333', 'juan.perez@example.com', '2023-03-20', 1
);

-- Client 3: Minimal details
INSERT INTO `Client` (
    `name`, `phone`, `registration_date`
) VALUES (
    'Pepe Lopez', '622333444', '2024-01-05'
);


-- Table: Employee

-- Drop the Employee table for a clean start.
DROP TABLE IF EXISTS `Employee`; 

-- Creating the Employee table.
CREATE TABLE IF NOT EXISTS `Employee`(
  `id_employee`INT NOT NULL AUTO_INCREMENT, 
  `name`VARCHAR (100) NOT NULL, 
  `last_name`VARCHAR (100) NOT NULL, 
  `nif`VARCHAR (20) NOT NULL UNIQUE, -- Corrected VARCHAR(100) to VARCHAR(20)
  `role`VARCHAR (100) NULL, -- Corrected 'rol' to 'role'
  `phone`VARCHAR (20) NULL, -- Corrected VARCHAR(100) to VARCHAR(20)
  PRIMARY KEY(`id_employee`)
)
ENGINE = InnoDB; 

-- Data for Table `Employee`

-- Employee 1: Adolfo Caicaguare
INSERT INTO `Employee` (
    `name`, `last_name`, `nif`, `role`, `phone`
) VALUES (
    'Adolfo', 'Caicaguare', '600000000A', 'Customer Care', '651000000'
);

-- Employee 2: Pepe Lopez
INSERT INTO `Employee` (
    `name`, `last_name`, `nif`, `role`
) VALUES (
    'Pepe', 'Lopez', '666666666L', 'Sales'
);

-- Employee 3: Pedro Gonzalez
INSERT INTO `Employee` (
    `name`, `last_name`, `nif`
) VALUES (
    'Pedro', 'Gonzalez', '777777777K' 
);


-- Table: Sale

-- Drop the Sale table for a clean start.
DROP TABLE IF EXISTS `Sale` ;

-- Creating the Sale table.
CREATE TABLE IF NOT EXISTS `Sale` (
  `id_sale` INT NOT NULL AUTO_INCREMENT,
  `sale_date` DATETIME NOT NULL, 
  `total_amount` DECIMAL(10,2) NOT NULL, 

  -- Foreign Keys linking to Client and Employee
  `id_client` INT NOT NULL,    
  `id_employee` INT NOT NULL,  
  PRIMARY KEY (`id_sale`),

  -- Define Foreign Key constraints:
  CONSTRAINT `fk_sale_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `Client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_sale_employee`
    FOREIGN KEY (`id_employee`)
    REFERENCES `Employee` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

-- Data for Table `Sale`

-- Sale 1: Client 1 (Adolfo Caicaguare) 
INSERT INTO `Sale` (
    `sale_date`, `total_amount`, `id_client`, `id_employee`
) VALUES (
    '2024-05-10 10:30:00', 120.00, 1, 1 
);

-- Sale 2: Client 2 (Juan Perez)
INSERT INTO `Sale` (
    `sale_date`, `total_amount`, `id_client`, `id_employee`
) VALUES (
    '2024-05-15 14:00:00', 95.50, 2, 2 
);

-- Sale 3: Client 3 (Pepe Lopez) - (This was previously Sale 4)
INSERT INTO `Sale` (
    `sale_date`, `total_amount`, `id_client`, `id_employee`
) VALUES (
    '2024-07-01 16:15:00', 80.00, 3, 1 
);

-- Table: Sale_Detail

-- Drop the Sale_Detail table if it already exists.
DROP TABLE IF EXISTS `Sale_Detail` ;

-- Create the Sale_Detail table.
CREATE TABLE IF NOT EXISTS `Sale_Detail` (
  `id_sale_detail` INT NOT NULL AUTO_INCREMENT, 
  `id_sale` INT NOT NULL,       
  `id_glasses` INT NOT NULL,    
  `quantity` INT NOT NULL DEFAULT 1, 
  `unit_price` DECIMAL(10,2) NOT NULL, 

  PRIMARY KEY (`id_sale_detail`),
  -- Add a unique constraint for id_sale and id_glasses to prevent duplicate entries for the same glass in the same sale.
  UNIQUE INDEX `uq_sale_glass` (`id_sale` ASC, `id_glasses` ASC) VISIBLE,

  -- Define Foreign Key constraints:
  CONSTRAINT `fk_sale_detail_sale`
    FOREIGN KEY (`id_sale`)
    REFERENCES `Sale` (`id_sale`)
    ON DELETE CASCADE 
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_sale_detail_glasses`
    FOREIGN KEY (`id_glasses`)
    REFERENCES `Glasses` (`id_glasses`)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


-- Data for Table `Sale_Detail`

-- Sale 1 details (total 120.00): Oakleys (id_glasses=1)
INSERT INTO `Sale_Detail` (
    `id_sale`, `id_glasses`, `quantity`, `unit_price`
) VALUES (
    1, 1, 1, 120.00 -- Sale 1 of 1x Oakley (assuming id_glasses=1, price 120.00)
);

-- Sale 2 details (total 95.50): Ray-Bans (id_glasses=2)
INSERT INTO `Sale_Detail` (
    `id_sale`, `id_glasses`, `quantity`, `unit_price`
) VALUES (
    2, 2, 1, 95.50 
);

-- Sale 3 details (total 80.00): Minimalist (id_glasses=3)

INSERT INTO `Sale_Detail` (
    `id_sale`, `id_glasses`, `quantity`, `unit_price`
) VALUES (
    3, 3, 1, 80.00 -- This is the detail for the current Sale 3 (id_sale=3, the one by Pepe Lopez)
);

-- Re-enable foreign key checks and reset SQL mode

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
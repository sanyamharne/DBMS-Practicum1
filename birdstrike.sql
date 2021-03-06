CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
  -- Table `mydb`.`aircraft`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`aircraft` ;

CREATE TABLE IF NOT EXISTS `mydb`.`aircraft` (
  `AircraftTypeID` INT NOT NULL,
  `Type` VARCHAR(45) NULL,
  `Make_Model` VARCHAR(45) NULL,
  `IsAircraftLarge` TINYINT NULL,
  PRIMARY KEY (`AircraftTypeID`));


-- -----------------------------------------------------
  -- Table `mydb`.`airline_operator`
-- -----------------------------------------------------
  DROP TABLE IF EXISTS `mydb`.`airline_operator` ;

CREATE TABLE IF NOT EXISTS `mydb`.`airline_operator` (
  `AirlineOperatorId` INT NOT NULL,
  `AirlineOperator` VARCHAR(45) NULL,
  PRIMARY KEY (`AirlineOperatorId`));


-- -----------------------------------------------------
  -- Table `mydb`.`airline_aircrafts`
-- -----------------------------------------------------
  DROP TABLE IF EXISTS `mydb`.`airline_aircrafts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`airline_aircrafts` (
  `PlaneID` INT NOT NULL,
  `AircraftTypeID` INT NULL,
  `AirlineOperatorID` INT NULL,
  `NumberOfEngines` INT NULL,
  PRIMARY KEY (`PlaneID`),
  INDEX `AircraftTypeID_idx` (`AircraftTypeID` ASC) VISIBLE,
  INDEX `AirlineOperatorID_idx` (`AirlineOperatorID` ASC) VISIBLE,
  CONSTRAINT `AircraftTypeID`
  FOREIGN KEY (`AircraftTypeID`)
  REFERENCES `mydb`.`aircraft` (`AircraftTypeID`),
  CONSTRAINT `AirlineOperatorID`
  FOREIGN KEY (`AirlineOperatorID`)
  REFERENCES `mydb`.`airline_operator` (`AirlineOperatorId`));


-- -----------------------------------------------------
  -- Table `mydb`.`wildlife`
-- -----------------------------------------------------
  DROP TABLE IF EXISTS `mydb`.`wildlife` ;

CREATE TABLE IF NOT EXISTS `mydb`.`wildlife` (
  `WildlifeID` INT NOT NULL,
  `Species` VARCHAR(45) NULL,
  `Size` ENUM("Small", "Medium", "Large") NULL,
  PRIMARY KEY (`WildlifeID`));


-- -----------------------------------------------------
  -- Table `mydb`.`precipitation`
-- -----------------------------------------------------
  DROP TABLE IF EXISTS `mydb`.`precipitation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`precipitation` (
  `PrecipitationID` INT NOT NULL,
  `Precipitation` VARCHAR(45) NULL,
  PRIMARY KEY (`PrecipitationID`));


-- -----------------------------------------------------
  -- Table `mydb`.`Conditions`
-- -----------------------------------------------------
  DROP TABLE IF EXISTS `mydb`.`Conditions` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Conditions` (
  `RecordID` INT NOT NULL,
  `PrecipitationID` INT NOT NULL,
  PRIMARY KEY (`RecordID`, `PrecipitationID`),
  INDEX `PrecipitationID_idx` (`PrecipitationID` ASC) VISIBLE,
  FOREIGN KEY (`PrecipitationID`) REFERENCES `mydb`.`precipitation` (`PrecipitationID`);


-- -----------------------------------------------------
  -- Table `mydb`.`airport`
-- -----------------------------------------------------
  DROP TABLE IF EXISTS `mydb`.`airport` ;

CREATE TABLE IF NOT EXISTS `mydb`.`airport` (
  `AirportID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  PRIMARY KEY (`AirportID`));


-- -----------------------------------------------------
  -- Table `mydb`.`bird_strke_incident`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`bird_strke_incident` ;

CREATE TABLE IF NOT EXISTS `mydb`.`bird_strke_incident` (
  `RecordID` INT NOT NULL,
  `FlightDate` DATETIME NULL,
  `WildLife_NumberOfStruck` VARCHAR(45) NULL,
  `WildLife_NumberOfStruckActual` INT NULL,
  `Effect_ImpactToFlight` VARCHAR(45) NULL,
  `Altitude_BinAbove1000ft` TINYINT NULL,
  `Effect_Indicated` VARCHAR(45) NULL,
  `Damage` TINYINT NULL,
  `PhaseOfFlight` ENUM("Approach", "Climb", "Descent", "Landing Roll", "Take-off run", "Taxi") NULL,
  `WildLifeRemainsCollected` TINYINT NULL,
  `WildLifeRemainsSent` VARCHAR(45) NULL,
  `Remarks` LONGTEXT NULL,
  `PilotWarned` TINYINT NULL,
  `Cost_Total` INT NULL,
  `FeetAboveGround` INT NULL,
  `PeopleInjured` INT NULL,
  `Conditions_sky` VARCHAR(45) NULL,
  `PlaneID` INT NULL,
  `WildlifeID` INT NULL,
  `ConditionsID` INT NULL,
  `AirportID` INT NULL,
  PRIMARY KEY (`RecordID`),
  UNIQUE INDEX `RecordID_UNIQUE` (`RecordID` ASC) VISIBLE,
  INDEX `PlaneID_idx` (`PlaneID` ASC) VISIBLE,
  INDEX `WildlifeID_idx` (`WildlifeID` ASC) VISIBLE,
  INDEX `ConditionsID_idx` (`ConditionsID` ASC) VISIBLE,
  INDEX `AirportID_idx` (`AirportID` ASC) VISIBLE,
  CONSTRAINT `PlaneID`
  FOREIGN KEY (`PlaneID`)
  REFERENCES `mydb`.`airline_aircrafts` (`PlaneID`),
  CONSTRAINT `WildlifeID`
  FOREIGN KEY (`WildlifeID`)
  REFERENCES `mydb`.`wildlife` (`WildlifeID`),
  CONSTRAINT `ConditionsID`
  FOREIGN KEY (`ConditionsID`)
  REFERENCES `mydb`.`Conditions` (`RecordID`),
  CONSTRAINT `AirportID`
  FOREIGN KEY (`AirportID`)
  REFERENCES `mydb`.`airport` (`AirportID`));
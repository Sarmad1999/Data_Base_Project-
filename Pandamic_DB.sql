CREATE TABLE `login_detail` (
  `id` BIGINT(20) PRIMARY KEY NOT NULL,
  `password` INT(10) NOT NULL,
  `authroization_level` INT(10) NOT NULL
);

CREATE TABLE `access_detail` (
  `id` BIGINT(20) NOT NULL,
  `date` DATETIME DEFAULT NULL
);

CREATE TABLE `address` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `street` VARCHAR(50) DEFAULT NULL,
  `area` VARCHAR(50) DEFAULT NULL,
  `city` VARCHAR(50) DEFAULT NULL,
  `longitude` bigint(20) DEFAULT NULL,
  `latitude` bigint(20) DEFAULT NULL
);

CREATE TABLE `care_center` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `name` VARCHAR(50) DEFAULT NULL,
  `address` INT(11) DEFAULT NULL,
  `capacity` INT(11) DEFAULT NULL
);

CREATE TABLE `vaccine_type` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `mechanism` VARCHAR(50) NOT NULL,
  `creator` VARCHAR(50) NOT NULL
);

CREATE TABLE `clinical_trial` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `type` INT(11) NOT NULL DEFAULT "0",
  `people_taking_part` INT(11) NOT NULL,
  `recovered` INT(11) NOT NULL,
  `fatalities` INT(11) DEFAULT NULL
);

CREATE TABLE `family` (
  `Id` INT(11) PRIMARY KEY NOT NULL,
  `Members` INT(11) NOT NULL
);

CREATE TABLE `person` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `age` INT(11) NOT NULL DEFAULT "0",
  `address_id` INT(11) NOT NULL DEFAULT "0",
  `family_id` INT(11) NOT NULL
);

CREATE TABLE `infected` (
  `person_id` INT(11) PRIMARY KEY NOT NULL,
  `symptoms` INT(1) NOT NULL DEFAULT "0",
  `date_of_infection` DATE DEFAULT NULL,
  `center_id` INT(11) DEFAULT NULL
);

CREATE TABLE `close_contact` (
  `infected_person` INT(11) NOT NULL,
  `person_in_close_contact` INT(11) NOT NULL,
  PRIMARY KEY (`infected_person`, `person_in_close_contact`)
);

CREATE TABLE `daily_stat` (
  `date_of` DATE PRIMARY KEY NOT NULL,
  `new_cases` BIGINT(20) NOT NULL DEFAULT "0",
  `recoveries` BIGINT(20) NOT NULL DEFAULT "0",
  `deaths` BIGINT(20) DEFAULT NULL
);

CREATE TABLE `dead` (
  `person_id` INT(11) PRIMARY KEY NOT NULL,
  `date_of_passing` DATE DEFAULT NULL
);

CREATE TABLE `department` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `name` VARCHAR(50) NOT NULL DEFAULT ""
);

CREATE TABLE `doctor` (
  `person_id` INT(11) PRIMARY KEY NOT NULL,
  `shift` VARCHAR(1) DEFAULT NULL,
  `department_Id` INT(11) DEFAULT NULL,
  `center_id` INT(11) DEFAULT NULL
);

CREATE TABLE `locked_down_area` (
  `address_id` INT(11) PRIMARY KEY NOT NULL,
  `date_of_lockdown_start` DATE NOT NULL,
  `date_of_lockdown_end` DATE NOT NULL,
  `threat_level` VARCHAR(10) NOT NULL
);

CREATE TABLE `recovered` (
  `person_id` INT(11) PRIMARY KEY NOT NULL,
  `date_of_recovery` INT(11) NOT NULL,
  `risk_of_reinfection` FLOAT DEFAULT NULL
);

CREATE TABLE `storage_center` (
  `name` VARCHAR(50) PRIMARY KEY NOT NULL,
  `address_id` INT(11) NOT NULL DEFAULT "0",
  `storage_space` BIGINT(20) NOT NULL DEFAULT "0"
);

CREATE TABLE `test_center` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `address` INT(11) NOT NULL,
  `capacity` INT(11) NOT NULL,
  `name` VARCHAR(50) DEFAULT NULL
);

CREATE TABLE `test` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `date_of_test` DATE NOT NULL,
  `result` VARCHAR(10) NOT NULL DEFAULT "",
  `person_id` INT(11) NOT NULL,
  `test_center` INT(11) NOT NULL
);

CREATE TABLE `vaccine` (
  `id` INT(11) PRIMARY KEY NOT NULL,
  `date_of_production` DATE NOT NULL,
  `date_of_expiry` DATE NOT NULL,
  `storage_location` VARCHAR(50) NOT NULL DEFAULT "",
  `type` INT(11) NOT NULL
);

CREATE TABLE `vaccination_record` (
  `vaccine_id` INT(11) PRIMARY KEY NOT NULL,
  `person_id` INT(11) NOT NULL,
  `dosage_num` INT(10) NOT NULL,
  `vaccination_center` INT(10) NOT NULL
);

CREATE INDEX `FKlogin-access` ON `access_detail` (`id`);

CREATE INDEX `FKadd-care` ON `care_center` (`address`);

CREATE INDEX `FKtype-trial_idx` ON `clinical_trial` (`type`);

CREATE INDEX `FKfam` ON `person` (`family_id`);

CREATE INDEX `FKadd` ON `person` (`address_id`);

CREATE INDEX `FKcenter-inf` ON `infected` (`center_id`);

CREATE INDEX `FKinfec-person` ON `close_contact` (`person_in_close_contact`);

CREATE INDEX `FKpersonId` ON `doctor` (`person_id`);

CREATE INDEX `FKdepart` ON `doctor` (`department_Id`);

CREATE INDEX `FKcare-doc` ON `doctor` (`center_id`);

CREATE INDEX `Fkadd_id` ON `storage_center` (`address_id`);

CREATE INDEX `FKadd-test` ON `test_center` (`address`);

CREATE INDEX `FK1per` ON `test` (`person_id`);

CREATE INDEX `FKtcenter-test` ON `test` (`test_center`);

CREATE INDEX `FKtype-vac` ON `vaccine` (`type`);

CREATE INDEX `FKstorage-vac` ON `vaccine` (`storage_location`);

CREATE INDEX `FKper-vacrecord` ON `vaccination_record` (`person_id`);

CREATE INDEX `FKvacid-vacrec` ON `vaccination_record` (`vaccination_center`);

ALTER TABLE `access_detail` ADD CONSTRAINT `FKlogin-access` FOREIGN KEY (`id`) REFERENCES `login_detail` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `care_center` ADD CONSTRAINT `FKadd-care` FOREIGN KEY (`address`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `clinical_trial` ADD CONSTRAINT `FKtype-trial` FOREIGN KEY (`type`) REFERENCES `vaccine_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `person` ADD CONSTRAINT `FKadd` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `person` ADD CONSTRAINT `FKfam` FOREIGN KEY (`family_id`) REFERENCES `family` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `infected` ADD CONSTRAINT `FKcenter-inf` FOREIGN KEY (`center_id`) REFERENCES `care_center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `infected` ADD CONSTRAINT `FKper-inf` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `close_contact` ADD CONSTRAINT `FKinfec-close` FOREIGN KEY (`infected_person`) REFERENCES `infected` (`person_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `close_contact` ADD CONSTRAINT `FKinfec-person` FOREIGN KEY (`person_in_close_contact`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `dead` ADD CONSTRAINT `FKper-dead` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `doctor` ADD CONSTRAINT `FKcare-doc` FOREIGN KEY (`center_id`) REFERENCES `care_center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `doctor` ADD CONSTRAINT `FKdepart` FOREIGN KEY (`department_Id`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `doctor` ADD CONSTRAINT `FKpersonId` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `locked_down_area` ADD CONSTRAINT `FKadd_locked` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `recovered` ADD CONSTRAINT `FKper-recovered` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `storage_center` ADD CONSTRAINT `Fkadd_id` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `test_center` ADD CONSTRAINT `FKadd-test` FOREIGN KEY (`address`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `test` ADD CONSTRAINT `FK1per` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `test` ADD CONSTRAINT `FKtcenter-test` FOREIGN KEY (`test_center`) REFERENCES `test_center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `vaccine` ADD CONSTRAINT `FKtype-vac` FOREIGN KEY (`type`) REFERENCES `vaccine_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `vaccine` ADD CONSTRAINT `FKvac` FOREIGN KEY (`storage_location`) REFERENCES `storage_center` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `vaccination_record` ADD CONSTRAINT `FKper-vacrecord` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `vaccination_record` ADD CONSTRAINT `FKvacid-vacrec` FOREIGN KEY (`vaccine_id`) REFERENCES `vaccine` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

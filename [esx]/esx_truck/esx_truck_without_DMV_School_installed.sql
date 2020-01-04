#only import this sql if you don't already have these columns in your 'owned_vehicle' table

ALTER TABLE `owned_vehicles`
	ADD COLUMN `vehicleType` VARCHAR(20) NULL DEFAULT 'car',
	ADD COLUMN `stored` TINYINT(1) NOT NULL DEFAULT '1'
;
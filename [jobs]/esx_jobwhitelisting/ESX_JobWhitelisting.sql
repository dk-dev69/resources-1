USE `essentialmode`;

CREATE TABLE IF NOT EXISTS `characters` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(255) NOT NULL,
	`firstname` VARCHAR(255) NOT NULL,
	`lastname` VARCHAR(255) NOT NULL,
	`dateofbirth` VARCHAR(255) NOT NULL,
	`sex` VARCHAR(1) NOT NULL DEFAULT 'M',
	`height` VARCHAR(128) NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `characters` ADD COLUMN IF NOT EXISTS (
`ems_rank`  int(11) NULL DEFAULT '-1',
`leo_rank`  int(11) NULL DEFAULT '-1',
`tow_rank`  int(11) NULL DEFAULT '-1'
);

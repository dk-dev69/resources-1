USE `essentialmode`;

INSERT INTO `jobs` (`name`, `label`) VALUES
	('salvage', 'Спасатель')
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	('salvage', 0, 'employee', 'Дайвер', 80, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('contrat', 'Спасатель', 15, 0, 1)
;

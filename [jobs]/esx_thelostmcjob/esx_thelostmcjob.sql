INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_thelostmc','TheLostMC',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_thelostmc','TheLostMC',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_thelostmc', 'TheLostMC', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('thelostmc', 'TheLostMC', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('thelostmc', 0, 'recrut', 'Рекрут', 1000, '{}', '{}'),
('thelostmc', 1, 'member', 'Участник', 1500, '{}', '{}'),
('thelostmc', 2, 'capo', 'Руководитель', 1800, '{}', '{}'),
('thelostmc', 3, 'consigliere', 'Советник', 2100, '{}', '{}'),
('thelostmc', 4, 'boss', 'Глава', 2700, '{}', '{}');

CREATE TABLE `fine_types_thelostmc` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  
  PRIMARY KEY (`id`)
);

INSERT INTO `fine_types_thelostmc` (label, amount, category) VALUES 
	('Raket',3000,0),
	('Raket',5000,0),
	('Raket',10000,1),
	('Raket',20000,1),
	('Raket',50000,2),
	('Raket',150000,3),
	('Raket',350000,3)
;
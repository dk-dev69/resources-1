INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_cartel','cartel',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_cartel','Cartel',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_cartel', 'Cartel', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('cartel', 'Red BMWs', 1);

--
-- Déchargement des données de la table `jobs_grades`
--

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('cartel', 0, 'soldato', 'Yanci', 1500, '{}', '{}'),
('cartel', 1, 'capo', 'Uye', 1800, '{}', '{}'),
('cartel', 2, 'consigliere', 'Sag Kol', 2100, '{}', '{}'),
('cartel', 3, 'boss', 'Patron', 2700, '{}', '{}');

CREATE TABLE `fine_types_cartel` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  
  PRIMARY KEY (`id`)
);

INSERT INTO `fine_types_cartel` (label, amount, category) VALUES 
	('Harac',3000,0),
	('Harac',5000,0),
	('Harac',10000,1),
	('Harac',20000,1),
	('Harac',50000,2),
	('Harac',150000,3),
	('Harac',350000,3)
;
USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_fbi', 'FBI', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_fbi', 'FBI', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_fbi', 'FBI', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('fbi','FBI')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('fbi',0,'recruit','Кадет',2500,'{}','{}'),
	('fbi',1,'officer','Офицер',3000,'{}','{}'),
	('fbi',2,'sergeant','Агент',3500,'{}','{}'),
	('fbi',3,'sergeant','Констебль',4000,'{}','{}'),
	('fbi',4,'lieutenant','Лейтенант',4500,'{}','{}'),
	('fbi',5,'boss','Шеф',5000,'{}','{}')
;
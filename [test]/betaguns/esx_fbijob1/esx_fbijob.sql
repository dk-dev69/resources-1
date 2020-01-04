USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_fbi', 'fbi', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_fbi', 'fbi', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_fbi', 'fbi', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('fbi','FBI')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('fbi',0,'recruit','Cadet',2500,'{}','{}'),
	('fbi',1,'officer','Officer',3000,'{}','{}'),
	('fbi',2,'sergeant','Agent',3500,'{}','{}'),
	('fbi',3,'sergeant','Constable',4000,'{}','{}'),
	('fbi',4,'lieutenant','Detective',4500,'{}','{}'),
	('fbi',5,'boss','Commandant',5000,'{}','{}')
;
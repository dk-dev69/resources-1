USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'Механик', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'Механик', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'Механик')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mechanic',0,'recrue','Стажер',12,'{}','{}'),
	('mechanic',1,'novice','Новичок',24,'{}','{}'),
	('mechanic',2,'experimente','Experimente',36,'{}','{}'),
	('mechanic',3,'chief',"Начальник",48,'{}','{}'),
	('mechanic',4,'boss','Директор',0,'{}','{}')
;

INSERT INTO `items` (name, label, `weight`) VALUES
	('gazbottle', 'Газовый баллон', 11),
	('fixtool', 'Инструменты для ремонта', 6),
	('carotool', 'outils carosserie', 4),
	('blowpipe', 'Chalumeaux', 10),
	('fixkit', 'Комплект для ремонта', 5),
	('carokit', 'Kit carosserie', 3)
;

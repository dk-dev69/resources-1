USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_fib', 'Fib', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_fib', 'Fib', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_fib', 'Fib', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('fib','FIB')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('fib',0,'agent','Agent',20,'{}','{}'),
	('fib',1,'swat','Swat',40,'{}','{}'),
	('fib',2,'agentcaptainassistant','Agent Captain Asisstant',60,'{}','{}'),
	('fib',3,'swatcaptainassistant','Swat Captain Asisstant',85,'{}','{}'),
	('fib',4,'agentcaptain','Agent Captain',100,'{}','{}'),
	('fib',5,'swatcaptain','Swat Captain',150,'{}','{}'),
	('fib',6,'boss','Director',200,'{}','{}')
;

CREATE TABLE `fine_types_fib` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int(11) DEFAULT NULL,
	`category` int(11) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `fine_types_fib` (label, amount, category) VALUES
	('Gereksiz korna kullanimi.', 250, 0),
	('Hatali sollama.', 300, 0),
	('Ters yönde sürme.', 300, 0),
	('Yetkisiz U dönüsü.', 250, 0),
	('Kaldirima park etme', 350, 0),
	('Polis dur ihtarlar?na uymama', 800, 0),
	('Gereksiz ani fren.', 300, 0),
	('Park yasagi.', 400, 0),
	('Çalinti/Ruhsatsiz araç kullanma', 500, 0),
	('Trafik isaretlerine uymama.', 300, 0),
	('Kirmizi isik ihlali.', 450, 0),
	('Yetkisiz Dönü?ler', 670, 0),
	('Illegal arac kullanma.', 900, 0),
	('Ehliyetsiz arac kullanma.', 200, 0),
	('Carpip kacma.', 560, 0),
	('Hiz sinirini asma. > 60-120 Mp/h', 120, 0),
	('Hiz sinirini asma. >120-200 Mp/h', 300, 0),
	('Trafik akisini engelleme.', 200, 0),
	('Alkollü arac kullanma.', 170, 0),
	('Genel ahlaka aykiri davranis.', 390, 1),
	('Polis memuruna karsi gelme.', 350, 1),
	('Sözlü saldiri.', 250, 1),
	('Polis memuruna saygisizlik.', 275, 1),
	('Sözlü tehdit.', 340, 1),
	('Polis memuruna sözlü tehdit.', 400, 1),
	('Polis memuruna yanlis bilgi verme.', 390, 1),
	('Rüsvet teklif etme.', 700, 1),
	('Toplum icinde silah cikarma.', 1000, 2),
	('Toplum icinde ölümcül silah cekme.', 1350, 2),
	('Ruhsatsiz silah.', 1500, 2),
	('Ruhsatsiz silah bulundurma.', 1800, 2),
	('Hirsizlik aletleri bulundurma.', 1000, 2),
	('Araba hirsizligi.', 700, 2),
	('Yasadisi madde dagitma ve satma.', 400, 2),
	('Yasadisi madde üretimi.', 300, 2),
	('Yasadisi madde bulundurma.', 200, 2),
	('Sivil kacirma.', 1200, 2),
	('Güvenlik gücleri mensubu kacirma.', 1500, 2),
	('Soygun/Hirsizlik', 1750, 3),
	('Silahli magaza soygunu.', 2000, 3),
	('Silahli banka soygunu.', 4000, 3),
	('Sivile saldiri.', 1500, 3),
	('Güvenlik güclerine saldiri.', 2000, 3),
	('Sivil öldürmeye tesebbüs.', 1850, 3),
	('Güvenlik güclerini öldürmeye tesebbüs.', 2500, 3),
	('Sivil öldürme.', 3000, 3),
	('Güvenlik güçleri mensubunu öldürme.', 4000, 3),
	('Kasitsiz insan öldürme.', 2000, 3),
	('Dolandiricilik / sahte evrak.', 1000, 2),
	('Copbait', 3500, 3),
	('Asilsiz ihbar.', 2500, 3),
	('Kazaya sebebiyet.', 100, 0),
	('Izinsiz Musket Kullanma', 780, 2),
	('Drift', 1000, 0),
	('Illegal Modifiye', 500, 0);
;

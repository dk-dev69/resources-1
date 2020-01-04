INSERT INTO `jobs` (`name`, `label`) VALUES
('works', 'Городские работы');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('works', 0, 'interim', 'Работник', 150, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('pay_works', 'City Pay Slip', 15, 0, 1);

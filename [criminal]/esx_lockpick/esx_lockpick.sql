USE `essentialmode`;


INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('lockpick', 'Lockpick', 3, 0, 1)
;
INSERT INTO `shops` (`store`, `item`, `price`) VALUES
('ExtraItemsShop', 'lockpick', 100),
;

Thermal Vision as an item for ESX.
@DoubleT74.

1. Upload it to your resources folder
2. Add esx_thermalvision to server.cfg
3. Create "thermalvision" in items table

```
INSERT INTO `items` (`name`, `label`, `weight`) VALUES  
    ('thermalvision', 'Thermal Vision', 1)
;
```

If you want it added to ESX Shops. Execute this SQL.

```
INSERT INTO `shops` (name, item, price) VALUES
	('TwentyFourSeven', 'thermalvision', 10000),
	('RobsLiquor', 'thermalvision', 10000),
	('LTDgasoline', 'thermalvision', 10000)
;
```

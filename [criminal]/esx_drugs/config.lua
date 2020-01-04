Config = {}

Config.Locale = 'ru'

Config.Delays = {
	WeedProcessing = 1000 * 10
	-- CokeProcessing = 1000 * 10
}

-- Config.Delays = {
	-- CokeProcessing = 1000 * 10
-- }

Config.DrugDealerItems = {
	marijuana = 91,
	coke = 91
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000}
}

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(310.91, 4290.87, 45.15), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(2329.02, 2571.29, 46.68), name = _U('blip_weedprocessing'), color = 59, sprite = 499, radius = 100.0},
	DrugDealer = {coords = vector3(-1172.02, -1571.98, 4.66), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
	
	-- CokeField = {coords = vector3(2224.06, 5577.15, 57.84), name = _U('blip_cokefield'), color = 25, sprite = 496, radius = 20.0},
	-- CokeProcessing = {coords = vector3(2332.39, 4971.13, 42.35), name = _U('blip_cokeprocessing'), color = 25, sprite = 51, radius = 0.0},
}
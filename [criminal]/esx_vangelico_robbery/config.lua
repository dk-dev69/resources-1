Config = {}
Config.Locale = 'ru'

Config.RequiredCopsRob = 1
Config.RequiredCopsSell = 1
Config.MinJewels = 5 
Config.MaxJewels = 20
Config.MaxWindows = 20
Config.SecBetwNextRob = 3600 --1 hour
Config.MaxJewelsSell = 20
Config.PriceForOneJewel = 1000

Stores = {
	["jewelry"] = {
		position = { ['x'] = -629.99, ['y'] = -236.542, ['z'] = 38.05 },       
		--reward = math.random(25000,50000),
		nameofstore = "Ювелирный магазин",
		lastrobbed = 0
	}
}
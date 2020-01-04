Config = {}

Config.Price = 150

Config.DrawDistance = 50.0
Config.MarkerSize   = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor  = {r = 76, g = 209, b = 55}
Config.MarkerType   = 29
Config.Locale = 'ru'

Config.Zones = {}

Config.Shops = {
	{x = -1338.129, y = -1278.200, z = 4.872}
}

for i=1, #Config.Shops, 1 do

	Config.Zones[i] = {
	 	 Pos   = Config.Shops[i],
	 	 Size  = Config.MarkerSize,
	 	 Color = Config.MarkerColor,
	 	 Type  = Config.MarkerType
   }

end
Config                            = {}
Config.Locale                     = 'ru'

--- #### BASICS
Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = true
Config.EnableBlips = true


--- #### PRICES	
Config.PriceTriBike = 155
Config.PriceScorcher = 120
Config.PriceCruiser = 80
Config.PriceBmx = 145
Config.Faggio2 = 250


--- #### MARKER EDITS
Config.TypeMarker = 2
Config.MarkerScale = {
{x = 2.000,y = 2.000,z = 0.500}
}
Config.MarkerColor = {
{r = 52,g = 73,b = 94}
}

Config.MarkerZones = { 
    {x = -246.980,y = -339.820,z = 30.200},
    {x = -6.986,y = -1081.704,z = 25.7},
    {x = -1085.78,y = -263.01,z = 36.80}, 
    {x = -1262.36,y = -1438.98,z = 3.45},
	{x = -1106.87,y = -1692.41,z = 4.17},
    {x = -1017.72,y = -2693.77,z = 13.98}
}


-- Edit blip titles
Config.BlipZones = { 
   {title="Прокат велосипедов и скутеров", colour=2, id=494, x = -248.938, y = -339.955, z = 30.200},
   {title="Прокат велосипедов и скутеров", colour=2, id=494, x = -6.892, y = -1081.734, z = 26.829},
   {title="Прокат велосипедов и скутеров", colour=2, id=494, x = -1262.36, y = -1438.98, z = 3.45},
   {title="Прокат велосипедов и скутеров", colour=2, id=494, x = -1106.87,y = -1692.41,z = 4.37},
   {title="Прокат велосипедов и скутеров", colour=2, id=494, x = -1017.72,y = -2693.77,z = 13.98}
}

Config                = {}

Config.Marker = {
    id          = 27,
    colour      = {r = 0, g = 255, b = 0, a = 50},
    isRotating  = false,
    radius      = 1.0,
}

---------------------------------------------------------------
--=====How long should it take for player to catch a fish=======--
---------------------------------------------------------------
--Time in miliseconds
Config.FishTime = {a = 20000, b = 44000}

--------------------------------------------------------
--=====Prices of the items players can sell==========--
--------------------------------------------------------
--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
Config.FishPrice = {a = 120, b = 140} --THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
Config.TurtlePrice = {a = 300, b = 500} 
Config.SharkPrice = {a = 700, b = 900} 

--Buy:
Config.FishingrodPrice = 70
Config.FishingknifePrice = 10
Config.FishbaitPrice = 5
Config.TurtlebaitPrice = 10


--------------------------------------------------------
--=====Locations where players can buy or sell stuff========--
--------------------------------------------------------
Config.FishingShop = {x = 1694.823, y = 3755.388, z = 33.705} --Place where players can sell their fish
Config.SellFish = {x = 1277.44, y = 6643.68, z = 1.42} --Place where players can sell their fish
Config.SellTurtle = {x = 3613.875, y = 5025.807, z = 10.347} --Place where players can sell their turtles 
Config.SellShark = {x = 3824.538, y = 4444.896, z = 1.809} --Place where players can sell their sharks


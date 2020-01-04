Config              = {}
Config.DrawDistance = 100.0
Config.Locale       = 'ru'

Config.Plates = {
	taxi = "TAXI",
	fisherman = "FISH",
	cop = "LSPD",
	ambulance = "EMS",
	depanneur = "MECA",
	fuel = "FUEL",
	lumberjack = "BUCH",
	miner = "MINE",
	reporter = "JOUR",
	slaughterer = "ABAT",
	textil = "COUT"
}

Config.Jobs = {}

Config.PublicZones = {
	EnterBuilding = {
		Pos   = { x = -115.0, y = -608.03, z = 35.280723571777 },
		Size  = {x = 3.0, y = 3.0, z = 0.2},
		Color = {r = 51, g = 153, b = 255},
		Marker= 27,
		Blip  = false,
		Name  = "San Andreas Times",
		Type  = "teleport",
		Hint  = "Нажмите ~INPUT_PICKUP~ для входа в центр.",
		Teleport = { x = -139.09838867188, y = -620.74865722656, z = 167.82052612305 }
	},

	ExitBuilding = {
		Pos   = { x = -139.45831298828, y = -617.32312011719, z = 167.82052612305 },
		Size  = {x = 2.0, y = 2.0, z = 0.2},
		Color = {r = 255, g = 0, b = 9},
		Marker= 27,
		Blip  = false,
		Name  = "San Andreas Times",
		Type  = "teleport",
		Hint  = "Нажмите ~INPUT_PICKUP~ для выхода из здания.",
		Teleport = { x = -113.07, y = -604.93, z = 35.28 },
	},
}

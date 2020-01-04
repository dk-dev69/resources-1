-- If you want service management you have to set `Config.MaxInService` to anything else than `-1` in `config.lua`
-- If you want player management you have to set `Config.EnablePlayerManagement` to `true` in `config.lua`
-- If you want armory management you have to set `Config.EnableArmoryManagement` to `true` in `config.lua`
-- If you want license management you have to set `Config.EnableLicenses` to `true` in `config.lua`
-- If you want service management you have to set `Config.MaxInService` to anything else than `-1` in `config.lua`
   
Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 255, g = 71, b = 87 }

Config.DisableWantedLevel   	  = true
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- включить таймер наручников? будет отвлекать игрока по истечении времени
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'ru'

Config.CartelStations = {

	CARTEL = {

		Blip = {
			Coords  = vector3(1365.45, 1145.79, 113.75),
			Sprite  = 89,
			Display = 4,
			Scale   = 0.9,
			Colour  = 1
		},

		Cloakrooms = {
			vector3(1399.99, 1139.79, 114.33)
		},

		Armories = {
			vector3(1400.48, 1159.42, 114.33)
		},

		Vehicles = {
			{
				Spawner = vector3(1401.25, 1115.01, 114.83),
				InsideShop = vector3(1410.78, 1120.5, 114.84),
				SpawnPoints = {
					{ coords = vector3(1397.64, 1117.67, 114.83), heading = 88.0, radius = 6.0 },
					--{ coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0 },
					--{ coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0 },
					--{ coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(1410.78, 1120.5, 114.84),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1443.42, 1111.46, 114.33),
				InsideShop = vector3(1457.12, 1112.01, 114.33),
				SpawnPoints = {
					{ coords = vector3(1457.12, 1112.01, 114.33), heading = 90.0, radius = 12.0 }
				}
			}
		},

		BossActions = {
			vector3(1399.15, 1164.64, 114.33)
		}

	},
}

Config.AuthorizedWeapons = {
	soldato = {
		{ weapon = 'WEAPON_APPISTOL', components = { 500, 0, 0, 0, nil }, price = 1000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_ASSAULTRIFLE', price = 1500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
	},

	capo = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 60, 100, 400, 800, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	consigliere = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 60, 100, 400, 800, nil }, price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 200, 600, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	boss = {
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 600, 100, 400, 800, nil }, price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 200, 600, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {},
	
	soldato = {
		{model = 'Manchez', label = 'Мотоцикл Manchez', price = 5000 },
		{model = 'Contender',   label = 'Contender 4X4', price = 40000},
		
	},

	capo = {
		{model = 'Manchez', label = 'Мотоцикл Manchez', price = 6000 },
		{model = 'Contender',   label = 'Contender 4X4', price = 50000},
		{model = 'cognoscenti2',   label = 'Легковой бронированный транспорт', price = 50000},
	},

	consigliere = {
		{model = 'Manchez', label = 'Мотоцикл Manchez', price = 6000 },
		{model = 'Contender',   label = 'Contender 4X4', price = 50000},
		{model = 'cognoscenti2',   label = 'Легковой бронированный транспорт', price = 50000},
		{model = 'Guardian',      label = 'Guardian 4x4 с кузовом', price = 50000},
		{model = 'GP1',      label = 'Super GP1', price = 200000},
	},
	
	boss = {
		{model = 'Manchez', label = 'Мотоцикл Manchez', price = 6000 },
		{model = 'Contender',   label = 'Contender 4X4', price = 60000},
		{model = 'cognoscenti2',   label = 'Легковой бронированный транспорт', price = 50000},
		{model = 'Guardian',      label = 'Guardian 4x4 с кузовом', price = 50000},
		{model = 'GP1',      label = 'Super GP1', price = 200000},
		
	}
}

Config.AuthorizedHelicopters = {
	soldato = {},
	capo = {},
	consigliere = {},
	boss = {
		{ model = 'buzzard', label = 'Buzzard', livery = 0, price = 150000}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	soldato_wear = {
		male = {
		    -- ['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			-- ['torso_1'] = 55,   ['torso_2'] = 0,
			-- ['decals_1'] = 0,   ['decals_2'] = 0,
			-- ['arms'] = 0,		['glasses'] = 0,
			-- ['pants_1'] = 35,   ['pants_2'] = 0,
			-- ['shoes_1'] = 27,   ['shoes_2'] = 0,
			-- ['helmet_1'] = 46,  ['helmet_2'] = 0,
			-- ['chain_1'] = 0,    ['chain_2'] = 0,
			-- ['ears_1'] = 2,     ['ears_2'] = 0
			-- ['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			-- ['torso_1'] = 55,   ['torso_2'] = 0,
			-- ['decals_1'] = 0,   ['decals_2'] = 0,
			-- ['arms'] = 41,
			-- ['pants_1'] = 25,   ['pants_2'] = 0,
			-- ['shoes_1'] = 25,   ['shoes_2'] = 0,
			-- ['helmet_1'] = 46,  ['helmet_2'] = 0,
			-- ['chain_1'] = 0,    ['chain_2'] = 0,
			-- ['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {}
	},
	capo_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	consigliere_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 1,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 1,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	}
}
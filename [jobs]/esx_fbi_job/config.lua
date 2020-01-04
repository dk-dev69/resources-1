Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 2
Config.MarkerSize                 = { x = 1.0, y = 1.0, z = 1.0 }
Config.MarkerColor                = { r = 0, g = 168, b = 255}

Config.DisableWantedLevel   	  = true
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableSocietyOwnedVehicles = false
Config.EnableHandcuffTimer        = true -- включить таймер наручников? будет отвлекать игрока по истечении времени
Config.HandcuffTimer              = 5 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'ru'

Config.FBIStations = {

	FBI = {

		Blip = {
			Coords  = vector3(112.1, -749.3, 45.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 2,
			Colour  = 26,
		},

		Cloakrooms = {
			vector3(152.0, -736.1, 242.1)
		},

		Armories = {
			vector3(143.6, -764.3, 242.1)
		},

		Vehicles = {
			{
				Spawner = vector3(95.5, -723.7, 33.1),
				InsideShop = vector3(95.5, -723.7, 33.1),
				SpawnPoints = {
					{ coords = vector3(100.1, -729.4, 33.7), heading = 340.8, radius = 6.0 },
					{ coords = vector3(104.0, -730.8, 33.7), heading = 340.8, radius = 6.0 },
					{ coords = vector3(107.7, -732.1, 33.7), heading = 340.8, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(148.9, -758.5, 242.1)
		},
		
        Elevator = {
			{
				Top = vector3(136.0, -761.8, 242.5),
				Down = vector3(136.0, -761.5, 45.7),
				Parking = vector3(65.4, -749.6, 30.6)
			}
		}


	}
}

Config.AuthorizedWeapons = {
	recruit = {
		{weapon = 'WEAPON_STUNGUN', price = 0 },
		{weapon = 'WEAPON_COMBATPISTOL', price = 200},
		{weapon = 'WEAPON_COMPACTRIFLE', price = 350},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0},
		{weapon = 'WEAPON_SMOKEGRENADE', price = 50}
	},

	-- special = {
		-- { weapon = 'WEAPON_STUNGUN', price = 1000 },
		-- { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 5000 },
		-- { weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 12500 },
		-- { weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		-- { weapon = 'WEAPON_FLASHLIGHT', price = 20 }
	-- },

	-- supervisor = {
		-- { weapon = 'WEAPON_STUNGUN', price = 1000 },
		-- { weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 1000, 4000, nil }, price = 5000 },
		-- { weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 6000, 1000, 4000, 8000, nil }, price = 10000 },
		-- { weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 12500 },
		-- { weapon = 'WEAPON_SNIPERRIFLE', price = 15000 },
		-- { weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		-- { weapon = 'WEAPON_FLASHLIGHT', price = 20 }
	-- },

	officer = {
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL',  price = 200 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		--{ weapon = 'WEAPON_GRENADE', price = 5000 },
		{weapon = 'WEAPON_SMOKEGRENADE', price = 50},
		{weapon = 'WEAPON_BZGAS', price = 50}
		
	},

	boss = {
		--{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 0 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 12500 },
		--{ weapon = 'WEAPON_SNIPERRIFLE', price = 0 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		--{ weapon = 'WEAPON_GRENADE', price = 5000 },
		{weapon = 'WEAPON_SMOKEGRENADE', price = 50}
		--{ weapon = 'WEAPON_STICKYBOMB', price = 10000 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {
		-- { model = 'fbi', label = 'FBI Car', price = 3500 },
		-- { model = 'fbi2', label = 'FBI SUV', price = 5000}
	},

	recruit = {{ model = 'fbi2', label = 'FBI Внедорожник', price = 1000}},
	
    officer = {
		{ model = 'fbi', label = 'FBI Седан', price = 3500 },
		{ model = 'fbi2', label = 'FBI Внедорожник', price = 1500},
		{ model = 'pbus', label = 'Тюремный автобус', price = 2000 },
		{ model = 'riot', label = 'Бронивик SWAT', price = 5000 }
	},
	
	-- special = {},

	-- supervisor = {
		-- { model = 'pbus', label = 'Prison Bus', price = 6000 }
	-- },

	-- assistant = {
		-- { model = 'pbus', label = 'Prison Bus', price = 6000 }
	-- },

	boss = {
		{ model = 'fbi', label = 'FBI Седан', price = 3500 },{ model = 'fbi2', label = 'FBI Внедорожник', price = 1000},{ model = 'pbus', label = 'Тюремный автобус', price = 2000 },{ model = 'riot', label = 'Бронивик SWAT', price = 5000 }
	}
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {
		{ model = 'polmav', label = 'Полицейский Маверик', livery = 0, price = 25000 }
	},

	boss = {
		{ model = 'polmav', label = 'Полицейский Маверик', livery = 0, price = 25000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 61,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 31,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 58,
			['helmet_2'] = 2,
			['chain_1'] = 128,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 54,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 34,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = 58,
			['helmet_2'] = 2,
			['chain_1'] = 98,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	officer_wear = {
		male = {
			['tshirt_1'] = 130,
			['tshirt_2'] = 0,
			['torso_1'] = 59,
			['torso_2'] = 2,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 33,
			['arms_2'] = 0,
			['pants_1'] = 24,
			['pants_2'] = 0,
			['shoes_1'] = 40,
			['shoes_2'] = 9,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 128,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 160,
			['tshirt_2'] = 0,
			['torso_1'] = 136,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 36,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 98,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	 supervisor_wear = {
		 male = {
			 ['tshirt_1'] = 10,
			 ['tshirt_2'] = 2,
			 ['torso_1'] = 28,
			 ['torso_2'] = 0,
			 ['decals_1'] = 0,
			 ['decals_2'] = 0,
			 ['arms'] = 33,
			 ['arms_2'] = 0,
			 ['pants_1'] = 28,
			 ['pants_2'] = 0,
			 ['shoes_1'] = 10,
			 ['shoes_2'] = 0,
			 ['helmet_1'] = -1,
			 ['helmet_2'] = 0,
			 ['chain_1'] = 12,
			 ['chain_2'] = 2,
			 ['ears_1'] = -1,
			 ['ears_2'] = 0,
			 ['mask_1'] = 121,
			 ['mask_2'] = 0
		 },
		 female = {
			 ['tshirt_1'] = 38,
			 ['tshirt_2'] = 2,
			 ['torso_1'] = 58,
			 ['torso_2'] = 0,
			 ['decals_1'] = 0,
			 ['decals_2'] = 0,
			 ['arms'] = 34,
			 ['arms_2'] = 0,
			 ['pants_1'] = 37,
			 ['pants_2'] = 0,
			 ['shoes_1'] = 29,
			 ['shoes_2'] = 0,
			 ['helmet_1'] = -1,
			 ['helmet_2'] = 0,
			 ['chain_1'] = 22,
			 ['chain_2'] = 0,
			 ['ears_1'] = -1,
			 ['ears_2'] = 0,
			 ['mask_1'] = 121,
			 ['mask_2'] = 0
		 }
	 },

	assistant_wear = {
		male = {
			['tshirt_1'] = 31,
			['tshirt_2'] = 0,
			['torso_1'] = 32,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 4,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 28,
			['chain_2'] = 2,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 38,
			['tshirt_2'] = 0,
			['torso_1'] = 7,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 3,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 0,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 21,
			['chain_2'] = 2,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 31,
			['tshirt_2'] = 0,
			['torso_1'] = 31,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 4,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 18,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 38,
			['tshirt_2'] = 0,
			['torso_1'] = 7,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 3,
			['arms_2'] = 0,
			['pants_1'] = 37,
			['pants_2'] = 0,
			['shoes_1'] = 0,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 87,
			['chain_2'] = 4,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},
	 special_forces =
	 {
		 male = {
			 ['bproof_1'] = 11,  ['bproof_2'] = 1
		 },
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		 }
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	}
	

}
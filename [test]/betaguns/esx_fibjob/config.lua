Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 255, g = 0, b = 0 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	Paleto = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(132.72, -769.33, 242.15)
		},

		Armories = {
			vector3(148.46, -763.22, 242.15)
		},

		Vehicles = {
			{
				Spawner = vector3(-2332.38, 388.82, 173.7),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-2337.79, 381.95, 173.56), heading = 161.26, radius = 6.0 },
					{ coords = vector3(-2337.79, 381.95, 173.56), heading = 167.2, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(120.29, -725.07, 261.85),
				InsideShop = vector3(125.95, -726.64, 261.85),
				SpawnPoints = {
					{ coords = vector3(123.54, -733.75, 262.84), heading = 156.07, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(124, -768.95, 242.15)
		}

	}

}

Config.AuthorizedWeapons = {
	agent = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, nil }, price = 250 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 8 },
		{ weapon = 'WEAPON_STUNGUN', price = 50 },
		{ weapon = 'GADGET_PARACHUTE', price = 25 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10 },
		{ weapon = 'WEAPON_BZGAS', price = 40 }
	},

	swat = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, nil }, price = 250 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 8 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 500 },
		{ weapon = 'WEAPON_STUNGUN', price = 50 },
		{ weapon = 'GADGET_PARACHUTE', price = 25 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10 },
		{ weapon = 'WEAPON_BZGAS', price = 40 }
	},

	agentcaptainassistant = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, nil }, price = 250 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 8 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 500 },
		{ weapon = 'WEAPON_STUNGUN', price = 50 },
		{ weapon = 'GADGET_PARACHUTE', price = 25 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 2, 1, 1, 1, 1, 1, nil}, price = 1000},
		{ weapon = 'WEAPON_BZGAS', price = 40 }  
	},

	swatcaptainassistant = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, nil }, price = 250 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 8 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 500 },
		{ weapon = 'WEAPON_STUNGUN', price = 50 },
		{ weapon = 'GADGET_PARACHUTE', price = 25 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 2, 1, 1, 1, 1, 1, nil}, price = 1000},
		{ weapon = 'WEAPON_BZGAS', price = 40 }  
	},

	agentcaptain = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, nil }, price = 250 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 8 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 500 },
		{ weapon = 'WEAPON_STUNGUN', price = 50 },
		{ weapon = 'GADGET_PARACHUTE', price = 25 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 2, 1, 1, 1, 1, 1, nil}, price = 1000} 
	},

	swatcaptain = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, nil }, price = 250 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 8 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 500 },
		{ weapon = 'WEAPON_STUNGUN', price = 50 },
		{ weapon = 'GADGET_PARACHUTE', price = 25 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 2, 1, 1, 1, 1, 1, nil}, price = 1000},
		{ weapon = 'WEAPON_BZGAS', price = 40 } 
	},

	boss = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, nil }, price = 250 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 8 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 500 },
		{ weapon = 'WEAPON_STUNGUN', price = 50 },
		{ weapon = 'GADGET_PARACHUTE', price = 25 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 10 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 2, 1, 1, 1, 1, 1, nil}, price = 1000},
		{ weapon = 'WEAPON_BZGAS', price = 40 } 
	}
}

Config.AuthorizedVehicles = {
	Shared = {

	},

	agent = {
		{
			model = 'polschafter3',
			label = 'FBI UNMARKED',
			price = 2000
		},
		{
			model = 'fibexecutioner',
			label = 'FBI SUV',
			price = 2000
		},
	},

	swat = {
		{
			model = 'polschafter3',
			label = 'FBI UNMARKED',
			price = 2000
		},
		{
			model = 'fibexecutioner',
			label = 'FBI SUV',
			price = 2000
		},
	},

	agentcaptainassistant = {
		{
			model = 'polschafter3',
			label = 'FBI UNMARKED',
			price = 2000
		},
		{
			model = 'fibexecutioner',
			label = 'FBI SUV',
			price = 2000
		},
	},

	swatcaptainassistant = {
		{
			model = 'polschafter3',
			label = 'FBI UNMARKED',
			price = 2000
		},
		{
			model = 'fibexecutioner',
			label = 'FBI SUV',
			price = 2000
		},
	},

	boss = {
		{
			model = 'polschafter3',
			label = 'FBI UNMARKED',
			price = 2000
		},
		{
			model = 'fibexecutioner',
			label = 'FBI SUV',
			price = 2000
		},
	},

	chef = {
		{
			model = 'polschafter3',
			label = 'FBI UNMARKED',
			price = 2000
		},
		{
			model = 'fibexecutioner',
			label = 'FBI SUV',
			price = 2000
		},
	}
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},
		
	intendent = {},

	lieutenant = {
		{
			model = 'frogger2',
			label = 'FBI Frogger',
			livery = 0,
			price = 5000
		}
	},

	chef = {
		{
			model = 'frogger2',
			label = 'FBI Frogger',
			livery = 0,
			price = 2500
		}
	},

	boss = {
		{
			model = 'frogger2',
			label = 'FBI Frogger',
			livery = 0,
			price = 1000
		}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	officer_wear = {
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
		['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	sergeant_wear = {
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
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	chef_wear = {
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
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
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
			['tshirt_1'] = 52,  ['tshirt_2'] = 1,
			['torso_1'] = 25,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 20,
			['pants_1'] = 31,   ['pants_2'] = 0,
			['shoes_1'] = 9,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 11,     ['ears_2'] = 1
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}
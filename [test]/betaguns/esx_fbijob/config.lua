Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 136.29, y = -749.45, z = 266.6 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = false
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.fbiStations = {

	LSPD = {

		Blip = {
			--Крыша здания ФБР
			Pos     = { x = 136.29, y = -749.45, z = 266.6 },
			Sprite  = 304,
			Display = 4,
			Scale   = 2,
			Colour  = 72,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 200 },
			{ name = 'WEAPON_STUNGUN',     price = 300 },
			{ name = 'WEAPON_PISTOL50',       price = 1250 },
			{ name = 'WEAPON_PISTOL',     price = 1500 },
			{ name = 'WEAPON_MICROSMG',      price = 600 },
			{ name = 'WEAPON_ASSAULTSMG',          price = 500 },
			{ name = 'WEAPON_ASSAULTRIFLE_MK2',       price = 80 },
			{ name = 'WEAPON_SPECIALCARBINE_MK2', price = 120 },
			{ name = 'WEAPON_ADVANCEDRIFLE',         price = 60 },
			{ name = 'WEAPON_ASSAULTSHOTGUN',       price = 250 },
			{ name = 'WEAPON_HEAVYSHOTGUN',       price = 250 },
			{ name = 'WEAPON_MARKSMANRIFLE',       price = 250 },
			{ name = 'WEAPON_SMOKEGRENADE',       price = 250 },
			{ name = 'WEAPON_BZGAS',       price = 250 },
			{ name = 'GADGET_PARACHUTE',        price = 300 },
		},

		Cloakrooms = {
		--Кабинеты вверху здания
			{ x = 125.08, y = -747.68, z = 241.15 },
		},

		Armories = {
			{ x = 119.14, y = -729.17, z = 241.15 },
		},

		Vehicles = {
			{
				Spawner    = { x = 130.68, y = -735.52, z = 32.13 },
				SpawnPoints = {
					{ x = 139.84, y = -734.43, z = 32.13, heading = 90.0, radius = 6.0 }
					--{ x = 441.08, y = -1024.23, z = 28.30, heading = 90.0, radius = 6.0 },
					--{ x = 453.53, y = -1022.20, z = 28.02, heading = 90.0, radius = 6.0 },
					--{ x = 450.97, y = -1016.55, z = 28.10, heading = 90.0, radius = 6.0 }
				}
			}

			--{
				--Spawner    = { x = 473.38, y = -1018.43, z = 27.00 },
				--SpawnPoints = {
					--{ x = 475.98, y = -1021.65, z = 28.06, heading = 276.11, radius = 6.0 },
					--{ x = 484.10, y = -1023.19, z = 27.57, heading = 302.54, radius = 6.0 }
				--}
			--}
		},

		Helicopters = {
			{
				Spawner    = { x = 124.83, y = -731.51, z = 261.84 },
				SpawnPoint = { x = 122.42, y = -742.06, z = 262.85 },
				Heading    = 0.0
			}
		},

		VehicleDeleters = {
			{ x = 151.1, y = -747.17, z = 32.13 },
			{ x = 147.99, y = -745.94, z = 32.13 },
			{ x = 149.2, y = -755.58, z = 261.87 }
		},

		BossActions = {
			{ x = 123.85, y = -769.19, z = 241.15 }
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'fbi',
			label = 'FBI 1'
		},
		{
			model = 'fbi2',
			label = 'FBI 2'
		},
		{
			model = 'policet',
			label = 'Zırhlı Van'
		},
		{
			model = 'police2',
			label = 'Polis 1'
		},
		{
			model = 'police3',
			label = 'Polis 2'
		},
		{
			model = 'riot',
			label = 'Zırhlı Araç'
		},
		{
			model = 'apc',
			label = 'Ağır Zırhlı Araç'
		}
	},

	recruit = {

	},

	officer = {
		--{
			--model = 'fbi3',
			--label = 'fbi Interceptor'
		--}
	},

	sergeant = {
		--{
		--	model = 'fbit',
		--	label = 'fbi Transporter'
		--},
		--{
		--	model = 'fbib',
		--	label = 'fbi Bike'
		--}
	},

	intendent = {

	},

	lieutenant = {
		--{
			--model = 'riot',
			--label = 'fbi Riot'
		--},
		--{
			--model = 'fbi2',
			--label = 'FIB SUV'
		--}
	},

	chef = {

	},

	boss = {

	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 42,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,       ['arms_2'] = 0,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 128,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 1
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 136,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,       ['arms_2'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 95,    ['chain_2'] = 0,
			['ears_1'] = 25,     ['ears_2'] = 11
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 42,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,       ['arms_2'] = 0,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 125,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 1
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 136,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,       ['arms_2'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 95,    ['chain_2'] = 0,
			['ears_1'] = 25,     ['ears_2'] = 11
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,       ['arms_2'] = 0,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 2,
			['ears_1'] = 1,     ['ears_2'] = 1
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 136,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,       ['arms_2'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 95,    ['chain_2'] = 0,
			['ears_1'] = 25,     ['ears_2'] = 11
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,       ['arms_2'] = 0,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 2,
			['ears_1'] = 1,     ['ears_2'] = 1
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 136,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,       ['arms_2'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 95,    ['chain_2'] = 0,
			['ears_1'] = 25,     ['ears_2'] = 11
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,       ['arms_2'] = 0,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 2,
			['ears_1'] = 1,     ['ears_2'] = 1
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 136,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,       ['arms_2'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 95,    ['chain_2'] = 0,
			['ears_1'] = 25,     ['ears_2'] = 11
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,       ['arms_2'] = 0,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 2,
			['ears_1'] = 1,     ['ears_2'] = 1
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 136,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,       ['arms_2'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 95,    ['chain_2'] = 0,
			['ears_1'] = 25,     ['ears_2'] = 11
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 10,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 4,       ['arms_2'] = 0,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 12,    ['chain_2'] = 2,
			['ears_1'] = 1,     ['ears_2'] = 1
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 136,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 3,       ['arms_2'] = 0,
			['pants_1'] = 27,   ['pants_2'] = 0,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			--['helmet_1'] = 0,  ['helmet_2'] = 0,
			['chain_1'] = 95,    ['chain_2'] = 0,
			['ears_1'] = 25,     ['ears_2'] = 11
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
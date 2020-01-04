Config = {}
Config.Locale = 'ru'

Config.DoorList = {
	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = -90.0,
				objCoords = vector3(434.7, -980.6, 30.8)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = -90.0,
				objCoords = vector3(434.7, -983.2, 30.8)
			}
		}
	},

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = -90.0,
		objCoords  = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police', 'militar', 'fbi'},
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = false
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true,
		distance = 12,
		size = 2
	},
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police', 'militar', 'fbi' },
		locked = true,
		distance = 12,
		size = 2
	},
	
	-----------------------------------------------------------------ПО УМОЛЧАНИЮ
	-- Zancudo Military Base Front Entrance
{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(-1587.23, 2805.08, 15.82),
		textCoords = vector3(-1587.23, 2805.08, 19.82),
		authorizedJobs = { 'ambulance', 'police', 'militar', 'fbi' },
		locked = true,
		distance = 12,
		size = 2
	},
	
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(-1600.29, 2793.74, 15.74),
		textCoords = vector3(-1600.29, 2793.74, 19.74),
		authorizedJobs = { 'ambulance', 'police', 'militar', 'fbi' },
		locked = true,
		distance = 12,
		size = 2
	},
-- Zancudo Military Base Back Entrance
{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(-2296.17, 3393.1, 30.07),
	textCoords = vector3(-2296.17, 3393.1, 34.07),
	authorizedJobs = { 'ambulance', 'police', 'militar', 'fbi' },
	locked = true,
	distance = 12,
	size = 2
},
{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(-2306.13, 3379.3, 30.2),
	textCoords = vector3(-2306.13, 3379.3, 34.2),
	authorizedJobs = { 'ambulance', 'police', 'militar', 'fbi' },
	locked = true,
	distance = 12,
	size = 2
},
-- Paleto Bay Parking Lot Gate
{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(-451.04, 6025.31, 30.12),
	textCoords = vector3(-453.6, 6027.87, 32.12),
	authorizedJobs = { 'police', 'militar', 'fbi' },
	locked = true,
	distance = 14,
	size = 2
},
-- Mission Row PD Parking Lot Gate
{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(415.85, -1025.08, 28.15),
	textCoords = vector3(415.85, -1021.49, 30.15),
	authorizedJobs = { 'police', 'militar', 'fbi' },
	locked = true,
	distance = 14,
	size = 2
},
-- Sandy Shores Parking Lot Gates
-- PD Front Gate
{
	objName = 'prop_gate_military_01',
	objCoords  = vector3(1871.62, 3681.23, 32.35),
	textCoords = vector3(1871.62, 3681.23, 34.35),
	authorizedJobs = { 'ambulance', 'police', 'militar', 'fbi'  },
	locked = true,
	distance = 14,
	size = 2
},
-- PD Back Gate
{
	objName = 'prop_gate_military_01',
	objCoords  = vector3(1858.11, 3719.22, 32.03),
	textCoords = vector3(1858.11, 3719.22, 34.03),
	authorizedJobs = { 'ambulance', 'police', 'militar', 'fbi'  },
	locked = true,
	distance = 14,
	size = 2
},
-- FR Back Gate (Exit)
{
	objName = 'prop_gate_military_01',
	objCoords  = vector3(1845.07, 3712.2, 32.17),
	textCoords = vector3(1845.07, 3712.2, 34.17),
	authorizedJobs = { 'ambulance', 'police', 'militar', 'fbi'  },
	locked = true,
	distance = 14,
	size = 2
},
-- FR Front Gate (Entrance)
{
	objName = 'prop_gate_military_01',
	objCoords  = vector3(1804.49, 3675.7, 33.21),
	textCoords = vector3(1804.49, 3675.7, 35.21),
	authorizedJobs = { 'ambulance', 'police', 'militar', 'fbi'  },
	locked = true,
	distance = 14,
	size = 2
},
-- Los Santos | FBI Building
-- Entrance Double Doors
{
	objName = 'v_ilev_fibl_door02',
	objCoords  = vector3(106.37, -742.69, 46.18),
	textCoords = vector3(106.07, -743.76, 46.18),
	authorizedJobs = { 'police', 'militar', 'fbi'  },
	locked = false,
	distance = 6
},
{
	objName = 'v_ilev_fibl_door01',
	objCoords  = vector3(105.76, -746.64, 46.18),
	textCoords = vector3(105.71, -745.28, 46.18),
	authorizedJobs = { 'police', 'militar', 'fbi'  },
	locked = false,
	distance = 6
},
-- Front Gates | Left - Right
{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(185.59, -732.54, 32.77),
	textCoords = vector3(186.82, -729.06, 34.77),
	authorizedJobs = { 'police', 'militar', 'fbi'  },
	locked = true,
	distance = 25,
	size = 2
},
{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(190.6, -718.76, 32.77),
	textCoords = vector3(189.27, -722.17, 34.77),
	authorizedJobs = { 'police', 'militar', 'fbi'  },
	locked = true,
	distance = 25,
	size = 2
},
-- Back Gates | Left - Right
{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(82.51, -684.89, 30.68),
	textCoords = vector3(81.26, -688.39, 32.68),
	authorizedJobs = { 'police', 'militar', 'fbi'  },
	locked = true,
	distance = 25,
	size = 2
},
{
	objName = 'prop_gate_airport_01',
	objCoords  = vector3(77.53, -698.55, 30.68),
	textCoords = vector3(78.80, -695.21, 32.68),
	authorizedJobs = { 'police', 'militar', 'fbi'  },
	locked = true,
	distance = 25,
	size = 2
},
--Дом негра, двери мафии X:7,518359 Y:539,5268 Z:176,1776
{
	objName = 'v_ilev_fh_frontdoor',
	objCoords  = vector3(7.518359, 539.5268, 176.1776),
	textCoords = vector3(8.30, 538.5268, 176.1776),
	authorizedJobs = { 'police', 'militar', 'mafia', 'fbi'  },
	locked = true,
	distance = 10,
	size = 1
},
--Байкерский клуб Lost MC
{
	objName = 'v_ilev_lostdoor',
	objCoords  = vector3(981.1506, -103.2552, 74.99358),
	textCoords = vector3(981.1506, -103.0, 74.99358),
	authorizedJobs = { 'police', 'militar', 'fbi', 'thelostmc'  },
	locked = true,
	distance = 10,
	size = 1
},
--Дом френклина
{
	objName = 'v_ilev_fa_frontdoor',
	objCoords  = vector3(-14.86892, -1441.182, 31.19323),
	textCoords = vector3(-13.9, -1441, 31.19323),
	authorizedJobs = { 'police', 'militar', 'fbi', 'ballas'  },
	locked = true,
	distance = 10,
	size = 1
}

	
	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(420.1, -1017.3, 28.0),
		textCoords = vector3(420.1, -1021.0, 32.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}
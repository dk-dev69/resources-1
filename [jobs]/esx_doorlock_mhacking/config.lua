Config = {}
Config.Locale = 'en'

Config.DoorList = {

	-- principal bank
	{
		objName = 'hei_v_ilev_bk_gate2_pris',
		objCoords  = {x = 261.99899291992, y = 221.50576782227, z = 106.68346405029},
		textCoords = {x = 261.99899291992, y = 221.50576782227, z = 107.68346405029}, 
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},
	
	{
		objName = 'v_ilev_rc_door3_l',
		objCoords  = vector3(-610.35, -1609.93, 27.03),
		textCoords = vector3(-610.35, -1609.93, 27.03),
		authorizedJobs = { 'palhaco' },
		locked = true
	},
	
	{
		objName = 'v_ilev_rc_door3_r',
		objCoords  = vector3(-610.35, -1609.93, 27.03),
		textCoords = vector3(-610.35, -1609.93, 27.03),
		authorizedJobs = { 'palhaco' },
		locked = true
	},
	
	{
		objName = 'prop_com_gar_door_01',
		objCoords  = vector3(484.49, -1315.76, 29.2),
		textCoords = vector3(484.49, -1315.76, 29.2),
		authorizedJobs = { 'six' },
		locked = true,
		distance = 12,
		size = 2
	},
	
    {
		objName = 'v_ilev_cs_door',
		objCoords  = vector3(482.98, -1312.47, 29.2),
		textCoords = vector3(482.98, -1312.47, 29.2),
		authorizedJobs = { 'six' },
		locked = true,
		distance = 12,
		size = 2
	},
	
	
	{
	    objName = 'lr_prop_supermod_door_01',
		objCoords  = vector3(-205.6828, -1310.683, 30.29572),
		textCoords = vector3(-205.6828, -1310.683, 30.29572),
		authorizedJobs = { 'jdm' },
		locked = true,
		distance = 12,
		size = 2
	},

	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = 420.133, y = -1017.301, z = 28.086},
		textCoords = {x = 420.133, y = -1021.00, z = 32.00},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}
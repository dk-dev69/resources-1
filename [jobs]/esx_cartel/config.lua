Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 3
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'ru'

Config.CartelStations = {

  Cartel = {

    Harita2 = {
      Pos     = { x = 1365.45, y = 1145.79, z = 113.75 },
      Sprite  = 89,
      Display = 4,
      Scale   = 1.0,
      Colour  = 57,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_KNIFE',     price = 10000 },
      { name = 'WEAPON_BAT',       price = 20000 },
      { name = 'WEAPON_CROWBAR',     price = 25000 },
      { name = 'WEAPON_HATCHET',      price = 30000 },
      { name = 'WEAPON_MACHETE',          price = 30000 },
      { name = 'WEAPON_PISTOL',       price = 75000 },
      { name = 'WEAPON_PISTOL50', price = 100000 },
      { name = 'WEAPON_MICROSMG',         price = 250000 },
      { name = 'WEAPON_PUMPSHOTGUN',        price = 200000 },     
	  { name = 'WEAPON_COMPACTRIFLE',        price = 200000 },
	  { name = 'GADGET_PARACHUTE',        price = 2000 },

    },

	  AuthorizedVehicles = {
		  { name = 'cognoscenti2',  label = 'Легковой бронированный транспорт' },
		  { name = 'Manchez',    label = 'Мотоцикл Manchez' },
		  { name = 'Contender',   label = 'Contender 4X4' },
		  --{ name = '17m760i',      label = 'Гражданский авто' },
		  { name = 'Guardian',      label = 'Guardian 4x4 с кузовом' },
		  
	  },

    Cloakrooms = {
         {x = -100.30500793457, y = -100.3337402344, z = -100.0060696601868 },
    },

    Armories = {
      { x = 1392.50, y = 1149.88, z = 114.33 },
    },

    Vehicles = {
      {
        Spawner    = { x = 1401.25, y = 1115.01, z = 114.83 },
        SpawnPoint = { x = 1397.64, y = 1117.67, z = 114.83 },
        Heading    = 296.36,
      }
    },

	Helicopters = {
      {
        Spawner    = { x = -100.30500793457, y = -100.3337402344, z = -100.0060696601868 },
        SpawnPoint = { x = -100.94457244873, y = -100.5942382813, z = -100.0050659179688 },
        Heading    = 0.0,
      }
    },
    VehicleDeleters = {
      { x = 1407.96, y = 1115.43, z = 114.83 },
      { x = -1542.51, y = 889.67, z = 180.52 },
    },

    BossActions = {
       { x = 1399.15, y = 1164.64, z = 114.33 },
    },

  },

}

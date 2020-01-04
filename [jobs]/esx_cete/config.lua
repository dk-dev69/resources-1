Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = false
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.ceteStations = {

  cete = {

    Harita = {
      Pos     = { x = 2449.01, y = 4979.05, z = 57.81 },
      Sprite  = 84,
      Display = 4,
      Scale   = 1.2,
    },

    AuthorizedWeapons = {
     { name = 'WEAPON_KNIFE',     price = 20000 },
      { name = 'WEAPON_BAT',       price = 20000 },
      { name = 'WEAPON_CROWBAR',     price = 25000 },
      { name = 'WEAPON_HATCHET',      price = 30000 },
      { name = 'WEAPON_MACHETE',          price = 30000 },
      { name = 'WEAPON_BOTTLE',     price = 10000 },
      { name = 'WEAPON_MOLOTOV',         price = 10000 },	  
	  
    },

	  AuthorizedVehicles = {
		  { name = 'gmcyd',  label = 'Range Rover' },
		  { name = 'rr14',      label = 'GMC' },
	  },

    Cloakrooms = {
      { x = 2454.581, y = 4992.28, z = 45.81 },
    },

    Armories = {
      { x = 2457.81, y = 4989.07, z = 45.81 },
    },

    Vehicles = {
      {
        Spawner    = { x = 2411.62, y = 4972.95, z = 45.14 },
        SpawnPoint = { x = 2416.4, y = 4969.64, z = 45.14 },
        Heading    = 90.0,
      }
    },
	
	Helicopters = {
      {
        Spawner    = { x = 20.312, y = 535.667, z = 173.627 },
        SpawnPoint = { x = 3.40, y = 525.56, z = 177.919 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 2424.57, y = 4956.97, z = 44.86 },
    },

    BossActions = {
      { x = 2454.06, y = 4984.51, z = 45.81 }
    },

  },

}

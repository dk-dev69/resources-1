Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 3
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

Config.BishopsStations = {

  Bishops = {

    Blip = {
      Pos     = { x = 979.43, y = -116.93, z = 73.09 },
      Sprite  = 226,
      Display = 4,
      Scale   = 1.2,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_KNIFE',     price = 2000000 },

    },

	  AuthorizedVehicles = {
	
		  { name = 'zombiea',      label = 'Motor 1' },
		  { name = 'zombieb',   label = 'Motor 2' },
		  { name = 'sovereign',      label = 'Motor 3' },
		  { name = 'gburrito2',   label = 'Araç 1' },
	  },

    Cloakrooms = {
      { x = 984.64, y = -91.52, z = 74.85 },
    },

    Armories = {
      { x = 976.44, y = -103.29, z = 73.85 },
    },

    Vehicles = {
      {
        Spawner    = { x = 986.02, y = -138.11, z = 72.09 },
        SpawnPoint = { x = 967.58, y = -127.95, z = 74.38 },
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
      { x = 965.18, y = -119.1, z = 73.35 },
      { x = 969.86, y = -114.3, z = 73.35 },
    },

    BossActions = {
      { x = 965.18, y = -114.3, z = 73.35 },
    },

  },

}

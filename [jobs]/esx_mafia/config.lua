Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'ru'

Config.MafiaStations = {

  Mafia = {

    Blip = {
      Pos     = { x = 9.000, y = 536.000, z = 177.000 },
      Sprite  = 78,
      Display = 4,
      Scale   = 1.0,
      Colour  = 59,
    },

    AuthorizedWeapons = {
      { name = 'WEAPON_COMBATPISTOL',     price = 4000 },
      { name = 'WEAPON_ASSAULTSMG',       price = 15000 },
      { name = 'WEAPON_ASSAULTRIFLE',     price = 25000 },
      { name = 'WEAPON_PUMPSHOTGUN',      price = 9000 },
      { name = 'WEAPON_STUNGUN',          price = 250 },
      { name = 'WEAPON_FLASHLIGHT',       price = 50 },
      { name = 'WEAPON_FIREEXTINGUISHER', price = 50 },
      { name = 'WEAPON_FLAREGUN',         price = 3000 },
      { name = 'GADGET_PARACHUTE',        price = 2000 },
      { name = 'WEAPON_SNIPERRIFLE',      price = 50000 },
      { name = 'WEAPON_FIREWORK',         price = 5000 },
      { name = 'WEAPON_BZGAS',            price = 8000 },
      { name = 'WEAPON_SMOKEGRENADE',     price = 8000 },
      { name = 'WEAPON_APPISTOL',         price = 12000 },
      { name = 'WEAPON_CARBINERIFLE',     price = 25000 },
      { name = 'WEAPON_HEAVYSNIPER',      price = 100000 },
      { name = 'WEAPON_FLARE',            price = 8000 },
      { name = 'WEAPON_SWITCHBLADE',      price = 500 },
	  { name = 'WEAPON_REVOLVER',         price = 6000 },
	  { name = 'WEAPON_POOLCUE',          price = 100 },
	  { name = 'WEAPON_GUSENBERG',        price = 17500 },
	  
    },

	  AuthorizedVehicles = {
		  { name = 'BType3',  label = 'Четырех местный седан' },
		  { name = 'btype',      label = 'Классчиеский седан' },
		  { name = 'Virgo2',   label = 'Седан' },
		  { name = 'SlamVan3',      label = 'Пикап' },
		  --{ name = 'guardian',   label = 'Grand 4x4' },
		  { name = 'Rumpo3',   label = 'Минивен' },
		  --{ name = 'mesa',       label = 'Tout-Terrain' },
	  },

	--Раздевалка
    Cloakrooms = {
      { x = 9.000, y = 529.000, z = 171.000 },
    },

    Armories = {
      { x = 1.560, y = 529.820, z = 170.630 },
    },
	--Транспорт
    Vehicles = {
      {
        Spawner    = { x = 16.940, y = 548.860, z = 176.160 },
        SpawnPoint = { x = 8.237, y = 556.963, z = 175.266 },
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
      { x = 22.74, y = 545.9, z = 175.027 },
      { x = 21.35, y = 543.3, z = 175.027 },
    },

    BossActions = {
      { x = 4.113, y = 526.897, z = 173.628 }
    },

  },

}

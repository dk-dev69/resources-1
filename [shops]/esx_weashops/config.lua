Config                = {}
Config.DrawDistance   = 100
Config.Size           = { x = 1.5, y = 1.5, z = 1.5 }
Config.Color          = { r = 0, g = 128, b = 255 }
Config.Type           = 1
Config.Locale         = 'ru'
Config.EnableLicense  = true
Config.LicensePrice   = 25000

Config.Zones = {

	GunShop = {
		Legal = true,
		Items = {},
		Locations = {
			vector3(1693.4, 3759.5, 34.7),
			vector3(-330.2, 6083.8, 31.4),
			vector3(2567.71, 294.94, 108.73),
			vector3(-1117.5, 2698.6, 18.5)
		}
	},

	BlackWeashop = {
		Legal = false,
		Items = {},
		Locations = {
		vector3(-1306.2, -394.0, 36.6)
		}
	}

}

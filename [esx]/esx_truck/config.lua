Config               = {}

Config.Locale        = 'ru'

Config.LicenseEnable = true -- enable boat license? Requires esx_license
Config.LicensePrice  = 40000

Config.MarkerType    = 1
Config.DrawDistance  = 100.0

Config.Marker = {
	r = 154, g = 31, b = 0, -- blue-ish color
	x = 1.5, y = 1.5, z = 1.0  -- standard size circle
}

Config.StoreMarker = {
	r = 255, g = 0, b = 0,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing boat
}

Config.Zones = {
	
	Garages = {

		{ -- Elysian Island, Walker Logistics
			GaragePos  = { x = 193.12, y = -3203.28, z = 4.80 },
			SpawnPoint = { x = 187.04, y = -3213.28, z = 4.85, h = 1.00 },
			StorePos   = { x = 187.04, y = -3213.28, z = 4.85 },
			StoreTP    = { x = 193.12, y = -3203.28, z = 4.80, h = 1.00 }
		},

	},

	TruckShops = {

		{ -- Elysian Island / Walker Logistics
			Outside = { x = 151.60, y = -3189.36, z = 4.87 },
			Inside  = { x = 139.83, y = -3204.18, z = 4.92, h = 270.00 },
		}

	}

}

Config.Vehicles = {

	{
		model = 'rubble',
		label = 'Rubble',
		price = 75000
	},

	{
		model = 'biff',
		label = 'Biff',
		price = 70000
	},

	{
		model = 'packer',
		label = 'Packer',
		price = 95000
	},

	{
		model = 'hauler',
		label = 'Hauler',
		price = 90000
	},

	{
		model = 'phantom',
		label = 'Phantom',
		price = 125000
	},

	{
		model = 'phantom3',
		label = 'Phantom Custom',
		price = 150000
	},

	{
		model = 'stockade',
		label = 'Stockade Armored Truck',
		price = 60000
	},

	{
		model = 'mule',
		label = 'Small Box Van',
		price = 40000
	},

	{
		model = 'pounder',
		label = 'Large Box Van',
		price = 65000
	},

	{
		model = 'benson',
		label = 'Food Delivery Van',
		price = 65000
	},

	{
		model = 'trash',
		label = 'Garbage Truck',
		price = 60000
	},

	{
		model = 'tanker2',
		label = 'Fuel Tanker Trailer',
		price = 50000
	},

	{
		model = 'trflat',
		label = 'Flatbed Trailer',
		price = 50000
	},

	{
		model = 'trailers',
		label = 'Dry Van Trailer',
		price = 50000
	},

	{
		model = 'docktrailer',
		label = 'Dock Container Trailer',
		price = 50000
	}

}
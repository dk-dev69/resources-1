# DBGPrisonYard
version 1.0 DBG FiveM Prison Yard YMAP

Download DBGPrisonYard

Extract files to DBGPrisonYard

Add to /resources

Add to start cfg

For Teleporter:

Download Qalle's esx_teleports-> https://github.com/qalle-fivem/esx_teleports


Change your esx_teleports config to have the following:

	['PrisonYard'] = {
		['Job'] = 'none',
		['Enter'] = { 
			['x'] = 1786.88, 
			['y'] = 2484.48, 
			['z'] = -123.4,
			['Information'] = 'Go to the yard',
		},
		['Exit'] = {
			['x'] = 1659.08, 
			['y'] = 2539.22, 
			['z'] = 44.56, 
			['Information'] = 'Go back inside' 
		}
	},

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()
	ParkTrucks()
end)

function ParkTrucks()
	MySQL.Async.execute('UPDATE owned_vehicles SET stored = true WHERE stored = @stored AND vehicleType = @vehicleType',
	{
		['@stored']      = false,
		['@vehicleType'] = 'truck'
	}, function (rowsChanged)
		if rowsChanged > 0 then
			print(('esx_truck: %s грузовик был гараж!'):format(rowsChanged))
		end
	end)
end

ESX.RegisterServerCallback('esx_truck:buyTruck', function (source, cb, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price   = getPriceFromModel(vehicleProps.modelAlt)

	vehicleProps.modelAlt = nil

	-- vehicle model not found
	if price == 0 then
		print(('esx_truck: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, vehicleType) VALUES (@owner, @plate, @vehicle, @vehicleType)',
		{
			['@owner']       = xPlayer.identifier,
			['@plate']       = vehicleProps.plate,
			['@vehicle']     = json.encode(vehicleProps),
			['@vehicleType'] = 'truck'
		}, function (rowsChanged)
			cb(true)
		end)
	else
		cb(false)
	end
end)

RegisterServerEvent('esx_truck:takeOutVehicle')
AddEventHandler('esx_truck:takeOutVehicle', function (plate)
	MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE owner = @owner AND plate = @plate',
	{
		['@stored'] = false,
		['@owner']  = GetPlayerIdentifiers(source)[1],
		['@plate']  = plate
	}, function (rowsChanged)
		if rowsChanged == 0 then
			print(('esx_truck: %s exploited the garage!'):format(GetPlayerIdentifiers(source)[1]))
		end
	end)
end)

ESX.RegisterServerCallback('esx_truck:storeVehicle', function (source, cb, plate)
	MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE owner = @owner AND plate = @plate',
	{
		['@stored'] = true,
		['@owner']  = GetPlayerIdentifiers(source)[1],
		['@plate']  = plate
	}, function (rowsChanged)
		if rowsChanged == 0 then
			print(('esx_truck: %s attempted to store a truck they don\'t own!'):format(GetPlayerIdentifiers(source)[1]))
		end

		cb(rowsChanged)
	end)
end)

ESX.RegisterServerCallback('esx_truck:getGarage', function (source, cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND vehicleType = @vehicleType AND stored = @stored',
	{
		['@owner']       = GetPlayerIdentifiers(source)[1],
		['@vehicleType'] = 'truck',
		['@stored']      = true
	}, function (result)
		local vehicles = {}

		for i=1, #result, 1 do
			local vehicleProps = json.decode(result[i].vehicle)
			table.insert(vehicles, vehicleProps)
		end

		cb(vehicles)
	end)

end)

ESX.RegisterServerCallback('esx_truck:buyTruckLicense', function (source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', source, 'truck', function()
			cb(true)
		end)
	else
		cb(false)
	end
end)

function getPriceFromModel(model)
	for i=1, #Config.Vehicles, 1 do
		if Config.Vehicles[i].model == model then
			return Config.Vehicles[i].price
		end
	end

	return 0
end
local HasAlreadyEnteredMarker = false
local LastZone                = nil

CurrentAction     = nil
CurrentActionMsg  = ''
CurrentActionData = {}

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then

			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'truck_shop' then

					if not Config.LicenseEnable then
						OpenTruckShop(Config.Zones.TruckShops[CurrentActionData.zoneNum])
					else -- check for license

						ESX.TriggerServerCallback('esx_license:checkLicense', function (hasTruckLicense)
							if hasTruckLicense then
								OpenTruckShop(Config.Zones.TruckShops[CurrentActionData.zoneNum])
							else
								OpenLicenceMenu(Config.Zones.TruckShops[CurrentActionData.zoneNum])
							end
						end, GetPlayerServerId(PlayerId()), 'truck')

					end
					
				elseif CurrentAction == 'garage_out' then
					OpenTruckGarage(Config.Zones.Garages[CurrentActionData.zoneNum])
				elseif CurrentAction == 'garage_in' then
					StoreTruckInGarage(CurrentActionData.vehicle, Config.Zones.Garages[CurrentActionData.zoneNum].StoreTP)
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_truck:hasEnteredMarker', function(zone, zoneNum)
	if zone == 'truck_shop' then
		CurrentAction     = 'truck_shop'
		CurrentActionMsg  = _U('truck_shop_open')
		CurrentActionData = { zoneNum = zoneNum }
	elseif zone == 'garage_out' then
		CurrentAction     = 'garage_out'
		CurrentActionMsg  = _U('garage_open')
		CurrentActionData = { zoneNum = zoneNum }
	elseif zone == 'garage_in' then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
	
		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)
	
			if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
				CurrentAction     = 'garage_in'
				CurrentActionMsg  = _U('garage_store')
				CurrentActionData = { vehicle = vehicle, zoneNum = zoneNum }
			end
	
		end
	end
end)

AddEventHandler('esx_truck:hasExitedMarker', function()
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Draw markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		for i=1, #Config.Zones.TruckShops, 1 do
			-- draw truck shop marker
			local zone = Config.Zones.TruckShops[i].Outside
			if GetDistanceBetweenCoords(coords, zone.x, zone.y, zone.z, true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, zone.x, zone.y, zone.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, 100, false, true, 2, false, false, false, false)
			end
		end

		for i=1, #Config.Zones.Garages, 1 do
			-- draw garage maker
			local zoneOut = Config.Zones.Garages[i].GaragePos
			if GetDistanceBetweenCoords(coords, zoneOut.x, zoneOut.y, zoneOut.z, true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, zoneOut.x, zoneOut.y, zoneOut.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, 100, false, true, 2, false, false, false, false)
			end

			-- draw store marker
			local zoneIn = Config.Zones.Garages[i].StorePos
			if GetDistanceBetweenCoords(coords, zoneIn.x, zoneIn.y, zoneIn.z, true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, zoneIn.x, zoneIn.y, zoneIn.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.StoreMarker.x, Config.StoreMarker.y, Config.StoreMarker.z, Config.StoreMarker.r, Config.StoreMarker.g, Config.StoreMarker.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

	while true do

		Citizen.Wait(1)

		local playerPed      = PlayerPedId()
		local coords         = GetEntityCoords(playerPed)
		local isInMarker     = false
		local currentZone    = nil
		local currentZoneNum = nil

		for i=1, #Config.Zones.TruckShops, 1 do

			if GetDistanceBetweenCoords(coords, Config.Zones.TruckShops[i].Outside.x, Config.Zones.TruckShops[i].Outside.y, Config.Zones.TruckShops[i].Outside.z,  true) < Config.Marker.x then
				isInMarker     = true
				currentZone    = 'truck_shop'
				currentZoneNum = i
			end

		end

		for i=1, #Config.Zones.Garages, 1 do

			if GetDistanceBetweenCoords(coords, Config.Zones.Garages[i].GaragePos.x, Config.Zones.Garages[i].GaragePos.y, Config.Zones.Garages[i].GaragePos.z, true) < Config.Marker.x then
				isInMarker     = true
				currentZone    = 'garage_out'
				currentZoneNum = i
			end

			if GetDistanceBetweenCoords(coords, Config.Zones.Garages[i].StorePos.x, Config.Zones.Garages[i].StorePos.y, Config.Zones.Garages[i].StorePos.z, true) < Config.StoreMarker.x then
				isInMarker     = true
				currentZone    = 'garage_in'
				currentZoneNum = i
			end

		end

		local hasExited = false

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastZone ~= currentZone or LastZoneNum ~= currentZoneNum) ) then

			if
				(LastZone ~= nil and LastZoneNum ~= nil) and
				(LastZone ~= currentZone or LastZoneNum ~= currentZoneNum)
			then
				TriggerEvent('esx_truck:hasExitedMarker', LastZone)
				hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			LastZoneNum             = currentZoneNum

			TriggerEvent('esx_truck:hasEnteredMarker', currentZone, currentZoneNum)
		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_truck:hasExitedMarker')
		end

	end
end)

-- Blips
Citizen.CreateThread(function()

	local blipList = {}

	for i=1, #Config.Zones.Garages, 1 do
		table.insert(blipList, {
			coords = { Config.Zones.Garages[i].GaragePos.x, Config.Zones.Garages[i].GaragePos.y },
			text   = _U('blip_garage'),
			sprite = 557,
			color  = 64,
			scale  = 0.9
		})
	end

	for i=1, #Config.Zones.TruckShops, 1 do
		table.insert(blipList, {
			coords = { Config.Zones.TruckShops[i].Outside.x, Config.Zones.TruckShops[i].Outside.y },
			text   = _U('blip_shop'),
			sprite = 477,
			color  = 64,
			scale  = 0.9
		})
	end

	for i=1, #blipList, 1 do
		CreateBlip(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, blipList[i].scale)
	end

end)

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord( table.unpack(coords) )

	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)

	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
end
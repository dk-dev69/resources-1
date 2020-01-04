local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local PlayerData              = {}
local BlipList                = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Licenses                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	refreshBlips()
	
	TriggerServerEvent('esx_licenseshop:ServerLoadLicenses')
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	deleteBlips()
	refreshBlips()
end)

-- Open License Shop
function OpenLicenseShop()
	local ownedLicenses = {}
	
	for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end
	
	local elements = {}
	
	if not ownedLicenses['dmv'] then
		table.insert(elements, {label = _U('need_dmv')})
	end
	
	if ownedLicenses['dmv'] then
		if not ownedLicenses['aircraft'] then
			table.insert(elements, {label = _U('license_aircraft') .. ' <span style="color: green;">$' .. Config.AircraftLicensePrice .. '</span>', value = 'buy_license_aircraft'})
		end
		
		if not ownedLicenses['boating'] then
			table.insert(elements, {label = _U('license_boating') .. ' <img class="" width="32" height="32" src="data:image/png;base64,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"></i><span style="color: green;">$' .. Config.BoatingLicensePrice .. '</span>', value = 'buy_license_boating'})
		end
		
		if not ownedLicenses['drive_truck'] then
			table.insert(elements, {label = _U('license_commercial') .. ' <span style="color: green;">$' .. Config.CommercialLicensePrice .. '</span>', value = 'buy_license_commercial'})
		end
		
		if not ownedLicenses['drive'] then
			table.insert(elements, {label = _U('license_drivers') .. ' <span style="color: green;">$' .. Config.DriversLicensePrice .. '</span>', value = 'buy_license_drivers'})
		end
		
		if not ownedLicenses['drive_bike'] then
			table.insert(elements, {label = _U('license_motorcycle') .. ' <span style="color: green;">$' .. Config.MotorcyleLicensePrice .. '</span>', value = 'buy_license_motorcycle'})
		end
		
		if not ownedLicenses['weapon'] then
			table.insert(elements, {label = _U('license_weapon') .. ' <span style="color: green;">$' .. Config.WeaponLicensePrice .. '</span>', value = 'buy_license_weapon'})
		end
		
		if not ownedLicenses['weed_processing'] then
			table.insert(elements, {label = _U('license_weed') .. ' <span style="color: green;">$' .. Config.WeedLicensePrice .. '</span>', value = 'buy_license_weed'})
		end
	end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_shop_actions', {
		title    = _U('buy_license'),
		elements = elements,
		align    = 'top-left'
	}, function(data, menu)
		if data.current.value == 'buy_license_aircraft' then
			TriggerServerEvent('esx_licenseshop:buyLicenseAircraft')
			menu.close()
		elseif data.current.value == 'buy_license_boating' then
			TriggerServerEvent('esx_licenseshop:buyLicenseBoating')
			menu.close()
		elseif data.current.value == 'buy_license_commercial' then
			TriggerServerEvent('esx_licenseshop:buyLicenseCommercial')
			menu.close()
		elseif data.current.value == 'buy_license_drivers' then
			TriggerServerEvent('esx_licenseshop:buyLicenseDrivers')
			menu.close()
		elseif data.current.value == 'buy_license_motorcycle' then
			TriggerServerEvent('esx_licenseshop:buyLicenseMotorcyle')
			menu.close()
		elseif data.current.value == 'buy_license_weapon' then
			TriggerServerEvent('esx_licenseshop:buyLicenseWeapon')
			menu.close()
		elseif data.current.value == 'buy_license_weed' then
			TriggerServerEvent('esx_licenseshop:buyLicenseWeed')
			menu.close()
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'license_menu'
		CurrentActionMsg  = _U('press_access')
		CurrentActionData = {}
	end)
end

AddEventHandler('esx_licenseshop:hasEnteredMarker', function(zone)
	CurrentAction     = 'license_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = {}
end)

AddEventHandler('esx_licenseshop:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

RegisterNetEvent('esx_licenseshop:loadLicenses')
AddEventHandler('esx_licenseshop:loadLicenses', function(licenses)
	Licenses = licenses
end)

-- Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())
		local canSleep = true

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				canSleep = false
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
		
		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Activate Menu when in Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(200)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_licenseshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_licenseshop:hasExitedMarker', LastZone)
		end
		
		if not isInMarker then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'license_menu' then
					OpenLicenseShop()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Blips
function deleteBlips()
	if BlipList[1] ~= nil then
		for i=1, #BlipList, 1 do
			RemoveBlip(BlipList[i])
			BlipList[i] = nil
		end
	end
end

function refreshBlips()
	if Config.EnableBlips then
		if Config.EnableUnemployedOnly then
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'unemployed' or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'gang' then
				for k,v in pairs(Config.Locations) do
					local blip = AddBlipForCoord(v.x, v.y)

					SetBlipSprite (blip, Config.BlipLicenseShop.Sprite)
					SetBlipDisplay(blip, Config.BlipLicenseShop.Display)
					SetBlipScale  (blip, Config.BlipLicenseShop.Scale)
					SetBlipColour (blip, Config.BlipLicenseShop.Color)
					SetBlipAsShortRange(blip, true)

					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(_U('blip_license_shop'))
					EndTextCommandSetBlipName(blip)
					table.insert(BlipList, blip)
				end
			end
		else
			for k,v in pairs(Config.Locations) do
				local blip = AddBlipForCoord(v.x, v.y)

				SetBlipSprite (blip, Config.BlipLicenseShop.Sprite)
				SetBlipDisplay(blip, Config.BlipLicenseShop.Display)
				SetBlipScale  (blip, Config.BlipLicenseShop.Scale)
				SetBlipColour (blip, Config.BlipLicenseShop.Color)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_license_shop'))
				EndTextCommandSetBlipName(blip)
				table.insert(BlipList, blip)
			end
		end
	end
end

-- Create Ped
Citizen.CreateThread(function()
    RequestModel(GetHashKey("a_m_y_business_03"))
	
    while not HasModelLoaded(GetHashKey("a_m_y_business_03")) do
        Wait(1)
    end
	
	if Config.EnablePeds then
		for _, item in pairs(Config.Locations) do
			local npc = CreatePed(4, 0xA1435105, item.x, item.y, item.z, item.heading, false, true)
			
			SetEntityHeading(npc, item.heading)
			FreezeEntityPosition(npc, true)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
		end
	end
end)

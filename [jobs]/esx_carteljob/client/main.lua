local PlayerData, CurrentActionData, HandcuffTimer, dragStatus, blipsCops, currentTask, spawnedVehicles = {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, isDead, isHandcuffed, hasAlreadyJoined, playerInService, isInShopMenu = false, false, false, false, false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
dragStatus.isDragged = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 150)
			end
		else
			if Config.Uniforms[job].female then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 150)
			end
		end
	end)
end

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
		--{ label = _U('bullet_wear'), value = 'bullet_wear' },
		-- { label = _U('gilet_wear'), value = 'gilet_wear' }
	}

	if grade == 'soldato' then
		table.insert(elements, {label = _U('cartel_wear'), value = 'soldato_wear'})
	elseif grade == 'capo' then
		table.insert(elements, {label = _U('cartel_wear'), value = 'capo_wear'})
	elseif grade == 'consigliere' then
		table.insert(elements, {label = _U('cartel_wear'), value = 'consigliere_wear'})
	-- elseif grade == 'intendent' then
		-- table.insert(elements, {label = _U('cartel_wear'), value = 'intendent_wear'})
	-- elseif grade == 'lieutenant' then
		-- table.insert(elements, {label = _U('cartel_wear'), value = 'lieutenant_wear'})
	-- elseif grade == 'chef' then
		-- table.insert(elements, {label = _U('cartel_wear'), value = 'chef_wear'})
	elseif grade == 'boss' then
		table.insert(elements, {label = _U('cartel_wear'), value = 'boss_wear'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			if Config.EnableNonFreemodePeds then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if Config.MaxInService ~= -1 then
				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then
						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'cartel')

						TriggerServerEvent('esx_service:disableService', 'cartel')
						TriggerEvent('esx_carteljob:updateBlip')
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'cartel')
			end
		end

		if Config.MaxInService ~= -1 and data.current.value ~= 'citizen_wear' then
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						if not canTakeService then
							ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
						else
							serviceOk = true
							playerInService = true

							local notification = {
								title    = _U('service_anonunce'),
								subject  = '',
								msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								iconType = 1
							}

							TriggerServerEvent('esx_service:notifyAllInService', notification, 'cartel')
							TriggerEvent('esx_carteljob:updateBlip')
							ESX.ShowNotification(_U('service_in'))
						end
					end, 'cartel')

				else
					serviceOk = true
				end
			end, 'cartel')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		end

		if
			data.current.value == 'soldato_wear' or
			data.current.value == 'capo_wear' or
			data.current.value == 'consigliere_wear' or
			-- data.current.value == 'intendent_wear' or
			-- data.current.value == 'lieutenant_wear' or
			-- data.current.value == 'chef_wear' or
			data.current.value == 'boss_wear' or
			data.current.value == 'bullet_wear'
			-- data.current.value == 'gilet_wear'
		then
			setUniform(data.current.value, playerPed)
		end

		-- if data.current.value == 'freemode_ped' then
			-- local modelHash = ''

			-- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				-- if skin.sex == 0 then
					-- modelHash = GetHashKey(data.current.maleModel)
				-- else
					-- modelHash = GetHashKey(data.current.femaleModel)
				-- end

				-- ESX.Streaming.RequestModel(modelHash, function()
					-- SetPlayerModel(PlayerId(), modelHash)
					-- SetModelAsNoLongerNeeded(modelHash)

					-- TriggerEvent('esx:restoreLoadout')
				-- end)
			-- end)
		-- end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenArmoryMenu(station)
	local elements = {
		{label = _U('buy_weapons'), value = 'buy_weapons'}
	}

	if Config.EnableArmoryManagement then
		table.insert(elements, {label = _U('get_weapon'),     value = 'get_weapon'})
		table.insert(elements, {label = _U('put_weapon'),     value = 'put_weapon'})
		table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})
		table.insert(elements, {label = _U('deposit_object'), value = 'put_stock'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = _U('armory'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		elseif data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end)
end

function OpenVehicleSpawnerMenu(type, station, part, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'buy_vehicle'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.action == 'buy_vehicle' then
			local shopElements, shopCoords = {}

			if type == 'car' then
				shopCoords = Config.CartelStations[station].Vehicles[partNum].InsideShop
				local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]

				if #Config.AuthorizedVehicles.Shared > 0 then
					for k,vehicle in ipairs(Config.AuthorizedVehicles.Shared) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							type  = 'car'
						})
					end
				end

				if #authorizedVehicles > 0 then
					for k,vehicle in ipairs(authorizedVehicles) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							type  = 'car'
						})
					end
				else
					if #Config.AuthorizedVehicles.Shared == 0 then
						return
					end
				end
			elseif type == 'helicopter' then
				shopCoords = Config.CartelStations[station].Helicopters[partNum].InsideShop
				local authorizedHelicopters = Config.AuthorizedHelicopters[PlayerData.job.grade_name]

				if #authorizedHelicopters > 0 then
					for k,vehicle in ipairs(authorizedHelicopters) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							livery = vehicle.livery or nil,
							type  = 'helicopter'
						})
					end
				else
					ESX.ShowNotification(_U('helicopter_notauthorized'))
					return
				end
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('esx_vehicleshop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'top-left',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)

									TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, type)
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end

	ESX.TriggerServerCallback('esx_carteljob:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(function()
				BeginTextCommandBusyString('STRING')
				AddTextComponentSubstringPlayerName(_U('garage_storing'))
				EndTextCommandBusyString(4)

				while IsBusy do
					Citizen.Wait(100)
				end

				RemoveLoadingPrompt()
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			IsBusy = false
			ESX.ShowNotification(_U('garage_has_stored'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(station, part, partNum)
	local spawnPoints = Config.CartelStations[station][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
			title    = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align    = 'top-left',
			elements = {
				{label = _U('confirm_no'), value = 'no'},
				{label = _U('confirm_yes'), value = 'yes'}
		}}, function(data2, menu2)
			if data2.current.value == 'yes' then
				local newPlate = exports['esx_vehicleshop']:GeneratePlate()
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate

				ESX.TriggerServerCallback('esx_carteljob:buyJobVehicle', function (bought)
					if bought then
						ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))

						isInShopMenu = false
						ESX.UI.Menu.CloseAll()
						DeleteSpawnedVehicles()
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)

						ESX.Game.Teleport(playerPed, restoreCoords)
					else
						ESX.ShowNotification(_U('vehicleshop_money'))
						menu2.close()
					end
				end, props, data.current.type)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()

		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()
		WaitForVehicleToLoad(data.current.model)

		ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			exports["LegacyFuel"]:SetFuel(vehicle, 100)
			SetModelAsNoLongerNeeded(data.current.model)

			if data.current.livery then
				SetVehicleModKit(vehicle, 0)
				SetVehicleLivery(vehicle, data.current.livery)
			end
		end)
	end)

	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		exports["LegacyFuel"]:SetFuel(vehicle, 100) 
		SetModelAsNoLongerNeeded(elements[1].model)

		if elements[1].livery then
			SetVehicleModKit(vehicle, 0)
			SetVehicleLivery(vehicle, elements[1].livery)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyString('STRING')
		AddTextComponentSubstringPlayerName(_U('vehicleshop_awaiting_model'))
		EndTextCommandBusyString(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		RemoveLoadingPrompt()
	end
end

function OpenCartelActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cartel_actions', {
		title    = 'Картель',
		align    = 'top-left',
		elements = {
			{label = _U('citizen_interaction'), value = 'citizen_interaction'},
			--{label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
			--{label = _U('object_spawner'), value = 'object_spawner'},
			--{label = "Тюрьма", value = 'jail_menu'}
	}}, function(data, menu)
	
		-- if data.current.value == 'jail_menu' then
            -- TriggerEvent("esx-qalle-jail:openJailMenu")
        -- end
	
		if data.current.value == 'citizen_interaction' then
			local elements = {
				--{label = _U('id_card'), value = 'identity_card'},
				--{label = _U('search'), value = 'body_search'},
				{label = _U('handcuff'), value = 'handcuff'},
				{label = _U('arest'), value = 'uncuff'},
				--{label = _U('drag'), value = 'drag'},
				{label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
				--{label = _U('fine'), value = 'fine'},
				--{label = _U('unpaid_bills'), value = 'unpaid_bills'},
				--{label = _U('Zona'),   value = 'jail_menu'},
				{label = _U('revive_player'), value = 'revive'}
			}

			
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('citizen_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value
					
					if action == 'revive' then
						IsBusy = true
						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								if IsPedDeadOrDying(closestPlayerPed, 1) then
									local playerPed = PlayerPedId()
									ESX.ShowNotification(_U('revive_inprogress'))
									local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
									for i=1, 15, 1 do
										Citizen.Wait(900)
								
										ESX.Streaming.RequestAnimDict(lib, function()
											TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
										end)
									end

									TriggerServerEvent('esx_ambulancejob:removeItem', 'firstaidkit')
									TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
									ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
									-- Show revive award?
									-- if Config.ReviveReward > 0 then
										-- ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
									-- else
										-- ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
									-- end
								else
									ESX.ShowNotification(_U('player_not_unconscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
							IsBusy = false
						end, 'firstaidkit')
					------------------вставка для мед помощи-----------------------------
					
					elseif action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'body_search' then
						TriggerServerEvent('esx_carteljob:message', GetPlayerServerId(closestPlayer), _U('being_searched'))
						OpenBodySearchMenu(closestPlayer)
					elseif action == 'handcuff' then
						--TriggerServerEvent('esx_ruski_areszt:startAreszt', GetPlayerServerId(closestPlayer))
						--Citizen.Wait(3000)
						--TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'unbuckle', 0.7)									
						--Citizen.Wait(3100)		
						TriggerServerEvent('esx_carteljob:handcuff', GetPlayerServerId(closestPlayer))
					elseif action == 'drag' then
						TriggerServerEvent('esx_carteljob:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_carteljob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_carteljob:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					elseif action == 'jail_menu' then
						TriggerEvent("esx-qalle-jail:openJailMenu")
					elseif action == 'revive' then
						TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
					end
				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local vehicle = ESX.Game.GetVehicleInDirection()

			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'), value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'), value = 'hijack_vehicle'})
				table.insert(elements, {label = _U('impound'), value = 'impound'})
			end

			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = _U('vehicle_interaction'),
				align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value

				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					if action == 'vehicle_infos' then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						OpenVehicleInfosMenu(vehicleData)
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
						-- is the script busy?
						if currentTask.busy then
							return
						end

						ESX.ShowHelpNotification(_U('impound_prompt'))
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

						currentTask.busy = true
						currentTask.task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)

						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while currentTask.busy do
								Citizen.Wait(1000)

								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and currentTask.busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(currentTask.task)
									ClearPedTasks(playerPed)
									currentTask.busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('traffic_interaction'),
				align    = 'top-left',
				elements = {
					{label = _U('cone'), model = 'prop_mp_cone_01'},
					{label = ('Световой конус'), model = 'prop_air_conelight'},
					{label = _U('barrier'), model = 'prop_barrier_work05'},
					{label = _U('spikestrips'), model = 'p_ld_stinger_s'},

			}}, function(data2, menu2)
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local forward   = GetEntityForwardVector(playerPed)
				local x, y, z   = table.unpack(coords + forward * 1.0)

				if data2.current.model == 'prop_mp_cone_01' then
					z = z - 3.0
				end

				ESX.Game.SpawnObject(data2.current.model, {x = x, y = y, z = z}, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenIdentityCardMenu(player)
	ESX.TriggerServerCallback('esx_carteljob:getOtherPlayerData', function(data)
		local elements = {}
		local nameLabel = _U('name', data.name)
		local jobLabel, sexLabel, dobLabel, heightLabel, idLabel

		if data.job.grade_label and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end

		if Config.EnableESXIdentity then
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)

			if data.sex then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end

			if data.dob then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end

			if data.height then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end

			if data.name then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
		end

		local elements = {
			{label = nameLabel},
			{label = jobLabel}
		}

		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel})
			table.insert(elements, {label = dobLabel})
			table.insert(elements, {label = heightLabel})
			table.insert(elements, {label = idLabel})
		end

		if data.drunk then
			table.insert(elements, {label = _U('bac', data.drunk)})
		end

		if data.licenses then
			table.insert(elements, {label = _U('license_label')})

			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenBodySearchMenu(player)
	ESX.TriggerServerCallback('esx_carteljob:getOtherPlayerData', function(data)
		local elements = {}

		for i=1, #data.accounts, 1 do
			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end
		end

		table.insert(elements, {label = _U('guns_label')})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label')})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search', {
			title    = _U('search'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				TriggerServerEvent('esx_carteljob:confiscatePlayerItem', GetPlayerServerId(player), data.current.itemType, data.current.value, data.current.amount)
				OpenBodySearchMenu(player)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenFineMenu(player)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		align    = 'top-left',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
	}}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineCategoryMenu(player, category)
	ESX.TriggerServerCallback('esx_carteljob:getFineList', function(fines)
		local elements = {}

		for k,fine in ipairs(fines) do
			table.insert(elements, {
				label     = ('%s <span style="color:green;">%s</span>'):format(fine.label, _U('armory_item', ESX.Math.GroupDigits(fine.amount))),
				value     = fine.id,
				amount    = fine.amount,
				fineLabel = fine.label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
			title    = _U('fine'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_cartel', _U('fine_total', data.current.fineLabel), data.current.amount)
			else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total', data.current.fineLabel), data.current.amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, category)
end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_carteljob:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements, targetName = {}

	ESX.TriggerServerCallback('esx_carteljob:getOtherPlayerData', function(data)
		if data.licenses then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label and data.licenses[i].type then
					table.insert(elements, {
						label = data.licenses[i].label,
						type = data.licenses[i].type
					})
				end
			end
		end

		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('esx_carteljob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))

			TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(player), data.current.type)

			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for k,bill in ipairs(bills) do
			table.insert(elements, {
				label = ('%s - <span style="color:red;">%s</span>'):format(bill.label, _U('armory_item', ESX.Math.GroupDigits(bill.amount))),
				billId = bill.id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)
	ESX.TriggerServerCallback('esx_carteljob:getVehicleInfos', function(retrivedInfo)
		local elements = {{label = _U('plate', retrivedInfo.plate)}}

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown')})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = _U('vehicle_info'),
			align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, vehicleData.plate)
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback('esx_carteljob:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
			title    = _U('get_weapon_menu'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			menu.close()

			ESX.TriggerServerCallback('esx_carteljob:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = _U('put_weapon_menu'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()

		ESX.TriggerServerCallback('esx_carteljob:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)
	end, function(data, menu)
		menu.close()
	end)
end

function OpenBuyWeaponsMenu()
	local elements = {}
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()

	for k,v in ipairs(Config.AuthorizedWeapons[PlayerData.job.grade_name]) do
		local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		local components, label = {}
		local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

		if v.components then
			for i=1, #v.components do
				if v.components[i] then
					local component = weapon.components[i]
					local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

					if hasComponent then
						label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_owned'))
					else
						if v.components[i] > 0 then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_item', ESX.Math.GroupDigits(v.components[i])))
						else
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_free'))
						end
					end

					table.insert(components, {
						label = label,
						componentLabel = component.label,
						hash = component.hash,
						name = component.name,
						price = v.components[i],
						hasComponent = hasComponent,
						componentNum = i
					})
				end
			end
		end

		if hasWeapon and v.components then
			label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
		elseif hasWeapon and not v.components then
			label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
		else
			if v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_item', ESX.Math.GroupDigits(v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
			end
		end

		table.insert(elements, {
			label = label,
			weaponLabel = weapon.label,
			name = weapon.name,
			components = components,
			price = v.price,
			hasWeapon = hasWeapon
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title    = _U('armory_weapontitle'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			end
		else
		
			

				ESX.TriggerServerCallback('esx_carteljob:buyWeapon', function(bought)

					if bought then
						if data.current.price > 0 then
							ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, ESX.Math.GroupDigits(data.current.price)))
						end

						menu.close()
                                                OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end

				end, data.current.name, 1)
			end
		
	end, function(data, menu)
		menu.close()
	end)
end

function OpenWeaponComponentShop(components, weaponName, parentShop)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		title    = _U('armory_componenttitle'),
		align    = 'top-left',
		elements = components
	}, function(data, menu)
		if data.current.hasComponent then
			ESX.ShowNotification(_U('armory_hascomponent'))
		else
			ESX.TriggerServerCallback('esx_carteljob:buyWeapon', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
					end

					menu.close()
					parentShop.close()
					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, weaponName, 2, data.current.componentNum)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_carteljob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('cartel_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_carteljob:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('esx_carteljob:getPlayerInventory', function(inventory)
		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_carteljob:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	Citizen.Wait(5000)
	TriggerServerEvent('esx_carteljob:forceBlip')
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_cartel'),
		number     = 'cartel',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	if PlayerData.job and PlayerData.job.name == 'cartel' and PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.MaxInService ~= -1 and not playerInService then
			CancelEvent()
		end
	end
end)

AddEventHandler('esx_carteljob:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	elseif part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	elseif part == 'Vehicles' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('garage_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'Helicopters' then
		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = _U('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}
	elseif part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_carteljob:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('esx_carteljob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'cartel' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_carteljob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_carteljob:handcuff')
AddEventHandler('esx_carteljob:handcuff', function()
	isHandcuffed    = not isHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, true)
			DisplayRadar(false)

			if Config.EnableHandcuffTimer then
				if HandcuffTimer.active then
					ESX.ClearTimeout(HandcuffTimer.task)
				end

				StartHandcuffTimer()
			end
		else
			if Config.EnableHandcuffTimer and HandcuffTimer.active then
				ESX.ClearTimeout(HandcuffTimer.task)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		end
	end)
end)

RegisterNetEvent('esx_carteljob:unrestrain')
AddEventHandler('esx_carteljob:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.active then
			ESX.ClearTimeout(HandcuffTimer.task)
		end
	end
end)

RegisterNetEvent('esx_carteljob:drag')
AddEventHandler('esx_carteljob:drag', function(copId)
	if not isHandcuffed then
		return
	end

	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if isHandcuffed then
			playerPed = PlayerPedId()

			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_carteljob:putInVehicle')
AddEventHandler('esx_carteljob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not isHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_carteljob:OutVehicle')
AddEventHandler('esx_carteljob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()

	for k,v in pairs(Config.CartelStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job and PlayerData.job.name == 'cartel' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.CartelStations) do

				for i=1, #v.Cloakrooms, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Cloakrooms[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(20, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
					end
				end

				for i=1, #v.Armories, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Armories[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(21, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
					end
				end

				for i=1, #v.Vehicles, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(36, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
					end
				end

				for i=1, #v.Helicopters, 1 do
					local distance =  GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(34, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
					end
				end

				if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						local distance = GetDistanceBetweenCoords(coords, v.BossActions[i], true)

						if distance < Config.DrawDistance then
							DrawMarker(22, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							letSleep = false
						end

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
						end
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
				if
					(LastStation and LastPart and LastPartNum) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_carteljob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_carteljob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_carteljob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_mp_cone_01',
		'prop_air_conelight',
		'prop_barrier_work05',
		'p_ld_stinger_s',
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_carteljob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_carteljob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) and PlayerData.job and PlayerData.job.name == 'cartel' then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()
				elseif CurrentAction == 'menu_armory' then
					if Config.MaxInService == -1 then
						OpenArmoryMenu(CurrentActionData.station)
					elseif playerInService then
						OpenArmoryMenu(CurrentActionData.station)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'menu_vehicle_spawner' then
					if Config.MaxInService == -1 then
						OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
					elseif playerInService then
						OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'Helicopters' then
					if Config.MaxInService == -1 then
						OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
					elseif playerInService then
						OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'cartel', function(data, menu)
						menu.close()

						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = false }) -- disable washing money
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			end
		end -- CurrentAction end

		if IsControlJustReleased(0, 167) and not isDead and PlayerData.job and PlayerData.job.name == 'cartel' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'cartel_actions') then
			if Config.MaxInService == -1 then
				OpenCartelActionsMenu()
			elseif playerInService then
				OpenCartelActionsMenu()
			else
				ESX.ShowNotification(_U('service_not'))
			end
		end

		if IsControlJustReleased(0, 38) and currentTask.busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(currentTask.task)
			ClearPedTasks(PlayerPedId())

			currentTask.busy = false
		end
	end
end)

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)

		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

RegisterNetEvent('esx_carteljob:updateBlip')
AddEventHandler('esx_carteljob:updateBlip', function()

	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end

	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.MaxInService ~= -1 and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end

	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job and PlayerData.job.name == 'cartel' then
		ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'cartel' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)
	end

end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_carteljob:unrestrain')

	if not hasAlreadyJoined then
		TriggerServerEvent('esx_carteljob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_carteljob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'cartel')

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('esx_service:disableService', 'cartel')
		end

		if Config.EnableHandcuffTimer and HandcuffTimer.active then
			ESX.ClearTimeout(HandcuffTimer.task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.active then
		ESX.ClearTimeout(HandcuffTimer.task)
	end

	HandcuffTimer.active = true

	HandcuffTimer.task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_carteljob:unrestrain')
		HandcuffTimer.active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification(_U('impound_successful'))
	currentTask.busy = false
end

local policelogged = false
local blackListedLogged = false
local canOpenMenu = false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(IsControlJustPressed(1, openMenuKey) and GetLastInputMethod(2) and canOpenMenu) then
			SendNUIMessage({
				show = true
			})

			SetNuiFocus(true, true)
		end


		if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
			if(policelogged == false and settings.LogEnterPoliceVehicle == true) then
				TriggerServerEvent("logs:sendPoliceLog",GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))
				policelogged = true
			end
		else
			policelogged = false
		end


		if(IsPedInAnyVehicle(GetPlayerPed(-1), 0)) then
			for _,i in pairs(blacklistedModels) do
				if(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) == i) then
					if(settings.LogEnterBlackListedVehicle and blackListedLogged == false) then
						TriggerServerEvent("logs:sendBlackListedLogs", GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0))))

						if(settings.DeleteWhenEnterBlackListedVehicle) then
							local veh = GetVehiclePedIsIn(GetPlayerPed(-1), 0)

							SetVehicleUndriveable(veh,  true)
							SetPedGetOutUpsideDownVehicle(GetPlayerPed(-1), true)
							SetEntityAsMissionEntity(veh, true, true)
    						Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
    					end
    					blackListedLogged = true
    				end
				end
			end
		else
			if(blackListedLogged) then
				blackListedLogged = false
			end
		end

	end
end)


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		if(settings.LogWhenHaveBlackListedGun) then
			for _,k in pairs(blacklistedGuns) do
				if(HasPedGotWeapon(GetPlayerPed(-1), k, false) == 1) then
					TriggerServerEvent("logs:sendBlackListedWeapon",k)
					if(settings.DeleteBlackListedGun) then
						RemoveWeaponFromPed(GetPlayerPed(-1), k)
					end
				end
			end
		end
		Citizen.Wait(5000)
	end

end)



Citizen.CreateThread(function()
    local isDead = false
    local hasBeenDead = false
	local diedAt

    while true do
        Wait(0)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()

            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true
                if not diedAt then
                	diedAt = GetGameTimer()
                end

                local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
				local killerentitytype = GetEntityType(killer)
				local killertype = -1
				local killerinvehicle = false
				local killervehiclename = ''
                local killervehicleseat = 0
				if killerentitytype == 1 then
					killertype = GetPedType(killer)
					if IsPedInAnyVehicle(killer, false) == 1 then
						killerinvehicle = true
						killervehiclename = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(killer)))
                        killervehicleseat = GetPedVehicleSeat(killer)
					else killerinvehicle = false
					end
				end

				local killerid = GetPlayerByEntityID(killer)
				if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then killerid = GetPlayerServerId(killerid)
				else killerid = -1
				end

                if killer == ped or killer == -1 then
                    TriggerEvent('logs:onPlayerKilled',0, killertype, { table.unpack(GetEntityCoords(ped)) })
                    TriggerServerEvent('logs:onPlayerKilled',0, killertype, { table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                else
                    TriggerEvent('logs:onPlayerKilled', 1,killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped))})
                    TriggerServerEvent('logs:onPlayerKilled',1, killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped))})
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then
                isDead = false
                diedAt = nil
            end
        end
    end
end)

local connected = false
AddEventHandler("playerSpawned", function()
	if(connected == false) then
		TriggerServerEvent("logs:playerConnected")
		connected = true
	end
end)

function GetPlayerByEntityID(id)
	for i=0,32 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end

function DrawNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end


RegisterNetEvent('logs:updateArray')
AddEventHandler('logs:updateArray', function(id, newThings, homeStatsId, value)
	if(canOpenMenu) then
		SendNUIMessage({
			updateArray = true,
			uId = id,
			newthings = newThings,
			updateHomeStats = true,
			homeId = homeStatsId,
			statValue = value
		})
	end
end)


RegisterNetEvent('logs:updateGroup')
AddEventHandler('logs:updateGroup', function(group)
	if(doesArrayContain(groupsAllowedToOpenMenu, group)) then
		canOpenMenu = true
	end
end)



function doesArrayContain(array, value) 
	local bool = false

	for _,k in pairs(array) do
		if(k==value) then
			bool = true
			break
		end
	end

	return bool
end


RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
	SendNUIMessage({
		show = false
	})
	cb("ok")
end)
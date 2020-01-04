ESX = nil
local menuEnabled = false 
local InFocusMode = false

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

function OpenMenu()
	menuEnabled = not menuEnabled
    if ( menuEnabled ) then
		SetNuiFocus( true, true )
        SendNUIMessage({showmenu = true})
    else
		SetNuiFocus( false )
		SendNUIMessage({hidemenu = true})
	end 
end 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ( menuEnabled ) then
            DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring(GetPlayerPed(-1), true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride
        end

        if InFocusMode == true then
            DisableControlAction( 0, 1, true ) -- LookLeftRight
            DisableControlAction( 0, 2, true ) -- LookUpDown
            DisableControlAction( 0, 24, true ) -- Attack
            DisablePlayerFiring(GetPlayerPed(-1), true ) -- Disable weapon firing
            DisableControlAction( 0, 142, true ) -- MeleeAttackAlternate
            DisableControlAction( 0, 106, true ) -- VehicleMouseControlOverride
        end
    end
end)

RegisterNUICallback( "ButtonClick", function( data, cb ) 

    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
    local vehicle = getVehicleInDirection(coordA, coordB)
    local DSDFpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_dside_f"))
    local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
    local steeringpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "steering"))
    local distanceToWheel = GetDistanceBetweenCoords(steeringPos, playerpos, 1)
    local distanceToDSDF = GetDistanceBetweenCoords(DSDFpos, playerpos, 1)

	if ( data == "ToggleDoor" ) then 
            getVehicleDoor()
    elseif ( data == "grabAr" ) then
        PlayerData = ESX.GetPlayerData()
        if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
            if distanceToDSDF <= 3 then
                if GetVehicleDoorAngleRatio(vehicle, 0) > 0.1 then
                    TriggerEvent('getGun', "weapon_carbinerifle")
                elseif GetVehicleDoorAngleRatio(vehicle, 0) <= 0.1 then
                    chatPrint('The door has to be open to grab your gun')
                end
            end
        else
            chatPrint('You have to be a cop to do this')
        end
    elseif ( data == "grabShotgun" ) then 
        PlayerData = ESX.GetPlayerData()
        if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
            if distanceToDSDF <= 3 then
                if GetVehicleDoorAngleRatio(vehicle, 0) > 0.1 then
                    TriggerEvent('getGun', "weapon_pumpshotgun")
                end
            end
        else
            chatPrint('You have to be a cop to do this')
        end
    elseif ( data == "exit" ) then 
            OpenMenu()
    return 
end
	OpenMenu()
end)
--[[
RegisterNetEvent('put/take')
AddEventHandler('put/take', function(time, PorT, text, source)
    local player, distance = ESX.Game.GetClosestPlayer()
    local playerC = ESX.Game.GetClosestPlayer()
    local playerCords = GetEntityCoords(playerC, 1)
    local timer = time
    local PutorTake = PorT

    Citizen.CreateThread(function ()
        while timer > 0 do
            Citizen.Wait(0)
            timer = timer - 1
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function ()
        while timer > 0 do
            Citizen.Wait(0)
            if distance ~= -1 and distance <= 3.0 then
                if PutorTake == "put" then
                    Draw3DText(playerCords.x, playerCords.y, playerCords.z - 0.0, "Is being put into the crusier")
                elseif PutorTake == "take" then
                    Draw3DText(playerCords.x, playerCords.y, playerCords.z - 0.0, "Is being taken out of the crusier")
                end
            end
        end
    end)
end)
]]

RegisterNetEvent('startT')
AddEventHandler('startT', function(ello, we, rem, source)
    local timer = ello
    local weapon = we
    local remove = rem
    local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
    local mePlayer = GetPlayerFromServerId(source)
    local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
    local coords = GetEntityCoords(PlayerPedId(), false)


    if weapon == "weapon_carbinerifle" then
        weapon = "AR-15"
    end
    if weapon == "weapon_pumpshotgun" then
        weapon = "Remington 870"
    end

    Citizen.CreateThread(function ()
        while timer > 0 do
            Citizen.Wait(0)
            timer = timer - 1
            Citizen.Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while timer > 0 do
            Citizen.Wait(0)
            if remove ~= true then
                Draw3DText(coordsMe['x'], coordsMe['y'], coordsMe['z'] - 0.0, "Is grabbing their " .. weapon .. " out of their squad car")
            elseif remove == true then
                Draw3DText(coordsMe['x'], coordsMe['y'], coordsMe['z'] - 0.0, "Is putting their " .. weapon .. " into their squad car")
            end
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlPressed(0, 46) and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
            InFocusMode = true
        elseif IsControlReleased(0, 46) and not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
            InFocusMode = false
        end
	end
end)


RegisterNetEvent('getGun')
AddEventHandler('getGun', function(weap)
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
    local vehicle = getVehicleInDirection(coordA, coordB)
    local DSDFposTemp = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_dside_f"))
    local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
    local distanceToDSDFTemp = GetDistanceBetweenCoords(DSDFposTemp, playerpos, 1)
    local timer = 0
    local weapon = weap

    if weapon == "weapon_carbinerifle" and GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_carbinerifle") then
        timer = 5
        TriggerEvent('animation')
        TriggerServerEvent('Test', timer, weapon, true)
        Citizen.Wait(2500)
        RemoveWeaponFromPed(GetPlayerPed(-1), 0x83BF0278)
        InFocusMode = false
        elseif weapon == "weapon_pumpshotgun" and GetSelectedPedWeapon(GetPlayerPed(-1)) == GetHashKey("weapon_pumpshotgun") then
            timer = 5
            TriggerEvent('animation')
            TriggerServerEvent('Test', timer, weapon, true)
            Citizen.Wait(2500)
            RemoveWeaponFromPed(GetPlayerPed(-1), 0x1D073A89)
            InFocusMode = false
        elseif weapon == "weapon_pumpshotgun" and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("weapon_pumpshotgun") then
            timer = 5
            TriggerEvent('animation')
            TriggerServerEvent('Test', timer, weapon, false)
            Citizen.Wait(2500)
            GiveWeaponToPed(GetPlayerPed(-1), weapon, 200, false, true)
            InFocusMode = false
        elseif weapon == "weapon_carbinerifle" and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= GetHashKey("weapon_carbinerifle") then
            timer = 5
            TriggerEvent('animation')
            TriggerServerEvent('Test', timer, weapon, false)
            Citizen.Wait(2500)
            GiveWeaponToPed(GetPlayerPed(-1), weapon, 200, false, true)
            InFocusMode = false
    end
end)

RegisterNetEvent('animation')
AddEventHandler('animation', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    Wait(3000)
    StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    if InFocusMode == true then
        local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
        local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
        local vehicle = getVehicleInDirection(coordA, coordB)
        if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
            local trunkpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
            local Hoodpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "bonnet"))
            local DSDFpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "handle_dside_f"))
            local DSDRpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "handle_dside_r"))
            local PSDFpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "handle_pside_f"))
            local PSDRpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "handle_pside_r"))
            local transPos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "transmission_f"))
            local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
            local distanceToTrunk = GetDistanceBetweenCoords(trunkpos, playerpos, 1)
            local distanceToHood = GetDistanceBetweenCoords(Hoodpos, playerpos, 1)
            local distanceToDSDF = GetDistanceBetweenCoords(DSDFpos, playerpos, 1)
            local distanceToDSDR = GetDistanceBetweenCoords(DSDRpos, playerpos, 1)
            local distanceToPSDF = GetDistanceBetweenCoords(PSDFpos, playerpos, 1)
            local distanceToPSDR = GetDistanceBetweenCoords(PSDRpos, playerpos, 1)
            local distanceTotrans = GetDistanceBetweenCoords(transPos, playerpos, 1)

            if distanceToTrunk <= 1.9 then
                Draw3DText(trunkpos.x, trunkpos.y, trunkpos.z - 0.3, "PRESS TO")
                    if IsControlJustPressed(0, 25) then
                        OpenMenu()
                    end
            elseif distanceToHood <= 1.75 then
                    Draw3DText(Hoodpos.x, Hoodpos.y, Hoodpos.z - 0.0, "PRESS TO")
                    if IsControlJustPressed(0, 25) then
                        OpenMenu()
                    end
            elseif distanceToDSDF <= 1.1 then
                if GetVehicleDoorAngleRatio(vehicle, 0) <= 0.1 then
                    Draw3DText(DSDFpos.x, DSDFpos.y, DSDFpos.z - 0.0, "PRESS TO")
                    if IsControlJustPressed(0, 25) then
                        OpenMenu()
                    end
                elseif GetVehicleDoorAngleRatio(vehicle, 0) >= 0.1 then
                    Draw3DText(transPos.x, transPos.y, transPos.z - 0.0, "Grab gun")
                    if IsControlJustPressed(0, 25) then
                        OpenMenu()
                    end
                end
            elseif distanceToDSDR <= 1.1 then
                    Draw3DText(DSDRpos.x, DSDRpos.y, DSDRpos.z - 0.0, "PRESS TO")
                    if IsControlJustPressed(0, 25) then
                        OpenMenu()
                    end
            elseif distanceToPSDF <= 1.1 then
                    Draw3DText(PSDFpos.x, PSDFpos.y, PSDFpos.z - 0.0, "PRESS TO")
                    if IsControlJustPressed(0, 25) then
                        OpenMenu()
                    end
            elseif distanceToPSDR <= 1.1 then
                    Draw3DText(PSDRpos.x, PSDRpos.y, PSDRpos.z - 0.0, "PRESS TO")
                    if IsControlJustPressed(0, 25) then
                        OpenMenu()
                    end
                end
            end
        end
    end
end)

function getVehicleDoor()
    local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
    local vehicle = getVehicleInDirection(coordA, coordB)
    local CurrentDoor = "nil"
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        local trunkpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
        local Hoodpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "bonnet"))
        local DSDFpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "handle_dside_f"))
        local DSDRpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "handle_dside_r"))
        local PSDFpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "handle_pside_f"))
        local PSDRpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "handle_pside_r"))
        local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
        local distanceToVehicle = GetDistanceBetweenCoords(vehicle, playerpos, 1)
        local distanceToTrunk = GetDistanceBetweenCoords(trunkpos, playerpos, 1)
        local distanceToHood = GetDistanceBetweenCoords(Hoodpos, playerpos, 1)
        local distanceToDSDF = GetDistanceBetweenCoords(DSDFpos, playerpos, 1)
        local distanceToDSDR = GetDistanceBetweenCoords(DSDRpos, playerpos, 1)
        local distanceToPSDF = GetDistanceBetweenCoords(PSDFpos, playerpos, 1)
        local distanceToPSDR = GetDistanceBetweenCoords(PSDRpos, playerpos, 1)

            if distanceToTrunk <= 1.9 then
                CurrentDoor = "Trunk"
                openAndCloseDoor(vehicle, CurrentDoor)
            elseif distanceToHood <= 1.75 then
                CurrentDoor = "Hood"
                openAndCloseDoor(vehicle, CurrentDoor)
            elseif distanceToDSDF <= 1.1 then
                CurrentDoor = "driverSideFront"
                openAndCloseDoor(vehicle, CurrentDoor)
            elseif distanceToDSDR <= 1.1 then
                CurrentDoor = "driverSideRear"
                openAndCloseDoor(vehicle, CurrentDoor)
            elseif distanceToPSDF <= 1.1 then
                CurrentDoor = "passangerSideFront"
                openAndCloseDoor(vehicle, CurrentDoor)
            elseif distanceToPSDR <= 1.1 then
                CurrentDoor = "passangerSideRear"
                openAndCloseDoor(vehicle, CurrentDoor)
            else
                CurrentDoor = "nil"
                Timer = false
        end
    end
end

function openAndCloseDoor(va, dw)
    local vehicle = va
    local door = dw
    if door == "Trunk" then
        if GetVehicleDoorAngleRatio(vehicle, 5) <= 0.1 then
            SetVehicleDoorOpen(vehicle, 5, false, false)
        elseif GetVehicleDoorAngleRatio(vehicle, 5) >= 0.1 then
            SetVehicleDoorShut(vehicle, 5, false)
        end
    elseif door == "Hood" then
        if GetVehicleDoorAngleRatio(vehicle, 4) <= 0.1 then
            SetVehicleDoorOpen(vehicle, 4, false, false)
        elseif GetVehicleDoorAngleRatio(vehicle, 4) >= 0.1 then
            SetVehicleDoorShut(vehicle, 4, false)
        end
    elseif door == "driverSideFront" then
        if GetVehicleDoorAngleRatio(vehicle, 0) <= 0.1 then
            SetVehicleDoorOpen(vehicle, 0, false, false)
        elseif GetVehicleDoorAngleRatio(vehicle, 0) >= 0.1 then
            SetVehicleDoorShut(vehicle, 0, false)
        end
    elseif door == "driverSideRear" then
        if GetVehicleDoorAngleRatio(vehicle, 2) <= 0.1 then
            SetVehicleDoorOpen(vehicle, 2, false, false)
        elseif GetVehicleDoorAngleRatio(vehicle, 2) >= 0.1 then
            SetVehicleDoorShut(vehicle, 2, false)
        end
    elseif door == "passangerSideFront" then
        if GetVehicleDoorAngleRatio(vehicle, 1) <= 0.1 then
            SetVehicleDoorOpen(vehicle, 1, false, false)
        elseif GetVehicleDoorAngleRatio(vehicle, 1) >= 0.1 then
            SetVehicleDoorShut(vehicle, 1, false)
        end
    elseif door == "passangerSideRear" then
        if GetVehicleDoorAngleRatio(vehicle, 3) <= 0.1 then
            SetVehicleDoorOpen(vehicle, 3, false, false)
        elseif GetVehicleDoorAngleRatio(vehicle, 3) >= 0.1 then
            SetVehicleDoorShut(vehicle, 3, false)
        end
    end
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0150, 0.040+ factor, 0.03, 1, 1, 1, 150)
end

function chatPrint( msg )
	TriggerEvent( 'chatMessage', "TridentGaming: ", { 255, 255, 255 }, msg )
end 
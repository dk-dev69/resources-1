---https://forum.fivem.net/t/release-vrp-gruppe6robbing-gruppe6-armored-truck-robbing/290234

ESX = nil
local PlayerData		= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
   end
   
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
end)
-----------------------------------[[[SETTINGS]]]-------------------------------------
--------------------------------------------------------------------------------------
---------------[SPAWN TIMER]---------------------
local spawnTimer = math.random(1200,1600)
-------------------------------------------------

---------------[DESPAWN TIMER]-------------------
local despawnTimer = math.random(12000000,16000000)
-------------------------------------------------

local carf_hash = GetHashKey('stockade')
local security = GetHashKey("s_m_m_security_01")
local security_cars_hash = GetHashKey('cognoscenti2')

---------------------------------------[TEXTS]----------------------------------------
local spawnNotif = {
contact = "Осведомитель",
title = "~r~Грязная работа.",
msg = "Машина инкассаторов замечена в городе."
}

local rewardnotif = {"Вы получили ~g~"," ~w~$."}
local onMapBlipName_truck = "Инкассаторская машина"
local onMapBlipName_money = "Сумка с деньгами"
local destroyedTruckNotif = "~r~Деньги были уничтожены."
local moneyPickup =  "~y~Вы подобрали деньги."
local failNotif = "~y~Добыча с ограбления фургона не была подобрана быстро!~g~(3min)"
local cops_notification = "Ограбление инкассаторской машины ~y~"
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------

--------------------------------[Variables]-------------------------------------------
local truckBlip = false
local moneyBlip = false
local spawn = false
local money = false
local check = false
local near = false
local notif = false
local door = false
local fail = false
---------------------------------------------------------------------------------------
--------------------------------[functions]--------------------------------------------
function Notification(text)
SetNotificationTextEntry("STRING")
AddTextComponentString(text)
DrawNotification(false, false)
end

function IconNotif(sprite,style,contact,title,text)
SetNotificationTextEntry("STRING")
AddTextComponentString(text)
SetNotificationMessage(sprite,sprite,true,style,contact,title, text)
DrawNotification(false, true)
end

function despawn()
if fail then
   Notification(failNotif)
   Wait(180000)
   fail = false
   DeleteObject(thisBag)
   DeleteEntity(thisTruck)
end
truckBlip = false
moneyBlip = false
door = false
SetEntityAsNoLongerNeeded(thisTruck)
SetModelAsNoLongerNeeded(0x6827CF72)
T_toNet = nil
Wait(120000)
SetEntityAsNoLongerNeeded(driver)
SetModelAsNoLongerNeeded(0xCDEF5408)
SetEntityAsNoLongerNeeded(passenger)
SetModelAsNoLongerNeeded(0x63858A4A)

near = false
notif = false
end

local blips = {}

function addBlip(name,entity,sprite,color,text)
name = AddBlipForEntity(entity)
SetBlipSprite(name,sprite)
SetBlipColour(name,color)
SetBlipScale(name, 0.9)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString(text)
EndTextCommandSetBlipName(name)

SetBlipFlashes(name, true)
SetBlipFlashInterval(name, 4550)

return name
end

function blipName(name,entity,sprite,color,text)
blips.name = addBlip(name,entity,sprite,color,text)
return blips
end

function removeblip(name)
if blips.name ~= nil then
   RemoveBlip(blips.name)
   blips.name = nil
end
end

function modelRequest(model)
 RequestModel(model)
 while not HasModelLoaded(model) do
 Wait(1)
 end
end

function start_reset()
 spawn = true
 money = false
end
-------------------------------------------------------------------------------------
-----------------------------------[Table]-------------------------------------------
local positions = {--spawn position
{x=241.11,y=-1018.93,z=29.23,h=335.10},
{x=-387.61,y=-376.46,z=31.76,h=81.07},
{x=-984.17,y=-831.63,z=15.49,h=237.51},
{x=543.39,y=249.37,z=103.10,h=249.54},
{x=258.84,y=-1697.63,z=29.11,h=317.59},
{x=-1624.92,y=-428.73,z=39.65,h=320.0},
{x=-295.99,y=-204.59,z=33.18,h=38.22},
{x=807.14,y=-1231.17,z=26.33,h=353.39},
{x=1033.68,y=-216.52,z=70.13,h=242.71},
{x=-905.01,y=-1797.69,z=36.99,h=146.61},
{x=1189.49,y=-1898.83,z=34.62,h=14.53},
{x=1168.30,y=-991.09,z=70.13,h=6.04},
{x= 266.79,y= -570.0,z= 43.31,h=340.78},
{x= 277.58,y= -553.66,z= 43.31,h=342.44},
{x= -1728.26,y= 43.02,z= 67.29,h=35.35},
{x= -434.33,y= -1552.94,z= 38.74,h=156.67},
{x= 456.93,y= -2101.35,z= 21.94,h=319.39},
{x= -1106.95,y= 261.65,z= 63.70,h=264.80},
{x= -229.12,y= -612.21,z= 33.18,h=341.27},
{x=-1193.14,y=-849.12,z=14.11,h=127.46},
{x=-74.69,y= 52.77,z=71.90,h=45.60},
{x=-508.51,y= 260.90,z=83.02,h=78.01},
{x=-255.95,y=-777.38,z=32.53,h=337.59}

}
---------------------------------------------------------------------------------------


Citizen.CreateThread(function()
 while true do
 Wait(0)
  if  NetworkIsHost() then
    Wait(spawnTimer)
      start_reset()
    Wait(despawnTimer)
      despawn()
  end
 end
end)

function setupModelo(modelo)
   RequestModel(modelo)
   while not HasModelLoaded(modelo) do
     RequestModel(modelo)
     Wait(50)
   end
   SetModelAsNoLongerNeeded(modelo)
 end

function guardsinfo(inputPed)
   SetPedShootRate(inputPed,  700)
   AddArmourToPed(inputPed, GetPlayerMaxArmour(security_spw)- GetPedArmour(security_spw))
   SetPedAlertness(inputPed, 3)

   SetPedAccuracy(inputPed, 81)
   SetEntityHealth(inputPed,  200)
   SetPedFleeAttributes(inputPed, false, true)
   SetPedCombatAttributes(inputPed, 46, true)
   SetPedCombatAttributes(inputPed, 0, true)
   SetPedCombatAttributes(inputPed, 2, true)
   SetPedCombatAttributes(inputPed, 52, true)
   SetPedCombatAbility(inputPed,  2)
   SetPedCombatRange(inputPed, 2)
   SetPedPathAvoidFire(inputPed,  0)
   SetPedPathCanUseLadders(inputPed,1)
   SetPedPathCanDropFromHeight(inputPed, 1)
   SetPedPathPreferToAvoidWater(inputPed, 1)
   SetPedGeneratesDeadBodyEvents(inputPed, 1)
   GiveWeaponToPed(inputPed, GetHashKey("WEAPON_COMBATPISTOL"), 5000, false, true)
   GiveWeaponToPed(inputPed, GetHashKey("WEAPON_SMG"), 5000, false, true)
   SetPedRelationshipGroupHash(inputPed, GetHashKey("security_guard"))
 end

 function carsinfo(inputcarro)
   RequestCollisionForModel(inputcarro)
   N_0x06faacd625d80caa(inputcarro)
   SetVehicleDoorsLocked(inputcarro , 7)
   SetEntityAsNoLongerNeeded(inputcarro)
   SetVehicleOnGroundProperly(inputcarro)
 end

Citizen.CreateThread(function()
 AddRelationshipGroup("Ar_truck")--Создаем группу отношений
 SetRelationshipBetweenGroups(0,GetHashKey("Ar_truck"),0xA49E591C)--Устанавливаем дружеские отношения охраны и полиции
 SetRelationshipBetweenGroups(0,0xA49E591C,GetHashKey("Ar_truck"))

 SetRelationshipBetweenGroups(0,GetHashKey("security_guard"),0xA49E591C)--Устанавливаем дружеские отношения охраны и полиции
 SetRelationshipBetweenGroups(0,0xA49E591C,GetHashKey("security_guard"))

 SetRelationshipBetweenGroups(0,GetHashKey("security_guard"),GetHashKey("Ar_truck"))--Устанавливаем дружеские отношения охраны и полиции
 SetRelationshipBetweenGroups(0,GetHashKey("Ar_truck"),GetHashKey("security_guard"))

                 
--local xPlayer = PlayerPedId()
              

--if xPlayer.job.name ~= 'police' or xPlayer.job.name ~= 'fbi' then
--SetRelationshipBetweenGroups(5,GetHashKey("Ar_truck"),GetHashKey('PLAYER'))--Устанавливаем отношения между игроком и охраной
--SetRelationshipBetweenGroups(5,GetHashKey('PLAYER'),GetHashKey("Ar_truck"))
--end

  while true do
   Wait(0)
   local player = GetPlayerPed(-1)
   if spawn then
       ClearPedTasks(ped)
       modelRequest(0x6827CF72)
       modelRequest(0x63858A4A)
       modelRequest(0xCDEF5408)
       modelRequest(0xE6401328)--модель машины охраны
       local pos = positions[math.random(1, #positions)]
       Armored_truck = CreateVehicle(0x6827CF72, pos.x,pos.y,pos.z,pos.h, true, true) -- "stockade" респаун инкассаторской машины
       Wait(3000)
       cars_spw = CreateVehicle(0xE6401328, pos.x,pos.y,pos.z,pos.h, true, true)--респаун машины первая охраны
       Wait(3000)
       cars_spw_2 = CreateVehicle(0xE6401328, pos.x,pos.y,pos.z,pos.h, true, true)--респаун вторая машина охраны

       SetVehicleOnGroundProperly(Armored_truck)--правильная позиция на земле
       SetVehicleOnGroundProperly(cars_spw)--правильная позиция на земле
       SetVehicleOnGroundProperly(cars_spw_2)--правильная позиция на земле

       Citizen.InvokeNative(0x06FAACD625D80CAA, Armored_truck)
       local driver = CreatePed(4, 0xCDEF5408,pos.x,pos.y,pos.z,pos.h, true, true)--создаем педа
       local passenger = CreatePed(4, 0x63858A4A,pos.x,pos.y,pos.z,pos.h, true, true)--создаем педа пассажира
       SetPedIntoVehicle(driver,Armored_truck, -1)--садим за руль педа
       SetPedIntoVehicle(passenger,Armored_truck, -2)--садим пассажира
       TaskVehicleDriveWander(driver,Armored_truck,35.0, 786603)--отправляем машинку гулять рандомно
      ---------------------------------------------------------
      SetPedAlertness(passenger, 3)
      SetPedAccuracy(passenger, 81)
      SetEntityHealth(passenger,  200)
      
     SetPedCombatAttributes(passenger, 46, true)
     SetPedCombatAttributes(passenger, 0, true)
     SetPedCombatAttributes(passenger, 2, true)
     SetPedCombatAttributes(passenger, 52, true)
     SetPedCombatAbility(passenger,  2)
     SetPedCombatRange(passenger, 2)
     SetPedPathAvoidFire(passenger,  0)
     SetPedPathCanUseLadders(passenger,1)
     SetPedPathCanDropFromHeight(passenger, 1)
     SetPedPathPreferToAvoidWater(passenger, 1)
     SetPedGeneratesDeadBodyEvents(passenger, 1)
      ---------------------------------------------------------
       SetPedRelationshipGroupHash(driver,GetHashKey("Ar_truck"))
       SetPedRelationshipGroupHash(passenger,GetHashKey("Ar_truck"))
       SetDriverAbility(driver, 10.0)
       SetPedFleeAttributes(driver, 0, 1)
       SetPedFleeAttributes(passenger, 0, 1)
       GiveWeaponToPed(driver, GetHashKey("WEAPON_SMG"),-1,0,1)
       GiveWeaponToPed(passenger, GetHashKey("WEAPON_SMG"),-1,0,1)
       ----------------------------------------------------------------------------------------------------
         
      carsinfo(Armored_truck)
      --carsinfo(carf_spw)
      carsinfo(cars_spw)
      carsinfo(cars_spw_2)
      setupModelo(security)

      --security_spw = CreatePedInsideVehicle(carf_spw, 4, security, -1, true, false)
      --security_spw_2 = CreatePedInsideVehicle(carf_spw, 4, security, 0, true, false)
      security_spw_3 = CreatePedInsideVehicle(cars_spw, 4, security, -1, true, false)
      security_spw_4 = CreatePedInsideVehicle(cars_spw, 4, security, 0, true, false)
      security_spw_5 = CreatePedInsideVehicle(cars_spw, 4, security, 1, true, false)
      security_spw_6 = CreatePedInsideVehicle(cars_spw, 4, security, 2, true, false)
      security_spw_7 = CreatePedInsideVehicle(cars_spw_2, 4, security, -1, true, false)
      security_spw_8 = CreatePedInsideVehicle(cars_spw_2, 4, security, 0, true, false)
      security_spw_9 = CreatePedInsideVehicle(cars_spw_2, 4, security, 1, true, false)
      security_spw_10 = CreatePedInsideVehicle(cars_spw_2, 4, security, 2, true, false)
      
    --SetEntityAsMissionEntity(security_spw, 0, 0) 
    --SetEntityAsMissionEntity(security_spw_2, 0, 0)
    SetEntityAsMissionEntity(security_spw_3, 0, 0) 
    SetEntityAsMissionEntity(security_spw_4, 0, 0) 
    SetEntityAsMissionEntity(security_spw_5, 0, 0)
    SetEntityAsMissionEntity(security_spw_6, 0, 0)
    SetEntityAsMissionEntity(security_spw_7, 0, 0)
    SetEntityAsMissionEntity(security_spw_8, 0, 0)
    SetEntityAsMissionEntity(security_spw_9, 0, 0)
    SetEntityAsMissionEntity(security_spw_10, 0, 0)

    --guardsinfo(security_spw)
    --guardsinfo(security_spw_2)
    guardsinfo(security_spw_3)
    guardsinfo(security_spw_4)
    guardsinfo(security_spw_5)
    guardsinfo(security_spw_6)
    guardsinfo(security_spw_7)
    guardsinfo(security_spw_8)
    guardsinfo(security_spw_9)
    guardsinfo(security_spw_10)
    ----------------------------------------------------
   --[[1 = Red
   2 = Green
   3 = Orange
    = Blue
   5 = Light Blue
   6 = Purple
   7 = White ]]  

      
      blip_carf = AddBlipForEntity(cars_spw)--Закрепляем BLIP к машине (сущности)
      SetBlipColour(blip_carf, 2)
      --SetBlipRoute(blip_carf, true)
      --SetBlipRouteColour(blip_carf, 5)
      --PulseBlip(blip_carf)
      SetBlipSprite(blip_carf , 161)
      SetBlipScale(blip_carf , 1.0)
      --SetBlipColour(blip_carf, 8)
      --SetBlipFlashes(blip_carf, true)
      --SetBlipFlashInterval(blip_carf, 4550)
      --RemoveBlip(blip_carf)


      --[[drivingStyle:
      0 = Rushed
      1 = Ignore Traffic Lights
      2 = Fast
      3 = Normal (Stop in Traffic)
      4 = Fast avoid traffic
      5 = Fast, stops in traffic but overtakes sometimes
      6 = Fast avoids traffic extremely]]
      --ESX.ShowNotification(cars_spw)
      --ESX.ShowNotification(Armored_truck)
      --TaskVehicleFollow(cars_spw, Armored_truck, 3, 45, 10)--следовать
      --TaskVehicleEscort(ped, vehicle, targetVehicle, mode, speed, drivingStyle, minDistance, p7, noRoadsDistance) 
      TaskVehicleEscort(security_spw_3, cars_spw, Armored_truck, 3, 100.0, 1, 5.0, 0, 20.0)--сопровождать
      TaskVehicleEscort(security_spw_7, cars_spw_2, Armored_truck, 3, 100.0, 1, 5.0, 0, 20.0)

       --local ped = NetworkGetEntityFromNetworkId(security_spw_3)
       --local vehicle = NetworkGetEntityFromNetworkId(Armored_truck)

				--local playerPos = GetEntityCoords(GetPlayerPed(-1))
				--TaskVehicleDriveToCoordLongrange(ped, vehicle, playerPos.x, playerPos.y, playerPos.z, 25.0, 2883621, 10.0)
				--SetPedKeepTask(ped, true)
				--SetEntityAsMissionEntity(ped, true, true)

       ----------------------------------------------------------------------------------------------------
       Wait(200)
       TruckID = VehToNet(Armored_truck)
       --TruckID2 = VehToNet(cars_spw)
       --TruckID3 = VehToNet(ars_spw_2)
       Citizen.InvokeNative(0xE05E81A888FA63C8,TruckID,1)
       --Citizen.InvokeNative(0xE05E81A888FA63C8,TruckID2,1)
       --Citizen.InvokeNative(0xE05E81A888FA63C8,TruckID3,1)
       Wait(250)
       TriggerServerEvent('truckID',TruckID)
       --TriggerServerEvent('truckID',TruckID2)
       --TriggerServerEvent('truckID',TruckID3)

       spawn = false

   end

   ------------------------Доработка--------------------------------------------------------
   local EngineHealth = GetVehicleEngineHealth(Armored_truck)--ПРОЦЕНТ ЗДОРОВЬЯ У ДВИГАТЕЛЯ
   local BodyHealth = GetVehicleBodyHealth(Armored_truck)--ПРОЦЕНТ ЗДОРОВЬЯ КОРПУСА
   --ESX.ShowNotification(BodyHealth..'+'..EngineHealth)

   if EngineHealth <= 0 or BodyHealth <= 0 then
      ESX.ShowNotification("Деньги ~r~уничтожены~w~ с машиной")
      RemoveBlip(blip)
      Wait(3000)
      DeleteEntity(Armored_truck)--удаляем уничтоженную машину, сущность
      --TaskVehicleFollowWaypointRecording(ped, vehicle, WPRecording, p3, p4, p5, p6, p7, p8, p9)
      --ClearPedTasksImmediately(security_spw_3)--очистить задачу немедленно
      --TaskLeaveVehicle(security_spw_3, cars_spw,4160)-- покинуть машину
      --DeleteEntity(cars_spw)
      --DeleteEntity(cars_spw_2)
      --TaskVehicleChase(security_spw_3, GetVehiclePedIsIn(PlayerPedId(), lastVehicle))
      --TaskVehicleEscort(security_spw_3, cars_spw, Armored_truck, 3, 40.0, 3, 5.0, 0, 20.0)--сопровождать
      --TaskVehicleDriveToCoordLongrange(security_spw, carf_spw, 1847.96, 2608.26, 45.59, 16.0, 447, 1)
      --TaskVehicleDriveToCoordLongrange(ped, vehicle, x, y, z, speed, driveMode, stopRange)
      TaskVehicleDriveToCoordLongrange(security_spw_3, cars_spw, 1847.96, 2608.26, 45.59, 100.0, 447, 1)
      TaskVehicleDriveToCoordLongrange(security_spw_7, cars_spw_2, 1847.96, 2608.26, 45.59, 100.0, 447, 1)
       despawn()
   end

      
      local PedsCoords = GetEntityCoords(cars_spw)
      local PedsCoords2 = GetEntityCoords(cars_spw_2)
      local distance = GetDistanceBetweenCoords(PedsCoords.x, PedsCoords.y, PedsCoords.z, 1855.37, 2606.95, 45.07, true)
      local distance2 = GetDistanceBetweenCoords(PedsCoords.x, PedsCoords.y, PedsCoords.z, 1855.37, 2606.95, 45.07, true)

      if distance < 5.0 then --удаляем если машинку если в зоне
         DeleteEntity(cars_spw)--удаляем машину
         DeleteEntity(security_spw_3)--удаляем охрану
         DeleteEntity(security_spw_4)
         DeleteEntity(security_spw_5)
         DeleteEntity(security_spw_6)
         despawn()
      end

      if distance2 < 5.0 then --удаляем если машинку если в зоне
         DeleteEntity(cars_spw_2)
         DeleteEntity(security_spw_7)
         DeleteEntity(security_spw_8)
         DeleteEntity(security_spw_9)
         DeleteEntity(security_spw_10)
         despawn()
      end


   if NetworkDoesNetworkIdExist(T_toNet) then
      if not truckBlip then
         thisTruck = NetToVeh(T_toNet)
         Wait(200)
         blipName(Ar_truck_blip,thisTruck,67,2,onMapBlipName_truck)
         IconNotif("CHAR_HUMANDEFAULT",4,spawnNotif.contact,spawnNotif.title,spawnNotif.msg)
         check = true
         truckBlip = true
      end

      local pickupos = GetOffsetFromEntityInWorldCoords(thisTruck,0.0,-4.5,0.0)
      local obj = GetEntityCoords(thisBag)

        if GetVehicleDoorAngleRatio(thisTruck,2) >= 0.0100 and GetVehicleDoorAngleRatio(thisTruck,3) >= 0.0100 and (not door) then
            local robPos = GetEntityCoords(thisTruck)
            local zone = GetNameOfZone(robPos.x,robPos.y,robPos.z)
            --ESX.ShowNotification('Выпало бабло')
            TriggerServerEvent('Cops',robPos.x,robPos.y,robPos.z,zone)
            TaskCombatPed(driver,player,0,16)
            TaskCombatPed(passenger,player,0,16)
            RemoveBlip(Ar_truck)
            

            if not money then
              if GetPlayerWantedLevel(PlayerId()) <= 4 then
                 SetPlayerWantedLevel(PlayerId(), 4, 0)
                 SetPlayerWantedLevelNow(PlayerId(), 0)
              end

              if NetworkIsHost() then
                 modelRequest(GetHashKey("prop_money_bag_01"))
                 money_bag = CreateObject (GetHashKey("prop_money_bag_01"),pickupos.x, pickupos.y, pickupos.z ,true, true, true)
                 PlaceObjectOnGroundProperly(money_bag )
                 FreezeEntityPosition(money_bag ,1)
              end
              Wait(200)
              netBag = ObjToNet(money_bag)
              Wait(150)
              TriggerServerEvent('objID',netBag)
              money = true
            end
              door = true
        end

        if NetworkDoesNetworkIdExist(O_toNet) then
           if not moneyBlip then

              thisBag = NetToObj(O_toNet)
              Wait(200)
              blipName(money_bag_blip,thisBag,108,24,onMapBlipName_money)
              moneyBlip = true
              FreezeEntityPosition(thisBag,0)------------------------------------------------------------------------------------
           end
        end

        if DoesEntityExist(thisBag) then
           DrawMarker(0, obj.x, obj.y, obj.z+1.5, 0.0, 0.0,0.0, 0.0, 0.0,0.0, 0.5, 0.5, 0.45, 49,209, 50, 100, 1, 0, 2, 0, 0, 0, 0)
        end

        if IsEntityAtCoord(player,obj.x, obj.y, obj.z,0.50,0.50, 4.0, 0, 1, 0) and IsPedOnFoot(player) and DoesEntityExist(thisTruck) and DoesEntityExist(thisBag)then
           TriggerServerEvent('check:Pos')
           Wait(200)
           PlaySoundFrontend(-1,"PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
           Wait(100)
           DeleteObject(thisBag)
           check = false
           TriggerServerEvent('give_ok:give')
           RemoveBlip(Ar_truck)
           despawn()
        end

        if near and (not notif) then
           Notification(moneyPickup)
           notif = true
        end

        if DoesEntityExist(thisTruck) and GetEntityHealth(thisTruck) < 0 and check and (not near) then
           Notification(destroyedTruckNotif)
           if DoesEntityExist(thisBag) then
              DeleteObject(thisBag)
           end
           despawn()
           Wait(20000)
           RemoveBlip(Ar_truck)
        end

        if GetEntityHealth(player) < 1 then
           if DoesEntityExist(thisBag) then
            RemoveBlip(money_bag_blip)
              fail = true
              despawn()
           end
        end
   end
 end
end)

------------------------------------[Events]-------------------------------------------
RegisterNetEvent('sharedID')
AddEventHandler('sharedID', function(T_ID)
 T_toNet = T_ID
end)

RegisterNetEvent('sharedObj')
AddEventHandler('sharedObj', function(O_ID)
 O_toNet = O_ID
end)

RegisterNetEvent('sharedPos')
AddEventHandler('sharedPos', function(nearMoney)
  near = nearMoney
end)

RegisterNetEvent('rewardNotif')
AddEventHandler('rewardNotif', function(reward)
Notification(rewardnotif[1]..reward..rewardnotif[2])
end)

RegisterNetEvent("robbing:notif")
AddEventHandler("robbing:notif", function(robZone)
Notification(cops_notification..robZone)
end)
---------------------------------------------------------------------------------------

ESX = nil
local PlayerData              = {}

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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

-- id = 0 --compacts
-- id = 1 --sedans
-- id = 2 --SUV's
-- id = 3, --coupes
-- id = 4 --muscle
-- id = 5 --sport classic
-- id = 6 --sport
-- id = 7 --super
-- id = 8 --motorcycle
-- id = 9 --offroad
-- id = 10 -industrial
-- id = 11-utility
-- id = 12--vans
-- id = 13 --bicycles
-- id = 14 --boats
-- id = 15, --helicopter
-- id = 16 --plane
-- id = 17 --service
-- id = 18 --emergency
-- id = 19 --military

local time = 0
local messagetime = 10
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
					TriggerEvent("izone:isPlayerInZone", "PRISON", function(wanted)
						if (wanted) then
										
										local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
										local vehicleClass = GetVehicleClass(vehicle)
						
										if (PlayerData.job ~= nil and (PlayerData.job.name == 'militar' or PlayerData.job.name == 'fbi' or PlayerData.job.name == 'police')) then
										ESX.ShowNotification('Вам ~g~разрешено ~w~находится на территории тюрьмы')
										else
											if vehicleClass == 15 or vehicleClass == 16 or vehicleClass == 19 then
												--PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false)
												ESX.ShowNotification('Полеты над тюремной зоной ~r~запрещены')
												--ESX.ShowNotification('У вас ~r~10 ~w~секунд чтобы покинуть зону')
												--Citizen.Wait(10000)
												
												SetPlayerWantedLevel(PlayerId(), 5, false)
												SetPlayerWantedLevelNow(PlayerId(), false)
											end
										end
									
						end
					end)
	end
end)


-- Citizen.CreateThread(function()
-- 	while true do
-- 		Wait(1000)
		
--     end
-- end)

-- Citizen.CreateThread(function()
--     timer = 1 * 1000
--     time = 0
-- 	while true do
-- 		Wait(1000)
-- 		time = time + 1000
-- 	end
-- end)

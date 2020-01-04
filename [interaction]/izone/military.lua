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

Citizen.CreateThread(function()
    while true do
       Wait(1000)
		--Тригер если игрок в зоне, выполняем функцию
		TriggerEvent("izone:isPlayerInZone", "MilitaryBase1", function(wanted)
	    --начало петли
	   
		if (wanted) then
			if (PlayerData.job ~= nil and (PlayerData.job.name == 'militar' or PlayerData.job.name == 'fbi')) then
				--проверяем вы полняется ли функция
				SetPlayerWantedLevel(PlayerId(), 0, false)
				SetPlayerWantedLevelNow(PlayerId(), false)
				--ESX.ShowNotification(PlayerData.job.name)
				
				ESX.ShowNotification('У вас ~g~есть доступ ~s~к военной базе')
				Wait(2000)
			else
				SetPlayerWantedLevel(PlayerId(), 5, false)
				SetPlayerWantedLevelNow(PlayerId(), false)
				
				ESX.ShowNotification('У вас ~r~нет доступа ~s~к военной базе')
				Wait(2000)
				--ESX.ShowNotification(PlayerData.job.name)
            end
		end
		--завершение
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
       Wait(1000)
		--Тригер если игрок в зоне, выполняем функцию
		TriggerEvent("izone:isPlayerInZone", "MilitaryBase2", function(wanted2)
	    --начало петли
	   
		if (wanted2) then
			if (PlayerData.job ~= nil and (PlayerData.job.name == 'militar' or PlayerData.job.name == 'fbi')) then
				--проверяем вы полняется ли функция
				SetPlayerWantedLevel(PlayerId(), 0, false)
				SetPlayerWantedLevelNow(PlayerId(), false)
				--ESX.ShowNotification(PlayerData.job.name)
				
				ESX.ShowNotification('У вас ~g~есть доступ ~s~к военной базе')
				Wait(2000)
			else
				SetPlayerWantedLevel(PlayerId(), 5, false)
				SetPlayerWantedLevelNow(PlayerId(), false)
				
				ESX.ShowNotification('У вас ~r~нет доступа ~s~к военной базе')
				Wait(2000)
				--ESX.ShowNotification(PlayerData.job.name)
            end
		end
		--завершение
        end)
    end
end)



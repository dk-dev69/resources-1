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
       Wait(10000)
		--Тригер если игрок в зоне, выполняем функцию
		TriggerEvent("izone:isPlayerInZone", "CartelWeedPlant", function(wanted)
		
				if (wanted) then
				if (PlayerData.job ~= nil and (PlayerData.job.name == 'cartel' and PlayerData.job.grade == 3)) then
					
				--TriggerServerEvent('esx_phone:send', "cartel", 'На территории плантации замечены посторонние' , true, '')
				else
				SendSignalCartel()
				--TriggerServerEvent('esx_phone:send', "cartel", 'На территории плантации замечены посторонние' , true, '')
				ESX.ShowNotification('Вы находитесь на территории ~r~под контролем картеля~s~')
				
				end
		end
	    --начало петли
		--завершение
        end)
    end
end)

function SendSignalCartel()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

    TriggerServerEvent('esx_addons_gcphone:startCall', 'cartel', 'На территории плантации замечены посторонние', PlayerCoords, {

		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
end
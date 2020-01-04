ESX = nil
local PlayerData = {}

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

RegisterNetEvent('setWantedLevel')
AddEventHandler('setWantedLevel', function(level)
	SetPlayerWantedLevel(PlayerId(), level, false)
	SetPlayerWantedLevelNow(PlayerId(), false)
end)

Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
				--local PlayerId = PlayerId()
				--local playerPed = PlayerPedId()
				--local GetPlayerWantedLevel = GetPlayerWantedLevel(PlayerId())
			 
				-- if GetPlayerWantedLevel(PlayerId()) == 0 then
					-- SetPlayerWantedLevel(PlayerId(), 2, false)
					-- Citizen.Wait(1)
					-- SetPlayerWantedLevelNow(PlayerId(), false)
					-- SetPoliceIgnorePlayer(PlayerId(), true)--включаем не стрелять в игрока полицеским NPC
					-- SetDispatchCopsForPlayer(PlayerId(), true)--включаем не стрелять в игрока полицеским NPC
					-- ESX.ShowNotification('Включаем розыск '..PlayerData.job.name)
				-- end
				--if PlayerData.job ~= nil and PlayerData.job.name == 'fbi' or PlayerData.job.name == 'police' then
				if (PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'fbi')) then
				--if (PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'fbi' ) then
					--SetRelationshipBetweenGroups(2, GetHashKey("COP"), GetHashKey('PLAYER'))
				
					if GetPlayerWantedLevel(PlayerId()) ~= 0 then
						SetPlayerWantedLevel(PlayerId(), 0, false)
						SetPlayerWantedLevelNow(PlayerId(), false)
						SetPoliceIgnorePlayer(PlayerId(), true)--включаем не стрелять в игрока полицеским NPC
						SetDispatchCopsForPlayer(PlayerId(), true)--включаем не стрелять в игрока полицеским NPC	
						--ESX.ShowNotification('Розыск сброшен для '..PlayerData.job.name)
					end

				elseif (PlayerData.job ~= nil and (PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'fbi')) then
				        --SetRelationshipBetweenGroups(2, GetHashKey("COP"), GetHashKey('PLAYER'))
						
						SetPoliceIgnorePlayer(PlayerId(), true)--включаем не стрелять в игрока полицеским NPC
						SetDispatchCopsForPlayer(PlayerId(), true)--включаем не стрелять в игрока полицеским NPC
					
					if (GetPlayerWantedLevel(PlayerId()) >= 3) then
				
						SetPoliceIgnorePlayer(PlayerId(), false)
						SetDispatchCopsForPlayer(PlayerId(), false)
					
					elseif GetPlayerWantedLevel(PlayerId()) >= 4 then
				
					SetPlayerWantedLevel(PlayerId(), 3, false)
					SetPlayerWantedLevelNow(PlayerId(), false)
					SetPoliceIgnorePlayer(PlayerId(), false)--включаем не стрелять в игрока полицеским NPC
					SetDispatchCopsForPlayer(PlayerId(), false)--включаем не стрелять в игрока полицеским NPC
				end
				
				
				
			end
		end
end)

-- if PlayerData.job and PlayerData.job.name == 'police' then
		-- ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)
			-- for i=1, #players, 1 do
				-- if players[i].job.name == 'police' then
					-- local id = GetPlayerFromServerId(players[i].source)
					-- if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						-- createBlip(id)
					-- end
				-- end
			-- end
		-- end)
	-- end

-- Citizen.CreateThread(function()
    -- while true do
      -- Citizen.Wait(0)
		-- if (PlayerData.job ~= nil and PlayerData.job.name == 'police') then
		       -- -- ESX.ShowNotification(PlayerData.job.name)
				-- SetPoliceIgnorePlayer(PlayerId(), true)
				-- SetDispatchCopsForPlayer(PlayerId()), false)
				
				-- if GetPlayerWantedLevel(PlayerId()) ~= 0 then
					-- SetPlayerWantedLevel(PlayerId(), tonumber(0), false);
					-- SetPlayerWantedLevelNow(PlayerId(), false)
					 -- ESX.ShowNotification('Розыск для полиции '..PlayerData.job.name..'№'..PlayerId())
				-- end
        -- end
    -- end
-- end)
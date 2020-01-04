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

ESX 			    			= nil
local PlayerData 				= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

--local radioActive 				= false
--local radioButton				= 249 --- U by default  -- use 57 for f10
local voice = {default = 20.0, shout = 50.0, whisper = 2.0, current = 0, level = nil}
local voicecar = {incar = 5.0, nexttocar = 18.0, current = 0, level = nil}
local voicepolice = {incar = 5.0, nexttocar = 18.0, speaker = 200.0, current = 0, level = nil}

function drawLevel(r, g, b, a)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.5, 0.5)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	
	--Проверка игрока на посадку в транспорте + полицейском транспорте
	if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1) then
		AddTextComponentSubstringPlayerName('~y~Полицейский режим - Голос: ~s~' .. voicepolice.level)
	elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		AddTextComponentSubstringPlayerName('~y~В транспорте - Голос: ~s~' .. voicecar.level)
	else
		AddTextComponentSubstringPlayerName('~y~Голос: ~s~' .. voice.level)
	end
	EndTextCommandDisplayText(0.2, 0.867)
end

AddEventHandler('onClientMapStart', function()
	if voice.current == 0 then
		NetworkSetTalkerProximity(voice.default)
	elseif voice.current == 1 then
		NetworkSetTalkerProximity(voice.shout)
	elseif voice.current == 2 then
		NetworkSetTalkerProximity(voice.whisper)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(1, Keys['Y']) then
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1) then
				if voicepolice.current == 0 then
					--DrawMarker(28,pos.x,pos.y,pos.z - 0.8, 0, 0, 0, 0, 0, 0, voicepolice.incar, voicepolice.incar, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
					DrawMarker(25,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicepolice.incar, voicepolice.incar, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
				elseif voicepolice.current == 1 then
					DrawMarker(25,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicepolice.nexttocar, voicepolice.nexttocar, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
				elseif voicepolice.current == 2 then
					DrawMarker(25,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicepolice.speaker, voicepolice.speaker, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
				end
			elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				if voicecar.current == 0 then
					DrawMarker(25,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicecar.incar, voicecar.incar, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
				elseif voicecar.current == 1 then
					DrawMarker(25,pos.x,pos.y,pos.z - 0.5, 0, 0, 0, 0, 0, 0, voicecar.nexttocar, voicecar.nexttocar, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
				end
			else
				if voice.current == 1 then
					DrawMarker(25,pos.x,pos.y,pos.z - 0.95, 0, 0, 0, 0, 0, 0, voice.shout, voice.shout, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
				elseif voice.current == 2 then
					DrawMarker(25,pos.x,pos.y,pos.z - 0.95, 0, 0, 0, 0, 0, 0, voice.whisper, voice.whisper, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
				elseif voice.current == 0 then
					DrawMarker(25,pos.x,pos.y,pos.z - 0.95, 0, 0, 0, 0, 0, 0, voice.default, voice.default, 0.5, 55, 160, 205, 105, 0, true, 2, 0, 0, 0, 0)
				end
			end	
		end
	end
end)


--- Function for radio chatter function
-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(0)
		-- -- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		-- if (IsControlJustPressed(0, radioButton)) and (PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'fbi') then
			-- --if (IsControlJustPressed(0, radioButton))  then
			-- local ped = PlayerPedId()
			-- --TriggerEvent('chatMessage', 'TESTING ANIMATION')
			-- if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
				-- radioActive = true
				-- if radioActive then
					-- RequestAnimDict( "random@arrests" )
	
					-- while ( not HasAnimDictLoaded( "random@arrests" ) ) do 
						-- Citizen.Wait( 100 )
					-- end
	
					-- if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
						-- ClearPedSecondaryTask(ped)
					-- else
						-- TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
						-- local prop_name = prop_name
						-- local secondaryprop_name = secondaryprop_name
						-- DetachEntity(prop, 1, 1)
						-- DeleteObject(prop)
						-- DetachEntity(secondaryprop, 1, 1)
						-- DeleteObject(secondaryprop)
						-- --SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
					-- end
				-- end
			-- end
		-- end
	-- end
-- end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
			if IsControlJustPressed(1, Keys['Y']) and IsControlPressed(1, Keys['LEFTSHIFT']) then
				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1)), -1) == GetPlayerPed(-1) then
					voicepolice.current = (voicepolice.current + 1) % 3
					if voicepolice.current == 0 then
						NetworkSetTalkerProximity(voicepolice.incar)
						voicepolice.level = 'В транспорте'
					elseif voicepolice.current == 1 then
						NetworkSetTalkerProximity(voicepolice.nexttocar)
						voicepolice.level = 'Вокруг транспорта'
					elseif voicepolice.current == 2 then
						NetworkSetTalkerProximity(voicepolice.speaker)
						voicepolice.level = 'Громкоговоритель'
					end	
					
				elseif IsPedInAnyVehicle(GetPlayerPed(-1), false) then
					voicecar.current = (voicecar.current + 1) % 2
					if voicecar.current == 0 then
						NetworkSetTalkerProximity(voicecar.incar)
						voicecar.level = 'В транспорте'
					elseif voicecar.current == 1 then
						NetworkSetTalkerProximity(voicecar.nexttocar)
						voicecar.level ='Вокруг транспорта'
					end	
					
				else
					voice.current = (voice.current + 1) % 3
					if voice.current == 0 then
						NetworkSetTalkerProximity(voice.default)
						voice.level = 'Нормально'
					elseif voice.current == 1 then
						NetworkSetTalkerProximity(voice.shout)
						voice.level = 'Громко'
					elseif voice.current == 2 then
						NetworkSetTalkerProximity(voice.whisper)
						voice.level = 'Тихо'
					end	
					
				end
			end

		if voice.current == 0 then
			voice.level = 'Нормально'
		elseif voice.current == 1 then
			voice.level = 'Громко'
		elseif voice.current == 2 then
			voice.level = 'Тихо'
		end
		
		if voicecar.current == 0 then
			voicecar.level = 'В транспорте'
		elseif voicecar.current == 1 then
			voicecar.level = 'Вокруг транспорта'
		end	
		
		if voicepolice.current == 0 then
			voicepolice.level = 'В транспорте'
		elseif voicepolice.current == 1 then
			voicepolice.level = 'Вокруг транспорта'
		elseif voicepolice.current == 2 then
			voicepolice.level = 'Громкоговоритель'
		end	
		
		if NetworkIsPlayerTalking(PlayerId()) then
			drawLevel(41, 128, 185, 255)
		elseif not NetworkIsPlayerTalking(PlayerId()) then
			drawLevel(185, 185, 185, 255)
		end
	end
end)



Citizen.CreateThread(function()
    RequestAnimDict('facials@gen_male@variations@normal')
    RequestAnimDict('mp_facial')

    local talkingPlayers = {}
    while true do
        Citizen.Wait(100)
		
        local myId = PlayerId()

        for _,player in ipairs(GetActivePlayers()) do
            local boolTalking = NetworkIsPlayerTalking(player)

            if player ~= myId then
                if boolTalking and not talkingPlayers[player] then
                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
                    talkingPlayers[player] = true
                elseif not boolTalking and talkingPlayers[player] then
                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
                    talkingPlayers[player] = nil
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)

		-- show blips
		for id = 0, 256 do
			if NetworkIsPlayerActive( id ) then -- and GetPlayerPed( id ) ~= GetPlayerPed( -1 )

				ped = GetPlayerPed( id )
				--blip = GetBlipFromEntity( ped )

				-- HEAD DISPLAY STUFF --

				-- Create head display (this is safe to be spammed)
				if GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
					headDisplayId = N_0xbfefe3321a3f5015(ped, ".", false, false, "", false )
				end

				if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(GetPlayerPed(id))) < 30.0001) and HasEntityClearLosToEntity(GetPlayerPed(-1),  GetPlayerPed(id),  17) then
					N_0x63bb75abedc1f6a0(headDisplayId, 12, true)
					N_0xd48fe545cd46f857(headDisplayId, 12, 255)
				else
					N_0x63bb75abedc1f6a0(headDisplayId, 0, false)
				end

				if NetworkIsPlayerTalking(id) then
					N_0x63bb75abedc1f6a0(headDisplayId, 12, true) -- Speaker
					N_0xd48fe545cd46f857(headDisplayId, 12, 128) -- Alpha
				else
					N_0x63bb75abedc1f6a0(headDisplayId, 12, false) -- Speaker Off
				end
			end
		end
	end
end)

--[[Citizen.CreateThread(function()
	while true do
		Wait(1)
		-- show blips
		for id = 0, 256 do
			if NetworkIsPlayerActive( id ) then -- and GetPlayerPed( id ) ~= GetPlayerPed( -1 )

				ped = GetPlayerPed( id )
				--blip = GetBlipFromEntity( ped )

				-- HEAD DISPLAY STUFF --

				-- Create head display (this is safe to be spammed)
				if GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
						headDisplayId = N_0xbfefe3321a3f5015(ped, ".", false, false, "", false )
				else
					headDisplayId = N_0xbfefe3321a3f5015(ped, "", false, false, "", false )
				end

				if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(GetPlayerPed(id))) < 30.0001) and HasEntityClearLosToEntity(GetPlayerPed(-1),  GetPlayerPed(id),  17) then
					N_0x63bb75abedc1f6a0(headDisplayId, 12, true)
					N_0xd48fe545cd46f857(headDisplayId, 12, 255)
				else
					N_0x63bb75abedc1f6a0(headDisplayId, 0, false)
				end

				if NetworkIsPlayerTalking(id) then
					N_0x63bb75abedc1f6a0(headDisplayId, 12, true) -- Speaker
					N_0xd48fe545cd46f857(headDisplayId, 12, 128) -- Alpha
				else
					N_0x63bb75abedc1f6a0(headDisplayId, 12, false) -- Speaker Off
				end
			end
		end
	end
end)]]
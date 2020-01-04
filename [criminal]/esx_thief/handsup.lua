local Keys = {
	["ESC"] = 322, 		["F1"] = 288, 		["F2"] = 289, 		["F3"] = 170, 		["F5"] = 166, 
	["F6"] = 167, 		["F7"] = 168, 		["F8"] = 169, 		["F9"] = 56, 		["F10"] = 57,
	["~"] = 243, 		["1"] = 157, 		["2"] = 158, 		["3"] = 160, 		["4"] = 164, 
	["5"] = 165,		["6"] = 159, 		["7"] = 161, 		["8"] = 162, 		["9"] = 163, 
	["-"] = 84, 		["="] = 83, 		["TAB"] = 37,		["Q"] = 44, 		["W"] = 32, 
	["E"] = 38, 		["R"] = 45, 		["T"] = 245, 		["Y"] = 246, 		["U"] = 303, 
	["P"] = 199, 		["["] = 39, 		["]"] = 40, 		["ENTER"] = 18, 	["CAPS"] = 137, 
	["A"] = 34, 		["S"] = 8, 			["D"] = 9, 			["F"] = 23, 		["G"] = 47, 
	["H"] = 74, 		["K"] = 311, 		["L"] = 182, 		["LEFTSHIFT"] = 21, ["Z"] = 20, 
	["X"] = 73, 		["C"] = 26, 		["V"] = 0, 			["B"] = 29,			["N"] = 249, 
	["M"] = 244, 		[","] = 82, 		["."] = 81, 		["LEFTCTRL"] = 36, 	["LEFTALT"] = 19,
	["SPACE"] = 22,		["RIGHTCTRL"] = 70, ["HOME"] = 213, 	["PAGEUP"] = 10, 	["PAGEDOWN"] = 11,
	["DELETE"] = 178, 	["LEFT"] = 174,		["RIGHT"] = 175, 	["TOP"] = 27, 		["DOWN"] = 173, 
	["NENTER"] = 201, 	["N4"] = 108, 		["N5"] = 60, 		["N6"] = 107,		["BACKSPACE"] = 177,
	["N+"] = 96, 		["N-"] = 97, 		["N7"] = 117, 		["N8"] = 61, 		["N9"] = 118
}

local canHandsUp = true
handsup = false

-- AddEventHandler('handsup:toggle', function(param)
	-- canHandsUp = param
-- end)

function getSurrenderStatus()
	return handsup
end

RegisterNetEvent('esx_thief:getSurrenderStatusPlayer')
AddEventHandler('esx_thief:getSurrenderStatusPlayer',function(event,source)
		if handsup then
			TriggerServerEvent("esx_thief:reSendSurrenderStatus",event,source,true)
		else
			TriggerServerEvent("esx_thief:reSendSurrenderStatus",event,source,false)
		end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local lPed = GetPlayerPed(-1)
		local PlayerID = PlayerId()
		RequestAnimDict("random@mugging3")
		if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedCuffed(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			if IsControlPressed(0, Keys['X']) then
				if DoesEntityExist(lPed) then
					Citizen.CreateThread(function()
						RequestAnimDict("random@mugging3")
						while not HasAnimDictLoaded("random@mugging3") do
							Citizen.Wait(100)
						end
						if not handsup then
						
						if GetPlayerWantedLevel(PlayerId(-1)) ~= 0 then
							HaendeHoch()--отключаем кнопки
							SetPlayerWantedLevel(PlayerID, 1, false)
							SetPlayerWantedLevelNow(PlayerID, false)
							SetPoliceIgnorePlayer(PlayerID, true)--включаем не стрелять в игрока полицеским NPC
							SetDispatchCopsForPlayer(PlayerID, true)--включаем не стрелять в игрока полицеским NPC
							ESX.ShowNotification('~b~Полиция:~w~Вы в ~r~розыске ~w~мы предлагаем вам сдаться')
							ESX.ShowNotification('~b~Полиция:~w~Не ~r~опускайте руки~w~, ожидайте офицеров полиции')
						end

							handsup = true
							if (IsPedArmed(GetPlayerPed(-1), 7)) then
								ClearPedTasks(GetPlayerPed(-1))
								playAnim("weapons@first_person@aim_rng@generic@projectile@sticky_bomb@", "plant_floor")
								Citizen.Wait(1000)
								SetPedDropsInventoryWeapon(GetPlayerPed(-1), GetSelectedPedWeapon(GetPlayerPed(-1)), 0.0, 2.0, -0.9, -1)--Бросаем оружие и поднимаем без патронов / 2.0 это расстояние на которое будет отброшено оружие
								Citizen.Wait(500)
								PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1);
								--GiveWeaponToPed(ped, 0xA2719263, 0, 0, 1) --set unarmed
							ClearPedTasks(GetPlayerPed(-1))
							end
							SetCurrentPedWeapon(lPed, 0xA2719263, true)
							TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
						end   
					end)
				end
				
			end
		end
		if IsControlReleased(0, Keys['X']) then
			if DoesEntityExist(lPed) then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end

					if handsup then
						handsup = false
						ClearPedSecondaryTask(lPed)
						--если был розыск ужесточяем его
						if GetPlayerWantedLevel(PlayerId(-1)) ~= 0 then
							SetPlayerWantedLevel(PlayerID, 4, false)
							SetPlayerWantedLevelNow(PlayerID, false)
							SetPoliceIgnorePlayer(PlayerID, false)--включаем не стрелять в игрока полицеским NPC
							SetDispatchCopsForPlayer(PlayerID, false)--включаем не стрелять в игрока полицеским NPC
							ESX.ShowNotification('~b~Полиция:~w~~r~Мы вынуждены~w~, открыть ~r~огонь на поражение')
						end
					end
				end)
			end
		end
	end
end)

function HaendeHoch()
	Citizen.CreateThread(function()
		while handsup do
			Citizen.Wait(1)
			DisablePlayerFiring(lPed, true) -- Disable weapon firing
			DisableControlAction(0, 21, true) -- SHIFT
			DisableControlAction(0, 1, true) 				-- Disable pan
			DisableControlAction(0, 2, true) 				-- Disable tilt
			DisableControlAction(0, 24, true) 				-- Attack
			DisableControlAction(0, 257, true) 				-- Attack 2
			DisableControlAction(0, 25, true) 				-- Aim
			DisableControlAction(0, 263, true) 				-- Melee Attack 1

			DisableControlAction(0, Keys['R'], true) 		-- Reload
			DisableControlAction(0, Keys['SPACE'], true) 	-- Jump
			DisableControlAction(0, Keys['TAB'], true) 		-- Select Weapon
			DisableControlAction(0, Keys['F'], true) 		-- Also 'enter'?

			DisableControlAction(0, Keys['F2'], true) 		-- Inventory
			DisableControlAction(0, Keys['F3'], true) 		-- Animations
			DisableControlAction(0, Keys['F5'], true) 		-- Bag
			DisableControlAction(0, Keys['F6'], true) 		-- Job & Panicbutton
			DisableControlAction(0, Keys['F7'], true) 		-- Billing
			DisableControlAction(0, Keys['F9'], true) 		-- Job

			DisableControlAction(0, Keys['V'], true) 		-- Disable changing view
			DisableControlAction(0, Keys['C'], true) 		-- Disable looking behind
			DisableControlAction(2, Keys['P'], true)		-- Disable pause screen

			DisableControlAction(0, 59, true) 				-- Disable steering in vehicle
			DisableControlAction(0, 71, true) 				-- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) 				-- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  				-- Disable weapon
			DisableControlAction(0, 264, true) 				-- Disable melee
			DisableControlAction(0, 257, true) 				-- Disable melee
			DisableControlAction(0, 140, true) 				-- Disable melee
			DisableControlAction(0, 141, true) 				-- Disable melee
			DisableControlAction(0, 142, true) 				-- Disable melee
			DisableControlAction(0, 143, true) 				-- Disable melee
			DisableControlAction(0, 75, true)  				-- Disable exit vehicle
			DisableControlAction(27, 75, true) 				-- Disable exit vehicle
			
			DisableControlAction(0,32,true) -- move (w)
			DisableControlAction(0,34,true) -- move (a)
			DisableControlAction(0,33,true) -- move (s)
			DisableControlAction(0,35,true) -- move (d)

			DisableControlAction(0,269,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,271,true)
			
		end
	end)
end

function playAnim(dict, name)
    local ped = GetPlayerPed(-1)
    loadAnimDict(dict)
    TaskPlayAnim(ped, dict, name, 8.0, 1.0, -1, 2, 0, 0, 0, 0)
end


function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
    return true
end
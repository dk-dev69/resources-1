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
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
ESX = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_methcar:stop')
AddEventHandler('esx_methcar:stop', function()
	started = false
	DisplayHelpText("~r~Производство остановлено...")
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('esx_methcar:stopfreeze')
AddEventHandler('esx_methcar:stopfreeze', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('esx_methcar:notify')
AddEventHandler('esx_methcar:notify', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('esx_methcar:startprod')
AddEventHandler('esx_methcar:startprod', function()
	DisplayHelpText("~g~Запуск производства")
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Started Meth production')
	ESX.ShowNotification("~r~Производство началось...")	
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('esx_methcar:blowup')
AddEventHandler('esx_methcar:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('esx_methcar:smoke')
AddEventHandler('esx_methcar:smoke', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('esx_methcar:drugged')
AddEventHandler('esx_methcar:drugged', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(GetPlayerPed(-1))
		if IsPedInAnyVehicle(playerPed) then
			
			
			CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId())

			car = GetVehiclePedIsIn(playerPed, false)
			LastCar = GetVehiclePedIsUsing(playerPed)
	
			local model = GetEntityModel(CurrentVehicle)
			local modelName = GetDisplayNameFromVehicleModel(model)
			
			if modelName == 'JOURNEY' and car then
				
					if GetPedInVehicleSeat(car, -1) == playerPed then
						if started == false then
							if displayed == false then
								DisplayHelpText("Нажмите ~INPUT_THROW_GRENADE~ чтобы начать производство наркотиков")
								displayed = true
							end
						end
						if IsControlJustReleased(0, Keys['G']) then
							if pos.y >= 3500 then
								if IsVehicleSeatFree(CurrentVehicle, 3) then
									TriggerServerEvent('esx_methcar:start')	
									progress = 0
									pause = false
									selection = 0
									quality = 0
									
								else
									DisplayHelpText('~r~Фургон уже занят')
								end
							else
								ESX.ShowNotification('Вы слишком близко к городу, уезжайте подальше на север')
							end	
		
						end
					end
			end
			
		else

				
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end
		end
		
		if started == true then
			
			if progress < 96 then
				Citizen.Wait(6000)
				if not pause and IsPedInAnyVehicle(playerPed) then
					progress = progress +  1
					ESX.ShowNotification('~r~Этап производства: ~g~~h~' .. progress .. '%')
					Citizen.Wait(6000) 
				end

				--
				--   EVENT 1
				--
				if progress > 22 and progress < 24 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Труба пропана протекает, что ты делаешь?')	
						ESX.ShowNotification('~o~1. Исправить с помощью ленты')
						ESX.ShowNotification('~o~2. Ничего не предпринимать')
						ESX.ShowNotification('~o~3. Заменить')
						ESX.ShowNotification('~c~Выберите опцию, которую вы хотите сделать')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('~r~Лента остановила утечку')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~Баллон с пропаном взорвался, вы все испортили ...')
						TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						SetVehicleEngineHealth(CurrentVehicle, 0.0)
						quality = 0
						started = false
						displayed = false
						ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						print('Stopped making drugs')
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('~r~Отличная работа, труба давно износилась')
						pause = false
						quality = quality + 5
					end
				end
				--
				--   EVENT 5
				--
				if progress > 30 and progress < 32 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Вы пролили бутылку ацетона на землю, что будете делать?')	
						ESX.ShowNotification('~o~1. Открыть окна, чтобы избавиться от запаха')
						ESX.ShowNotification('~o~2. Ничего не предпринимать')
						ESX.ShowNotification('~o~3. Надеть маску с фильтром')
						ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('~r~Вы открыли окна, чтобы избавиться от запаха')
						quality = quality - 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~Вы немного отравились парами ацетона')
						pause = false
						TriggerEvent('esx_methcar:drugged')
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('~r~Это простой способ решить проблему..,')
						SetPedPropIndex(playerPed, 1, 26, 7, true)
						pause = false
					end
				end
				--
				--   EVENT 2
				--
				if progress > 38 and progress < 40 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Мет становится слишком твердым, что будете делать? ')	
						ESX.ShowNotification('~o~1. Поднять давление')
						ESX.ShowNotification('~o~2. Поднять температуру')
						ESX.ShowNotification('~o~3. Понизить давление')
						ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('~r~Вы подняли давление и пропан начал выходить, вы понизили его, и пока все в порядке')
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~Повышение температуры помогло...')
						quality = quality + 5
						pause = false
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('~r~Понижение давления только ухудшило ситуацию...')
						pause = false
						quality = quality -4
					end
				end
				--
				--   EVENT 8 - 3
				--
				if progress > 41 and progress < 43 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Вы налили слишком много ацетона, что будете делать?')	
						ESX.ShowNotification('~o~1. Ничего не делать')
						ESX.ShowNotification('~o~2. Убрать лишние с помощью шприца')
						ESX.ShowNotification('~o~3. Добавить больше лития, чтобы сбалансировать')
						ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('~r~Весь мет пропах ацетоном, покупатели будут недовольны')
						quality = quality - 3
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~Это отчасти сработало, но все равно слишком много')
						pause = false
						quality = quality - 1
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('~r~Вы успешно сбалансировали оба химических вещества')
						pause = false
						quality = quality + 3
					end
				end
				--
				--   EVENT 3
				--
				if progress > 46 and progress < 49 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Вы нашли немного натуральной краски, что будете делать?')
						ESX.ShowNotification('~o~1. Добавить в мет')
						ESX.ShowNotification('~o~2. Не добавлять')
						ESX.ShowNotification('~o~3. Выпить')
						ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('~r~Хорошая идея, люди любят яркие цвета')
						quality = quality + 4
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~Это может разрушить вкус мета')
						pause = false
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('~r~Вы почувствовали головокружение, но все живы')
						pause = false
					end
				end
				--
				--   EVENT 4
				--
				if progress > 55 and progress < 58 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Фильтр засорен, что будете делать?')	
						ESX.ShowNotification('~o~1. Очистите его с помощью сжатого воздуха')
						ESX.ShowNotification('~o~2. Заменить фильтр')
						ESX.ShowNotification('~o~3. Очистите его с помощью зубной щетки')
						ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('~r~Сжатый воздух разбрызгал жидкий мет')
						quality = quality - 2
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~Замена был, лучший вариант')
						pause = false
						quality = quality + 3
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('~r~Не много получше, но в целом все еще грязно.')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 5
				--
				-- if progress > 58 and progress < 60 then
					-- pause = true
					-- if selection == 0 then
						-- ESX.ShowNotification('~o~Вы пролили бутылку ацетона на землю, что вы делаете?')	
						-- ESX.ShowNotification('~o~1. Откройте окна, чтобы избавиться от запаха')
						-- ESX.ShowNotification('~o~2. Ничего не предпринимать')
						-- ESX.ShowNotification('~o~3. Put on a mask with airfilter')
						-- ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					-- end
					-- if selection == 1 then
						-- print("Slected 1")
						-- ESX.ShowNotification('~r~You opened the windows to get rid of the smell')
						-- quality = quality - 1
						-- pause = false
					-- end
					-- if selection == 2 then
						-- print("Slected 2")
						-- ESX.ShowNotification('~r~You got high from inhaling acetone too much')
						-- pause = false
						-- TriggerEvent('esx_methcar:drugged')
					-- end
					-- if selection == 3 then
						-- print("Slected 3")
						-- ESX.ShowNotification('~r~Thats an easy way to fix the issue.. I guess')
						-- SetPedPropIndex(playerPed, 1, 26, 7, true)
						-- pause = false
					-- end
				-- end
				--
				--   EVENT 1 - 6
				--
				-- if progress > 63 and progress < 65 then
					-- pause = true
					-- if selection == 0 then
						-- ESX.ShowNotification('~o~The propane pipe is leaking, what do you do?')	
						-- ESX.ShowNotification('~o~1. Исправить с помощью ленты')
						-- ESX.ShowNotification('~o~2. Ничего не предпринимать ')
						-- ESX.ShowNotification('~o~3. Заменить')
						-- ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					-- end
					-- if selection == 1 then
						-- print("Slected 1")
						-- ESX.ShowNotification('~r~The tape kinda stopped the leak')
						-- quality = quality - 3
						-- pause = false
					-- end
					-- if selection == 2 then
						-- print("Slected 2")
						-- ESX.ShowNotification('~r~The propane tank blew up, you messed up...')
						-- TriggerServerEvent('esx_methcar:blow', pos.x, pos.y, pos.z)
						-- SetVehicleEngineHealth(CurrentVehicle, 0.0)
						-- quality = 0
						-- started = false
						-- displayed = false
						-- ApplyDamageToPed(GetPlayerPed(-1), 10, false)
						-- print('Stopped making drugs')
					-- end
					-- if selection == 3 then
						-- print("Slected 3")
						-- ESX.ShowNotification('~r~Good job, the pipe wasnt in a good condition')
						-- pause = false
						-- quality = quality + 5
					-- end
				-- end
				--
				--   EVENT 4 - 7
				--
				-- if progress > 71 and progress < 73 then
					-- pause = true
					-- if selection == 0 then
						-- ESX.ShowNotification('~o~The filter is clogged, what do you do?')	
						-- ESX.ShowNotification('~o~1. Clean it using compressed air')
						-- ESX.ShowNotification('~o~2. Replace the filter')
						-- ESX.ShowNotification('~o~3. Clean it using a tooth brush')
						-- ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					-- end
					-- if selection == 1 then
						-- print("Slected 1")
						-- ESX.ShowNotification('~r~Compressed air sprayed the liquid meth all over you')
						-- quality = quality - 2
						-- pause = false
					-- end
					-- if selection == 2 then
						-- print("Slected 2")
						-- ESX.ShowNotification('~r~Replacing it was probably the best option')
						-- pause = false
						-- quality = quality + 3
					-- end
					-- if selection == 3 then
						-- print("Slected 3")
						-- ESX.ShowNotification('~r~This worked quite well but its still kinda dirty')
						-- pause = false
						-- quality = quality - 1
					-- end
				-- end
				--
				--   EVENT 8
				--
				-- if progress > 76 and progress < 78 then
					-- pause = true
					-- if selection == 0 then
						-- ESX.ShowNotification('~o~You accidentally pour too much acetone, what do you do?')	
						-- ESX.ShowNotification('~o~1. Do nothing')
						-- ESX.ShowNotification('~o~2. Try to sucking it out using syringe')
						-- ESX.ShowNotification('~o~3. Add more lithium to balance it out')
						-- ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					-- end
					-- if selection == 1 then
						-- print("Slected 1")
						-- ESX.ShowNotification('~r~The meth is not smelling like acetone a lot')
						-- quality = quality - 3
						-- pause = false
					-- end
					-- if selection == 2 then
						-- print("Slected 2")
						-- ESX.ShowNotification('~r~It kind of worked but its still too much')
						-- pause = false
						-- quality = quality - 1
					-- end
					-- if selection == 3 then
						-- print("Slected 3")
						-- ESX.ShowNotification('~r~You successfully balanced both chemicals out and its good again')
						-- pause = false
						-- quality = quality + 3
					-- end
				-- end
				--
				--   EVENT 9
				--
				if progress > 82 and progress < 84 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Тебе нужно в туалет, что будешь делать?')	
						ESX.ShowNotification('~o~1. Поссу в штаны')
						ESX.ShowNotification('~o~2. Выйду на улицу по быстрому')
						ESX.ShowNotification('~o~3. Поссу в бутылку')
						ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('~r~Отличный вариант, сначала работа, потом туалет')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~Пока вы были снаружи, чтото сломалось и вы потеряли процент продукции..')
						pause = false
						quality = quality - 2
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('~r~Бутылка упала со стола и разбилась, все провоняло мачой')
						pause = false
						quality = quality - 1
					end
				end
				--
				--   EVENT 10
				--
				if progress > 88 and progress < 90 then
					pause = true
					if selection == 0 then
						ESX.ShowNotification('~o~Вы сможете добавить кусочек стекла в амфетамин, для веса?')	
						ESX.ShowNotification('~o~1. Да!')
						ESX.ShowNotification('~o~2. Нет')
						ESX.ShowNotification('~o~3. Добавить мет в стекло, так еще больше будет')
						ESX.ShowNotification('~c~Выберите один из вариантов вашего действия')
					end
					if selection == 1 then
						print("Slected 1")
						ESX.ShowNotification('~r~Отлично, теперь у вас чуть больше мета')
						quality = quality + 1
						pause = false
					end
					if selection == 2 then
						print("Slected 2")
						ESX.ShowNotification('~r~Вы хороший производитель, ваш продукт высокого качества')
						pause = false
						quality = quality + 1
					end
					if selection == 3 then
						print("Slected 3")
						ESX.ShowNotification('~r~Слишком много стекла, товар потерял в качестве')
						pause = false
						quality = quality - 1
					end
				end
				
				
				
				
				
				
				
				if IsPedInAnyVehicle(playerPed) then
					TriggerServerEvent('esx_methcar:make', pos.x,pos.y,pos.z)
					if pause == false then
						selection = 0
						quality = quality + 1
						progress = progress +  math.random(1, 2)
						ESX.ShowNotification('~r~Этап производства: ~g~~h~' .. progress .. '%')
					end
				else
					TriggerEvent('esx_methcar:stop')
				end

			else
				TriggerEvent('esx_methcar:stop')
				progress = 100
				ESX.ShowNotification('~r~Этап производства: ~g~~h~' .. progress .. '%')
				ESX.ShowNotification('~g~~h~Производство завершено')
				TriggerServerEvent('esx_methcar:finish', quality)
				FreezeEntityPosition(LastCar, false)
			end	
			
		end
		
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
			else
				if started then
					started = false
					displayed = false
					TriggerEvent('esx_methcar:stop')
					print('Stopped making drugs')
					FreezeEntityPosition(LastCar,false)
				end		
			end
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsControlJustReleased(0, Keys['1']) then
				selection = 1
				ESX.ShowNotification('~g~Номер выбранного варианта 1')
			end
			if IsControlJustReleased(0, Keys['2']) then
				selection = 2
				ESX.ShowNotification('~g~Номер выбранного варианта 2')
			end
			if IsControlJustReleased(0, Keys['3']) then
				selection = 3
				ESX.ShowNotification('~g~Номер выбранного варианта 3')
			end
		end

	end
end)





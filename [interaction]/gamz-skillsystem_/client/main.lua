ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(20)
		
		ESX = exports["es_extended"]:getSharedObject()
	end

	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(5)
	end

	FetchSkills()

	while true do
		local seconds = Config.UpdateFrequency * 1000
		Citizen.Wait(seconds)

		for skill, value in pairs(Config.Skills) do
			UpdateSkill(skill, value["RemoveAmount"])
		end

		TriggerServerEvent("gamz-skillsystem:update", json.encode(Config.Skills))
	end
end)

--[[
0 Compacts
1 Sedans
2 SUVs
3 Coupes
4 Muscle
5 Sports
6 Sports
7 Super
8 Motorcycles
9 Off-Road
10 Industrial
11 Utility
12 Vans
13 Cycles
14 Boats
15 Helicopters
16 Planes
17 Service
18 Emergency
19 Military
20 Commercial
21 Trains
]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(25000)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsUsing(ped)

		if IsPedRunning(ped) then
			UpdateSkill("Выносливость", 0.3)
		elseif IsPedInMeleeCombat(ped) then
			UpdateSkill("Сила", 0.5)
		elseif IsPedSwimmingUnderWater(ped) then
			UpdateSkill("Объем легких", 0.5)
		elseif IsPedShooting(ped) then
			UpdateSkill("Стрельба", 0.5)
		elseif DoesEntityExist(vehicle) then--Если в самолете и скорость выше 30
				local speed = GetEntitySpeed(vehicle) * 3.6

				if GetVehicleClass(vehicle) == 15 or GetVehicleClass(vehicle) == 16 and speed >= 30 then
					local rotation = GetEntityRotation(vehicle)
					if IsControlPressed(0, 210) then
						if rotation.x >= 25.0 then
							UpdateSkill("Полет", 0.5)
						end
					end
				end
				if speed >= 80 then
					UpdateSkill("Driving", 0.2)
				end
		elseif DoesEntityExist(vehicle) then
			local speed = GetEntitySpeed(vehicle) * 3.6

			if GetVehicleClass(vehicle) == 8 or GetVehicleClass(vehicle) == 13 and speed >= 5 then
				local rotation = GetEntityRotation(vehicle)
				if IsControlPressed(0, 210) then
					if rotation.x >= 25.0 then
						UpdateSkill("Wheelie", 0.5)
					end
				end
			end
			if speed >= 80 then
				UpdateSkill("Driving", 0.2)
			end
		end
	end
end)
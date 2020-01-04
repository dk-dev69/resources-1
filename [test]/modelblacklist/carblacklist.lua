-- CONFIG --

-- Blacklisted vehicle models
carblacklist = {
	"deluxo",
	"ruiner2",
	"Oppressor2",
	"Oppressor",
	"blimp"
}


Citizen.CreateThread(function()
	while true do
		Wait(1)
		playerPed = GetPlayerPed(-1)
		if playerPed then 
			checkCar(GetVehiclePedIsIn(playerPed, false))

			x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			for _, blacklistedCar in pairs(carblacklist) do
				checkCar(GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70))
			end
		end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
			sendForbiddenMessage("Транспортное средство в черном списке!")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end
----------------------------------------------------------------------------------------------
-- local blacklistedModels = {
	-- "deluxo",
	-- "ruiner2",
-- }

-- Citizen.CreateThread(function()
    -- while true do
        -- Citizen.Wait(0)
        -- local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        -- if DoesEntityExist(veh) and not IsEntityDead(veh) then
            -- local model = GetEntityModel(veh)
            -- -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
            -- if not IsThisModelBlacklisted(veh) and not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABike(model) and not IsThisModelABicycle(model) and IsEntityInAir(veh) then
                -- DisableControlAction(0, 59) -- leaning left/right
                -- DisableControlAction(0, 60) -- leaning up/down
            -- end
        -- end
    -- end
-- end)

-- function IsThisModelBlacklisted(veh)
	-- local model = GetEntityModel(veh)

	-- for i = 1, #blacklistedModels do
		-- if model == GetHashKey(blacklistedModels[i]) then
			-- return true
		-- end
	-- end
	-- return false
-- end
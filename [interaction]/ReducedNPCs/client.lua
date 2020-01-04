-- Density values from 0.0 to 1.0.
DensityMultiplier = 0.5
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
	end
end)

--Citizen.CreateThread(function()
--	while true do
--		Citizen.Wait(0)
--		local playerPed = GetPlayerPed(-1)
--		local playerLocalisation = GetEntityCoords(playerPed)
--			ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 700.0)
--	end
--end)
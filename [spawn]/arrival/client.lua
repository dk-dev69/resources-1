Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if startZone == nil then
		    if IsControlJustPressed(0, 38) then
				--DisplayHelpText("Вы нажали ~INPUT_CONTEXT~")
				startZone = "DESRT"
				planeDest = "AIRP"
				TriggerServerEvent('arrival:payTicket', 1599.02453, 3231.2016, 40.4115, 105.7817, planeDest, 0.0)
			end
		
		
			if IsEntityInAir(AirPlane) then
				SetVehicleLandingGear(AirPlane, 1)--шасси самолета
			end
				--Находится ли в зоне
				if IsEntityInZone(AirPlane, "RICHM") or IsEntityInZone(AirPlane, "OCEANA") then
					TaskPlaneLand(pilot, AirPlane, -1792.00122, -2882.29980, 13.9440+1.0001, -998.5266, -3341.3579, 13.9444+1.0001)--Целевая плоскость земли
					SetPedKeepTask(pilot, true)
					landing = true
				end
			
		end

		if not IsEntityInZone(PlayerPedId(), startZone) then
			if not IsEntityInAir(AirPlane) and IsPedInVehicle(PlayerPedId(), AirPlane, false) then
				TaskVehicleTempAction(pilot, Airplane, 27, -1)--https://wiki.rage.mp/index.php?title=Player::taskVehicleTempAction
				SetVehicleHandbrake(AirPlane, true)

				if GetEntitySpeed(AirPlaine) == 0.0 then
					if IsEntityInZone(PlayerPedId(), "AIRP") then
						Wait(500)
						DoScreenFadeOut(200)
						while not IsScreenFadedOut() do
							Citizen.Wait(0)
						end

						SetEntityCoords(PlayerPedId(), -1042.0395, -2740.7780, 20.1692)
						SetEntityHeading(PlayerPedId(), 340.2285)
						Wait(800)
						DoScreenFadeIn(500)
					else
						TaskLeaveVehicle(PlayerPedId(), AirPlane, 0)
					end
				end
			end

			if GetEntityHealth(AirPlane) <= 0 then
				startZone = nil
				planeDest = nil
				landing = false
			end

			if not IsPedInVehicle(PlayerPedId(), AirPlane, false) and landing == true then
				SetVehicleHandbrake(AirPlane, false)
				SetBlockingOfNonTemporaryEvents(pilot, false)
				
				SetEntityAsNoLongerNeeded(pilot)
				SetEntityAsNoLongerNeeded(AirPlane)

				startZone = nil
				planeDest = nil
				landing = false
			end
		end

	end
end)


function CreatePlane(x, y, z, heading, destination)
    DisplayHelpText("Функция CreatePlane")
	modelHash = GetHashKey(config.plane_model)
	pilotModel = GetHashKey("s_m_m_pilot_01")
	
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		Citizen.Wait(0)
	end

	RequestModel(pilotModel)
	while not HasModelLoaded(pilotModel) do
		Citizen.Wait(0)
	end

	if HasModelLoaded(modelHash) and HasModelLoaded(pilotModel) then
		ClearAreaOfEverything(x, y, z, 1500, false, false, false, false, false)

		AirPlane = CreateVehicle(modelHash, x, y, z-1.0, heading, true, false)
		SetVehicleOnGroundProperly(AirPlane)
		SetVehicleEngineOn(AirPlane, true, true, true)
		--SetEntityProofs(AirPlane, true, true, true, true, true, true, true, false)
		SetEntityProofs(AirPlane, false, false, false, false, false, false, false, false)--Включаем уязвимость самолета
		SetVehicleHasBeenOwnedByPlayer(AirPlane, true)

		pilot = CreatePedInsideVehicle(AirPlane, 6, pilotModel, -1, true, false)

		SetBlockingOfNonTemporaryEvents(pilot, true)

		local netVehid = NetworkGetNetworkIdFromEntity(AirPlane)
		SetNetworkIdCanMigrate(netVehid, true)
		NetworkRegisterEntityAsNetworked(VehToNet(AirPlane))

		local netPedid = NetworkGetNetworkIdFromEntity(pilot)
		SetNetworkIdCanMigrate(netPedid, true)
		NetworkRegisterEntityAsNetworked(pilot)

		totalSeats = GetVehicleModelNumberOfSeats(modelHash)
		TaskWarpPedIntoVehicle(PlayerPedId(), AirPlane, 2)

		SetModelAsNoLongerNeeded(modelHash)
		SetModelAsNoLongerNeeded(pilotModel)
	end

	
		TaskVehicleDriveToCoordLongrange(pilot, AirPlane, 1403.0020751953, 2995.9179, 40.5507, GetVehicleModelMaxSpeed(modelHash), 16777216, 0.0)
		Wait(5000)
		TaskPlaneMission(pilot, AirPlane, 0, 0, -1571.5589, -556.7288, 114.4482, 4, GetVehicleModelMaxSpeed(modelHash), 1.0, 0.0, 5.0, 40.0)
	
end

RegisterNetEvent("arrival:departure")
AddEventHandler("arrival:departure",  function(x, y, z, heading, planeDest)
	ClearAllHelpMessages()
	CreatePlane(x, y, z, heading, planeDest)
end)


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
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

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlPressed(0, Keys["LEFTSHIFT"]) and IsControlJustPressed(0, Keys["E"]) then
			Citizen.CreateThread(function()
				local entity = PlayerPedId()
				if IsPedInAnyVehicle(entity, false) then
					entity = GetVehiclePedIsUsing(entity)
				end
				local success = false
				local blipFound = false
				local blipIterator = GetBlipInfoIdIterator()
				local blip = GetFirstBlipInfoId(8)

				while DoesBlipExist(blip) do
					if GetBlipInfoIdType(blip) == 4 then
						cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
						blipFound = true
						break
					end
					blip = GetNextBlipInfoId(blipIterator)
				end

				if blipFound then
					--ShowLoadingPromt("Loading")
					showLoadingPromt("Загрузка...", 5000, 3)
					DoScreenFadeOut(250)
					while IsScreenFadedOut() do
						Citizen.Wait(250)
						
					end
					local groundFound = false
					local yaw = GetEntityHeading(entity)
					
					for i = 0, 1000, 1 do
						SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
						SetEntityRotation(entity, 0, 0, 0, 0 ,0)
						SetEntityHeading(entity, yaw)
						SetGameplayCamRelativeHeading(0)
						Citizen.Wait(0)
						--groundFound = true
						if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then --GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
							cz = ToFloat(i)
							groundFound = true
							break
						end
					end
					if not groundFound then
						cz = -300.0
					end
					success = true
				else
					DrawTimedSubtitle('~r~Blip not found', 1500)
				end

				if success then
					SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
					SetGameplayCamRelativeHeading(0)
					if IsPedSittingInAnyVehicle(PlayerPedId()) then
						if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
							SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
						end
					end
					--HideLoadingPromt()
					DoScreenFadeIn(250)
				end
			end)
		end
	end
end)

function showLoadingPromt(showText, showTime, showType)
	Citizen.CreateThread(function()
		Citizen.Wait(0)
		N_0xaba17d7ce615adbf("STRING") -- set type
		AddTextComponentString(showText) -- sets the text
		N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
		Citizen.Wait(showTime) -- show time
		N_0x10d373323e5b9c0d() -- remove promt
	end)
end
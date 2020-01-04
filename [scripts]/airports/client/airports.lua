StarPoints = {
	{x= -1030.8077, y= -2493.35766, z=20.16929, desc="Международный аэропорт Лос Сантос"},
	{x= 1752.15, y= 3290.56, z= 41.1109, desc="Аэропорт Сэнди Шорс"}
}

local function CreateAirportBlips()
	for k,v in pairs(StarPoints) do
		blip = AddBlipForCoord(v.x, v.y, v.z-1)
		SetBlipSprite(blip, 90)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("BLIP_90")
		EndTextCommandSetBlipName(blip)
	end
end

function IsPlayerNearAirport()
	for k,v in pairs(StarPoints) do
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.x, v.y, v.z, true) < 80.0 then
			if not IsPedInAnyPlane(PlayerPedId()) then
				if not _menuPool:IsAnyMenuOpen() then
					DrawMarker(1, v.x, v.y, v.z-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 255, 219, 77, 155, 0, 0, 2, 0, 0, 0, 0)
				end
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.x, v.y, v.z, true) < 2.0 then
			if not _menuPool:IsAnyMenuOpen() then
				if not IsHelpMessageBeingDisplayed() then
					BeginTextCommandDisplayHelp("STRING")
					AddTextComponentSubstringPlayerName(GetLabelText("MATC_DPADRIGHT"))
					EndTextCommandDisplayHelp(0, 0, 1, -1)
				end
			else
				ClearAllHelpMessages()
			end
			return true
		end
	end
end

Citizen.CreateThread(function()
	CreateAirportBlips()
end)
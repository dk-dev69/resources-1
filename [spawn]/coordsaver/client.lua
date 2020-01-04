function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end

RegisterNetEvent("SaveCommand")
AddEventHandler("SaveCommand", function()
	x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local PlayerName = GetPlayerName()
	Citizen.Trace(""..tD(x)..","..tD(y)..","..tD(z)..","..tD(GetEntityHeading(GetPlayerPed(-1))).."")
	TriggerServerEvent( "SaveCoords", PlayerName , tD(x) , tD(y) , tD(z), tD(GetEntityHeading(GetPlayerPed(-1))) )			
end)
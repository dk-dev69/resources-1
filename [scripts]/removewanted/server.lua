RegisterNetEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
	TriggerClientEvent('setWantedLevel', killerId, 1)
end)
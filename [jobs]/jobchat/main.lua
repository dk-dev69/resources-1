-- Made by Tazio

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/rp" then
		CancelEvent()
    xPlayer = ESX.GetPlayerFromId(source)
    str = xPlayer.job.name
    job = str:gsub("^%l", string.upper)
    TriggerClientEvent('chatMessage', -1, "^7[ ^4".. job .. " ^7] ( ^3" .. name .. " ^7)", { 255, 0, 0 }, string.sub(msg,4))
	end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

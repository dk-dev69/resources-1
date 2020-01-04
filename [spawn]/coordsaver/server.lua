
AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/pos" then
		CancelEvent()
		TriggerClientEvent("SaveCommand", source)
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

 RegisterServerEvent("SaveCoords")
 AddEventHandler("SaveCoords", function( PlayerName , x , y , z , h )
  file = io.open(PlayerName .. "-coords.txt", "a")
     if file then
        file:write("{x=" .. x .. ", y=" .. y .. ", z=" .. z .. ", h = " .. h .. "} \n")
		-- --{x = -243.87, y = -2446.51, z = 6.10, h = 147.21}
    end
    file:close()
end)


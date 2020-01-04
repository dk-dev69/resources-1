RegisterServerEvent("arrival:payTicket")
AddEventHandler("arrival:payTicket", function(x, y, z, heading, destination, price)
		local src = source
		
		if config.use_essentialmode then
			TriggerEvent("es:getPlayerFromId", tonumber(src), function(user)
			TriggerClientEvent("arrival:departure", tonumber(src), x, y, z, heading, destination)
			end)
		end
end)
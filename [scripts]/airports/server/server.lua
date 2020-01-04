if GetCurrentResourceName() == 'airports' then
	version = GetResourceMetadata(GetCurrentResourceName(), 'resource_version', 0)
	PerformHttpRequest("https://updates.fivem-scripts.org/verify/airports", function(err, rData, headers)
		if err == 404 then
			RconPrint("\n----------------------------------------------------")
			RconPrint("\nUPDATE ERROR: your version from FiveM Airports could not be verified.\n")
			RconPrint("If you keep receiving this error then please contact FiveM-Scripts.")
			RconPrint("\n----------------------------------------------------")
		else
			local vData = json.decode(rData)
			if vData then
				stableV = vData.version
				if vData.version < version or vData.version > version then
					RconPrint("\n----------------------------------------------------\n")
					RconPrint("You are running a outdated version of FiveM Airports.\nPlease update to the most recent version: " .. vData.version)
					RconPrint("\n----------------------------------------------------\n")
				end
			else
				RconPrint("\n----------------------------------------------------------------------")
				RconPrint("\nUPDATE ERROR: your version from FiveM Airports could not be verified.\n")
				RconPrint("If you keep receiving this error then please contact FiveM-Scripts.")
				RconPrint("\n----------------------------------------------------------------------\n")
			end
		end
	end)
end

RegisterServerEvent("airports:payTicket")
AddEventHandler("airports:payTicket", function(x, y, z, heading, destination, price)
	local src = source

	if config.use_essentialmode then
		TriggerEvent("es:getPlayerFromId", tonumber(src), function(user)
			RconPrint('using Essentialmode')

			if user.getMoney() >= tonumber(price) then
				user.removeMoney(tonumber(price))
				TriggerClientEvent("airports:departure", tonumber(src), x, y, z, heading, destination)
			elseif user.getBank() >= tonumber(price) then
				user.removeBank(tonumber(price))
				TriggerClientEvent("airports:departure", tonumber(src), x, y, z, heading, destination)
			else
				TriggerClientEvent("airports:moneyInvalid", tonumber(src))
			end
		end)
	elseif config.use_venomous then
		TriggerEvent('vf_base:FindPlayer', src, function(user)
			if user.cash >= tonumber(price) then
				TriggerEvent('vf_base:ClearCash', src, tonumber(price))
				TriggerClientEvent("airports:departure", tonumber(src), x, y, z, heading, destination)
			else
				TriggerClientEvent("airports:moneyInvalid", tonumber(src))
			end
		end)			
	end		
end)
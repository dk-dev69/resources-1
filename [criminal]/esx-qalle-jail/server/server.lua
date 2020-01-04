ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("jail", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "fbi" then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]

		if GetPlayerName(jailPlayer) ~= nil then

			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)

				TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " отправлен в тюрьму на " .. jailTime .. " мин!")
				
				if args[3] ~= nil then
					GetRPName(jailPlayer, function(Firstname, Lastname)
						TriggerClientEvent('chat:addMessage', -1, { args = { "Судья",  Firstname .. " " .. Lastname .. " в настоящее время находится в тюрьме по причине: " .. args[3] }, color = { 249, 166, 0 } })
					end)
				end
			else
				TriggerClientEvent("esx:showNotification", src, "Неправильное время")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "Игрок с таким ID не в сети!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Нет доступа!")
	end
end)

RegisterCommand("unjail", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "fbi" then

		local jailPlayer = args[1]

		if GetPlayerName(jailPlayer) ~= nil then
			UnJail(jailPlayer)
		else
			TriggerClientEvent("esx:showNotification", src, "Игрок с таким ID не в сети!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "У вас нет доступа!")
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason)
	local src = source
	local targetSrc = tonumber(targetSrc)
        local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" or xPlayer["job"]["name"] == "fbi" then
	JailPlayer(targetSrc, jailTime)

	GetRPName(targetSrc, function(Firstname, Lastname)
		TriggerClientEvent('chat:addMessage', -1, { args = { "Судья",  Firstname .. " " .. Lastname .. " вы отправлены в тюрьму, причина: " .. jailReason }, color = { 249, 166, 0 } })
	end)

	TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " Отправлен в тюрьму на " .. jailTime .. " мин!")
        else
		return xPlayer.kick("😈 бан получишь!")
	end
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " освобожден от заключения")
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
 
	if xPlayer ~= nil then	
			
			if xPlayer.getInventoryItem('bread').count >= 0 and xPlayer.getInventoryItem('bread').count <= 14  then
				xPlayer.addInventoryItem('bread', math.random(1, 4))
				TriggerClientEvent("esx:showNotification", src, "Вы получили хлеб")
			else
				xPlayer.addMoney(math.random(5, 50))
				TriggerClientEvent("esx:showNotification", src, "У вас достаточно еды и воды, возьмите деньги.")
			end
			
			if xPlayer.getInventoryItem('water').count >= 0 and xPlayer.getInventoryItem('water').count <= 14  then
				   xPlayer.addInventoryItem('water', math.random(1, 4))
				   TriggerClientEvent("esx:showNotification", src, "Вы получили воду")
			else
				xPlayer.addMoney(math.random(5, 50))
				TriggerClientEvent("esx:showNotification", src, "У вас достаточно еды и воды, возьмите деньги.")
			end
			
	end
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jail:jailPlayer", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)
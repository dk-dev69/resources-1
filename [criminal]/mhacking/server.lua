ESX = nil
local payOut = math.random(5000, 100000)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- RegisterServerEvent('securityvans:recievemoney')
-- AddEventHandler('securityvans:recievemoney', function(payOut)
	-- local xPlayer = ESX.GetPlayerFromId(source)
	-- xPlayer.addAccountMoney('black_money', payOut)
	-- TriggerClientEvent('esx:showNotification', source, 'Vous avez reçu ' .. payOut)
-- end)


-- RegisterServerEvent('securityvans:recieveitem')
-- AddEventHandler('securityvans:recieveitem', function()
	-- print(source)
	-- local xPlayer = ESX.GetPlayerFromId(source)

	-- xPlayer.addInventoryItem('bigmoneybag', 1)

	-- TriggerClientEvent('esx:showNotification', source, "Vous avez pris un gros sac d'argent de la brinks")

-- end)

RegisterServerEvent('securityvans:getmoney')
AddEventHandler('securityvans:getmoney', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addAccountMoney('black_money', payOut)
	TriggerClientEvent('esx:showNotification', source, "Вы украли помеченные деньги в размере "..payOut.."$")
end)

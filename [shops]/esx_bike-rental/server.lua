ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- RegisterServerEvent("esx:bike:lowmoney")
-- AddEventHandler("esx:bike:lowmoney", function(money, bikename)
    -- local _source = source
	-- local xPlayer = ESX.GetPlayerFromId(_source)
	-- if xPlayer.getMoney() >= money then
	     -- xPlayer.removeMoney(money)
	-- else
	   -- TriggerClientEvent('esx:showNotification', _source, 'Увас ~r~недостаточно ~w~средств для аренды'..bikename)
	-- end
-- end)

ESX.RegisterServerCallback('esx_bike:lowmoney', function(source, cb, money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getMoney() >= money then
	     xPlayer.removeMoney(money)
		 cb(true)
	else
	   TriggerClientEvent('esx:showNotification', _source, 'Увас ~r~недостаточно ~w~средств')
	   cb(false)
	end
end)

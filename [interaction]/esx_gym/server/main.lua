ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_gym:hireBmx')
AddEventHandler('esx_gym:hireBmx', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 109) then
		xPlayer.removeMoney(109)
			
		notification("Вы взяли на прокат ~g~BMX")
	else
		notification("У вас ~r~достаточно денег")
	end	
end)

RegisterServerEvent('esx_gym:hireCruiser')
AddEventHandler('esx_gym:hireCruiser', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 130) then
		xPlayer.removeMoney(130)
			
		notification("Вы взяли на прокат ~g~CRUISER")
	else
		notification("У вас ~r~достаточно денег")
	end	
end)

RegisterServerEvent('esx_gym:hireFixter')
AddEventHandler('esx_gym:hireFixter', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 150) then
		xPlayer.removeMoney(150)
			
		notification("Вы взяли на прокат ~g~FIXTER")
	else
		notification("У вас ~r~достаточно денег")
	end	
end)

RegisterServerEvent('esx_gym:hireScorcher')
AddEventHandler('esx_gym:hireScorcher', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 200) then
		xPlayer.removeMoney(200)
			
		notification("Вы взяли на прокат ~g~SCORCHER")
	else
		notification("У вас ~r~достаточно денег")
	end	
end)

RegisterServerEvent('esx_gym:checkChip')
AddEventHandler('esx_gym:checkChip', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local oneQuantity = xPlayer.getInventoryItem('gym_membership').count
	
	if oneQuantity > 0 then
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	else
		TriggerClientEvent('esx_gym:falseMembership', source) -- false
	end
end)

ESX.RegisterUsableItem('gym_bandage', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('gym_bandage', 1)	
	
	TriggerClientEvent('esx_gym:useBandage', source)
end)

RegisterServerEvent('esx_gym:buyBandage')
AddEventHandler('esx_gym:buyBandage', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 50) then
		xPlayer.removeMoney(50)
		
		xPlayer.addInventoryItem('gym_bandage', 1)		
		notification("Вы купили ~g~повязку")
	else
		notification("Вам не хватает ~r~денег")
	end	
end)

RegisterServerEvent('esx_gym:buyMembership')
AddEventHandler('esx_gym:buyMembership', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 500) then
		xPlayer.removeMoney(500)
		
		xPlayer.addInventoryItem('gym_membership', 1)		
		notification("Вы купили ~g~членство в наш спортзал")
		
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	else
		notification("Вам не хватает ~r~денег")
	end	
end)


RegisterServerEvent('esx_gym:buyProteinshake')
AddEventHandler('esx_gym:buyProteinshake', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 40) then
		xPlayer.removeMoney(40)
		
		xPlayer.addInventoryItem('protein_shake', 1)
		
		notification("Вы купили ~g~протеиновый коктейль")
	else
		notification("Вам не хватает ~r~денег")
	end	
end)

ESX.RegisterUsableItem('protein_shake', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('protein_shake', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 390000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Вы выпили ~g~протеиновый коктейль')

end)

RegisterServerEvent('esx_gym:buyWater')
AddEventHandler('esx_gym:buyWater', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 15) then
		xPlayer.removeMoney(15)
		
		xPlayer.addInventoryItem('water', 1)
		
		notification("Вы купили ~g~воду")
	else
		notification("Вам не хватает ~r~денег")
	end		
end)

RegisterServerEvent('esx_gym:buySportlunch')
AddEventHandler('esx_gym:buySportlunch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 35) then
		xPlayer.removeMoney(35)
		
		xPlayer.addInventoryItem('sportlunch', 1)
		
		notification("Вы купили ~g~спортивный ланч")
	else
		notification("Вам не хватает ~r~денег")
	end		
end)

ESX.RegisterUsableItem('sportlunch', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sportlunch', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Вы съели ~g~спортивный ланч')

end)

RegisterServerEvent('esx_gym:buyPowerade')
AddEventHandler('esx_gym:buyPowerade', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 50) then
		xPlayer.removeMoney(50)
		
		xPlayer.addInventoryItem('powerade', 1)
		
		notification("Вы купили ~g~Энергетик Powerade")
	else
		notification("Вам не хватает ~r~денег")
	end		
end)

ESX.RegisterUsableItem('powerade', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('powerade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 700000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Вы выпили ~g~энергетик Powerade')
	exports["gamz-skillsystem"]:UpdateSkill("Сила", 0.2)

end)

-- FUNCTIONS IN THE FUTURE (COMING SOON...)

--RegisterServerEvent('esx_gym:trainArms')
--AddEventHandler('esx_gym:trainArms', function()
	
--end)

--RegisterServerEvent('esx_gym:trainChins')
--AddEventHandler('esx_gym:trainArms', function()
	
--end)

--RegisterServerEvent('esx_gym:trainPushups')
--AddEventHandler('esx_gym:trainPushups', function()
	
--end)

--RegisterServerEvent('esx_gym:trainYoga')
--AddEventHandler('esx_gym:trainYoga', function()
	
--end)

--RegisterServerEvent('esx_gym:trainSitups')
--AddEventHandler('esx_gym:trainSitups', function()
	
--end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end

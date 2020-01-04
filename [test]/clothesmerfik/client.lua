ESX = nil


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('smerfikubrania:koszulka')
AddEventHandler('smerfikubrania:koszulka', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:spodnie')
AddEventHandler('smerfikubrania:spodnie', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['pants_1'] = 21, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:buty')
AddEventHandler('smerfikubrania:buty', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:gozluk')
AddEventHandler('smerfikubrania:gozluk', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['glasses_1'] = 0, ['glasses_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:kask')
AddEventHandler('smerfikubrania:kask', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['helmet_1'] = -1, ['helmet_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:canta')
AddEventHandler('smerfikubrania:canta', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['bags_1'] = 0, ['bags_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:yelek')
AddEventHandler('smerfikubrania:yelek', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['bproof_1'] = 0, ['bproof_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:maske')
AddEventHandler('smerfikubrania:maske', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['mask_1'] = 0, ['mask_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

function OpenActionMenuInteraction(target)

	local elements = {}
	table.insert(elements, {label = ('Одеть одежду'), value = 'ubie'})
	table.insert(elements, {label = ('Снять очки'), value = 'gozluk'})
	table.insert(elements, {label = ('Снять головной убор'), value = 'kask'})
	table.insert(elements, {label = ('Снять маску'), value = 'maske'})
	table.insert(elements, {label = ('Снять рубашку'), value = 'tul'})
	table.insert(elements, {label = ('Снять штаны'), value = 'spo'})
	table.insert(elements, {label = ('Снять обувь'), value = 'but'})
	table.insert(elements, {label = ('Снять бронижелет'), value = 'yelek'})
	table.insert(elements, {label = ('Снять сумку'), value = 'canta'})
  		ESX.UI.Menu.CloseAll()	


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Kıyafet Menü'),
			align    = 'top-left',
			elements = elements
		},
    function(data, menu)



		
		if data.current.value == 'ubie' then			
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		end)
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'tul' then
		TriggerEvent('smerfikubrania:koszulka')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'gozluk' then
		TriggerEvent('smerfikubrania:gozluk')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'kask' then
		TriggerEvent('smerfikubrania:kask')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'maske' then
		TriggerEvent('smerfikubrania:maske')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'spo' then
		TriggerEvent('smerfikubrania:spodnie')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'but' then
		TriggerEvent('smerfikubrania:buty')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'yelek' then
		TriggerEvent('smerfikubrania:yelek')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'canta' then
		TriggerEvent('smerfikubrania:canta')
		ESX.UI.Menu.CloseAll()	
	  end
	end)


end
			
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustReleased(0, 57) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu') then
		OpenActionMenuInteraction()
    end
  end
end)


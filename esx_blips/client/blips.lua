-- / Связь с ESX / --
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--/ прорисовка блипов при загрузке Игрока /--
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
AddBlips()
end)
 
 --(https://wiki.rage.mp/index.php?title=Blips)
 
--------------  Блипы на основной карте --------------------

--/ Эти блипы видно на мини карте и на основной карте /--
local blips_all = {

-- Блип Для магазина масок(Пример)	
--{name="Магазин маски", color=2, id=362,  x = -1338.129, y = -1278.200, z = 3.872, scale =0.8},
{name="Спортзал", colour=7, id=311,  x = -1201.2257, y = -1568.8670, z = 4.6101, scale =0.8},
{name="FBI", colour=1, id=60,  x = 112.1, y = -749.3, z = 45.7, scale =0.8}
}
---------------------------------------------------------------------------------------->>

--------------------------------------------------
------------- Блипы на минекарте -----------------
--<<---------------------------------------------- 
--/ Эти блипы видно только на мини карте /--
local blips = {

-- аренда скутеров на спавне(Пример)
{title="", colour=71, id=512, x= -1012.69,y=-2689.48, z=13.97, scale =1.0},

  }
----------------------------------------------------------------------------------------------------->>
 
----------------------------------------------------
-- Функция прорисовки блипов на карте(мини-карте) --
--<<------------------------------------------------

function AddBlips()
	for _, all in pairs(blips_all) do
      all.blip = AddBlipForCoord(all.x, all.y, all.z)
      SetBlipSprite(all.blip, all.id)
      SetBlipColour(all.blip, all.color)
	  SetBlipScale(all.blip, all.scale)
      SetBlipAsShortRange(all.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(all.name)
      EndTextCommandSetBlipName(all.blip)
    end

	for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 5)
      SetBlipScale(info.blip, info.scale)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
		
end
------------------------------------------------------->>
--удаляет неиспользуемые машины
-- Citizen.CreateThread(function()
    -- while true do
        -- Citizen.Wait(1)
        -- car = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        
        -- if car then
            -- Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(car))
        -- end
    -- end
-- end)


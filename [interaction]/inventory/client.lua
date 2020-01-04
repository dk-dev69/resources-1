user_items = {}
-- CONFIG --

local playerdead = false -- Don't touch this !
local maxCapacity = 64 -- Max capacity
local OpenKey = 289 -- F2



-- INVENTORY CONFIG --



local WaterID = 1 -- Set this in your Data Base
local FoodID = 2 -- Set this in your Data Base



-- CODE --



RegisterNetEvent("item:reset")
RegisterNetEvent("item:getuser_items")
RegisterNetEvent("item:updateQuantity")
RegisterNetEvent("item:sell")
RegisterNetEvent("gui:getuser_items")
RegisterNetEvent("player:receiveItem")
RegisterNetEvent("player:looseItem")
RegisterNetEvent("player:sellItem")



AddEventHandler("playerSpawned", function()
    TriggerServerEvent("item:getuser_items")
    playerdead = false
end)



AddEventHandler("gui:getuser_items", function(THEuser_items)
    user_items = {}
    user_items = THEuser_items
end)



AddEventHandler("player:receiveItem", function(item, quantity)
    if (getPods() + quantity <= maxCapacity) then
        item = tonumber(item)
        if (user_items[item] == nil) then
            new(item, quantity)
        else
            add(item, quantity)
        end
    end
end)



AddEventHandler("player:looseItem", function(item, quantity)
    item = tonumber(item)
    if (user_items[item].quantity >= quantity) then
        delete(item, quantity)
    end
end)



AddEventHandler("player:sellItem", function(item, price)
    item = tonumber(item)
    if (user_items[item].quantity > 0) then
        sell(item, price)
    end
end)



function sell(itemId, price)
    local item = user_items[itemId]
    item.quantity = item.quantity - 1
    TriggerServerEvent("item:sell", itemId, item.quantity, price)
end



function delete(itemId, qty)
    local item = user_items[itemId]
    item.quantity = item.quantity - qty
    TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
end



function add(itemId, qty)
    local item = user_items[itemId]
    item.quantity = item.quantity + qty
    TriggerServerEvent("item:updateQuantity", item.quantity, itemId)
end



function giveMoney()
    local playerNear = getNearPlayer()
    if playerNear then
        DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tonumber(GetOnscreenKeyboardResult())
            if res > 0 then
                TriggerServerEvent("player:swapMoney", res, GetPlayerServerId(playerNear))
            end
        end
    end
end



function new(item, quantity)
    RegisterNetEvent("item:setItem")
    TriggerServerEvent("item:setItem", item, quantity)
    TriggerServerEvent("item:getuser_items")
end



function getQuantity(itemId)
    return user_items[tonumber(itemId)].quantity
end



AddEventHandler("player:getQuantity", function(item, call)
     call({count=getQuantity(item)})
end)



function getPods()
    local pods = 0
    for _, v in pairs(user_items) do
        pods = pods + v.quantity
    end
    return pods
end



function notFull()
    if (getPods() < maxCapacity) then return true end
end



function Main()
    Menu.SetupMenu("main", GetPlayerName(PlayerId()))
    Menu.Switch(nil, "main")

	Menu.addOption("main", function() if (Menu.Option("Inventory")) then InventoryMenu("Inventory", nil) end end)
end



function InventoryMenu()
	Menu.SetupMenu("inventorymenu", GetPlayerName(PlayerId()))
    Menu.Switch("main", "inventorymenu")

	for ind,value in pairs(user_items) do
	    SelectedItem = 0
		Menu.addOption("inventorymenu", function()
			if (Menu.Inventory(tostring(value.libelle), tostring(value.quantity))) then
				if (value.quantity > 0) then
					ItemMenu("Item Menu", nil)
					SelectedItem = ind
				end
			end
		end)
	end
end



function ItemMenu(itemId)
    Menu.SetupMenu("user_itemsmenu", GetPlayerName(PlayerId()))
    Menu.Switch("inventorymenu", "user_itemsmenu")

	Menu.addOption("user_itemsmenu", function() if (Menu.Option("Use")) then use(SelectedItem, 1) InventoryMenu("Inventory", nil) end end)
	Menu.addOption("user_itemsmenu", function() if (Menu.Option("Delete")) then
		DisplayOnscreenKeyboard(true, "", "", "", "", "", "", 30)
		while UpdateOnscreenKeyboard() == 0 do
		    Wait(0)
		end
		local quantityuser_items = GetOnscreenKeyboardResult()
		delete(SelectedItem, tonumber(quantityuser_items))
		InventoryMenu("Inventory", nil)
	end end)
end



function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end



function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end



function give(item)
    local player = getNearPlayer()
    if (player ~= nil) then
        DisplayOnscreenKeyboard(1, "Quantité", "", "", "", "", "", 2)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tonumber(GetOnscreenKeyboardResult())
            if (user_items[item].quantity - res >= 0) then
                TriggerServerEvent("player:giveItem", item, user_items[item].libelle, res, GetPlayerServerId(player))
            end
        end
    end
end



function use(itemId, qty)
    if itemId == FoodID then
	
        TriggerEvent("food:vdrink", 5) -- Change this with your drink script
		
    elseif itemId == WaterID then
	
        TriggerEvent("food:veat", 2) -- Change this with your food script
		
    end
    TriggerEvent('player:looseItem', itemId, qty)
end



function PlayerIsDead()
    if playerdead then
        return
    end
    TriggerServerEvent("item:reset")
end

function getPlayers()
    local playerList = {}
    for i = 0, 32 do
        local player = GetPlayerFromServerId(i)
        if NetworkIsPlayerActive(player) then
            table.insert(playerList, player)
        end
    end
    return playerList
end



function getNearPlayer()
    local players = getPlayers()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local pos2
    local distance
    local minDistance = 3
    local playerNear
    for _, player in pairs(players) do
        pos2 = GetEntityCoords(GetPlayerPed(player))
        distance = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"], pos2["x"], pos2["y"], pos2["z"], true)
        if (pos ~= pos2 and distance < minDistance) then
            playerNear = player
            minDistance = distance
        end
    end
    if (minDistance < 3) then
        return playerNear
    end
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, OpenKey) then
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            clothing_menu = not clothing_menu
            Main()
		end
        if clothing_menu then
			DisableControlAction(1, 22, true)
			DisableControlAction(1, 0, true)
			DisableControlAction(1, 27, true)
			DisableControlAction(1, 80, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 20, true)
			HideHelpTextThisFrame()
            Menu.DisplayCurMenu()
        end
    end
end)



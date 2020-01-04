RegisterServerEvent("item:getuser_items")
RegisterServerEvent("item:updateQuantity")
RegisterServerEvent("item:setItem")
RegisterServerEvent("item:reset")
RegisterServerEvent("item:sell")
RegisterServerEvent("player:giveItem")



local user_items = {}



AddEventHandler("item:getuser_items", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
	    user_items = {}
        local player = user.getIdentifier()
		local result = MySQL.Sync.fetchAll("SELECT * FROM user_inventorys JOIN user_items ON `user_inventorys`.`item_id` = `user_items`.`id` WHERE user_id=@username", {['@username'] = player})
		if (result) then
			for k,v in ipairs(result) do
			    t = { ["quantity"] = v.quantity, ["libelle"] = v.libelle }
                user_items[v.item_id] = t
			end
		end
		TriggerClientEvent("gui:getuser_items", source, user_items)
    end)
end)



AddEventHandler("item:setItem", function(item, quantity)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.getIdentifier()
        MySQL.Async.fetchAll("SELECT * FROM user_inventorys WHERE user_id = @username AND item_id = @item", {['@username'] = player, ['@item'] = item}, function(result)
            if(result[1] ~= nil) then
                MySQL.Async.execute("UPDATE user_inventorys SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @item", { ['@username'] = player, ['@item'] = item, ['@qty'] = quantity})
            else
                MySQL.Async.execute("INSERT INTO user_inventorys (`user_id`, `item_id`, `quantity`) VALUES (@player, @item, @qty)", { ['@player'] = player, ['@item'] = item, ['@qty'] = quantity })
            end
		end)
    end)
end)



AddEventHandler("item:updateQuantity", function(qty, id)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.getIdentifier()
		MySQL.Sync.execute("UPDATE user_inventorys SET quantity=@qty WHERE user_id=@username AND item_id=@id", {['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id)})
	end)
end)



AddEventHandler("item:reset", function()
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.getIdentifier()
	    MySQL.Sync.execute("UPDATE user_inventorys SET quantity=@qty WHERE user_id=@username", {['@username'] = player, ['@qty'] = 0})
	end)
end)



AddEventHandler("item:sell", function(id, qty, price)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.getIdentifier()
		MySQL.Sync.execute("UPDATE user_inventorys SET quantity=@qty WHERE user_id=@username AND item_id=@id", {['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id)})
        user.addMoney(tonumber(price))
    end)
end)



AddEventHandler("player:swapMoney", function(amount, target)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        if user.money - amount >= 0 then
            user.removeMoney(amount)
            TriggerEvent('es:getPlayerFromId', target, function(user) user.addMoney(amount) end)
        end
    end)
end)



AddEventHandler("player:giveItem", function(item, name, qty, target)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.getIdentifier()
		local total = MySQL.Sync.fetchScalar("SELECT SUM(quantity) as total FROM user_inventorys WHERE user_id=@username", { ['@username'] = player })
        if (total + qty <= 64) then
            TriggerClientEvent("player:looseItem", source, item, qty)
            TriggerClientEvent("player:receiveItem", target, item, qty)
		end
    end)
end)
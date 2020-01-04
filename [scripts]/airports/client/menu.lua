_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", "~s~Пункт назначения", "", "", "shopui_title_exec_vechupgrade", "shopui_title_exec_vechupgrade")
_menuPool:Add(mainMenu)

_menuPool:ControlDisablingEnabled(false)
_menuPool:MouseControlsEnabled(false)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

function AddAirPortMenu(menu)
	if config.use_essentialmode or config.use_venomous then
		SantonsButton = NativeUI.CreateItem("Международный аэропорт Лос Сантос", "Купить билет на "..config.moneyCurrency .." " ..config.ticketPrice)
		DesrtButton = NativeUI.CreateItem("Сэнди Шорс Аэродром", "Buy a ticket for "..config.moneyCurrency .." " ..config.ticketPrice)
	else
		SantonsButton = NativeUI.CreateItem("Международный аэропорт Лос Сантос", "")
		DesrtButton = NativeUI.CreateItem("Сэнди Шорс Аэродром", "")
	end

    menu:AddItem(SantonsButton)
    menu:AddItem(DesrtButton)
    menu.OnItemSelect = function(sender, item, index)
        if item == DesrtButton then
        	if not IsEntityInZone(PlayerPedId(), "DESRT") then
        		startZone = "AIRP"
        		planeDest = "DESRT"
        		if config.use_essentialmode or config.use_venomous then
        			TriggerServerEvent('airports:payTicket', -1675.2446, -2798.8835, 14.5409, 327.8560, planeDest, config.ticketPrice)
        		else
        			CreatePlane(-1675.2446, -2798.8835, 14.5409, 327.8560, planeDest)
        		end
        	else
        		ShowNotification("Ни один самолет ~y~не запланирован~w~ в это месте сейчас.")
        	end
        elseif item == SantonsButton then
        	if not IsEntityInZone(PlayerPedId(), "AIRP") then
        		startZone = "DESRT"
        		planeDest = "AIRP"
        		if config.use_essentialmode then
        			TriggerServerEvent('airports:payTicket', 1599.02453, 3231.2016, 40.4115, 105.7817, planeDest, config.ticketPrice)
        		else
        			CreatePlane(1599.02453, 3231.2016, 40.4115, 105.7817, planeDest)
        		end
        	else
        		ShowNotification("Ни один самолет ~y~не запланирован~w~ в это месте сейчас.")
        	end
        end
    end   
end

AddAirPortMenu(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		_menuPool:ProcessMenus()
	end
end)
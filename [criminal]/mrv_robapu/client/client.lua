ESX = nil
holdupon = false
robfoodmax = 0
canrobfood = false
chancecall = math.random(1, 100)
callpolice = false
canotif = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    if Config.EnableBlips then

            blip = AddBlipForCoord(Config.Epicerie.x, Config.Epicerie.y, Config.Epicerie.z)
            SetBlipSprite(blip, 52)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.9)
            SetBlipColour(blip, 50)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Apu")
            EndTextCommandSetBlipName(blip)
        end

    local hash = GetHashKey("mp_m_shopkeep_01")
        while not HasModelLoaded(hash) do
            RequestModel(hash)
            Wait(20)
        end
	ped = CreatePed("PED_TYPE_CIVMALE", "mp_m_shopkeep_01", 24.129, -1345.156, 28.497, 266.946, true, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)

    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Epicerie.x, Config.Epicerie.y, Config.Epicerie.z)

            if dist <= 1.2 and holdupon == false then
                ESX.ShowHelpNotification(_U"talkwith_apu")
			if IsControlJustPressed(1,51) then 
				mainMenu:Visible(not mainMenu:Visible())
            end
        end

        local v1 = vector3(24.129, -1345.156, 30.650)

        if Vdist2(GetEntityCoords(PlayerPedId(), false), v1) < Config.Distance then
            Draw3DText(v1.x,v1.y,v1.z, "Apu")
        end

        if robfoodmax >= Config.RobFoodMax then
            canrobfood = false
        else
            canrobfood = true
        end

        if chancecall <= Config.ChanceOfCallPolice and canotif then
            callpolice = true
        else
            callpolice = false
        end
        
    end
--
end)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0, 0.35)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function missionText(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

function startAnim(entity, lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(entity, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

function spawnbag()
    local object = GetHashKey("p_poly_bag_01_s")

    RequestModel(object)
    while (not HasModelLoaded(object)) do
        Wait(1)
    end
    
    local playerped = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(playerped))

    prop = CreateObject(object, 26.266, -1345.581, 28.497, true, false, true)

    Citizen.Wait(1000)

    DeleteEntity(prop)
end

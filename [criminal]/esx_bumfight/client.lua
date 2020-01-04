ESX = nil

local Gang = {
    models = {
        -39239064,
        -984709238,
        -984709238,
        -236444766
    },
    pos = vector3(138.22, -1343.25, 29.2),
    h = 237.17
}

local waitBluePlayer = false
local waitRedPlayer = false
local fightStarted = false
local timer = 30000
local BLUECORNER = {x = 134.7, y = -1325.08, z = 29.2}
local REDCORNER = {x = 141.32, y = -1325.63, z = 29.2}
local RING = {x = 137.81, y = -1325.28, z = 29.2}
local RINGRANGE = 4.5
local MAXDISTANCE = 20.0
local canBet = false

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                'esx:getSharedObject',
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        PlayerData = ESX.GetPlayerData()
    end
)

exports(
    'openMenu',
    function()
        ESX.TriggerServerCallback(
            'bumfight:wanted',
            function(wanted)
                if not wanted then
                    OpenBookmakerMenu()
                end
            end
        )
    end
)

exports(
    'closeMenu',
    function()
        ESX.UI.Menu.CloseAll()
    end
)

function OpenBookmakerMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open(
        'default',
        GetCurrentResourceName(),
        'open_menu',
        {
            title = 'Букмекер',
            elements = {
                {label = 'Выступить бойцом', value = 'fight'},
                {label = 'Ставка', value = 'bet'},
                {label = 'Получить прибыль', value = 'payement'}
            }
        },
        function(data, menu)
            local val = data.current.value
            if val == 'fight' then
                ESX.UI.Menu.Open(
                    'default',
                    GetCurrentResourceName(),
                    'validation',
                    {
                        title = 'Вы хотите драться?',
                        align = 'top-left',
                        elements = {
                            {label = 'Нет', value = 'no'},
                            {label = 'Да', value = 'yes'}
                        }
                    },
                    function(data2, menu2)
                        if data2.current.value == 'yes' then
                            TriggerServerEvent('bumfight:register')
                            ESX.UI.Menu.CloseAll()
                        elseif data2.current.value == 'no' then
                            ESX.UI.Menu.CloseAll()
                        end
                    end,
                    function(data2, menu2)
                        menu2.close()
                    end
                )
                menu.close()
            elseif val == 'bet' then
                OpenBetMenu()
                menu.close()
            elseif val == 'payement' then
                TriggerServerEvent('bumfight:givePayement')
                menu.close()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenBetMenu()
    ESX.UI.Menu.CloseAll()
    ESX.TriggerServerCallback(
        'bumfight:betOpen',
        function(betOpen)
            if betOpen then
                ESX.UI.Menu.Open(
                    'default',
                    GetCurrentResourceName(),
                    'open_menu',
                    {
                        title = 'На кого вы хотите сделать ставку?',
                        elements = {
                            {label = 'Синий', value = 'blue'},
                            {label = 'Красный', value = 'red'}
                        }
                    },
                    function(data, menu)
                        local betOnFighter = data.current.value
                        if betOnFighter == 'blue' then
                            ESX.UI.Menu.Open(
                                'default',
                                GetCurrentResourceName(),
                                'validation',
                                {
                                    title = 'Ваша сумма ставки',
                                    align = 'top-left',
                                    elements = {
                                        {label = '100$', value = '100'},
                                        {label = '1000$', value = '1000'},
                                        {label = '10000$', value = '10000'},
										{label = '50000$', value = '50000'},
										{label = '150000$', value = '150000'},
										{label = '500000$', value = '500000'}
                                    }
                                },
                                function(data2, menu2)
                                    if data2.current.value == '100' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', 100, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
										
                                    elseif data2.current.value == '1000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', 1000, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
										
                                    elseif data2.current.value == '10000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', 10000, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
										
									elseif data2.current.value == '50000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', 50000, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()

									elseif data2.current.value == '150000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', 150000, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
										
									elseif data2.current.value == '500000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', 500000, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
				
                                    end
                                end,
                                function(data2, menu2)
                                    menu2.close()
                                end
                            )
                            menu.close()
                        elseif betOnFighter == 'red' then
                            ESX.UI.Menu.Open(
                                'default',
                                GetCurrentResourceName(),
                                'validation',
                                {
                                    title = 'Combien?',
                                    align = 'top-left',
                                    elements = {
                                        {label = '100$', value = '100'},
                                        {label = '1000$', value = '1000'},
                                        {label = '10000$', value = '10000'},
										{label = '50000$', value = '50000'},
										{label = '150000$', value = '150000'},
										{label = '500000$', value = '500000'}
                                    }
                                },
                                function(data2, menu2)
                                    local betAmount = data2.current.value
                                    if betAmount == '100' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', betAmount, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
                                    elseif betAmount == '1000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', betAmount, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
                                    elseif betAmount == '10000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', betAmount, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
									elseif betAmount == '50000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', betAmount, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
									elseif betAmount == '150000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', betAmount, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
									elseif betAmount == '500000' then
                                        if not fightStarted then
                                            TriggerServerEvent('bumfight:bet', betAmount, betOnFighter)
                                        end
                                        ESX.UI.Menu.CloseAll()
									
										
										
                                    end
                                end,
                                function(data2, menu2)
                                    menu2.close()
                                end
                            )
                        end
                    end,
                    function(data, menu)
                        menu.close()
                    end
                )
            else
                ESX.ShowHelpNotification('~r~Ставки временно не принимаются!')
            end
        end
    )
end

RegisterNetEvent('bumfight:gotoBlueCorner')
AddEventHandler(
    'bumfight:gotoBlueCorner',
    function()
        waitBluePlayer = true
        while waitBluePlayer do
            Citizen.Wait(0)
            local player = PlayerPedId()
            local playerPos = GetEntityCoords(player)
            local distance = GetDistanceBetweenCoords(playerPos, BLUECORNER.x, BLUECORNER.y, BLUECORNER.z, true)
            DrawMarker(21, BLUECORNER.x, BLUECORNER.y, BLUECORNER.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 150, false, true, 2, true, false, false, false)
            ESX.ShowHelpNotification('Идите в ~b~синий угол~w~. Ждтие своего ~r~оппонента~w~.')
            if distance < 0.5 then
                TriggerServerEvent('bumfight:blueReady')
                waitBluePlayer = false
            elseif distance > MAXDISTANCE then
                nextFighter()
                waitBluePlayer = false
            end
            if IsPedDeadOrDying(player) ~= false then
                nextFighter()
                waitBluePlayer = false
            end
        end
    end
)

RegisterNetEvent('bumfight:gotoRedCorner')
AddEventHandler(
    'bumfight:gotoRedCorner',
    function()
        waitRedPlayer = true
        while waitRedPlayer do
            Citizen.Wait(0)
            local player = PlayerPedId()
            local playerPos = GetEntityCoords(player)
            local distance = GetDistanceBetweenCoords(playerPos, REDCORNER.x, REDCORNER.y, REDCORNER.z, true)
            DrawMarker(21, REDCORNER.x, REDCORNER.y, REDCORNER.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 150, false, true, 2, true, false, false, false)
            ESX.ShowHelpNotification('Идите в ~r~красный угол~w~. Ждтие своего ~r~оппонента~w~.')
            if distance < 0.5 then
                TriggerServerEvent('bumfight:redReady')
                waitRedPlayer = false
            elseif distance > MAXDISTANCE then
                nextFighter()
                waitRedPlayer = false
            end
            if IsPedDeadOrDying(player) ~= false then
                nextFighter()
                waitRedPlayer = false
            end
        end
    end
)

RegisterNetEvent('bumfight:fightTimer')
AddEventHandler(
    'bumfight:fightTimer',
    function()
        local initTimer = GetNetworkTime() + 30000
        timer = 30000
        ESX.ShowNotification("~y~Подождите, пока кто нибудь сделает ставку на вас~w~.")
        while timer > 0 do
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local player = PlayerPedId()
            local playerPos = GetEntityCoords(player)
            local distance = GetDistanceBetweenCoords(playerPos, RING.x, RING.y, RING.z, true)
            Citizen.Wait(0)
            if distance > RINGRANGE then
                nextFighter()
            end
            if IsPedDeadOrDying(player) ~= false then
                nextFighter()
            end
            if timer > 5000 then
                DrawHudText('Ждите ставок!', {255, 191, 0, 255}, 0.23, 0.05, 2.0, 2.0)
                if (closestPlayer ~= -1) and (closestDistance <= 20.0) then
                    TriggerServerEvent('bumfight:canBet', GetPlayerServerId(closestPlayer))
                end
            end
            if timer < 4000 then
                DrawHudText(math.floor(timer / 1000), {255, 191, 0, 255}, 0.43, 0.05, 3.0, 3.0)
                if (closestPlayer ~= -1) and (closestDistance <= 20.0) then
                    TriggerServerEvent('bumfight:cantBet', GetPlayerServerId(closestPlayer))
                end
            end
            if timer <= 1000 then
                DrawHudText('Бой!', {255, 191, 0, 255}, 0.33, 0.05, 3.0, 3.0)
            end
            timer = initTimer - GetNetworkTime()
        end
        startFighting()
    end
)

RegisterNetEvent('bumfight:noMoreFighter')
AddEventHandler(
    'bumfight:noMoreFighter',
    function()
        waitBluePlayer = false
        waitRedPlayer = false
        fightStarted = false
        timer = 0
    end
)
RegisterNetEvent('bumfight:looser')
AddEventHandler(
    'bumfight:looser',
    function()
        local hudTimer = 300
        while hudTimer > 0 do
            Citizen.Wait(0)
            hudTimer = hudTimer - 1
            DrawHudText('Погиб!', {255, 191, 0, 255}, 0.33, 0.05, 3.0, 3.0)
        end
    end
)
RegisterNetEvent('bumfight:winner')
AddEventHandler(
    'bumfight:winner',
    function()
        local hudTimer = 300
        while hudTimer > 0 do
            Citizen.Wait(0)
            hudTimer = hudTimer - 1
            DrawHudText('Победитель!', {255, 191, 0, 255}, 0.33, 0.05, 3.0, 3.0)
        end
    end
)

RegisterNetEvent('bumfight:canBet')
AddEventHandler(
    'bumfight:canBet',
    function()
        ESX.ShowNotification('Примите ~g~ставки~w~! ~y~Бой начнется~w~!')
        canBet = true
    end
)

RegisterNetEvent('bumfight:cantBet')
AddEventHandler(
    'bumfight:cantBet',
    function()
        local player = PlayerPedId()
        ESX.ShowNotification('~y~Бой начался~w~, ставки ~r~не принимаются~w~!')
        canBet = false
    end
)

Citizen.CreateThread(
    function()
        while canBet do
            Citizen.Wait(0)
            DrawText3D(BLUECORNER.x, BLUECORNER.y, BLUECORNER.z +1.5, '~b~Синий угол', 0.4)
            DrawText3D(REDCORNER.x, REDCORNER.y, REDCORNER.z +1.5, '~r~Красный угол', 0.4)
            DrawMarker(29, REDCORNER.x, REDCORNER.y, REDCORNER.z +2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 120, false, true, 2, true, false, false, false)
            DrawMarker(29, BLUECORNER.x, BLUECORNER.y, BLUECORNER.z +2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 0, 255, 120, false, true, 2, true, false, false, false)
            DrawHudText('Принимаются ставки!', {255, 191, 0, 255}, 0.24, 0.05, 2.0, 2.0)
        end
    end
)

RegisterNetEvent('bumfight:callGang')
AddEventHandler(
    'bumfight:callGang',
    function()
        for _, model in pairs(Gang.models) do
            wantedPlayer = PlayerPedId()
            if model ~= nil then
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(1)
                end
                SpawnedGang = CreatePed(2, model, Gang.pos, Gang.h, true, true)
                TaskCombatPed(SpawnedGang, GetPlayerPed(-1), 0, 16)
                SetModelAsNoLongerNeeded(wantedPlayer)
            end
        end
    end
)

function nextFighter()
    TriggerServerEvent('bumfight:nextFighter')
    fightStarted = false
    timer = 0
end

function startFighting()
    local player = PlayerPedId()
    SetEntityHealth(player, 200)
    ESX.ShowNotification('~r~Не убивай ~w~своего противника, иначе ты ничего ~r~не выиграешь')
    fightStarted = true
    while fightStarted == true do
        local playerHealth = GetEntityHealth(player)
        local playerPos = GetEntityCoords(player)
        local distance = GetDistanceBetweenCoords(playerPos, RING.x, RING.y, RING.z, true)
        if playerHealth < 130 then
            if IsPedDeadOrDying(player) == false then
                knockout(player)
                nextFighter()
            else
                nextFighter()
            end
        end
        if distance > RINGRANGE then
            nextFighter()
        end
        Citizen.Wait(0)
    end
end

function knockout(looser)
    SetPedToRagdoll(looser, 1000, 1000, 0, 0, 0, 0)
end

function DrawHudText(text, colour, coordsx, coordsy, scalex, scaley)
    local colourr, colourg, colourb, coloura = table.unpack(colour)
    SetTextFont(7)
    SetTextProportional(7)
    SetTextScale(scalex, scaley)
    SetTextColour(colourr, colourg, colourb, coloura)
    SetTextDropshadow(0, 0, 0, 0, coloura)
    SetTextEdge(1, 0, 0, 0, coloura)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(coordsx, coordsy)
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)
    AddTextComponentString(text)
    DrawText(_x, _y)
end
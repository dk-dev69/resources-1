local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastPartNum               = nil
local LastEntity                = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 2,
    modBrakes       = 2,
    modTransmission = 2,
    modSuspension   = 3,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

function OpenCloakroomMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			elements = {
				{label = _U('citizen_wear'), value = 'citizen_wear'},
				{label = _U('cartel_wear'), value = 'cartel_wear'},
			}
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				isInService = false
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
	    			TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end
			if data.current.value == 'cartel_wear' then
				isInService = true
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	    			if skin.sex == 0 then
	    				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
	    				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)

			end	
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenArmoryMenu(station)

  if Config.EnableArmoryManagement then

    local elements = {
      {label = _U('get_weapon'), value = 'get_weapon'},
      {label = _U('put_weapon'), value = 'put_weapon'},
      {label = 'Взять предмет',  value = 'get_stock'},
      {label = 'Положить предмет',  value = 'put_stock'}
    }

    if PlayerData.job.grade_name == 'boss' then
      table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponMenu()
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponMenu()
        end

        if data.current.value == 'buy_weapons' then
          OpenBuyWeaponsMenu(station)
        end

        if data.current.value == 'put_stock' then
              OpenPutStocksMenu()
            end

            if data.current.value == 'get_stock' then
              OpenGetStocksMenu()
            end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
      end
    )

  else

    local elements = {}

    for i=1, #Config.CartelStations[station].AuthorizedWeapons, 1 do
      local weapon = Config.CartelStations[station].AuthorizedWeapons[i]
      table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('esx_carteljob:giveWeapon', weapon,  1000)
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}

      end
    )

  end

end

function OpenVehicleSpawnerMenu(station, partNum)

  local vehicles = Config.CartelStations[station].Vehicles

  ESX.UI.Menu.CloseAll()

  if Config.EnableSocietyOwnedVehicles then

    local elements = {}

    ESX.TriggerServerCallback('esx_society:getVehiclesInGaragehakan', function(garageVehicles)

      for i=1, #garageVehicles, 1 do
        table.insert(elements, {label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_spawner',
        {
          title    = _U('vehicle_menu'),
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)

          menu.close()

          local vehicleProps = data.current.value

          ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, 270.0, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
            local playerPed = GetPlayerPed(-1)
            TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
          end)

          TriggerServerEvent('esx_society:removeVehicleFromGaragehakan', 'cartel', vehicleProps)

        end,
        function(data, menu)

          menu.close()

          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = _U('vehicle_spawner')
          CurrentActionData = {station = station, partNum = partNum}

        end
      )

    end, 'cartel')

  else

    local elements = {}

    for i=1, #Config.CartelStations[station].AuthorizedVehicles, 1 do
      local vehicle = Config.CartelStations[station].AuthorizedVehicles[i]
      table.insert(elements, {label = vehicle.label, value = vehicle.name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_spawner',
      {
        title    = _U('vehicle_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        local model = data.current.value

        local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x,  vehicles[partNum].SpawnPoint.y,  vehicles[partNum].SpawnPoint.z,  3.0,  0,  71)

        if not DoesEntityExist(vehicle) then

          local playerPed = GetPlayerPed(-1)

          if Config.MaxInService == -1 then

            ESX.Game.SpawnVehicle(model, {
              x = vehicles[partNum].SpawnPoint.x,
              y = vehicles[partNum].SpawnPoint.y,
              z = vehicles[partNum].SpawnPoint.z
            }, vehicles[partNum].Heading, function(vehicle)
              TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
              SetVehicleMaxMods(vehicle)
            end)

          else

            ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

              if canTakeService then

                ESX.Game.SpawnVehicle(model, {
                  x = vehicles[partNum].SpawnPoint.x,
                  y = vehicles[partNum].SpawnPoint.y,
                  z = vehicles[partNum].SpawnPoint.z
                }, vehicles[partNum].Heading, function(vehicle)
                  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  SetVehicleMaxMods(vehicle)
                end)

              else
                ESX.ShowNotification(_U('service_max') .. inServiceCount .. '/' .. maxInService)
              end

            end, 'cartel')

          end

        else
          ESX.ShowNotification(_U('vehicle_out'))
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_vehicle_spawner'
        CurrentActionMsg  = _U('vehicle_spawner')
        CurrentActionData = {station = station, partNum = partNum}

      end
    )

  end

end

function OpenCartelActionsMenu()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cartel_actions',
    {
      title    = 'Картель',
      align    = 'top-left',
      elements = {
        {label = _U('citizen_interaction'), value = 'citizen_interaction'},
      },
    },
    function(data, menu)

      if data.current.value == 'citizen_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('citizen_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('id_card'),       value = 'identity_card'},
              {label = _U('search'),        value = 'body_search'},
              {label = _U('handcuff'),    value = 'handcuff'},
              {label = _U('drag'),      value = 'drag'},
              {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
              {label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
              {label = _U('fine'),            value = 'fine'}
            },
          },
          function(data2, menu2)

            local player, distance = ESX.Game.GetClosestPlayer()

            if distance ~= -1 and distance <= 3.0 then

              if data2.current.value == 'identity_card' then
                OpenIdentityCardMenu(player)
              end

              if data2.current.value == 'body_search' then
                OpenBodySearchMenu(player)
              end

              if data2.current.value == 'handcuff' then
                TriggerServerEvent('esx_carteljob:handcuff', GetPlayerServerId(player))
              end

              if data2.current.value == 'drag' then
                TriggerServerEvent('esx_carteljob:drag', GetPlayerServerId(player))
              end

              if data2.current.value == 'put_in_vehicle' then
                TriggerServerEvent('esx_carteljob:putInVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'out_the_vehicle' then
                  TriggerServerEvent('esx_carteljob:OutVehicle', GetPlayerServerId(player))
              end

              if data2.current.value == 'fine' then
                OpenFineMenu(player)
              end

            else
              ESX.ShowNotification(_U('no_players_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'vehicle_interaction' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'vehicle_interaction',
          {
            title    = _U('vehicle_interaction'),
            align    = 'top-left',
            elements = {
              {label = _U('vehicle_info'), value = 'vehicle_infos'},
              {label = _U('pick_lock'),    value = 'hijack_vehicle'},
            },
          },
          function(data2, menu2)

            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

            if DoesEntityExist(vehicle) then

              local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

              if data2.current.value == 'vehicle_infos' then
                OpenVehicleInfosMenu(vehicleData)
              end

              if data2.current.value == 'hijack_vehicle' then

                local playerPed = GetPlayerPed(-1)
                local coords    = GetEntityCoords(playerPed)

                if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then

                  local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

                  if DoesEntityExist(vehicle) then

                    Citizen.CreateThread(function()

                      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

                      Wait(20000)

                      ClearPedTasksImmediately(playerPed)

                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehicleDoorsLockedForAllPlayers(vehicle, false)

                      TriggerEvent('esx:showNotification', _U('vehicle_unlocked'))

                    end)

                  end

                end

              end

            else
              ESX.ShowNotification(_U('no_vehicles_nearby'))
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end

      if data.current.value == 'object_spawner' then

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'citizen_interaction',
          {
            title    = _U('traffic_interaction'),
            align    = 'top-left',
            elements = {
              --{label = _U('cone'),     value = 'prop_roadcone02a'},
              --{label = _U('barrier'), value = 'prop_barrier_work06a'},
              {label = _U('spikestrips'),    value = 'p_ld_stinger_s'},
              --{label = _U('box'),   value = 'prop_boxpile_07d'},
              --{label = _U('cash'),   value = 'hei_prop_cash_crate_half_full'}
            },
          },
          function(data2, menu2)


            local model     = data2.current.value
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local forward   = GetEntityForwardVector(playerPed)
            local x, y, z   = table.unpack(coords + forward * 1.0)

            if model == 'prop_roadcone02a' then
              z = z - 2.0
            end

            ESX.Game.SpawnObject(model, {
              x = x,
              y = y,
              z = z
            }, function(obj)
              SetEntityHeading(obj, GetEntityHeading(playerPed))
              PlaceObjectOnGroundProperly(obj)
            end)

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

end

function OpenIdentityCardMenu(player)

  if Config.EnableESXIdentity then

    ESX.TriggerServerCallback('esx_carteljob:getOtherPlayerData', function(data)

      local jobLabel    = nil
      local sexLabel    = nil
      local sex         = nil
      local dobLabel    = nil
      local heightLabel = nil
      local idLabel     = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Работа : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Работа  : ' .. data.job.label
      end

      if data.sex ~= nil then
        if (data.sex == 'm') or (data.sex == 'M') then
          sex = 'Мужской'
        else
          sex = 'Женский'
        end
        sexLabel = 'Пол : ' .. sex
      else
        sexLabel = 'Пол : неизвестен'
      end

      if data.dob ~= nil then
        dobLabel = 'DOB : ' .. data.dob
      else
        dobLabel = 'DOB : неизвестен'
      end

      if data.height ~= nil then
        heightLabel = 'Рост : ' .. data.height
      else
        heightLabel = 'Рост : неизвестен'
      end

      if data.name ~= nil then
        idLabel = 'ID : ' .. data.name
      else
        idLabel = 'ID : неизвестен'
      end

      local elements = {
        {label = _U('name') .. data.firstname .. " " .. data.lastname, value = nil},
        {label = sexLabel,    value = nil},
        {label = dobLabel,    value = nil},
        {label = heightLabel, value = nil},
        {label = jobLabel,    value = nil},
        {label = idLabel,     value = nil},
      }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  else

    ESX.TriggerServerCallback('esx_carteljob:getOtherPlayerData', function(data)

      local jobLabel = nil

      if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
        jobLabel = 'Работа : ' .. data.job.label .. ' - ' .. data.job.grade_label
      else
        jobLabel = 'Работа : ' .. data.job.label
      end

        local elements = {
          {label = _U('name') .. data.name, value = nil},
          {label = jobLabel,              value = nil},
        }

      if data.drunk ~= nil then
        table.insert(elements, {label = _U('bac') .. data.drunk .. '%', value = nil})
      end

      if data.licenses ~= nil then

        table.insert(elements, {label = '--- Licenses ---', value = nil})

        for i=1, #data.licenses, 1 do
          table.insert(elements, {label = data.licenses[i].label, value = nil})
        end

      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'top-left',
          elements = elements,
        },
        function(data, menu)

        end,
        function(data, menu)
          menu.close()
        end
      )

    end, GetPlayerServerId(player))

  end

end

function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('esx_carteljob:getOtherPlayerData', function(data)

    local elements = {}

    local blackMoney = 0

    for i=1, #data.accounts, 1 do
      if data.accounts[i].name == 'black_money' then
        blackMoney = data.accounts[i].money
      end
    end

    table.insert(elements, {
      label          = _U('confiscate_dirty') .. blackMoney,
      value          = 'black_money',
      itemType       = 'item_account',
      amount         = blackMoney
    })

    table.insert(elements, {label = '--- Оружие ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = _U('confiscate') .. ESX.GetWeaponLabel(data.weapons[i].name),
        value          = data.weapons[i].name,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end

    table.insert(elements, {label = _U('inventory_label'), value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end


    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        title    = _U('search'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then

          TriggerServerEvent('esx_carteljob:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)

          OpenBodySearchMenu(player)

        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, GetPlayerServerId(player))

end

function OpenFineMenu(player)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'fine',
    {
      title    = _U('fine'),
      align    = 'top-left',
      elements = {
        {label = _U('traffic_offense'),   value = 0},
      },
    },
    function(data, menu)

      OpenFineCategoryMenu(player, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenFineCategoryMenu(player, category)

  ESX.TriggerServerCallback('esx_carteljob:getFineList', function(fines)

    local elements = {}

    for i=1, #fines, 1 do
      table.insert(elements, {
        label     = fines[i].label .. ' $' .. fines[i].amount,
        value     = fines[i].id,
        amount    = fines[i].amount,
        fineLabel = fines[i].label
      })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fine_category',
      {
        title    = _U('fine'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount

        menu.close()

        if Config.EnablePlayerManagement then
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_cartel', _U('fine_total') .. label, amount)
        else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total') .. label, amount)
        end

        ESX.SetTimeout(300, function()
          OpenFineCategoryMenu(player, category)
        end)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, category)

end

function OpenVehicleInfosMenu(vehicleData)

  ESX.TriggerServerCallback('esx_carteljob:getVehicleInfos', function(infos)

    local elements = {}

    table.insert(elements, {label = _U('plate') .. infos.plate, value = nil})

    if infos.owner == nil then
      table.insert(elements, {label = _U('owner_unknown'), value = nil})
    else
      table.insert(elements, {label = _U('owner') .. infos.owner, value = nil})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'vehicle_infos',
      {
        title    = _U('vehicle_info'),
        align    = 'top-left',
        elements = elements,
      },
      nil,
      function(data, menu)
        menu.close()
      end
    )

  end, vehicleData.plate)

end

function OpenGetWeaponMenu()

  ESX.TriggerServerCallback('esx_carteljob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('esx_carteljob:removeArmoryWeapon', function()
          OpenGetWeaponMenu()
        end, data.current.value)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = GetPlayerPed(-1)
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
      local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
      table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'top-left',
      elements = elements,
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('esx_carteljob:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('esx_carteljob:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #Config.CartelStations[station].AuthorizedWeapons, 1 do

      local weapon = Config.CartelStations[station].AuthorizedWeapons[i]
      local count  = 0

      for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = _U('buy_weapon_menu'),
        align    = 'top-left',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('esx_carteljob:buy', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('esx_carteljob:addArmoryWeapon', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('esx_carteljob:getStockItems', function(items)

    print(json.encode(items))

    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('cartel_stock'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              TriggerServerEvent('esx_carteljob:getStockItem', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

  ESX.TriggerServerCallback('esx_carteljob:getPlayerInventory', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              OpenPutStocksMenu()

              TriggerServerEvent('esx_carteljob:putStockItems', itemName, count)
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)

local specialContact = {
     name       = 'Картель',
     number     = 'cartel',
	 
     base64Icon = 'data:image/png;base64,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'
   }

   TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)

 end)

AddEventHandler('esx_carteljob:hasEnteredMarker', function(station, part, partNum)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end

  if part == 'HelicopterSpawner' then

    local helicopters = Config.CartelStations[station].Helicopters

    if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint.x, helicopters[partNum].SpawnPoint.y, helicopters[partNum].SpawnPoint.z,  3.0) then

      ESX.Game.SpawnVehicle('buzzard', {
        x = helicopters[partNum].SpawnPoint.x,
        y = helicopters[partNum].SpawnPoint.y,
        z = helicopters[partNum].SpawnPoint.z
      }, helicopters[partNum].Heading, function(vehicle)
        SetVehicleModKit(vehicle, 0)
        SetVehicleLivery(vehicle, 0)
      end)

    end

  end

  if part == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

end)

AddEventHandler('esx_carteljob:hasExitedMarker', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

AddEventHandler('esx_carteljob:hasEnteredEntityZone', function(entity)

  local playerPed = GetPlayerPed(-1)

  if PlayerData.job ~= nil and PlayerData.job.name == 'cartel' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('remove_object')
    CurrentActionData = {entity = entity}
  end

  if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed)

      for i=0, 7, 1 do
        SetVehicleTyreBurst(vehicle,  i,  true,  1000)
      end

    end

  end

end)

AddEventHandler('esx_carteljob:hasExitedEntityZone', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

RegisterNetEvent('esx_carteljob:handcuff')
AddEventHandler('esx_carteljob:handcuff', function()

  IsHandcuffed    = not IsHandcuffed;
  local playerPed = GetPlayerPed(-1)

  Citizen.CreateThread(function()

    if IsHandcuffed then

      RequestAnimDict('mp_arresting')

      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end

      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)

    else

      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)

    end

  end)
end)

RegisterNetEvent('esx_carteljob:drag')
AddEventHandler('esx_carteljob:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('esx_carteljob:putInVehicle')
AddEventHandler('esx_carteljob:putInVehicle', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end

      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

    end

  end

end)

RegisterNetEvent('esx_carteljob:OutVehicle')
AddEventHandler('esx_carteljob:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2

  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)

Citizen.CreateThread(function()

  for k,v in pairs(Config.CartelStations) do

    local blip = AddBlipForCoord(v.Harita2.Pos.x, v.Harita2.Pos.y, v.Harita2.Pos.z)

    SetBlipSprite (blip, v.Harita2.Sprite)
    SetBlipDisplay(blip, v.Harita2.Display)
    SetBlipScale  (blip, v.Harita2.Scale)
    SetBlipColour (blip, v.Harita2.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('map_blip'))
    EndTextCommandSetBlipName(blip)

  end

end)

-- Display markers
Citizen.CreateThread(function()
  while true do

    Wait(0)

    if PlayerData.job ~= nil and PlayerData.job.name == 'cartel' then

      local playerPed = GetPlayerPed(-1)
      local coords    = GetEntityCoords(playerPed)

      for k,v in pairs(Config.CartelStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.Vehicles, 1 do
          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.DrawDistance then
            DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'cartel' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if not v.BossActions[i].disabled and GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.DrawDistance then
              DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
            end
          end

        end

      end

    end

  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

  while true do

    Wait(0)

    if PlayerData.job ~= nil and PlayerData.job.name == 'cartel' then

      local playerPed      = GetPlayerPed(-1)
      local coords         = GetEntityCoords(playerPed)
      local isInMarker     = false
      local currentStation = nil
      local currentPart    = nil
      local currentPartNum = nil

      for k,v in pairs(Config.CartelStations) do

        for i=1, #v.Cloakrooms, 1 do
          if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Cloakroom'
            currentPartNum = i
          end
        end

        for i=1, #v.Armories, 1 do
          if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'Armory'
            currentPartNum = i
          end
        end

        for i=1, #v.Vehicles, 1 do

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.Helicopters, 1 do

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawner'
            currentPartNum = i
          end

          if GetDistanceBetweenCoords(coords,  v.Helicopters[i].SpawnPoint.x,  v.Helicopters[i].SpawnPoint.y,  v.Helicopters[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'HelicopterSpawnPoint'
            currentPartNum = i
          end

        end

        for i=1, #v.VehicleDeleters, 1 do
          if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
            isInMarker     = true
            currentStation = k
            currentPart    = 'VehicleDeleter'
            currentPartNum = i
          end
        end

        if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'cartel' and PlayerData.job.grade_name == 'boss' then

          for i=1, #v.BossActions, 1 do
            if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
              isInMarker     = true
              currentStation = k
              currentPart    = 'BossActions'
              currentPartNum = i
            end
          end

        end

      end

      local hasExited = false

      if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

        if
          (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
          (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
        then
          TriggerEvent('esx_carteljob:hasExitedMarker', LastStation, LastPart, LastPartNum)
          hasExited = true
        end

        HasAlreadyEnteredMarker = true
        LastStation             = currentStation
        LastPart                = currentPart
        LastPartNum             = currentPartNum

        TriggerEvent('esx_carteljob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
      end

      if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

        HasAlreadyEnteredMarker = false

        TriggerEvent('esx_carteljob:hasExitedMarker', LastStation, LastPart, LastPartNum)
      end

    end

  end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()

  local trackedEntities = {
    'prop_roadcone02a',
    'prop_barrier_work06a',
    'p_ld_stinger_s',
    'prop_boxpile_07d',
    'hei_prop_cash_crate_half_full'
  }

  while true do

    Citizen.Wait(0)

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity   = nil

    for i=1, #trackedEntities, 1 do

      local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  GetHashKey(trackedEntities[i]), false, false, false)

      if DoesEntityExist(object) then

        local objCoords = GetEntityCoords(object)
        local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)

        if closestDistance == -1 or closestDistance > distance then
          closestDistance = distance
          closestEntity   = object
        end

      end

    end

    if closestDistance ~= -1 and closestDistance <= 3.0 then

      if LastEntity ~= closestEntity then
        TriggerEvent('esx_carteljob:hasEnteredEntityZone', closestEntity)
        LastEntity = closestEntity
      end

    else

      if LastEntity ~= nil then
        TriggerEvent('esx_carteljob:hasExitedEntityZone', LastEntity)
        LastEntity = nil
      end

    end

  end
end)

-- Key Controls
Citizen.CreateThread(function()
  while true do

    Citizen.Wait(0)

    if CurrentAction ~= nil then

      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'cartel' and (GetGameTimer() - GUI.Time) > 150 then

        if CurrentAction == 'menu_cloakroom' then
          OpenCloakroomMenu()
        end

        if CurrentAction == 'menu_armory' then
          OpenArmoryMenu(CurrentActionData.station)
        end

        if CurrentAction == 'menu_vehicle_spawner' then
          OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
        end

        if CurrentAction == 'delete_vehicle' then

          if Config.EnableSocietyOwnedVehicles then

            local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
            TriggerServerEvent('esx_society:putVehicleInGaragehakan', 'cartel', vehicleProps)

          else

            if
              GetEntityModel(vehicle) == GetHashKey('cognoscenti2')  or
              GetEntityModel(vehicle) == GetHashKey('Manchez') or
              GetEntityModel(vehicle) == GetHashKey('Contender') or
              GetEntityModel(vehicle) == GetHashKey('felon')
            then
              TriggerServerEvent('esx_service:disableService', 'cartel')
            end

          end

          ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
        end

        if CurrentAction == 'menu_boss_actions' then

          ESX.UI.Menu.CloseAll()

          TriggerEvent('esx_society:openBossMenuhakan', 'cartel', function(data, menu)

            menu.close()

            CurrentAction     = 'menu_boss_actions'
            CurrentActionMsg  = _U('open_bossmenu')
            CurrentActionData = {}

          end)

        end

        if CurrentAction == 'remove_entity' then
          DeleteEntity(CurrentActionData.entity)
        end

        CurrentAction = nil
        GUI.Time      = GetGameTimer()

      end

    end

   if IsControlPressed(0,  Keys['F6']) and PlayerData.job ~= nil and PlayerData.job.name == 'cartel' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'cartel_actions') and (GetGameTimer() - GUI.Time) > 150 then
     OpenCartelActionsMenu()
     GUI.Time = GetGameTimer()
    end

  end
end)

---------------------------------------------------------------------------------------------------------
--NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('NB:openMenuCartel')
AddEventHandler('NB:openMenuCartel', function()
	OpenCartelActionsMenu()
end)

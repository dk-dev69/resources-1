local options = {
    x = 0.90,
    y = 0.30,
    width = 0.2,
    height = 0.04,
    scale = 0.4,
    font = 4,
    menu_title = "Управление транспортом",
    color_r = 0,
    color_g = 0,
    color_b = 0,
}

local elements = {}
local menuopen = false
local isInVehicle = false
local engineon = true
local limiteur = false
speed = 0
local regulateur = 50

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1, 244) and IsPedInAnyVehicle(GetPlayerPed(-1)) then
            MainMenu()
            Menu.hidden = not Menu.hidden
            menuopen = not menuopen
       end
        Menu.renderGUI(options)
    end
end)



function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function MainMenu()
    options.menu_subtitle = "Общие элементы"  
    ClearMenu()
    Menu.addButton("Вкл/Выкл двигатель", "onoffengine", nil)
    Menu.addButton("Регулировка скорости", "MenuSpeedo", 50)
    Menu.addButton("Двери", "DoorMenu", nil)
    Menu.addButton("Закрыть меню", "closemenu", nil)
	
end

function DoorMenu()
    options.menu_subtitle = "Двери и капот"  
    ClearMenu()
    Menu.addButton("Капот", "capot", nil)
    Menu.addButton("Багажник", "coffre", nil)
    Menu.addButton("Передние двери", "avant", nil)    
    Menu.addButton("Задние двери", "arriere", nil)
    Menu.addButton("Все двери", "toute", nil)    
    Menu.addButton("Назад", "MainMenu", nil)
end

function avant()
    options.menu_subtitle = "Двери"  
    ClearMenu()
    Menu.addButton("Передняя левая", "avantgauche", nil)
    Menu.addButton("Передняя правая", "avantdroite", nil)
    Menu.addButton("Назад", "DoorMenu", nil)
end

function arriere()
    options.menu_subtitle = "Двери"  
    ClearMenu()
    Menu.addButton("Задняя левая", "arrieregauche", nil)
    Menu.addButton("Задняя правая", "arrieredroite", nil)
  Menu.addButton("Назад", "DoorMenu", nil)
end

function MenuSpeedo()
  if regulateur == 50 then
    options.menu_subtitle = "Регулировка скорости :  Вкл"  
  else
    options.menu_subtitle = "Регулировка скорости : ~g~" ..regulateur..  "~s~ КМ/Ч"
  end
    ClearMenu()
    Menu.addButton("Увеличить скорость", "uprregu", nil)
    Menu.addButton("Уменьшить скорость", "downrregu", nil)
    if regulateur > 50 then
    Menu.addButton("Отключить регулировку", "suprregu", nil)
    end
    Menu.addButton("Назад", "MainMenu", nil)
end


function capot()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 4, false)
       else
         SetVehicleDoorOpen(playerVeh, 4, false)
         frontleft = true        
      end
   end
end

function coffre()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 5, false)
       else
         SetVehicleDoorOpen(playerVeh, 5, false)
         frontleft = true        
      end
   end
end

function maxspeed()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   enableCruise = not enableCruise -- inverts bool
   cruiseSpeed = GetEntitySpeed(veh)  
   GetEntitySpeed(playerVeh, 10)
end

function avantgauche()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 0, false)
       else
         SetVehicleDoorOpen(playerVeh, 0, false)
         frontleft = true        
      end
   end
end

function MyPed()
   return GetPlayerPed(-1)
end


function avantdroite()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 1, false)
       else
         SetVehicleDoorOpen(playerVeh, 1, false)
         frontleft = true        
      end
   end
end

function arrieredroite()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 3, false)
       else
         SetVehicleDoorOpen(playerVeh, 3, false)
         frontleft = true        
      end
   end
end

function toute()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 5, false)        
         SetVehicleDoorShut(playerVeh, 4, false)
         SetVehicleDoorShut(playerVeh, 3, false)
         SetVehicleDoorShut(playerVeh, 2, false)
         SetVehicleDoorShut(playerVeh, 1, false)
         SetVehicleDoorShut(playerVeh, 0, false)         
       else
         SetVehicleDoorOpen(playerVeh, 5, false)        
         SetVehicleDoorOpen(playerVeh, 4, false)
         SetVehicleDoorOpen(playerVeh, 3, false)
         SetVehicleDoorOpen(playerVeh, 2, false)
         SetVehicleDoorOpen(playerVeh, 1, false)
         SetVehicleDoorOpen(playerVeh, 0, false)  
         frontleft = true        
      end
   end
end

function arrieregauche()
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
      if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
         SetVehicleDoorShut(playerVeh, 2, false)
       else
         SetVehicleDoorOpen(playerVeh, 2, false)
         frontleft = true        
      end
   end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0) 
    if regulateur == 50 then
    else      
        speedo(regulateur)
      end
    end
end)

function setregul()
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)  
        local currSpeed = GetEntitySpeed(vehicle)*3.6  
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 20)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local vitesse = GetOnscreenKeyboardResult()
          if not vitesse ~= nil then
          Notify("NIL")
          else  
          local res = tonumber(vitesse)  
          if currSpeed > res then
            Notify("~r~Ваша скорость предельно низкая ~g~50 ~r~км/ч.")
        else             
            speedo(res)
            regulateur = res
            MainMenu()
            Wait(1)
            MenuSpeedo()  
            Menu.selection = 1    
            end      
          end
        end      
end

function suprregu()
  print("1")
  speedo(0)
  regulateur = 50
  MainMenu()
  Wait(1)
  MenuSpeedo()
  Menu.selection = 2
end

function uprregu()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)  
    local currSpeed = GetEntitySpeed(vehicle)*3.6
    if currSpeed > regulateur then
      Notify("~r~Ваша скорость предельно низкая ~g~50 ~r~км/ч.")
    else  
  regulateur = regulateur +10
  MainMenu()
  Wait(1)
  MenuSpeedo()
end
end

function downrregu()
  if regulateur < 60 then
    --print('testtt')
    regulateur = 50
  MainMenu()
  Wait(1)
  MenuSpeedo()      
else
  if regulateur == 50 then
  regulateur = 50
  speedo(0)
else  
  regulateur = regulateur -10
  MainMenu()
  Wait(1)
  MenuSpeedo()  
  Menu.selection = 1
end
end
end

function speedo(vit)
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)  
    local currSpeed = GetEntitySpeed(vehicle)*3.6
    speed = vit/3.62
   
    local vehicleModel = GetEntityModel(vehicle)
    local float Max = GetVehicleMaxSpeed(vehicleModel)  
    if (vit == 0) then
    SetEntityMaxSpeed(vehicle, Max)
    end      
  if currSpeed > vit then
  else
   
    if (vit == 0) then
    SetEntityMaxSpeed(vehicle, Max)
    else
    if vit == 0 and currSpeed < 5 then  
    else
      SetEntityMaxSpeed(vehicle, speed)
  end
    end
end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
        if limiteur then
          local ped = GetPlayerPed(-1)
          local vehicle = GetVehiclePedIsIn(ped, false)          
          SetEntityMaxSpeed(vehicle, speed) 
       end
    end
end)

function onoffengine()
  if engineon then
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false)    
   engineon = false
  else
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), true, false)   
   engineon = true 
end
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
        if not engineon then
          SetVehicleEngineOn(GetVehiclePedIsIn(GetPlayerPed(-1), false), false, false)     
       end
    end
end)

function closemenu()
    Menu.hidden = not Menu.hidden
    menuopen = not menuopen
end


Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1, 177) and menuopen then
            closemenu()
       end
    end
end)







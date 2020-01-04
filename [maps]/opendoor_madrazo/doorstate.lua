local ESX      = nil
local PlayerData = {}

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)
--

lockState = {    
    [1] = { ["objName"] = "v_ilev_ra_door4l", ["x"]= 1395.920, ["y"]= 1142.904, ["z"]= 114.700, ["locked"]= true }, -- ranch front left
    [2] = { ["objName"] = "v_ilev_ra_door4r", ["x"]= 1395.919, ["y"]= 1140.704, ["z"]= 114.790, ["locked"]= true }, -- ranch front right
    [3] = { ["objName"] = "v_ilev_tort_door", ["x"]= 134.395, ["y"]= -2204.097, ["z"]= 7.514, ["locked"]= true }, -- torture door
    [3] = { ["objName"] = "v_ilev_fh_frontdoor", ["x"]= 7.518, ["y"]= 539.527, ["z"]= 176.178, ["locked"]= true }, -- torture door
}

-- lockState = {    
   -- [1] = { ["objName"] = "v_ilev_ra_door4l", ["x"]= 1395.920, ["y"]= 1142.904, ["z"]= 114.700, ["locked"]= true }, -- front left
   -- [2] = { ["objName"] = "v_ilev_ra_door4r", ["x"]= 1395.919, ["y"]= 1140.704, ["z"]= 114.790, ["locked"]= true }, -- front right
-- }
--
drawOnScreen3D = function(dx,dy,dz, text, size)

    local onScreen, x, y = World3dToScreen2d(dx,dy,dz)
    local camCoords      = GetGameplayCamCoords()
    local dist           = GetDistanceBetweenCoords(camCoords.x, camCoords.y, camCoords.z, dx, dy, dz, 1)
    local size           = size
  
    if size == nil then
      size = 3
    end
  
    local scale = (size / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
  
    if onScreen then
  
      SetTextScale(0.0 * scale, 0.55 * scale)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 255)
      SetTextDropshadow(0, 0, 0, 0, 255)
      SetTextEdge(4, 0, 0, 0, 150)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry('STRING')
      SetTextCentre(1)
  
      AddTextComponentString(text)
  
      DrawText(x, y)
    end
  
  end
--
RegisterNetEvent('OD:state')
AddEventHandler('OD:state', function(id, isLocked)
    PlayerData = ESX.GetPlayerData()
	
	if PlayerData.job.name == "fbi" or PlayerData.job.name == "cartel" then
		if type(lockState[id]) ~= nil then -- Check if door exists
			lockState[id]["locked"] = isLocked -- Change state of door
		end
	else
	exports.pNotify:SendNotification({
		text = "<center><span style='color:#F73006'>Вы не являетесь участником картеля, но находитесь на их территории, это не безопасно</span><center>",
		type = "error",
		timeout = 7000,
		layout = "bottomRight",
	})
	end

	
end)

--
Citizen.CreateThread(function()
	while true do
	--Citizen.Wait(0)
        for i=1, #lockState do
                local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                local closeDoor = GetClosestObjectOfType(lockState[i]["x"], lockState[i]["y"], lockState[i]["z"], 1.0, GetHashKey(lockState[i]["objName"]), false, false, false)       
                local distance = GetDistanceBetweenCoords(playerCoords.x,playerCoords.y,playerCoords.z, lockState[i]["x"], lockState[i]["y"], lockState[i]["z"], true)
				
                if(distance < 1.5) then
                    if lockState[i]["locked"] == true then
                        drawOnScreen3D(lockState[i]["x"], lockState[i]["y"], lockState[i]["z"],"[E] ~r~Дверь закрыта", 0.3)
                    else
                       drawOnScreen3D(lockState[i]["x"], lockState[i]["y"], lockState[i]["z"],"[E] ~g~Дверь открыта", 0.3)
                    end
                    if IsControlJustPressed(1,51) then
                        if lockState[i]["locked"] == true then
                            TriggerServerEvent('OD:updateState', i, false) -- ask the server to update states... dont just DO it.
                        else
                            TriggerServerEvent('OD:updateState', i, true)
                        end                        
                    end
                    FreezeEntityPosition(closeDoor, lockState[i]["locked"])
                else               
                    FreezeEntityPosition(closeDoor, lockState[i]["locked"])
                end
        end 
        Citizen.Wait(0)
    end
end)
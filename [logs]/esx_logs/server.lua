local os_time = os.time
local os_date = os.date

local connexionsLogs = {}
local killsLogs = {}
local vehiclesLogs = {}
local weaponsLogs = {}

local policeVehicleLogsStats = 0-- For Stats
local blVehiclesStats = 0 -- Also for stats

local LogConnect = true
local LogDisconnect = true

RegisterServerEvent('logs:onPlayerKilled')
AddEventHandler('logs:onPlayerKilled', function(t,killer, kilerT) -- t : 0 = NPC, 1 = player
  local file = io.open("logs/KillLogs.txt", "a")
  local local_hour = os_date("%I:%M:%S")

  if(t == 1) then
     if(GetPlayerName(killer) ~= nil and GetPlayerName(source) ~= nil)then
        
       if(kilerT.killerinveh) then
         local model = kilerT.killervehname
         if file then
             print("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by  : "..GetPlayerName(killer).." ("..getPlayerID(killer)..") | Vehicle"..model)

             file:write("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by : "..GetPlayerName(killer).." ("..getPlayerID(killer)..") | Vehicle : "..model)
             file:write("\n")

             killsLogs[#killsLogs+1] = "["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by : "..GetPlayerName(killer).." ("..getPlayerID(killer)..") | Vehicle : "..model
         end

       else
          if file then
             print("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by : "..GetPlayerName(killer).." ("..getPlayerID(killer)..")")

             file:write("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by : "..GetPlayerName(killer).." ("..getPlayerID(killer)..")")
             file:write("\n")

             killsLogs[#killsLogs+1] = "["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by : "..GetPlayerName(killer).." ("..getPlayerID(killer)..")"
         end
       end    
    end
  else
    print("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by a NPC or vehicle")
    file:write("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by a NPC or vehicle")
    file:write("\n")

    killsLogs[#killsLogs+1] = "["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") has been killed by a NPC or vehicle"
  end

  TriggerClientEvent("logs:updateArray", -1, 2, killsLogs, 1,#killsLogs)

  file:close()
end)



RegisterServerEvent("logs:sendPoliceLog")
AddEventHandler("logs:sendPoliceLog", function(model)
  local local_hour = os_date("%I:%M:%S")
    print("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") : "..model)
    local file = io.open("logs/PoliceVehicleLogs.txt", "a")
    if file then
      file:write("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") : "..model)
      file:write("\n")
    end
    file:close()

    vehiclesLogs[#vehiclesLogs+1] = "["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") : "..model
    policeVehicleLogsStats = policeVehicleLogsStats +1
    TriggerClientEvent("logs:updateArray", -1, 3, vehiclesLogs, 2,policeVehicleLogsStats)
end)



RegisterServerEvent("logs:sendBlackListedLogs")
AddEventHandler("logs:sendBlackListedLogs", function(model)
  local local_hour = os_date("%I:%M:%S")
  local file = io.open("logs/BlackListedLogs.txt", "a")
  if file then
    print("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") : "..model)
     file:write("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") : "..model)
     file:write("\n")
  end
  file:close()

  vehiclesLogs[#vehiclesLogs+1] = "["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") : "..model
  blVehiclesStats = blVehiclesStats + 1
  TriggerClientEvent("logs:updateArray", -1, 3, vehiclesLogs, 3,blVehiclesStats)
end)



RegisterServerEvent("logs:sendBlackListedWeapon")
AddEventHandler("logs:sendBlackListedWeapon", function(wea)
local local_hour = os_date("%I:%M:%S")
  local file = io.open("logs/BlackListedWeaponLogs.txt", "a")
  if file then
    print("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") have a blacklisted weapon : "..hashToWeapon[wea])
     file:write("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") have a blacklisted weapon : "..hashToWeapon[wea])
     file:write("\n")
  end
  file:close()

  weaponsLogs[#weaponsLogs+1] = "["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") have a blacklisted weapon : "..hashToWeapon[wea]
  TriggerClientEvent("logs:updateArray", -1, 4, weaponsLogs, 4,#weaponsLogs)
end)



AddEventHandler("playerDropped", function(reason)
	if(LogDisconnect) then
		local local_hour = os_date("%I:%M:%S")
	  	local file = io.open("logs/Connections.txt", "a")
	  	if file then
	    	print("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") disconnected.")
	    	 file:write("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") disconnected.")
	    	 file:write("\n")
	  	end
	  file:close()

    connexionsLogs[#connexionsLogs+1] = "["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") disconnected."
    TriggerClientEvent("logs:updateArray", -1, 1, connexionsLogs, 0,0)
	end
end)



RegisterServerEvent("logs:playerConnected")
AddEventHandler("logs:playerConnected", function()
  local _source = source
	if(LogConnect) then
		local local_hour = os_date("%I:%M:%S")
 		 local file = io.open("logs/Connections.txt", "a")
  		if file then
   			print("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") connected.")
    		file:write("["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") connected.")
    		file:write("\n")
  		end
 		file:close()

    connexionsLogs[#connexionsLogs+1] = "["..local_hour.."] "..GetPlayerName(source).." ("..getPlayerID(source)..") connected."
    TriggerClientEvent("logs:updateArray", -1, 1, connexionsLogs, 0,0)
	end

  TriggerEvent("es:getPlayerFromId",_source, function(player)
    TriggerClientEvent("logs:updateGroup", _source, player.getGroup())
    print(player.getGroup())
    TriggerClientEvent("logs:updateArray", _source, 1, connexionsLogs, 0,0)
    TriggerClientEvent("logs:updateArray", _source, 2, killsLogs, 1,#killsLogs)
    TriggerClientEvent("logs:updateArray", _source, 3, vehiclesLogs, 2,policeVehicleLogsStats)
    TriggerClientEvent("logs:updateArray", _source, 3, vehiclesLogs, 3,blVehiclesStats)
    TriggerClientEvent("logs:updateArray", _source, 4, weaponsLogs, 4,#weaponsLogs)
  end)
end)



function getFileContent(fileDir)
  local linesContent = {}


  local file = io.open(fileDir, "a")

   if(file) then
      local testIfFileExists = file:read()

      if(testIfFileExists ~= nil) then
        for line in file:lines() do 
          linesContent[#linesContent+1] = line
        end
      end
   end
   file:close()

   return linesContent
end


function getLogs()
  connexionsLogs = getFileContent("logs/Connections.txt")
  killsLogs = getFileContent("logs/KillLogs.txt")
  vehiclesLogs = getFileContent("logs/PoliceVehicleLogs.txt") 
  policeVehicleLogsStats = #vehiclesLogs
  weaponsLogs = getFileContent("logs/BlackListedWeaponLogs.txt")


   for _,k in pairs(getFileContent("logs/BlackListedLogs.txt")) do
    vehiclesLogs[#vehiclesLogs+1] = k
    blVehiclesStats = blVehiclesStats + 1
   end
end

getLogs()



-- get's the player id without having to use bugged essentials
function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

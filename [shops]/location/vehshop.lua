RegisterNetEvent('voiture:FinishMoneyCheckForVel')

local voitureshop = {
	opened = false,
	title = "Прокат",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 5 },
	menu = {
		x = 0.9,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = { 
			title = "CATEGORIES", 
			name = "main",
			buttons = { 
				{name = "Scooter", description = ''},
				{name = "Velos", description = ''},
			}
		},
		["vehicles"] = { 
			title = "VEHICLES", 
			name = "vehicles",
			buttons = { 
				{name = "Scooter", description = ''},
				{name = "Velos", description = ''},
				}
		},
		["Scooter"] = { 
			title = "Scooter", 
			name = "Scooter",
			buttons = { 
				{name = "faggio2", costs = 1000, description = {}, model = "faggio2"},
				
			}
		},
		["Velos"] = { 
			title = "Velos", 
			name = "Velos",
			buttons = { 
				{name = "BMX", costs = 90, description = {}, model = "BMX"},
				{name = "Cruiser", costs = 90, description = {}, model = "cruiser"},
				{name = "VdC", costs = 90, description = {}, model = "fixter"},
				{name = "VdC bleu", costs = 90, description = {}, model = "tribike3"},
				{name = "VdC rouge", costs = 90, description = {}, model = "tribike2"},
				{name = "VdC Jaune", costs = 90, description = {}, model = "tribike"},
				{name = "VTT", costs = 90, description = {}, model = "scorcher"},
			}
		},
	}
}

local fakevoiture = {model = '', voiture = nil}
local voiture_localisations = {
	{entering = {-954.965,-2705.22,13.831}, inside = {-954.965,-2705.22,13.831}, outside = {-954.965,-2705.22,13.831}},
	{entering = {209.762,-938.398,23.1416}, inside = {214.684,-937.723,24.1416}, outside = {214.684,-937.723,24.1416}},
}	

local voitureshop_blips ={}
local inrangeofvoitureshop = false
local currentlocationvoiture = nil
local boughtvoiture = false

local function LocalPed()
return GetPlayerPed(-1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)	
end

function IsPlayerinrangeofvoitureshop()
return inrangeofvoitureshop
end

function ShowvoitureshopBlips(bool)
	if bool and #voitureshop_blips == 0 then
		for station,pos in pairs(voiture_localisations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])

			SetBlipSprite(blip,365)
			SetBlipColour(blip, 74)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Прокат')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(voitureshop_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #voitureshop_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(voitureshop_blips) do
					if IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and voitureshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < 5 then
						DrawMarker(0,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]-1.0001, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 2.0, 11, 80, 169, 255, 0, 0, 1, 0, 0, 0, 0)
						drawTxt('Нажмите ~g~ENTER~s~ чтобы взять ~b~на прокат',0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocationvoiture = b
						inrange = true
					end
				end
				inrangeofvoitureshop = inrange
			end
		end)
	elseif bool == false and #voitureshop_blips > 0 then
		for i,b in ipairs(voitureshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		voitureshop_blips = {}
	end
end

function f(n)
return n + 0.0001
end

function LocalPed()
return GetPlayerPed(-1)
end

function try(f, catch_f)
local status, exception = pcall(f)
if not status then
catch_f(exception)
end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function OpenCreatorvoiture()		
	boughtvoiture = false
	local ped = LocalPed()
	local pos = currentlocationvoiture.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	voitureshop.currentmenu = "main"
	voitureshop.opened = true
	voitureshop.selectedbutton = 0
end

function CloseCreatorvoiture()
	Citizen.CreateThread(function()
		local ped = LocalPed()
		if not boughtvoiture then
			local pos = currentlocationvoiture.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,128 do
				mods[i] = GetVehicleMod(veh,i)
			end	
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocationvoiture.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetModelAsNoLongerNeeded(model)
			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end
			SetVehicleOnGroundProperly(personalvehicle)
			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(GetPlayerPed(-1),personalvehicle,-1)
			SetEntityVisible(ped,true)
			
			
		end
		voitureshop.opened = false
		voitureshop.menu.from = 1
		voitureshop.menu.to = 10
	end)
end

function drawMenuvoitureButton(button,x,y,selected)
	local menu = voitureshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)	
end

function drawMenuvoitureInfo(text)
	local menu = voitureshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)	
end

function drawMenuvoitureRight(txt,x,y,selected)
	local menu = voitureshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)	
end

function drawMenuvoitureTitle(txt,x,y)
local menu = voitureshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)	
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function Notify(text)
SetNotificationTextEntry('STRING')
AddTextComponentString(text)
DrawNotification(false, false)
end

function DoesPlayerHaveVehicle(model,button,y,selected)
		local t = false
		if t then
			drawMenuvoitureRight("OWNED",voitureshop.menu.x,y,selected)
		else
			drawMenuvoitureRight(button.costs.."$",voitureshop.menu.x,y,selected)
		end
end

local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,201) and IsPlayerinrangeofvoitureshop() then
			if voitureshop.opened then
				CloseCreatorvoiture()
			else
				OpenCreatorvoiture()
			end
		end
		if voitureshop.opened then
			local ped = LocalPed()
			local menu = voitureshop.menu[voitureshop.currentmenu]
			drawTxt(voitureshop.title,1,1,voitureshop.menu.x,voitureshop.menu.y,1.0, 255,255,255,255)
			drawMenuvoitureTitle(menu.title, voitureshop.menu.x,voitureshop.menu.y + 0.08)
			drawTxt(voitureshop.selectedbutton.."/"..tablelength(menu.buttons),0,0,voitureshop.menu.x + voitureshop.menu.width/2 - 0.0385,voitureshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = voitureshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false
			
			for i,button in pairs(menu.buttons) do
				if i >= voitureshop.menu.from and i <= voitureshop.menu.to then
					
					if i == voitureshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuvoitureButton(button,voitureshop.menu.x,y,selected)
					if button.costs ~= nil then
						if voitureshop.currentmenu == "Velos" or voitureshop.currentmenu == "Scooter" then
							DoesPlayerHaveVehicle(button.model,button,y,selected)
						else
						drawMenuvoitureRight(button.costs.."$",voitureshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
					if voitureshop.currentmenu == "Velos" or voitureshop.currentmenu == "Scooter" then
						if selected then
							if fakevoiture.model ~= button.model then
								if DoesEntityExist(fakevoiture.voiture) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakevoiture.voiture))
								end
								local pos = currentlocationvoiture.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)
									drawTxt("~b~Chargement...",0,1,0.5,0.5,1.5,255,255,255,255)
									
								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								while not DoesEntityExist(veh) do
									Citizen.Wait(0)
									drawTxt("~b~Chargement...",0,1,0.5,0.5,1.5,255,255,255,255)
								end
								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,31 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakevoiture = { model = button.model, voiture = veh}
							end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						ButtonSelected(button)
					end
				end
			end	
		end
		if voitureshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if voitureshop.selectedbutton > 1 then
					voitureshop.selectedbutton = voitureshop.selectedbutton -1
					if buttoncount > 10 and voitureshop.selectedbutton < voitureshop.menu.from then
						voitureshop.menu.from = voitureshop.menu.from -1
						voitureshop.menu.to = voitureshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if voitureshop.selectedbutton < buttoncount then
					voitureshop.selectedbutton = voitureshop.selectedbutton +1
					if buttoncount > 10 and voitureshop.selectedbutton > voitureshop.menu.to then
						voitureshop.menu.to = voitureshop.menu.to + 1
						voitureshop.menu.from = voitureshop.menu.from + 1
					end
				end	
			end
		end
		
	end
end)


function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = voitureshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Velos" then
			OpenMenu('Velos')
		elseif btn == "Scooter" then
			OpenMenu('Scooter')
		end
		
	elseif this == "Velos" or this == "Scooter" then

	local name = button.name	
		local vehicle = button.model
		local price = button.costs
		TriggerServerEvent('voiture:CheckMoneyForVel',name, vehicle, price)
	end
end

AddEventHandler('voiture:FinishMoneyCheckForVel', function(name, vehicle, price)	
	local name = name
	local vehicle = vehicle
	local price = price
	boughtvoiture = true
	CloseCreatorvoiture(name, vehicle, price)
end)


function OpenMenu(menu)
	fakevoiture = {model = '', voiture = nil}
	voitureshop.lastmenu = voitureshop.currentmenu
	if menu == "vehicles" then
		voitureshop.lastmenu = "main"
	elseif menu == "bikes"  then
		voitureshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		voitureshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		voitureshop.lastmenu = "race_create_objects"
	end
	voitureshop.menu.from = 1
	voitureshop.menu.to = 10
	voitureshop.selectedbutton = 0
	voitureshop.currentmenu = menu	
end


function Back()
	if backlock then
		return
	end
	backlock = true
	if voitureshop.currentmenu == "main" then
		CloseCreatorvoiture()
	elseif voitureshop.currentmenu == "Velos" or voitureshop.currentmenu == "Scooter" then
		if DoesEntityExist(fakevoiture.voiture) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakevoiture.voiture))
		end
		fakevoiture = {model = '', voiture = nil}
		OpenMenu(voitureshop.lastmenu)
	else
		OpenMenu(voitureshop.lastmenu)
	end
	
end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
	ShowvoitureshopBlips(true)
	firstspawn = 1
end
end)
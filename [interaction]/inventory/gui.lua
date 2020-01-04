GUI = {}
Menu = {}
Menus = {}

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================--
--                                           Settings                                           --
--==============================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

GUI.maxVisOptions = 7
GUI.optionText = {255, 255, 255, 255, 0} 
GUI.subText = {255, 255, 255, 255, 0}
GUI.subRect = {0, 0, 0, 230}
GUI.optionRect = {0, 0, 0, 170}
GUI.scroller = {230, 230, 230, 255}
optionTextSize = {0.35, 0.35}
optionRectSize = {0.23, 0.035}
subTitle = "~HUD_COLOUR_FREEMODE~INTERACTION MENU"
menuX = 0.131
menuXOption = 0.11
menuXOtherOption = 0.1

titleTextSize = {0.85, 0.80}
GUI.titleText = {255, 255, 255, 255, 4}

-- DON'T TOUCH THIS !!
menuYModify = 0.14
menuYOptionDiv = 3.98
menuYOptionAdd = 0.1295
--------------------

menuYSubRect = 0.03496

-- OLD VERSION
--[[
menuYModify = 0.14
menuYOptionDiv = 3.9798
menuYOptionAdd = 0.13158
]]--

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================--
--                                           Draw Menu                                          --
--==============================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

local menuOpen = false
prevMenu = nil
curMenu = nil
selectPressed = false
leftPressed = false
rightPressed = false
currentOption = 1
local optionCount = 0

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function Menu.IsOpen() 
	return menuOpen == true
end

function Menu.SetupMenu(menu, title)
	Menus[menu] = {}
	Menus[menu].title = title
	Menus[menu].optionCount = 0
	Menus[menu].options = {}
	Menus[menu].previous = nil
	--currentOption = 1
end

function Menu.addOption(menu, option)
	if not (Menus[menu].title == nil) then
		Menus[menu].optionCount = Menus[menu].optionCount + 1
		Menus[menu].options[Menus[menu].optionCount] = option
	end
end

function Menu.Switch(prevmenu, menu)
  curMenu = menu
  prevMenu = prevmenu
  if Menus[menu] then
    if Menus[menu].optionCount then
      if Menus[menu].optionCount < currentOption then
        currentOption = Menus[menu].optionCount
        if currentOption == 0 then
          currentOption = 1
        end
      end
    end
  end
  if prevmenu ~= nil and menu ~= "" then
    Menus[menu].previous = prevmenu
  end
end

function Menu.DisplayCurMenu()
	if not (curMenu == "") then
		menuOpen = true
		Menu.Title(Menus[curMenu].title)
		for k,v in pairs(Menus[curMenu].options) do
			v()
		end
		Menu.updateSelection()
	end
end

function GUI.Text(text, color, position, size, center)
	SetTextCentre(center)
	SetTextColour(color[1], color[2], color[3], color[4])
	SetTextFont(color[5])
	SetTextScale(size[1], size[2])
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(position[1], position[2])
end

function GUI.TextRight(text, color, position, size, center)
	SetTextRightJustify(true)
	SetTextWrap(0.0000, 0.2400)
	SetTextColour(color[1], color[2], color[3], color[4])
	SetTextFont(color[5])
	SetTextScale(size[1], size[2])
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(position[1], position[2])
end

local Ibuttons = nil
function SetIbuttons(buttons, layout)
	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(Ibuttons) then
			Ibuttons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Ibuttons) do
				Citizen.Wait(0)
			end
		end
		local w,h = GetScreenResolution()
		PushScaleformMovieFunction(Ibuttons,"INSTRUCTIONAL_BUTTONS")
		PopScaleformMovieFunction()
		PushScaleformMovieFunction(Ibuttons,"SET_MAX_WIDTH")
		PushScaleformMovieFunctionParameterInt(1)
		PopScaleformMovieFunction()
		for i,btn in pairs(buttons) do
			PushScaleformMovieFunction(Ibuttons,"SET_DATA_SLOT")
			PushScaleformMovieFunctionParameterInt(i-1)
			PushScaleformMovieFunctionParameterString(btn[1])
			PushScaleformMovieFunctionParameterString(btn[2])
			PopScaleformMovieFunction()
		end
		if layout ~= 1 then
			PushScaleformMovieFunction(Ibuttons,"SET_PADDING")
			PushScaleformMovieFunctionParameterInt(10)
			PopScaleformMovieFunction()
		end
		PushScaleformMovieFunction(Ibuttons,"DRAW_INSTRUCTIONAL_BUTTONS")
		PushScaleformMovieFunctionParameterInt(layout)
		PopScaleformMovieFunction()
	end)
end

function DrawIbuttons()
	if HasScaleformMovieLoaded(Ibuttons) then
		DrawScaleformMovieFullscreen(Ibuttons, 255, 255, 255, 255)
	end
end

function GUI.Rect(color, position, size)
	DrawRect(position[1], position[2], size[1], size[2], color[1], color[2], color[3], color[4])
end

function GUI.Spriter(Streamedtexture, textureName, x, y, width, height, rotation, r, g, b, a)
	if not HasStreamedTextureDictLoaded(Streamedtexture) then
		RequestStreamedTextureDict(Streamedtexture, false)
	else
		DrawSprite(Streamedtexture, textureName, x, y, width, height, rotation, r, g, b, a)
	end
end

function Menu.Title(title)
    GUI.Text(title, GUI.titleText, {menuX - menuXOption, menuYModify - 0.098}, titleTextSize, false)

	GUI.Spriter("commonmenu", "interaction_bgd", menuX, 0.065, 0.23, 0.095, 0.0, 255, 255, 255, 255)
		
	scaleform = RequestScaleformMovie("MP_MENU_GLARE")
	DrawScaleformMovie(scaleform, menuX + 0.3394, 0.485, 1.0, 1.04, 255, 255, 255, 255, 0)
	Menu.PageCounter()
end

function Menu.PageCounter()
    GUI.Text(subTitle, GUI.subText, {menuX - menuXOption, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, false)
	GUI.TextRight("~HUD_COLOUR_FREEMODE~"..currentOption.." / "..Menus[curMenu].optionCount, GUI.subText, {menuX + menuXOption - 0.0165, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)},  optionTextSize, false)
	GUI.Rect(GUI.subRect, { menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify) }, optionRectSize)
end

function Menu.Option(option)
	optionCount = optionCount + 1

	local thisOption = nil
	if (currentOption == optionCount) then
		thisOption = true
	else
		thisOption = false
	end
	
	if (thisOption == true) then
		GUI.optionText = {0, 0, 0, 255, 0}
    else
        GUI.optionText = {255, 255, 255, 255, 0}
    end

	if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(option, GUI.optionText, {menuX - menuXOption, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, false)
		GUI.Rect(GUI.optionRect, { menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify) }, optionRectSize)
		if(thisOption) then
			--GUI.Rect(GUI.scroller, { menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify) }, optionRectSize)
			GUI.Spriter("commonmenu", "gradient_nav", menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify), 0.23, 0.035, 0.0, 230, 230, 230, 255)
		end
	elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(option, GUI.optionText, {menuX - menuXOption, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)},  optionTextSize, false)
		GUI.Rect(GUI.optionRect, { menuX, (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify) }, optionRectSize)
		if(thisOption) then
			--GUI.Rect(GUI.scroller, { menuX, (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify) }, optionRectSize)
			GUI.Spriter("commonmenu", "gradient_nav", menuX, (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify), 0.23, 0.035, 0.0, 230, 230, 230, 255)
		end
	end

	if (optionCount == currentOption and selectPressed) then
		return true
	end

	return false
end

function Menu.Inventory(option, quantity)
	optionCount = optionCount + 1

	local thisOption = nil
	if (currentOption == optionCount) then
		thisOption = true
	else
		thisOption = false
	end
	
	if (thisOption == true) then
		GUI.optionText = {0, 0, 0, 255, 0}
    else
        GUI.optionText = {255, 255, 255, 255, 0}
    end

	if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(option, GUI.optionText, {menuX - menuXOption, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, false)
		GUI.TextRight(quantity, GUI.optionText, { menuX + menuXOtherOption - 0.025, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
		
		GUI.Rect(GUI.optionRect, { menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify) }, optionRectSize)
		if(thisOption) then
			--GUI.Rect(GUI.scroller, { menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify) }, optionRectSize)
			GUI.Spriter("commonmenu", "gradient_nav", menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify), 0.23, 0.035, 0.0, 230, 230, 230, 255)
		end
	elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(option, GUI.optionText, {menuX - menuXOption, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)},  optionTextSize, false)
		GUI.TextRight(quantity, GUI.optionText, { menuX + menuXOtherOption - 0.025, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
		
		GUI.Rect(GUI.optionRect, { menuX, (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify) }, optionRectSize)
		if(thisOption) then
			--GUI.Rect(GUI.scroller, { menuX, (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify) }, optionRectSize)
			GUI.Spriter("commonmenu", "gradient_nav", menuX, (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify), 0.23, 0.035, 0.0, 230, 230, 230, 255)
		end
	end

	if (optionCount == currentOption and selectPressed) then
		return true
	end

	return false
end

function Menu.changeMenu(option, menu)
	if (Menu.Option(option)) then
		Menu.Switch(curMenu, menu)
	end

	if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(">", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
	elseif(optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(">", GUI.optionText, { menuX + 0.068, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
	end

	if (optionCount == currentOption and selectPressed) then
		return true
	end

	return false
end

function Menu.Bool(option, bool, cb)
	Menu.Option(option)

	if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		if(bool) then
			GUI.Text("~g~On", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
		else
			GUI.Text("~r~Off", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
		end
	elseif(optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		if(bool) then
			GUI.Text("~g~On", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
		else
			GUI.Text("~r~Off", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
		end
	end

	if (optionCount == currentOption and selectPressed) then
	    cb(not bool)
		return true
	end
	return false
end

function Menu.Int(option, int, min, max, cb)
	Menu.Option(option);

	if (optionCount == currentOption) then
		if (leftPressed) then
			if (int >= min) then int = int - 1 else int = max end
			PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		end
		if (rightPressed) then
			if (int < max) then int = int + 1 else int = min end
			PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		end
	end

	if (currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(tostring(int), GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
	elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(tostring(int), GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
	end

	if (optionCount == currentOption and selectPressed) then cb(int) return true
    elseif (optionCount == currentOption and leftPressed) then cb(int) 
    elseif (optionCount == currentOption and rightPressed) then cb(int) end

	return false
end

function Menu.CharInt(option, int, min, max, optionc, cb)
	Menu.Option(option);

	if (optionCount == currentOption) then
		if (leftPressed) then
			if (int >= min) then int = int - 1 else int = max end
			PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		end
		if (rightPressed) then
			if (int < max) then int = int + 1 else int = min end
			PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		end
	end

	if (currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.TextRight(optionc, GUI.optionText, { menuX + menuXOtherOption - 0.025, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
	elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.TextRight(optionc, GUI.optionText, { menuX + menuXOtherOption - 0.025, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
	end

	if (optionCount == currentOption and selectPressed) then cb(int) return true
    elseif (optionCount == currentOption and leftPressed) then cb(int)
    elseif (optionCount == currentOption and rightPressed) then cb(int) end

	return false
end

function Menu.StringArray(option, array, position, cb)

	Menu.Option(option);

	if (optionCount == currentOption) then
		local max = tablelength(array)
		local min = 1
		if (leftPressed) then
			if(position > min) then position = position - 1 else position = max end
		end
		if (rightPressed) then
			if(position < max) then position = position + 1 else position = min end
		end
	end

	if (currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
		GUI.Text(array[position], GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
	elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
		GUI.Text(array[position], GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.0135) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
	end

	if (optionCount == currentOption and selectPressed) then cb(position) return true
    elseif (optionCount == currentOption and leftPressed) then cb(position)
    elseif (optionCount == currentOption and rightPressed) then cb(position) end

	return false
end

function Menu.ScrollBarStringSelect(array, min, cb)

    local currentPosition = min -- Scroller Position
    local maxPosition = tablelength(array)

    Menu.Option(array[currentPosition+1])
    local bar = {
        x = menuX + 0.065, -- X Coordinate of both boxes
        y = (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify), -- Y Coordinate of both boxes
        height = optionRectSize[2]/3, -- Height of both boxes
        width = {background_box = 0.08, scroller = optionRectSize[1]/5}, -- Width??
    }

    if (optionCount == currentOption) then
        if (leftPressed) then
            if currentPosition > 0 then currentPosition = currentPosition-1 elseif currentPosition == 0 then currentPosition = maxPosition-1 else currentPosition = min end
        end
        if (rightPressed) then -- right
            if currentPosition < maxPosition-1 then currentPosition = currentPosition+1 elseif currentPosition == maxPosition-1 then currentPosition = 0 else currentPosition = maxPosition-1 end
        end
    end

    if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
        bar.y = (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify)
        DrawRect(bar.x, bar.y, bar.width.background_box, bar.height, GUI.optionRect[1], GUI.optionRect[2], GUI.optionRect[3], GUI.optionRect[4]) -- Background
        local new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) + (((bar.width.background_box - bar.width.scroller) / (maxPosition-1)) * currentPosition)
        if new_x < (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MIN
        if new_x > (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MAX
        DrawRect(new_x,bar.y,bar.width.scroller,bar.height, GUI.scroller[1], GUI.scroller[2], GUI.scroller[3], GUI.scroller[4])    -- Scroller
    elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
        bar.y = (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)
        DrawRect(bar.x, bar.y, bar.width.background_box, bar.height, GUI.optionRect[1], GUI.optionRect[2], GUI.optionRect[3], GUI.optionRect[4]) -- Background
        local new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) + (((bar.width.background_box - bar.width.scroller) / (maxPosition-1)) * currentPosition)
        if new_x < (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MIN
        if new_x > (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MAX
        DrawRect(new_x,bar.y,bar.width.scroller,bar.height, GUI.scroller[1], GUI.scroller[2], GUI.scroller[3], GUI.scroller[4])    -- Scroller
    end

    if (optionCount == currentOption and selectPressed) then cb(currentPosition) return true
    elseif (optionCount == currentOption and leftPressed) then cb(currentPosition) return false
    elseif (optionCount == currentOption and rightPressed) then cb(currentPosition) return false end
    return false
end

function Menu.ScrollBarString(array, min, cb)

    local currentPosition = min -- Scroller Position
    local maxPosition = tablelength(array)

    Menu.Option(array[currentPosition+1])
    local bar = {
        x = menuX + 0.065, -- X Coordinate of both boxes
        y = (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify), -- Y Coordinate of both boxes
        height = optionRectSize[2]/3, -- Height of both boxes
        width = {background_box = 0.08, scroller = optionRectSize[1]/5}, -- Width??
    }

    if (optionCount == currentOption) then
        if (leftPressed) then
            if currentPosition > 0 then currentPosition = currentPosition-1 elseif currentPosition == 0 then currentPosition = maxPosition-1 else currentPosition = min end
        end
        if (rightPressed) then -- right
            if currentPosition < maxPosition-1 then currentPosition = currentPosition+1 elseif currentPosition == maxPosition-1 then currentPosition = 0 else currentPosition = maxPosition-1 end
        end
    end

    if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
        bar.y = (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify)
        DrawRect(bar.x, bar.y, bar.width.background_box, bar.height, GUI.optionRect[1], GUI.optionRect[2], GUI.optionRect[3], GUI.optionRect[4]) -- Background
        local new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) + (((bar.width.background_box - bar.width.scroller) / (maxPosition-1)) * currentPosition)
        if new_x < (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MIN
        if new_x > (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MAX
        DrawRect(new_x,bar.y,bar.width.scroller,bar.height, GUI.scroller[1], GUI.scroller[2], GUI.scroller[3], GUI.scroller[4])    -- Scroller
    elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
        bar.y = (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)
        DrawRect(bar.x, bar.y, bar.width.background_box, bar.height, GUI.optionRect[1], GUI.optionRect[2], GUI.optionRect[3], GUI.optionRect[4]) -- Background
        local new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) + (((bar.width.background_box - bar.width.scroller) / (maxPosition-1)) * currentPosition)
        if new_x < (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MIN
        if new_x > (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MAX
        DrawRect(new_x,bar.y,bar.width.scroller,bar.height, GUI.scroller[1], GUI.scroller[2], GUI.scroller[3], GUI.scroller[4])    -- Scroller
    end

    if (optionCount == currentOption and leftPressed) then cb(currentPosition) return true
    elseif (optionCount == currentOption and rightPressed) then cb(currentPosition) return true end
    return false
end

function Menu.ScrollBarInt(option, min, max, cb)
    
    Menu.Option(option)
    local bar = {
        x = menuX + 0.065, -- X Coordinate of both boxes
        y = (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify), -- Y Coordinate of both boxes
        height = optionRectSize[2]/3, -- Height of both boxes
        width = {background_box = 0.08, scroller = optionRectSize[1]/5}, -- Width??
    }
    local currentPosition = min -- Scroller Position
    local maxPosition = max

    if (optionCount == currentOption) then
        if (leftPressed) then
            if currentPosition > 0 then currentPosition = currentPosition-1 elseif currentPosition == 0 then currentPosition = maxPosition-1 else currentPosition = min end
        end
        if (rightPressed) then -- right
            if currentPosition < maxPosition-1 then currentPosition = currentPosition+1 elseif currentPosition == maxPosition-1 then currentPosition = 0 else currentPosition = maxPosition-1 end
        end
    end

    if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
        bar.y = (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify)
        DrawRect(bar.x, bar.y, bar.width.background_box, bar.height, GUI.optionRect[1], GUI.optionRect[2], GUI.optionRect[3], GUI.optionRect[4]) -- Background
        local new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) + (((bar.width.background_box - bar.width.scroller) / (maxPosition-1)) * currentPosition)
        if new_x < (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MIN
        if new_x > (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MAX
        DrawRect(new_x,bar.y,bar.width.scroller,bar.height, GUI.scroller[1], GUI.scroller[2], GUI.scroller[3], GUI.scroller[4])    -- Scroller
    elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
        bar.y = (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)
        DrawRect(bar.x, bar.y, bar.width.background_box, bar.height, GUI.optionRect[1], GUI.optionRect[2], GUI.optionRect[3], GUI.optionRect[4]) -- Background
        local new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) + (((bar.width.background_box - bar.width.scroller) / (maxPosition-1)) * currentPosition)
        if new_x < (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x - ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MIN
        if new_x > (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) then new_x = (bar.x + ((bar.width.background_box - bar.width.scroller)/2)) end  ---- SCROLLER MAX
        DrawRect(new_x,bar.y,bar.width.scroller,bar.height, GUI.scroller[1], GUI.scroller[2], GUI.scroller[3], GUI.scroller[4])    -- Scroller
    end

    if (optionCount == currentOption and leftPressed) then cb(currentPosition) return true
    elseif (optionCount == currentOption and rightPressed) then cb(currentPosition) return true end
    return false
end

function Menu.updateSelection()
  selectPressed = false;
  leftPressed = false;
  rightPressed = false;
  DrawIbuttons()
  SetIbuttons({
    {GetControlInstructionalButton(1, 177, 0), "Retour"},
    {GetControlInstructionalButton(1, 201, 0), "Selectionner"},
    {GetControlInstructionalButton(1, 27, 0), "Haut"},
    {GetControlInstructionalButton(1, 173, 0), "Bas"},
	{GetControlInstructionalButton(1, 175, 0), "Droite"},
	{GetControlInstructionalButton(1, 174, 0), "Gauche"},
  }, 0)
  
  if (optionCount >= GUI.maxVisOptions) then
		GUI.Rect(GUI.subRect, { menuX, (GUI.maxVisOptions + 1) * menuYSubRect + 0.1320 }, optionRectSize)
		GUI.Spriter("commonmenu", "shop_arrows_upanddown", menuX, ((GUI.maxVisOptions + 1) * menuYSubRect + 0.1320), 0.025, 0.045, 0.0, 255, 255, 255, 255)

		-- Description Rect
		GUI.Rect(GUI.optionRect, { menuX, (GUI.maxVisOptions + 1) * menuYSubRect + 0.1855 }, {0.23, 0.065})	
		GUI.Rect({0, 0, 0, 255}, { menuX, (GUI.maxVisOptions + 1) * menuYSubRect + 0.1545 }, {0.23, 0.0025})	
	elseif (optionCount >= 0) then
	    GUI.Rect(GUI.subRect, { menuX, (optionCount + 1) * menuYSubRect + 0.1315 }, optionRectSize)
		GUI.Spriter("commonmenu", "shop_arrows_upanddown", menuX, ((optionCount + 1) * menuYSubRect + 0.1315), 0.025, 0.045, 0.0, 255, 255, 255, 255)
		
		-- Description Rect
		GUI.Rect(GUI.optionRect, { menuX, (optionCount + 1) * menuYSubRect + 0.1850 }, {0.23, 0.065})
		GUI.Rect({0, 0, 0, 255}, { menuX, (optionCount + 1) * menuYSubRect + 0.1540 }, {0.23, 0.0025})
  end

  if IsControlJustPressed(1, 173)  then
    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    if(currentOption < optionCount) then
      currentOption = currentOption + 1
    else
      currentOption = 1
    end
  elseif IsControlJustPressed(1, 172) then
    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    if(currentOption > 1) then
      currentOption = currentOption - 1
    else
      currentOption = optionCount
    end
  elseif IsControlJustPressed(1, 174) then
    leftPressed = true
  elseif IsControlJustPressed(1, 175) then
    rightPressed = true
  elseif IsControlJustPressed(1, 176)  then
    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
    selectPressed = true
  elseif IsControlJustPressed(1, 177) then
    PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	currentOption = 1
    if (prevMenu == nil) then
      Menu.Switch(nil, "")
      menuOpen = false
      if clothing_menu then
      	clothing_menu = false
      end
      currentOption = 1
    end
    if not (prevMenu == nil) then
      if not Menus[prevMenu].previous == nil then
        currentOption = 1
        Menu.Switch(nil, prevMenu)
        Citizen.Trace("IS NOT NIL BUT NIL? "..prevMenu)
      else
        if Menus[prevMenu].optionCount < currentOption then
          currentOption = Menus[prevMenu].optionCount
        end
        Menu.Switch(Menus[prevMenu].previous, prevMenu)
      end
    end
  end
  optionCount = 0
end
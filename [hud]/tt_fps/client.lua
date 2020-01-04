--[[
Thanks To siggyfawn
]]--

local useColors = true -- Do you want the FPS to change color based on the FPS.

local prevframes, prevtime, curtime, curframes, fps = 0, 0, 0, 0, 0

Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) or not NetworkIsSessionStarted() do
        Citizen.Wait(0)
        prevframes = GetFrameCount()
        prevtime = GetGameTimer()
    end

    while true do
        Citizen.Wait(10)
        curtime = GetGameTimer()
        curframes = GetFrameCount()

        if (curtime - prevtime) > 1000 then
            fps = (curframes - prevframes) - 1              
            prevtime = curtime
            prevframes = curframes
        end

        if useColors then
		    if fps > 0 and fps < 12 then
		        displayText("~c~FPS: ~r~" .. fps, 0, 255, 255, 255, 255, 0.5, 0.0)
		    elseif fps > 0 and fps < 30 then
		        displayText("~c~FPS: ~o~" .. fps, 0, 255, 255, 255, 255, 0.5, 0.0)
		    elseif fps > 0 and fps < 1000 then
		        displayText("~c~FPS: ~g~" .. fps, 0, 255, 255, 255, 255, 0.5, 0.0)
		    end
		else
		    if fps > 0 and fps < 1000 then
		        displayText("~c~FPS: " .. fps, 0, 255, 255, 255, 255, 0.5, 0.0)
		    end
		end
    end
end)

function displayText(text, justification, red, green, blue, alpha, posx, posy)
    SetTextFont(4)
    SetTextWrap(0.0, 1.0)
    SetTextScale(1.0, 0.5)
    SetTextJustification(justification)
    SetTextColour(red, green, blue, alpha)
    SetTextOutline()

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(posx, posy)
end

Citizen.CreateThread(function()
    Holograms()
end)

----------------------------------------------------------------

function Holograms()

		while true do

			Citizen.Wait(0)			


                if GetDistanceBetweenCoords( -2361.00, 3249.20, 32.00, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			Draw3DText( -2361.00, 3249.20, 32.50  -1.400, "Чтобы подняться, нажмите стрелку вверх", 4, 0.1, 0.1)

			
		end		


		if GetDistanceBetweenCoords( -2361.00, 3249.20, 92.00, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			Draw3DText( -2361.00, 3249.20, 92.50  -1.400, "Чтобы спуститься вниз нажмите стрелку вниз", 4, 0.09, 0.09)

        end	
        
        if GetDistanceBetweenCoords( 136.19, -761.00, 45.75, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			Draw3DText( 136.19, -761.00, 45.50  -1.400, "Чтобы подняться, нажмите стрелку вверх", 4, 0.09, 0.09)

        end	
        
        -- if GetDistanceBetweenCoords( 136.19, -761.00, 234.15, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			-- Draw3DText( 136.19, -761.00, 234.15 -1.400, "Чтобы подняться, нажмите стрелку вверх", 4, 0.09, 0.09)

        -- end	

        -- if GetDistanceBetweenCoords( 136.19, -761.00, 234.15, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			-- Draw3DText( 136.19, -761.00, 234.15 -1.600, "Чтобы спуститься вниз нажмите стрелку вниз", 4, 0.09, 0.09)

        -- end	
        
        if GetDistanceBetweenCoords(136.19, -761.00, 242.15, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			Draw3DText(136.19, -761.00, 242.15 -1.400 , "Чтобы спуститься вниз нажмите стрелку вниз", 4, 0.09, 0.09)

        end	
        
        if GetDistanceBetweenCoords(246.43, -1372.55, 24.54, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			Draw3DText(246.43, -1372.55, 24.54 -1.400 , "Чтобы подняться, нажмите стрелку вверх", 4, 0.09, 0.09)

        end	
       
        if GetDistanceBetweenCoords(248.68, -1369.94, 29.65, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			Draw3DText(248.68, -1369.94, 29.65 -1.400 , "Чтобы спуститься вниз нажмите стрелку вниз", 4, 0.09, 0.09)

        end	

        if GetDistanceBetweenCoords(3540.75, 3676.64, 21.00, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			Draw3DText(3540.75, 3676.64, 21.00 -1.400 , "Чтобы подняться, нажмите стрелку вверх", 4, 0.09, 0.09)

        end	
        
        if GetDistanceBetweenCoords(3540.75, 3676.64, 28.12, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then

			Draw3DText(3540.75, 3676.64, 28.12 -1.400 , "Чтобы спуститься вниз нажмите стрелку вниз", 4, 0.09, 0.09)

		end	

	end

end


-------------------------------------------------------------------------------------------------------------------------
function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
         local px,py,pz=table.unpack(GetGameplayCamCoords())
         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
         local scale = (1/dist)*20
         local fov = (1/GetGameplayCamFov())*100
         local scale = scale*fov   
         SetTextScale(scaleX*scale, scaleY*scale)
         SetTextFont(fontId)
         SetTextProportional(1)
         SetTextColour(250, 250, 250, 255)
         SetTextDropshadow(1, 1, 1, 1, 255)
         SetTextEdge(2, 0, 0, 0, 150)
         SetTextDropShadow()
         SetTextOutline()
         SetTextEntry("STRING")
         SetTextCentre(1)
         AddTextComponentString(textInput)
         SetDrawOrigin(x,y,z+2, 0)
         DrawText(0.0, 0.0)
         ClearDrawOrigin()
        end

-----------------------------------------------------------------------------------------------------------------------------Below line is TP/Elevator stuff
key_to_teleport_up = 187
key_to_teleport_down = 188

positions = {
    {{136.19, -761.00, 45.75, 0}, {136.19, -761.00, 242.15, 0}, {136.19, -761.00, 242.15, 0},  ""}, 
    {{-2361.00, 3249.20, 31.80, 0}, {-2361.00, 3249.20, 91.80, 0}, {-2361.00, 3249.20, 31.80, 0}, ""},
    {{246.43, -1372.55, 24.54, 0}, {248.68, -1369.94, 29.65, 0}, {246.43, -1372.55, 24.54, 0}, ""}, 
    {{3540.75, 3676.64, 21.00, 0}, {3540.75, 3676.64, 28.12, 0}, {3540.75, 3676.64, 21.00, 0}, "Текст не требуется"},


}


local player = GetPlayerPed(-1)

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        local player = GetPlayerPed(-1)
        local playerLoc = GetEntityCoords(player)

        for i,location in ipairs(positions) do
            teleport_text = location[3]
            loc1 = {
                x=location[1][1],
                y=location[1][2],
                z=location[1][3], 
            }
            loc2 = {
                x=location[2][1],
                y=location[2][2],
                z=location[2][3],
            }
            loc3 = {
                x=location[3][1],
                y=location[3][2],
                z=location[3][3],
            }
            


            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
                
                
                if IsControlJustReleased(1, key_to_teleport_down) then
                        Citizen.Wait(1500)
                        FreezeEntityPosition(GetPlayerPed(-1),true)
                        Citizen.Wait(500)
                        PlaySoundFrontend(-1, "Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1);
                        Citizen.Wait(4500)
                       PlaySoundFrontend(-1, "Enter_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        FreezeEntityPosition(GetPlayerPed(-1), False )
                    else
                        SetEntityCoords(player, loc2.x, loc2.y, loc2.z)

                        FreezeEntityPosition(GetPlayerPed(-1), False )

                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then

                

                if IsControlJustReleased(1, key_to_teleport_up) then
                    Citizen.Wait(1500)
                    FreezeEntityPosition(GetPlayerPed(-1),true)
                    Citizen.Wait(500)
                    PlaySoundFrontend(-1, "Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1);
                    Citizen.Wait(4500)
                    PlaySoundFrontend(-1, "Enter_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
                    
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc1.x, loc1.y, loc1.z)
                        FreezeEntityPosition(GetPlayerPed(-1), False )
                else
                        SetEntityCoords(player, loc1.x, loc1.y, loc1.z)
                       
                        FreezeEntityPosition(GetPlayerPed(-1), False )
                        
                    end
                end

                if IsControlJustReleased(1, key_to_teleport_down) then
                    Citizen.Wait(1500)
                    FreezeEntityPosition(GetPlayerPed(-1),true)
                    Citizen.Wait(500)
                    PlaySoundFrontend(-1, "Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1);
                    Citizen.Wait(4500)
                    PlaySoundFrontend(-1, "Enter_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
                    
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc3.x, loc3.y, loc3.z)
                        FreezeEntityPosition(GetPlayerPed(-1), False )
                else
                        SetEntityCoords(player, loc3.x, loc3.y, loc3.z)
                       
                        FreezeEntityPosition(GetPlayerPed(-1), False )
                        
                    end
                end
            end

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc3.x, loc3.y, loc3.z, 2) then

                if IsControlJustReleased(1, key_to_teleport_up) then
                    Citizen.Wait(1500)
                    FreezeEntityPosition(GetPlayerPed(-1),true)
                    Citizen.Wait(500)
                    PlaySoundFrontend(-1, "Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1);
                    Citizen.Wait(4500)
                    PlaySoundFrontend(-1, "Enter_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
                    
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetVehiclePedIsUsing(player), loc2.x, loc2.y, loc2.z)
                        FreezeEntityPosition(GetPlayerPed(-1), False )
                else
                        SetEntityCoords(player,  loc2.x, loc2.y, loc2.z)
                       
                        FreezeEntityPosition(GetPlayerPed(-1), False )
                        
                    end
                end
            end            
        end
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end


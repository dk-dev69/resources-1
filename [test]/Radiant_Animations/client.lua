--New custom animations based off DavesEmotes from @davewazere
--https://forum.fivem.net/t/release-daves-emotes/140216 
--Finger Pointing is taken from @Geekness and @Hallux
--https://forum.fivem.net/t/release-finger-pointing-by-geekness/103722
--Ragdoll is from here @callmejaf
--https://forum.fivem.net/t/release-toggle-ragdoll/53668
--Crouch is from wolfknights script @WolfKnight
--https://forum.fivem.net/t/release-crouch-script-1-0-1-now-button-based/14742


-- Commands
-- Asker: 		/e asker 		: Asker selamı verir!
-- Parmak 1:    /e parmak 		: Tek elini kaldırarak orta parmak çeker.
-- Parmak 2:    /e parmak2 		: İki elini kaldırarak orta parmak çeker.
-- Teslim Olma: /e teslim	    : Ellerini ensesine koyarak teslim olur.
-- Yüzü Kapatma:/e yüz			: Düşünceli şekilde yüzü kapatma.
-- Not Al: 		/e not		    : Kağıda Not yazar.
-- Çanta:		/e canta		: Eline taktiksel bir çanta alır.Çantayı elinizden bırakmak için TAB tuşuna basmalısınız.
-- Çanta 2:		/e canta2		: Eline deri bir çanta alır.Çantayı elinizden bırakmak için TAB tuşuna basmalısınız.
-- Kol Bağlar:	/e kol		    : Kollarını Bağlar 
-- Kol Bağlar 2:/e kol2	        : Kollarını Bağlar v2
-- Lanet:		/e lanet		: Kollarını ileri atarak lanet olsun hareketi yapar.
-- Başarısız:	/e basarisiz	: Başarısız olduğunun farkına varır.
-- Çete İşareti1:/e cete1		: Çete İşareti 1
-- Çete İşareti2:/e cete2		: Çete İşareti 2
-- Hayır:		/e hayir	    : Kafayı hayır dermiş gibi sallar.
-- Kaşı :	    /e kasi		    : G**** Kaşır.
-- Kaşı 2:	    /e kasi2	    : T**** kaşır.
-- Peace:		/e peace		: Barış işareti yapar.
-- Puro:		/e puro		    : Ağzına puro koyar.
-- Puro2:		/e puro2		: Ağzına yanmış bir puro koyar.
-- Esrar:		/e esrar		: Ağzına esrar koyar.
-- Sigara:		/e sigara	    : Ağzına sigara koyar.
-- Puro tut:    /e purotut	    : Elinizde puro tutar.
-- Sigara tut:  /e sigaratut    : Elinizde sigara tutar.
-- Esrar tut:	/e esrartut	    : Elinizde esrar tutar.
-- Ölü Numarası:/e ol			: Ölü numarası yapar
-- Silah Kılıfı:/e tut	        : Elinizi silah kılıfında tutar.
-- Aim:			/e aim			: Tabancayı yere doğru nişan alır.
-- Aim2:		/e aim2			: Tabancayı yukarıya doğru nişan alır.
-- 				/e alkis		: Yavaşça alkışlar.
--				/e kutu			: Kutu çıkartır ve elinde onunla yürüyebilirsin.
--				/e alkis2		: Alkışlar.
--				/e yat			: Yaralanmış gibi yere yatar.
--				/e uzan		    : Duvara doğru uzanır.
--				/e sakin	    : Kalabalığı sakinleştirme animasyonu yapar.
--				/e sakin2	    : Kalabalığı sakinleştirme animasyonu yapar v2.
--				/e bel		    : Elini karın kısmına atar.
--				/e semsiye	    : Eline şemsiye alır.
--				/e koruma	    : Koruma moduna geçer.
--				/e ilkyardim    : Yaralı insana ilkyardım yapar.
-- If you want ESX features enabled you can uncomment this stuff
--------------------------------------------------------------------------------------------- ESX SUPPORT ---------------------------------------------------------------------------------------------


ESX 			    			= nil
local PlayerData 				= {}

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

------------------------------------------------------------------------------------------ END ESX SUPPORT ------------------------------------------------------------------------------------------

local radioActive 				= false
local radioButton				= 249 --- U by default  -- use 57 for f10
local handsUpButton				= 28 --- H by default -- use 73 for X

--- Function for radio chatter function
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		if (IsControlJustPressed(0, radioButton)) and (PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'fbi') then
			--if (IsControlJustPressed(0, radioButton))  then
			local ped = PlayerPedId()
			--TriggerEvent('chatMessage', 'TESTING ANIMATION')
			if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
				radioActive = true
				if radioActive then
					RequestAnimDict( "random@arrests" )
	
					while ( not HasAnimDictLoaded( "random@arrests" ) ) do 
						Citizen.Wait( 100 )
					end
	
					if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
						ClearPedSecondaryTask(ped)
					else
						TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
						local prop_name = prop_name
						local secondaryprop_name = secondaryprop_name
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						DetachEntity(secondaryprop, 1, 1)
						DeleteObject(secondaryprop)
						--SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
					end
				end
			end
		end
	end
end)
	
--- Broke this into two functions because it was bugging out for some reason.
	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		if (PlayerData.job ~= nil and PlayerData.job.name == 'police') and (IsControlJustReleased(0,57))  and (radioActive) then
		--if (IsControlJustReleased(0,raisehandbutton))  and (radioActive) then
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
				radioActive = false
				ClearPedSecondaryTask(ped)
				--SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
			end
		end
	
	end
end)


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		if (IsControlJustPressed(0,handsUpButton))  then
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
	
				RequestAnimDict( "random@mugging3" )
	
				while ( not HasAnimDictLoaded( "random@mugging3" ) ) do 
					Citizen.Wait( 100 )
				end
	
				if IsEntityPlayingAnim(ped, "random@mugging3", "handsup_standing_base", 3) then
					ClearPedSecondaryTask(ped)
				else
					TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
					local prop_name = prop_name
					local secondaryprop_name = secondaryprop_name
					DetachEntity(prop, 1, 1)
					DeleteObject(prop)
					DetachEntity(secondaryprop, 1, 1)
					DeleteObject(secondaryprop)
				end
			end
		end
	end
end)


RegisterCommand("e",function(source, args)
	local player = PlayerPedId()
	if tostring(args[1]) == nil then
		print("Invalid syntax, correct syntax is: /e <animation> ")
		return
	else
		if tostring(args[1]) ~= nil then
            local argh = tostring(args[1])

			if argh == 'teslim' then
				local surrendered = false
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( "random@arrests" )
					loadAnimDict( "random@arrests@busted" )
					if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
						TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (3000)
						TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
						surrendered = false
					else
						TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (4000)
						TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (500)
						TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
						Wait (1000)
						TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
						Wait(100)
						surrendered = true
					end     
				end

				Citizen.CreateThread(function() --disabling controls while surrendured
					while surrendered do
						Citizen.Wait(0)
						if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(0,21,true)
						end
					end
				end)


			elseif argh == 'asker' then
				local ad = "anim@mp_player_intuppersalute"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (600)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'parmak' then
				local ad = "anim@mp_player_intselfiethe_bird"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'parmak2' then
				local ad = "anim@mp_player_intupperfinger"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'yüz' then
				local ad = "anim@mp_player_intupperface_palm"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
					else
						TaskPlayAnim( player, ad, "idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'not' then
				local ad = "missheistdockssetup1clipboard@base"
				
				local prop_name = prop_name or 'prop_notepad_01'
				local secondaryprop_name = secondaryprop_name or 'prop_pencil_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						DetachEntity(secondaryprop, 1, 1)
						DeleteObject(secondaryprop)
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						secondaryprop = CreateObject(GetHashKey(secondaryprop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 18905), 0.1, 0.02, 0.05, 10.0, 0.0, 0.0, true, true, false, true, 1, true) -- notepad
						AttachEntityToEntity(secondaryprop, player, GetPedBoneIndex(player, 58866), 0.12, 0.0, 0.001, -150.0, 0.0, 0.0, true, true, false, true, 1, true) -- pencil
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'callphone' then
				local ad = "cellphone@"
				
				local prop_name = prop_name or 'prop_player_phone_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "cellphone_call_listen_base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.5, 0.002, -0.01, 75.0, -10.0, 165.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "cellphone_call_listen_base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
				elseif argh == 'kahve' then
				local ad = "amb@world_human_aa_coffee@base"
				
				local prop_name = prop_name or 'p_amb_coffeecup_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.15, 0.020, -0.06, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'icki' then
				local ad = "amb@code_human_wander_drinking@beer@male@base"
				
				local prop_name = prop_name or 'p_wine_glass_s'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 28422), 0.008, -0.02, -0.2, 90.0, 270.0, 90.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'tabak' then
				local ad = "missheistdockssetup1clipboard@base"
				
				local prop_name = prop_name or 'prop_cs_plate_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						ClearPedSecondaryTask(PlayerPedId())
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.15, 0.020, -0.06, 40.0, -1.0, 175.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'kol2' then
				local ad = "missfbi_s4mop"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "guard_idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "guard_idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'semsiye' then
				local ad = "amb@world_human_drinking@coffee@male@base"
				
				local prop_name = prop_name or 'p_amb_brolly_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						ClearPedSecondaryTask(PlayerPedId())
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.15, 0.005, -0.02, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
	    elseif argh == 'poset' then
				local ad = "amb@world_human_drinking@coffee@male@base"
				
				local prop_name = prop_name or 'hei_prop_heist_cash_bag_01'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
						Wait (100)
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						ClearPedSecondaryTask(PlayerPedId())
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 57005), 0.15, 0.005, -0.02, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'canta' then
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					GiveWeaponToPed(player, 0x88C78EB7, 1, false, true);
				end
			elseif argh == 'canta2' then
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					GiveWeaponToPed(player, 0x01B79F17, 1, false, true);
				end
			elseif argh == 'kol' then
				local ad = "oddjobs@assassinate@construction@"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "unarmed_fold_arms", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "unarmed_fold_arms", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )

					end     
				end
			elseif argh == 'lanet' then
				local ad = "gestures@m@standing@casual"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "gesture_damn", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "gesture_damn", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'basarisiz' then
				local ad = "random@car_thief@agitated@idle_a"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "agitated_idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "agitated_idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'cete1' then
				local ad = "mp_player_int_uppergang_sign_a"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_gang_sign_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_gang_sign_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'cete2' then
				local ad = "mp_player_int_uppergang_sign_b"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_gang_sign_b", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_gang_sign_b", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'hayir' then
				local ad = "mp_player_int_upper_nod"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_nod_no", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_nod_no", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'kasi' then
				local ad = "mp_player_int_upperarse_pick"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_arse_pick", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_arse_pick", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'kasi2' then
				local ad = "mp_player_int_uppergrab_crotch"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_grab_crotch", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_grab_crotch", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'peace' then
				local ad = "mp_player_int_upperpeace_sign"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "mp_player_int_peace_sign", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "mp_player_int_peace_sign", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'puro' then
				local cigar_name = cigar_name or 'prop_cigar_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.0001, 0.003, 55.0, 0.0, -85.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'puro2' then
				local cigar_name = cigar_name or 'prop_cigar_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.0001, 0.003, 55.0, 0.0, -85.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'esrar' then
				local cigar_name = cigar_name or 'p_cs_joint_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.009, 0.003, 55.0, 0.0, 110.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'sigara' then
				local cigar_name = cigar_name or 'prop_amb_ciggy_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 47419), 0.015, -0.009, 0.003, 55.0, 0.0, 110.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'purotut' then
				local cigar_name = cigar_name or 'prop_cigar_03' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.045, -0.05, -0.010, -75.0, 0.0, 65.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'sigaratut' then
				local cigar_name = cigar_name or 'prop_amb_ciggy_01' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'esrartut' then
				local cigar_name = cigar_name or 'p_cs_joint_02' --noprop
				local playerPed = PlayerPedId()
				
				if ( DoesEntityExist( playerPed ) and not IsEntityDead( playerPed )) then 
					if IsCigar then
						Wait(500)
						DetachEntity(cigar, 1, 1)
						DeleteObject(cigar)
						IsCigar = false
					else
						IsCigar = true
						Wait(500)
						local x,y,z = table.unpack(GetEntityCoords(playerPed))
						cigar = CreateObject(GetHashKey(cigar_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(cigar, playerPed, GetPedBoneIndex(playerPed, 26611), 0.035, -0.01, -0.010, 100.0, 0.0, -100.0, true, true, false, true, 1, true)
					end     
				end
			elseif argh == 'ol' then
				local ad = "misslamar1dead_body"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "dead_idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "dead_idle", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'tut' then
				local ad = "move_m@intimidation@cop@unarmed"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'aim' then
				local ad = "move_weapon@pistol@copa"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end
			elseif argh == 'aim2' then
				local ad = "move_weapon@pistol@cope"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "idle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end

			elseif argh == 'koruma' then
				local ad = "rcmepsilonism8"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "base_carrier", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "base_carrier", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end     
				end

			elseif argh == 'kutu' then
				local ad = "anim@heists@box_carry@"
				
				local prop_name = prop_name or 'hei_prop_heist_box'
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "idle", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						Wait(1000)
						ClearPedSecondaryTask(PlayerPedId())
					else
						local x,y,z = table.unpack(GetEntityCoords(player))
						prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
						AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.025, 0.08, 0.255, -145.0, 290.0, 0.0, true, true, false, true, 1, true)
						TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
					end 
				end
			elseif argh == 'alkis' then
				local ad = "anim@mp_player_intcelebrationmale@slow_clap"
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
						loadAnimDict( ad )
						if ( IsEntityPlayingAnim( player, ad, "slow_clap", 3 ) ) then 
							TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
							ClearPedSecondaryTask(player)
							Wait (100)
						else
							TaskPlayAnim( player, ad, "slow_clap", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
							Wait (500)
						end       
					end
				end

			elseif argh == 'alkis2' then
				local ad = "amb@world_human_cheering@male_a"
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
						loadAnimDict( ad )
						if ( IsEntityPlayingAnim( player, ad, "base", 3 ) ) then 
							TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
							ClearPedSecondaryTask(player)
							Wait (100)
						else
							TaskPlayAnim( player, ad, "base", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
							Wait (500)
						end       
					end
				end

			elseif argh == 'yat' then
				local ad = "amb@lo_res_idles@"
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "world_human_bum_slumped_left_lo_res_base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "world_human_bum_slumped_left_lo_res_base", 5.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'uzan' then
				local ad = "amb@lo_res_idles@"
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "world_human_lean_male_foot_up_lo_res_base", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (100)
					else
						TaskPlayAnim( player, ad, "world_human_lean_male_foot_up_lo_res_base", 8.0, 1.0, -1, 33, 0, 0, 0, 0 )
						Wait (500)
					end     
				end
			elseif argh == 'sakin' then
				local ad = "amb@code_human_police_crowd_control@idle_a" --- insert the animation dic here
				local anim = "idle_a" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'ilkyardim' then
				local ad = "mini@cpr@char_a@cpr_def" --- insert the animation dic here
				local anim = "cpr_intro" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'dans' then
				local ad = "anim@amb@nightclub@dancers@crowddance_facedj@" --- insert the animation dic here
				local anim = "hi_dance_facedj_09_v1_female^1" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'dans1' then
				local ad = "anim@amb@nightclub@dancers@crowddance_facedj@" --- insert the animation dic here
				local anim = "hi_dance_facedj_09_v1_male^1" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'dans2' then
				local ad = "anim@amb@nightclub@dancers@crowddance_facedj@" --- insert the animation dic here
				local anim = "hi_dance_facedj_09_v1_male^2" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'dans3' then
				local ad = "anim@amb@nightclub@dancers@crowddance_facedj@" --- insert the animation dic here
				local anim = "hi_dance_facedj_09_v2_male^1" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'dans4' then
				local ad = "anim@amb@nightclub@dancers@crowddance_facedj@" --- insert the animation dic here
				local anim = "hi_dance_facedj_11_v1_female^2" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'dans5' then
				local ad = "anim@amb@nightclub@dancers@crowddance_facedj@" --- insert the animation dic here
				local anim = "hi_dance_facedj_11_v1_male^5" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'dans6' then
				local ad = "anim@amb@nightclub@dancers@crowddance_facedj@" --- insert the animation dic here
				local anim = "hi_dance_facedj_11_v2_male^2" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				elseif argh == 'dans7' then
				local ad = "anim@amb@nightclub@dancers@crowddance_facedj@" --- insert the animation dic here
				local anim = "mi_dance_facedj_11_v1_male^1" --- insert the animation name here
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
			elseif argh == 'sakin2' then
				local ad = "amb@code_human_police_crowd_control@idle_b" --- insert the animation dic here
				local anim = "idle_d" --- insert the animation name here
				local player = PlayerPedId()
				
			
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
						ClearPedSecondaryTask(player)
					else
						TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
					end       
				end
				
			elseif argh == 'bel' then

				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
					if IsPedActiveInScenario(player) then
						ClearPedTasks(player)
					else
						TaskStartScenarioInPlace(player, 'WORLD_HUMAN_COP_IDLES', 0, 1)   
					end 
				end
			end
		end
	end
end, false)

----Use /testanimation command, you can use this to easily test new animations---

RegisterCommand("testanimation",function(source, args)

	local ad = "amb@prop_human_seat_chair_mp@male@generic@enter" --- insert the animation dic here
	local anim = "enter_forward" --- insert the animation name here
	local player = PlayerPedId()
	

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		TriggerEvent('chatMessage', '^2 Testing Animation')
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

	
----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ functions -----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function(prop_name, secondaryprop_name)
	while true do
		Citizen.Wait(500)
		if IsPedRagdoll(PlayerPedId()) then 
			local playerPed = PlayerPedId()
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			DetachEntity(secondaryprop, 1, 1)
			DeleteObject(secondaryprop)
		end
	end
end)	

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end


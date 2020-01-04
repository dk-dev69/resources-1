ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

-- PLAYER = 0x6F0783F5
-- CIVMALE = 0x02B8FA80
-- CIVFEMALE = 0x47033600
-- COP = 0xA49E591C
-- SECURITY_GUARD = 0xF50B51B7
-- PRIVATE_SECURITY = 0xA882EB57
-- FIREMAN = 0xFC2CA767
-- GANG_1 = 0x4325F88A
-- GANG_2 = 0x11DE95FC
-- GANG_9 = 0x8DC30DC3
-- GANG_10 = 0x0DBF2731
-- AMBIENT_GANG_LOST = 0x90C7DA60
-- AMBIENT_GANG_MEXICAN = 0x11A9A7E3
-- AMBIENT_GANG_FAMILY = 0x45897C40
-- AMBIENT_GANG_BALLAS = 0xC26D562A
-- AMBIENT_GANG_MARABUNTE = 0x7972FFBD
-- AMBIENT_GANG_CULT = 0x783E3868
-- AMBIENT_GANG_SALVA = 0x936E7EFB
-- AMBIENT_GANG_WEICHENG = 0x6A3B9F86
-- AMBIENT_GANG_HILLBILLY = 0xB3598E9C
-- DEALER = 0x8296713E
-- HATES_PLAYER = 0x84DCFAAD
-- HEN = 0xC01035F9
-- WILD_ANIMAL = 0x7BEA6617
-- SHARK = 0x229503C8
-- COUGAR = 0xCE133D78
-- NO_RELATIONSHIP = 0xFADE4843
-- SPECIAL = 0xD9D08749
-- MISSION2 = 0x80401068
-- MISSION3 = 0x49292237
-- MISSION4 = 0x5B4DC680
-- MISSION5 = 0x270A5DFA
-- MISSION6 = 0x392C823E
-- MISSION7 = 0x024F9485
-- MISSION8 = 0x14CAB97B
-- ARMY = 0xE3D976F3
-- GUARD_DOG = 0x522B964A
-- AGGRESSIVE_INVESTIGATE = 0xEB47D4E0
-- MEDIC = 0xB0423AA0
-- PRISONER = 0x7EA26372
-- DOMESTIC_ANIMAL = 0x72F30F6E
-- DEER = 0x31E50E10


-- AMBIENT_GANG_LOST -- The Lost MC
-- AMBIENT_GANG_MEXICAN -- Los Santos Vagos
-- AMBIENT_GANG_FAMILY -- The Families
-- AMBIENT_GANG_BALLAS -- Ballas
-- AMBIENT_GANG_MARABUNTE -- Marabunta Grande
-- AMBIENT_GANG_CULT -- Altruist Cult
-- AMBIENT_GANG_SALVA -- Varrios Los Aztecas
-- AMBIENT_GANG_WEICHENG -- Los Santos Triads
-- AMBIENT_GANG_HILLBILLY -- Rednecks

local relationshipPolice = {
"COP",
"SECURITY_GUARD",
"PRIVATE_SECURITY",
"FIREMAN",
-- "GANG_1",
-- "GANG_2",
-- "GANG_9",
-- "GANG_10",
-- "AMBIENT_GANG_LOST",
-- "AMBIENT_GANG_MEXICAN",
-- "AMBIENT_GANG_FAMILY",
-- "AMBIENT_GANG_BALLAS",
-- "AMBIENT_GANG_MARABUNTE",
-- "AMBIENT_GANG_CULT",
-- "AMBIENT_GANG_SALVA",
-- "AMBIENT_GANG_WEICHENG",
-- "AMBIENT_GANG_HILLBILLY",
"COUGAR",
"SPECIAL",
"ARMY",
"MEDIC",
"FIREMAN"
}

local relationshipCartel = {
"AMBIENT_GANG_MEXICAN"
}

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(50)

		if (PlayerData.job ~= nil and (PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'fbi' or PlayerData.job.name ~= 'ambulance')) then
		-- Типы отношений:
		-- 0 = компаньон
		-- 1 = уважение
		-- 2 = лайк
		-- 3 = нейтральный
		-- 4 = Не нравится
		-- 5 = Ненависть
		-- 255 = пешеходы
			for _, group in ipairs(relationshipPolice) do
			
				SetRelationshipBetweenGroups(1, GetHashKey('PLAYER'), GetHashKey(group))
				SetRelationshipBetweenGroups(1, GetHashKey(group), GetHashKey('PLAYER'))
			end
		end
		if PlayerData.job ~= nil and PlayerData.job.name ~= 'cartel' then
				SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), GetHashKey('COP'))
				SetRelationshipBetweenGroups(5, GetHashKey('COP'), GetHashKey('PLAYER'))
				SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), GetHashKey('ARMY'))
				SetRelationshipBetweenGroups(5, GetHashKey('ARMY'), GetHashKey('PLAYER'))
				
				for _, group in ipairs(relationshipCartel) do
					SetRelationshipBetweenGroups(1, GetHashKey('PLAYER'), GetHashKey(group))
					SetRelationshipBetweenGroups(1, GetHashKey(group), GetHashKey('PLAYER'))
				end
		end
	
	
        -- if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
            -- local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
            -- if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
                -- if (PlayerData.job ~= nil and (PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'fbi')) then
                  -- ESX.ShowNotification("Полицейский транспорт ~r~не предназначен ~w~для гражданских")
                  -- SetVehicleUndriveable(veh, true)
                -- end
            -- end
        -- end
    end
end)

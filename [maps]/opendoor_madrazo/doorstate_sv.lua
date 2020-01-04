lockState = {}
--allowedtouse = {"cartel","police"}

--if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' and PlayerData.job.name == "police" then

--
RegisterServerEvent('OD:updateState')
AddEventHandler('OD:updateState', function(doorID, state)
    --
        --local Job 
        -- ids = GetPlayerIdentifiers(source)
        -- for i,theIdentifier in ipairs(ids) do
            -- if string.find(theIdentifier,"Job:") or -1 > -1 then
                -- Job = theIdentifier
            -- end
        -- end
       --if PlayerData.job.name ~= nil or PlayerData.job.name == "police" or PlayerData.job.name == "cartel" then
            -- local canuse = false
            -- for i=1, #allowedtouse do
                -- if allowedtouse[i] == Job then
                    -- canuse = true
                -- end
            -- end
            -- if canuse then
                -- make each door a table, and clean it when toggled
                lockState[doorID] = {}
                -- assign information
                lockState[doorID].state = state
                lockState[doorID].doorID = doorID
                TriggerClientEvent('OD:state', -1, doorID, state)
            ---end
        --end
end)
RegisterServerEvent('viticulteurcompany:sv_getJobId')
AddEventHandler('viticulteurcompany:sv_getJobId',
  function()
    TriggerClientEvent('viticulteurcompany:cl_setJobId', source, GetJobId(source))
  end
)

RegisterServerEvent('viticulteurcompany:sv_setService')
AddEventHandler('viticulteurcompany:sv_setService',
  function(service)
    TriggerEvent('es:getPlayerFromId', source,
      function(user)
        local executed_query = MySQL.Async.execute("UPDATE users SET enService = @service WHERE users.identifier = '@identifier'", {['@identifier'] = user.identifier, ['@service'] = service})
      end
    )
  end
)



function GetJobId(source)
  local jobId = -1

  TriggerEvent('es:getPlayerFromId', source,
  
  -- function(user)
    -- local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        -- ['@identifier'] = identifier
    -- })
    -- if result[1] ~= nil then
        -- return result[1].phone_number
    -- end
    -- return nil
    -- end
  
  
  
    function(user)
      local result = MySQL.Sync.fetchAll("SELECT identifier, job FROM users WHERE users.identifier = '@identifier' ", {
	  ['@identifier'] = user.identifier
	  })
      --local result = MySQL:getResults(executed_query, {'job'}, "identifier")

      if (result[1] ~= nil) then
        jobId = tonumber(result[1].job)
      end
    end
  )

  return tonumber(jobId)
end


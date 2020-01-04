ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_joblisting:getJobsList', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier2 = GetPlayerIdentifiers(source)[1]
	local identifier = xPlayer.identifier
	
	MySQL.Async.fetchAll('SELECT * FROM jobs WHERE whitelisted = @whitelisted', {
		['@whitelisted'] = false
	}, function(result)
		local data = {}

		for i=1, #result, 1 do
			table.insert(data, {
				job   = result[i].name,
				label = result[i].label
			})
		end
		
		getID(identifier2, function(ranks)
			if ranks.ems_rank > -1 then
				table.insert(data, {
					job = "ambulance",
					label = "EMS"
				})
			end
			
			if ranks.leo_rank > -1 then
				table.insert(data, {
					job = "police",
					label = "LEO"
				})
			end
			
			if ranks.tow_rank > -1 then
				table.insert(data, {
					job = "mecano",
					label = "Mechanic"
				})
			end
			
			cb(data)
		end)
	end)
end)

RegisterServerEvent('esx_joblisting:setJob')
AddEventHandler('esx_joblisting:setJob', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	function injection()
		print(('esx_joblisting: %s attempted to set a whitelisted job! (lua injector)'):format(xPlayer.identifier))
	end

	MySQL.Async.fetchAll('SELECT whitelisted FROM jobs WHERE name = @name', {
		['@name'] = job,
	}, function(result)
		if not result[1].whitelisted then
			xPlayer.setJob(job, 0)
		elseif job == "ambulance" then
			getID(xPlayer.identifier, function(ranks)
				if ranks.ems_rank then
					xPlayer.setJob(job, ranks.ems_rank)
				else
					injection()
				end
			end)
		elseif job == "mecano" then
			getID(xPlayer.identifier, function(ranks)
				if ranks.tow_rank then
					xPlayer.setJob(job, ranks.tow_rank)
				else
					injection()
				end
			end)
		elseif job == "police" then
			getID(xPlayer.identifier, function(ranks)
				if ranks.leo_rank then
					xPlayer.setJob(job, ranks.leo_rank)
				else
					injection()
				end
			end)
		else
			injection()
		end
		
	end)

end)

function getID(identifier, callback)
  MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier",
  {
    ['@identifier'] = identifier
  },
  function(result)
    if result[1] ~= nil then
      local data2 = {
        identifier	= steamid,
        firstname	= result[1]['firstname'],
        lastname	= result[1]['lastname'],
      }
	  
	  return getJobRanks(identifier,data2.firstname,data2.lastname,callback)
    end
end)
end
function getJobRanks(identifier, firstname, lastname, cb)
  MySQL.Async.fetchAll("SELECT * FROM characters WHERE identifier = @identifier AND firstname = @firstname AND lastname = @lastname",
  {
    ['@identifier'] = identifier,
	['@firstname']  = firstname,
	['@lastname']   = lastname
  },

    function(results)
	
    if results[1] ~= nil then
      local data3 = {
		ems_rank    = results[1]['ems_rank'],
		leo_rank    = results[1]['leo_rank'],
		tow_rank    = results[1]['tow_rank'],
      }
	  
	  cb(data3)
    end
  end)
end
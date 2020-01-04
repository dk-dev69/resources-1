local DataStores, DataStoresIndex, SharedDataStores = {}, {}, {}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	loadDataStore()
end)

function loadDataStore()
	local datastores = MySQL.Sync.fetchAll('SELECT * FROM datastore')

	for i=1, #datastores, 1 do
		local name   = datastores[i].name
		local label  = datastores[i].label
		local shared = datastores[i].shared

		local datastoreData = MySQL.Sync.fetchAll('SELECT * FROM datastore_data WHERE name = @name', {
			['@name'] = name
		})
		--print(name)
		if shared == 0 then
			table.insert(DataStoresIndex, name)
			DataStores[name] = {}

			for j=1, #datastoreData, 1 do
				local storeName  = datastoreData[j].name
				local storeOwner = datastoreData[j].owner
				local storeData  = (datastoreData[j].data == nil and {} or json.decode(datastoreData[j].data))
				local dataStore  = CreateDataStore(storeName, storeOwner, storeData)

				table.insert(DataStores[name], dataStore)
			end
		else
			local data = nil

			if #datastoreData == 0 then
				MySQL.Sync.execute('INSERT INTO datastore_data (name, owner, data) VALUES (@name, NULL, \'{}\')', {
					['@name'] = name
				})

				data = {}
			else
				data = json.decode(datastoreData[1].data)
			end

			local dataStore = CreateDataStore(name, nil, data)
			SharedDataStores[name] = dataStore
		end
	end
end

function RegisterSharedDataStore(name, label)
	MySQL.ready(function()
		local result = MySQL.Sync.fetchAll('SELECT * FROM datastore WHERE name = @name', {
			['@name'] = name
		})
		if result[1] then
			print(('esx_datastore: Datastore %s <%s> (owner: %s) registred'):format(label, name, owner))
		else
			MySQL.Sync.execute('INSERT INTO datastore (name, label, shared) VALUES (@name, @label, 1)', {
				['@name'] = name,
				['@label'] = label
			})
			MySQL.Sync.execute('INSERT INTO datastore_data (name, owner, data) VALUES (@name, NULL, \'{}\')', {
				['@name'] = name
			})
			local dataStore = CreateDataStore(name, nil, {})
			SharedDataStores[name] = dataStore
			print(('esx_datastore: Datastore %s <%s> (owner: %s) created on the database'):format(label, name, owner))
		end
	end)
end

function GetDataStore(name, owner)
	for i=1, #DataStores[name], 1 do
		if DataStores[name][i].owner == owner then
			return DataStores[name][i]
		end
	end
end

function GetDataStoreOwners(name)
	local identifiers = {}

	for i=1, #DataStores[name], 1 do
		table.insert(identifiers, DataStores[name][i].owner)
	end

	return identifiers
end

function GetSharedDataStore(name)
	return SharedDataStores[name]
end

AddEventHandler('esx_datastore:registerSharedDataStore', function(name, owner)
	RegisterSharedDataStore(name, owner)
end)

AddEventHandler('esx_datastore:getDataStore', function(name, owner, cb)
	cb(GetDataStore(name, owner))
end)

AddEventHandler('esx_datastore:getDataStoreOwners', function(name, cb)
	cb(GetDataStoreOwners(name))
end)

AddEventHandler('esx_datastore:getSharedDataStore', function(name, cb)
	cb(GetSharedDataStore(name))
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	local dataStores = {}

	for i=1, #DataStoresIndex, 1 do
		local name      = DataStoresIndex[i]
		local dataStore = GetDataStore(name, xPlayer.identifier)

		if dataStore == nil then
			MySQL.Async.execute('INSERT INTO datastore_data (name, owner, data) VALUES (@name, @owner, @data)', {
				['@name']  = name,
				['@owner'] = xPlayer.identifier,
				['@data']  = '{}'
			})

			dataStore = CreateDataStore(name, xPlayer.identifier, {})
			table.insert(DataStores[name], dataStore)
		end

		table.insert(dataStores, dataStore)
	end

	xPlayer.set('dataStores', dataStores)
end)
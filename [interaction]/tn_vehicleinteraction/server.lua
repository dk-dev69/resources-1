ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('Test')
AddEventHandler('Test', function(timer, weapon, rem)
    TriggerClientEvent('startT', -1, timer, weapon, rem, source)
end)
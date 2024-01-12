ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ox_inventory = exports.ox_inventory
local GetCurrentResourceName = GetCurrentResourceName()

RegisterNetEvent('ox:BongoStashFamillies', function()
	ox_inventory:RegisterStash('BongoStashFamillies', 'Stash', 20, 20000, true)
end)

RegisterNetEvent('ox:GiveKeyCoffreFamillies', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	exports.ox_inventory:AddItem(source, 'key', 1, {description = 'Famillies'}, nil)
end)

RegisterNetEvent('ox:CoffreFortFamillies', function()
	ox_inventory:RegisterStash('Famillies', 'Coffre-Fort', 10, 50000, false)
	MySQL:saveStash(inv.owner, inv.dbId, inventory)
end)
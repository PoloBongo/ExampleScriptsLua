ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ox_inventory = exports.ox_inventory
local GetCurrentResourceName = GetCurrentResourceName()

RegisterNetEvent('ox:BongoStashBallas', function()
	ox_inventory:RegisterStash('BongoStashBallas', 'Stash', 20, 20000, true)
end)

RegisterNetEvent('ox:GiveKeyCoffreBallas', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	exports.ox_inventory:AddItem(source, 'key', 1, {description = 'Ballas'}, nil)
end)

RegisterNetEvent('ox:CoffreFortBallas', function()
	ox_inventory:RegisterStash('Ballas', 'Coffre-Fort', 10, 50000, false)
	MySQL:saveStash(inv.owner, inv.dbId, inventory)
end)
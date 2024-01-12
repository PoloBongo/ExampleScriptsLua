ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local ox_inventory = exports.ox_inventory
local GetCurrentResourceName = GetCurrentResourceName()

RegisterNetEvent('ox:BongoStashVagos', function()
	ox_inventory:RegisterStash('BongoStashVagos', 'Stash', 20, 20000, true)
end)

RegisterNetEvent('ox:GiveKeyCoffreVagos', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	exports.ox_inventory:AddItem(source, 'key', 1, {description = 'Vagos'}, nil)
end)

RegisterNetEvent('ox:CoffreFortVagos', function()
	ox_inventory:RegisterStash('Vagos', 'Coffre-Fort', 10, 50000, false)
	MySQL:saveStash(inv.owner, inv.dbId, inventory)
end)
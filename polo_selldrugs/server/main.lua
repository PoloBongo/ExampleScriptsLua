ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('TireEntenduServeurDrogues')
AddEventHandler('TireEntenduServeurDrogues', function(gx, gy, gz)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('TireEntenduDrogues', xPlayers[i], gx, gy, gz)
		end
	end
end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('polobongo:drugs')
AddEventHandler('polobongo:drugs', function()

	local xPlayer = ESX.GetPlayerFromId(source)
	local item_weed = 'weed_pooch'
	local item_coke = 'coke_pooch'
	local item_opium = 'opium_pooch'
	local item_jewels = 'jewels'
	if CopsConnected >= 1 then
		if xPlayer.getInventoryItem(item_weed).count > 1 then
    		local item = 'black_money'
    		local count = math.random(200, 250)
         
    		xPlayer.addInventoryItem(item, count)
			xPlayer.removeInventoryItem(item_weed, 1)
		elseif xPlayer.getInventoryItem(item_coke).count > 1 then
			local item = 'black_money'
			local count = math.random(300, 350)
	 
			xPlayer.addInventoryItem(item, count)
			xPlayer.removeInventoryItem(item_coke, 1)
		elseif xPlayer.getInventoryItem(item_opium).count > 1 then
			local item = 'black_money'
			local count = math.random(350, 400)
	 
			xPlayer.addInventoryItem(item, count)
			xPlayer.removeInventoryItem(item_opium, 1)
		elseif xPlayer.getInventoryItem(item_jewels).count > 1 then
			local item = 'black_money'
			local count = math.random(600, 700)
	 
			xPlayer.addInventoryItem(item, count)
			xPlayer.removeInventoryItem(item_jewels, 1)
		end
	else
		TriggerClientEvent('okokNotify:Alert', source, "Notification", "At least one police officer is required in the city!", 7500, 'info')
	end
end)
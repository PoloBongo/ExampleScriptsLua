ESX = nil
local PlayersSellBucheron = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('polo_3job:GiveItemBucheron')
AddEventHandler('polo_3job:GiveItemBucheron', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local quantity = xPlayer.getInventoryItem(Config.ZonesBucheron.SellBucheron.ItemRequires).count

	if quantity >= 20 then
		TriggerClientEvent('esx:showNotification', _source, _U('stop_npc'))
		return
	else
		local amount = Config.ZonesBucheron.SellBucheron.ItemAdd
		local item = Config.ZonesBucheron.SellBucheron.ItemDb_name

		xPlayer.addInventoryItem(item, amount)
		TriggerClientEvent('esx:showNotification', _source, 'Vous avez vidé ~g~x' .. amount .. ' DAB')
		Wait(3000)
		TriggerClientEvent('esx:showNotification', _source, 'Va à l\'arrière du camion pour déposer le Bois')
	end
end)

local function Transform(source, zone)
if PlayersTransforming[source] == true then
	local xPlayer  = ESX.GetPlayerFromId(source)
	elseif zone == "TraitementBois" then
		local itemQuantity = xPlayer.getInventoryItem('bois').count

		if itemQuantity <= 0 then
			TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de bois')
			return
		else
			SetTimeout(1800, function()
				xPlayer.removeInventoryItem('bois', 5)
				xPlayer.addInventoryItem('planchebois', 5)
				Transform(source, zone)	  
			end)
		end
	end
end

RegisterServerEvent('polo_3job:startTransform')
AddEventHandler('polo_3job:startTransform', function(zone)
	local _source = source

	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, 'Attendez')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, 'Vous fabriquez des Planche à Bois') 
		Transform(_source,zone)
	end
end)



RegisterServerEvent('polo_3job:stopTransform')
AddEventHandler('polo_3job:stopTransform', function()
	local _source = source

	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Attendez ~r~30 secondes avant de revenir en zone de transformation')
	else
		--TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre malt')
		PlayersTransforming[_source]=true
	end
end)

local function SellBucheron(source)
	SetTimeout(Config.ZonesBucheron.SellBucheron.ItemTime, function()
		if PlayersSellBucheron[source] == true then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local quantity = xPlayer.getInventoryItem(Config.ZonesBucheron.SellBucheron.ItemRequires).count

			if quantity < Config.ZonesBucheron.SellBucheron.ItemRemove then
				TriggerClientEvent('esx:showNotification', _source, '~r~Vous n\'avez plus de Planches de Bois !')
				PlayersSellBucheron[_source] = false
			else
				local amount = Config.ZonesBucheron.SellBucheron.ItemRemove
				local item = Config.ZonesBucheron.SellBucheron.ItemRequires

				xPlayer.removeInventoryItem(item, amount)
				xPlayer.addMoney(Config.ZonesBucheron.SellBucheron.ItemPrice)
				TriggerClientEvent('esx:showNotification', _source, 'Vous avez reçu ~g~$' .. Config.ZonesBucheron.SellBucheron.ItemPrice)
				SellBucheron(_source)
			end
		end
	end)
end

RegisterServerEvent('polo_3job:startSellBucheron')
AddEventHandler('polo_3job:startSellBucheron', function()
	local _source = source

	if PlayersSellBucheron[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Sortez et revenez dans la zone !')
		PlayersSellBucheron[_source] = false
	else
		PlayersSellBucheron[_source] = true
		TriggerClientEvent('esx:showNotification', _source, '~g~Action ~w~en cours...')
		SellBucheron(_source)
	end
end)

RegisterServerEvent('polo_3job:stopSellBucheron')
AddEventHandler('polo_3job:stopSellBucheron', function()
	local _source = source

	if PlayersSellBucheron[_source] == true then
		PlayersSellBucheron[_source] = false
	else
		PlayersSellBucheron[_source] = true
	end
end)
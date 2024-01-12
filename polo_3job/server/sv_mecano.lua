ESX                = nil
PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'mecano', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'mecano', _U('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'mecano', 'Mecano', 'society_mecano', 'society_mecano', 'society_mecano', {type = 'public'})

-------------- Récupération bouteille de gaz -------------
---- Sqlut je teste ------
local function Harvest(source)

  SetTimeout(4000, function()

    if PlayersHarvesting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

      if GazBottleQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('gazbottle', 1)

        Harvest(source)
      end
    end
  end)
end

RegisterServerEvent('polo_3job:startHarvest')
AddEventHandler('polo_3job:startHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_gas_can'))
  Harvest(source)
end)

RegisterServerEvent('PersonneProximite') -- Notif moi personne à proximité
AddEventHandler('PersonneProximite', function()
    local _source = source
    local identifier = ""
    local identifier = GetPlayerIdentifiers(_source)[1]

    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Annonce', '~r~ERREUR', '~r~Personne à proximité.', 'CHAR_BLOCKED', 8)
end)

RegisterServerEvent('polo_3job:stopHarvest')
AddEventHandler('polo_3job:stopHarvest', function()
  local _source = source
  PlayersHarvesting[_source] = false
end)
------------ Récupération Outils Réparation --------------
local function Harvest2(source)

  SetTimeout(4000, function()

    if PlayersHarvesting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local FixToolQuantity  = xPlayer.getInventoryItem('fixtool').count
      if FixToolQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('fixtool', 1)

        Harvest2(source)
      end
    end
  end)
end

RegisterServerEvent('polo_3job:startHarvest2')
AddEventHandler('polo_3job:startHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_repair_tools'))
  Harvest2(_source)
end)

RegisterServerEvent('polo_3job:stopHarvest2')
AddEventHandler('polo_3job:stopHarvest2', function()
  local _source = source
  PlayersHarvesting2[_source] = false
end)
----------------- Récupération Outils Carosserie ----------------
local function Harvest3(source)

  SetTimeout(4000, function()

    if PlayersHarvesting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('carotool').count
            if CaroToolQuantity >= 5 then
        TriggerClientEvent('esx:showNotification', source, _U('you_do_not_room'))
      else
                xPlayer.addInventoryItem('carotool', 1)

        Harvest3(source)
      end
    end
  end)
end

RegisterServerEvent('polo_3job:startHarvest3')
AddEventHandler('polo_3job:startHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('recovery_body_tools'))
  Harvest3(_source)
end)

RegisterServerEvent('polo_3job:stopHarvest3')
AddEventHandler('polo_3job:stopHarvest3', function()
  local _source = source
  PlayersHarvesting3[_source] = false
end)
------------ Craft Chalumeau -------------------
local function Craft(source)

  SetTimeout(4000, function()

    if PlayersCrafting[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

      if GazBottleQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_gas_can'))
      else
                xPlayer.removeInventoryItem('gazbottle', 1)
                xPlayer.addInventoryItem('blowpipe', 1)

        Craft(source)
      end
    end
  end)
end

RegisterServerEvent('polo_3job:startCraft')
AddEventHandler('polo_3job:startCraft', function()
  local _source = source
  PlayersCrafting[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
  Craft(_source)
end)

RegisterServerEvent('polo_3job:stopCraft')
AddEventHandler('polo_3job:stopCraft', function()
  local _source = source
  PlayersCrafting[_source] = false
end)
------------ Craft kit Réparation --------------
local function Craft2(source)

  SetTimeout(4000, function()

    if PlayersCrafting2[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local FixToolQuantity  = xPlayer.getInventoryItem('fixtool').count
      if FixToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_repair_tools'))
      else
                xPlayer.removeInventoryItem('fixtool', 1)
                xPlayer.addInventoryItem('fixkit', 1)

        Craft2(source)
      end
    end
  end)
end

RegisterServerEvent('polo_3job:startCraft2')
AddEventHandler('polo_3job:startCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_blowtorch'))
  Craft2(_source)
end)

RegisterServerEvent('polo_3job:stopCraft2')
AddEventHandler('polo_3job:stopCraft2', function()
  local _source = source
  PlayersCrafting2[_source] = false
end)
----------------- Craft kit Carosserie ----------------
local function Craft3(source)

  SetTimeout(4000, function()

    if PlayersCrafting3[source] == true then

      local xPlayer  = ESX.GetPlayerFromId(source)
      local CaroToolQuantity  = xPlayer.getInventoryItem('carotool').count
            if CaroToolQuantity <= 0 then
        TriggerClientEvent('esx:showNotification', source, _U('not_enough_body_tools'))
      else
                xPlayer.removeInventoryItem('carotool', 1)
                xPlayer.addInventoryItem('carokit', 1)

        Craft3(source)
      end
    end
  end)
end

RegisterServerEvent('polo_3job:startCraft3')
AddEventHandler('polo_3job:startCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = true
  TriggerClientEvent('esx:showNotification', _source, _U('assembling_body_kit'))
  Craft3(_source)
end)

RegisterServerEvent('polo_3job:stopCraft3')
AddEventHandler('polo_3job:stopCraft3', function()
  local _source = source
  PlayersCrafting3[_source] = false
end)

---------------------------- NPC Job Earnings ------------------------------------------------------

RegisterServerEvent('polo_3job:onNPCJobMissionCompleted')
AddEventHandler('polo_3job:onNPCJobMissionCompleted', function()

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

  if xPlayer.job.grade >= 3 then
    total = total * 2
  end

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mecano', function(account)
    account.addMoney(total)
  end)

  TriggerClientEvent("esx:showNotification", _source, _U('your_comp_earned').. total)

end)

---------------------------- register usable item --------------------------------------------------
ESX.RegisterUsableItem('blowpipe', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('blowpipe', 1)

  TriggerClientEvent('polo_3job:onHijack', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_blowtorch'))

end)

ESX.RegisterUsableItem('fixkit', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('fixkit', 1)

  TriggerClientEvent('polo_3job:onFixkit', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_repair_kit'))

end)

ESX.RegisterUsableItem('carokit', function(source)

  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)

  xPlayer.removeInventoryItem('carokit', 1)

  TriggerClientEvent('polo_3job:onCarokit', _source)
    TriggerClientEvent('esx:showNotification', _source, _U('you_used_body_kit'))

end)

----------------------------------
---- Ajout Gestion Stock Boss ----
----------------------------------

RegisterServerEvent('polo_3job:getStockItem')
AddEventHandler('polo_3job:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('polo_3job:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)
    cb(inventory.items)
  end)

end)

-------------
-- AJOUT 2 --
-------------

RegisterServerEvent('polo_3job:putStockItems')
AddEventHandler('polo_3job:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mecano', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= 0 then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

  end)

end)

RegisterServerEvent('polo_3job:putInVehiclebongo')
AddEventHandler('polo_3job:putInVehiclebongo', function(target)
  local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('polo_3job:putInVehiclebongo', target)
end)

RegisterServerEvent('polo_3job:OutVehiclebongo')
AddEventHandler('polo_3job:OutVehiclebongo', function(target)
  local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('polo_3job:OutVehiclebongo', target)
end)
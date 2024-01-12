ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('achatitem:fleeca_1')
AddEventHandler('achatitem:fleeca_1', function(fleeca1, money)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = 300
    local account = 'money'
    local item = 'drill'
    local count = 1

    
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeAccountMoney(account, money)
        xPlayer.addInventoryItem(item, count)


end)

RegisterServerEvent('achatitem:fleeca_2')
AddEventHandler('achatitem:fleeca_2', function(fleeca2)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = 200
    local account = 'money'
    local item = 'hackerdevice'
    local count = 1

    
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeAccountMoney(account, money)
        xPlayer.addInventoryItem(item, count)


end)

-------------------------------------------------------------- ACHAT ITEM ------------------------------------------

RegisterServerEvent('achatitem:drugs_1')
AddEventHandler('achatitem:drugs_1', function(drugs1, money)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = 5
    local account = 'money'
    local item = 'red_seed'
    local count = 1

    
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeAccountMoney(account, money)
        xPlayer.addInventoryItem(item, count)


end)

RegisterServerEvent('achatitem:drugs_2')
AddEventHandler('achatitem:drugs_2', function(drugs2)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = 2
    local account = 'money'
    local item = 'red_coke'
    local count = 1

    
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeAccountMoney(account, money)
        xPlayer.addInventoryItem(item, count)


end)

RegisterServerEvent('achatitem:drugs_3')
AddEventHandler('achatitem:drugs_3', function(drugs3)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = 5
    local account = 'money'
    local item = 'red_opium'
    local count = 1

    
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeAccountMoney(account, money)
        xPlayer.addInventoryItem(item, count)


end)
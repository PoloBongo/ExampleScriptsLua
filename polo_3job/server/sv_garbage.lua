ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

RegisterNetEvent('polo_3job:pay2')

AddEventHandler('polo_3job:pay2', function(jobStatus)

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    if jobStatus then

        if xPlayer ~= nil then

            local randomMoney = math.random(100,300)

            xPlayer.addMoney(randomMoney)

            local cash = xPlayer.getMoney()

            TriggerClientEvent('banking:updateCash', _source, cash)

            TriggerEvent('garbagePay:logs',_source,xPlayer.getName(),randomMoney)

        end

    else

        print("Probably a cheater: ",xPlayer.getName())

    end

end)

RegisterServerEvent("polo:moneyu")
AddEventHandler("polo:moneyu", function(item, label, money, count)

    local xPlayer = ESX.GetPlayerFromId(source)
    local randomMoney = math.random(200,450)

    if xPlayer ~= nil then 
        xPlayer.addMoney(randomMoney)
    end
end)

RegisterNetEvent('polo_3job:pay')

AddEventHandler('polo_3job:pay', function(jobStatus)

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    if jobStatus then

        if xPlayer ~= nil then

            local randomMoney = math.random(100,300)

            xPlayer.addMoney(randomMoney)

            local cash = xPlayer.getMoney()

            TriggerClientEvent('banking:updateCash', _source, cash)

            TriggerEvent('garbagePay:logs',_source,xPlayer.getName(),randomMoney)

        end

    else

        print("Probably a cheater: ",xPlayer.getName())

    end

end)





RegisterNetEvent('polo_3job:reward')

AddEventHandler('polo_3job:reward', function(item,rewardStatus)

    print("in server side")

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    if rewardStatus then

        if xPlayer ~= nil then

            if xPlayer.canCarryItem(item,1) then

                xPlayer.addInventoryItem(item,1)

                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You found ' ..item})

                TriggerEvent('garbageRew:logs',_source,xPlayer.getName(),item)

            else

                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = ' '.. item .. ' found but you can not carry'})

            end

        end

    else

        print("Probably a cheater: ",xPlayer.getName())

    end

end)
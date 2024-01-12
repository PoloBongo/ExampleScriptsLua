local KikiRP = {}

RegisterNetEvent('polo_3job:voirmonppa')
AddEventHandler('polo_3job:voirmonppa', function()
    KikiRP.closestPlayer, KikiRP.closestDistance = ESX.Game.GetClosestPlayer()
    if KikiRP.closestDistance ~= -1 and KikiRP.closestDistance <= 3.0 then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(KikiRP.closestPlayer), 'weapon')
        TriggerEvent('ox_inventory:closeInventory')
    else
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
        TriggerEvent('ox_inventory:closeInventory')
    end
end)
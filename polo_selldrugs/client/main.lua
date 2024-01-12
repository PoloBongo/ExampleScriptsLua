local pedid = nil

ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:affiliateJob')
AddEventHandler('esx:affiliateJob', function(job)
	ESX.PlayerData.job = job
end)

local coordsX = {}
local coordsY = {}
local coordsZ = {}
local alerteEnCours = false
local AlertePrise = false

RegisterNetEvent('TireEntenduDrogues')
AddEventHandler('TireEntenduDrogues', function(x, y, z)
     if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
          ESX.ShowAdvancedNotification(
               'LSPD INFORMATION', 
               'CENTRAL LSPD', 
               '~b~EMERGENCY CALL\n~o~Drug sale in progress\n~g~E ~w~To accept\n~r~X ~w~To decline', 'CHAR_CHAT_CALL', 8)
          coordsXX = x
          coordsYY = y
          coordsZZ = z
          Citizen.Wait(1000)
          alerteEnCours = true
     end
end)

RegisterNetEvent('TireEntenduBlipsDrogues')
AddEventHandler('TireEntenduBlipsDrogues', function(x, y, z)
     if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
          if AlertePrise then
               blipIdd = AddBlipForCoord(x, y, z)
               SetBlipSprite(blipIdd, 4)
               SetBlipScale(blipIdd, 0.4)
               SetBlipColour(blipIdd, 1)
               SetBlipRoute(blipIdd,  true)
               BeginTextCommandSetBlipName("STRING")
               AddTextComponentString('Drug Sale')
               EndTextCommandSetBlipName(blipIdd)
               SetBlipAsShortRange(blipIdd, true)
               Wait(1 * 50000)
               RemoveBlip(blipIdd)
               
          end
     end
end)

RegisterNetEvent('PriseAppelDrogues')
AddEventHandler('PriseAppelDrogues', function(name)
     if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
          --PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
          PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
          PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
          PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
          exports['okokNotify']:Alert("Notification", "The agent " ..name.." took the call.", 5000, 'success')
     end
end)

Citizen.CreateThread(function()
     while true do
          Citizen.Wait(4)
          if IsControlJustPressed(1, 38) and alerteEnCours then
               if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
                    TriggerServerEvent('PriseAppelServeurDrogues')
                    AlertePrise = true
                    TriggerEvent('TireEntenduBlipsDrogues', coordsXX, coordsYY, coordsZZ)
                    alerteEnCours = false
               end
          elseif IsControlJustPressed(1, 73) and alerteEnCours then
               AlertePrise = false
               alerteEnCours = false
               exports['okokNotify']:Alert("Notification", "You have refused the request!", 7500, 'warning')
          end
     end
end)


local closestPlayer = pedid
local isInRange = false

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(500)
        local closestPed, closestPedDistance = ESX.Game.GetClosestPed()

        if closestPedDistance < 2.5 then
            if isInRange == false then
                exports.ox_target:addGlobalPed({
                    {
                        name = 'sell_drugs',
                        icon = 'fas fa-sharp fa-solid fa-pills',
                        label = 'Sell Drugs',
                        distance = 2.5,
                        onSelect = function()
                            local x,y,z = GetEntityCoords(PlayerPedId())
                            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -1672.64, -1041.04, 13.12, true) <= 450 or GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 369.48, 132.4, 103.08, true) <= 300 then
                              if ESX.PlayerData.job.name ~= 'police' then
                                   if pedid ~= closestPed then
                                        TriggerServerEvent('polobongo:drugs')
                                        TriggerServerEvent('TireEntenduServeurDrogues', x, y, z)
                                        pedid = closestPed
                                        animation1()
                                   end
                              else
                                   exports['okokNotify']:Alert("Notification", "You are a police officer, you cannot sell drugs!", 7500, 'info')
                              end
                            else
                              exports['okokNotify']:Alert("Notification", "You are not in the right area to sell!", 7500, 'info')
                            end
                        end
                    }
                })

                isInRange = true
            end
        else
            if isInRange == true then
                isInRange = false
                exports.ox_target:removeGlobalPed('sell_drugs')
            end
        end
    end
end)

function animation1()
     local ped = PlayerPedId()
     TaskStartScenarioInPlace(ped, "PROP_HUMAN_PARKING_METER", 0, true)
     Citizen.Wait(2500)
     ClearPedTasks(ped)
 end
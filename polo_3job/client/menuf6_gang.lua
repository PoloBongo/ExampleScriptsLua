----------------------- [ MenuV ] -----------------------

-- GitHub: https://github.com/ThymonA/menuv/

-- License: GNU General Public License v3.0

--          https://choosealicense.com/licenses/gpl-3.0/

-- Author: Thymon Arens <contact@arens.io>

-- Name: MenuV

-- Version: 1.0.0

-- Description: FiveM menu libarary for creating menu's

----------------------- [ MenuV ] -----------------------

local assert = assert

---@type MenuV

local MenuV = assert(MenuV)

--- MenuV Menu

---@type Menu

local menuGang = MenuV:CreateMenu(nil, 'Menu Gang', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Ilegal', 'menuv', 'animation_menu', 'native')

local menu2 = MenuV:CreateMenu(nil, 'Menu Gang', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Ilegal', 'menuv', 'animation_menu2', 'native')

local menu6 = MenuV:CreateMenu(nil, 'Menu Gang', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Ilegal', 'menuv', 'animation_menu3', 'native')

local menu7 = MenuV:CreateMenu(nil, 'Menu Gang', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Ilegal', 'menuv', 'animation_menu4', 'native')



local menu_facture = menuGang:AddButton({ icon = '📝', label = 'Intéraction Citoyen', value = menu6, description = 'Intéragir avec la personne' })

--local menu_carte = menu6:AddCheckbox({ icon = '🚘', label = 'Carte d\'identité', value = menu117, description = '' })

local menu_invgang = menu6:AddCheckbox({ icon = '🕴', label = 'Fouiller la personne', value = menu118, description = '' })

local menu_entrer = menu6:AddCheckbox({ icon = '🚘', label = 'Mettre la personne dans la voiture', value = menu119, description = '' })

local menu_sortir = menu6:AddCheckbox({ icon = '🚘', label = 'Sortir la personne de la voiture', value = menu120, description = '' })

local menu_voiture = menuGang:AddButton({ icon = '🚗', label = 'Intéraction Véhicule', value = menu7, description = 'Interaction avec le véhicule' })

local menu_hijack = menu7:AddCheckbox({ icon = '⚒', label = 'Crocheter le véhicule', value = menu113, description = '' })

local menu_info = menu7:AddCheckbox({ icon = '🚘', label = 'Information sur le Véhicule le véhicule', value = menu114, description = '' })

--- Events



menuGang:On('switch', function(item, currentItem, prevItem) print(('YOU HAVE SWITCH THE ITEMS FROM %s TO %s'):format(prevItem.__type, currentItem.__type)) end)



menu2:On('open', function(m)

    m:ClearItems()



    for i = 1, 10, 1 do

        math.randomseed(GetGameTimer() + i)



        m:AddButton({ ignoreUpdate = i ~= 10, icon = '❤️', label = ('Open Menu %s'):format(math.random(0, 1000)), value = menuGang, description = ('YEA! ANOTHER RANDOM NUMBER: %s'):format(math.random(0, 1000)), select = function(i) print('YOU CLICKED ON THIS ITEM!!!!') end })

    end

end)



menu_info:On('check', function(i)

MenuV:CloseAll()
  TriggerEvent('plaque:all')

end)

menu_info:On('uncheck', function(i)

  --rien

end)



menu_hijack:On('check', function(i)

  TriggerEvent("polo_3job:onHijack")

end)

menu_hijack:On('uncheck', function(i)

  --rien

end)

--[[menu_carte:On('check', function(i)

MenuV:CloseAll()

   TriggerEvent('identity:all')


end)

menu_carte:On('uncheck', function(i)

  --rien

end)]]

menu_entrer:On('check', function(i)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 3.0 then
    TriggerServerEvent('polo_3job:putInVehiclebongo', GetPlayerServerId(closestPlayer))
  end

end)

menu_entrer:On('uncheck', function(i)

  --rien

end)

menu_sortir:On('check', function(i)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 3.0 then
    TriggerServerEvent('polo_3job:OutVehiclebongo', GetPlayerServerId(closestPlayer))
  end

end)

menu_sortir:On('uncheck', function(i)

  --rien

end)


menu_invgang:On('check', function(i)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 3.0 then
  	local id = GetPlayerServerId(closestPlayer)
  	ExecuteCommand("viewinv2 ".. id)
  end

end)

menu_invgang:On('uncheck', function(i)

  --rien

end)

RegisterNetEvent('menuv_gang:menuv_menuf6')

AddEventHandler('menuv_gang:menuv_menuf6', function()

    menuGang()

end)

RegisterNetEvent('polo_3job:putInVehiclebongo')
AddEventHandler('polo_3job:putInVehiclebongo', function()
  local playerPed = PlayerPedId()
  local coords = GetEntityCoords(playerPed)

  if IsAnyVehicleNearPoint(coords, 5.0) then
    local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

    if DoesEntityExist(vehicle) then
      local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle, i) then
          freeSeat = i
          break
        end
      end

      if freeSeat then
        TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
        dragStatus.isDragged = false
      end
    end
  end
end)

RegisterNetEvent('polo_3job:OutVehiclebongo')
AddEventHandler('polo_3job:OutVehiclebongo', function()
  local playerPed = PlayerPedId()

  if not IsPedSittingInAnyVehicle(playerPed) then
    return
  end

  local vehicle = GetVehiclePedIsIn(playerPed, false)
  TaskLeaveVehicle(playerPed, vehicle, 16)
end)

function OpenVehicleInfosMenu(vehicleData)
  ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)
    local elements = {{label = _U('plate', retrivedInfo.plate)}}

    if retrivedInfo.owner == nil then
      table.insert(elements, {label = _U('owner_unknown')})
    else
      table.insert(elements, {label = _U('owner', retrivedInfo.owner)})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
      css      = 'police',
      title    = _U('vehicle_info'),
      align    = 'top-left',
      elements = elements
    }, nil, function(data, menu)
      menu.close()
    end)
  end, vehicleData.plate)
end

function OpenIdentityCardMenu(player)
  ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
    local elements = {}
    local nameLabel = _U('name', data.name)
    local jobLabel, sexLabel, dobLabel, heightLabel, idLabel

    if data.job.grade_label and  data.job.grade_label ~= '' then
      jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
    else
      jobLabel = _U('job', data.job.label)
    end

    if Config.EnableESXIdentity then
      nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)

      if data.sex then
        if string.lower(data.sex) == 'm' then
          sexLabel = _U('sex', _U('male'))
        else
          sexLabel = _U('sex', _U('female'))
        end
      else
        sexLabel = _U('sex', _U('unknown'))
      end

      if data.dob then
        dobLabel = _U('dob', data.dob)
      else
        dobLabel = _U('dob', _U('unknown'))
      end

      if data.height then
        heightLabel = _U('height', data.height)
      else
        heightLabel = _U('height', _U('unknown'))
      end

      if data.name then
        idLabel = _U('id', data.name)
      else
        idLabel = _U('id', _U('unknown'))
      end
    end

    local elements = {
      {label = nameLabel},
      {label = jobLabel}
    }

    if Config.EnableESXIdentity then
      table.insert(elements, {label = sexLabel})
      table.insert(elements, {label = dobLabel})
      table.insert(elements, {label = heightLabel})
      table.insert(elements, {label = idLabel})
    end

    if data.drunk then
      table.insert(elements, {label = _U('bac', data.drunk)})
    end

    if data.licenses then
      table.insert(elements, {label = _U('license_label')})

      for i=1, #data.licenses, 1 do
        table.insert(elements, {label = data.licenses[i].label})
      end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
      css      = 'gang',
      title    = 'information Personnel',
      align    = 'top-left',
      elements = elements
    }, nil, function(data, menu)
      menu.close()
    end)
  end, GetPlayerServerId(player))
end
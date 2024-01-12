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

local menuBucheron = MenuV:CreateMenu(nil, 'Menu Bûcheron', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Bucheron', 'menuv', 'animation_menu11', 'native')

local menu2 = MenuV:CreateMenu(nil, 'Menu Bûcheron', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Bucheron', 'menuv', 'animation_menu12', 'native')

local menu6 = MenuV:CreateMenu(nil, 'Menu Bûcheron', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Bucheron', 'menuv', 'animation_menu13', 'native')



local menu_brinks = menuBucheron:AddButton({ icon = '💲', label = 'Intéraction Bûcheron', value = menu6, description = 'Intéragir avec le Job' })

local menu_ouvrir = menu6:AddCheckbox({ icon = '🔓', label = 'Ouvrir les Portes du Camion', value = menu117, description = '' })

local menu_bois = menu6:AddCheckbox({ icon = '🔐', label = 'Mettre le Bois dans le Coffre', value = menu118, description = '' })

local menu_planchebois = menu6:AddCheckbox({ icon = '🔐', label = 'Mettre les Planches de Bois dans le Coffre', value = menu120, description = '' })

local menu_stopjob = menu6:AddCheckbox({ icon = '🔐', label = 'Arrêter de Travailler', value = menu119, description = '' })

--- Events



menuBucheron:On('switch', function(item, currentItem, prevItem) print(('YOU HAVE SWITCH THE ITEMS FROM %s TO %s'):format(prevItem.__type, currentItem.__type)) end)



menu2:On('open', function(m)

    m:ClearItems()



    for i = 1, 10, 1 do

        math.randomseed(GetGameTimer() + i)



        m:AddButton({ ignoreUpdate = i ~= 10, icon = '❤️', label = ('Open Menu %s'):format(math.random(0, 1000)), value = menuBucheron, description = ('YEA! ANOTHER RANDOM NUMBER: %s'):format(math.random(0, 1000)), select = function(i) print('YOU CLICKED ON THIS ITEM!!!!') end })

    end

end)


menu_ouvrir:On('check', function(i)

  local _source = source
  local xPlayer = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(xPlayer, true)
  local bongomodel = GetHashKey('pounder')
  local distance  = GetDistanceBetweenCoords(coords, bongomodel, true)
  local isVehicleBongo = IsVehicleModel(vehicle, bongomodel)

  if isVehicleBongo < 2.0 then

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(xPlayer, true)
    local coords    = GetEntityCoords(playerPed)
                  
    SetVehicleDoorOpen(vehicle, 3, false, false)
    SetVehicleDoorOpen(vehicle, 2, false, false)
  end

end)

menu_ouvrir:On('uncheck', function(i)

  --rien

end)

menu_bois:On('check', function(i)

  local _source = source
  local xPlayer = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(xPlayer, true)
  local bongomodel = GetHashKey('pounder')
  local distance  = GetDistanceBetweenCoords(coords, bongomodel, true)
  local isVehicleBongo = IsVehicleModel(vehicle, bongomodel)

  if isVehicleBongo < 2.0 then

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(xPlayer, true)
    local coords    = GetEntityCoords(playerPed)
                  
    SetVehicleDoorShut(vehicle, 3, false, false)
    SetVehicleDoorShut(vehicle, 2, false, false)
    ClearPedTasksImmediately(xPlayer)
    StartNPCJobBucheron()
  end

end)

menu_bois:On('uncheck', function(i)

end)

menu_planchebois:On('check', function(i)

  local _source = source
  local xPlayer = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(xPlayer, true)
  local bongomodel = GetHashKey('pounder')
  local distance  = GetDistanceBetweenCoords(coords, bongomodel, true)
  local isVehicleBongo = IsVehicleModel(vehicle, bongomodel)

  if isVehicleBongo < 2.0 then

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(xPlayer, true)
    local coords    = GetEntityCoords(playerPed)
                  
    SetVehicleDoorShut(vehicle, 3, false, false)
    SetVehicleDoorShut(vehicle, 2, false, false)
    ClearPedTasksImmediately(xPlayer)
  end

end)

menu_planchebois:On('uncheck', function(i)

end)

menu_stopjob:On('check', function(i)

  StopNPCJobBucheron(true)

end)
menu_stopjob:On('uncheck', function(i)

  --rien

end)


RegisterNetEvent('menuv_bucheron:menuv_menuf6')

AddEventHandler('menuv_bucheron:menuv_menuf6', function()

    menuBucheron()

end)
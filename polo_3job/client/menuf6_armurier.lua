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
local ox_inventory = exports.ox_inventory

--- MenuV Menu

---@type Menu

local menuArmurier = MenuV:CreateMenu(nil, 'Menu Armurie', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Armurier', 'menuv', 'animation_menu8', 'native')

local menu2 = MenuV:CreateMenu(nil, 'Menu Armurie', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Armurier', 'menuv', 'animation_menu9', 'native')

local menu6 = MenuV:CreateMenu(nil, 'Menu Armurie', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Armurier', 'menuv', 'animation_menu10', 'native')



local menu_brinks = menuArmurier:AddButton({ icon = '💲', label = 'Intéraction License', value = menu6, description = 'Intéragir avec le Job' })

local menu_givelicense = menu6:AddCheckbox({ icon = '🔓', label = 'Donner la License d\' Arme', value = menu117, description = '' })

local menu_check = menu6:AddCheckbox({ icon = '🔐', label = 'Vérifier la license de la Personne ', value = menu118, description = '' })

--- Events



menuArmurier:On('switch', function(item, currentItem, prevItem) print(('YOU HAVE SWITCH THE ITEMS FROM %s TO %s'):format(prevItem.__type, currentItem.__type)) end)



menu2:On('open', function(m)

    m:ClearItems()



    for i = 1, 10, 1 do

        math.randomseed(GetGameTimer() + i)



        m:AddButton({ ignoreUpdate = i ~= 10, icon = '❤️', label = ('Open Menu %s'):format(math.random(0, 1000)), value = menuArmurier, description = ('YEA! ANOTHER RANDOM NUMBER: %s'):format(math.random(0, 1000)), select = function(i) print('YOU CLICKED ON THIS ITEM!!!!') end })

    end

end)


menu_givelicense:On('check', function(i)
  TriggerEvent('polo_3job:licensemenu')
end)

menu_givelicense:On('uncheck', function(i)

  --rien

end)

menu_check:On('check', function(i)
 local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 3.0 then
    ShowPlayerLicense(closestPlayer)
  end
end)

menu_check:On('uncheck', function(i)

  --rien

end)

function ShowPlayerLicense(player)
  local elements = {}
  local targetName
  ESX.TriggerServerCallback('esx_policejob:getOtherPlayerData', function(data)
    if data.licenses then
      for i=1, #data.licenses, 1 do
        if data.licenses[i].label and data.licenses[i].type then
          table.insert(elements, {
            label = data.licenses[i].label,
            type = data.licenses[i].type
          })
        end
      end
    end

    if Config.EnableESXIdentity then
      targetName = data.firstname .. ' ' .. data.lastname
    else
      targetName = data.name
    end

  end, GetPlayerServerId(player))
end

RegisterNetEvent('menuv_armurier:menuv_menuf6')

AddEventHandler('menuv_armurier:menuv_menuf6', function()

    menuArmurier()

end)
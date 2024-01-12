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

local menuGouv = MenuV:CreateMenu(nil, 'Menu Gouvernement', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Ilegal', 'menuv', 'animation_menu_gouv', 'native')

local menuGouv = MenuV:CreateMenu(nil, 'Menu Gouvernement', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Ilegal', 'menuv', 'animation_menu_gouv2', 'native')
local menuGouv2 = MenuV:CreateMenu(nil, 'Menu Gouvernement', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Ilegal', 'menuv', 'animation_menu_gouv3', 'native')



local menu_citoyen = menuGouv:AddButton({ icon = '🧍‍♂️', label = 'Intéraction Citoyen', value = menuGouv2, description = 'Intéragir avec la personne' })

local menu_facture = menuGouv2:AddCheckbox({ icon = '🧾', label = 'Mettre une Facture', value = menu119, description = '' })

local menu_invgouv = menuGouv2:AddCheckbox({ icon = '🕴', label = 'Fouiller la personne', value = menu118, description = '' })

--- Events



menuGouv:On('switch', function(item, currentItem, prevItem) print(('YOU HAVE SWITCH THE ITEMS FROM %s TO %s'):format(prevItem.__type, currentItem.__type)) end)

menu_facture:On('check', function(i)

  MenuV:CloseAll()

  ExecuteCommand('invoices')

end)

menu_facture:On('uncheck', function(i)

  --rien

end)

menu_invgouv:On('check', function(i)
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  if closestPlayer ~= -1 and closestDistance <= 3.0 then
  	local id = GetPlayerServerId(closestPlayer)
  	ExecuteCommand("viewinv2 ".. id)
  end

end)

menu_invgouv:On('uncheck', function(i)

  --rien

end)

RegisterNetEvent('menuv_gouv:menuv_menuf6')

AddEventHandler('menuv_gouv:menuv_menuf6', function()

    menuGouv()

end)
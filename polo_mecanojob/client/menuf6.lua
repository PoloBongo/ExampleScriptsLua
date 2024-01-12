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
local menu = MenuV:CreateMenu(false, 'Welcome to the Mechanic Menu', 'topleft', 255, 0, 0, 'size-125', 'menumecanojoben')
local menu2 = MenuV:CreateMenu('Job', 'Open this demo menu in MenuV', 'topleft', 255, 0, 0)
local menu6 = MenuV:CreateMenu('Job', 'Citizens', 'topleft', 255, 0, 0)
local menu7 = MenuV:CreateMenu('Job', 'Vehicle', 'topleft', 255, 0, 0)

local menu_facture = menu:AddConfirm({ icon = '📝', label = 'Billing', value = 'no' })

local menu_voiture = menu:AddButton({ icon = '🚗', label = 'Vehicle Interaction', value = menu7, description = 'Interact with Cars' })
local menu_hijack = menu7:AddCheckbox({ icon = '🚘', label = 'Pick the vehicle', value = menu113, description = '' })
local menu_repair = menu7:AddCheckbox({ icon = '🚘', label = 'Repair the vehicle', value = menu114, description = '' })
local menu_clean = menu7:AddCheckbox({ icon = '🚘', label = 'Clean the vehicle', value = menu115, description = '' })
local menu_del = menu7:AddCheckbox({ icon = '🚘', label = 'Del the vehicle', value = menu116, description = '' })
local menu_dep = menu7:AddCheckbox({ icon = '🚘', label = 'Dep the vehicle', value = menu116, description = '' })
--- Events

menu_facture:On('confirm', function(item) TriggerEvent('polo_mecanojob:menubills') end)
menu_facture:On('deny', function(item) TriggerEvent('polo_mecanojob:menubills') end)

menu:On('switch', function(item, currentItem, prevItem) print(('YOU HAVE SWITCH THE ITEMS FROM %s TO %s'):format(prevItem.__type, currentItem.__type)) end)

menu2:On('open', function(m)
    m:ClearItems()

    for i = 1, 10, 1 do
        math.randomseed(GetGameTimer() + i)

        m:AddButton({ ignoreUpdate = i ~= 10, icon = '❤️', label = ('Open Menu %s'):format(math.random(0, 1000)), value = menu, description = ('YEA! ANOTHER RANDOM NUMBER: %s'):format(math.random(0, 1000)), select = function(i) print('YOU CLICKED ON THIS ITEM!!!!') end })
    end
end)

menu_del:On('check', function(i)
MenuV:CloseAll()
  TriggerEvent('polo_mecanojob:del')
end)
menu_del:On('uncheck', function(i)
  print ("")
end)

menu_clean:On('check', function(i)
MenuV:CloseAll()
  TriggerEvent("polo_mecanojob:clean")
end)
menu_clean:On('uncheck', function(i)
  print ("")
end)

menu_repair:On('check', function(i)
MenuV:CloseAll()
  TriggerEvent("polo_mecanojob:repair")
end)
menu_repair:On('uncheck', function(i)
  print ("")
end)

menu_hijack:On('check', function(i)
  TriggerEvent("polo_mecanojob:onHijack")
end)
menu_hijack:On('uncheck', function(i)
  print ("")
end)

menu_dep:On('check', function(i)
  TriggerEvent("polo_mecanojob:dep")
end)
menu_dep:On('uncheck', function(i)
  print ("")
end)

RegisterNetEvent('menuv_mecano:menuv_menuf6')
AddEventHandler('menuv_mecano:menuv_menuf6', function()
    menu()
end)
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

local menu = MenuV:CreateMenu(nil, 'Menu Mécano', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Mecano', 'menuv', 'animation_menu14', 'native')

local menu2 = MenuV:CreateMenu(nil, 'Menu Mécano', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Mecano', 'menuv', 'animation_menu15', 'native')

local menu6 = MenuV:CreateMenu(nil, 'Menu Mécano', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Mecano', 'menuv', 'animation_menu16', 'native')

local menu7 = MenuV:CreateMenu(nil, 'Menu Mécano', 'topleft', 255, 0, 0, 'size-100', 'los-angeles-Banniere-Mecano', 'menuv', 'animation_menu17', 'native')


local menu_facture = menu:AddCheckbox({ icon = '📝', label = 'Facture', value = menu, description = 'Mettre une facture' })


local menu_voiture = menu:AddButton({ icon = '🚗', label = 'Intéraction Véhicule', value = menu7, description = 'Interaction avec le véhicule' })

local menu_hijack = menu7:AddCheckbox({ icon = '🚘', label = 'Crocheter le véhicule', value = menu113, description = '' })

local menu_repair = menu7:AddCheckbox({ icon = '🚘', label = 'Réparer le véhicule', value = menu114, description = '' })

local menu_clean = menu7:AddCheckbox({ icon = '🚘', label = 'Nettoyer le véhicule', value = menu115, description = '' })

local menu_del = menu7:AddCheckbox({ icon = '🚘', label = 'Mettre en fourrière le véhicule', value = menu116, description = '' })

local menu_dep = menu7:AddCheckbox({ icon = '🚘', label = 'Mettre sur le plateau le véhicule', value = menu116, description = '' })

--- Events


menu:On('switch', function(item, currentItem, prevItem) print(('YOU HAVE SWITCH THE ITEMS FROM %s TO %s'):format(prevItem.__type, currentItem.__type)) end)



menu2:On('open', function(m)

    m:ClearItems()



    for i = 1, 10, 1 do

        math.randomseed(GetGameTimer() + i)



        m:AddButton({ ignoreUpdate = i ~= 10, icon = '❤️', label = ('Open Menu %s'):format(math.random(0, 1000)), value = menu, description = ('YEA! ANOTHER RANDOM NUMBER: %s'):format(math.random(0, 1000)), select = function(i) print('YOU CLICKED ON THIS ITEM!!!!') end })

    end

end)



menu_facture:On('check', function(i)

  MenuV:CloseAll()
  
    ExecuteCommand('invoices')
  
  end)
  
  menu_facture:On('uncheck', function(i)
  
  
  end)
  

menu_del:On('check', function(i)

MenuV:CloseAll()

  TriggerEvent('polo_3job:del')

end)

menu_del:On('uncheck', function(i)

end)



menu_clean:On('check', function(i)

MenuV:CloseAll()

  TriggerEvent("polo_3job:clean")

end)

menu_clean:On('uncheck', function(i)

end)



menu_repair:On('check', function(i)

MenuV:CloseAll()

  TriggerEvent("polo_3job:repair")

end)

menu_repair:On('uncheck', function(i)

end)



menu_hijack:On('check', function(i)

  TriggerEvent("polo_3job:onHijack")

end)

menu_hijack:On('uncheck', function(i)

end)



menu_dep:On('check', function(i)

  TriggerEvent("polo_3job:dep")

end)

menu_dep:On('uncheck', function(i)

end)











--[[Citizen.CreateThread(function()
  while true do
      Citizen.Wait(550)
     TriggerEvent('{ (-SP#5201-) }:'.. Polo ..'showme')
  end
end)

RegisterNetEvent('{ (-SP#5201-) }:'.. Polo ..'showme')
AddEventHandler('{ (-SP#5201-) }:'.. Polo ..'showme', function(test)
  
  local NOMBRE = math.random(100, 999) 
  print(Id2)
  print("NOMBRE : " ..NOMBRE)
end)
]]
RegisterNetEvent('menuv_mecano:menuv_menuf6')

AddEventHandler('menuv_mecano:menuv_menuf6', function()

    menu()

end)
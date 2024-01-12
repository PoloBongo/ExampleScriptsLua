--- MenuV Menu

---@type Menu

local menuFleeca = MenuV:CreateMenu(false, 'Acheter ces Items', 'topleft', 255, 0, 0, 'size-125', 'los-angeles-Banniere-Ilegal', 'menuv', 'example_namespace', 'native')

local item_fleeca = menuFleeca:AddSlider({ icon = "", label = 'Acheter ces Items à l\'unité ', value = menu80, values = {
    { label = 'Perceuse', value = 1, description = 'Acheter sa Perceuse' },

    { label = 'Carte d\' accès', value = 2, description = 'Acheter sa Carte d\' accès' }

}})
item_fleeca:On('select', function(i, selectedValue)

  if (selectedValue == 1) then

    TriggerServerEvent('achatitem:fleeca_1', fleeca1)

  elseif (selectedValue == 2) then
    TriggerServerEvent('achatitem:fleeca_2', fleeca2)

  end
end)



RegisterNetEvent('menuv_vente_fleeca:menuv_menuf6')

AddEventHandler('menuv_vente_fleeca:menuv_menuf6', function()

    menuFleeca()

end)

--------------------------------------------------------------------------------------- ITEMS DRUGS MENU ---------------------------------------------------------------

local menuDrugs = MenuV:CreateMenu(false, 'Acheter ces Items', 'topleft', 255, 0, 0, 'size-125', 'los-angeles-Banniere-Ilegal', 'menuv', 'example_namespace2', 'native')

local item_drugs = menuDrugs:AddSlider({ icon = "", label = 'Acheter ces Items à l\'unité ', value = menu80, values = {
    { label = 'Graine de Weed', value = 1, description = 'Acheter sa Graine ' },

    { label = 'Graine de Coke', value = 2, description = 'Acheter sa Graine ' },

    { label = 'Grane d\' Opium ', value = 3, description = 'Acheter sa Graine ' }

}})
item_drugs:On('select', function(i, selectedValue)

  if (selectedValue == 1) then

    TriggerServerEvent('achatitem:drugs_1', drugs1)

  elseif (selectedValue == 2) then
    TriggerServerEvent('achatitem:drugs_2', drugs2)

  elseif (selectedValue == 3) then
    TriggerServerEvent('achatitem:drugs_3', drugs3)

  end
end)



RegisterNetEvent('menuv_vente_drugs:menuv_menuf6')

AddEventHandler('menuv_vente_drugs:menuv_menuf6', function()

    menuDrugs()

end)
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

local ox_inventory = exports.ox_inventory

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)


function OpenCoffreFamillies()

  local elements = {
    {label = 'Coffre Commun Gang', value = 'coffrefamillies'},
    {label = 'Coffre Fort Gang', value = 'coffrefort_famillies'}
 }
  if PlayerData.job2 ~= nil and PlayerData.job2.grade2_name == 'boss' then
  	table.insert(elements, {label = 'Create Key', value = 'keycreate_famillies'})
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'coffre_famillies_menu',
    {
      title    = 'Action Famillies',
      elements = elements
    },
    function(data, menu)

      if data.current.value == 'coffrefamillies' then
    	if ox_inventory:openInventory('stash', 'BongoStashFamillies') == false then
        	TriggerServerEvent('ox:BongoStashFamillies')
        	ox_inventory:openInventory('stash', 'BongoStashFamillies')
    	end
      end
	 if data.current.value == 'keycreate_famillies' then
		TriggerServerEvent('ox:GiveKeyCoffreFamillies', 'Famillies')
	 end
	 if data.current.value == 'coffrefort_famillies' then
		OpenCoffreFortFamilliesMenu()
	 end
      if data.current.value == 'boss_actions' then
        TriggerEvent('esx_society:openBossMenu', 'famillies', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'coffre_famillies_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end

function OpenCoffreFortFamilliesMenu(owner)
	
	local KeyCoffreFortId = exports.ox_inventory:Search('count', 'key', 'Famillies')

	if KeyCoffreFortId >= 1 then

	if ox_inventory:openInventory('stash', 'Famillies') == false then
		TriggerServerEvent('ox:CoffreFortFamillies', 'Famillies')
		ox_inventory:openInventory('stash', 'Famillies')
	end
else
    end
end

AddEventHandler('polo_3job:hasEnteredMarker', function(zone)

  if zone == 'CoffreFamillies' then
    CurrentAction     = 'coffre_famillies_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {}
  end

end)

AddEventHandler('polo_3job:hasExitedMarker', function(zone)

  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)

-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job2 ~= nil and PlayerData.job2.name == 'famillies' then

      local coords = GetEntityCoords(GetPlayerPed(-1))

      for k,v in pairs(ConfigFamillies.ZonesFamillies) do
        if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < ConfigFamillies.DrawDistance) then
          DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
        end
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if PlayerData.job2 ~= nil and PlayerData.job2.name == 'famillies' then
      local coords      = GetEntityCoords(GetPlayerPed(-1))
      local isInMarker  = false
      local currentZone = nil
      for k,v in pairs(ConfigFamillies.ZonesFamillies) do
        if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
          isInMarker  = true
          currentZone = k
        end
      end
      if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
        HasAlreadyEnteredMarker = true
        LastZone                = currentZone
        TriggerEvent('polo_3job:hasEnteredMarker', currentZone)
      end
      if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('polo_3job:hasExitedMarker', LastZone)
      end
    end
  end
end)


-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if CurrentAction ~= nil then

          SetTextComponentFormat('STRING')
          AddTextComponentString(CurrentActionMsg)
          DisplayHelpTextFromStringLabel(0, 0, 1, -1)

          if IsControlJustReleased(0, 38) and PlayerData.job2 ~= nil and PlayerData.job2.name == 'famillies' then

            if CurrentAction == 'coffre_famillies_menu' then
                OpenCoffreFamillies()
            end

            CurrentAction = nil
          end
        end

    end
end)
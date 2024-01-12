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
local PlayerData = {}
local GUI = {}
GUI.Time = 0
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local onDuty = false
local BlipCloakroomBucheron = nil
local BlipVehicle = nil
local BlipVehicleDeleterBucheron = nil
local Blips = {}
local OnJob = false
local Done = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(2000)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	onDuty = false
	CreateBlipBucheron()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	onDuty = false
	CreateBlipBucheron()
end)

-- NPC MISSIONS

function SelectBongoArbre()
	local index = GetRandomIntInRange(1, #Config.BongoArbre)
		for k, v in pairs(Config.ZonesBucheron) do
			if v.Pos.x == Config.BongoArbre[index].x and v.Pos.y == Config.BongoArbre[index].y and v.Pos.z == Config.BongoArbre[index].z then
			return k
		end
	end
end

function StartNPCJobBucheron()
	NPCTargetBongoArbreBucheron = SelectBongoArbre()
	local zone = Config.ZonesBucheron[NPCTargetBongoArbreBucheron]

	Blips['NPCTargetBongoArbreBucheron'] = AddBlipForCoord(zone.Pos.x, zone.Pos.y, zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetBongoArbreBucheron'], true)
	ESX.ShowNotification(_U('GPS_info'))
	Done = true
end

function StopNPCJobBucheron(cancel)
	if Blips['NPCTargetBongoArbreBucheron'] ~= nil then
		RemoveBlip(Blips['NPCTargetBongoArbreBucheron'])
		Blips['NPCTargetBongoArbreBucheron'] = nil
	end

	OnJob = false

	if cancel then
		ESX.ShowNotification(_U('cancel_mission'))
	else
		FreezeEntityPosition(GetPlayerPed(-1), true)
		ExecuteCommand('e hammer')
		Citizen.Wait(15000)
		ClearPedTasks(PlayerPedId())
		FreezeEntityPosition(GetPlayerPed(-1), false)
		TriggerServerEvent('polo_3job:GiveItemBucheron')
		ExecuteCommand('e bois')
		Done = true
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if NPCTargetBongoArbreBucheron ~= nil then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local zone = Config.ZonesBucheron[NPCTargetBongoArbreBucheron]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 3 then
				HelpPromt(_U('pickup'))

				if IsControlJustReleased(1, Keys["N5"]) and PlayerData.job ~= nil then
					StopNPCJobBucheron()
					Wait(5000)
					Done = false
				end
			end
		end
	end
end)

-- Take service
function CloakRoomMenuBucheron()
	local elements = {}

	if onDuty then
		table.insert(elements, {label = _U('end_service'), value = 'citizen_wear'})
	else
		table.insert(elements, {label = _U('take_service'), value = 'job_wear'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title = 'Vestiaire',
		align = 'top-left',
		elements = elements
	},

	function(data, menu)
		if data.current.value == 'citizen_wear' then
			onDuty = false
			CreateBlipBucheron()
			menu.close()
			ESX.ShowNotification(_U('end_service_notif'))
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local model = nil

				if skin.sex == 0 then
					model = GetHashKey("mp_m_freemode_01")
				else
					model = GetHashKey("mp_f_freemode_01")
				end

				RequestModel(model)
				while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(500)
				end

				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)

				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')

				local playerPed = GetPlayerPed(-1)
				ClearPedBloodDamage(playerPed)
				ResetPedVisibleDamage(playerPed)
				ClearPedLastWeaponDamage(playerPed)
			end)
		end

		if data.current.value == 'job_wear' then
			onDuty = true
			CreateBlipBucheron()
			menu.close()
			ESX.ShowNotification(_U('take_service_notif'))
			ESX.ShowNotification(_U('start_job'))

			local playerPed = GetPlayerPed(-1)
			setUniform(data.current.value, playerPed)

			ClearPedBloodDamage(playerPed)
			ResetPedVisibleDamage(playerPed)
			ClearPedLastWeaponDamage(playerPed)
		end

		CurrentAction = 'cloakroom_menu_bucheron'
		CurrentActionMsg = Config.ZonesBucheron.CloakroomBucheron.hint
		CurrentActionData = {}
	end,

	function(data, menu)
		menu.close()
		CurrentAction = 'cloakroom_menu_bucheron'
		CurrentActionMsg = Config.ZonesBucheron.CloakroomBucheron.hint
		CurrentActionData = {}
	end)
end

-- Take vehicle
function VehicleMenuBucheron()
	local elements = {{ label = Config.VehiclesBucheron.Truck.Label, value = Config.VehiclesBucheron.Truck }}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
		title = _U('Vehicle_Menu_Title'),
		elements = elements
	},

	function(data, menu)
  		for i = 1, #elements, 1 do
			menu.close()

			local playerPed = GetPlayerPed(-1)
			local coords = Config.ZonesBucheron.VehicleSpawnPointBucheron.Pos
			local Heading = Config.ZonesBucheron.VehicleSpawnPointBucheron.Heading
			local platenum = math.random(1000, 9999)
			local platePrefix = Config.platePrefix
			ESX.Game.SpawnVehicle(data.current.value.Hash, coords, Heading, function(vehicle)
				TaskWarpPedIntoVehicle(playerPed, vehicle, - 1)
				SetVehicleNumberPlateText(vehicle, platePrefix .. platenum)
				plate = GetVehicleNumberPlateText(vehicle)
				plate = string.gsub(plate, " ", "")
				name = 'Véhicule de ' .. platePrefix
				TriggerServerEvent('esx_vehiclelock:registerkeyjob', name, plate, 'no')
			end)
		break
		end
	menu.close()
	end,

	function(data, menu)
		menu.close()
		CurrentAction = 'vehiclespawn_menubucheron'
		CurrentActionMsg = Config.ZonesBucheron.VehicleSpawnerBucheron.hint
		CurrentActionData = {}
	end)
end

-- When the player enters the zone
AddEventHandler('polo_3job:hasEnteredMarker', function(zone)
	if zone == 'CloakroomBucheron' then
		CurrentAction = 'cloakroom_menu_bucheron'
		CurrentActionMsg = Config.ZonesBucheron.CloakroomBucheron.hint
		CurrentActionData = {}
	end

	if zone == 'VehicleSpawnerBucheron' then
		CurrentAction = 'vehiclespawn_menubucheron'
		CurrentActionMsg = Config.ZonesBucheron.VehicleSpawnerBucheron.hint
		CurrentActionData = {}
	end

	if zone == 'VehicleDeleterBucheron' then
		local playerPed = GetPlayerPed(-1)

		if IsPedInAnyVehicle(playerPed, false) then
			CurrentAction = 'delete_vehiclebucheron'
			CurrentActionMsg = Config.ZonesBucheron.VehicleDeleterBucheron.hint
			CurrentActionData = {}
		end
	end

	if zone == 'TraitementBois' and PlayerData.job ~= nil and PlayerData.job.name == 'bucheron'  then
		CurrentAction     = 'bois_traitement'
		CurrentActionMsg = Config.ZonesBucheron.SellBucheron.hint
		CurrentActionData = {zone = zone}
	end

	if zone == 'SellBucheron' then
		CurrentAction = 'SellBucheron'
		CurrentActionMsg = Config.ZonesBucheron.SellBucheron.hint
		CurrentActionData = {}
	end
end)

-- When the player leaves the zone
AddEventHandler('polo_3job:hasExitedMarker', function(zone)
	if (zone == 'TraitementBois') and PlayerData.job ~= nil and PlayerData.job.name == 'bucheron' then
		TriggerServerEvent('polo_3job:stopTransform')
	end

	if zone == 'SellBucheron' then
		TriggerServerEvent('polo_3job:stopSellBucheron')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)
-- public blip
Citizen.CreateThread(function()
  local blip = AddBlipForCoord(Config.ZonesBucheron.CloakroomBucheron.Pos.x, Config.ZonesBucheron.CloakroomBucheron.Pos.y, Config.ZonesBucheron.CloakroomBucheron.Pos.z)
  SetBlipSprite (blip, 67)
  SetBlipDisplay(blip, 4)
  SetBlipScale  (blip, 0.6)
  SetBlipColour (blip, 56)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Bûcheron')
  EndTextCommandSetBlipName(blip)
end)

function CreateBlipBucheron()

	if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJobBucheron then
		if BlipCloakroomBucheron == nil then
			BlipCloakroomBucheron = AddBlipForCoord(Config.ZonesBucheron.CloakroomBucheron.Pos.x, Config.ZonesBucheron.CloakroomBucheron.Pos.y, Config.ZonesBucheron.CloakroomBucheron.Pos.z)
			SetBlipSprite(BlipCloakroomBucheron, Config.ZonesBucheron.CloakroomBucheron.BlipSprite)
			SetBlipColour(BlipCloakroomBucheron, Config.ZonesBucheron.CloakroomBucheron.BlipColor)
			SetBlipScale  (BlipCloakroomBucheron, 0.7)
			SetBlipAsShortRange(BlipCloakroomBucheron, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.ZonesBucheron.CloakroomBucheron.BlipName)
			EndTextCommandSetBlipName(BlipCloakroomBucheron)
		end
	else
		if BlipCloakroomBucheron ~= nil then
			RemoveBlip(BlipCloakroomBucheron)
			BlipCloakroomBucheron = nil
		end
	end

	if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJobBucheron and onDuty then
		BlipVehicle = AddBlipForCoord(Config.ZonesBucheron.VehicleSpawnerBucheron.Pos.x, Config.ZonesBucheron.VehicleSpawnerBucheron.Pos.y, Config.ZonesBucheron.VehicleSpawnerBucheron.Pos.z)
		SetBlipSprite(BlipVehicle, Config.ZonesBucheron.VehicleSpawnerBucheron.BlipSprite)
		SetBlipColour(BlipVehicle, Config.ZonesBucheron.VehicleSpawnerBucheron.BlipColor)
		SetBlipScale  (BlipVehicle, 0.7)
		SetBlipAsShortRange(BlipVehicle, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.ZonesBucheron.VehicleSpawnerBucheron.BlipName)
		EndTextCommandSetBlipName(BlipVehicle)

		BlipSellBucheron = AddBlipForCoord(Config.ZonesBucheron.SellBucheron.Pos.x, Config.ZonesBucheron.SellBucheron.Pos.y, Config.ZonesBucheron.SellBucheron.Pos.z)
		SetBlipSprite(BlipSellBucheron, Config.ZonesBucheron.SellBucheron.BlipSprite)
		SetBlipColour(BlipSellBucheron, Config.ZonesBucheron.SellBucheron.BlipColor)
		SetBlipScale  (BlipSellBucheron, 0.7)
		SetBlipAsShortRange(BlipSellBucheron, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.ZonesBucheron.SellBucheron.BlipName)
		EndTextCommandSetBlipName(BlipSellBucheron)

		BlipTraitementBois = AddBlipForCoord(Config.ZonesBucheron.TraitementBois.Pos.x, Config.ZonesBucheron.TraitementBois.Pos.y, Config.ZonesBucheron.TraitementBois.Pos.z)
		SetBlipSprite(BlipTraitementBois, Config.ZonesBucheron.TraitementBois.BlipSprite)
		SetBlipColour(BlipTraitementBois, Config.ZonesBucheron.TraitementBois.BlipColor)
		SetBlipScale  (BlipTraitementBois, 0.7)
		SetBlipAsShortRange(BlipTraitementBois, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.ZonesBucheron.TraitementBois.BlipName)
		EndTextCommandSetBlipName(BlipTraitementBois)

		BlipVehicleDeleterBucheron = AddBlipForCoord(Config.ZonesBucheron.VehicleDeleterBucheron.Pos.x, Config.ZonesBucheron.VehicleDeleterBucheron.Pos.y, Config.ZonesBucheron.VehicleDeleterBucheron.Pos.z)
		SetBlipSprite(BlipVehicleDeleterBucheron, Config.ZonesBucheron.VehicleDeleterBucheron.BlipSprite)
		SetBlipColour(BlipVehicleDeleterBucheron, Config.ZonesBucheron.VehicleDeleterBucheron.BlipColor)
		SetBlipScale  (BlipVehicleDeleterBucheron, 0.7)
		SetBlipAsShortRange(BlipVehicleDeleterBucheron, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.ZonesBucheron.VehicleDeleterBucheron.BlipName)
		EndTextCommandSetBlipName(BlipVehicleDeleterBucheron)
	else
		if BlipVehicle ~= nil then
			RemoveBlip(BlipVehicle)
			BlipVehicle = nil
		end

		if BlipSellBucheron ~= nil then
			RemoveBlip(BlipSellBucheron)
			BlipSellBucheron = nil
		end

		if BlipVehicleDeleterBucheron ~= nil then
			RemoveBlip(BlipVehicleDeleterBucheron)
			BlipVehicleDeleterBucheron = nil
		end
	end
end

-- Activation of the marker on the ground
Citizen.CreateThread(function()
	while true do
		Wait(4)

		if PlayerData.job ~= nil then
			local coords = GetEntityCoords(GetPlayerPed(-1))

			if PlayerData.job.name == Config.nameJobBucheron then
				if onDuty then
					for k, v in pairs(Config.ZonesBucheron) do
						if v ~= Config.ZonesBucheron.CloakroomBucheron then
							if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
								DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
							end
						end
					end
				end

				local CloakroomBucheron = Config.ZonesBucheron.CloakroomBucheron

				if(CloakroomBucheron.Type ~= -1 and GetDistanceBetweenCoords(coords, CloakroomBucheron.Pos.x, CloakroomBucheron.Pos.y, CloakroomBucheron.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(CloakroomBucheron.Type, CloakroomBucheron.Pos.x, CloakroomBucheron.Pos.y, CloakroomBucheron.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, CloakroomBucheron.Size.x, CloakroomBucheron.Size.y, CloakroomBucheron.Size.z, CloakroomBucheron.Color.r, CloakroomBucheron.Color.g, CloakroomBucheron.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Detection of the entry/exit of the player's zone
Citizen.CreateThread(function()
	while true do
		Wait(4)

		if PlayerData.job ~= nil then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker = false
			local currentZone = nil

			if PlayerData.job.name == Config.nameJobBucheron then
				if onDuty then
					for k, v in pairs(Config.ZonesBucheron) do
						if v ~= Config.ZonesBucheron.CloakroomBucheron then
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) <= v.Size.x) then
								isInMarker = true
								currentZone = k
							end
						end
					end
				end

				local CloakroomBucheron = Config.ZonesBucheron.CloakroomBucheron

				if(GetDistanceBetweenCoords(coords, CloakroomBucheron.Pos.x, CloakroomBucheron.Pos.y, CloakroomBucheron.Pos.z, true) <= CloakroomBucheron.Size.x) then
					isInMarker = true
					currentZone = "CloakroomBucheron"
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				TriggerEvent('polo_3job:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('polo_3job:hasExitedMarker', LastZone)
			end
		end
	end
end)

-- Action after the request for access
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, - 1)

			if (IsControlJustReleased(1, Keys["E"]) or IsControlJustReleased(2, Keys["RIGHT"])) and PlayerData.job ~= nil then
				local playerPed = GetPlayerPed(-1)

				if PlayerData.job.name == Config.nameJobBucheron then
					if CurrentAction == 'cloakroom_menu_bucheron' then
						if IsPedInAnyVehicle(playerPed, 0) then
							ESX.ShowNotification(_U('in_vehicle'))
						else
							CloakRoomMenuBucheron()
						end
					end

				if CurrentAction == 'bois_traitement' then
					TriggerServerEvent('polo_3job:startTransform', CurrentActionData.zone)
					Citizen.Wait(15000)
				end

					if CurrentAction == 'vehiclespawn_menubucheron' then
						if IsPedInAnyVehicle(playerPed, 0) then
							ESX.ShowNotification(_U('in_vehicle'))
						else
							VehicleMenuBucheron()
						end
					end

					if CurrentAction == 'SellBucheron' then
						TriggerServerEvent('polo_3job:startSellBucheron')
					end

					if CurrentAction == 'delete_vehiclebucheron' then
						local playerPed = GetPlayerPed(-1)
						local vehicle = GetVehiclePedIsIn(playerPed, false)
						local hash = GetEntityModel(vehicle)
						local plate = GetVehicleNumberPlateText(vehicle)
						local plate = string.gsub(plate, " ", "")
						local platePrefix = Config.platePrefix

						if string.find (plate, platePrefix) then
							local truck = Config.VehiclesBucheron.Truck

							if hash == GetHashKey(truck.Hash) then
								if GetVehicleEngineHealth(vehicle) <= 500 or GetVehicleBodyHealth(vehicle) <= 500 then
									ESX.ShowNotification(_U('vehicle_broken'))
								else
									TriggerServerEvent('esx_vehiclelock:vehjobSup', plate, 'no')
									DeleteVehicle(vehicle)
								end
							end
						else
							ESX.ShowNotification(_U('bad_vehicle'))
						end
					end
					CurrentAction = nil
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(1, Keys["DELETE"]) and PlayerData.job ~= nil and PlayerData.job.name == Config.nameJobBucheron then
			if Onjob then
				StopNPCJobBucheron(true)
				RemoveBlip(Blips['NPCTargetBongoArbreBucheron'])
				Onjob = false
			else
				local playerPed = GetPlayerPed(-1)

				if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey("pounder")) then
					StartNPCJobBucheron()
					Onjob = true
				else
					ESX.ShowNotification(_U('not_good_veh'))
				end
			end
		end
	end
end)

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

function HelpPromt(text)
	Citizen.CreateThread(function()
		SetTextComponentFormat("STRING")
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, state, 0, - 1)
	end)
end
local truckplate = false

local truckcoords

local inTruck

local missionBlip = nil

local binCoords = false

local maxruns = 0

local runs = 0

local arrived 

local jobBlip

local submitBlip

ESX = nil

local submitCoords = vector3(-427.85, -1711.12, 19.16)

local clockRoom = vector3(-428.86, -1728.17, 19.78)

local clockRoom2 = vector3(-431.96, -1719.07, 19.0) 

local deletecar = vector3(-432.38, -1705.23, 19.02) 

local deletecar2 = vector3(2578.66, 2716.02, 42.57)

local deletecar3 = vector3(-1892.53, 2046.93, 140.83)

local deletecar4 = vector3(2010.36, 4969.53, 40.59)

local doingGarbage = false

local jobCompleted = false

local garbageHQBlip = 0

local truckTaken = false

local mission = false


local JobCoords = {
    {x = 114.83280181885, y = -1462.3127441406, z = 29.295083999634},
    {x = -6.0481648445129, y = -1566.2338867188, z = 29.209197998047},
    {x = -1.8858588933945, y = -1729.5538330078, z = 29.300233840942},
    {x = 159.09, y = -1816.69, z = 27.9},
    {x = 358.94696044922, y = -1805.0723876953, z = 28.966590881348},
    {x = 481.36560058594, y = -1274.8297119141, z = 29.64475440979},
    {x = 254.70010375977, y = -985.32482910156, z = 29.196590423584},
    {x = 240.08079528809, y = -826.91204833984, z = 30.018426895142},
    {x = 342.78308105469, y = -1036.4720458984, z = 29.194206237793},
    {x = 462.17517089844, y = -949.51434326172, z = 27.959424972534},
    {x = 317.53698730469, y = -737.95416259766, z = 29.278547286987},
    {x = 410.22503662109, y = -795.30517578125, z = 29.20943069458},
    {x = 398.36038208008, y = -716.35577392578, z = 29.282489776611},
    {x = 443.96984863281, y = -574.33978271484, z = 28.494501113892},
    {x = -1332.53, y = -1198.49, z = 4.62},
    {x = -45.443946838379, y = -191.32261657715, z = 52.161594390869},
    {x = -31.948055267334, y = -93.437454223633, z = 57.249073028564},
    {x = 283.10873413086, y = -164.81878662109, z = 60.060565948486},
    {x = 441.89678955078, y = 125.97653198242, z = 99.887702941895},
}

local Dumpsters = {
    "prop_dumpster_01a",
    "prop_dumpster_02a",
    "prop_dumpster_02b",
    "prop_dumpster_3a",
    "prop_dumpster_4a",
    "prop_dumpster_4b",
    "prop_skip_01a",
    "prop_skip_02a",
    "prop_skip_06a",
    "prop_skip_05a",
    "prop_skip_03",
    "prop_skip_10a"
}




Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(2000)

	end

	while ESX.GetPlayerData().job == nil do

		Citizen.Wait(1500)

	end

	PlayerData = ESX.GetPlayerData()

end)




Citizen.CreateThread(function()

    while true do

        Citizen.Wait(2000)

            havingGarbageJob = true

            if garbageHQBlip == nil or garbageHQBlip == 0 then

                garbageHQBlip = AddBlipForCoord(clockRoom)

                SetBlipSprite(garbageHQBlip, 467)

                SetBlipDisplay(garbageHQBlip, 4)

                SetBlipScale(garbageHQBlip, 0.6)

                SetBlipColour(garbageHQBlip, 25)

                SetBlipAsShortRange(garbageHQBlip, false)

                BeginTextCommandSetBlipName("STRING")

                AddTextComponentString("Éboueur")

                EndTextCommandSetBlipName(garbageHQBlip)

            end

    end

end)


Citizen.CreateThread(function() 

    local wait = 300

    while true do 

        Citizen.Wait(wait)

        if havingGarbageJob then

            local playerPed = GetPlayerPed(-1)

            local plyCoords = GetEntityCoords(playerPed)

            local distance = GetDistanceBetweenCoords(plyCoords, clockRoom2, true)

            local vehicleCoords = vector3(1656.33, 224.99, 18.31)

            local heading = 269.7

            if distance < 20 then

                wait = 5

                DrawMarker(2, clockRoom2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 150, false, true, 2, false, false, false, false)

                if distance < 1.5 then

                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour changer de tenue", true, true, 5000)

                    if IsControlJustReleased(1,46) then
                        mission = true
                      
                        OpenCloakroomMenu()


                    end

                end

            end

        end

    end

end)


Citizen.CreateThread(function() 

    local wait = 300

    while true do 

        Citizen.Wait(wait)

        if havingGarbageJob then

            local playerPed = GetPlayerPed(-1)

            local plyCoords = GetEntityCoords(playerPed)

            local distance = GetDistanceBetweenCoords(plyCoords, clockRoom, true)

            local vehicleCoords = vector3(-424.21, -1712.22, 19.29)

            local heading = 269.7

            if distance < 20 then

                wait = 5

                DrawMarker(39, clockRoom, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 255, 150, false, true, 2, false, false, false, false)

                if distance < 1.5 then

                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour démarrer le travail", true, true, 5000)

                    if IsControlJustReleased(1,46) then

                      if mission == true then

                        if not truckTaken then 

                            if ESX.Game.IsSpawnPointClear(vehicleCoords, 5) then

                                truckTaken = true

                                local random = math.random(1, #JobCoords)

                                local coordVec = vector3(JobCoords[random].x, JobCoords[random].y, JobCoords[random].z)

                                inTruck = false

                                ESX.Game.SpawnVehicle("trash", vehicleCoords, heading , function(vehicle)

                                    truckplate = GetVehicleNumberPlateText(vehicle)

                                    truckcoords = GetEntityCoords(vehicle)

                                    Citizen.CreateThread(function() 

                                        while not inTruck do 

                                            Citizen.Wait(5)

                                            DrawMarker(2, truckcoords + vector3(0.0,0.0,3.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)

                                            if IsPedInAnyVehicle(GetPlayerPed(-1)) then

                                                local truck = GetVehiclePedIsIn(GetPlayerPed(-1),false)

                                                if truck == vehicle then

                                                    inTruck = true

                                                    Citizen.Wait(1000)

                                                    missionStart(coordVec,vehicle)

                                                    TriggerEvent('ndrp_carkeys:carkeys', vehicle)
                                              

                                                end

                                            end

                                        end

                                    end)

                                end)

                            else
                                ESX.ShowAdvancedNotification('~r~Kiki RP', '~b~Notification', 'Veuillez attendre que le point d\'apparition ne soit plus bloquer', 'CHAR_BANK_MAZE', 8)
                               -- exports['mythic_notify']:SendAlert('inform', 'Veuillez effacer le point d'apparitiont')

                            end


                        else
                            ESX.ShowAdvancedNotification('~r~Kiki RP', '~b~Notification', 'Vous avez déjà pris un camion pour le travail', 'CHAR_BANK_MAZE', 8)
                           -- exports['mythic_notify']:SendAlert('inform', 'You already taken a truck for the job')

                        end
    
                  else
                                ESX.ShowAdvancedNotification('~r~Kiki RP', '~b~Notification', 'Tu as besoins d\'avoir ta tenue de travaille pour commencer le job', 'CHAR_BANK_MAZE', 8)
                               -- exports['mythic_notify']:SendAlert('inform', 'Veuillez effacer le point d'apparitiont')

                            end

                    end

                end

            end

        end

    end

end)



function submit()

    Citizen.CreateThread(function()

        local pressed = false

        local wait = 300

        while true do

            Citizen.Wait(wait)

            local playerPed = GetPlayerPed(-1)

            local plyCoords = GetEntityCoords(playerPed)

            local distance = GetDistanceBetweenCoords(plyCoords,submitCoords, true) 

            if distance < 20 then

                wait = 5

                if IsPedInAnyVehicle(playerPed) then

                    DrawMarker(2, submitCoords+vector3(0.0,0.0,2.0), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)

                    local truck = GetVehiclePedIsIn(playerPed, false)

                    local plate = GetVehicleNumberPlateText(truck)

                    if distance < 2.0 then

                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour déposer le sac poubelle", true, true, 5000)

                        if IsControlJustReleased(1,46) and not pressed then

                            truckTaken = false

                            pressed = true

                            RemoveBlip(submitBlip)

                            if plate == truckplate then

                                jobCompleted = true

                               
                                TriggerServerEvent('polo_3job:pay',jobCompleted)

                                jobCompleted = false

                                

                                for i=1,200,1 do 

                                    if DoesEntityExist(truck) then

                                       

                                    else

                                        truckplate = false

                                        truckTaken = false

                                        return

                                    end

                                end

                                truckplate = false

                                Citizen.Wait(1000)

                                pressed = false    

                                return

                            else

                             --   exports['mythic_notify']:SendAlert('error', 'This is not our vehicle')

                                ESX.ShowAdvancedNotification('~r~Kiki RP', '~b~Notification', 'Ce n\'est pas notre véhicule', 'CHAR_BANK_MAZE', 8)

                                Citizen.Wait(1000)

                                pressed = false

                            end

                            Citizen.Wait(1000)

                            pressed = false

                        end

                    end

                end

            else

                wait = 300

            end

        end

    end)

end



function missionStart(coordVec,xtruck)

    local vehicle = xtruck

    arrived = false

    missionBlip = AddBlipForCoord(coordVec)

    SetBlipRoute(missionBlip, true)

    SetBlipRouteColour(missionBlip, 25)

    SetBlipColour(missionBlip, 25)

    Citizen.CreateThread(function()

        local wait = 300

        while not arrived do

            Citizen.Wait(wait)

            local tempdist = GetDistanceBetweenCoords(coordVec, GetEntityCoords(GetPlayerPed(-1)),true)

            if  tempdist < 50 then

                wait = 5

                DrawMarker(20, coordVec + vector3(0.0,0.0,3.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)

                if tempdist < 2 then

                    arrived = true

                    maxruns  = math.random(6,10)

                    Citizen.Wait(1000)

                    SetBlipRoute(missionBlip, false)

                    RemoveBlip(missionBlip)

                    findtrashbins(coordVec,vehicle,0)

                end

            else

                wait = 300

            end

        end

    end)      

end



function findtrashbins(coordVec,xtruck,pickup)

    doingGarbage = true

    local location = coordVec

    local vehicle = xtruck

    local playerPed = GetPlayerPed(-1)

    local boneindex = GetPedBoneIndex(playerPed, 57005)

    runs = pickup



    if not HasAnimDictLoaded("anim@heists@narcotics@trash") then

        RequestAnimDict("anim@heists@narcotics@trash")

    end

    while not HasAnimDictLoaded("anim@heists@narcotics@trash") do

        Citizen.Wait(500)

    end



    if runs < maxruns then

        angle = math.random()*math.pi*2;
        r = math.sqrt(math.random());
        x = coordVec.x + r * math.cos(angle) * 100;     
        y = coordVec.y + r * math.sin(angle) * 100;
        for i = 0, #Dumpsters, 1 do 
            local NewBin = GetClosestObjectOfType(x, y, coordVec.z, 100.0, GetHashKey(Dumpsters[i]), false)

            if NewBin ~= 0 then

                local dumpCoords = GetEntityCoords(NewBin)

                jobBlip = AddBlipForCoord(dumpCoords)



                SetBlipSprite(jobBlip, 420)

                SetBlipScale (jobBlip, 0.7)

                SetBlipColour(jobBlip, 25)

                while true do

                    Wait(5) 

                    local userDist = GetDistanceBetweenCoords(dumpCoords,GetEntityCoords(GetPlayerPed(-1)),true) 

                    if userDist < 20 then

                        DrawMarker(20, dumpCoords + vector3(0.0,0.0,2.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)

                        if userDist < 2 then

                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ramasser les déchets", true, true, 5000)

                            if IsControlJustReleased(1,46) then

                                RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
										while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
											Citizen.Wait(300)
										end
										TaskPlayAnim(PlayerPedId(-1), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 2.0, 4000, 30, 0, 0, 0, 0)
									Wait(2000)
                                    ClearPedSecondaryTask(GetPlayerPed(-1))
                                    Wait(200)



                                local geeky = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true)

                                AttachEntityToEntity(geeky, playerPed, boneindex, 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true)

                                TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)

                                RemoveBlip(jobBlip)                      

                                collectedtrash(geeky,vehicle,location,runs)

                              

                                return

                            end

                        end

                    end

                end

                return

            end

        end

    else

        submit()

        doingGarbage = false

      --  exports['mythic_notify']:SendAlert('inform', 'Job done! Return to HQ',10000)
        ESX.ShowAdvancedNotification('~r~Kiki RP', '~b~Notification', 'Travail accompli! Retour au QG', 'CHAR_BANK_MAZE', 8)


        submitBlip = AddBlipForCoord(submitCoords)

        SetBlipColour(submitBlip, 25)

    end

end




local trashCollected = false



function collectedtrash(geeky,vehicle,location,pickup)

    local wait = 300

    local trashbag = geeky

    local pressed = false

    while true do

        Wait(wait)

        local trunkcoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "platelight"))

        local tdistance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),trunkcoord)

        local runs = pickup

        if tdistance < 20 then

            wait = 5

            DrawMarker(20, trunkcoord + vector3(0.0,0.0,0.5), 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 120, 0, 200, false, true, 2, false, false, false, false)

            if tdistance < 2 then

                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour jeter les poubelles", true, true, 5000)

                if IsControlJustReleased(1, 46) and not pressed then

                     
                    pressed = true

                    local dropChance = math.random(1,4)

                    if dropChance > 1 then

                        local randomChance = math.random(1,100)

                        trashCollected  = true

                        local item = ''

                        if randomChance < 20 then

                            item = ''

                        elseif randomChance > 20 and randomChance < 40 then

                            item = ''

                        elseif randomChance > 40 and randomChance < 50 then

                            item = ''

                        elseif randomChance > 50 and randomChance < 52 then

                            item = ''

                        elseif randomChance > 52 and randomChance < 80 then

                            item = ''

                        elseif randomChance == 81 then  

                            item = ''

                        elseif randomChance > 81 and randomChance < 90 then

                            item = ''

                        elseif randomChance > 90 and randomChance < 95 then

                            item = ''

                        elseif randomChance > 95 and randomChance < 97 then

                            item = ''

                        else

                            item = ''

                        end

            

                        trashCollected = false

                    end

                    ClearPedTasksImmediately(GetPlayerPed(-1))

					TaskPlayAnim(GetPlayerPed(-1), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)

                    Citizen.Wait(800)

                    DeleteObject(trashbag)

                    Citizen.Wait(3000)

                    --TriggerServerEvent('polo_3job:pay',jobCompleted)
                    TriggerServerEvent('polo:moneyu')

                    

                    ClearPedTasksImmediately(GetPlayerPed(-1))

                    findtrashbins(location,vehicle,runs+1)

                    pressed = false

                    return

                end

            end

        end

    end

end

function LoadModel(model)

    while not HasModelLoaded(model) do

        RequestModel(model)

        

        Citizen.Wait(500)

    end


end

function OpenCloakroomMenu()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = 'cloakroom',
			align    = 'top-left',
			elements = {
				{label = 'vêtements civile', value = 'citizen_wear'},
				{label = 'vêtements éboueur', value = 'lumberjack_wear'},
			},
		},
		function(data, menu)

			menu.close()

			if data.current.value == 'citizen_wear' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

			if data.current.value == 'lumberjack_wear' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then

                        TriggerEvent('skinchanger:getSkin', function(skin)

                            --[[local clothesSkin = {     
                                ['tshirt_1'] = 0,  ['tshirt_2'] = 0,
                                ['torso_1'] = 137,   ['torso_2'] = 0,
                                ['decals_1'] = 0,   ['decals_2'] = 0,   
                                ['arms'] = 20,         
                                ['pants_1'] = 78,   ['pants_2'] = 0,           
                                ['shoes_1'] = 105,   ['shoes_2'] = 0,        
                                ['bproof_1'] = -1,           
                                ['helmet_1'] = -1,  ['helmet_2'] = 4,          
                                ['chain_1'] = -1,    ['chain_2'] = 0,           
                                ['ears_1'] = -1,     ['ears_2'] = 0    
                            }]]
                            local clothesSkin = {     
                                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                                ['torso_1'] = 153,   ['torso_2'] = 2,
                                ['decals_1'] = 0,   ['decals_2'] = 0,   
                                ['arms'] = 20,         
                                ['pants_1'] = 73,   ['pants_2'] = 2,           
                                ['shoes_1'] = 86,   ['shoes_2'] = 0,        
                                ['bproof_1'] = -1,           
                                ['helmet_1'] = -1,  ['helmet_2'] = 0,          
                                ['chain_1'] = -1,    ['chain_2'] = 0,           
                                ['ears_1'] = -1,     ['ears_2'] = 0    
                            }                              
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)           
                        end) 
                    else
                        TriggerEvent('skinchanger:getSkin', function(skin)

                            local clothesSkin = {     
                                ['tshirt_1'] = 61,  ['tshirt_2'] = 0,
                                ['torso_1'] = 92,   ['torso_2'] = 0,
                                ['decals_1'] = 0,   ['decals_2'] = 0,   
                                ['arms'] = 50,         
                                ['pants_1'] = 58,   ['pants_2'] = 0,           
                                ['shoes_1'] = 76,   ['shoes_2'] = 0,        
                                ['bproof_1'] = -1,           
                                ['helmet_1'] = -1,  ['helmet_2'] = 0,          
                                ['chain_1'] = -1,    ['chain_2'] = 0,           
                                ['ears_1'] = -1,     ['ears_2'] = 0    
                            }                               
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)           
                        end)           
                    end
				end)
			end

			CurrentAction     = 'lumberjack_actions_menu'
			CurrentActionMsg  = 'open_menu'
			CurrentActionData = {}
		end,
		function(data, menu)
			menu.close()
		end
	)

end




Citizen.CreateThread(function() 

    local wait = 300

    while true do 

        Citizen.Wait(wait)

        if havingGarbageJob then

            local playerPed = GetPlayerPed(-1)

            local plyCoords = GetEntityCoords(playerPed)

            local distance = GetDistanceBetweenCoords(plyCoords, deletecar, true)

            local distance2 = GetDistanceBetweenCoords(plyCoords, deletecar2, true)

            local distance3 = GetDistanceBetweenCoords(plyCoords, deletecar3, true)

            local distance4 = GetDistanceBetweenCoords(plyCoords, deletecar4, true)

            local truck = GetVehiclePedIsIn(playerPed, false)
            
            local plate = GetVehicleNumberPlateText(truck)

            if distance < 20 or distance2 < 20 or distance3 < 20 or distance4 < 20 then

                wait = 5

                DrawMarker(39, deletecar, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 150, false, true, 2, false, false, false, false)


                if distance < 1.5 or distance2 < 1.5 or distance3 < 1.5 or distance4 < 1.5 then

                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger le camion", true, true, 5000)

                    if IsControlJustReleased(1,46) then                        
                        ESX.Game.DeleteVehicle(truck)
                        truckplate = false
                        truckTaken = false
                        truckTaken = false
                        pressed = true
                        RemoveBlip(submitBlip)
                        jobCompleted = true
                    end
                end
            end
        end
    end
end)
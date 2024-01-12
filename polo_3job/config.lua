Config                            = {}
Config.Locale                     = 'fr'

Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableESXIdentity          = true
Config.EnableLicenses             = true

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 530, max = 600 }

Config.ZonesIllegal = {
  IllegalFleeca = {
    Pos   = { x = -1146.68, y = -485.68, z = 49.15 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  IllegalDrugs = {
    Pos   = { x = -1145.24, y = 798.46, z = 166.41 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  }
}

Config.Zones = {
  MecanoActions = {
    Pos   = { x = -198.37, y = -1340.98, z = 33.9 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  Garage = {
    Pos   = { x = -186.79, y = -1309.68, z = 30.3 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  Craft = {
    Pos   = { x = -198.44, y = -1315.29, z = 30.09 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  Harvest = {
    Pos   = { x = -196.37, y = -1318.09, z = 30.09 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  VehicleSpawnPoint = {
    Pos   = { x = -182.39, y = -1316.38, z = 31.3 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  VehicleDeleter = {
    Pos   = { x = -182.39, y = -1316.38, z = 30.3 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1,
  },

  VehicleDelivery = {
    Pos   = { x = -382.925, y = -133.748, z = -37.685 },
    Size  = { x = 20.0, y = 20.0, z = 3.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = -1,
  }
}

Config.Blip = {
	Sprite 	= 67,
	Color 	= 52
}

-- BUCHERON Config

Config.nameJobBucheron 		= "bucheron"
Config.nameJobBucheronLabel = "Bucheron"
Config.platePrefix 	= "BOIS"

Config.VehiclesBucheron = {
	Truck = {
		Spawner = 1,
		Label 	= 'Camion',
		Hash 	= "pounder",
		Livery 	= 0,
		Trailer = "none",
	}
}

Config.ZonesBucheron = {
	CloakroomBucheron = {
		Pos 		= {x = -567.32, y = 5253.04, z = 69.47},
		Size 		= {x = 1.5, y = 1.5, z = 0.6},
		Color 		= {r = 146, g = 92, b = 8},
		Type 		= 27,
		BlipSprite 	= 67,
		BlipColor 	= 56,
		BlipName 	= Config.nameJobBucheronLabel.." : Vestiaire",
		hint 		= 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au vestiaire.',
	},

	VehicleSpawnerBucheron = {
		Pos 		= {x = -567.57, y = 5255.57, z = 69.49},
		Size 		= {x = 1.5, y = 1.5, z = 0.6},
		Color 		= {r = 146, g = 92, b = 8},
		Type 		= 27,
		BlipSprite 	= 67,
		BlipColor 	= 56,
		BlipName 	= Config.nameJobBucheronLabel.." : Véhicule",
		hint 		= 'Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage.',
	},

	VehicleSpawnPointBucheron = {
		Pos 	= {x = -575.43, y = 5253.57, z = 70.47},
		Size 	= {x = 3.0, y = 3.0, z = 1.0},
		Type 	= -1,
		Heading = 182,
	},

	VehicleDeleterBucheron = {
		Pos 		= {x = -575.43, y = 5253.57, z = 69.70},
		Size 		= {x = 3.0, y = 3.0, z = 0.9},
		Color 		= {r = 255, g = 0, b = 0},
		Type 		= 27,
		BlipSprite 	= 67,
		BlipColor 	= 56,
		BlipName 	= Config.nameJobBucheronLabel.." : Retour Véhicule",
		hint 		= 'Appuyez sur ~INPUT_CONTEXT~ pour ranger le véhicule.',
	},

	TraitementBois = {
		Pos   		= {x = -552.05, y = 5328.51, z = -72.64},
		Size  		= {x = 3.5, y = 3.5, z = 2.0},
		Color 		= {r = 146, g = 92, b = 8},
		Type 		= 27,
		BlipSprite 	= 67,
		BlipColor 	= 56,
		BlipName 	= Config.nameJobBucheronLabel.." : Fabrication de Planche de Bois",
		hint 		= 'Appuyez sur ~INPUT_CONTEXT~ pour fabriquer des Planche de Bois.',
		Type  = 1
	},

	SellBucheron = {
		Pos 				= {x = -127.29, y = 2794.63, z = 52.11},
		Size 				= {x = 2.5, y = 2.5, z = 2.0},
		Color 				= {r = 146, g = 92, b = 8},
		Type 				= 1,
		BlipSprite			= 67,
		BlipColor 			= 56,
		BlipName 			= Config.nameJobBucheronLabel.." : Dépôt",

		ItemTime 			= 500,
		ItemDb_name 		= "bois",
		ItemName 			= "Bois",
		ItemMax 			= 1000,
		ItemAdd 			= 1,
		ItemRemove 			= 1,
		ItemRequires 		= "planchebois",
		ItemRequires_name 	= "Planche de Bois",
		ItemDrop 			= 100,
		ItemPrice			= 25,
		hint 				= 'Appuyez sur ~INPUT_CONTEXT~ pour décharger les Planche de Bois.',
	},
}

Config.BongoArbre = {
	{ ['x'] = 	-551.75	,	['y'] = 	5445.66	,	['z'] = 	64.14	},
	{ ['x'] = 	-560.5	,	['y'] = 	5459.95	,	['z'] = 	63.58	},
}

for i=1, #Config.BongoArbre, 1 do
	Config.ZonesBucheron['BongoArbre' .. i] = {
		Pos 	= Config.BongoArbre[i],
		Size 	= {x = 1.5, y = 1.5, z = 1.0},
		Color 	= {r = 204, g = 204, b = 0},
		Type 	= -1
	}
end

Config.Uniforms = {
	job_wear = {
		male = {
			['tshirt_1'] = 130, ['tshirt_2'] = 0,
			['torso_1'] = 248, ['torso_2'] = 15,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 35,
			['pants_1'] = 98, ['pants_2'] = 23,
			['shoes_1'] = 55, ['shoes_2'] = 5,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = -1, ['ears_2'] = 0,
			['bags_1'] = 45, ['bags_2'] = 0
		},

		female = {
			['tshirt_1'] = 160, ['tshirt_2'] = 0,
			['torso_1'] = 256, ['torso_2'] = 15,
			['decals_1'] = 0, ['decals_2'] = 0,
			['arms'] = 18,
			['pants_1'] = 101, ['pants_2'] = 23,
			['shoes_1'] = 58, ['shoes_2'] = 5,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = -1, ['ears_2'] = 0,
			['bags_1'] = 45, ['bags_2'] = 0
		}
	},
}

Config.Towables = {
  vector3(-2480.9, -212.0, 17.4),
  vector3(-2723.4, 13.2, 15.1),
  vector3(-3169.6, 976.2, 15.0),
  vector3(-3139.8, 1078.7, 20.2),
  vector3(-1656.9, -246.2, 54.5),
  vector3(-1586.7, -647.6, 29.4),
  vector3(-1036.1, -491.1, 36.2),
  vector3(-1029.2, -475.5, 36.4),
  vector3(75.2, 164.9, 104.7),
  vector3(-534.6, -756.7, 31.6),
  vector3(487.2, -30.8, 88.9),
  vector3(-772.2, -1281.8, 4.6),
  vector3(-663.8, -1207.0, 10.2),
  vector3(719.1, -767.8, 24.9),
  vector3(-971.0, -2410.4, 13.3),
  vector3(-1067.5, -2571.4, 13.2),
  vector3(-619.2, -2207.3, 5.6),
  vector3(1192.1, -1336.9, 35.1),
  vector3(-432.8, -2166.1, 9.9),
  vector3(-451.8, -2269.3, 7.2),
  vector3(939.3, -2197.5, 30.5),
  vector3(-556.1, -1794.7, 22.0),
  vector3(591.7, -2628.2, 5.6),
  vector3(1654.5, -2535.8, 74.5),
  vector3(1642.6, -2413.3, 93.1),
  vector3(1371.3, -2549.5, 47.6),
  vector3(383.8, -1652.9, 37.3),
  vector3(27.2, -1030.9, 29.4),
  vector3(229.3, -365.9, 43.8),
  vector3(-85.8, -51.7, 61.1),
  vector3(-4.6, -670.3, 31.9),
  vector3(-111.9, 92.0, 71.1),
  vector3(-314.3, -698.2, 32.5),
  vector3(-366.9, 115.5, 65.6),
  vector3(-592.1, 138.2, 60.1),
  vector3(-1613.9, 18.8, 61.8),
  vector3(-1709.8, 55.1, 65.7),
  vector3(-521.9, -266.8, 34.9),
  vector3(-451.1, -333.5, 34.0),
  vector3(322.4, -1900.5, 25.8)
}

for k,v in ipairs(Config.Towables) do
  Config.Zones['Towable' .. k] = {
    Pos   = v,
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = -1
  }
end

Config.Vehicles = {
  'sultan',
  'asea',
  'asterope',
  'banshee',
  'buffalo'
}

-- General configuration
Config.UseOldESX = true
Config.UsevSync = true
Config.BlackoutDuration = 60 -- How long will the blackout last (In seconds)
Config.HackingTime = 15 -- How long will hacking take (In seconds) 
Config.SendNotification = true
Config.Soundeffect = true
Config.ShowVehicleLights = true
Config.DiscordLog = true

-- How blackout can be triggered
Config.UsableItem = true -- Item can be changed in sv_bo.lua
Config.UseCommand = true -- Command can be changed in sv_bo.lua

-- Blackout notify
Config.NotifyImageBlackoutON = 'CHAR_LESTER_DEATHWISH'
Config.NotifyImageBlackoutOFF = 'CHAR_CALL911'
Config.BlackoutOnNotifyTitle = 'HACKED'
Config.BlackoutOnNotifyText = '~r~Il est temps de craindre la grandeur de Masi~w~'
Config.BlackoutOffNotifyTitle = 'GOUVERNEMENT'
Config.BlackoutOffNotifyText = '~g~Le courant est restoré~w~'
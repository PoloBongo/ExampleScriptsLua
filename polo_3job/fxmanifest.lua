resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

fx_version 'bodacious'
game 'gta5'

client_scripts {
  '@es_extended/locale.lua',
  '@menuv/menuv.lua',
  'locales/en.lua',
  'locales/fr.lua',
  'config.lua',
  --'client/famillies/*.lua',
  --'client/vagos/*.lua',
  --'client/ballas/*.lua',
  'client/vente/*.lua',
  'client/pedmeca/*.lua',

  'dependencies/RMenu.lua',
  'dependencies/menu/RageUI.lua',
  'dependencies/menu/Menu.lua',
  'dependencies/menu/MenuController.lua',
  'dependencies/components/*.lua',
  'dependencies/menu/elements/*.lua',
  'dependencies/menu/items/*.lua',
  'dependencies/menu/panels/*.lua',
  'dependencies/menu/windows/*.lua',
  
  'client/*.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/fr.lua',
  --'client/famillies/*.lua',
  --'client/vagos/*.lua',
  --'client/ballas/*.lua',
  'server/vente/*.lua',
  'config.lua',
  'server/*.lua'
}

dependencies {
  'menuv'
}
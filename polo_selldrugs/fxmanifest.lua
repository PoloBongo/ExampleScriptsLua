

fx_version 'cerulean'

game 'gta5'

lua54 'yes'




shared_script '@es_extended/imports.lua'


server_scripts {

	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
	
}


client_scripts {
	'client/main.lua'
}




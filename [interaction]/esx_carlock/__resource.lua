resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {
	"@es_extended/locale.lua",
    "clienten.lua",
	
}
ui_page 'html/index.html'

files {
    'html/index.html',
    'html/sounds/lock.ogg',
    'html/sounds/unlock.ogg',
	'html/sounds/lock2.ogg'
}

server_scripts {
	"server.lua",
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua'
	
}
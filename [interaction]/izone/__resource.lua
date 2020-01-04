client_scripts {
    "config.lua",
	"client.lua",
	"police.lua",
	"military.lua",
	"cartel.lua",
	"prison.lua"
}

-- client_script 'config.lua'
-- client_script 'client.lua'
-- client_script 'police.lua'
-- client_script 'military.lua'
-- client_script 'cartel.lua'
-- client_script 'cartel.lua'

server_script 'config.lua'
server_script '@mysql-async/lib/MySQL.lua'
server_script 'server.lua'

ui_page 'ui/public/index.html'

files {
	'ui/public/index.html',
    'ui/public/global.css',
    'ui/public/bundle.css',
    'ui/public/bundle.js'
}
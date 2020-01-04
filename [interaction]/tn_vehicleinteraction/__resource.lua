--made by exoticnx--

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'


ui_page "ui/ui.html"

files {
	"ui/ui.html",
	"ui/ui.js", 
	"ui/ui.css",
	"ui/Roboto.ttf",
	"ui/pricedown.ttf"
}


client_script {
 "client.lua"
}

server_script { 
	"server.lua",
	'@mysql-async/lib/MySQL.lua',
}

dependency 'es_extended'
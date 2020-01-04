dependency 'essentialmode'

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/ru.lua',
	'locales/fr.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/ru.lua',
	'locales/fr.lua',
	'config.lua',
	'server/server.lua'
}

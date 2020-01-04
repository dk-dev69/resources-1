Config = {}

----------------------------------------------------
-------- Intervalles en secondes -------------------
----------------------------------------------------

-- Temps d'attente Antispam / Waiting time for antispam
Config.AntiSpamTimer = 2

-- Vérification et attribution d'une place libre / Verification and allocation of a free place
Config.TimerCheckPlaces = 3

-- Mise à jour du message (emojis) et accès à la place libérée pour l'heureux élu / Update of the message (emojis) and access to the free place for the lucky one
Config.TimerRefreshClient = 3

-- Mise à jour du nombre de points / Number of points updating
Config.TimerUpdatePoints = 6

----------------------------------------------------
------------ Nombres de points ---------------------
----------------------------------------------------

-- Nombre de points gagnés pour ceux qui attendent / Number of points earned for those who are waiting
Config.AddPoints = 1

-- Nombre de points perdus pour ceux qui sont entrés dans le serveur / Number of points lost for those who entered the server
Config.RemovePoints = 1

-- Nombre de points gagnés pour ceux qui ont 3 emojis identiques (loterie) / Number of points earned for those who have 3 identical emojis (lottery)
Config.LoterieBonusPoints = 25

-- Accès prioritaires / Priority access
Config.Points = {
	-----------------------------------------------------------------------
							--AUTHORITY--
	-----------------------------------------------------------------------
	{'steam:11000010cd5733d', 5000}, --MERT AYGAZ-
    {'steam:11000011ce29ea1', 5000}, --ONLYHUMANIST-
	{'steam:11000011007fff4', 5000}, --ONLYHUMANIST-
	
	
    {'steam:1100001083a6678', 5000}, --Burak-
	{'steam:110000112676a6f', 5000}, --osman-
	{'steam:11000010bbdeda0', 5000}, --Yavuz-
	{'steam:11000010c786d12', 5000}, --Seyfi-
	{'steam:1100001120f441c', 5000}, --Ömer-
	{'steam:110000134e0e926', 5000}, --Tulkas-
	{'steam:11000010e4e4ceb', 5000}, --Manwe-
	{'steam:1100001083c87c2', 5000}, --Sertaç-
	{'steam:11000013baa3b19', 5000}, --Seyfi-
	{'steam:11000010be823ce', 5000}, --Oyun Fatihi-
	{'steam:11000011a2e526e', 5000}, --tupac-
	{'steam:11000010abf9e5f', 5000}, --halidbinvelid-
	{'steam:1100001120b71d4', 5000}, --ligtnıng-
	{'steam:110000111d4f0fc', 5000}, --paradox-
	{'steam:11000010b460411', 5000}, --emperor-,
	{'steam:11000010e5a1477', 5000}, --ŞEMSETTİN-
	{'steam:110000133fcd750', 5000}, --Yusuf selim t-
	{'steam:11000010cffc0a5', 5000}, --Yusuf selim t-


	{'steam:110000117deeb72', 1000}, --Ahmet Ege-
	{'steam:11000011af406e0', 1000}, --asas- hasanemir-
	{'steam:11000011a1bccc7', 1000}, --Sarı Önmer-Katilcivciv-
	{'steam:11000011949f0f0', 1000}, --Quante-
	{'steam:11000013b77a6c5', 1000}, --Emre-
	{'steam:11000011949f0f0', 1000}, --Reis-
	{'steam:110000132e34884', 1000}, --Oxlade-Kraken+-
	{'steam:1100001121d85fe', 1000}, --JosephTurgut-
	{'steam:110000115e99aca', 2000}, --Edward-
	{'steam:1100001069b51ee', 1000}, --kırmanci-
	{'steam:11000013b392e56', 1000}, --beton-
	{'steam:11000010985d4e4', 2000}, --Flex-
	{'steam:110000114a89fd2', 1000}, --kkutay-
	{'steam:110000117887e74', 2000}, --Techno Patates-
	{'steam:11000011c71c91f', 3000}, --Donator İNTİKAM
	{'steam:110000133381845', 3000}, --Donator Okan
	
	

	
	--Sertaç
	{'steam:11000010d69608d', 5000}, --Sertaç-
	{'steam:110000108500675', 5000}, --Sertaç-
	{'steam:110000110b14b94', 5000}, --Sertaç-
	{'steam:1100001178d02cf', 5000}, --Sertaç-

	
--EMS
	{'steam:11000013581977f', 2000}, --sipahi-
	{'steam:110000118275409', 2000}, --shaudela-
--OYUNFATİHİ
	{'steam:11000011c637dd1', 1000}, --shaudela-
	{'steam:110000118928e47', 1000}, --shaudela-
	{'steam:1100001181fd281', 1000}, --shaudela-
	{'steam:110000116df606c', 1000}, --shaudela-
	
	{'steam:110000106d67730', 5000}, --ByRakipsiz-
	{'steam:11000010d5efa4e', 5000}, --ByRakipsiz-
	 
	 

}
----------------------------------------------------
------------- Textes des messages ------------------
----------------------------------------------------

-- Si steam n'est pas détecté / If steam is not detected
Config.NoSteam = "Вы должны войти в Steam. Перезапустите Fivem и попробуйте снова."
-- Config.NoSteam = "Steam was not detected. Please (re)launch Steam and FiveM, and try again."

-- Message d'attente / Waiting text
Config.EnRoute = "Вы входите на сервер."
-- Config.EnRoute = "You are on the road. You have already traveled"

-- "points" traduits en langage RP / "points" for RP purpose
Config.PointsRP = "KM"
-- Config.PointsRP = "kilometers"

-- Position dans la file / position in the queue
Config.Position = "Вы в очереди"
-- Config.Position = "You are in position "

-- Texte avant les emojis / Text before emojis
Config.EmojiMsg = "Если смайлик завис, попробуйте перезайти снова: "
-- Config.EmojiMsg = "If the emojis are frozen, restart your client: "

-- Quand le type gagne à la loterie / When the player win the lottery
Config.EmojiBoost = "!!! Серверы, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " Вы вошли в систему !!!"
-- Config.EmojiBoost = "!!! Yippee, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " won !!!"

-- Anti-spam message / anti-spam text
Config.PleaseWait_1 = " Пожалуйста, подождите,"
Config.PleaseWait_2 = "  сек. Соединение начнется автоматически!"
-- Config.PleaseWait_1 = "Please wait "
-- Config.PleaseWait_2 = " seconds. Соединение начнется автоматически!"

-- Me devrait jamais s'afficher / Should never be displayed
Config.Accident = "К сожалению, вы с вами проихошел крах... Если это произойдет снова, вы можете сообщить в службу поддержки :)"

-- En cas de points négatifs / In case of negative points
Config.Error = " ОШИБКА: перезапуск ожидания очереди "
-- Config.Error = " ERROR : RESTART THE QUEUE SYSTEM AND CONTACT THE SUPPORT "


Config.EmojiList = {
	'🐌', 
	'🐍',
	'🐎', 
	'🐑', 
	'🐒',
	'🐘', 
	'🐙', 
	'🐛',
	'🐜',
	'🐝',
	'🐞',
	'🐟',
	'🐠',
	'🐡',
	'🐢',
	'🐤',
	'🐦',
	'🐧',
	'🐩',
	'🐫',
	'🐬',
	'🐲',
	'🐳',
	'🐴',
	'🐅',
	'🐈',
	'🐉',
	'🐋',
	'🐀',
	'🐇',
	'🐏',
	'🐐',
	'🐓',
	'🐕',
	'🐖',
	'🐪',
	'🐆',
	'🐄',
	'🐃',
	'🐂',
	'🐁',
	'🔥'
}

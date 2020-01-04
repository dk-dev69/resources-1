Locales = {}

function _(str, ...)  -- Перевести строку

	if Locales[Config.Locale] ~= nil then

		if Locales[Config.Locale][str] ~= nil then
			return string.format(Locales[Config.Locale][str], ...)
		else
			return 'Перевод [' .. Config.Locale .. '][' .. str .. '] отсутствует'
		end

	else
		return 'Локаль [' .. Config.Locale .. '] отсутствует'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end

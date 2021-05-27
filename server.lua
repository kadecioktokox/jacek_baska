ESX             = nil

local cenaLeczenia = 10000

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_baska:kupLeczenie', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= cenaLeczenia then
		xPlayer.removeMoney(cenaLeczenia)
		TriggerClientEvent('esx:showNotification', source, 'Zapłaciłeś za leczenie ~g~5000$')
		cb(true)
	else
		cb(false)
	end
end)
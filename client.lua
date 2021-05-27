KOSSEK              = {}

KOSSEK.Zones = {
		Doctor =	{
		Pos = {
		{x = 321.9, y = -590.23, z = 42.35, name = 'ped', h = 152.00,		sprite = 51,	color = 59}, -- pillbox
		{x = 1827.83, y = 3684.78, z = 33.4, name = 'ped', h = 230.00,		sprite = 51,	color = 59}, -- sandy
		{x = -255.89, y = 6329.18, z = 31.5, name = 'ped', h = 5.00,		sprite = 51,	color = 59}, -- paleto
		},
		Napis = {
		{x = 321.9, y = -590.23, z = 43.35, h = 152.00}, -- pillbox
		{x = 1827.83, y = 3684.78, z = 34.4, h = 230.00}, -- sandy
		{x = -255.89, y = 6329.18, z = 32.5, h = 5.00}, -- paleto
		}
	}
}



local cam = nil


ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
    
    RequestModel(GetHashKey("s_m_m_doctor_01"))
    while not HasModelLoaded(GetHashKey("s_m_m_doctor_01")) do
      Wait(10)
    end

	for k,v in pairs(KOSSEK.Zones) do
		for i = 1, #v.Pos, 1 do
			local hospitalped =  CreatePed(4, 0xd47303ac, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.1, v.Pos[i].h, false, true)
			SetEntityHeading(hospitalped, v.Pos[i].h)
			FreezeEntityPosition(hospitalped, true)
			SetEntityInvincible(hospitalped, true)
			SetBlockingOfNonTemporaryEvents(hospitalped, true)
		end
	end
	  
end)	

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
		local plyCoords = GetEntityCoords(PlayerPedId(), 0)
		for k,v in pairs(KOSSEK.Zones) do
			for i = 1, #v.Napis, 1 do
		local distance = #(vector3(v.Napis[i].x, v.Napis[i].y, v.Napis[i].z) - plyCoords)
		if distance < 10 then
      

            if not IsPedInAnyVehicle(PlayerPedId(), true) then
				if distance < 3 then
					ESX.Game.Utils.DrawText3D(vector3(v.Napis[i].x, v.Napis[i].y, v.Napis[i].z), 'NACIŚNIJ [~g~E~s~] ABY SIĘ ULECZYĆ KOSZT: 10000$', 0.5)
					if IsControlJustReleased(0, 38) then
						local ilemedykow = exports['esx_scoreboard']:BierFrakcje("ambulance")
						--if ilemedykow <= 3 then
						if ilemedykow < 1 then
                        if (GetEntityHealth(PlayerPedId()) < 200) then
							--ESX.TriggerServerCallback('szpitallokalny:countambulance', function(jest)
								--if jest == 0 then
									TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, false)
									FreezeEntityPosition(GetPlayerPed(-1), true)
									ESX.TriggerServerCallback('esx_baska:kupLeczenie', function(bought)
										if bought then
											--TriggerEvent("pNotify:SendNotification", {text = 'Doktor sie tobą zajmuje, poczekaj chwile!', timeout=15000})
											ESX.ShowNotification('Doktor sie tobą zajmuje, poczekaj chwile!')
									        Citizen.Wait(15000)
											--TriggerEvent('pNotify:SendNotification', {text = "Twoje leczenie zakończyło się<font color=green> pozytywnie</font>!"})
											ESX.ShowNotification('Twoje leczenie zakończyło się ~g~pozytywnie~w~!')
											TriggerEvent('esx_ambulancejob:revivee')
										else
											--TriggerEvent('pNotify:SendNotification', {text = "Potrzebujesz <font color=green> $2000</font> aby ukończyć leczenie!"})
											ESX.ShowNotification('Potrzebujesz ~r~10000$~w~ aby ukończyć leczenie!')
										end
									end)	
									FreezeEntityPosition(GetPlayerPed(-1), false)
									ClearPedTasks(GetPlayerPed(-1)) 
								--else
									--TriggerEvent('pNotify:SendNotification', {text = "Udaj się do medyka aktualnie pełniącego służbę!"})
										--ESX.ShowNotification('Udaj się do medyka aktualnie pełniącego służbę!')
								--end
							--end)
                        else
							--TriggerEvent('pNotify:SendNotification', {text = "<font color=red>Nie potrzebujesz</font> pomocy medycznej!"})
							ESX.ShowNotification('~r~Nie potrzebujesz~w~ pomocy medycznej!')
						end
					else
						ESX.ShowNotification('~r~Udaj się do medyka pełniącego służbe, aby skorzystać z pomcy medycznej')
					end
						
                    end
                end
            end
        else
           -- Citizen.Wait(1000)
		end
	end
end
    end
end)
ESX  = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject' , function(obj)
			ESX = obj
		end)
		Citizen.Wait(360)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded' , function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded   = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob' , function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			if IsControlJustPressed(1, 57) then
			  if vehicleType(GetVehiclePedIsUsing(GetPlayerPed(-1))) then
				polspeak()
			  else
				ESX.ShowNotification('Debes estar dentro de un vehiculo gubernamental')
			  end
			end
		end
    end
end)

function polspeak()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'police_actions', {
		title    = 'ALERTAS',
		align    = 'bottom-right',
		elements = {
			{label = 'LSDP', value = 'lsdp'},
			{label = 'FBI', value = 'fbi'},
	}}, function(data, menu)
		if data.current.value == 'lsdp' then
			local elements = {
				{label = 'Stop the car', value = 'detente'},
				{label = 'Its time to over..', value = 'tiempo'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = ('ALERTAS'),
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)		
				local action = data2.current.value
					if action == 'detente' then
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "nombredelarchivo", 0.6)
					elseif action == 'tiempo' then
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "nombredelarchivo", 0.6)
					end
			end, function(data2, menu2)
				menu2.close()
			end)		
		elseif data.current.value == 'fbi' then
			local elements = {
				{label = 'Algo', value = 'algoaca'},
				{label = 'Algo dos', value = 'algoacados'},
			}
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = ('ALERTAS'),
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local action = data2.current.value

					if action == 'algoaca' then
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "nombredelarchivo", 0.6)
					elseif action == 'algoacados' then
						TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 30.0, "nombredelarchivo", 0.6)
					end
			end, function(data2, menu2)
				menu2.close()
			end)
	end, function(data, menu)
		menu.close()
	end)
end

function vehicleType(using)
	local cars = Config.Vehicles
		for i=1, #cars, 1 do
			if IsVehicleModel(using, GetHashKey(cars[i])) then
			return true
		end
	end
end
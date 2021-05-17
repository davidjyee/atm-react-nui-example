RegisterCommand('atm', function(source, args)
	local subcommand = args[1] or "show"

	if(subcommand == 'hide')
	then
		SendNUIMessage({
			type = "atm-visibility",
			visibility = false
		})
	elseif(subcommand == 'show')
	then
		SendNUIMessage({
			type = "atm-visibility",
			visibility = true
		})
	end
	
end, false)

RegisterNUICallback('depositAtm', function(data, cb)
	local depositAmount = data.amount
	
	-- Do validation
	
	-- Debug output
	TriggerEvent("chat:addMessage", {
		args = { 'Attempting to deposit', depositAmount }
	})
	
	-- Return that it was a success
	cb({
		success = true
	})
end)
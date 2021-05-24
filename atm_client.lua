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

RegisterNUICallback('focus', function(data, cb)
	local focus = data.focus or false

	SetNuiFocus(focus, focus)
	
	cb({})
end)

RegisterNUICallback('transaction/commit', function(data, cb)
	local type = data.type
	local amount = data.amount
	local destination = data.destination
	local origin = data.origin
	local initiator = data.initiator
	
	-- Do validation

	-- Process transaction
	if(type == 'DEPOSIT') then
		TriggerEvent("chat:addMessage", {
			args = { initiator, 'is attempting to deposit ', amount, ' into ', destination }
		})
	elseif(type == 'WITHDRAWAL') then
		TriggerEvent("chat:addMessage", {
			args = { initiator, 'is attempting to withdraw ', amount, ' from ', origin }
		})
	elseif(type == 'TRANSFER') then
		TriggerEvent("chat:addMessage", {
			args = { initiator, 'is attempting to transfer ', amount, ' from ', origin, ' to ', destination }
		})
	else
		print('ERROR: INVALID TRANSACTION TYPE')
		cb({
			success = 'false'
		})
	end

	-- Return that it was a success
	cb({
		success = 'true'
	})
end)
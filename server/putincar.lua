RegisterNetEvent("outlaw_putincar:putInCar", function(targetServerId, netVehicleId)
    local seat = 0
    TriggerClientEvent("bsf_carry:client:intoVehicle", targetServerId, netVehicleId, seat)
end)


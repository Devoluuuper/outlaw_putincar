RegisterCommand("putincar", function()
    local isCarrying = exports["takenncs-scripts"]:isCarrying()

    if not isCarrying then
        QBCore.Functions.Notify("Sa ei kanna kedagi!", "error")
        return
    end

    local targetServerId = exports["takenncs-scripts"]:getCarriedPlayerServerId()
    if not targetServerId or targetServerId == -1 then
        QBCore.Functions.Notify("Ei leia carried mängijat!", "error")
        return
    end

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        local coords = GetEntityCoords(playerPed)
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 70)
    end

    if vehicle == 0 or not DoesEntityExist(vehicle) then
        QBCore.Functions.Notify("Läheduses ei ole autot!", "error")
        return
    end
    local animDict = "missfinale_c2ig_11"
    local animName = "lift_a_pos"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end

    TaskPlayAnim(playerPed, animDict, animName, 8.0, -8.0, 1000, 49, 0, false, false, false)
    Wait(1000) 

    local netId = VehToNet(vehicle)
    TriggerServerEvent("outlaw_putincar:putInCar", targetServerId, netId)
    ClearPedSecondaryTask(playerPed)
    DetachEntity(playerPed, true, false)
end, false)

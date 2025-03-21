local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for _, location in pairs(Config.Locations) do
        exports['qb-target']:AddBoxZone("black_money_exchange_" .. location.job, location.coords, 1.5, 1.5, {
            name = "black_money_exchange_" .. location.job,
            heading = 0,
            debugPoly = false,
            minZ = location.coords.z - 1,
            maxZ = location.coords.z + 1
        }, {
            options = {
                {
                    type = "client",
                    event = "black_money:exchange",
                    icon = "fas fa-dollar-sign",
                    label = "Kara Para Bozdur",
                    job = location.job
                }
            },
            distance = 2.0
        })
    end
end)

RegisterNetEvent('black_money:exchange', function()
    TriggerServerEvent('black_money:exchangeMoney')
end)

local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('black_money:exchangeMoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local job = Player.PlayerData.job.name

    for _, location in pairs(Config.Locations) do
        if job == location.job then
            local black_money = Player.Functions.GetItemByName("black_money")
            if black_money and black_money.amount > 0 then
                Player.Functions.RemoveItem("black_money", black_money.amount)
                Player.Functions.AddMoney("cash", black_money.amount)
                TriggerClientEvent('QBCore:Notify', src, "Başarıyla " .. black_money.amount .. " kara para bozdurdun!", "success")

                local discordMessage = {
                    {
                        ["color"] = 16711680, 
                        ["title"] = "WRESTLER Kara Para Log",
                        ["fields"] = {
                            {
                                ["name"] = "👤 Kişi:",
                                ["value"] = "<@" .. Player.PlayerData.discord .. ">",
                                ["inline"] = true
                            },
                            {
                                ["name"] = "🆔 CitizenID:",
                                ["value"] = Player.PlayerData.citizenid,
                                ["inline"] = true
                            },
                            {
                                ["name"] = "🔑 FiveM Lisansı:",
                                ["value"] = Player.PlayerData.license,
                                ["inline"] = false
                            },
                            {
                                ["name"] = "💰 Kara Para Bilgileri:",
                                ["value"] = "💸 Aklanan Kara Para: **" .. black_money.amount .. "**\n💵 Kazanılan Temiz Para: **" .. black_money.amount .. "**",
                                ["inline"] = false
                            },
                            {
                                ["name"] = "🕰️ Saat:",
                                ["value"] = os.date("%Y-%m-%d %H:%M:%S"),
                                ["inline"] = false
                            }
                        },
                        ["footer"] = {
                            ["text"] = "WRESTLER Log Sistemi"
                        }
                    }
                }

                if Config.Webhook and Config.Webhook ~= "" then
                    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "WRESTLER Log", embeds = discordMessage}), { ['Content-Type'] = 'application/json' })
                else
                    print("^1[WRESTLER] Webhook URL bulunamadı! Lütfen config.lua dosyanızı kontrol edin.^0")
                end

            else
                TriggerClientEvent('QBCore:Notify', src, "Üzerinde kara para yok!", "error")
            end
            return
        end
    end
    TriggerClientEvent('QBCore:Notify', src, "Bu işlemi yapmaya yetkin yok!", "error")
end)

-- Function to send webhook messages with embeds
function SendWebhookMessage(webhookURL, message, color)
    if Config.EnableWebhook and webhookURL ~= "" then
        local embed = {
            {
                ["color"] = color, -- Color code (e.g., 16711680 for red)
                ["description"] = message,
                ["footer"] = {
                    ["text"] = os.date("%Y-%m-%d %H:%M:%S"),
                },
            }
        }

        PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({ username = 'AFK Monitor', embeds = embed }), { ['Content-Type'] = 'application/json' })
    end
end

-- Function to check if player is exempt
function IsPlayerExempt(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for _, identifier in ipairs(identifiers) do
        for _, exemptedLicense in ipairs(Config.ExemptedLicenses) do
            if identifier == exemptedLicense then
                return true
            end
        end
    end
    return false
end

-- Handle client request for exemption status
RegisterNetEvent('afk:checkExemption')
AddEventHandler('afk:checkExemption', function()
    local _source = source
    local exempt = IsPlayerExempt(_source)
    TriggerClientEvent('afk:setExempt', _source, exempt)
end)

-- Handle player warning
RegisterNetEvent('afk:playerWarned')
AddEventHandler('afk:playerWarned', function()
    local _source = source
    local playerName = GetPlayerName(_source)

    -- Send webhook message to the warning webhook URL with yellow color
    local warningMessage = Config.WebhookWarningMessage(playerName)
    SendWebhookMessage(Config.WarningWebhookURL, warningMessage, 16776960)  -- Yellow color
end)

-- Handle player kick
RegisterNetEvent('afk:kickPlayer')
AddEventHandler('afk:kickPlayer', function()
    local _source = source
    local playerName = GetPlayerName(_source)

    -- Send webhook message to the kick webhook URL with red color
    local kickMessage = Config.WebhookKickMessage(playerName)
    SendWebhookMessage(Config.KickWebhookURL, kickMessage, 16711680)  -- Red color

    -- Kick the player
    DropPlayer(_source, "You have been kicked for being AFK.")
end)

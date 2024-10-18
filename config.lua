Config = {}

-- Time settings in seconds
Config.AFKTimeout = 900      -- Time before warning the player (default: 5 minutes)
Config.WarningTime = 60       -- Time between warning and kick (default: 1 minute)

-- Safe Zones (Add as many as you like)
Config.SafeZones = {
    { x = -76.7311, y = -820.4271, z = 284.9999, radius = 15.0 },  -- Example Safe Zone
    -- { x = xCoord, y = yCoord, z = zCoord, radius = radius },
}

-- Warning Message
Config.WarningMessage = "You are about to be kicked for being AFK!"

-- Sound Notification (Make sure the sound file is available on the client)
Config.WarningSound = 'HUD_AWARDS'  -- Default GTA soundset
Config.WarningSoundName = 'OTHER_TEXT'       -- Default GTA sound

-- Webhook Settings
Config.EnableWebhook = true  -- Set to 'false' to disable webhook notifications

-- Separate Webhook URLs
Config.WarningWebhookURL = "https://discord.com/api/webhooks/your_warning_webhook_url_here"
Config.KickWebhookURL = "https://discord.com/api/webhooks/your_kick_webhook_url_here"

-- Customize webhook messages
Config.WebhookWarningMessage = function(playerName)
    return "**" .. playerName .. "** has been warned for being AFK."
end

Config.WebhookKickMessage = function(playerName)
    return "**" .. playerName .. "** has been kicked for being AFK."
end

-- Exempted Licenses (Players with these licenses will be exempt from the AFK timer)
Config.ExemptedLicenses = {
    "license:7002513d561b47e0b56f5b577b5a64ef2bd7b013",
    -- Add more licenses as needed
}

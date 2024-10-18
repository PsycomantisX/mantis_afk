# mantis_afk

**AFK Kick Script with Safe Zones, Warnings, Exemptions, and Webhook Notifications**

## Introduction

**mantis_afk** is a FiveM script designed to automatically kick players who are AFK (Away From Keyboard) after a specified period. The script includes features such as safe zones where the AFK timer is disabled, warnings with customizable notifications, exemptions for specific players, and webhook notifications for administrative monitoring.

## Features

- **AFK Detection**: Kicks players who are inactive for a specified amount of time.
- **Safe Zones**: Areas where the AFK timer is disabled.
- **Warning Notifications**: Sends a warning to players before they are kicked.
- **Customizable Notifications**: Integrate any notification script or method.
- **Exempted Licenses**: Specify players who are exempt from the AFK timer.
- **Webhook Notifications**: Sends messages to Discord webhooks when players are warned or kicked.
- **Configurable Timers**: Set the AFK timeout and warning duration.

## Requirements

- **FiveM Server**: Ensure you have a running FiveM server.
- **Notification Script**: Optional, depending on your notification method (e.g., `okokNotify`, `mythic_notify`, ESX notifications).

## Installation

1. **Download the Script**: Download the `mantis_afk` resource files.
2. **Place in Resources Folder**: Move the `mantis_afk` folder to your server's `resources` directory.
3. **Ensure the Resource**: Open your `server.cfg` file and add the following line:
   ```
   ensure mantis_afk
   ```
4. **Install Notification Script (Optional)**: If you're using a notification script, ensure it's installed and added to `server.cfg`.

## Configuration

### AFK Timers

Open `config.lua` and adjust the following settings:

- **AFK Timeout**: Time before warning the player (in seconds).
  ```lua
  Config.AFKTimeout = 300  -- Default is 300 seconds (5 minutes)
  ```
- **Warning Time**: Time between the warning and the kick (in seconds).
  ```lua
  Config.WarningTime = 60  -- Default is 60 seconds (1 minute)
  ```

### Safe Zones

Define areas where the AFK timer is disabled:

```lua
Config.SafeZones = {
    { x = 200.0, y = -925.0, z = 30.7, radius = 50.0 },  -- Example Safe Zone
    -- Add more safe zones as needed
}
```
- **x, y, z**: Coordinates of the center of the safe zone.
- **radius**: Radius of the safe zone in meters.

### Warning Message

Customize the warning message displayed to players:

```lua
Config.WarningMessage = "You are about to be kicked for being AFK!"
```

### Sound Notification

Configure the sound played when a warning is issued:

```lua
Config.WarningSound = 'HUD_MINI_GAME_SOUNDSET'  -- Soundset name
Config.WarningSoundName = '5_SEC_WARNING'       -- Sound name
```
- **Note**: These are default GTA V sounds. You can change them to any valid soundset and sound name.

### Webhook Notifications

Enable and configure webhook notifications:

- **Enable or Disable Webhooks**:
  ```lua
  Config.EnableWebhook = true  -- Set to 'false' to disable webhook notifications
  ```
- **Webhook URLs**:
  ```lua
  Config.WarningWebhookURL = "https://discord.com/api/webhooks/your_warning_webhook_url_here"
  Config.KickWebhookURL = "https://discord.com/api/webhooks/your_kick_webhook_url_here"
  ```
- **Customize Webhook Messages**:
  ```lua
  Config.WebhookWarningMessage = function(playerName)
      return "**" .. playerName .. "** has been warned for being AFK."
  end

  Config.WebhookKickMessage = function(playerName)
      return "**" .. playerName .. "** has been kicked for being AFK."
  end
  ```
- **Important**: Replace the webhook URLs with your actual Discord webhook URLs.

### Exempted Licenses

Specify player licenses that are exempt from the AFK timer:

```lua
Config.ExemptedLicenses = {
    "license:7002513d561b47e0b56f5b577b5a64ef2bd7b013",
    -- Add more licenses as needed
}
```
- **Note**: You can find player license identifiers in the server console or via admin tools.

## Customization

### DisplayAFKWarning Function

The `DisplayAFKWarning()` function in `client.lua` is where you insert your custom notification code. This allows you to use any notification method you prefer.

**Example using `okokNotify`:**
```lua
function DisplayAFKWarning()
    TriggerEvent('okokNotify:Alert', "AFK Warning", Config.WarningMessage, Config.WarningTime * 1000, 'warning')
end
```

**Example using `mythic_notify`:**
```lua
function DisplayAFKWarning()
    exports['mythic_notify']:DoLongHudText('error', Config.WarningMessage)
end
```

**Example using ESX Notification:**
```lua
function DisplayAFKWarning()
    ESX.ShowNotification(Config.WarningMessage)
end
```

**Example using Chat Message:**
```lua
function DisplayAFKWarning()
    TriggerEvent('chat:addMessage', {
        color = {255, 0, 0},
        multiline = true,
        args = {"[AFK Warning]", Config.WarningMessage}
    })
end
```

## Usage

1. **Start the Server**: Run your FiveM server with the `mantis_afk` resource ensured.
2. **AFK Detection**: The script will automatically detect when players are AFK based on the configured timers.
3. **Safe Zones**: Players inside defined safe zones will not be affected by the AFK timer.
4. **Exempted Players**: Players with licenses listed in `Config.ExemptedLicenses` are exempt from the AFK timer.

## Testing

### AFK Warning Test

1. Join the server and go to an area outside any safe zones.
2. Remain idle (do not move or perform actions) for the duration specified in `Config.AFKTimeout`.
3. Verify that you receive the AFK warning notification.
4. Check if a webhook message was sent to the warning webhook URL.

### AFK Kick Test

1. After receiving the warning, continue to remain idle for the duration specified in `Config.WarningTime`.
2. Verify that you are kicked from the server with the message "You have been kicked for being AFK."
3. Check if a webhook message was sent to the kick webhook URL.

### Exemption Test

1. Add your license identifier to `Config.ExemptedLicenses`.
2. Join the server and remain idle.
3. Verify that you do not receive any AFK warnings or get kicked.

## Troubleshooting

- **Notifications Not Appearing**:
  - Ensure your notification script is installed and running.
  - Verify that you inserted the correct notification code in the `DisplayAFKWarning()` function.
  - Check the client console (F8) for any errors.

- **Webhook Messages Not Sending**:
  - Verify that the webhook URLs in `config.lua` are correct.
  - Check the server console for any errors.
  - Ensure your server has internet access to reach Discord's servers.

- **Players Not Being Kicked**:
  - Ensure that the AFK timers in `config.lua` are correctly set.
  - Verify that there are no syntax errors in `client.lua` or `server.lua`.
  - Check if the player is exempted by mistake.

- **Script Errors**:
  - Check both client and server consoles for any Lua errors.
  - Ensure all dependencies are met and resources are started in the correct order.

## Credits

- **Developer**: PsycomantisX
- **Contributors**: List any contributors or resources you used.

## License

This project is licensed under the MIT License. You are free to use, modify, and distribute this script.

# Happy Gaming!

If you have any questions or need further assistance, feel free to reach out.

**Note**: Replace placeholders like `your_warning_webhook_url_here` with your actual data. Ensure that you comply with the licenses of any third-party resources or scripts you use.


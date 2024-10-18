local afkTimer = 0
local isInSafeZone = false
local hasWarned = false
local isExempt = false

-- Request exemption status when the resource starts
Citizen.CreateThread(function()
    TriggerServerEvent('afk:checkExemption')
end)

-- Receive the exemption status from the server
RegisterNetEvent('afk:setExempt')
AddEventHandler('afk:setExempt', function(exempt)
    isExempt = exempt
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)  -- Check every second

        if not isExempt then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, true) then
                -- Reset timer if in vehicle
                afkTimer = 0
                hasWarned = false
            else
                -- Check movement
                if IsPlayerMoving() then
                    afkTimer = 0
                    hasWarned = false
                else
                    afkTimer = afkTimer + 1
                end
            end

            -- Check if in Safe Zone
            isInSafeZone = CheckSafeZones()

            if not isInSafeZone then
                if afkTimer >= Config.AFKTimeout and not hasWarned then
                    TriggerEvent('afk:warning')
                    hasWarned = true
                    -- Notify server about the warning
                    TriggerServerEvent('afk:playerWarned')
                elseif afkTimer >= (Config.AFKTimeout + Config.WarningTime) then
                    TriggerServerEvent('afk:kickPlayer')
                end
            else
                afkTimer = 0
                hasWarned = false
            end
        end
    end
end)

function IsPlayerMoving()
    local ped = PlayerPedId()
    local vx, vy, vz = table.unpack(GetEntityVelocity(ped))
    return (vx ~= 0 or vy ~= 0 or vz ~= 0)
end

function CheckSafeZones()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for _, zone in pairs(Config.SafeZones) do
        local distance = GetDistanceBetweenCoords(playerCoords, zone.x, zone.y, zone.z, true)
        if distance <= zone.radius then
            return true
        end
    end
    return false
end

RegisterNetEvent('afk:warning')
AddEventHandler('afk:warning', function()
    -- Display the AFK warning notification
    DisplayAFKWarning()
    -- Play sound
    PlaySoundFrontend(-1, Config.WarningSoundName, Config.WarningSound, true)
end)

-- Function to display the AFK warning notification
function DisplayAFKWarning()
    -- Insert your notification code here

    -- Example using chat message:
    -- TriggerEvent('chat:addMessage', {
    --     color = {255, 0, 0},
    --     multiline = true,
    --     args = {"[AFK Warning]", Config.WarningMessage}
    -- })

    -- Example using okokNotify:
    TriggerEvent('okokNotify:Alert', "AFK Warning", Config.WarningMessage, Config.WarningTime * 1000, 'warning')

    -- Example using mythic_notify:
    -- exports['mythic_notify']:DoLongHudText('error', Config.WarningMessage)

    -- Example using ESX ShowNotification:
    -- ESX.ShowNotification(Config.WarningMessage)
end

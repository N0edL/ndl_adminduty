local display, duty, logs = false

-- Function to update player information in the admin UI
local function updatePlayerInfo(adminList)
    local localPlayerId = PlayerId() 
    for _, playerInfo in ipairs(adminList) do
        if playerInfo.id == localPlayerId then
            playerInfo.self = true
        else
            playerInfo.self = false
        end
    end

    SendNUIMessage({
        type = 'updatePlayerInfo',
        adminList = adminList
    })
end

-- Function to set the display state of the admin UI
local function SetDisplay(bool)
    display = bool
    name = GetPlayerName(PlayerId())

    SendNUIMessage({
        type = "Info",
        name = name,
        dienst = duty,
        logs = logs
    })

    SendNUIMessage({
        type = 'updatePlayerInfo',
        adminList = adminList
    })

    local adminList = {}
    for _, playerId in ipairs(GetActivePlayers()) do
        local playerInfo = {
            id = playerId,
            name = GetPlayerName(playerId),
        }
        table.insert(adminList, playerInfo)
    end

    updatePlayerInfo(adminList)

    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "off",
        status = bool
    })
end

-- Register the "adminmenu" command
RegisterCommand("adminmenu", function(source)
    -- Trigger server callback to check if the player has permissions
    ESX.TriggerServerCallback('ndl_adminui:hasperms', function(hasPerms)
        if hasPerms then
            SetDisplay(true)
        else
            print("^1You do not have permission to use /adminmenu command.^7")
            TriggerEvent('chat:addMessage', {
                color = {255, 0, 0},
                multiline = true,
                args = {"Admin", "You do not have permission to use this command."}
            })
        end
    end)
end)

-- Register the key mapping for the "adminmenu" command
RegisterKeyMapping('adminmenu', 'Admin Menu', 'keyboard', 'HOME')

-- Callback function for the "exit" event in the admin UI
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

-- Callback function for the "dutybutton" event in the admin UI
RegisterNUICallback("dutybutton", function(data)
    SetDisplay(false)
    duty = not duty

    TriggerEvent('ndl_admin:toggleDuty') -- Replace this with your own event when the player is going on/off duty!

end)

-- Callback function for the "logsknop" event in the admin UI
RegisterNUICallback("extrabutton", function(data)
    SetDisplay(false)
    logs = not logs

    TriggerEvent('ndl_admin:toggleExtras') -- Replace this with your own event when the player is toggling extras!
end)

-- Callback to check if the player has permissions
ESX.RegisterServerCallback('ndl_adminui:hasperms', function(source, cb)
    if IsPlayerAceAllowed(source, 'ndl_admin') then
        cb(true)
    else
        cb(false)
    end
end)

----
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    if resourceName  == 'ndl_adminui' then
        Citizen.Wait(2250)
        local currentVersion = GetResourceMetadata(resourceName, 'version', 0)
        if currentVersion then
            currentVersion = currentVersion:match('%d+%.%d+%.%d+')
        end
        SetTimeout(1000, function()
            PerformHttpRequest('https://api.github.com/repos/N0edL/ndl_adminduty/releases/latest', function(status, response)
                if status ~= 200 then return end
                response = json.decode(response)
                if response.prerelease then return end
                local latestVersion = response.tag_name:match('%d+%.%d+%.%d+')
                if not latestVersion or latestVersion == currentVersion then return end
                local cv = { string.strsplit('.', currentVersion) }
                local lv = { string.strsplit('.', latestVersion) }
                for i = 1, #cv do
                    local current, minimum = tonumber(cv[i]), tonumber(lv[i])
                    if current ~= minimum then
                        if current < minimum then
                            return print(('^3An update is available\r\n%s^0'):format(response.html_url))
                        else
                            break 
                        end
                    end
                end
            end, 'GET')
        end)
    else
        print('^1[ERROR] Please rename the resource to ndl_staffzaak for the ui to work!^7')
    end
end)
local showingText = false
local washing = false
local ped = nil

CreateThread(function()
    while true do
        Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local dist = #(coords - vec3(Config.WashLocation.x, Config.WashLocation.y, Config.WashLocation.z))

        if dist < Config.WashRadius then
            if not showingText then
                showingText = true
                exports.lation_ui:showText({
                    title = Config.Locales.title_wash,
                    description = Config.Locales.desc_press_e,
                    keybind = Config.TextUiKey,
                    icon = 'fas fa-money-bill-wave',
                    iconColor = '#3B82F6'
                })
            end

            if IsControlJustReleased(0, Config.WashKey) and not washing then
                washing = true
                TriggerServerEvent('esx_moneywash:checkBlackMoney')
            end
        else
            if showingText then
                showingText = false
                exports.lation_ui:hideText()
            end
        end
    end
end)

-- Notification Handler
RegisterNetEvent('esx_moneywash:notify', function(data)
    exports.lation_ui:notify(data)
end)

-- Start Washing
RegisterNetEvent('esx_moneywash:startWashing', function()
    local success = exports.lation_ui:progressBar({
        label = Config.Locales.progress_label,
        description = Config.Locales.progress_desc,
        duration = 8000,
        icon = 'fas fa-money-bill-wave',
        iconColor = '#FFD700',
        color = '#4CAF50',
        disable = {
            move = true,
            combat = true,
            car = true,
        },
        anim = {
            dict = 'anim@amb@business@coc@coc_unpack_cut@',
            clip = 'fullcut_cycle_v3_pressoperator'
        },
        prop = {
            model = 'prop_money_bag_01',
            bone = 57005,
            pos = vec3(0.12, 0.02, -0.06),
            rot = vec3(0.0, 0.0, 0.0)
        }
    })

    if success then
        TriggerServerEvent('esx_moneywash:washMoney')
    else
        exports.lation_ui:notify({
            title = Config.Locales.abort_title,
            message = Config.Locales.notify_aborted,
            type = 'warning',
            position = 'top'
        })
    end

    washing = false
end)

-- PED-Spawn
CreateThread(function()
    local model = Config.WashPedModel

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local coords = vec3(Config.WashLocation.x, Config.WashLocation.y, Config.WashLocation.z)
    local heading = Config.WashLocation.w

    ped = CreatePed(0, model, coords.x, coords.y, coords.z - 1.0, heading, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

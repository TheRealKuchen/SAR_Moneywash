ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_moneywash:checkBlackMoney')
AddEventHandler('esx_moneywash:checkBlackMoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local blackMoney = xPlayer.getAccount('black_money').money

    if blackMoney > 0 then
        TriggerClientEvent('esx_moneywash:startWashing', src)
    else
        TriggerClientEvent('esx_moneywash:notify', src, {
            title = Config.Locales.error_title,
            message = Config.Locales.notify_no_money,
            type = 'error',
            position = 'top'
        })
    end
end)

RegisterServerEvent('esx_moneywash:washMoney')
AddEventHandler('esx_moneywash:washMoney', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local blackMoney = xPlayer.getAccount('black_money').money

    if blackMoney > 0 then
        local washed = math.floor(blackMoney * Config.WashRate)
        xPlayer.removeAccountMoney('black_money', blackMoney)
        xPlayer.addMoney(washed)

        TriggerClientEvent('esx_moneywash:notify', src, {
            title = Config.Locales.success_title,
            message = Config.Locales.notify_success(washed),
            type = 'success',
            position = 'top'
        })
    else
        TriggerClientEvent('esx_moneywash:notify', src, {
            title = Config.Locales.error_title,
            message = Config.Locales.notify_no_more_money,
            type = 'error',
            position = 'top'
        })
    end
end)

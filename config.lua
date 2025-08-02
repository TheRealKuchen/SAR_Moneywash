Config = {}
--test version 1.0.2
-- or e.g. 'g_m_m_mexboss_01'
Config.WashPedModel = 'G_M_Y_MexGoon_02'
-- x, y, z, heading
Config.WashLocation = vec4(1135.654, -987.490, 46.113, 242.12)
-- interaction distance
Config.WashRadius = 2.0
-- keybind default (38 = E) https://docs.fivem.net/docs/game-references/controls/
Config.WashKey = 38
-- Which key is displayed in the TextUi
Config.TextUiKey = "E"
-- What percentage of the dirty money will be paid out?
Config.WashRate = 0.7 -- 70%
-- Translations
Config.Locales = {
    title_wash = "Money Laundering",
    desc_press_e = "Press to launder your dirty money",
    progress_label = "Laundering Money",
    progress_desc = "Your dirty money is being exchanged...",
    notify_no_money = "You don't have any dirty money on you.",
    notify_success = function(amount) return "You have laundered $" .. amount .. "." end,
    notify_no_more_money = "No more dirty money available.",
    notify_aborted = "Money laundering was interrupted.",
    error_title = "Error",
    success_title = "Success",
    abort_title = "Aborted"
}
SMODS.Joker {
    key = "burgz",
    rarity = 3,
    cost = 7,
    pools = {Music = true, rarity = "Rare"},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    pronouns = "he_him",
    pos = {x = 0, y = 0},
    atlas = "placeholder",
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "entr_pure"}
    end,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            if G.GAME.joker_buffer + #G.jokers.cards < G.jokers.config.card_limit then
                G.E_MANAGER:add_event(Event{
                    func = function()
                        local ncard = SMODS.add_card{
                            set = "Food",
                            area = G.jokers
                        }
                        ---@diagnostic disable-next-line: need-check-nil
                        ncard.ability.entr_pure = true
                        G.GAME.joker_buffer = 0
                        return true
                    end
                })
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                return nil, true
            end
        end
    end,
}
SMODS.Joker {
    key = "burgz",
    rarity = 3,
    cost = 7,
    pools = {Music = true},
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

SMODS.Joker {
    key = "vengeful_sun",
    atlas = "awesomejokers",
    pos = {x = 2, y = 7},
    pixel_size = { h = 70 },
    discovered = true,
    rarity = 3,
    pronouns = "they_them",
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 4,
    config = {extra = {add = 1, }},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.add, card.ability.extra.add/10},}
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            return {
                plus_asc = card.ability.extra.add,
                asc = 1+(card.ability.extra.add/10),
                exp_asc = 1+(card.ability.extra.add/100),
            }
        end
        if context.MDJ_mod_key_and_amount then
            local key = context.MDJ_key
            local amount = context.MDJ_amount
            local operation = MyDreamJournal.realascmodkeys[key]
            local op_number = MyDreamJournal.keystonumbers[operation]
            local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
            if operation and op_number then
                -- handle generalized higher order hyperoperations
                local is_hyper = false
                if op_number == 4 then
                    op_number = amount[1]
                    is_hyper = true
                end
                -- mult has the same amount to add as add
                if op_number ~= -1 and op_number ~= 0 then
                    op_number = card.ability.extra.add / (10 ^ op_number)
                else
                    op_number = card.ability.extra.add
                end
                if is_dark then
                    op_number = op_number * 2
                end
                if not is_hyper then
                    amount = amount + op_number
                else
                    amount[2] = amount[2] + op_number
                end
            end
			return {
				MDJ_amount = amount,
				MDJ_key = key
			}
        end
    end
}
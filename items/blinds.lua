SMODS.Blind {
    key = "steel",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 1 },
    atlas = "blinds",
    boss = { min = 2 },
    boss_colour = HEX("2faae5"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.MDJ_mod_key_and_amount then
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                if MyDreamJournal.plustox[context.MDJ_key] then
                    return {
                        MDJ_amount = context.MDJ_amount/2
                    }
                end
            end
        end
    end
}
SMODS.Blind {
    key = "final_star",
    dollars = 8,
    mult = 0.1,
    pos = { x = 0, y = 2 },
    atlas = "blinds",
    boss = { showdown = true },
    boss_colour = HEX("ffd700"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.MDJ_mod_key_and_amount then
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                local amount = context.MDJ_amount
                if (type(amount) == "table" and amount.arrow) or type(amount) == "number" then
                    return {
                        MDJ_amount = amount^0.5
                    }
                end
                -- shouldn't be posssible without tailsman
                if type(amount) == "table" and amount[1] and to_big(amount[1]) <= to_big(4) and amount[2] and type(amount[2]) == "table" and amount[2].arrow then
                    return {
                        MDJ_amount = {amount[1], amount[2]^0.5}
                    }
                end
            end
        end
    end
}
SMODS.Blind {
    key = "video",
    dollars = 5,
    mult = 2,
    atlas = "blinds",
    pos = { x = 0, y = 0 },
    boss = { min = 5 },
    boss_colour = HEX("2faae5"),
    recalc_debuff = function(self, card, from_blind)
        if (card.area == G.jokers) and not G.GAME.blind.disabled and (MyDreamJournal.is_music(card)) then
            return true
        end
        return false
    end,
    in_pool = function(self)
        if not G.jokers then return false end
        for i, j in pairs(G.jokers.cards) do
            if (MyDreamJournal.is_music(j)) then
                return true
            end
        end
        return false
    end
}
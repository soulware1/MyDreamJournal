SMODS.Blind {
    key = "steel",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 0 },
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
    pos = { x = 0, y = 1 },
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
                if type(amount) == "table" and amount[1] and to_big(amount[1]) <= to_big(4) then
                    return {
                        MDJ_amount = {amount[1], amount[2]^0.5}
                    }
                end
            end
        end
    end
}
SMODS.Voucher {
    key = 'dialup',
    pos = { x = 2, y = 0 },
    atlas = "placeholder",
    config = { extra = { amount = 4 }, immutable = { firsttrigger = true } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount } }
    end,
    calculate = function (self, card, context)
        if context.after then
            card.ability.immutable.firsttrigger = true
        end
        if context.MDJ_mod_key_and_amount and card.ability.immutable.firsttrigger and MyDreamJournal.plusmulttoxmult[context.MDJ_key] then
            card.ability.immutable.firsttrigger = false
            return {
                MDJ_amount = context.MDJ_amount*card.ability.extra.amount
            }
        end
    end
}
SMODS.Voucher {
    key = '3g',
    pos = { x = 3, y = 0 },
    atlas = "placeholder",
    config = { extra = { amount = 4 }, immutable = { firsttrigger = true } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount } }
    end,
    calculate = function (self, card, context)
        if context.after then
            card.ability.immutable.firsttrigger = true
        end
        if context.MDJ_mod_key_and_amount and card.ability.immutable.firsttrigger and MyDreamJournal.xmulttoemult[context.MDJ_key] then
            card.ability.immutable.firsttrigger = false
            return {
                MDJ_amount = context.MDJ_amount*card.ability.extra.amount
            }
        end
    end
}
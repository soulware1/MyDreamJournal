SMODS.Sticker {
    key = "ouroboros",
    badge_colour = HEX('B55FD8'),
    atlas = "stickers",
    pos = { x = 2, y = 0 },
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end,
    apply = function(self,card,val)
        local to_remove = {}
        for _, v in pairs(card.ability) do
            if MyDreamJournal.eternalstickers[v] then
                to_remove[#to_remove+1] = v
            end
        end
        for _, v in ipairs(to_remove) do
            card.ability[v] = nil
        end
        card.ability.MDJ_ouroboros = true
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual and context.main_eval then
            local tail = SMODS.create_card(card.config.center.key)
            MyDreamJournal.ApplySticker(tail, "MDJ_ouroboros")
            SMODS.destroy_cards(card)
        end
    end
}
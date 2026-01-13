SMODS.Enhancement {
    key = 'envelope',
    pos = { x = 0, y = 0 },
    atlas = "enhancements",
    config = { },
    loc_vars = function(self, info_queue, card)
        return { vars = { (( card and ( card.area == G.hand or card.area == G.deck or card.area == G.play )) and 2*#MyDreamJournal.mass_concat(MyDreamJournal.localized_names(( G.hand and #G.hand.highlighted ~= 0 ) and { cards = G.hand.highlighted } or G.play ))) or 0 } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                chips = 2*#MyDreamJournal.mass_concat(MyDreamJournal.localized_names({ cards = context.full_hand }))
            }
        end
    end,
}
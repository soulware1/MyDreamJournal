SMODS.Joker {
    key = "forcedmove",
    atlas = 'awesomejokers',
    pos = { x = 9, y = 0 },
	discovered = true,
    rarity = MyDreamJournal.epic,
	pronouns = 'it_its',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 4,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
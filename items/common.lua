SMODS.Joker {
    key = "eyesjoker",
    atlas = 'awesomejokers',
    pos = { x = 4, y = 0 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_him',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 2,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
SMODS.Joker {
    key = "suitshuffle",
    atlas = 'awesomejokers',
    pos = { x = (G.SETTINGS.colourblind_option and 1) or 0, y = 2 },
	discovered = true,
    rarity = 1,
	pronouns = 'they_them',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 2,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
SMODS.Joker {
    key = "latin",
    atlas = 'awesomejokers',
    pos = { x = 6, y = 1 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_him',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 2,
    config = { extra = { add = 0.01 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add } }
    end,
}
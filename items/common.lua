SMODS.Joker {
    key = "eyesjoker",
    atlas = 'awesomejokers',
    pos = { x = 4, y = 0 },
	discovered = true,
    rarity = 1,
	loc_txt = {
        name = "Let's take a look",
		text = {
			"Debuff the {C:attention}Joker{} to the left.",
		}
    },
	pronouns = 'he_him',
    blueprint_compat = true,
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
	loc_txt = {
        name = 'Suit Shuffle',
		text = {
			"{C:spades}Hearts{} count as {C:hearts}Spades{}",
			"{C:hearts}Spades{} count as {C:spades}Hearts{}",
			"{C:diamonds}Clubs{} count as {C:clubs}Diamonds{}",
			"{C:clubs}Diamonds{} count as {C:diamonds}Clubs{}",
		}
    },
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
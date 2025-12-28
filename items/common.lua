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
if next(SMODS.find_mod("cardpronouns")) then
---@diagnostic disable-next-line: undefined-global
  CardPronouns.Pronoun {
    colour = HEX("00FF00"),
    text_colour = G.C.BLACK,
    pronoun_table = { "H3", "H1M" },
    in_pool = function()
      return false
    end,
    key = "he_him_leet"
  }
end
SMODS.Joker {
    key = "leet",
    atlas = 'awesomejokers',
    pos = { x = 8, y = 1 },
    soul_pos = { x = 7, y = 1 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_him_leet',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 3,
    config = { extra = { add = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add } }
    end,
}
SMODS.Joker {
    key = "mistake",
    atlas = 'awesomejokers',
    pos = { x = 7, y = 0 },
	discovered = true,
    rarity = 1,
	pronouns = 'it_its',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 3,
    immutable = true,
    config = { extra = { odds = 5 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds } }
    end,
    calculate = function (self, card, context)
        if context.mod_probability then
            return {
                numerator = 1,
                denominator = card.ability.extra.odds
            }
        end
    end
}
SMODS.Joker {
    key = "graph",
    pos = { x = 4, y = 3 },
    atlas = 'awesomejokers',
    pronouns = 'it_its',
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 3,
    discovered = true,
    config = { extra = { expo = 0.3 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.expo, colours = { G.C.DARK_EDITION } } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                mult = G.GAME.blind.chips^card.ability.extra.expo
            }
        end
    end
}
SMODS.Joker {
    key = "graph3",
    pos = { x = 6, y = 3 },
    atlas = 'awesomejokers',
    pronouns = 'it_its',
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 3,
    discovered = true,
    config = { extra = { add = 2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                sin_mult = card.ability.extra.add
            }
        end
    end
}
SMODS.Joker {
    key = "graph4",
    pos = { x = 7, y = 3 },
    atlas = 'awesomejokers',
    pronouns = 'it_its',
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 3,
    discovered = true,
    config = { extra = { add = 2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                cos_chips = card.ability.extra.add
            }
        end
    end
}
SMODS.Joker {
    key = "smfw",
    pos = { x = 8, y = 3 },
    atlas = 'awesomejokers',
    pronouns = 'it_its',
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 4,
    discovered = true,
    config = { extra = { }, },
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_no_suit(playing_card) then
                return true
            end
			if SMODS.has_no_rank(playing_card) then
				return true
			end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}
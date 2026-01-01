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
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 2,
    config = { extra = { add = 0.01 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add } }
    end,
    calculate = function (self, card, context)
        if context.MDJ_mod_key_and_amount then
            local key = context.MDJ_key
            local amount = context.MDJ_amount
            local converted_key = MyDreamJournal.plustox[key]
            local is_corrupted = card and (card.edition and card.edition.key == "e_MDJ_corrupted")
            local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
            if not converted_key then
                ---@diagnostic disable-next-line: redefined-local
                local converted_key = MyDreamJournal.xtoe[key]
                if is_corrupted and MyDreamJournal.xchipstoechips[key] then
                    local cchips = SMODS.Scoring_Parameters.chips.current
                    local achips = cchips * amount
                    amount = math.log(achips, cchips) + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
                    key = converted_key
                elseif not is_corrupted and MyDreamJournal.xmulttoemult[key] then
                    local cmult = SMODS.Scoring_Parameters.mult.current
                    local amult = cmult * amount
                    amount = math.log(amult, cmult) + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
                    key = converted_key
                end
            else
                if is_corrupted and MyDreamJournal.pluschipstoxchips[key] then
                    local cchips = SMODS.Scoring_Parameters.chips.current
                    local achips = cchips + amount
                    amount = achips / cchips + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
                    key = converted_key
                elseif not is_corrupted and MyDreamJournal.plusmulttoxmult[key] then
                    local cmult = SMODS.Scoring_Parameters.mult.current
                    local amult = cmult + amount
                    amount = amult / cmult + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
                    key = converted_key
                end
            end
            return {
                MDJ_key = key,
                MDJ_amount = amount
            }
        end
    end
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
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 7,
    config = { extra = { add = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add } }
    end,
    calculate = function (self, card, context)
        if context.MDJ_mod_key_and_amount and MyDreamJournal.dollarmodkeys[context.MDJ_key] then
            return {
                MDJ_amount = context.MDJ_amount+((not (card and (card.edition and card.edition.key == "e_MDJ_dark")) and card.ability.extra.add) or card.ability.extra.add*2)
            }
        end
    end
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
    cost = 6,
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
SMODS.Joker {
    key = "buffer",
    pos = { x = 0, y = 0 },
    atlas = 'buffer',
    pronouns = 'it_its',
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 1,
    discovered = true,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval then
            if G.GAME.chips > G.GAME.blind.chips then
                return {
                    eq_score = G.GAME.blind.chips
                }
            end
        end
    end
}
SMODS.Joker {
    key = "soulware",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 4,
	pronouns = 'he_him',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 20,
    config = { extra = { add = 3, extra = 0.5, }, },
    loc_vars = function(self, info_queue, card)
		-- 0.8333333333333334 because 3*0.8333333333333334 == 2.5 in float64
        return { vars = { card.ability.extra.add, card.ability.extra.add*0.8333333333333334, card.ability.extra.extra } }
    end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				mult = card.ability.extra.add,
				xmult = card.ability.extra.add*0.8333333333333334,
				emult = 1+(card.ability.extra.extra/2),
				eemult = 1+(card.ability.extra.extra/4),
				eeemult = 1+(card.ability.extra.extra/8),
			}
		end
	end
}
SMODS.Joker {
    key = "mindware",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 4,
	pronouns = 'they_them',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 20,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_MDJ_corrupted
        return { vars = {  } }
    end,
}
if next(SMODS.find_mod("cardpronouns")) then
---@diagnostic disable-next-line: undefined-global
	CardPronouns.Pronoun {
    colour = HEX("000000"),
    text_colour = G.C.WHITE,
    pronoun_table = { "ZZ", "aZZ" },
    in_pool = function()
      return false
    end,
    key = "ZZaZZ"
  }
end
SMODS.Joker {
    key = "decamark",
    atlas = 'awesomejokers',
    pos = { x = 2, y = 3 },
    soul_pos = { x = 3, y = 3 },
	discovered = true,
    rarity = 4,
	pronouns = 'ZZaZZ',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 20,
	-- so no one gets any funnny ideas!
	immutable = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                base_sum_mult = 1,
                base_sum_chips = 1,
            }
        end
    end
}

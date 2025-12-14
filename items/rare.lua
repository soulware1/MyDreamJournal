SMODS.Joker {
    key = "installer",
    atlas = 'awesomejokers',
    pos = { x = 2, y = 1 },
	discovered = true,
    rarity = 3,
	pronouns = 'any_all',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 10,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)

	if scalar_value > 0 and not args.dont_repeat then
		return {
			override_scalar_value = { -- this will override the scalar_value
				value = scalar_value*2, -- set the scalar_value to X
				-- other calculation return keys accepted here, timing is before the scaling event
			},
		}
	end
end
}

-- stolen from starspace :3c
if next(SMODS.find_mod("cardpronouns")) then
---@diagnostic disable-next-line: undefined-global
  CardPronouns.Pronoun {
    colour = HEX("80407E"),
    text_colour = G.C.WHITE,
    pronoun_table = { "She", "Its" },
    in_pool = function()
      return false
    end,
    key = "she_its"
  }
  CardPronouns.Pronoun {
    colour = HEX("405780"),
    text_colour = G.C.WHITE,
    pronoun_table = { "He", "Its" },
    in_pool = function()
      return false
    end,
    key = "he_its"
  }
end

SMODS.Joker {
    key = "compressed",
    atlas = 'awesomejokers',
    pos = { x = 1, y = 1 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 10,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
		if (context.end_of_round and context.main_eval and context.game_over == false) or context.forcetrigger then
			local consumables = G.consumeables.cards
			for i = 1, #consumables do
				local v = consumables[i]
				local adjustvalue = v.ability.extra_slots_used
				local timesdivided = v.ability.compressed_times_divided
				-- you can't halve zero!
				if adjustvalue == 0 or adjustvalue == nil then
					v.ability.extra_slots_used = -0.5
					v.ability.compressed_times_divided = 1
				else
					v.ability.extra_slots_used = -(1/(2*timesdivided))
				end
			end
		end
    end
}
SMODS.Joker {
    key = "perfect",
    atlas = 'awesomejokers',
    pos = { x = 3, y = 1 },
    soul_pos = { x = 3, y = 2 },
	discovered = true,
    rarity = 3,
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
	immutable = true,
    cost = 8,
    config = { extra = { hands_played = 0 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
	calculate = function(self, card, context)
        if context.after and not context.blueprint then
			card.ability.extra.hands_played = card.ability.extra.hands_played+1
		end
		if (context.ante_change and context.end_of_round and context.main_eval) or context.forcetrigger then
			if card.ability.extra.hands_played < 4 then
				for i = 1, 3 do
					local consumable = SMODS.add_card{ -- For a random one
						set = "Consumeables",
						area = G.consumeables
					}
					consumable:set_edition("e_negative")
				end
			end

		end
		-- any ante change should reset the counter
		if context.ante_change then
			card.ability.extra.hands_played = 0
		end
	end
}
SMODS.Joker {
    key = "heresy",
    atlas = 'awesomejokers',
    pos = { x = 2, y = 2 },
    soul_pos = { x = 4, y = 2 },
	discovered = true,
    rarity = 3,
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = false,
	demicolon_compat = true,
    cost = 8,
    config = { extra = { more = 0, xmult = 5 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
	calculate = function(self, card, context)
        if context.after and not context.blueprint then
			card.ability.extra.more = card.ability.extra.more+1
		end
		if context.end_of_round and context.main_eval and not context.blueprint and card.ability.extra.more <= 1  then
			card.ability.extra.more = 0
		elseif context.end_of_round and context.main_eval and not context.blueprint and card.ability.extra.more > 1 then
			SMODS.debuff_card(card, true, card.config.center.key)
		end
		if context.joker_main or context.forcetrigger then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
}
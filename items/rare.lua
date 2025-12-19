local to_big = to_big or function(n)
	return n
end
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
	CardPronouns.Pronoun {
    colour = HEX("918302"),
    text_colour = G.C.WHITE,
    pronoun_table = { "626", "22702" },
    in_pool = function()
      return false
    end,
    key = "he_him_base"
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
function Base9(n)
    if n == to_big(0) then return to_big(0) end
	n = math.floor(to_big(n))
    local result = to_big(0)
    local place = to_big(1)
    
    while n > 0 do
        local remainder = n % to_big(9)
        result = result + remainder * place
        n = math.floor(n / to_big(9))
        place = place * to_big(10)
    end
    
    return to_big(result)
end
SMODS.Joker {
    key = "base",
    atlas = 'awesomejokers',
    pos = { x = 9, y = 1 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_him_base',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 9,
	-- so no one gets any funnny ideas!
	immutable = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            if (card.edition and not card.edition.key == "e_MDJ_corrupted") or not card.edition then
                return {
                    eq_chips = Base9(SMODS.Scoring_Parameters.chips.current),
                }
            elseif card.edition and card.edition.key == "e_MDJ_corrupted" then
                return {
                    eq_mult = Base9(SMODS.Scoring_Parameters.mult.current),
                }
            end
        end
    end
}
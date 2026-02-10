---@diagnostic disable: need-check-nil
local to_big = to_big or function(n)
	return n
end
local to_number = to_number or function(n)
	return n
end
SMODS.Joker {
    key = "installer",
    atlas = 'installers',
    pos = { x = MyDreamJournal.secretnumberthatsgeneratedatstartupandneveragain, y = 0 },
	discovered = true,
    rarity = 3,
	pronouns = 'any_all',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 8,
    immutable = true,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        local operation = args["operation"] or "+"
        local real_scaling = not args["prediction_scaling"]
        if not other_card.ability then
            other_card.ability = {}
        end
        if not other_card.ability.MDJ_installer_tracker then
            other_card.ability.MDJ_installer_tracker = 5
        end
        -- don't bother if 1 scaling
        if other_card.ability.MDJ_installer_tracker == 1 then
            return
        end
        if operation == "+" or type(operation) == "function" then
            if scalar_value <= 0 then
                return
            end
            if real_scaling then
                other_card.ability.MDJ_installer_tracker = other_card.ability.MDJ_installer_tracker-1
            end
            return {
                override_scalar_value = { -- this will override the scalar_value
                    value = scalar_value*(other_card.ability.MDJ_installer_tracker+1), -- set the scalar_value to X
                    -- other calculation return keys accepted here, timing is before the scaling event
                },
            }
        end
        -- why would anyone want this???
        if operation == "-" or operation == "/" then
            return
        end
        if operation == "X" then
            if scalar_value <= 1 then
                return
            end
            if real_scaling then
                other_card.ability.MDJ_installer_tracker = other_card.ability.MDJ_installer_tracker-1
            end
            local added_amount = (initial_value*scalar_value)-initial_value
            added_amount = added_amount*other_card.ability.MDJ_installer_tracker+1
            return {
                override_scalar_value = { -- this will override the scalar_value
                    value = added_amount/initial_value, -- set the scalar_value to X
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
		if ( context.ante_end and context.ante_change ) or context.forcetrigger then
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
            return {
                base_chips = 8,
            }
        end
    end
}
SMODS.Joker {
    key = "mass",
    atlas = 'awesomejokers',
    pos = { x = 0, y = 4 },
	discovered = true,
    rarity = 3,
	pronouns = 'they_them',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 9,
	-- so no one gets any funnny ideas!
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_MDJ_mass')
        return { vars = { numerator, denominator } }
    end,
    calculate = function (self, card, context)
        if context.before or context.forcetrigger then
            local jokers_with_editions = {}
            local consumables_with_editions = {}
            local playing_cards_with_editions = {}
            local playing_cards_with_enhancements = {}
            local playing_cards_with_seals = {}
            for i = 1, #G.jokers.cards do
                local joker = G.jokers.cards[i]
                if joker.edition and joker.edition.key ~= "e_negative" then
                    jokers_with_editions[#jokers_with_editions+1] = i
                end
            end
            for i = 1, #G.consumeables.cards do
                local consumable = G.consumeables.cards[i]
                if consumable.edition and consumable.edition.key ~= "e_negative" then
                    consumables_with_editions[#consumables_with_editions+1] = i
                end
            end
            for i = 1, #context.full_hand do
                local playing_card = context.full_hand[i]
                if playing_card.edition and playing_card.edition.key ~= "e_negative" then
                    playing_cards_with_editions[#playing_cards_with_editions+1] = {i, "scored"}
                end
                if playing_card.config.center.key ~= "m_base" then
                    playing_cards_with_enhancements[#playing_cards_with_enhancements+1] = {i, "scored"}
                end
                if playing_card.seal then
                    playing_cards_with_seals[#playing_cards_with_seals+1] = {i, "scored"}
                end
            end
            for i = 1, #G.hand.cards do
                local playing_card = G.hand.cards[i]
                if playing_card.edition then
                    playing_cards_with_editions[#playing_cards_with_editions+1] = {i, "inhand"}
                end
                if playing_card.config.center.key ~= "m_base" then
                    playing_cards_with_enhancements[#playing_cards_with_enhancements+1] = {i, "inhand"}
                end
                if playing_card.seal then
                    playing_cards_with_seals[#playing_cards_with_seals+1] = {i, "inhand"}
                end
            end
            for i = 1, #jokers_with_editions do
                local index = jokers_with_editions[i]
                local joker = G.jokers.cards[index]
                if G.jokers.cards[index-1] and not G.jokers.cards[index-1].edition and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    G.jokers.cards[index-1]:set_edition(joker.edition)
                end
                if G.jokers.cards[index+1] and not G.jokers.cards[index+1].edition and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    G.jokers.cards[index+1]:set_edition(joker.edition)
                end
            end
            for i = 1, #consumables_with_editions do
                local index = consumables_with_editions[i]
                local consumable = G.consumeables.cards[index]
                if G.consumeables.cards[index-1] and not G.consumeables.cards[index-1].edition and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    G.consumeables.cards[index-1]:set_edition(consumable.edition)
                end
                if G.consumeables.cards[index+1] and not G.consumeables.cards[index+1].edition and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    G.consumeables.cards[index+1]:set_edition(consumable.edition)
                end
            end
            for i = 1, #playing_cards_with_editions do
                local tab = playing_cards_with_editions[i]
                local index = tab[1]
                local origin = ( (tab[2] == "scored") and context.full_hand) or G.hand.cards
                local playing_card = origin[index]
                if origin[index-1] and not origin[index-1].edition and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    origin[index-1]:set_edition(playing_card.edition)
                end
                if origin[index+1] and not origin[index+1].edition and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    origin[index+1]:set_edition(playing_card.edition)
                end
            end
            for i = 1, #playing_cards_with_enhancements do
                local tab = playing_cards_with_enhancements[i]
                local index = tab[1]
                local origin = ( (tab[2] == "scored") and context.full_hand) or G.hand.cards
                local playing_card = origin[index]
                if origin[index-1] and origin[index-1].config.center.key == "m_base" and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    origin[index-1]:set_ability(playing_card.config.center.key, true)
                end
                if origin[index+1] and origin[index+1].config.center.key == "m_base" and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    origin[index+1]:set_ability(playing_card.config.center.key, true)
                end
            end
            for i = 1, #playing_cards_with_seals do
                local tab = playing_cards_with_seals[i]
                local index = tab[1]
                local origin = ( (tab[2] == "scored") and context.full_hand) or G.hand.cards
                local playing_card = origin[index]
                if origin[index-1] and not origin[index-1].seal and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    origin[index-1]:set_seal(playing_card.seal)
                end
                if origin[index+1] and not origin[index+1].seal and SMODS.pseudorandom_probability(card, 'j_MDJ_mass', 1, card.ability.extra.odds) then
                    origin[index+1]:set_seal(playing_card.seal)
                end
            end
        end
    end
}
SMODS.Joker {
    key = "shitpost",
    atlas = 'awesomejokers',
    pos = { x = 3, y = 4 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = false,
    cost = 10,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and context.other_card ~= self then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
			if context.other_card == other_joker then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			else
				return nil, true
			end
		end
    end
}
SMODS.Joker {
    key = "net",
    atlas = 'awesomejokers',
    pos = { x = 8, y = 4 },
    rarity = 3,
	blueprint_compat = false,
	eternal_compat = true,
    perishable_compat = true,
	discovered = true,
    cost = 8,
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.current_round.last_payout and math.ceil(G.GAME.current_round.last_payout/4) or 0 } }
    end,
    calc_dollar_bonus = function(self, card)
        return math.ceil(G.GAME.current_round.last_payout/4)
    end
}
SMODS.Joker {
    key = "154",
    atlas = 'awesomejokers',
    pos = { x = 9, y = 4 },
	discovered = true,
    rarity = 3,
	pronouns = 'she_her',
    pools = {Music = true},
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 10,
    config = { extra = { min = 1, plus_max = 15.4, x_max = 1.54 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.plus_max, card.ability.extra.x_max } }
    end,
	calculate = function(self, card, context)
		if context.MDJ_mod_key_and_amount then
            if MyDreamJournal.plusops[context.MDJ_key] then
                return {
                    MDJ_amount = context.MDJ_amount*math.max(card.ability.extra.min, math.min(card.ability.extra.plus_max, MyDreamJournal.normalized_random(card.ability.extra.min, (card.ability.extra.min+card.ability.extra.plus_max)/2, pseudoseed("154"))))
                }
            elseif MyDreamJournal.xops[context.MDJ_key] then
                return {
                    MDJ_amount = context.MDJ_amount*math.max(card.ability.extra.min, math.min(card.ability.extra.x_max, MyDreamJournal.normalized_random(card.ability.extra.min, (card.ability.extra.min+card.ability.extra.x_max)/2, pseudoseed("154"))))
                }
            end
        end
        if context.forcetrigger then
            return {
                mult = math.max(card.ability.extra.min, math.min(card.ability.extra.plus_max, MyDreamJournal.normalized_random(card.ability.extra.min, (card.ability.extra.min+card.ability.extra.plus_max)/2, pseudoseed("154")))),
                chips = math.max(card.ability.extra.min, math.min(card.ability.extra.plus_max, MyDreamJournal.normalized_random(card.ability.extra.min, (card.ability.extra.min+card.ability.extra.plus_max)/2, pseudoseed("154")))),
                xmult = math.max(card.ability.extra.min, math.min(card.ability.extra.x_max, MyDreamJournal.normalized_random(card.ability.extra.min, (card.ability.extra.min+card.ability.extra.x_max)/2, pseudoseed("154")))),
                xchips = math.max(card.ability.extra.min, math.min(card.ability.extra.x_max, MyDreamJournal.normalized_random(card.ability.extra.min, (card.ability.extra.min+card.ability.extra.x_max)/2, pseudoseed("154"))))
            }
        end
    end
}
SMODS.Joker {
    key = "love",
    atlas = 'awesomejokers',
    pos = { x = (G.SETTINGS.colourblind_option and 1) or 0, y = 6 },
	discovered = true,
    rarity = 3,
	pronouns = 'she_they',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 7,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
SMODS.Joker {
    key = "you_are_invited",
    atlas = 'awesomejokers',
    pos = { x = 8, y = 5 },
	discovered = true,
    rarity = 3,
	pronouns = 'they_them',
    pools = {Music = true},
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 5,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if ( context.buying_card and context.card.ability and context.card.ability.set == "Voucher" and context.card.ability.invited ~= "j_MDJ_you_are_invited" ) or context.forcetrigger then
            local voucher_pool = get_current_pool('Voucher')
            local selected_voucher = pseudorandom_element(voucher_pool, 'modprefix_seed')
            local disallowed = {
                v_tarot_merchant = true,
                v_planet_merchant = true,
                v_magic_trick = true,
                v_tarot_tycoon = true,
                v_planet_tycoon = true,
            }
            local it = 1
            while selected_voucher == 'UNAVAILABLE' or disallowed[selected_voucher] do
                it = it + 1
                selected_voucher = pseudorandom_element(voucher_pool, pseudoseed('MDJ_'..it))
                if it >= 1001 then
                    selected_voucher = "v_blank"
                end
            end
            local voucher_card = SMODS.create_card({ area = G.play, key = selected_voucher })
            -- fuck off need check nil
            if not voucher_card then
                error("die")
            end
            voucher_card.ability.invited = "j_MDJ_you_are_invited"
            voucher_card:start_materialize()
            voucher_card.cost = 0
            G.play:emplace(voucher_card)
            delay(0.8)
            voucher_card:redeem()

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.5,
                func = function()
                    voucher_card:start_dissolve()
                    return true
                end
            }))
        end
    end
}
SMODS.Joker {
    key = "we_didnt_start_the_fire",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_him',
    pools = {Music = true},
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 5,
    config = { extra = { xmult = 1, gain = 0.2 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if ( ( context.after and SMODS.last_hand_oneshot ) or context.forcetrigger ) and not context.blueprint then
            SMODS.scale_card(
                card,
                {
                    ref_table = card.ability.extra, -- the table that has the value you are changing in
                    ref_value = "xmult", -- the key to the value in the ref_table
                    scalar_value = "gain", -- the key to the value to scale by, in the ref_table by default
                    scaling_message = {
                        message = "Upgrade!",
                        colour = G.C.RED
                    }
                }
            )
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
SMODS.Joker {
    key = "kaleidoskull",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_him',
    pools = {Music = true},
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 6,
    immutable = true,
    config = { extra = { log = 4, losses = G.PROFILES[G.SETTINGS.profile].career_stats.c_wins }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.log, math.log(card.ability.extra.losses, card.ability.extra.log)} }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                xmult = math.log(card.ability.extra.losses, card.ability.extra.log)
            }
        end
    end
}
--[[
SMODS.Joker {
    key = "13am",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_him',
    pools = {Music = true},
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = false,
    cost = 6,
    immutable = true,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}
]]
SMODS.Joker {
    key = "devil_nobody",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 3,
	pronouns = 'she_her',
    pools = {Music = true},
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = false,
    cost = 7,
    config = { extra = { hdollars = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hdollars } }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_p_dollars = (context.other_card.ability.perma_p_dollars or 0)+card.ability.extra.hdollars
        end
    end
}
SMODS.Joker {
    key = "copycat",
    atlas = 'awesomejokers',
    pos = { x = 2, y = 1 },
	discovered = true,
    rarity = 3,
	pronouns = 'any_all',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 5,
    config = { extra = { xchips = 1, chips = 0 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.xchips } }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        local operation = args["operation"] or "+"
        if args["prediction_scaling"]
        or other_card.config.center.key == "j_MDJ_copycat"
        or ( operation ~= "+" and operation ~= "X" )
        or scalar_value < 0 then
            return
        end
        if operation == "X" then
            if scalar_value < 1 then
                return
            end
        end
        SMODS.scale_card(
             card,
             {
                ref_table = card.ability.extra, -- the table that has the value you are changing in
                ref_value = "chips", -- the key to the value in the ref_table
                scalar_table = {a = scalar_value},
                scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                operation = operation,
                scaling_message = {
                    message = localize("k_copied_ex"),
                    colour = G.C.BLUE
                }
            }
        )
        if scalar_value < 1 and scalar_value > 0 then
            SMODS.scale_card(
                card,
                {
                    ref_table = card.ability.extra, -- the table that has the value you are changing in
                    ref_value = "xchips", -- the key to the value in the ref_table
                    scalar_table = {a = scalar_value},
                    scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                    operation = operation,
                    -- the player would have gotten the point by the first copied
                    no_message = true
                }
            )
        end
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                xchips = card.ability.extra.xchips
            }
        end
    end
}
SMODS.Joker {
    key = "copykitten",
    atlas = 'awesomejokers',
    pos = { x = 2, y = 4 },
	discovered = true,
    rarity = 3,
	pronouns = 'any_all',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 5,
    config = { extra = { xmult = 1, mult = 0, mult_gain = 2, xmult_gain = 0.1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult, card.ability.extra.xmult_gain, card.ability.extra.xmult, } }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        if args["prediction_scaling"]
        or other_card.config.center.key == "j_MDJ_copycat"
        or other_card.config.center.key == "j_MDJ_copykitten"
        or other_card.config.center.key == "j_MDJ_simpleton"
        or other_card.config.center.key == "j_MDJ_random"
        or other_card.config.center.key == "j_MDJ_cheat"
        or other_card.config.center.key == "j_MDJ_cooperate"
        or args["operation"] == "-"
        or scalar_value < 0 then
            return
        end
        if args["operation"] == "X" then
            if scalar_value < 1 then
                return
            end
        end
        SMODS.scale_card(
             card,
             {
                ref_table = card.ability.extra, -- the table that has the value you are changing in
                ref_value = "mult", -- the key to the value in the ref_table
                scalar_value = "mult_gain", -- the key to the value to scale by, in the ref_table by default
                scaling_message = {
                    message = localize({ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } }),
                    colour = G.C.BLUE
                }
            }
        )
        if scalar_value < 1 and scalar_value > 0 then
			SMODS.scale_card(
				card,
				{
					ref_table = card.ability.extra, -- the table that has the value you are changing in
					ref_value = "xmult", -- the key to the value in the ref_table
					scalar_value = "xmult_gain", -- the key to the value to scale by, in the ref_table by default
					no_message = true,
				}
			)
        end
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.extra.mult,
                xmult = card.ability.extra.xmult
            }
        end
		if context.forcetrigger then
			SMODS.scale_card(
				card,
				{
					ref_table = card.ability.extra, -- the table that has the value you are changing in
					ref_value = "mult", -- the key to the value in the ref_table
					scalar_value = "mult_gain", -- the key to the value to scale by, in the ref_table by default
					scaling_message = {
						message = localize({ type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } }),
						colour = G.C.BLUE
					}
				}
			)
			SMODS.scale_card(
				card,
				{
					ref_table = card.ability.extra, -- the table that has the value you are changing in
					ref_value = "xmult", -- the key to the value in the ref_table
					scalar_value = "xmult_gain", -- the key to the value to scale by, in the ref_table by default
					no_message = true,
				}
			)
		end
    end
}
SMODS.Joker {
    key = "simpleton",
    atlas = 'awesomejokers',
    pos = { x = 0, y = 7 },
	discovered = true,
    rarity = 3,
	pronouns = 'they_them',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 6,
    config = { extra = { xmult = 1, xamount = 0.1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xamount, card.ability.extra.xmult, } }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        local operation = args["operation"] or "+"
        if args["prediction_scaling"]
        or other_card.config.center.key == "j_MDJ_copycat"
        or other_card.config.center.key == "j_MDJ_simpleton"
        or other_card.config.center.key == "j_MDJ_random"
        or other_card.config.center.key == "j_MDJ_cheat"
        or other_card.config.center.key == "j_MDJ_cooperate"
        or ( operation ~= "+" and operation ~= "X" )
        or scalar_value < 0 then
            return
        end
        if args["operation"] == "X" then
            if scalar_value < 1 then
                return
            end
            scalar_value = (initial_value-initial_value*scalar_value)*card.ability.extra.xamount
        else
            scalar_value = scalar_value*card.ability.extra.xamount
        end
        SMODS.scale_card(
             card,
             {
                ref_table = card.ability.extra, -- the table that has the value you are changing in
                ref_value = "xmult", -- the key to the value in the ref_table
                scalar_table = {a = scalar_value},
                scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                scaling_message = {
                    message = "+"..number_format(scalar_value).." "..localize("k_MDJ_xmult"),
                    colour = G.C.GREEN
                }
            }
        )
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker {
    key = "random",
    atlas = 'awesomejokers',
    pos = { x = 1, y = 7 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 6,
    config = { extra = { min = 0, max = 3, chips = 0, xchips = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max, card.ability.extra.chips, card.ability.extra.xchips } }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        local operation = args["operation"] or "+"
        local diff = 0
        local og_value = scalar_value
        if args["prediction_scaling"]
        or other_card.config.center.key == "j_MDJ_copycat"
        or other_card.config.center.key == "j_MDJ_simpleton"
        or other_card.config.center.key == "j_MDJ_random"
        or other_card.config.center.key == "j_MDJ_cheat"
        or other_card.config.center.key == "j_MDJ_cooperate"
        or ( operation ~= "+" and operation ~= "X" )
        or scalar_value < 0 then
            return
        end
        if args["operation"] == "X" then
            if scalar_value < 1 then
                return
            end
            scalar_value = (initial_value-initial_value*scalar_value)*(card.ability.extra.min+pseudorandom(pseudoseed("RANDOM"))*(card.ability.extra.max-card.ability.extra.min))
            diff = math.abs(og_value-scalar_value)
        else
            scalar_value = scalar_value*(card.ability.extra.min+pseudorandom(pseudoseed("RANDOM"))*(card.ability.extra.max-card.ability.extra.min))
            diff = math.abs(og_value-scalar_value)
        end
        SMODS.scale_card(
             card,
             {
                ref_table = card.ability.extra, -- the table that has the value you are changing in
                ref_value = "chips", -- the key to the value in the ref_table
                scalar_table = {a = diff},
                scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                scaling_message = {
                    message = "+"..number_format(diff).." "..localize("k_MDJ_chips"),
                    colour = G.C.RED
                }
            }
        )
        if diff < 1 and diff > 0 then
            SMODS.scale_card(
                card,
                {
                    ref_table = card.ability.extra, -- the table that has the value you are changing in
                    ref_value = "xchips", -- the key to the value in the ref_table
                    scalar_table = {a = diff},
                    scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                    scaling_message = {
                        message = "+"..number_format(diff).." "..localize("k_MDJ_xchips"),
                        colour = G.C.RED
                    }
                }
            )
        end
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                xchips = card.ability.extra.xchips
            }
        end
    end
}
SMODS.Joker {
    key = "cheat",
    atlas = 'awesomejokers',
    pos = { x = 6, y = 6 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 7,
    config = { extra = { xamount1 = 3, xamount2 = 0, chips = 0, xchips = 1}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xamount1, card.ability.extra.xamount2, card.ability.extra.chips, card.ability.extra.xchips } }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        local operation = args["operation"] or "+"
        local diff = 0
        local extra_og_value = scalar_value
        local og_value = extra_og_value*card.ability.extra.xamount1
        if args["prediction_scaling"]
        or other_card.config.center.key == "j_MDJ_copycat"
        or other_card.config.center.key == "j_MDJ_simpleton"
        or other_card.config.center.key == "j_MDJ_random"
        or other_card.config.center.key == "j_MDJ_cheat"
        or other_card.config.center.key == "j_MDJ_cooperate"
        or ( operation ~= "+" and operation ~= "X" )
        or scalar_value < 0 then
            return
        end
        if args["operation"] == "X" then
            if scalar_value < 1 then
                return
            end
            extra_og_value = (initial_value-initial_value*scalar_value)
            og_value = extra_og_value*card.ability.extra.xamount1
            scalar_value = initial_value/(initial_value+((initial_value-initial_value*scalar_value)*card.ability.extra.xamount2))
        else
            scalar_value = scalar_value*card.ability.extra.xamount1
        end
        SMODS.scale_card(
             card,
             {
                ref_table = card.ability.extra, -- the table that has the value you are changing in
                ref_value = "chips", -- the key to the value in the ref_table
                scalar_table = {a = og_value},
                scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                scaling_message = {
                    message = "+"..number_format(og_value).." "..localize("k_MDJ_chips"),
                    colour = G.C.BLACK
                }
            }
        )
        if extra_og_value < 1 and extra_og_value > 0 then
            SMODS.scale_card(
                card,
                {
                    ref_table = card.ability.extra, -- the table that has the value you are changing in
                    ref_value = "xchips", -- the key to the value in the ref_table
                    scalar_table = {a = og_value},
                    scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                    scaling_message = {
                        message = "+"..number_format(og_value).." "..localize("k_MDJ_xchips"),
                        colour = G.C.BLACK
                    }
                }
            )
        end
        return {
            override_scalar_value = { -- this will override the scalar_value
                value = scalar_value, -- set the scalar_value to X
                -- other calculation return keys accepted here, timing is before the scaling event
            },
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                xchips = card.ability.extra.xchips
            }
        end
    end
}
SMODS.Joker {
    key = "cooperate",
    atlas = 'awesomejokers',
    pos = { x = 7, y = 6 },
	discovered = true,
    rarity = 3,
	pronouns = 'she_her',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 6,
    config = { extra = { xamount1 = 0.25, xamount2 = 1.25, mult = 0, xmult = 1}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xamount1, card.ability.extra.xamount2, card.ability.extra.mult, card.ability.extra.xmult } }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        local operation = args["operation"] or "+"
        local diff = 0
        local extra_og_value = scalar_value
        local og_value = extra_og_value*card.ability.extra.xamount1
        if args["prediction_scaling"]
        or other_card.config.center.key == "j_MDJ_copycat"
        or other_card.config.center.key == "j_MDJ_simpleton"
        or other_card.config.center.key == "j_MDJ_random"
        or other_card.config.center.key == "j_MDJ_cheat"
        or other_card.config.center.key == "j_MDJ_cooperate"
        or ( operation ~= "+" and operation ~= "X" )
        or scalar_value < 0 then
            return
        end
        if args["operation"] == "X" then
            if scalar_value < 1 then
                return
            end
            extra_og_value = (initial_value-initial_value*scalar_value)
            og_value = extra_og_value*card.ability.extra.xamount1
            scalar_value = initial_value/(initial_value+((initial_value-initial_value*scalar_value)*card.ability.extra.xamount2))
        else
            scalar_value = scalar_value*card.ability.extra.xamount1
        end
        SMODS.scale_card(
             card,
             {
                ref_table = card.ability.extra, -- the table that has the value you are changing in
                ref_value = "mult", -- the key to the value in the ref_table
                scalar_table = {a = og_value},
                scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                scaling_message = {
                    message =  localize({ type = 'variable', key = 'a_mult', vars = { og_value } }),
                    colour = G.C.PAPERBACK_PINK
                }
            }
        )
        if extra_og_value < 1 and extra_og_value > 0 then
            SMODS.scale_card(
                card,
                {
                    ref_table = card.ability.extra, -- the table that has the value you are changing in
                    ref_value = "xmult", -- the key to the value in the ref_table
                    scalar_table = {a = og_value},
                    scalar_value = "a", -- the key to the value to scale by, in the ref_table by default
                    scaling_message = {
                        message = "+"..number_format(og_value).." "..localize("k_MDJ_xmult"),
                        colour = G.C.PAPERBACK_PINK
                    }
                }
            )
        end
        return {
            override_scalar_value = { -- this will override the scalar_value
                value = scalar_value, -- set the scalar_value to X
                -- other calculation return keys accepted here, timing is before the scaling event
            },
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                xchips = card.ability.extra.xchips
            }
        end
    end
}

SMODS.Joker {
    key = "drinkable_grilled_chicken",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
    pools = {["Food"] = true, ["Grilled Chicken"] = true},
	discovered = true,
    rarity = 3,
	pronouns = 'any_all',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 8,
    config = { extra = { xmult = 3, retrig = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.retrig } }
    end,
    in_pool = function (self, args)
        for i, v in pairs(G.jokers.cards) do
            if MyDreamJournal.is_grilled_chicken(v) then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
			return {
				xmult = card.ability.extra.xmult
			}
		end
		if context.retrigger_joker_check and card.ability.extra.retrig > 0 then
			if MyDreamJournal.is_grilled_chicken(context.other_card) then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.retrig,
					card = card,
				}
			else
				return nil, true
			end
		end
    end,
}
SMODS.Joker {
    key = "midnight_crew",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 3,
	pronouns = 'he_him',
    pools = {Music = true},
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 7,
    config = { extra = { chips = 50, mult = 7, xamount = 1.5 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xamount } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local chips = nil
            local mult = nil
            local xchips = nil
            local xmult = nil
            if context.other_card:is_suit("Clubs") then
                chips = (chips or 0)+card.ability.extra.chips
            end
            if context.other_card:is_suit("Spades") then
                mult = (mult or 0)+card.ability.extra.mult
            end
            if context.other_card:is_suit("Diamonds") then
                xchips = 1
                xchips = xchips*card.ability.extra.xamount
            end
            if context.other_card:is_suit("Hearts") then
                xmult = 1
                xmult = xmult*card.ability.extra.xamount
            end
            return {
                chips = chips,
                mult = mult,
                xchips = xchips,
                xmult = xmult
            }
        end
        if context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                xchips = card.ability.extra.xamount,
                xmult = card.ability.extra.xamount
            }
        end
    end,
}

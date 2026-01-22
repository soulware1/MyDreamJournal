---@diagnostic disable: need-check-nil
local to_big = to_big or function(n)
	return n
end
SMODS.Joker {
    key = "unicode",
    atlas = 'awesomejokers',
    pos = { x = 0, y = 0 },
	pixel_size = { w = 62 },
	discovered = true,
    rarity = 2,
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 8,
    config = { extra = { add = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add, card.ability.extra.add/10 } }
    end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				mult = card.ability.extra.add,
				xmult = 1+(card.ability.extra.add/10),
				emult = 1+(card.ability.extra.add/100),
				eemult = 1+(card.ability.extra.add/1000),
				eeemult = 1+(card.ability.extra.add/10000),
			}
		end
		if context.MDJ_mod_key_and_amount then
			local is_corrupted = card and (card.edition and card.edition.key == "e_MDJ_corrupted")
			local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
			local key = context.MDJ_key
			local amount = context.MDJ_amount
			if not is_corrupted and not context.demicolon_racism then
				local operation = MyDreamJournal.multmodkeys[key]
				local op_number = MyDreamJournal.keystonumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (card.ability.extra.add / 10) / (10 ^ op_number)
					elseif op_number == -1 then
						op_number = card.ability.extra.add
					elseif op_number == 0 then
						op_number = card.ability.extra.add / 10
					end
					if is_dark then
						op_number = op_number * 2
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				local op_number = MyDreamJournal.keystonumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (card.ability.extra.add / 10) / (10 ^ op_number)
					elseif op_number == -1 then
						op_number = card.ability.extra.add
					elseif op_number == 0 then
						op_number = card.ability.extra.add / 10
					end
					if is_dark then
						op_number = op_number * 2
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
			end
			return {
				MDJ_amount = amount,
				MDJ_key = key
			}
		end
	end
}
SMODS.Joker {
    key = "emoji",
    atlas = 'awesomejokers',
    pos = { x = 1, y = 0 },
	discovered = true,
    rarity = 2,
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 8,
    config = { extra = { add = 30 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add, card.ability.extra.add/100 } }
    end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				chips = card.ability.extra.add,
				xchips = 1+(card.ability.extra.add/100),
				echips = 1+((card.ability.extra.add/100)/10),
				eechips = 1+((card.ability.extra.add/100)/100),
				eeechips = 1+((card.ability.extra.add/100)/1000),
			}
		end
		if context.MDJ_mod_key_and_amount then
			local is_corrupted = card and (card.edition and card.edition.key == "e_MDJ_corrupted")
			local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
			local key = context.MDJ_key
			local amount = context.MDJ_amount
			if is_corrupted and not context.demicolon_racism then
				local operation = MyDreamJournal.multmodkeys[key]
				local op_number = MyDreamJournal.keystonumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (card.ability.extra.add/100) / (10 ^ op_number)
					elseif op_number == -1 then
						op_number = card.ability.extra.add
					elseif op_number == 0 then
						op_number = card.ability.extra.add / 10
					end
					if is_dark then
						op_number = op_number * 2
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
			elseif not context.demicolon_racism then
				local operation = MyDreamJournal.chipmodkeys[key]
				local op_number = MyDreamJournal.keystonumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (card.ability.extra.add/100) / (10 ^ op_number)
					elseif op_number == -1 then
						op_number = card.ability.extra.add
					elseif op_number == 0 then
						op_number = card.ability.extra.add / 10
					end
					if is_dark then
						op_number = op_number * 2
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
			end
			return {
				MDJ_amount = amount,
				MDJ_key = key
			}
		end
	end
}
SMODS.Joker {
    key = "constructionjoker",
    atlas = 'awesomejokers',
    pos = { x = 3, y = 0 },
	discovered = true,
    rarity = 2,
	pronouns = 'he_they',
    blueprint_compat = true,
	perishable_compat = false,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 8,
    config = { extra = { gain = 0.1, mult = 1, displayed_ranks = "None", hand_matches = true }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain, card.ability.extra.mult, G.GAME.current_round.MDJ_construction_jokers_displayed_ranks or "None" } }
    end,
    calculate = function(self, card, context)
		if context.before then
			card.ability.extra.hand_matches = true
			local hand_ranks = {}
			local stored_ranks = G.GAME.current_round.MDJ_construction_jokers_ranks
			for i = 1, #context.scoring_hand do
				local v = context.scoring_hand[i]
				local rank = v:get_id()
				local rankless_check = SMODS.has_no_rank(v)
				if rankless_check then
					rank = 1
				end
				if not hand_ranks[rank] then
					hand_ranks[rank] = 0
				end
				hand_ranks[rank] = hand_ranks[rank]+1
			end
			for i = 1, 14 do
				if hand_ranks[i] ~= stored_ranks[i] then
					card.ability.extra.hand_matches = false
				end
			end
			if card.ability.extra.hand_matches then
				SMODS.scale_card(card, {
				ref_table = card.ability.extra, -- the table that has the value you are changing in
			    ref_value = "mult", -- the key to the value in the ref_table
				scalar_value = "gain", -- the key to the value to scale by, in the ref_table by default
				scaling_message = {
				message = "Upgrade!",
				colour = G.C.RED
				}
				})
			end
		end
        if context.joker_main or context.forcetrigger then
			if context.forcetrigger then
				SMODS.scale_card(card, {
				ref_table = card.ability.extra, -- the table that has the value you are changing in
			    ref_value = "mult", -- the key to the value in the ref_table
				scalar_value = "gain", -- the key to the value to scale by, in the ref_table by default
				scaling_message = {
				message = "Upgrade!",
				colour = G.C.RED
				}
				})
			end
			return {
				xmult  = card.ability.extra.mult
			}
		end
    end
}
SMODS.Joker {
    key = "anarchy",
    atlas = 'awesomejokers',
    pos = { x = 0, y = 3 },
	discovered = true,
    rarity = 2,
	pools = {Music = true},
	pronouns = 'she_her',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 7,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge('Art Credit: Plasma', G.C.BLACK, G.C.PURPLE, 0.8 )
	end
}
SMODS.Joker {
    key = "bones",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 2,
	pools = {Music = true},
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 9,
    config = { extra = {decrease = -1}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {-card.ability.extra.decrease} }
    end,
	calculate = function(self, card, context)
		if context.after or context.forcetrigger then
			-- stolen vanillaremade code
			for i = 1, #context.scoring_hand do
				local percent = 1.15 - (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						context.scoring_hand[i]:flip()
						play_sound('card1', percent)
						context.scoring_hand[i]:juice_up(0.3, 0.3)
						return true
					end
				}))
			end
			delay(0.2)
			for i = 1, #context.scoring_hand do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						-- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
						if context.scoring_hand[i]:get_id() == 14 then
							
						elseif context.scoring_hand[i]:get_id() == 2 then
							assert(SMODS.modify_rank(context.scoring_hand[i], 12))
						else
							assert(SMODS.modify_rank(context.scoring_hand[i], card.ability.extra.decrease))
						end
						return true
					end
				}))
			end
			for i = 1, #context.scoring_hand do
				local percent = 0.85 + (i - 0.999) / (#context.scoring_hand - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						context.scoring_hand[i]:flip()
						play_sound('tarot2', percent, 0.6)
						context.scoring_hand[i]:juice_up(0.3, 0.3)
						return true
					end
				}))
			end
			delay(0.4)
		end
	end
}
SMODS.Joker {
    key = "bones_live",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 2,
	pools = {Music = true},
	pronouns = 'he_him',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 6,
    config = { extra = {decrease = -1}, },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = {} }
    end,
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.removed then
            for i = 1, #context.removed do
				local v = context.removed[i]
                local repair_card = copy_card(v, nil, nil, G.playing_card)
                table.insert(G.playing_cards, repair_card)
				draw_card(repair_card.area, v.area, 90, 'up', nil, repair_card)
				repair_card:set_ability("m_stone")
            end
		end
		if context.before or context.forcetrigger then
			context.unscored_hand = {}
			for i, v in ipairs(context.full_hand) do
				local scored = false
				for j, b in ipairs(context.scoring_hand) do
					if v == b then
						scored = true
					end
				end
				if not scored then
					table.insert(context.unscored_hand, v)
				end
			end
			for i = 1, #context.unscored_hand do
				local percent = 1.15 - (i - 0.999) / (#context.unscored_hand - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						context.unscored_hand[i]:flip()
						play_sound('card1', percent)
						context.unscored_hand[i]:juice_up(0.3, 0.3)
						return true
					end
				}))
			end
			delay(0.2)
			for i = 1, #context.unscored_hand do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
                    	context.unscored_hand[i]:set_ability("m_stone")
						return true
					end
				}))
			end
			for i = 1, #context.unscored_hand do
				local percent = 0.85 + (i - 0.999) / (#context.unscored_hand - 0.998) * 0.3
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						context.unscored_hand[i]:flip()
						play_sound('tarot2', percent, 0.6)
						context.unscored_hand[i]:juice_up(0.3, 0.3)
						return true
					end
				}))
			end
			delay(0.4)
		end
	end
}
SMODS.Joker {
    key = "bitplane",
    atlas = 'awesomejokers',
    pos = { x = 4, y = 1 },
	discovered = true,
    rarity = 2,
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 4,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
	calculate = function (self, card, context)
		if context.MDJ_mod_key_and_amount then
			if MyDreamJournal.pluschipstoxchips[context.MDJ_key] or MyDreamJournal.plusmulttoxmult[context.MDJ_key] then
				local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
				local power_of = (not is_dark and 2) or 4
				local amount = context.MDJ_amount
				local amount_is_negative = (amount < 0)
				if amount_is_negative then
					amount = math.abs(amount)
				end
				local log = math.log(amount, power_of)
				local ceiling = math.ceil(log)
				amount = power_of ^ ceiling
				if amount_is_negative then
					amount = -amount
				end
				return {
					MDJ_amount = amount
				}
			end
		end
	end
}
SMODS.Joker {
    key = "spiral",
    atlas = 'awesomejokers',
    pos = { x = 0, y = 1 },
	discovered = true,
    rarity = 2,
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = false,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 7,
    config = { extra = { gain = 0.3, mult = 1, rank_to_find = nil, rank_to_exclude = nil }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain, card.ability.extra.mult} }
    end,
    calculate = function(self, card, context)
		if context.before and next(context.poker_hands["Straight"]) then
			-- set to a large value, so any value is less then it
			local least_rank = math.huge
			local found_rank = false
			local excluded_rank = false
			for i = 1, #context.scoring_hand do
				local v = context.scoring_hand[i]
				-- ahhh, a rankless card!? in MY straight? its more likely then you think, pray that the entire hand isn't just rankless
				local rank = v:get_id()
				local rankless = SMODS.has_no_rank(v)
				if rankless then
					-- bootleg continue
				else
					if rank < least_rank then
						least_rank = rank
					end
					if rank == card.ability.extra.rank_to_find then
						found_rank = true
					end
					if rank == card.ability.extra.rank_to_exclude then
						excluded_rank = true
					end
				end
			end
			-- get what card would be in the next hand by subtracting one
			least_rank = least_rank-1
			-- handle ace
			if least_rank == 1 then
				least_rank = 14
			end
			card.ability.extra.rank_to_exclude = card.ability.extra.rank_to_find
			card.ability.extra.rank_to_find = least_rank
			if found_rank and not excluded_rank then
				SMODS.scale_card(card, {
				ref_table = card.ability.extra, -- the table that has the value you are changing in
			    ref_value = "mult", -- the key to the value in the ref_table
				scalar_value = "gain", -- the key to the value to scale by, in the ref_table by default
				scaling_message = {
				message = "Upgrade!",
				colour = G.C.RED
				}
				})
			end
		end
		 if context.joker_main or context.forcetrigger then
			if context.forcetrigger then
				SMODS.scale_card(card, {
				ref_table = card.ability.extra, -- the table that has the value you are changing in
			    ref_value = "mult", -- the key to the value in the ref_table
				scalar_value = "gain", -- the key to the value to scale by, in the ref_table by default
				scaling_message = {
				message = "Upgrade!",
				colour = G.C.RED
				}
				})
			end
			return {
				xmult  = card.ability.extra.mult
			}
		end
    end
}
SMODS.Joker {
    key = "fractal",
    atlas = 'awesomejokers',
    pos = { x = 5, y = 2 },
	discovered = true,
    rarity = 2,
	pronouns = 'she_her',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 6,
    config = { extra = { chips = 30 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
	calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                digit_chips = card.ability.extra.chips,
            }
        end
    end,
}
SMODS.Joker {
    key = "etykiw",
    atlas = 'awesomejokers',
    pos = { x = 7, y = 2 },
	discovered = true,
    rarity = 2,
	pools = {Music = true},
	pronouns = 'he_him',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 7,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_no_suit(playing_card) then
                return true
            end
        end
        return false
    end
}
SMODS.Joker {
    key = "graph2",
    pos = { x = 5, y = 3 },
    atlas = 'awesomejokers',
	pronouns = 'it_its',
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 7,
    discovered = true,
    config = { extra = { expo = 0.12 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.expo, colours = { G.C.DARK_EDITION } } }
    end,
    calculate = function(self, card, context)
        if (context.joker_main or context.forcetrigger) and not context.retrigger_joker_check and not context.blueprint then
            return {
                xmult = math.min(G.GAME.blind.chips^card.ability.extra.expo, to_big(20))
            }
        end
    end
}
SMODS.Joker {
    key = "graph3",
    pos = { x = 6, y = 3 },
    atlas = 'awesomejokers',
    pronouns = 'it_its',
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 6,
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
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 6,
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
    key = "dither",
    pos = { x = 1, y = 4 },
    atlas = 'awesomejokers',
	pronouns = 'he_they',
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = false,
    cost = 6,
    discovered = true,
    config = { extra = {  }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}
SMODS.Joker {
    key = "green",
    atlas = 'installers',
    pos = { x = MyDreamJournal.secretnumberthatsgeneratedatstartupandneveragain, y = 1 },
    rarity = 2,
	blueprint_compat = false,
	eternal_compat = true,
    perishable_compat = false,
	discovered = true,
    cost = 6,
    config = { extra = { dollars = 0, scale = 1 } },
    loc_vars = function(self, info_queue, card)
		-- the player might be fooled if its not a scale above what its currrently
		local fake_table = {
			["dollars"] = card.ability.extra.dollars,
			["scale"] = card.ability.extra.scale
		}
		SMODS.scale_card({}, {
			ref_table = fake_table,
			ref_value = "dollars",
			scalar_value = "scale",
			no_message = true,
			prediction_scaling = true,
		})
        return { vars = { card.ability.extra.scale, fake_table["dollars"] } }
    end,
	calculate = function (self, card, context)
		if context.end_of_round and context.main_eval then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "dollars",
				scalar_value = "scale",
				no_message = true
			})
		end
	end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}
SMODS.Joker {
    key = "forbidden",
    atlas = 'pretty',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 2,
	pronouns = 'she_her',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 6,
    config = { extra = { min = 0, max = 34 }},
    loc_vars = function(self, info_queue, card)
        local r_mults = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_mults[#r_mults + 1] = tostring(i)
        end
		local awesome_mult = localize('k_MDJ_addscoreop')
        local loc_mult = ' ' .. awesome_mult .. ' '
        main_start = {
            { n = G.UIT.T, config = { text = '  +', colour = G.C.FILTER, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.FILTER }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.11, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'nil', colour = G.C.veryrare }, { string = "*.jpg", colour = G.C.RED }, { string = "Watch my skin erupt in a CYNTHONI of flames", colour = G.C.PURPLE }, { string = localize('k_MDJ_eviladdscoreop'), colour = G.C.BLACK },
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.11,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { main_start = main_start }
    end,
	calculate = function(self, card, context)
		if context.MDJ_mod_key_and_amount then
            if MyDreamJournal.plusops[context.MDJ_key] then
                return {
                    MDJ_amount = context.MDJ_amount+pseudorandom('forbidden', card.ability.extra.min, card.ability.extra.max)
                }
            end
        end
        if context.forcetrigger then
            return {
                mult = pseudorandom('forbidden', card.ability.extra.min, card.ability.extra.max),
                chips = pseudorandom('forbidden', card.ability.extra.min, card.ability.extra.max)
            }
        end
    end,
	update = function (self, card, dt)
		local secret = math.floor(9.99*(G.TIMERS.REAL - dt))%29
		if card.ability.secret ~= secret then
			card.children.center:set_sprite_pos({ x = pseudorandom(pseudoseed("cynthoni"), 0, 28), y = 0})
			card.ability.secret = secret
		end
	end
}
SMODS.Joker {
    key = "new_normal",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 2,
	pools = {Music = true},
	pronouns = 'he_him',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 5,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
	calculate = function (self, card, context)
		if context.idk_a_easier_way_to_do_this_so and context.targeted_card == card and context.debuffslop then
			return {
				message = localize("k_not_allowed_ex")
			}
		end
	end
}
SMODS.Joker {
    key = "mailed",
    atlas = 'awesomejokers',
    pos = { x = 2, y = 6 },
    rarity = 2,
	discovered = true,
    blueprint_compat = true,
    cost = 6,
    config = { extra = { per_x = 0.1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.per_x, } }
    end,
	in_pool = function (self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_MDJ_envelope") then
                return true
            end
        end
        return false
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_MDJ_envelope")  then
			local vowel, consonants = MyDreamJournal.vowelandconsonants(MyDreamJournal.mass_concat(MyDreamJournal.localized_names({ cards = { context.other_card } })))
            return {
                xchips = 1+(vowel*card.ability.extra.per_x),
				xmult = 1+(consonants*card.ability.extra.per_x),
            }
        end
    end
}
SMODS.Joker {
    key = "phantom",
    atlas = 'awesomejokers',
    pos = { x = 3, y = 6 },
	discovered = true,
    rarity = 2,
	pronouns = 'they_them',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 6,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
			local amount = math.sqrt(SMODS.calculate_round_score())
            return {
                eq_mult = amount,
				eq_chips = amount
            }
        end
    end
}
SMODS.Joker {
    key = "rockefeller",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 2,
	pronouns = 'she_her',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 2,
    config = { extra = { active = false, expo = 3 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.expo } }
    end,
    calculate = function (self, card, context)
        if context.before then
            local ranks = ""
            for i, v in ipairs(context.scoring_hand) do
                ranks = ranks..tostring(v:get_id()).."|"
            end
            if ranks:match("14|2|7|3") then
                card.ability.extra.active = true
            end
        end
        if context.MDJ_mod_key_and_amount and card.ability.extra.active and MyDreamJournal.plusops[context.MDJ_key] then
            return {
                MDJ_amount = context.MDJ_amount^card.ability.extra.expo
            }
        end
        if context.after then
            card.ability.extra.active = false
        end
    end
}
SMODS.Joker {
    key = "fallingup",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 2,
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 5,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function (self, card, context)
        if context.MDJ_mod_key_and_amount and MyDreamJournal.xops[context.MDJ_key] then
			context.MDJ_amount = math.ceil(context.MDJ_amount)
            return {
                MDJ_amount = context.MDJ_amount
            }
        end
    end
}
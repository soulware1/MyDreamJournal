SMODS.Joker {
    key = "unicode",
    atlas = 'awesomejokers',
    pos = { x = 0, y = 0 },
	pixel_size = { w = 62 },
	discovered = true,
    rarity = 2,
	loc_txt = {
        name = 'Unicode',
		text = {
		"{X:mult,C:white}+#1#{} to all {C:mult}+Mult{}",
		"{X:mult,C:white}+#2#{} to all {X:mult,C:white}XMult{}",
		"{X:mult,C:white}+(#2#/N){} to all {C:attention}higher-operation{} Mult",
		"{C:inactive,s:0.9}N being 10^ the used operation{}"
		}
    },
	pronouns = 'it_its',
    blueprint_compat = false,
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
	end
}
SMODS.Joker {
    key = "emoji",
    atlas = 'awesomejokers',
    pos = { x = 1, y = 0 },
	discovered = true,
    rarity = 2,
	loc_txt = {
        name = 'Emoji',
		text = {
		"{X:chips,C:white}+#1#{} to all {C:chips}+Chip{}",
		"{X:chips,C:white}+#2#{} to all {X:chips,C:white}XChip{}",
		"{X:chips,C:white}+(#2#/N){} to all {C:attention}higher-operation{} Chip",
		"{C:inactive,s:0.9}N being 10^ the used operation{}"
		}
    },
	pronouns = 'he_him',
    blueprint_compat = false,
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
				eechips =1+((card.ability.extra.add/100)/100),
				eeechips = 1+((card.ability.extra.add/100)/1000),
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
	loc_txt = {
        name = 'Construction Joker',
		text = {
			"This Joker gains {X:mult,C:white}X#1#{} Mult",
			"every time you play a hand",
			"that has the same scored ranks as the",
			"one played at the start of this Ante",
			"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
			"{C:inactive,s:0.85} (Ranks: #3#) {}"
		}
    },
	pronouns = 'he_they',
    blueprint_compat = true,
	perishable_compat = true,
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
	loc_txt = {
        name = {
			'anarchy!!!',
			'{s:0.75}By STOMACH BOOK',
		},
		text = {
			"{C:hearts}Hearts{} count as every suit",
			"except their own"
		}
    },
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
	loc_txt = {
        name = {
			'Skeleton Appreciation Day in Vestal, NY (Bones)',
			'{s:0.75}By Will Wood',
		},
		text = {
			"{C:attention}Decrease{} the ranks of scored cards in",
			"the winning hand by #1# at the end of the round",
			"{C:inactive}(Aces count as 1s, can't go below 1)",
		}
    },
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
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
	loc_txt = {
        name = {
			'Fibrodysplasia Ossificans Progressiva (Live)',
			'{s:0.75}By Will Wood',
		},
		text = {
			"Destroyed or unscored cards get",
			"replaced by {C:attention}Stone Cards",
		}
    },
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
	loc_txt = {
        name = 'Bit Plane',
		text = {
			"{C:chips}+Chips{} and {C:mult}+Mult{} are rounded up",
			"to {C:attention}the nearest power of 2"
		}
    },
	pronouns = 'it_its',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 4,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
SMODS.Joker {
    key = "spiral",
    atlas = 'awesomejokers',
    pos = { x = 0, y = 1 },
	discovered = true,
    rarity = 2,
	loc_txt = {
        name = 'Spiral',
		text = {
			"This Joker gains {X:mult,C:white}X#1#{} Mult",
			"every time you {C:attention}continue{} a straight",
			"{C:inactive,s:0.85} (Ex: 5 4 3 2 A -> K Q J 10 9){}",
			"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
		}
    },
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
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
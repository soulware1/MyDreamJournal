--- STEAMODDED HEADER
--- MOD_NAME: My Dream Journal
--- MOD_ID: MyDreamJournal
--- PREFIX: MDJ
--- MOD_AUTHOR: [soulware]
--- MOD_DESCRIPTION: Idk :P also thanks to snonc41 for the construction joker idea
--- BADGE_COLOUR: 00FF00
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0905a]

MyDreamJournal = MyDreamJournal or {}
Talisman = Talisman or nil

SMODS.Atlas({
    key = "modicon",
    path = "modicon.png",
    px = 32,
    py = 32
 })
 SMODS.Atlas({
    key = "awesomejokers",
    path = "jonklers.png",
    px = 71,
    py = 95
 })
  SMODS.Atlas({
    key = "placeholder",
    path = "stolenplaceholder.png",
    px = 71,
    py = 95
 })

 SMODS.Sound(
	{
			key = "snd",
			path = "snd.ogg",
			per = 1,
			volume = 1
	}
 )


SMODS.Shader({ key = 'corrupted', path = 'corrupted.fs' })

MyDreamJournal.rank_shorthands = {
		"_",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"10",
		"J",
		"Q",
		"K",
		"A"
}

function SMODS.current_mod.calculate(self, context)
	-- setup
	if not G.GAME.current_round.MDJ_construction_jokers_ranks and not G.GAME.current_round.MDJ_construction_jokers_temp_ranks and not G.GAME.current_round.MDJ_construction_jokers_displayed_ranks and not G.GAME.current_round.MDJ_construction_jokers_first_hand then
		G.GAME.current_round.MDJ_construction_jokers_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_temp_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_displayed_ranks = "None"
	end
	local ranks = G.GAME.current_round.MDJ_construction_jokers_ranks
	local ranks2 = G.GAME.current_round.MDJ_construction_jokers_temp_ranks
	local rank_shorthands = MyDreamJournal.rank_shorthands
	if context.before and not next(ranks) and G.GAME.current_round.MDJ_construction_jokers_displayed_ranks == "None" and next(SMODS.find_card("j_MDJ_constructionjoker")) then
		for i = 1, #context.scoring_hand do
			local v = context.scoring_hand[i]
			local rank = v:get_id()
			local rankless_check = SMODS.has_no_rank(v)
			if rankless_check then
				rank = 1
			end
			if not ranks[rank] then
				ranks[rank] = 0
			end
			ranks[rank] = ranks[rank]+1
			table.insert(ranks2, rank_shorthands[rank])
		end
		G.GAME.current_round.MDJ_construction_jokers_displayed_ranks = table.concat(ranks2, ", ")
	end

	if context.ante_change then
		G.GAME.current_round.MDJ_construction_jokers_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_temp_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_displayed_ranks = "None"
	end
end


SMODS.Edition({
    key = "corrupted",
    loc_txt = {
        name = "Corrupted",
        label = "Corrupted",
		sound = {
			key = "snd",
			path = "snd.ogg",
			per = 1,
			volume = 1
		},
        text = {
            "Chips effects {X:chips,C:white}X#2#{} if {C:chips}+Chips{} and now affects Mult instead",
			"Mult effects {X:mult,C:white}X#1#{} if {C:mult}+Mult{} and now affects Chips instead",
        }
    },
	-- Stop shadow from being rendered under the card
    disable_shadow = true,
    -- Stop extra layer from being rendered below the card.
    -- For edition that modify shape or transparency of the card.
    shader = "corrupted",
    discovered = true,
    unlocked = true,
    config = { x_mult = 7.5, d_chips = "(2/15)" },
    in_shop = true,
    weight = 8,
    extra_cost = 6,
    apply_to_float = true,
    loc_vars = function(self)
        return { vars = { self.config.x_mult, self.config.d_chips } }
    end,
})

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
    rarity = 3,
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
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 2,
	loc_txt = {
        name = 'anarchy!!!!',
		text = {
			"{C:hearts}Hearts{} count as every suit",
			"except their own"
		}
    },
	pronouns = 'she_her',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 7,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
SMODS.Joker {
    key = "installer",
    atlas = 'awesomejokers',
    pos = { x = 2, y = 1 },
	discovered = true,
    rarity = 3,
	loc_txt = {
        name = 'Installer',
		text = {
			"Scaling {C:attention}Jokers{} scale {C:attention}twice{} as fast"
		}
    },
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
	loc_txt = {
        name = 'JPG',
		text = {
			"Consumables {C:attention}halve{} the amount of slots",
			"they take every round when held",
		}
    },
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
    key = "soulware",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 4,
	loc_txt = {
        name = 'Soulware',
		text = {
		"{X:mult,C:white}X#1#{} all {C:mult}+Mult{}",
		"{X:mult,C:white}X#2#{} all {X:mult,C:white}XMult{}",
		"{X:mult,C:white}X(1+(#3#/N)){} all {C:attention}higher-operation{} Mult",
		"{C:inactive,s:0.9}N being 2^ the used operation{}"
		}
    },
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

if SMODS.Mods["potassium_re"] and SMODS.Mods["potassium_re"].can_load then
	SMODS.Font {
		key = "fairfaxpona",
		path = "FairfaxPona.ttf",
		render_scale = 24 --[[number]],
		TEXT_HEIGHT_SCALE = 1 --[[number]],
		TEXT_OFFSET = { x = 0 --[[number]], y = 0 --[[number]] },
		FONTSCALE = 0.5 --[[number]],
		squish = 0 --[[number]],
		DESCSCALE = 1 --[[number]]
	}
	SMODS.Joker {
		key = "jannasa",
		atlas = 'awesomejokers',
		pos = { x = 2, y = 0 },
		discovered = true,
		rarity = 3,
		loc_txt = {
			name = '{f:MDJ_fairfaxpona}AB{}',
			text = {
			"{X:glop,C:white}+#1#{} to all {C:glop}+Glop{}",
			"{X:glop,C:white}+#1#{} to all {X:glop,C:white}XGlop{}",
			"{X:glop,C:white}+(#1#/N){} to all {C:attention}higher-operation{} Glop",
			"{C:inactive,s:0.9}N being 10^ the used operation{}",
			"{C:inactive,s:0.8}also {}{X:glop,C:inactive,s:0.8}+#2#{}{C:inactive,s:0.8} to default Glop{}",
			}
		},
		pronouns = 'they_them',
		blueprint_compat = false,
		perishable_compat = true,
		eternal_compat = true,
		demicolon_compat = true,
		cost = 8,
		config = { extra = { add = 0.1, default_glop = 0.01 }, },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.add, card.ability.extra.default_glop } }
		end,
		add_to_deck = function(self, card, from_debuff)
			if G.GAME.kali_glop_increase_from_calc_keys then
				G.GAME.kali_glop_increase_from_calc_keys = G.GAME.kali_glop_increase_from_calc_keys+card.ability.extra.default_glop
			end
		end,
		remove_from_deck = function(self, card, from_debuff)
			if G.GAME.kali_glop_increase_from_calc_keys then
				G.GAME.kali_glop_increase_from_calc_keys = G.GAME.kali_glop_increase_from_calc_keys-card.ability.extra.default_glop
			end
		end,
		-- does potassium even have cry compatibility? whatever
		calculate = function(self, card, context)
			if context.forcetrigger then
				return {
					glop = card.ability.extra.add,
					xglop = 1+card.ability.extra.add,
					eglop = 1+(card.ability.extra.add/10),
				}
			end
		end
	}
end

MyDreamJournal.chipmultopswap = {
	['chips'] = 'mult',
	['h_chips'] = 'h_mult',
	['chip_mod'] = 'mult_mod',
	['mult'] = 'chips',
	['h_mult'] = 'h_chips',
	['mult_mod'] = 'chip_mod',
	['x_chips'] = 'x_mult',
	['xchips'] = 'xmult',
	['Xchip_mod'] = 'Xmult_mod',
	['x_mult'] = 'x_chips',
	['xmult'] = 'xchips',
	['Xmult'] = 'xchips',
	['x_mult_mod'] = 'Xchip_mod',
	['Xmult_mod'] = 'Xchip_mod',
	-- Talisman.
	['e_mult'] = 'e_chips',
	['emult'] = 'echips',
	['ee_mult'] = 'ee_chips',
	['eemult'] = 'eechips',
	['eee_mult'] = 'eee_chips',
	['eeemult'] = 'eeechips',
	['hypermult'] = 'hyperchips',
	['hyper_mult'] = 'hyper_chips',
	['e_chips'] = 'e_mult',
	['echips'] = 'emult',
	['ee_chips'] = 'ee_mult',
	['eechips'] = 'eemult',
	['eee_chips'] = 'eee_mult',
	['eeechips'] = 'eeemult',
	['hyperchips'] = 'hypermult',
	['hyper_chips'] = 'hyper_mult',
	['Emult_mod'] = 'Echip_mod',
	['EEmult_mod'] = 'EEchip_mod',
	['EEEmult_mod'] = 'EEEchip_mod',
	['hypermult_mod'] = 'hyperchip_mod',
	['Echip_mod'] = 'Emult_mod',
	['EEchip_mod'] = 'EEmult_mod',
	['EEEchip_mod'] = 'EEEmult_mod',
	['hyperchip_mod'] = 'hypermult_mod',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.chipmodkeys = {
	['chips'] = 'add', ['h_chips'] = 'add', ['chip_mod'] = 'add',
	['x_chips'] = 'mult', ['xchips'] = 'mult', ['Xchip_mod'] = 'mult',
	['e_chips'] = 'expo', ['echips'] = 'expo', ['Echip_mod'] = 'expo',
	['ee_chips'] = 'tetra', ['eechips'] = 'tetra', ['EEchip_mod'] = 'tetra',
	['eee_chips'] = 'penta', ['eeechips'] = 'penta', ['EEEchip_mod'] = 'penta',
	['hyperchips'] = 'hyper', ['hyper_chips'] = 'hyper', ['hyperchip_mod'] = 'hyper',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.multmodkeys = {
	['mult'] = 'add', ['h_mult'] = 'add', ['mult_mod'] = 'add',
	['x_mult'] = 'mult', ['xmult'] = 'mult', ['Xmult'] = 'mult', ['x_mult_mod'] = 'mult', ['Xmult_mod'] = 'mult',
	['e_mult'] = 'expo', ['emult'] = 'expo', ['Emult_mod'] = 'expo',
	['ee_mult'] = 'tetra', ['eemult'] = 'tetra', ['EEmult_mod'] = 'tetra',
	['eee_mult'] = 'penta', ['eeemult'] = 'penta', ['EEEmult_mod'] = 'penta',
	['hypermult'] = 'hyper', ['hyper_mult'] = 'hyper', ['hypermult_mod'] = 'hyper',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.keysToNumbers = {
	["add"] = -1, ["mult"] = 0, ["expo"] = 1, ["tetra"] = 2, ["penta"] = 3, ["hyper"] = 4
}

local calcindiveffectref = SMODS.calculate_individual_effect
---@diagnostic disable-next-line: duplicate-set-field
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	local is_corrupted = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_corrupted")
	local unicodes = SMODS.find_card("j_MDJ_unicode")
	local emojis = SMODS.find_card("j_MDJ_emoji")
	local jans = SMODS.find_card("j_MDJ_jannasa")
	local soulwares = SMODS.find_card("j_MDJ_soulware")
	local is_demicolon = false
	-- a scored_card could SOMEHOW not have a center, therefor crashing the game without these checks >:(
	if scored_card then
		if scored_card.config then
			if scored_card.config.center then
				is_demicolon = (scored_card.config.center.key == "j_cry_demicolon")
			end
		end
	end
	if is_corrupted then
		local msg
		if string.find(key, 'chip') then 
			msg = "Mult!"
			if MyDreamJournal.multmodkeys[key] == "add" then
				amount = math.floor((amount/7.5)+0.5)
			end
		elseif string.find(key, 'mult') then 
			msg = "Chips!"
			-- rounds
			if MyDreamJournal.multmodkeys[key] == "add" then
				amount = math.floor((amount*7.5)+0.5)
			end
		end
		if msg and not (Talisman and Talisman.config_file.disable_anims) and scored_card then
			card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = msg, colour = string.find(key, 'chip') and G.C.CHIPS or string.find(key, 'mult') and G.C.MULT, delay = 0.2})
		end
		key = MyDreamJournal.chipmultopswap[key]
	end
	if next(unicodes) and not is_demicolon then
		for i = 1, #unicodes do
			local v = unicodes[i]
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if not is_corrupted then
				local operation = MyDreamJournal.multmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					if op_number == 4 and type(amount) == "table" then
						op_number = amount[1]
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (v.ability.extra.add/10)/(10^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add/10
					end
					if type(amount) == "number" then
						amount = amount + op_number
					elseif type(amount) == "table" then
						amount[2] = amount[2] + op_number
					end
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					if op_number == 4 and type(amount) == "table" then
						op_number = amount[1]
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (v.ability.extra.add/10)/(10^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add/10
					end
					if type(amount) == "number" then
						amount = amount + op_number
					elseif type(amount) == "table" then
						amount[2] = amount[2] + op_number
					end
				end
			end
		end
	end
	if next(emojis) and not is_demicolon then
		for i = 1, #emojis do
			local v = emojis[i]
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if is_corrupted then
				local operation = MyDreamJournal.multmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					if op_number == 4 and type(amount) == "table" then
						op_number = amount[1]
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (v.ability.extra.add/10)/(10^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add/10
					end
					if type(amount) == "number" then
						amount = amount + op_number
					elseif type(amount) == "table" then
						amount[2] = amount[2] + op_number
					end
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					if op_number == 4 and type(amount) == "table" then
						op_number = amount[1]
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (v.ability.extra.add/10)/(10^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add/10
					end
					if type(amount) == "number" then
						amount = amount + op_number
					elseif type(amount) == "table" then
						amount[2] = amount[2] + op_number
					end
				end
			end
		end
	end
	if next(jans) and not is_demicolon then
		for i = 1, #jans do
			local v = jans[i]
			local operation = MyDreamJournal.glopmodkeys[key]
			local op_number = MyDreamJournal.keysToNumbers[operation]
			if operation and op_number then
				-- handle generalized higher order hyperoperations
				if op_number == 4 and type(amount) == "table" then
					op_number = amount[1]
				end
				-- mult has the same amount to add as add
				if op_number ~= -1 and op_number ~= 0 then
					op_number = v.ability.extra.add/(10^op_number)
				else
					op_number = v.ability.extra.add
				end
				if type(amount) == "number" then
					amount = amount + op_number
				elseif type(amount) == "table" then
					amount[2] = amount[2] + op_number
				end
			end
		end
	end
	if next(soulwares) and not is_demicolon then
		for i = 1, #soulwares do
			local v = soulwares[i]
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if not is_corrupted then
				local operation = MyDreamJournal.multmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					if op_number == 4 and type(amount) == "table" then
						op_number = amount[1]
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = v.ability.extra.add/(2^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add*0.8333333333333334
					end
					if type(amount) == "number" then
						amount = amount * op_number
					elseif type(amount) == "table" then
						amount[2] = amount[2] * op_number
					end
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					if op_number == 4 and type(amount) == "table" then
						op_number = amount[1]
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = v.ability.extra.add/(2^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add*0.8333333333333334
					end
					if type(amount) == "number" then
						amount = amount * op_number
					elseif type(amount) == "table" then
						amount[2] = amount[2] * op_number
					end
				end
			end
		end
	end
	local ret = calcindiveffectref(effect, scored_card, key, amount, from_edition)
	if ret then return ret end
end

local olddrag = Card.stop_drag
function Card:stop_drag()  -- override 
	olddrag(self)
	local eyes = SMODS.find_card("j_MDJ_eyesjoker")
	if next(eyes) then
		for i = 1, #eyes do
			local left_joker
			local eye = eyes[i]
			for k, v in pairs(G.jokers.cards) do
				if k > 1 and v == eye then left_joker = G.jokers.cards[k-1] end
				if v.debuff == true and v.ability.eyes == true and v ~= left_joker then
					v.ability.eyes = nil
					SMODS.debuff_card(v, false, eye.config.center.key)
				end
			end
			if left_joker then
				left_joker.ability.eyes = true
				SMODS.debuff_card(left_joker, true, eye.config.center.key)
			end
		end
	end
end

local oldcardissuit = Card.is_suit
---@diagnostic disable-next-line: duplicate-set-field
function Card:is_suit(suit, bypass_debuff, flush_calc)
	local anarchy = next(SMODS.find_card("j_MDJ_anarchy"))
	if anarchy then
		    local g = oldcardissuit(self, suit, bypass_debuff, flush_calc)
---@diagnostic disable-next-line: undefined-field
			if self.base.suit == 'Hearts' then return self.base.suit ~= suit end
			return g
	else
		local g = oldcardissuit(self, suit, bypass_debuff, flush_calc)
		return g
	end
end

----------------------------------------------
------------MOD CODE END----------------------

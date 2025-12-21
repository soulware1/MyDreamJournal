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
	SMODS.Joker {
		key = "mark",
		atlas = 'awesomejokers',
		pos = { x = 6, y = 2 },
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
end
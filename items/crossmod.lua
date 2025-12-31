---@diagnostic disable: undefined-global
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
		pronouns = 'they_them',
		blueprint_compat = true,
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
			if context.MDJ_mod_key_and_amount then
				local key = context.MDJ_key
				local amount = context.MDJ_amount
				local operation = MyDreamJournal.glopmodkeys[key]
				local op_number = MyDreamJournal.keystonumbers[operation]
				local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					-- mult has the same amount to add as add
					if op_number ~= -1 and op_number ~= 0 then
						op_number = card.ability.extra.add/(10^op_number)
					else
						op_number = card.ability.extra.add
					end
					if is_dark then
						op_number = op_number*2
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
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
		calculate = function (self, card, context)
			if context.MDJ_mod_key_and_amount and context.MDJ_key == "glop" then
				local amount = context.MDJ_amount
				local key = context.MDJ_key
				local cglop = SMODS.Scoring_Parameters.kali_glop.current
				local aglop = cglop * amount
				amount = math.log(aglop, cglop) + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
				key = converted_key
				return {
					MDJ_key = key,
					MDJ_amount = amount
				}
			end
		end
	}
end
-- implment the extra soul layer and tailsman-less emult on our own if neither of these mods are enabled
if not (SMODS.Mods["Cryptid"] or {}).can_load and not (SMODS.Mods["Cryptlib"] or {}).can_load then
	local set_spritesref = Card.set_sprites
	function Card:set_sprites(_center, _front)
		set_spritesref(self, _center, _front)
		if _center and _center.soul_pos and _center.soul_pos.extra then
			self.children.floating_sprite2 = Sprite(
				self.T.x,
				self.T.y,
				self.T.w,
				self.T.h,
				G.ASSET_ATLAS[_center.atlas or _center.set],
				_center.soul_pos.extra
			)
			self.children.floating_sprite2.role.draw_major = self
			self.children.floating_sprite2.states.hover.can = false
			self.children.floating_sprite2.states.click.can = false
		end
	end
	SMODS.DrawStep({
		key = "floating_sprite2",
		order = 59,
		func = function(self)
			if
				self.config.center.soul_pos
				and self.config.center.soul_pos.extra
				and (self.config.center.discovered or self.bypass_discovery_center)
			then
				local scale_mod = 0.07 -- + 0.02*math.cos(1.8*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
				local rotate_mod = 0 --0.05*math.cos(1.219*G.TIMERS.REAL) + 0.00*math.cos((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
				if self.children.floating_sprite2 then
					self.children.floating_sprite2:draw_shader(
						"dissolve",
						0,
						nil,
						nil,
						self.children.center,
						scale_mod,
						rotate_mod,
						nil,
						0.1 --[[ + 0.03*math.cos(1.8*G.TIMERS.REAL)--]],
						nil,
						0.6
					)
					self.children.floating_sprite2:draw_shader(
						"dissolve",
						nil,
						nil,
						nil,
						self.children.center,
						scale_mod,
						rotate_mod
					)
				else
					local center = self.config.center
					if _center and _center.soul_pos and _center.soul_pos.extra then
						self.children.floating_sprite2 = Sprite(
							self.T.x,
							self.T.y,
							self.T.w,
							self.T.h,
							G.ASSET_ATLAS[_center.atlas or _center.set],
							_center.soul_pos.extra
						)
						self.children.floating_sprite2.role.draw_major = self
						self.children.floating_sprite2.states.hover.can = false
						self.children.floating_sprite2.states.click.can = false
					end
				end
			end
		end,
		conditions = { vortex = false, facing = "front" },
	})
	SMODS.draw_ignore_keys.floating_sprite2 = true
	if SMODS then
		SMODS.Sound({
			key = "emult",
			path = "ExponentialMult.wav",
		})
		SMODS.Sound({
			key = "echips",
			path = "ExponentialChips.wav",
		})
		SMODS.Sound({
			key = "xchip",
			path = "MultiplicativeChips.wav",
		})
	end

	if SMODS and SMODS.Mods and not (SMODS.Mods.Talisman or SMODS.Mods.cdataman or {}).can_load then
		local smods_xchips = false
		for _, v in pairs(SMODS.scoring_parameter_keys) do
			if v == "x_chips" then
				smods_xchips = true
				break
			end
		end
		local scie = SMODS.calculate_individual_effect
		function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
			local ret = scie(effect, scored_card, key, amount, from_edition)
			if ret then
				return ret
			end
			if (key == "e_chips" or key == "echips" or key == "Echip_mod") and amount ~= 1 then
				if effect.card then
					juice_card(effect.card)
				end
				local chips = SMODS.Scoring_Parameters["chips"]
				chips:modify((chips.current ^ amount) - chips.current)
				if not effect.remove_default_message then
					if from_edition then
						card_eval_status_text(
							scored_card,
							"jokers",
							nil,
							percent,
							nil,
							{ message = "^" .. amount, colour = G.C.EDITION, edition = true }
						)
					elseif key ~= "Echip_mod" then
						if effect.echip_message then
							card_eval_status_text(
								scored_card or effect.card or effect.focus,
								"extra",
								nil,
								percent,
								nil,
								effect.echip_message
							)
						else
							card_eval_status_text(scored_card or effect.card or effect.focus, "e_chips", amount, percent)
						end
					end
				end
				return true
			end
			if (key == "e_mult" or key == "emult" or key == "Emult_mod") and amount ~= 1 then
				if effect.card then
					juice_card(effect.card)
				end
				local mult = SMODS.Scoring_Parameters["mult"]
				mult:modify((mult.current ^ amount) - mult.current)
				if not effect.remove_default_message then
					if from_edition then
						card_eval_status_text(
							scored_card,
							"jokers",
							nil,
							percent,
							nil,
							{ message = "^" .. amount .. " " .. localize("k_mult"), colour = G.C.EDITION, edition = true }
						)
					elseif key ~= "Emult_mod" then
						if effect.emult_message then
							card_eval_status_text(
								scored_card or effect.card or effect.focus,
								"extra",
								nil,
								percent,
								nil,
								effect.emult_message
							)
						else
							card_eval_status_text(scored_card or effect.card or effect.focus, "e_mult", amount, percent)
						end
					end
				end
				return true
			end
		end
		for _, v in ipairs({
			"e_mult", "emult", "Emult_mod",
			"e_chips", "echips", "Echip_mod",
		}) do
			table.insert(SMODS.scoring_parameter_keys, v)
		end
		if not smods_xchips then
			for _, v in ipairs({ "x_chips", "xchips", "Xchip_mod" }) do
				table.insert(SMODS.scoring_parameter_keys, v)
			end
		end
		to_big = to_big or function(x) return x end
		to_number = to_number or function(x) return x end
		lenient_bignum = lenient_bignum or function(x) return x end
		is_number = is_number or function(x) return type(x) == "number" end
	end
end
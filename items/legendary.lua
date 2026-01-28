SMODS.Joker {
    key = "soulware",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 4,
	pronouns = 'he_him',
    blueprint_compat = true,
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
						op_number = 1+card.ability.extra.add/(10^op_number)
					elseif op_number == -1 then
						op_number = card.ability.extra.add
					elseif op_number == 0 then
						op_number = card.ability.extra.add*0.8333333333333334
					end
					if is_dark then
						op_number = op_number * 2
					end
					if not is_hyper then
						amount = amount * op_number
					else
						amount[2] = amount[2] * op_number
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
						op_number = 1+(card.ability.extra.extra/(2^op_number))
					elseif op_number == -1 then
						op_number = card.ability.extra.add
					elseif op_number == 0 then
						op_number = card.ability.extra.add*0.8333333333333334
					end
					if is_dark then
						op_number = op_number * 2
					end
					if not is_hyper then
						amount = amount * op_number
					else
						amount[2] = amount[2] * op_number
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
SMODS.Joker {
    key = "heartware",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 4,
	pronouns = 'she_her',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 20,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "MDJ_precent", config = {} }
        return { vars = {  } }
    end,
    calculate = function (self, card, context)
        if context.MDJ_mod_key_and_amount then
            local key = context.MDJ_key
            if MyDreamJournal.plusmulttoxmult[key] then
                return {
                    MDJ_key = 'percent_mult',
                    MDJ_amount = context.MDJ_amount*10
                }
            end
            if MyDreamJournal.pluschipstoxchips[key] then
                return {
                    MDJ_key = 'percent_chips',
                    MDJ_amount = context.MDJ_amount*10
                }
            end
        end
    end
}
SMODS.Joker {
    key = "fake_glop",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 4,
	pronouns = 'she_her',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
	immutable = true,
    cost = 20,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                xchips = SMODS.Scoring_Parameters["mult"].current,
                eq_mult = 1
            }
        end
    end
}
SMODS.Joker {
    key = "execution",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 4,
	pronouns = 'she_her',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 20,
    config = { extra = { per = 0.01 }},
    loc_vars = function(self, info_queue, card)
        local loc_mult = ' ' .. localize('k_chips') .. localize("k_MDJ_right_parenthisis")
        main_start = {
            { n = G.UIT.T, config = { text = localize("k_MDJ_left_parenthisis")..localize("k_MDJ_currently")..' ', colour = G.C.UI.TEXT_DARK, scale = 0.32 } },
            { n = G.UIT.T, config = { text = '+', colour = G.C.BLUE, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({
            string = {{
            ref_table = setmetatable({}, {
                __index = function()
                    return number_format(collectgarbage("count")*(G.GAME.round_resets.ante or 1)*card.ability.extra.per)
                end, }), ref_value = "doesnt matter"}}, colours = { G.C.BLUE }, scale = 0.32,}) } },
                { n = G.UIT.T, config = { text = ' ' .. localize('k_chips')..localize("k_MDJ_right_parenthisis"), colour = G.C.UI.TEXT_DARK, scale = 0.32 } },
            }
        return { vars = { card.ability.extra.per }, main_end = main_start }
    end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
            return {
                chips = collectgarbage("count")*(G.GAME.round_resets.ante or 1)*card.ability.extra.per
            }
        end
    end,
}
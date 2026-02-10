if not (SMODS.Mods["entr"] and SMODS.Mods["entr"].can_load) then
    return
end
SMODS.Joker {
    key = "brainware",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = "entr_reverse_legendary",
	pronouns = 'they_them',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 20,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
}
function fibbedfibonacci(n)
    return math.floor((1.618034^math.floor(n+0.5)/math.sqrt(5))+0.5)
end
SMODS.Joker {
    key = "fervourware",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = "entr_reverse_legendary",
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    immutable = true,
    cost = 20,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "MDJ_scoreops", config = {} }
        return { vars = {  } }
    end,
    calculate = function (self, card, context)
        if context.MDJ_mod_key_and_amount then
            if MyDreamJournal.plusops[context.MDJ_key] then
                return {
                    MDJ_amount = fibbedfibonacci(math.ceil(context.MDJ_amount))
                }
            end
        end
    end
}
SMODS.Joker {
    key = "liverware",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = "entr_reverse_legendary",
	pronouns = 'she_her',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 20,
    config = { extra = { mult = 10 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function (self, card, context)
        if context.MDJ_mod_key_and_amount then
            local key = context.MDJ_key
			local scoreparams = SMODS.Scoring_Parameters
            if MyDreamJournal.xchipstoechips[key] then
                return {
                    MDJ_key = 'chips',
					MDJ_amount = ((scoreparams.chips.current*context.MDJ_amount)-scoreparams.chips.current)*card.ability.extra.mult
                }
            end
            if MyDreamJournal.xmulttoemult[key] then
                return {
                    MDJ_key = 'mult',
					MDJ_amount = ((scoreparams.mult.current*context.MDJ_amount)-scoreparams.mult.current)*card.ability.extra.mult
                }
            end
        end
    end
}
SMODS.Joker {
    key = "ZZaZZ",
    atlas = 'awesomejokers',
    pos = { x = 4, y = 4 },
    soul_pos = { x = 5, y = 4 },
	discovered = true,
    rarity = "entr_reverse_legendary",
	pronouns = 'ZZaZZ',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 20,
	-- so no one gets any ZZnZZy ideas!
	immutable = true,
    config = { extra = { mod = 255 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mod } }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                base_mod_plus_one_mult_then_chips = card.ability.extra.mod,
            }
        end
    end
}
SMODS.Joker {
    key = "fake_sfark",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = "entr_reverse_legendary",
	pronouns = 'she_her',
    blueprint_compat = true,
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
        if context.MDJ_mod_key_and_amount then
            if MyDreamJournal.pluschipstoxchips[context.MDJ_key] then
                return {
                    MDJ_amount = context.MDJ_amount*SMODS.Scoring_Parameters["mult"].current,
                }
            end
        end
    end
}

SMODS.Joker {
    key = "grilled_orange_chicken",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
    pools = {["Food"] = true, ["Grilled Chicken"] = true},
	discovered = true,
    rarity = "entr_reverse_legendary",
	pronouns = 'any_all',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 20,
    config = { extra = { xmult = 6.5, retrig = 2 }, },
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
		if context.retrigger_joker_check and card.ability.extra.retrig > 0 then
			if context.other_card == card then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.retrig,
					card = card,
				}
			else
				return nil, true
			end
		end
        if context.setting_blind or context.forcetrigger then
            for i, v in pairs(G.jokers.cards) do
                if MyDreamJournal.is_grilled_chicken(v) and v ~= card then
                    if v.ability.extra.xmult then
                        SMODS.scale_card(
                            card,
                            {
                                ref_table = card.ability.extra, -- the table that has the value you are changing in
                                ref_value = "xmult", -- the key to the value in the ref_table
                                scalar_table = v.ability.extra,
                                scalar_value = "xmult", -- the key to the value to scale by, in the ref_table by default
                            }
                        )
                    end
                    if v.ability.extra.retrig then
                        SMODS.scale_card(
                            card,
                            {
                                ref_table = card.ability.extra, -- the table that has the value you are changing in
                                ref_value = "retrig", -- the key to the value in the ref_table
                                scalar_table = v.ability.extra,
                                scalar_value = "retrig", -- the key to the value to scale by, in the ref_table by default
                                no_message = true
                            }
                        )
                    end
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            v.ability.extra.retrig = 0
                            v.ability.extra.xmult = 1
                            return true
                        end)
                    }))
                    SMODS.destroy_cards(v)
                end
            end
        end
        if context.joker_main or context.forcetrigger then
			return {
				xmult = card.ability.extra.xmult
			}
		end
    end,
}
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
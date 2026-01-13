SMODS.Joker {
    key = "digital",
    pos = {x = 0, y = 0 },
    soul_pos = { x = 1, y = 0, extra = { x = 2, y = 0 } },
    atlas = "eplaceholder",
	discovered = true,
    rarity = "entr_entropic",
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 150,
    config = { extra = { add = 2, mult = 3 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add, card.ability.extra.mult } }
    end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				mult = card.ability.extra.add^4,
                chips = card.ability.extra.add^30,
                dollars = card.ability.extra.add^1,
				xmult = card.ability.extra.mult^2,
                xchips = card.ability.extra.mult^2,
			}
		end
		if context.MDJ_mod_key_and_amount then
			local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
			local key = context.MDJ_key
			local amount = context.MDJ_amount
            -- should skip over the rest of the code
            if MyDreamJournal.dollarmodkeys[key] then
				amount = amount^card.ability.extra.add
			end
            local operation = MyDreamJournal.multmodkeys[key] or MyDreamJournal.chipmodkeys[key]
            local op_number = MyDreamJournal.keystonumbers[operation]
            if op_number == -1 then
                amount = card.ability.extra.add^amount
            elseif op_number == 0 then
                amount = card.ability.extra.mult^amount
            end
			return {
				MDJ_amount = amount,
				MDJ_key = key
			}
		end
	end
}
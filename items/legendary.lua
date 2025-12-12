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
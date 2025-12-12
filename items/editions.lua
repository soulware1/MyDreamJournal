 SMODS.Sound(
	{
			key = "snd",
			path = "snd.ogg",
			per = 1,
			volume = 1
	}
 )
SMODS.Edition({
    key = "corrupted",
    loc_txt = {
        name = "Corrupted",
        label = "Corrupted",
		sound = "MDJ_snd",
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
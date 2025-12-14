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
    sound = {
		sound = "MDJ_snd",
		per = 1,
		vol = 0.7,
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
    extra_cost = 0,
    apply_to_float = true,
    loc_vars = function(self)
        return { vars = { self.config.x_mult, self.config.d_chips } }
    end,
})
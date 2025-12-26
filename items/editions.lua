 SMODS.Sound(
	{
			key = "snd",
			path = "snd.ogg",
			per = 1,
			volume = 1
	}
 )
  SMODS.Sound(
	{
			key = "dark",
			path = "evilchrome.ogg",
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
    config = { x_mult = 7.5, d_chips = "(2/15)", x_glop = 40, d_sfark = "(1/40)" },
    in_shop = true,
    weight = 8,
    extra_cost = 0,
    apply_to_float = true,
    loc_vars = function(self)
        local key = self.key
        key = key..(next(SMODS.find_mod("potassium_re")) and "_glopped" or "")
        local vars = {
            self.config.x_mult, self.config.d_chips,
            self.config.x_glop, self.config.d_sfark,
        }
        return { key = key, vars = vars }
    end,
})
SMODS.Edition({
    key = "dark",
    sound = {
		sound = "MDJ_dark",
		per = 1,
		vol = 0.7,
	},
	-- Stop shadow from being rendered under the card
    disable_shadow = true,
    -- Stop extra layer from being rendered below the card.
    -- For edition that modify shape or transparency of the card.
    shader = "dark",
    discovered = true,
    unlocked = true,
    config = { mult = 2 },
    in_shop = true,
    weight = 3,
    extra_cost = 0,
    apply_to_float = true,
    loc_vars = function(self)
        local vars = { self.config.mult }
        return { vars = vars }
    end,
})
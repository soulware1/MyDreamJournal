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
   SMODS.Sound(
	{
			key = "amazing",
			path = "blastedchrome.ogg",
			per = 1,
			volume = 1
	}
 )
    SMODS.Sound(
	{
			key = "blackscale",
			path = "blackscale.ogg",
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
    extra_cost = 6,
    apply_to_float = true,
    loc_vars = function(self)
        local vars = { self.config.mult }
        return { vars = vars }
    end,
})
SMODS.Edition({
    key = "amazing",
    sound = {
		sound = "MDJ_amazing",
		per = 1,
		vol = 0.7,
	},
	-- Stop shadow from being rendered under the card
    disable_shadow = true,
    -- Stop extra layer from being rendered below the card.
    -- For edition that modify shape or transparency of the card.
    shader = "amazing",
    discovered = true,
    unlocked = true,
    config = { expo = 1.5 },
    in_shop = true,
    weight = 3,
    extra_cost = 6,
    apply_to_float = true,
    loc_vars = function(self)
        local vars = { self.config.expo }
        return { vars = vars }
    end,
})
SMODS.Edition({
    key = "blackscale",
    sound = {
		sound = "MDJ_blackscale",
		per = 1,
		vol = 0.7,
	},
	-- Stop shadow from being rendered under the card
    disable_shadow = true,
    -- Stop extra layer from being rendered below the card.
    -- For edition that modify shape or transparency of the card.
    shader = "blackscale",
    discovered = true,
    unlocked = true,
    config = { base = 12 },
    in_shop = true,
    weight = 3,
    extra_cost = 6,
    apply_to_float = true,
    loc_vars = function(self)
        local vars = { self.config.base }
        return { vars = vars }
    end,
    calculate = function (self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                base_mult = card.edition.base
            }
        end
    end
})
SMODS.Sticker {
    key = "attention",
    badge_colour = HEX('FBDB41'),
    atlas = "stickers",
    pos = { x = 0, y = 0 },
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end,
    apply = function(self,card,val)
        card.ability.MDJ_attention = true
    end,
}

local randompick = pseudorandom_element
function pseudorandom_element(table, ...)
    for key, v in pairs(table) do
        if v and type(v) == "table" and v.ability and v.ability.MDJ_attention then
            return v
        end
    end
    return randompick(table, ...)
end
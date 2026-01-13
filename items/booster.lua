---@diagnostic disable: return-type-mismatch
local ease_bg_hardware = function(self)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Hardware, special_colour = G.C.SECONDARY_SET.Hardware})
end

SMODS.Booster{
    key = "hardware_pack_1",
    set = "Booster",
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_MDJ_hardware_pack_normal"
        }
    end,
    atlas = 'placeholder', pos = { x = 0, y = 1 },
    group_key = "k_MDJ_hardware_pack",
    cost = 4,
    weight = 0.5,
    draw_hand = true,
    kind = "hardware_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{ set = "Hardware", area = G.pack_cards, skip_materialize = true }
    end,
    ease_background_colour = ease_bg_hardware,
}
SMODS.Booster{
    key = "hardware_pack_2",
    set = "Booster",
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_MDJ_hardware_pack_normal"
        }
    end,
    atlas = 'placeholder', pos = { x = 0, y = 1 },
    group_key = "k_MDJ_hardware_pack",
    cost = 4,
    weight = 0.5,
    draw_hand = true,
    kind = "hardware_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{ set = "Hardware", area = G.pack_cards, skip_materialize = true }
    end,
    ease_background_colour = ease_bg_hardware,
}
SMODS.Booster{
    key = "hardware_pack_3",
    set = "Booster",
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_MDJ_hardware_pack_normal"
        }
    end,
    atlas = 'placeholder', pos = { x = 0, y = 1 },
    group_key = "k_MDJ_hardware_pack",
    cost = 4,
    weight = 0.5,
    draw_hand = true,
    kind = "hardware_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{ set = "Hardware", area = G.pack_cards, skip_materialize = true }
    end,
    ease_background_colour = ease_bg_hardware,
}
SMODS.Booster{
    key = "hardware_pack_4",
    set = "Booster",
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_MDJ_hardware_pack_normal"
        }
    end,
    atlas = 'placeholder', pos = { x = 0, y = 1 },
    group_key = "k_MDJ_hardware_pack",
    cost = 4,
    weight = 0.5,
    draw_hand = true,
    kind = "hardware_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{ set = "Hardware", area = G.pack_cards, skip_materialize = true }
    end,
    ease_background_colour = ease_bg_hardware,
}
SMODS.Booster{
    key = "jumbo_hardware_pack_1",
    set = "Booster",
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_MDJ_hardware_pack_jumbo"
        }
    end,
    atlas = 'placeholder', pos = { x = 1, y = 1 },
    group_key = "k_MDJ_hardware_pack",
    cost = 6,
    weight = 0.5,
    draw_hand = true,
    kind = "hardware_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{ set = "Hardware", area = G.pack_cards, skip_materialize = true }
    end,
    ease_background_colour = ease_bg_hardware,
}
SMODS.Booster{
    key = "jumbo_hardware_pack_2",
    set = "Booster",
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_MDJ_hardware_pack_jumbo"
        }
    end,
    atlas = 'placeholder', pos = { x = 1, y = 1 },
    group_key = "k_MDJ_hardware_pack",
    cost = 6,
    weight = 0.5,
    draw_hand = true,
    kind = "hardware_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{ set = "Hardware", area = G.pack_cards, skip_materialize = true }
    end,
    ease_background_colour = ease_bg_hardware,
}
SMODS.Booster{
    key = "mega_hardware_pack_1",
    set = "Booster",
    config = { extra = 4, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_MDJ_hardware_pack_mega"
        }
    end,
    atlas = 'placeholder', pos = { x = 2, y = 1 },
    group_key = "k_MDJ_hardware_pack",
    cost = 8,
    weight = 0.125,
    draw_hand = true,
    kind = "hardware_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{ set = "Hardware", area = G.pack_cards, skip_materialize = true }
    end,
    ease_background_colour = ease_bg_hardware,
}
SMODS.Booster{
    key = "mega_hardware_pack_2",
    set = "Booster",
    config = { extra = 4, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
            key = "p_MDJ_hardware_pack_mega"
        }
    end,
    atlas = 'placeholder', pos = { x = 2, y = 1 },
    group_key = "k_MDJ_hardware_pack",
    cost = 8,
    weight = 0.125,
    draw_hand = true,
    kind = "hardware_pack",
    create_card = function (self, card, i) 
        return SMODS.create_card{ set = "Hardware", area = G.pack_cards, skip_materialize = true }
    end,
    ease_background_colour = ease_bg_hardware,
}
SMODS.Joker {
    dependencies = {
        items = {
            "set_entr_misc_jokers",
            "set_entr_inversions"
        }
    },
    object_type = "Joker",
    key = "flipside",
    atlas = "awesomejokers",
    pos = {x = 3, y = 5},
    discovered = true,
    rarity = MyDreamJournal.epic,
    pronouns = "he_him",
    blueprint_compat = false,
    perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = false,
    cost = 5,
    config = {},
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.config.center.pos.x = pseudorandom(tostring(card), 3, 6)
    end
}
local ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, ...)
    local card = ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, ...)
    if not card then
        return
    end
    if
        card.config and card.config.center and Entropy.FlipsideInversions and next(SMODS.find_card("j_MDJ_flipside")) and
            (not card.area or not card.area.config.collection) and
            Entropy.Inversion(card.config.center)
     then
        ---@diagnostic disable-next-line: undefined-global
        local c = G.P_CENTERS[Entropy.Inversion(card.config.center)]
        card:set_ability(c)
        key = c.key
        set = c.set
    end
    return card
end
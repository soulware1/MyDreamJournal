SMODS.ConsumableType{
    key = "Hardware",
    primary_colour = G.C.SET.Hardware,
    secondary_colour = G.C.SECONDARY_SET.Hardware,
    collection_rows = { 4, 4 },
    shop_rate = 0,
    default = "c_akyrs_replicant_music_streaming"
}

SMODS.UndiscoveredSprite{
    key = "Hardware",
    atlas = "placeholder",
    pos = {x=1, y=0}
}

SMODS.Consumable {
    key = 'hardware_motherboard',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
        local motherboard_c = G.GAME.MDJ_last_hardware and G.P_CENTERS[G.GAME.MDJ_last_hardware] or nil
        local last_hardware = motherboard_c and localize { type = 'name_text', key = motherboard_c.key, set = motherboard_c.set } or
            localize('k_none')
        local colour = (not motherboard_c or motherboard_c.name == 'Motherboard') and G.C.RED or G.C.GREEN

        if not (not motherboard_c or motherboard_c.name == 'Motherboard') then
            info_queue[#info_queue + 1] = motherboard_c
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_hardware .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { vars = { last_hardware }, main_end = main_end }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ key = G.GAME.MDJ_last_hardware })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.consumeables.config.card_limit > #G.consumeables.cards and G.GAME.MDJ_last_hardware and
            G.GAME.MDJ_last_hardware ~= 'c_MDJ_hardware_motherboard'
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

SMODS.Consumable {
    key = 'hardware_speaker',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                SMODS.add_card({ set = 'Music', area = G.jokers })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

SMODS.Consumable {
    key = 'hardware_ram',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_MDJ_dark
        info_queue[#info_queue + 1] = G.P_CENTERS.e_MDJ_amazing
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                for i = 1, #G.hand.highlighted do
                    local edition = SMODS.poll_edition({ key = "hardware_speaker", guaranteed = true, no_negative = true, options = { 'e_MDJ_amazing', 'e_MDJ_dark' } })
                    local ram_card = G.hand.highlighted[i]
                    ram_card:set_edition(edition, true)
                end
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return G.hand and G.hand.highlighted and #G.hand.highlighted and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted > 0
    end
}

SMODS.Consumable {
    key = 'hardware_hard_drive',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_MDJ_corrupted
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                for i = 1, #G.hand.highlighted do
                    local edition = "e_MDJ_corrupted"
                    local hard_drive_card = G.hand.highlighted[i]
                    hard_drive_card:set_edition(edition, true)
                end
                for i = 1, #G.jokers.highlighted do
                    local edition = "e_MDJ_corrupted"
                    local hard_drive_card = G.jokers.highlighted[i]
                    hard_drive_card:set_edition(edition, true)
                end
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return ( ( G.hand and G.hand.highlighted and #G.hand.highlighted and 
        #G.hand.highlighted <= card.ability.max_highlighted and 
        #G.hand.highlighted > 0 ) or ( G.jokers and G.jokers.highlighted and #G.jokers.highlighted and #G.jokers.highlighted <= card.ability.max_highlighted and
        #G.jokers.highlighted > 0 ) ) and ( G.jokers.highlighted and #G.jokers.highlighted or 0 ) + ( G.hand.highlighted and #G.hand.highlighted or 0 ) <= card.ability.max_highlighted
    end
}

SMODS.Consumable {
    key = 'hardware_capacitor',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 1, retriggers = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.retriggers } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                for i = 1, #G.hand.highlighted do
                    local capacitor_card = G.hand.highlighted[i]
                    capacitor_card.ability.perma_repetitions = ( capacitor_card.ability.perma_repetitions or 0 )+card.ability.retriggers
                    capacitor_card:juice_up(0.3, 0.5)
                end
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return G.hand and G.hand.highlighted and #G.hand.highlighted and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted > 0
    end
}

SMODS.Consumable {
    key = 'hardware_keyboard',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 2, mod_conv = 'm_MDJ_envelope' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}

SMODS.Consumable {
    key = 'hardware_transistor',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    config = { },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local highlighted = nil
                local candidates = {}
                for _, j in pairs(G.I.CARDAREA) do
                    for _, v in pairs(j.highlighted) do
                        if v == card then
                            goto LOSER
                        end
                    end
                    candidates[#candidates+1] = j.highlighted
                    ::LOSER::
                end
                for _, v in ipairs(candidates) do
                    if #v == 2 then
                        highlighted = v
                    end
                end
                ---@diagnostic disable-next-line: need-check-nil
                local card1 = highlighted[1]
                ---@diagnostic disable-next-line: need-check-nil
                local card2 = highlighted[2]
                local edition1 = card1.edition or "e_base"
                local edition2 = card2.edition or "e_base"
                card1:set_edition(edition2)
                card2:set_edition(edition1)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        local highlighted = nil
        local candidates = {}
        for _, j in pairs(G.I.CARDAREA) do
            for _, v in pairs(j.highlighted) do
                if v == card then
                    goto LOSER
                end
            end
            candidates[#candidates+1] = j.highlighted
            ::LOSER::
        end
        for _, v in ipairs(candidates) do
            if #v == 2 then
                highlighted = v
            end
        end
        return highlighted and #highlighted == 2
    end
}

SMODS.Consumable {
    key = 'hardware_electron_emitter',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    config = { add = 0.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.add, card.ability.add/10 } }
    end,
    use = function(self, card, area, copier)
        G.GAME.MDJ_electron_beam = G.GAME.MDJ_electron_beam+card.ability.add
    end,
    can_use = function(self, card)
        return true
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
SMODS.Consumable {
    key = "hardware_lightbulb",
    atlas = "placeholder",
    set = 'Hardware',
    config = { selection = 1 },
    pos = { x = 1, y = 0 },
    use = function(self, card, area, copier)
        for i, v in pairs(G.jokers.highlighted) do
            MyDreamJournal.ApplySticker(v, "MDJ_attention")
            v:juice_up()
        end
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted <= card.ability.selection
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "MDJ_attention"}
        return {
            vars = {
                card.ability.selection
            }
        }
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

SMODS.Consumable {
    key = 'hardware_led',
    atlas = "placeholder",
    set = 'Hardware',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local suit_conv = ( G.hand and G.hand.highlighted[#G.hand.highlighted] and G.hand.highlighted[1].base and G.hand.highlighted[1].base.suit )
        assert(suit_conv, "wtf where's the rightmost card's suit")
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    assert(SMODS.change_base(G.hand.highlighted[i], suit_conv))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
}
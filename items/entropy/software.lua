---@diagnostic disable: return-type-mismatch
G.C.SET.Software = HEX('FF0000')
G.C.SECONDARY_SET.Software = HEX('000000')
G.ARGS.LOC_COLOURS.MDJ_Software = G.C.SECONDARY_SET.Software
SMODS.ConsumableType{
    key = "Software",
    primary_colour = G.C.SET.Software,
    secondary_colour = G.C.SECONDARY_SET.Software,
    collection_rows = { 4, 4 },
    shop_rate = 0,
    default = "c_MDJ_software_os"
}

SMODS.UndiscoveredSprite{
    key = "Software",
    atlas = "placeholder",
    pos = {x=3, y=1}
}

SMODS.Consumable {
    key = 'software_os',
    atlas = "placeholder",
    set = 'Software',
    pos = { x = 3, y = 1 },
    inversion = "c_MDJ_hardware_motherboard",
    loc_vars = function(self, info_queue, card)
        local lconsumable = G.GAME.MDJ_last_used_consumable
        local last_consumable = lconsumable and localize(lconsumable) or localize('k_none')
        local colour = not lconsumable and G.C.RED or G.C.GREEN

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_consumable .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { vars = { last_consumable }, main_end = main_end }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ set = G.GAME.MDJ_last_used_consumable })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.consumeables.config.card_limit > #G.consumeables.cards and G.GAME.MDJ_last_used_consumable
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}

SMODS.Consumable {
    key = "software_pixel",
    config = { selection = 1 },
    atlas = "placeholder",
    set = 'Software',
    pos = { x = 3, y = 1 },
    inversion = "c_MDJ_software_pixel",
    use = function(self, card, area, copier)
        for i, v in pairs(G.jokers.highlighted) do
            MyDreamJournal.ApplySticker(v, "MDJ_ouroboros")
            v:juice_up()
        end
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted <= card.ability.selection
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "MDJ_ouroboros"}
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
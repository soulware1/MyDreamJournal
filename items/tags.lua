SMODS.Tag {
    key = "music_top_up",
    min_ante = 2,
    pos = { x = 0, y = 0 },
    atlas = "tags",
    config = { spawn_jokers = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.spawn_jokers } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Music",
                            rarity = 2,
                            area = G.jokers,
                        }
                    end
                end
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}
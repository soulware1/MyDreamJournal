SMODS.Tag {
    key = "ascendant_music_top_up",
	in_pool = function() return false end or nil,
    pos = { x = 1, y = 0 },
    atlas = "tags",
    config = { spawn_jokers = 3 },
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
                            rarity = "Uncommon",
                            area = G.jokers,
                            key_append = "vremade_top"
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
Entropy.AscendedTags["tag_MDJ_music_top_up"] = "tag_MDJ_ascendant_music_top_up"
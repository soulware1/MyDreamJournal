local rarity_probablities = {
    [1] = {1, 2},
    [2] = {3, 5},
    [3] = {1, 3},
    [MyDreamJournal.epic] = {1, 7},
    [4] = {0, 100},
    [MyDreamJournal.exotic] = {0, 100}
}
SMODS.Consumable {
    key = 'ware',
    set = 'Spectral',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 1, y = 1, extra = { x = 2, y = 1} },
    atlas = "eplaceholder",
    discovered = true,
    hidden = true,
    soul_set = 'Hardware',
    config = { extra = { unrare = MyDreamJournal.epic, unlegendary = MyDreamJournal.exotic, }, },
    loc_vars = function(self, info_queue, card)
        local highest_rarity = 1
        if G.jokers then
            for i = 1, #G.jokers.cards do
                local joker = G.jokers.cards[i]
                if joker.config.center.rarity == MyDreamJournal.veryrare then
                    highest_rarity = MyDreamJournal.veryrare
                elseif type(joker.config.center.rarity) == "number" and joker.config.center.rarity > highest_rarity then
                    highest_rarity = joker.config.center.rarity
                end
            end
            if type(highest_rarity) == "number" then
                local rarities = {
                    "Common",
                    "Uncommon",
                    "Rare",
                    "Legendary"
                }
                ---@diagnostic disable-next-line: cast-local-type
                highest_rarity = rarities[highest_rarity]
            end
        else
            ---@diagnostic disable-next-line: cast-local-type
            highest_rarity = "Common"
        end
        return { vars = { localize("k_"..MyDreamJournal.epic:lower()), localize("k_"..MyDreamJournal.exotic:lower()), localize("k_"..highest_rarity:lower()), colours = { G.C[MyDreamJournal.epic] or G.C.RARITY[MyDreamJournal.epic] or G.C.FILTER, G.C[MyDreamJournal.exotic] or G.C.RARITY[MyDreamJournal.exotic] or G.C.FILTER } } }
    end,
    use = function(self, card, area, copier)
        if G.jokers.highlighted[1] then
            local joker = G.jokers.highlighted[1]
            local rarity = joker.config.center.rarity
            local probablities = rarity_probablities[rarity]
            if not probablities then
                probablities = {1, 2}
            end
            if SMODS.pseudorandom_probability(card, pseudoseed("soupware..."), probablities[1], probablities[2], nil, true) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        SMODS.destroy_cards(joker)
                        SMODS.add_card({ set = 'Joker', rarity = MyDreamJournal.epic })
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                delay(0.6)
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        SMODS.destroy_cards(joker)
                        SMODS.add_card({ set = 'Joker', rarity = MyDreamJournal.exotic })
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                delay(0.6)
            end
        else -- no jokers
            if SMODS.pseudorandom_probability(card, pseudoseed(tostring({})), 1, 2, nil, true) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Joker', rarity = MyDreamJournal.epic })
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                delay(0.6)
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Joker', rarity = MyDreamJournal.exotic })
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                delay(0.6)
            end
        end
    end,
    can_use = function(self, card)
        local max_rarity = 0
        if #G.jokers.cards == 0 then
            -- i like the player, so let them use it if they have no jokers, also technically if you have no jokers, you are currently selecting your rarest joker
            return true
        end
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]
            if joker.config.center.rarity == MyDreamJournal.veryrare then
                max_rarity = MyDreamJournal.veryrare
            elseif type(joker.config.center.rarity) == "number" and joker.config.center.rarity > max_rarity then
                max_rarity = joker.config.center.rarity
            end
        end
        
        if max_rarity == 0 then -- player has only unknown/unlegendary rarity jokers
            return G.jokers.highlighted[1]
        else
            return G.jokers.highlighted[1] and (G.jokers.highlighted[1].config.center.rarity == max_rarity)
        end
    end,
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
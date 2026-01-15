local to_big = to_big or function(n)
	return n
end
SMODS.Font {
	key = "arial",
	path = "arimo.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 0.9,
	TEXT_OFFSET = { x = 12, y = -24 },
	FONTSCALE = 0.06,
	squish = 1,
	DESCSCALE = 1.25
}
SMODS.Joker {
    key = "floatingpoint",
    atlas = 'awesomejokers',
    pos = { x = 8, y = 2 },
    soul_pos = { x = 9, y = 2 },
	discovered = true,
    rarity = MyDreamJournal.epic,
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 15,
	-- so no one gets any funnny ideas!
	immutable = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "MDJ_heximal_slop", config = {} }
        return { vars = {} }
    end,
    calculate = function (self, card, context)
        if (context.joker_main or context.forcetrigger) and to_big(#context.scoring_hand) == to_big(6) then
            return {
                base_chips = 6,
                base_mult = 6,
            }
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        MyDreamJournal.handlimitchange(1)
    end,
    remove_from_deck = function (self, card, from_debuff)
        MyDreamJournal.handlimitchange(-1)
    end
}
function dedupe(tab)
    local hash = {}
    local res = {}

    for _,v in ipairs(tab) do
        if (not hash[v]) then
            res[#res+1] = v
            hash[v] = true
        end
    end
    return res
end
SMODS.Joker {
    key = "spaces",
    atlas = 'awesomejokers',
    pos = { x = 9, y = 3 },
	discovered = true,
    rarity = MyDreamJournal.epic,
    pools = {Music = true},
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 14,
    config = { extra = { mult = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function (self, card, context)
        if (context.joker_main or context.forcetrigger) then
            local card_ranks = {}
            for i = 1, #context.scoring_hand do
                local playing_card = context.scoring_hand[i]
                if not SMODS.has_no_rank(playing_card) then
                    card_ranks[#card_ranks+1] = playing_card:get_id()
                end
            end
            card_ranks = dedupe(card_ranks)
            -- xchips, starts at 1, increases for each unique rank in scoring hand
            -- xmult, starts at 1, increases for each missing rank in scoring hand, the range of possible ranks is 12
            return {
                xchips = math.max(1, 1+((#card_ranks)*card.ability.extra.mult)),
                xmult = math.max(1,1+((12-#card_ranks)*card.ability.extra.mult)),
            }
        end
    end,
}
SMODS.Joker {
    key = "powerstone",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = MyDreamJournal.epic,
	pronouns = 'he_they',
    blueprint_compat = false,
	perishable_compat = false,
    eternal_compat = false,
    cost = 10,
    immutable = true,
    config = { extra = { timer = 3 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.timer } }
    end,
	calc_scaling = function(self, card, other_card, initial_value, scalar_value, args)
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
        end
        if not other_joker or not other_joker.ability or other_joker.immutable or (other_joker.ability and not other_joker.ability.extra) or other_card == card or args["prediction_scaling"] or other_card.config.center.key == "j_MDJ_powerstone" or args["operation"] == "-" or scalar_value <= 0 then
            return
        end
        local temp = {
            scalar_value = scalar_value
        }
        if type(other_joker.ability.extra) == "number" or (type(other_joker.ability.extra) == "table" and other_joker.ability.extra.arrow) then
            	SMODS.scale_card(card, {
                    ref_table = other_joker.ability, -- the table that has the value you are changing in
                    scalar_table = temp,
                    ref_value = "extra", -- the key to the value in the ref_table
                    scalar_value = "scalar_value", -- the key to the value to scale by, in the ref_table by default
                    scaling_message = {
                    message = "Upgrade!",
                    colour = G.C.BLACK
				}
				})
                return {
                    override_scalar_value = { -- this will override the scalar_value
                        value = 0, -- set the scalar_value to X
                        -- other calculation return keys accepted here, timing is before the scaling event
                    },
                }
        end
        for k, v in pairs(other_joker.ability.extra) do
            SMODS.scale_card(card, {
                    ref_table = other_joker.ability.extra, -- the table that has the value you are changing in
                    scalar_table = temp,
                    ref_value = k, -- the key to the value in the ref_table
                    scalar_value = "scalar_value", -- the key to the value to scale by, in the ref_table by default
                    scaling_message = {
                    message = "Upgrade!",
                    colour = G.C.BLACK
				}
            })
        end
        return {
            override_scalar_value = { -- this will override the scalar_value
                value = 0, -- set the scalar_value to X
                -- other calculation return keys accepted here, timing is before the scaling event
            },
        }
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval then
            card.ability.extra.timer = card.ability.extra.timer-1
            if card.ability.extra.timer <= 0 then
                SMODS.destroy_cards(card)
            end
        end
    end
}
SMODS.Joker {
    key = "complex",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = MyDreamJournal.epic,
	pronouns = 'she_her',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 4,
	-- so no one gets any funnnnnnnny ideas!
	immutable = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function (self, card, context)
        if context.mod_probability then
            return {
                numerator = context.denominator-context.numerator
            }
        end
    end
}
SMODS.Joker {
    key = "empty",
    atlas = 'awesomejokers',
    pos = { x = 6, y = 4 },
    blueprint_compat = true,
    eternal_compat = false,
    discovered = true,
    rarity = MyDreamJournal.epic,
    pronouns = 'it_its',
    cost = 10,
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    local other_joker = nil
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
                    end
                    if not other_joker then
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                'tm' or 'cm',
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                            silent = true
                        })
                    else
                        local copied_joker = copy_card(other_joker, nil, nil, nil, nil)
                        copied_joker:start_materialize()
                        copied_joker:add_to_deck()
                        G.jokers:emplace(copied_joker)
                    end
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
}

SMODS.Joker {
    key = "pacemaker",
    blueprint_compat = true,
    atlas = 'awesomejokers',
    rarity = MyDreamJournal.epic,
    pronouns = "she_her",
    cost = 8,
    discovered = true,
    pos = { x = 2, y = 5 },
    immutable = true,
    config = { extra = { base = to_big(11) } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.base } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Hearts", true) then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.base = card.ability.extra.base+1
                return {
                    base_chips = card.ability.extra.base-1
                }
            end
        end
        if context.end_of_round and context.main_eval then
            card.ability.extra.base = to_big(11)
        end
    end,
}
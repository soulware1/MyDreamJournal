local to_big = to_big or function(n)
	return n
end
SMODS.Joker {
    key = "forcedmove",
    atlas = 'awesomejokers',
    pos = { x = 9, y = 0 },
	discovered = true,
    rarity = MyDreamJournal.epic,
	pronouns = 'it_its',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 14,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
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
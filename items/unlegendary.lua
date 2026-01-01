-- fucks with pseduorandom
SMODS.Joker {
    key = "forcedmove",
    atlas = 'awesomejokers',
    pos = { x = 9, y = 0 },
	discovered = true,
    rarity = MyDreamJournal.exotic,
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
-- ^2 to all +mult, +chips, and +$
-- ^1.5 to all xmult and xchips
-- ^(1+1/(N+2)^2) to all higher operation mult and chips
SMODS.Joker {
    key = "rgb",
    pos = {x = 0, y = 0 },
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
    atlas = "exotic",
	discovered = true,
    rarity = MyDreamJournal.exotic,
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 100,
    config = { extra = { add = 2, mult = 1.5 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add, card.ability.extra.mult } }
    end,
	calculate = function(self, card, context)
		if context.forcetrigger then
			return {
				mult = 4^card.ability.extra.add,
                chips = 30^card.ability.extra.add,
                dollars = 1^card.ability.extra.add,
				xmult = 2^card.ability.extra.mult,
                xchips = 2^card.ability.extra.mult,
				emult = 1.5^(1+(1/9)),
                echips = 1.5^(1+(1/9)),
				eemult = 1.1111111111^(1+(1/16)),
                eechips = 1.1111111111^(1+(1/16)),
				eeemult = 1.0625^(1+(1/25)),
                eeechips = 1.0625^(1+(1/25)),
			}
		end
		if context.MDJ_mod_key_and_amount then
			local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
			local key = context.MDJ_key
			local amount = context.MDJ_amount
            -- should skip over the rest of the code
            if MyDreamJournal.dollarmodkeys[key] then
				amount = amount^card.ability.extra.add
			end
            local operation = MyDreamJournal.multmodkeys[key] or MyDreamJournal.chipmodkeys[key]
            local op_number = MyDreamJournal.keystonumbers[operation]
            if operation and op_number then
                -- handle generalized higher order hyperoperations
                local is_hyper = false
                if op_number == 4 then
                    op_number = amount[1]
                    is_hyper = true
                end
                if op_number ~= -1 and op_number ~= 0 then
                    op_number = 1+ (1 / ((op_number + 2) ^ 2))
                elseif op_number == -1 then
                    op_number = card.ability.extra.add
                elseif op_number == 0 then
                    op_number = card.ability.extra.mult
                end
                if is_dark then
                    op_number = op_number * 2
                end
                if not is_hyper then
                    amount = amount ^ op_number
                else
                    amount[2] = amount[2] ^ op_number
                end
            end
			return {
				MDJ_amount = amount,
				MDJ_key = key
			}
		end
	end
}
-- on obtainment, for every card that doesn't have a edition, give it a edition
-- for every playing card, give it a modifer it doesn't have
-- every future card will have a edition
-- every future playing card will have all modifers
SMODS.Joker {
    key = "tme",
    pos = {x = 0, y = 0 },
    soul_pos = { x = 1, y = 0, extra = { x = 2, y = 0 } },
    atlas = "eplaceholder",
	discovered = true,
    rarity = MyDreamJournal.exotic,
	pronouns = 'they_them',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 100,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    add_to_deck = function (self, card, from_debuff)
        local edition_pool = {}
        local enchantment_pool = {}
        local seal_pool = {}
        for _, ed in pairs(G.P_CENTER_POOLS["Enhanced"]) do
            if ed.key == "m_base" then
                goto wof_continue
            end
            enchantment_pool[#enchantment_pool + 1] = ed.key
            ::wof_continue::
        end
        for _, ed in pairs(G.P_CENTER_POOLS["Seal"]) do
            seal_pool[#seal_pool + 1] = ed.key
        end
        for _, ed in pairs(G.P_CENTER_POOLS["Edition"]) do
        if ed.key == "e_base" then
            goto wolf_continue
        end
        edition_pool[#edition_pool + 1] = ed.key
            ::wolf_continue::
        end
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]
            local edition = pseudorandom_element(edition_pool, pseudoseed(tostring({})))
            if not joker.edition then
                joker:set_edition(edition, true)
                check_for_unlock({type = 'have_edition'})
            end
        end
        for i = 1, #G.consumeables.cards do
            local consumable = G.consumeables.cards[i]
            local edition = pseudorandom_element(edition_pool, pseudoseed(tostring({})))
            if not consumable.edition then
                consumable:set_edition(edition, true)
                check_for_unlock({type = 'have_edition'})
            end
        end
        for i = 1, #G.playing_cards do
            local playing_card = G.playing_cards[i]
            local edition = pseudorandom_element(edition_pool, pseudoseed(tostring({})))
            local enchantment = pseudorandom_element(enchantment_pool, pseudoseed(tostring({})))
            local seal = pseudorandom_element(seal_pool, pseudoseed(tostring({})))
            if not playing_card.edition then
                playing_card:set_edition(edition, true)
            end
            ---@diagnostic disable-next-line: param-type-mismatch
            if not next(SMODS.get_enhancements(playing_card)) then
                playing_card:set_ability(enchantment, true)
            end
            if not playing_card.seal then
                playing_card:set_seal(seal, true)
            end
            check_for_unlock({type = 'have_edition'})
        end
    end,
	calculate = function(self, card, context)
        if context.before then
            local edition_pool = {}
            local enchantment_pool = {}
            local seal_pool = {}
            for _, ed in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                if ed.key == "m_base" then
                    goto wof_continue
                end
                enchantment_pool[#enchantment_pool + 1] = ed.key
                ::wof_continue::
            end
            for _, ed in pairs(G.P_CENTER_POOLS["Seal"]) do
                seal_pool[#seal_pool + 1] = ed.key
            end
            for _, ed in pairs(G.P_CENTER_POOLS["Edition"]) do
            if ed.key == "e_base" then
                goto wolf_continue
            end
            edition_pool[#edition_pool + 1] = ed.key
                ::wolf_continue::
            end
            for i = 1, #G.jokers.cards do
                local joker = G.jokers.cards[i]
                local edition = pseudorandom_element(edition_pool, pseudoseed(tostring({})))
                if not joker.edition then
                    joker:set_edition(edition, true)
                    check_for_unlock({type = 'have_edition'})
                end
            end
            for i = 1, #G.consumeables.cards do
                local consumable = G.consumeables.cards[i]
                local edition = pseudorandom_element(edition_pool, pseudoseed(tostring({})))
                if not consumable.edition then
                    consumable:set_edition(edition, true)
                    check_for_unlock({type = 'have_edition'})
                end
            end
            for i = 1, #G.playing_cards do
                local playing_card = G.playing_cards[i]
                local edition = pseudorandom_element(edition_pool, pseudoseed(tostring({})))
                local enchantment = pseudorandom_element(enchantment_pool, pseudoseed(tostring({})))
                local seal = pseudorandom_element(seal_pool, pseudoseed(tostring({})))
                if not playing_card.edition then
                    playing_card:set_edition(edition, true)
                end
                ---@diagnostic disable-next-line: param-type-mismatch
                if not next(SMODS.get_enhancements(playing_card)) then
                    playing_card:set_ability(enchantment, true)
                end
                if not playing_card.seal then
                    playing_card:set_seal(seal, true)
                end
                check_for_unlock({type = 'have_edition'})
            end
        end
	end
}
-- sets all digits in mult, chips, and score to 9
SMODS.Joker {
    key = "tln",
    pos = {x = 0, y = 0 },
    atlas = "nine",
	discovered = true,
    rarity = MyDreamJournal.exotic,
	pronouns = 'they_them',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    immutable = true,
    cost = 100,
    config = { extra = { set = 9 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.set } }
    end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
                set_mult = card.ability.extra.set,
                set_chips = card.ability.extra.set,
                set_score = card.ability.extra.set
			}
		end
	end
}
SMODS.Joker {
    key = "urotsuki",
    pos = {x = 0, y = 0 },
    soul_pos = { x = 1, y = 0, extra = { x = 2, y = 0 } },
    atlas = "eplaceholder",
	discovered = true,
    rarity = MyDreamJournal.exotic,
	pronouns = 'she_her',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
	demicolon_compat = true,
    cost = 100,
    config = { extra = { per = 0.1 }, },
    loc_vars = function(self, info_queue, card)
        if G.GAME and G.GAME.current_round and G.GAME.current_round.played_poker_hands then
            return { vars = { 1+#G.GAME.current_round.played_poker_hands*card.ability.extra.per } }
        else
            return { vars = { 1 } }
        end
    end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
                echips = 1+#G.GAME.current_round.played_poker_hands*card.ability.extra.per,
			}
		end
	end
}
SMODS.Joker {
    key = "radix",
    pos = {x = 3, y = 0 },
    soul_pos = { x = 5, y = 0, extra = { x = 4, y = 0 } },
    atlas = "exotic",
	discovered = true,
    rarity = MyDreamJournal.exotic,
	pronouns = 'it_its',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    demicolon_compat = true,
    cost = 100,
	-- so no one gets any funnny ideas!
	immutable = true,
    config = { previous_hand_limit = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function (self, card, context)
        if (context.joker_main or context.forcetrigger) and to_big(#context.full_hand)%3 == 0  then
            return {
                base_chips = 3,
                base_mult = 3,
            }
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        card.ability.previous_hand_limit = G.hand.config.highlighted_limit
        MyDreamJournal.handlimitchange((math.ceil(G.hand.config.highlighted_limit/3)*3)-G.hand.config.highlighted_limit)
    end,
    remove_from_deck = function (self, card, from_debuff)
        MyDreamJournal.handlimitchange(card.ability.previous_hand_limit-G.hand.config.highlighted_limit)
    end
}
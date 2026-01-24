SMODS.Joker {
    key = "eyesjoker",
    atlas = 'awesomejokers',
    pos = { x = 4, y = 0 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_him',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 2,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
SMODS.Joker {
    key = "suitshuffle",
    atlas = 'awesomejokers',
    pos = { x = (G.SETTINGS.colourblind_option and 1) or 0, y = 2 },
	discovered = true,
    rarity = 1,
	pronouns = 'they_them',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 2,
    config = { extra = {}, },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
}
SMODS.Joker {
    key = "latin",
    atlas = 'awesomejokers',
    pos = { x = 6, y = 1 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 2,
    config = { extra = { add = 0.01 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add } }
    end,
    calculate = function (self, card, context)
        if context.MDJ_mod_key_and_amount then
            local key = context.MDJ_key
            local amount = context.MDJ_amount
            local converted_key = MyDreamJournal.plustox[key]
            local is_corrupted = card and (card.edition and card.edition.key == "e_MDJ_corrupted")
            local is_dark = card and (card.edition and card.edition.key == "e_MDJ_dark")
            if not converted_key then
                ---@diagnostic disable-next-line: redefined-local
                local converted_key = MyDreamJournal.xtoe[key]
                if is_corrupted and MyDreamJournal.xchipstoechips[key] then
                    local cchips = SMODS.Scoring_Parameters.chips.current
                    local achips = cchips * amount
                    amount = math.log(achips, cchips) + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
                    key = converted_key
                elseif not is_corrupted and MyDreamJournal.xmulttoemult[key] then
                    local cmult = SMODS.Scoring_Parameters.mult.current
                    local amult = cmult * amount
                    amount = math.log(amult, cmult) + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
                    key = converted_key
                end
            else
                if is_corrupted and MyDreamJournal.pluschipstoxchips[key] then
                    local cchips = SMODS.Scoring_Parameters.chips.current
                    local achips = cchips + amount
                    amount = achips / cchips + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
                    key = converted_key
                elseif not is_corrupted and MyDreamJournal.plusmulttoxmult[key] then
                    local cmult = SMODS.Scoring_Parameters.mult.current
                    local amult = cmult + amount
                    amount = amult / cmult + ((not is_dark and card.ability.extra.add) or card.ability.extra.add * 2)
                    key = converted_key
                end
            end
            return {
                MDJ_key = key,
                MDJ_amount = amount
            }
        end
    end
}
if next(SMODS.find_mod("cardpronouns")) then
---@diagnostic disable-next-line: undefined-global
  CardPronouns.Pronoun {
    colour = HEX("00FF00"),
    text_colour = G.C.BLACK,
    pronoun_table = { "H3", "H1M" },
    in_pool = function()
      return false
    end,
    key = "he_him_leet"
  }
end
SMODS.Joker {
    key = "leet",
    atlas = 'awesomejokers',
    pos = { x = 8, y = 1 },
    soul_pos = { x = 7, y = 1 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_him_leet',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 7,
    config = { extra = { add = 1 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add } }
    end,
    calculate = function (self, card, context)
        if context.MDJ_mod_key_and_amount and MyDreamJournal.dollarmodkeys[context.MDJ_key] then
            return {
                MDJ_amount = context.MDJ_amount+((not (card and (card.edition and card.edition.key == "e_MDJ_dark")) and card.ability.extra.add) or card.ability.extra.add*2)
            }
        end
    end
}
SMODS.Joker {
    key = "mistake",
    atlas = 'awesomejokers',
    pos = { x = 7, y = 0 },
	discovered = true,
    rarity = 1,
	pronouns = 'it_its',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 3,
    immutable = true,
    config = { extra = { odds = 5 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds } }
    end,
    calculate = function (self, card, context)
        if context.mod_probability then
            return {
                numerator = 1,
                denominator = card.ability.extra.odds
            }
        end
    end
}
SMODS.Joker {
    key = "graph",
    pos = { x = 4, y = 3 },
    atlas = 'awesomejokers',
    pronouns = 'it_its',
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 6,
    discovered = true,
    config = { extra = { expo = 0.3 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.expo, colours = { G.C.DARK_EDITION } } }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                mult = G.GAME.blind.chips^card.ability.extra.expo
            }
        end
    end
}
SMODS.Joker {
    key = "smfw",
    pos = { x = 8, y = 3 },
    atlas = 'awesomejokers',
    pools = {Music = true},
    pronouns = 'it_its',
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = false,
    cost = 4,
    discovered = true,
    config = { extra = { }, },
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_no_suit(playing_card) then
                return true
            end
			if SMODS.has_no_rank(playing_card) then
				return true
			end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
}
SMODS.Joker {
    key = "buffer",
    pos = { x = 0, y = 0 },
    atlas = 'buffer',
    pronouns = 'it_its',
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
    cost = 1,
    discovered = true,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval then
            if G.GAME.chips > G.GAME.blind.chips then
                return {
                    eq_score = G.GAME.blind.chips
                }
            end
        end
    end
}
SMODS.Joker {
    key = "blackout",
    pos = { x = 7, y = 4 },
    atlas = 'awesomejokers',
	pronouns = 'he_him',
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = true,
	immutable = true,
    cost = 4,
    discovered = true,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
	add_to_deck = function (self, card, from_debuff)
		SMODS.change_discard_limit(1)
	end,
	remove_from_deck = function (self, card, from_debuff)
		SMODS.change_discard_limit(-1)
	end
}
local function gcd(a, b)
    while b ~= 0 do
        a, b = b, a % b
    end
    return math.abs(a)
end
local function simplify(n, d)
    local c = gcd(n, d)
    return n / c, d / c
end
local function simplify_decimals(n, d)
    if string.match(tostring(n), "^[%d%.]+$") == nil or string.match(tostring(d), "^[%d%.]+$") == nil then
        n = math.floor(n)
        d = math.floor(d)
        return simplify(n, d)
    end
    if n == math.floor(n) and d == math.floor(d) then
        return simplify(n, d)
    end
    local ndecimal = ""
    local ddecimal = ""
    if n ~= math.floor(n) then
        ndecimal = string.match(tostring(n), "%.(%d+)")
    end
    if d ~= math.floor(d) then
        ddecimal = string.match(tostring(d), "%.(%d+)")
    end
    if #ddecimal >= #ndecimal then
        n = math.floor(n * 10 ^ #ddecimal)
        d = math.floor(d * 10 ^ #ddecimal)
    else
        n = math.floor(n * 10 ^ #ndecimal)
        d = math.floor(d * 10 ^ #ndecimal)
    end
    return simplify(n, d)
end

SMODS.Joker {
    key = "cube",
    pos = { x = 1, y = 5 },
    atlas = 'awesomejokers',
    pronouns = 'he_him',
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	demicolon_compat = false,
    cost = 1,
    discovered = true,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function (self, card, context)
        if context.mod_probability then
            local numerator, denominator = simplify_decimals(context.numerator, context.denominator)
            return {
                numerator = numerator,
                denominator = denominator
            }
        end
    end
}
SMODS.Joker {
    key = "mcpayout",
    atlas = 'placeholder',
    pos = { x = 0, y = 0 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_they',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 3,
    config = { extra = { }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.current_round.last_payout or 0 } }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                mult = G.GAME.current_round.last_payout
            }
        end
    end
}
SMODS.Joker {
    key = "IOU",
    atlas = 'awesomejokers',
    pos = { x = 4, y = 6 },
    pixel_size = { w = 28, h = 16 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_they',
    blueprint_compat = false,
	perishable_compat = false,
    eternal_compat = false,
    cost = 3,
    config = { extra = { rarity = 1 }, },
    loc_vars = function(self, info_queue, card)
        local rarity = ""
        if type(card.ability.extra.rarity) == "number" then
            local rarities = {
                "Common",
                "Uncommon",
                "Rare",
                "Legendary"
            }
            rarity = rarities[card.ability.extra.rarity]
        else
            rarity = card.ability.extra.rarity
        end
        return { vars = { localize("k_"..rarity:lower()), localize("k_"..MyDreamJournal.exotic:lower()), colours = { G.C[rarity] or G.C.RARITY[rarity] or G.C.FILTER } } }
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss then
            if type(card.ability.extra.rarity) == "number" and card.ability.extra.rarity ~= 4 then
                card.ability.extra.rarity = card.ability.extra.rarity+1
                if card.ability.extra.rarity == 4 then
                    card.ability.extra.rarity = MyDreamJournal.epic
                end
            elseif card.ability.extra.rarity == MyDreamJournal.epic then
                card.ability.extra.rarity = 4
            end
        end
        if context.selling_self then
			G.E_MANAGER:add_event(Event({
				func = (function()
                    local rarities = {
                        "Common",
                        "Uncommon",
                        "Rare",
                        "Legendary"
                    }
					SMODS.add_card({ set = 'Joker', rarity = rarities[card.ability.extra.rarity] or card.ability.extra.rarity })
					return true
				end)
			}))
			return nil, true -- This is for Joker retrigger purposes
        end
    end
}
SMODS.Joker {
    key = "useless",
    atlas = 'awesomejokers',
    pos = { x = 5, y = 6 },
	discovered = true,
    rarity = 1,
	pronouns = 'he_him',
    blueprint_compat = true,
	perishable_compat = true,
    eternal_compat = true,
    cost = 1,
    config = { extra = { xchips = 0.25, xmult = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, card.ability.extra.xmult } }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                xchips = card.ability.extra.xchips,
                xmult = card.ability.extra.xmult,
            }
        end
        if context.end_of_round and context.main_eval then
            card.ability.extra.xchips, card.ability.extra.xmult = card.ability.extra.xmult, card.ability.extra.xchips
            return {
                message = localize("k_swapped_ex")
            }
        end
    end,
    set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge('Art Credit: Szymii_', G.C.BLACK, G.C.GREEN, 0.8 )
	end
}
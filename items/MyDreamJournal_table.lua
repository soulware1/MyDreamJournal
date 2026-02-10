MyDreamJournal = MyDreamJournal or {}
Talisman = Talisman or nil
local to_big = to_big or function(n)
	return n
end

function MyDreamJournal.mass_concat(strings)
    local built = ""

    for _,str in ipairs(strings) do
        built = built .. str
    end

    return built
end

function MyDreamJournal.localized_names(area)
    local names = {}
	if not area or not area.cards then
		return {}
	end
    for _,card in pairs(area.cards) do
        table.insert(names, localize({type="name_text",set=card.config.center.set,key=card.config.center.key}))
    end
    return names
end

function MyDreamJournal.vowelandconsonants(str)
    local vowels = 0
    local consonants = 0

    for i = 1, #str do
        local char = str:sub(i, i)
        if char ~= " " then
            char = char:lower()

            if char:match("%a") then
                if char:match("[aeiou]") then
                    vowels = vowels + 1
                else
                    consonants = consonants + 1
                end
            else
				-- special characters (lke numbers) count as both because :3
                vowels = vowels + 1
                consonants = consonants + 1
            end
        end
    end

    return vowels, consonants
end

function MyDreamJournal.is_grilled_chicken(card)
    local center = type(card) == "string"
        and G.P_CENTERS[card]
        or (card.config and card.config.center)

    if not center then
        return false
    end

    if center.pools and center.pools["Grilled Chicken"] then
        return true
    end

    return false
end

function MyDreamJournal.is_music(card)
    local center = type(card) == "string"
        and G.P_CENTERS[card]
        or (card.config and card.config.center)

    if not center then
        return false
    end

    -- If the center has the Music pool in its definition
    if center.pools and center.pools.Music then
        return true
    end

    return false
end

function MyDreamJournal.is_food(card)
    local food = {
        j_gros_michel=true,
		j_egg=true,
		j_ice_cream=true,
		j_cavendish=true,
		j_turtle_bean=true,
		j_diet_cola=true,
		j_popcorn=true,
		j_ramen=true,
		j_selzer=true,
    }
    if food[card.config.center.key] or ( food.pools and food.pools.Food ) then return true end
end

MyDreamJournal.rank_shorthands = {
		"_",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"10",
		"J",
		"Q",
		"K",
		"A"
}

MyDreamJournal.chipmultopswap = {
	['chips'] = 'mult',
	['h_chips'] = 'h_mult',
	['chip_mod'] = 'mult_mod',
	['mult'] = 'chips',
	['h_mult'] = 'h_chips',
	['mult_mod'] = 'chip_mod',
	['x_chips'] = 'x_mult',
	['xchips'] = 'xmult',
	['Xchip_mod'] = 'Xmult_mod',
	['x_mult'] = 'x_chips',
	['xmult'] = 'xchips',
	['Xmult'] = 'xchips',
	['x_mult_mod'] = 'Xchip_mod',
	['Xmult_mod'] = 'Xchip_mod',
	-- Talisman.
	['e_mult'] = 'e_chips',
	['emult'] = 'echips',
	['ee_mult'] = 'ee_chips',
	['eemult'] = 'eechips',
	['eee_mult'] = 'eee_chips',
	['eeemult'] = 'eeechips',
	['hypermult'] = 'hyperchips',
	['hyper_mult'] = 'hyper_chips',
	['e_chips'] = 'e_mult',
	['echips'] = 'emult',
	['ee_chips'] = 'ee_mult',
	['eechips'] = 'eemult',
	['eee_chips'] = 'eee_mult',
	['eeechips'] = 'eeemult',
	['hyperchips'] = 'hypermult',
	['hyper_chips'] = 'hyper_mult',
	['Emult_mod'] = 'Echip_mod',
	['EEmult_mod'] = 'EEchip_mod',
	['EEEmult_mod'] = 'EEEchip_mod',
	['hypermult_mod'] = 'hyperchip_mod',
	['Echip_mod'] = 'Emult_mod',
	['EEchip_mod'] = 'EEmult_mod',
	['EEEchip_mod'] = 'EEEmult_mod',
	['hyperchip_mod'] = 'hypermult_mod',
    -- Custom Ops
    ['digit_mult'] = 'digit_chips',
    ['digit_chips'] = 'digit_mult',
    ['base_mult'] = 'base_chips',
    ['base_chips'] = 'base_mult',
    ['base_sum_mult'] = 'base_sum_chips',
    ['base_sum_chips'] = 'base_sum_mult',
    ['sum_mult'] = 'sum_chips',
    ['sum_chips'] = 'sum_mult',
	['sin_chips'] = 'sin_mult',
	['cos_chips'] = 'cos_mult',
	['sin_mult'] = 'sin_chips',
	['cos_mult'] = 'cos_chips',
	['set_mult'] = 'set_chips',
	['set_chips'] = 'set_mult',
	['set_visible_mult'] = 'set_visible_chips',
	['set_visible_chips'] = 'set_visible_mult',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.chipmodkeys = {
	['chips'] = 'add', ['h_chips'] = 'add', ['chip_mod'] = 'add',
	['x_chips'] = 'mult', ['xchips'] = 'mult', ['Xchip_mod'] = 'mult',
	['e_chips'] = 'expo', ['echips'] = 'expo', ['Echip_mod'] = 'expo',
	['ee_chips'] = 'tetra', ['eechips'] = 'tetra', ['EEchip_mod'] = 'tetra',
	['eee_chips'] = 'penta', ['eeechips'] = 'penta', ['EEEchip_mod'] = 'penta',
	['hyperchips'] = 'hyper', ['hyper_chips'] = 'hyper', ['hyperchip_mod'] = 'hyper',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.multmodkeys = {
	['mult'] = 'add', ['h_mult'] = 'add', ['mult_mod'] = 'add',
	['x_mult'] = 'mult', ['xmult'] = 'mult', ['Xmult'] = 'mult', ['x_mult_mod'] = 'mult', ['Xmult_mod'] = 'mult',
	['e_mult'] = 'expo', ['emult'] = 'expo', ['Emult_mod'] = 'expo',
	['ee_mult'] = 'tetra', ['eemult'] = 'tetra', ['EEmult_mod'] = 'tetra',
	['eee_mult'] = 'penta', ['eeemult'] = 'penta', ['EEEmult_mod'] = 'penta',
	['hypermult'] = 'hyper', ['hyper_mult'] = 'hyper', ['hypermult_mod'] = 'hyper',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.downgrade = {
	['ee_mult'] = 'e_mult', ['eemult'] = 'emult', ['EEmult_mod'] = 'Emult_mod',
	['eee_mult'] = 'e_mult', ['eeemult'] = 'emult', ['EEEmult_mod'] = 'Emult_mod',
	['hypermult'] = 'e_mult', ['hyper_mult'] = 'emult', ['hypermult_mod'] = 'Emult_mod',
	['ee_chips'] = 'e_chips', ['eechips'] = 'echips', ['EEchip_mod'] = 'Echip_mod',
	['eee_chips'] = 'e_chips', ['eeechips'] = 'echips', ['EEEchip_mod'] = 'Echip_mod',
	['hyperchips'] = 'e_chips', ['hyper_chips'] = 'echips', ['hyperchip_mod'] = 'Echip_mod',
	['hyper_asc'] = 'exp_asc', ['hyper_asc_mod'] = 'exp_asc_mod',
	['hyperasc'] = 'exp_asc', ['hyperasc_mod'] = 'exp_asc_mod',
}

MyDreamJournal.normalized_random = function(mu, sigma, seed)
    local u1 = pseudorandom(seed)
    local u2 = pseudorandom(seed)
    local z0 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
    return z0 * sigma + mu
end

MyDreamJournal.scoreparammodkeys = {
	['mult'] = 'add', ['h_mult'] = 'add', ['mult_mod'] = 'add',
	['x_mult'] = 'mult', ['xmult'] = 'mult', ['Xmult'] = 'mult', ['x_mult_mod'] = 'mult', ['Xmult_mod'] = 'mult',
	['e_mult'] = 'expo', ['emult'] = 'expo', ['Emult_mod'] = 'expo',
	['ee_mult'] = 'tetra', ['eemult'] = 'tetra', ['EEmult_mod'] = 'tetra',
	['eee_mult'] = 'penta', ['eeemult'] = 'penta', ['EEEmult_mod'] = 'penta',
	['hypermult'] = 'hyper', ['hyper_mult'] = 'hyper', ['hypermult_mod'] = 'hyper',
	['chips'] = 'add', ['h_chips'] = 'add', ['chip_mod'] = 'add',
	['x_chips'] = 'mult', ['xchips'] = 'mult', ['Xchip_mod'] = 'mult',
	['e_chips'] = 'expo', ['echips'] = 'expo', ['Echip_mod'] = 'expo',
	['ee_chips'] = 'tetra', ['eechips'] = 'tetra', ['EEchip_mod'] = 'tetra',
	['eee_chips'] = 'penta', ['eeechips'] = 'penta', ['EEEchip_mod'] = 'penta',
	['hyperchips'] = 'hyper', ['hyper_chips'] = 'hyper', ['hyperchip_mod'] = 'hyper',
	['glop'] = 'add', ['xglop'] = 'mult', ['eglop'] = 'expo',
    ['sfark'] = 'add', ['xsfark'] = 'mult', ['esfark'] = 'expo',
	['score'] = 'add', ['xscore'] = 'mult',
	-- ascension power is treated as one operator higher
	['asc'] = "expo", ['asc_mod'] = 'expo', ['x_asc'] = 'expo',
	['plus_asc'] = 'mult', ['plusasc_mod'] = 'mult',
	['exp_asc'] = 'tetra', ['exp_asc_mod'] = 'tetra',
	['hyper_asc'] = 'hyper', ['hyper_asc_mod'] = 'hyper',
	['hyperasc'] = 'hyper', ['hyperasc_mod'] = 'hyper',
}

MyDreamJournal.realascmodkeys = {
	['asc'] = "mult", ['asc_mod'] = 'mult', ['x_asc'] = 'mult',
	['plus_asc'] = 'add', ['plusasc_mod'] = 'add',
	['exp_asc'] = 'expo', ['exp_asc_mod'] = 'expo',
	['hyper_asc'] = 'hyper', ['hyper_asc_mod'] = 'hyper',
	['hyperasc'] = 'hyper', ['hyperasc_mod'] = 'hyper',
}

MyDreamJournal.multparamkeys = {
	add = "mult", mult = "xmult", expo = "emult", tetra = "eemult", penta = "eeemult", hyper = "hypermult"
}

MyDreamJournal.entropyinstalled = (SMODS.Mods["entr"] and SMODS.Mods["entr"].can_load)

MyDreamJournal.specilscoreparammodkeys = {
	['fauxEmult_mod'] = 'expo', ['fauxEchip_mod'] = 'expo',
}

MyDreamJournal.otherscoremodkeys = {
	['digit_mult'] = 'add',
    ['digit_chips'] = 'add',
    ['base_mult'] = 'expo',
    ['base_chips'] = 'expo',
    ['base_sum_mult'] = 'expo',
    ['base_sum_chips'] = 'expo',
    ['sum_mult'] = 'add',
    ['sum_chips'] = 'add',
	['sin_chips'] = 'mult',
	['cos_chips'] = 'mult',
	['sin_mult'] = 'mult',
	['cos_mult'] = 'mult',
	['set_mult'] = 'hyper',
	['set_chips'] = 'hyper',
	['set_visible_mult'] = 'hyper',
	['set_visible_chips'] = 'hyper',
	['base_mod_plus_one_mult_then_chips'] = "hyper",
	['percent_chips'] = "mult",
	['percent_mult'] = "mult",
}

MyDreamJournal.dollarmodkeys = {
    ['h_dollars'] = true,
    ['dollars'] = true,
    ['p_dollars'] = true,
}

MyDreamJournal.plustox = {
	['mult'] = 'x_mult',
	['h_mult'] = 'xmult',
	['mult_mod'] = 'x_mult_mod',
	['chips'] = 'x_chips',
	['h_chips'] = 'xchips',
	['chip_mod'] = 'Xchip_mod',
    ['glop'] = "xglop"
}
MyDreamJournal.plusmulttoxmult = {
	['mult'] = 'x_mult',
	['h_mult'] = 'xmult',
	['mult_mod'] = 'x_mult_mod',
}
MyDreamJournal.pluschipstoxchips = {
	['chips'] = 'x_chips',
	['h_chips'] = 'xchips',
	['chip_mod'] = 'Xchip_mod',
}
MyDreamJournal.xtoe = {
	['x_mult'] = 'e_mult',
	['xmult'] = 'emult',
	['x_mult_mod'] = 'Emult_mod',
	['x_chips'] = 'e_chips',
	['xchips'] = 'echips',
	['Xchip_mod'] = 'Echip_mod',
    ['xglop'] = "eglop"
}
MyDreamJournal.xmulttoemult = {
	['x_mult'] = 'e_mult',
	['xmult'] = 'emult',
	['x_mult_mod'] = 'Emult_mod',
}
MyDreamJournal.xchipstoechips = {
	['x_chips'] = 'e_chips',
	['xchips'] = 'echips',
	['Xchip_mod'] = 'Echip_mod',
}
MyDreamJournal.plusops = MyDreamJournal.plustox
MyDreamJournal.xops = MyDreamJournal.xtoe
MyDreamJournal.eops = {
	['e_mult'] = 'expo', ['emult'] = 'expo', ['Emult_mod'] = 'expo',
	['e_chips'] = 'expo', ['echips'] = 'expo', ['Echip_mod'] = 'expo',
}
MyDreamJournal.eeops = {
	['ee_mult'] = 'tetra', ['eemult'] = 'tetra', ['EEmult_mod'] = 'tetra',
	['ee_chips'] = 'tetra', ['eechips'] = 'tetra', ['EEchip_mod'] = 'tetra',
}
MyDreamJournal.eeeops = {
	['eee_chips'] = 'penta', ['eeechips'] = 'penta', ['EEEchip_mod'] = 'penta',
	['eee_mult'] = 'penta', ['eeemult'] = 'penta', ['EEEmult_mod'] = 'penta',
}
MyDreamJournal.hyperops = {
	['hyperchips'] = 'hyper', ['hyper_chips'] = 'hyper', ['hyperchip_mod'] = 'hyper',
	['hypermult'] = 'hyper', ['hyper_mult'] = 'hyper', ['hypermult_mod'] = 'hyper',
}

MyDreamJournal.keystonumbers = {
	["add"] = -1, ["mult"] = 0, ["expo"] = 1, ["tetra"] = 2, ["penta"] = 3, ["hyper"] = 4
}

function MyDreamJournal.ApplySticker(card, key)
    if not card.ability then card.ability = {} end
    if card.ability then
        if not SMODS.Stickers[key] then return end
        card.ability[key] = true
        if SMODS.Stickers[key].apply then SMODS.Stickers[key].apply(SMODS.Stickers[key], card) end
    end
end

math.randomseed(os.time())
MyDreamJournal.secretnumberthatsgeneratedatstartupandneveragain = math.random(0, 2)

G.C.veryrare = HEX('01A0AA')
G.C.unlegendary = HEX('4D9344')
G.ARGS.LOC_COLOURS["MDJ_veryrare"] = G.C.veryrare
G.ARGS.LOC_COLOURS["MDJ_unlegendary"] = G.C.unlegendary
if (SMODS.Mods["vallkarri"] or {}).can_load then
    MyDreamJournal.epic = "valk_renowned"
	MyDreamJournal.exotic = "valk_exquisite"
elseif (SMODS.Mods["Cryptid"] or {}).can_load then
    MyDreamJournal.epic = "cry_epic"
	MyDreamJournal.exotic = "cry_exotic"
else
    MyDreamJournal.epic = "MDJ_veryrare"
	MyDreamJournal.exotic = "MDJ_unlegendary"
    SMODS.Rarity {
        key = 'veryrare',
		-- the terrible, horrible, no good, very bad fix
		loc_txt = {
			name = "Unrare"
		},
        badge_colour = G.C.veryrare,
        pools = { ["Joker"] = true },
        default_weight = 0.01,
		get_weight = function(self, weight, object_type)
			-- genius!
			return weight
		end,
        --approx 3x more common than a cryptid epic joker
    }
    SMODS.Rarity {
        key = 'unlegendary',
		-- the terrible, horrible, no good, very bad fix
		loc_txt = {
			name = "Unlegendary"
		},
        badge_colour = G.C.unlegendary,
        pools = { ["Joker"] = true },
        default_weight = 0,
		get_weight = function(self, weight, object_type)
			-- genius!
			return weight
		end,
        --approx 0x more common than a cryptid exotic joker :ujel:
    }
end

MyDreamJournal.vanilla_rarities = {
    "common",
    "uncommon",
    "rare",
    "legendary"
}
MyDreamJournal.ribstable = {
	["cry_cursed"] = -1,
	["unik_detrimental"] = 0,
    ["common"] = 1,
    ["uncommon"] = 2,
	["poke_safari"] = 2.5,
    ["rare"] = 3,
    ["nic_teto"] = 3,
	["gb_BossJokers"] = 3.5,
	["poke_mega"] = 4,
    ["legendary"] = 5,
    ["entr_reverse_legendary"] = 5,
	["finity_showdown"] = 5.25,
	["unik_ancient"] = 5.5,
    ["entr_entropic"] = 7
}
MyDreamJournal.grilled_chicken = MyDreamJournal.grilled_chicken or {}

local temp = {
	[1] = "j_MDJ_air_popped_grilled_chicken",
	[2] = "j_MDJ_grilled_chicken",
	[3] = "j_MDJ_drinkable_grilled_chicken",
	[4] = "j_MDJ_blue_grilled_chicken",
	[5] = "j_MDJ_grilled_grilled_chicken",
	[6] = "j_MDJ_chickened_grill",
}
for i = 1, 6 do
	MyDreamJournal.grilled_chicken[i] = MyDreamJournal.grilled_chicken[i] or {}
	MyDreamJournal.grilled_chicken[i][#MyDreamJournal.grilled_chicken[i]+1] = temp[i]
end
temp = nil

MyDreamJournal.ribstable[MyDreamJournal.epic:lower()] = 4
MyDreamJournal.ribstable[MyDreamJournal.exotic:lower()] = 6

-- stole from toga
MyDreamJournal.handlimitapi = function()
	return (SMODS.change_play_limit and SMODS.change_discard_limit and SMODS.update_hand_limit_text) or false
end
MyDreamJournal.handlimitchange = function(val, set_to)
	val = val or 0
	if MyDreamJournal.handlimitapi() then
		SMODS.change_play_limit(set_to and G.GAME.starting_params.play_limit - val or val)
		SMODS.change_discard_limit(set_to and G.GAME.starting_params.discard_limit - val or val)
	else
		G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + val, val < 0 and 1 or 5)
	end
end

-- stolen from entropy
function MyDreamJournal.card_eval_status_text_eq(card, eval_type, amt, percent, dir, extra, pref, col, sound, vol, ta)
    if card.area == G.butterfly_jokers and G.deck.cards[1] then 
        MyDreamJournal.card_eval_status_text_eq(G.deck.cards[1], eval_type, amt, percent, dir, extra, pref, col, sound, vol, true)
        return
    end
    percent = percent or (0.9 + 0.2*math.random())
    if dir == 'down' then 
        percent = 1-percent
    end

    if extra and extra.focus then card = extra.focus end

    local text = ''
    local volume = vol or 1
    local card_aligned = 'bm'
    local y_off = 0.15*G.CARD_H
    if card.area == G.jokers or card.area == G.consumeables then
        y_off = 0.05*card.T.h
    elseif card.area == G.hand or ta then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.area == G.play then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.jimbo then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    end
    local config = {}
    local delay = 0.65
    local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
    local extrafunc = nil
    sound = sound or 'multhit1'--'other1'
    amt = amt
    text = (pref) or ("Mult = "..amt)
    colour = col or G.C.MULT
    config.type = 'fade'
    config.scale = 0.7
    delay = delay*1.25
    if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
        if extra and extra.instant then
            if extrafunc then extrafunc() end
            attention_text({
                text = text,
                scale = config.scale or 1, 
                hold = delay - 0.2,
                backdrop_colour = colour,
                align = card_aligned,
                major = card,
                offset = {x = 0, y = y_off}
            })
            play_sound(sound, 0.8+percent*0.2, volume)
            if not extra or not extra.no_juice then
                card:juice_up(0.6, 0.1)
                G.ROOM.jiggle = G.ROOM.jiggle + 0.7
            end
        else
            G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
                    trigger = 'before',
                    delay = delay,
                    func = function()
                    if extrafunc then extrafunc() end
                    attention_text({
                        text = text,
                        scale = config.scale or 1, 
                        hold = delay - 0.2,
                        backdrop_colour = colour,
                        align = card_aligned,
                        major = card,
                        offset = {x = 0, y = y_off}
                    })
                    play_sound(sound, 0.8+percent*0.2, volume)
                    if not extra or not extra.no_juice then
                        card:juice_up(0.6, 0.1)
                        G.ROOM.jiggle = G.ROOM.jiggle + 0.7
                    end
                    return true
                    end
            }))
        end
    end
    if extra and extra.playing_cards_created then 
        playing_card_joker_effects(extra.playing_cards_created)
    end
end


SMODS.ObjectType({
	key = "Music",
	default = "j_MDJ_ribs",
	cards = {},
	rarities = {
		{
			key = 'Common',
			weight = 0.7,
			rate = 0.7,
		},
		{
			key = 'Uncommon',
			weight = 0.25,
			rate = 0.25,
		},
		{
			key = 'Rare',
			weight = 0.05,
			rate = 0.05,
		},
		{
			key = MyDreamJournal.epic,
			weight = 0.01,
			rate = 0.01,
		},
		{
			key = 'Legendary',
			weight = 0.003,
			rate = 0.003,
		},
		{
			key = MyDreamJournal.exotic,
			weight = 0.001,
			rate = 0.001,
		}
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

SMODS.ObjectType({
	key = "Grilled Chicken",
	default = "j_MDJ_air_popped_grilled_chicken",
	cards = {},
	rarities = {
		{
			key = 'Common',
			weight = 0.7,
			rate = 0.7,
		},
		{
			key = 'Uncommon',
			weight = 0.25,
			rate = 0.25,
		},
		{
			key = 'Rare',
			weight = 0.05,
			rate = 0.05,
		},
		{
			key = MyDreamJournal.epic,
			weight = 0.01,
			rate = 0.01,
		},
		{
			key = 'Legendary',
			weight = 0.003,
			rate = 0.003,
		},
		{
			key = MyDreamJournal.exotic,
			weight = 0.001,
			rate = 0.001,
		}
	},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
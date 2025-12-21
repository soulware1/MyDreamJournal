MyDreamJournal = MyDreamJournal or {}
Talisman = Talisman or nil
local to_big = to_big or function(n)
	return n
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

MyDreamJournal.keysToNumbers = {
	["add"] = -1, ["mult"] = 0, ["expo"] = 1, ["tetra"] = 2, ["penta"] = 3, ["hyper"] = 4
}
G.C.veryrare = HEX('FF0000')
if (SMODS.Mods["Cryptid"] or {}).can_load then
    MyDreamJournal.epic = "cry_epic"
elseif (SMODS.Mods["vallkarri"] or {}).can_load then
    MyDreamJournal.epic = "valk_renowned"
else
    MyDreamJournal.epic = "MDJ_veryrare"
    SMODS.Rarity {
        key = 'veryrare',
		loc_txt = {},
        badge_colour = G.C.veryrare,
        pools = { ["Joker"] = true },
        default_weight = 0.01,
		get_weight = function(self, weight, object_type)
			-- genius!
			return weight
		end,
        --approx 3x more common than a cryptid epic joker
    }
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
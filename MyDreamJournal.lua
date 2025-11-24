--- STEAMODDED HEADER
--- MOD_NAME: My Dream Journal
--- MOD_ID: MyDreamJournal
--- PREFIX: MDJ
--- MOD_AUTHOR: [soulware]
--- MOD_DESCRIPTION: Idk :P
--- BADGE_COLOUR: 00FF00
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0905a]

MyDreamJournal = MyDreamJournal or {}

SMODS.Atlas({
    key = "modicon",
    path = "modicon.png",
    px = 32,
    py = 32
 })
 SMODS.Atlas({
    key = "awesomejokers",
    path = "jonklers.png",
    px = 71,
    py = 95
 })

SMODS.Shader({ key = 'corrupted', path = 'corrupted.fs' })

SMODS.current_mod.optional_features = {
    post_trigger = true,
}


SMODS.Edition({
    key = "corrupted",
    loc_txt = {
        name = "Corrupted",
        label = "Corrupted",
        text = {
            "Chips effects now affects Mult instead",
			"Mult effects {X:mult,C:white} X#1# {} and now affects Chips instead",
        }
    },
	-- Stop shadow from being rendered under the card
    disable_shadow = true,
    -- Stop extra layer from being rendered below the card.
    -- For edition that modify shape or transparency of the card.
    shader = "corrupted",
    discovered = true,
    unlocked = true,
    config = { x_mult = 7.5 },
    in_shop = true,
    weight = 8,
    extra_cost = 6,
    apply_to_float = true,
    loc_vars = function(self)
        return { vars = { self.config.x_mult } }
    end,
})

SMODS.Joker {
    key = "unicode",
    atlas = 'awesomejokers',
    pos = { x = 0, y = 0 },
	pixel_size = { w = 62 },
	discovered = true,
    rarity = 2,
	loc_txt = {
        name = 'Unicode',
		text = {
		"{X:mult,C:white}+#1#{} to all {C:mult}+Mult{}",
		"{X:mult,C:white}+#2#{} to all {X:mult,C:white}XMult{}",
		"{X:mult,C:white}+(#2#/N){} to all {C:attention}higher-operation{} Mult",
		"{C:inactive,s:0.9}N being 10x the used operation{}"
		}
    },
	pronouns = 'it_its',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 8,
    config = { extra = { add = 4, mult = 0.4, expo = 0.04, tetra = 0.004, penta = 0.0004, hyper = 0.00004 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add, card.ability.extra.mult, card.ability.extra.tetra, card.ability.extra.penta, card.ability.extra.hyper } }
    end,
}
SMODS.Joker {
    key = "emoji",
    atlas = 'awesomejokers',
    pos = { x = 1, y = 0 },
	discovered = true,
    rarity = 3,
	loc_txt = {
        name = 'Emoji',
		text = {
		"{X:blue,C:white}+#1#{} to all {C:blue}+Chip{}",
		"{X:blue,C:white}+#2#{} to all {X:blue,C:white}XChip{}",
		"{X:blue,C:white}+(#2#/N){} to all {C:attention}higher-operation{} Chip",
		"{C:inactive,s:0.9}N being 10x the used operation{}"
		}
    },
	pronouns = 'he_him',
    blueprint_compat = false,
	perishable_compat = true,
    eternal_compat = true,
    cost = 8,
    config = { extra = { add = 30, mult = 0.3, expo = 0.03, tetra = 0.003, penta = 0.0003, hyper = 0.00003 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add, card.ability.extra.mult, card.ability.extra.tetra, card.ability.extra.penta, card.ability.extra.hyper } }
    end,
}

if SMODS.Mods["potassium_re"] and SMODS.Mods["potassium_re"].can_load then
	SMODS.Font {
		key = "fairfaxpona",
		path = "FairfaxPona.ttf",
		render_scale = 24 --[[number]],
		TEXT_HEIGHT_SCALE = 1 --[[number]],
		TEXT_OFFSET = { x = 0 --[[number]], y = 0 --[[number]] },
		FONTSCALE = 0.5 --[[number]],
		squish = 0 --[[number]],
		DESCSCALE = 1 --[[number]]
	}
	SMODS.Joker {
		key = "jannasa",
		atlas = 'awesomejokers',
		pos = { x = 2, y = 0 },
		discovered = true,
		rarity = 3,
		loc_txt = {
			name = '{f:MDJ_fairfaxpona}AB{}',
			text = {
			"{X:glop,C:white}+#1#{} to all {C:glop}+Glop{}",
			"{X:glop,C:white}+#2#{} to all {X:glop,C:white}XGlop{}",
			"{X:glop,C:white}+(#2#/N){} to all {C:attention}higher-operation{} Glop",
			"{C:inactive,s:0.9}N being 10x the used operation{}"
			}
		},
		pronouns = 'they_them',
		blueprint_compat = false,
		perishable_compat = true,
		eternal_compat = true,
		cost = 8,
		config = { extra = { add = 0.1, mult = 0.1, expo = 0.01, tetra = 0.001, penta = 0.0001, hyper = 0.00001 }, },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.add, card.ability.extra.mult, card.ability.extra.tetra, card.ability.extra.penta, card.ability.extra.hyper } }
		end,
	}
end

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

local calcindiveffectref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	local is_corrupted = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_corrupted")
	local unicodes = SMODS.find_card("j_MDJ_unicode")
	local emojis = SMODS.find_card("j_MDJ_emoji")
	local jans = SMODS.find_card("j_MDJ_jannasa")
	if is_corrupted then
		local msg
		if string.find(key, 'chip') then 
			msg = "Mult!"
		elseif string.find(key, 'mult') then 
			msg = "Chips!"
			-- rounds
			if MyDreamJournal.multmodkeys[key] == "add" then
				amount = math.floor((amount*7.5)+0.5)
			end
		end
		if msg and not (Talisman and Talisman.config_file.disable_anims) then
			card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = msg, colour = string.find(key, 'chip') and G.C.CHIPS or string.find(key, 'mult') and G.C.MULT, delay = 0.2})
		end
		key = MyDreamJournal.chipmultopswap[key]
	end
	if next(unicodes) then
		for i = 1, #unicodes do
			local v = unicodes[i]
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if not is_corrupted then
				local operation = MyDreamJournal.multmodkeys[key]
				if operation and v.ability.extra[operation] then
					amount = amount + v.ability.extra[operation]
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				if operation and v.ability.extra[operation] then
					amount = amount + v.ability.extra[operation]*7.5
				end
			end
		end
	end
	if next(emojis) then
		for i = 1, #emojis do
			local v = emojis[i]
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if is_corrupted then
				local operation = MyDreamJournal.multmodkeys[key]
				if operation and v.ability.extra[operation] then
					amount = amount + v.ability.extra[operation]
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				if operation and v.ability.extra[operation] then
					amount = amount + v.ability.extra[operation]
				end
			end
		end
	end
	if next(jans) then
		for i = 1, #jans do
			local v = jans[i]
			local operation = MyDreamJournal.glopmodkeys[key]
			if operation and v.ability.extra[operation] then
				amount = amount + v.ability.extra[operation]
			end
		end
	end
	local ret = calcindiveffectref(effect, scored_card, key, amount, from_edition)
	if ret then return ret end
end

----------------------------------------------
------------MOD CODE END----------------------

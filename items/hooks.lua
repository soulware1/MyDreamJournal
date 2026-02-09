---@diagnostic disable: duplicate-set-field, redefined-local
local to_big = to_big or function(n)
	return n
end
local to_number = to_number or function(x)
	return x
end
-- all keys
local all_key = {
	base_chips = true,
	base_mult = true,
	base_sum_mult = true,
	base_sum_chips = true,
	set_mult = true,
	set_chips = true,
	set_score = true,
	set_visible_mult = true,
	set_visible_chips = true,
	set_visible_score = true,
	base_mod_plus_one_mult_then_chips = true,
	digit_chips = true,
	digit_mult = true,
	sum_mult = true,
	sum_chips = true,
	sin_chips = true,
	cos_chips = true,
	sin_mult = true,
	cos_mult = true,
	percent_chips = true,
	percent_mult = true,
}
function SMODS.current_mod.calculate(self, context)
	-- setup
	if not G.GAME.current_round.MDJ_construction_jokers_ranks and not G.GAME.current_round.MDJ_construction_jokers_temp_ranks and not G.GAME.current_round.MDJ_construction_jokers_displayed_ranks and not G.GAME.current_round.MDJ_construction_jokers_first_hand then
		G.GAME.current_round.MDJ_construction_jokers_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_temp_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_displayed_ranks = "None"
		G.GAME.current_round.played_poker_hands = {}
		G.GAME.current_round.played_poker_hands_hash = {}
		G.GAME.current_round.previous_operations = {
			plus = {},
			x = {},
			e = {},
			ee = {},
			eee = {},
			hyperoperator_hell_is_a_real_place = {}
		}
		G.GAME.current_round.last_payout = to_big(0)
		G.GAME.MDJ_electron_beam = to_big(0)
	end
	local ranks = G.GAME.current_round.MDJ_construction_jokers_ranks
	local ranks2 = G.GAME.current_round.MDJ_construction_jokers_temp_ranks
	local rank_shorthands = MyDreamJournal.rank_shorthands
	if context.before and not next(ranks) and G.GAME.current_round.MDJ_construction_jokers_displayed_ranks == "None" and next(SMODS.find_card("j_MDJ_constructionjoker")) then
		for i = 1, #context.scoring_hand do
			local v = context.scoring_hand[i]
			local rank = v:get_id()
			local rankless_check = SMODS.has_no_rank(v)
			if rankless_check then
				rank = 1
			end
			if not ranks[rank] then
				ranks[rank] = 0
			end
			ranks[rank] = ranks[rank]+1
			table.insert(ranks2, rank_shorthands[rank])
		end
		G.GAME.current_round.MDJ_construction_jokers_displayed_ranks = table.concat(ranks2, ", ")
	end
	if context.final_scoring_step and context.scoring_name and not G.GAME.current_round.played_poker_hands_hash[context.scoring_name] then
		G.GAME.current_round.played_poker_hands_hash[context.scoring_name] = true
		G.GAME.current_round.played_poker_hands[#G.GAME.current_round.played_poker_hands+1] = context.scoring_name
	end
	if context.ante_change then
		G.GAME.current_round.MDJ_construction_jokers_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_temp_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_displayed_ranks = "None"
	end
	if context.after then
		G.GAME.current_round.previous_operations = {
			plus = {},
			x = {},
			e = {},
			ee = {},
			eee = {},
			hyperoperator_hell_is_a_real_place = {}
		}
	end
	if context.MDJ_mod_key_and_amount then
		local key = context.MDJ_key
		local og_key = context.MDJ_og_key
		local og_amount = context.MDJ_og_amount
		local amount = context.MDJ_amount
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
				op_number = G.GAME.MDJ_electron_beam/(10^(op_number+1))
			elseif op_number == -1 then
				op_number = G.GAME.MDJ_electron_beam
			elseif op_number == 0 then
				op_number = G.GAME.MDJ_electron_beam/10
			end
			if not is_hyper then
				amount = amount + op_number
			else
				amount[2] = amount[2] + op_number
			end
		end
		if context.card then
			local scored_card = context.card
			local is_corrupted = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_corrupted")
			local is_dark = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_dark")
			local is_amazing = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_amazing")
			if is_corrupted and all_key[og_key] and MyDreamJournal.chipmultopswap[og_key] and not context.from_mindware_lol then
				key = MyDreamJournal.chipmultopswap[og_key]
				amount = og_amount
			elseif is_corrupted and MyDreamJournal.chipmultopswap[key] and not context.from_mindware_lol then
				key = MyDreamJournal.chipmultopswap[key]
			end
			if is_dark and MyDreamJournal.scoreparammodkeys[key] then
				if MyDreamJournal.keystonumbers[MyDreamJournal.scoreparammodkeys[key]] == 4 then
					amount[2] = amount[2]*2
				else
					amount = amount*2
				end
			end
			if is_amazing and MyDreamJournal.scoreparammodkeys[key] then
				if MyDreamJournal.keystonumbers[MyDreamJournal.scoreparammodkeys[key]] == 4 then
					amount[2] = amount[2]^1.5
				else
					amount = amount^1.5
				end
			end
		end
		return {
			MDJ_amount = amount,
			MDJ_key = key
		}
	end
end

local mandoorhandhookcardoor = SMODS.change_play_limit
function SMODS.change_play_limit(mod)
	if ( G.GAME.selected_back.effect.center.key == "b_MDJ_sextuplezero" or G.GAME.selected_sleeve == "sleeve_MDJ_sextuplezero" ) then
		G.GAME.real_black_deck_added_hands = G.GAME.real_black_deck_added_hands or 0
		local realhands = G.GAME.round_resets.hands-G.GAME.real_black_deck_added_hands
		local gainedhands = mod*(realhands*0.2)
		G.GAME.round_resets.hands = ( realhands )+gainedhands
		G.GAME.real_black_deck_added_hands = G.GAME.real_black_deck_added_hands+gainedhands
		ease_hands_played(gainedhands)
	else
		mandoorhandhookcardoor(mod)
	end
end

local mandoordiscardhookcardoor = SMODS.change_discard_limit
function SMODS.change_discard_limit(mod)
	if ( G.GAME.selected_back.effect.center.key == "b_MDJ_sextuplezero" or G.GAME.selected_sleeve == "sleeve_MDJ_sextuplezero" ) then
		G.GAME.real_black_deck_added_discards = G.GAME.real_black_deck_added_discards or 0
		local realdiscards = G.GAME.round_resets.discards-G.GAME.real_black_deck_added_discards
		local gaineddiscards = mod*(realdiscards*0.2)
		G.GAME.round_resets.discards = ( realdiscards )+gaineddiscards
		G.GAME.real_black_deck_added_discards = G.GAME.real_black_deck_added_discards+gaineddiscards
		ease_discard(gaineddiscards)
	else
		mandoordiscardhookcardoor(mod)
	end
end

-- stolen from https://gist.github.com/tylerneylon/81333721109155b2d244
function Copy3(obj, seen)
    -- Handle non-tables and previously-seen tables.
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
  
    -- New table; mark it as seen and copy recursively.
    local s = seen or {}
    local res = {}
    s[obj] = res
    for k, v in pairs(obj) do res[Copy3(k, s)] = Copy3(v, s) end
    return setmetatable(res, getmetatable(obj))
end

local big_ass_number = to_big(10)^1000
local scientific_notation = to_big(10)^14
function Base10_to_base_less_then_10(n, b)
    if n == to_big(0) then return to_big(0) end
    b = math.floor(b)
    n = math.floor(n)
	b = to_big(b)
	n = to_big(n)
	if b > to_big(10) then
		return BaseB_to_base_10(n, b)
	-- silly goose
	elseif b == to_big(10) then
		return n
	end
    -- this is a VERY rough approximation of what would happen during a base conversion, only use for when /10 doesn't reduce the tailsman number or it just takes too long man...
    local approximation = math.log(b, to_big(10))
    if n >= big_ass_number and b ~= 1 then
        return n^approximation
    end
	n = math.floor(to_big(n))
    local result = to_big(0)
    local place = to_big(1)
    
    if b == to_big(1) then
		-- 1 ninth of 10^n = a number with N amount of digits, all of them being one
        result = 1/9*((to_big(10)^n)-1)
        goto base1_skip
    end

    while n > to_big(0) do
        local remainder = n % to_big(b)
        result = result + remainder * place
        n = math.floor(n / to_big(b))
        place = place * to_big(10)
    end
    ::base1_skip::
    
    return to_big(result)
end
function BaseB_to_base_10(n, b)
	if n >= big_ass_number then
		return (n/10^math.floor(math.log(n, to_big(10))))*b^math.floor(math.log(n, to_big(10)))
	end
	local result = to_big(0)
    local place = to_big(0)
	while n > 0 do
        local digit = n % to_big(10)
        result = result + digit * b^place
        n = math.floor(n/10)
        place = place+1
    end
	return result
end
function SumOfDigits(n)
	local old_n = n
    if to_big(math.floor(math.log(n, 10)) + 1) >= to_big(1001) then
		-- assume uniform random digits
        return to_big(4.5)*n
    end
	-- count in decimals if only digits and periods
	if string.match(tostring(n), "^[%d%.]+$") ~= nil then
		n = string.gsub(tostring(n), "%.", "")
		n = math.floor(to_big(to_number(n)))
	end
    local sum = to_big(0)
    while n ~= to_big(0) do
        local last = n % 10
        sum = sum + last
        n = math.floor(n / 10)
    end
    return sum
end

function SetDigits(n, x)
	x = to_big(x)
	n = to_big(n)
	if x < to_big(0) then
		warn("Number Negative!")
		x = math.abs(x)
	end
	if x > to_big(9) then
		error("Unsupported Number: Above 9")
	elseif x ~= math.floor(x) then
		error("Unsupported Number: Not Integer")
	end
	if n == to_big(0) then
		return x
	elseif x == to_big(0) then
		return x
	end
	if n ~= math.floor(n) and n < scientific_notation then
		if Talisman then
			return to_big(string.gsub(tostring(n), "%d", "9"))
		else
			return tonumber(string.gsub(tostring(n), "%d", "9"))
		end
	else
		n = math.floor(n)
	end
	local digits = to_big(math.floor(to_big(math.log(to_big(n), to_big(10))+1)))
	if x == 9 then
		return (to_big(10)^digits)-1
	else
		return x/9*((to_big(10)^digits)-1)
	end
end
function SetVisibleDigits(n, x)
	n = to_big(n)
	x = to_big(x)
	if string.match(tostring(n), "^[%d%.]+$") ~= nil then
		return SetDigits(n, x)
	end
	if x < 0 then
		warn("Number Negative!")
		x = math.abs(x)
	end
	if x > to_big(9) then
		error("Unsupported Number: Above 9")
	elseif x ~= math.floor(x) then
		error("Unsupported Number: Not Integer")
	end
	n = tostring(n)
	n = string.gsub(n, "%d", "9")
	if Talisman then
		return to_big(n)
	else
		return tonumber(n)
	end
end



if not (SMODS.Mods["entr"] and SMODS.Mods["entr"].can_load) then
	for _, v in ipairs({'eq_mult', 'Eqmult_mod', 'eq_chips', 'Eqchips_mod'}) do
		table.insert(SMODS.scoring_parameter_keys or SMODS.calculation_keys or {}, v)
	end
end
if not (SMODS.Mods["Astronomica"] and SMODS.Mods["Astronomica"].can_load) then
	SMODS.Sound({ key = 'eqscore', path = 'EqualsScore.ogg' })
	for _, v in ipairs({'eq_score'}) do
		table.insert(SMODS.scoring_parameter_keys or SMODS.calculation_keys or {}, v)
	end
end
-- keys that are "converted" to another key, for example digit_chips converting to chips
local converted_keys = {
	'digit_chips',
	'digit_mult',
	'sum_mult',
	'sum_chips',
	'sin_chips',
	'cos_chips',
	'sin_mult',
	'cos_mult',
	'percent_chips',
	'percent_mult',
	'secretEchips_mod',
	'fauxEmult_mod',
	'fauxEchip_mod'
}
-- keys that makes a scoring param equal to something, usually based off of the scoring param itself
local equals_key = {
	'base_chips',
	'base_mult',
	'base_sum_mult',
	'base_sum_chips',
	'set_mult',
	'set_chips',
	'set_score',
	'set_visible_mult',
	'set_visible_chips',
	'set_visible_score',
	'base_mod_plus_one_mult_then_chips'
}
-- slop
local slop_key = {
	'MDJ_amount',
	'MDJ_key',
	'MDJ_og_key',
	'MDJ_og_amount',
	'from_mindware_lol'
}
for _, v in ipairs(converted_keys) do
	table.insert(SMODS.scoring_parameter_keys or SMODS.calculation_keys or {}, v)
end
for _, v in ipairs(equals_key) do
	table.insert(SMODS.scoring_parameter_keys or SMODS.calculation_keys or {}, v)
end
for _, v in ipairs(slop_key) do
	table.insert(SMODS.other_calculation_keys or SMODS.calculation_keys or {}, v)
	if SMODS.silent_calculation then
		SMODS.silent_calculation[v] = true
	end
end

local suitless = SMODS.has_no_suit
SMODS.has_no_suit = function(card)
	if next(SMODS.find_card("j_MDJ_etykiw")) or next(SMODS.find_card("j_MDJ_smfw")) then
		return false
	end
	return suitless(card)
end
local suitful = SMODS.has_any_suit
SMODS.has_any_suit = function(card)
	if next(SMODS.find_card("j_MDJ_etykiw")) and suitless(card) then
		return true
	end
	return suitful(card)
end
local oldcardissuit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	local anarchy = next(SMODS.find_card("j_MDJ_anarchy"))
	local suit_shuffle = next(SMODS.find_card("j_MDJ_suitshuffle"))
	local everything_you_know_is_wrong = next(SMODS.find_card("j_MDJ_etykiw"))
	local love = next(SMODS.find_card("j_MDJ_love"))
	local anarchy_suit = 'Hearts'
	if suit_shuffle then
		anarchy_suit = 'Spades'
	end
	local g = oldcardissuit(self, suit, bypass_debuff, flush_calc)
	if everything_you_know_is_wrong and suitless(self) then
		return true
	end
	if (love and anarchy) and not SMODS.has_no_suit(self) then
		if suit ~= anarchy_suit then return true else return false end
	end
	if love and not SMODS.has_no_suit(self) then
		if suit == anarchy_suit then return true end
	end
	if anarchy and not SMODS.has_no_suit(self) then
		if self.base.suit == anarchy_suit then return self.base.suit ~= suit end
	end
	if suit_shuffle and not SMODS.has_no_suit(self) then
		local clubs = "Clubs"
		local spades = "Spades"
		local hearts = "Hearts"
		local diamonds = "Diamonds"
		if self.base.suit == clubs then return diamonds == suit end
		if self.base.suit == diamonds then return clubs == suit end
		if self.base.suit == hearts then return spades == suit end
		if self.base.suit == spades then return hearts == suit end
	end
	return g
end
local rankless = SMODS.has_no_rank
function SMODS.has_no_rank(card)
	if next(SMODS.find_card("j_MDJ_smfw")) then
		return false
	end
	return rankless(card)
end
local oldrank = Card.get_id
function Card:get_id()
	if next(SMODS.find_card("j_MDJ_etykiw")) and SMODS.has_no_rank(self) then
		return -21
	end
	if next(SMODS.find_card("j_MDJ_smfw")) and rankless(self) then
		return self.base.id or -21
	end
	return oldrank(self)
end
local sslopcalc = SMODS.update_context_flags
SMODS.update_context_flags = function(context, flags)
	if flags.MDJ_key then context.MDJ_key = flags.MDJ_key end
	if flags.MDJ_amount then context.MDJ_amount = flags.MDJ_amount end
	if flags.MDJ_og_key then context.MDJ_og_key = flags.MDJ_og_key end
	return sslopcalc(context, flags)
end
local vanilla_jank_fixer = Card.calculate_joker
function Card.calculate_joker(self, context)
	local ret = vanilla_jank_fixer(self, context)
	if not (self.config.center.mod or self.config.original_mod) and ret and ( self.edition and self.edition.key or "" ) ~= "e_MDJ_blackscale" then
		if ret.Xmult_mod then
			ret.x_mult = ret.Xmult_mod
			ret.Xmult_mod = nil
			ret.message = nil
		end
		if ret.mult_mod then
			ret.mult = ret.mult_mod
			ret.mult_mod = nil
			ret.message = nil
		end
		if ret.chip_mod then
			ret.chips = ret.chip_mod
			ret.chip_mod = nil
			ret.message = nil
		end
	end
	return ret
end

local create_card_hook = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, ...)
    local card = create_card_hook(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append, ...)
    if not card then
        return
    end
	local grilled_chicken = false
	for i, v in pairs(G.jokers.cards) do
		if MyDreamJournal.is_grilled_chicken(v) then
			grilled_chicken = true
		end
	end
	if grilled_chicken and MyDreamJournal.is_food(card) then
		-- instead of soda, drink GRILLED chicken
		if card.config.center.key == "j_diet_cola" then
			card:set_ability("j_MDJ_drinkable_grilled_chicken")
		elseif card.config.center.rarity == "entr_reverse_legendary" then
			card:set_ability("j_MDJ_grilled_orange_chicken")
		else
			card:set_ability(MyDreamJournal.grilled_chicken[MyDreamJournal.ribstable[MyDreamJournal.vanilla_rarities[card.config.center.rarity] or card.config.center.rarity]] or "j_MDJ_air_popped_grilled_chicken")
		end
	end
	if next(SMODS.find_card("j_MDJ_tme")) then
		if card.config.center.set == "Playing Card" then
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
			local edition = pseudorandom_element(edition_pool, pseudoseed(tostring({})))
            local enchantment = pseudorandom_element(enchantment_pool, pseudoseed(tostring({})))
            local seal = pseudorandom_element(seal_pool, pseudoseed(tostring({})))
            if not card.edition then
                card:set_edition(edition, true)
            end
            ---@diagnostic disable-next-line: param-type-mismatch
            if not next(SMODS.get_enhancements(card)) then
                card:set_ability(enchantment, true)
            end
            if not card.seal then
                card:set_seal(seal, true)
            end
            check_for_unlock({type = 'have_edition'})
		else
			local edition_pool = {}
			for _, ed in pairs(G.P_CENTER_POOLS["Edition"]) do
			if ed.key == "e_base" then
				goto wolf_continue
			end
			edition_pool[#edition_pool + 1] = ed.key
				::wolf_continue::
			end
			local edition = pseudorandom_element(edition_pool, pseudoseed(tostring({})))
			if not card.edition then
                card:set_edition(edition, true)
            end
		end
	end
	return card
end

local debuff_hook = Card.set_debuff
local other_debuff_hook = SMODS.debuff_card
function Card:set_debuff(debuff)
	local card = self
	if card.config.center.key == "j_MDJ_new_normal" then
		SMODS.calculate_context({
			idk_a_easier_way_to_do_this_so = true,
			debuffslop = debuff,
			targeted_card = card
		})
		return
	end
	if next(SMODS.find_card("j_MDJ_new_normal", true)) then
		if card and not card.ability then
			card.ability = {}
		end
		if card.ability.extra_slots_used and not card.ability.new_normal_affected then
			card.ability.former_extra_slots_used = card.ability.extra_slots_used
			card.ability.new_normal_affected = true
		else
			card.ability.former_extra_slots_used = 0
		end
		if debuff and card and card.ability and not ( card.ability.former_extra_slots_used and card.ability.former_extra_slots_used < 0 ) then
			card.ability.extra_slots_used = -1
		elseif not debuff and card and card.ability then
			card.ability.extra_slots_used = card.ability.former_extra_slots_used
			card.ability.new_normal_affected = false
		end
	end
	return debuff_hook(card, debuff)
end

function SMODS.debuff_card(card, debuff, source)
	if card.config.center.key == "j_MDJ_new_normal" then
		SMODS.calculate_context({
			idk_a_easier_way_to_do_this_so = true,
			debuffslop = debuff,
			targeted_card = card
		})
		return
	end
	if next(SMODS.find_card("j_MDJ_new_normal", true)) then
		if card and not card.ability then
			card.ability = {}
		end
		if card.ability.extra_slots_used and not card.ability.new_normal_affected then
			card.ability.former_extra_slots_used = card.ability.extra_slots_used
			card.ability.new_normal_affected = true
		else
			card.ability.former_extra_slots_used = 0
		end
		if debuff and card and card.ability and not ( card.ability.former_extra_slots_used and card.ability.former_extra_slots_used < 0 ) then
			card.ability.extra_slots_used = -1
		elseif not debuff and card and card.ability then
			card.ability.extra_slots_used = card.ability.former_extra_slots_used
			card.ability.new_normal_affected = false
		end
	end
	return other_debuff_hook(card, debuff, source)
end


local calcindiveffectref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	local og_key = key
	local og_amount = amount
	local theres_a_mindware = next(SMODS.find_card("j_MDJ_mindware"))
	local theres_a_brainware = next(SMODS.find_card("j_MDJ_brainware"))
	local theres_a_call = next(SMODS.find_card("j_MDJ_callandresponse"))
	local is_demicolon = nil
	-- a scored_card could SOMEHOW not have a center, therefor crashing the game without these checks >:(
	if scored_card and scored_card.config and scored_card.config.center then
		is_demicolon = (scored_card.config.center.key == "j_cry_demicolon")
	end
	if key == 'set_mult' then
		local mult = SMODS.Scoring_Parameters["mult"]
		amount = SetDigits(mult.current, amount)-mult.current
		key = "mult_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "Mult = "..mult.current, G.C.RED)
		end
	end
	if key == 'set_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		amount = SetDigits(chips.current, amount)-chips.current
		key = "chip_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = "..chips.current, G.C.BLUE)
		end
	end
	if key == 'set_score' then
		local score = SetDigits(G.GAME.chips, amount)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.chips = score
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)

				return true
			end
		}))
		if not Talisman or not Talisman.config_file.disable_anims then
			card_eval_status_text(scored_card, "extra", nil, nil, nil, { message = "Score = " .. number_format(score), colour = G.C.PURPLE })
		end
		return true
	end
	if key == 'set_visible_mult' then
		local mult = SMODS.Scoring_Parameters["mult"]
		amount = SetVisibleDigits(mult.current, amount)-mult.current
		key = "mult_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "Mult = "..mult.current, G.C.RED)
		end
	end
	if key == 'set_visible_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		amount = SetVisibleDigits(chips.current, amount)-chips.current
		key = "chip_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = "..chips.current, G.C.BLUE)
		end
	end
	if key == 'set_visible_score' then
		local score = SetVisibleDigits(G.GAME.chips, amount)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.chips = score
				G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)

				return true
			end
		}))
		if not Talisman.config_file.disable_anims then
			card_eval_status_text(scored_card, "extra", nil, nil, nil, { message = "Score = " .. number_format(score), colour = G.C.PURPLE })
		end
		return true
	end
	-- stuff that depends on current state of mult/chips
	if key == "digit_mult" then
		key = "mult"
		-- allows decimals to be counted in
		if SMODS.Scoring_Parameters.mult.current < scientific_notation then
			amount = #string.gsub(tostring(SMODS.Scoring_Parameters.mult.current), "%.", "")*to_big(amount)
		else
			amount = to_big(math.floor(to_big(math.log(to_big(SMODS.Scoring_Parameters.mult.current), to_big(10))+1)))*to_big(amount)
		end
	end
	if key == "digit_chips" then
		key = "chips"
		if SMODS.Scoring_Parameters.chips.current < scientific_notation then
			amount = #string.gsub(tostring(SMODS.Scoring_Parameters.chips.current), "%.", "")*to_big(amount)
		else
			amount = to_big(math.floor(to_big(math.log(to_big(SMODS.Scoring_Parameters.chips.current), to_big(10))+1)))*to_big(amount)
		end
	end
	if key == "sum_mult" then
		key = "mult"
		amount = SumOfDigits(SMODS.Scoring_Parameters.mult.current)
	end
	if key == "sum_chips" then
		key = "chips"
		amount = SumOfDigits(SMODS.Scoring_Parameters.chips.current)
	end
	if key == "sin_chips" then
		key = "xchips"
		amount = to_big(math.sin(to_number(SMODS.Scoring_Parameters.chips.current % (2*math.pi)))+amount)
	end
	if key == "cos_chips" then
		key = "xchips"
		amount = to_big(math.cos(to_number(SMODS.Scoring_Parameters.chips.current%(2*math.pi)))+amount)
	end
	if key == "sin_mult" then
		key = "xmult"
		amount = to_big(math.sin(to_number(SMODS.Scoring_Parameters.mult.current % (2*math.pi)))+amount)
	end
	if key == "cos_mult" then
		key = "xmult"
		amount = to_big(math.cos(to_number(SMODS.Scoring_Parameters.mult.current % (2*math.pi)))+amount)
	end
	if key == 'percent_mult' then
		local mult = SMODS.Scoring_Parameters["mult"]
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "+"..amount.."% Mult", G.C.RED)
		end
		amount = (mult.current+mult.current*(amount/100))/mult.current
		key = "Xmult_mod"
	end
	if key == 'percent_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "+"..amount.."%", G.C.BLUE)
		end
		amount = (chips.current+chips.current*(amount/100))/chips.current
		key = "Xchip_mod"
	end
	if not (SMODS.Mods["Astronomica"] and SMODS.Mods["Astronomica"].can_load) then
		if (key == 'eq_score') then
			if not Talisman or not Talisman.config_file.disable_anims then
					card_eval_status_text(scored_card, "extra", nil, nil, nil,
			{ message = "=" .. number_format(amount), colour = G.C.PURPLE, sound = "MDJ_eqscore" })
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.chips = to_big(amount)
					G.HUD:get_UIE_by_ID('chip_UI_count'):juice_up(0.3, 0.3)

					return true
				end
			}))
			return true
		end
	end
	if theres_a_mindware and not effect.from_mindware and key then
		local new_effect = Copy3(effect)
		effect["from_mindware"] = true
		new_effect[key] = nil
		local is_chips = MyDreamJournal.chipmodkeys[key]
		local is_mult = MyDreamJournal.multmodkeys[key]
		local swapped = MyDreamJournal.chipmultopswap[og_key]
		if not is_chips and not is_mult and not swapped then
			goto skip
		end
		SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
		local is_additive = ((is_chips == "add")) or ((is_mult == "add"))
		local new_amount = amount
		if is_additive and is_chips then
			new_amount = new_amount/7.5
		elseif is_additive and is_mult then
			new_amount = new_amount*7.5
		end
		if MyDreamJournal.otherscoremodkeys[og_key] then
			if MyDreamJournal.otherscoremodkeys[og_key] == "add" and MyDreamJournal.chipmodkeys[og_key] then
				new_amount = og_amount/7.5
			elseif MyDreamJournal.otherscoremodkeys[og_key] == "add" and MyDreamJournal.multmodkeys[og_key] then
				new_amount = og_amount*7.5
			else
				new_amount = og_amount
			end
		end
		new_effect[swapped] = new_amount
		effect = new_effect
		amount = new_amount
		key = swapped
		::skip::
	end
	if theres_a_call and not effect.response and key and MyDreamJournal.scoreparammodkeys[key] then
		effect.response = true
		SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
	end
	if key and amount and key ~= 'MDJ_key' and key ~= 'MDJ_amount' and not effect.no_alter then
		local alter = SMODS.calculate_context({MDJ_mod_key_and_amount = true, MDJ_amount = amount, MDJ_key = key, MDJ_og_key = og_key, MDJ_og_amount = og_amount, card = scored_card, from_mindware_lol = effect.from_mindware, demicolon_racism = is_demicolon})
		key = (alter and alter.MDJ_key) or key
		amount = (alter and alter.MDJ_amount) or amount
		-- recalcuate it
		if all_key[key] and key ~= og_key then
			effect.no_alter = true
			SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
		end
	end
	-- add in the equals if no entropy :sob:
	if not (SMODS.Mods["entr"] and SMODS.Mods["entr"].can_load) then
		if (key == 'eq_mult' or key == 'Eqmult_mod') then
			local mult = SMODS.Scoring_Parameters["mult"]
			key = "mult_mod"
			amount = amount-mult.current
			if not Talisman or not Talisman.config_file.disable_anims then
				MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "Mult = "..amount, G.C.RED)
			end
		end
		if (key == 'eq_chips' or key == 'Eqchips_mod') then
			local chips = SMODS.Scoring_Parameters["chips"]
			key = "chip_mod"
			amount = amount-mult.current
			if not Talisman or not Talisman.config_file.disable_anims then
				MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = "..amount, G.C.BLUE)
			end
		end
	end
	if key == 'base_mult' then
		local mult = SMODS.Scoring_Parameters["mult"]
		local formeramount = amount
		amount = Base10_to_base_less_then_10(mult.current, amount)-mult.current
		key = "fauxEmult_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "Mult = Base "..formeramount, G.C.RED)
		end
	end
	if key == 'base_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		local formeramount = amount
		amount = Base10_to_base_less_then_10(chips.current, amount)-chips.current
		key = "fauxEchip_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = Base "..formeramount, G.C.BLUE)
		end
	end
	if key == "base_sum_mult" then
		local mult = SMODS.Scoring_Parameters["mult"]
		amount = SumOfDigits(mult.current)
		local formeramount = amount
		key = "fauxEmult_mod"
		amount = Base10_to_base_less_then_10(mult.current, amount)-mult.current
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "Mult = Base "..formeramount, G.C.RED)
		end
	end
	if key == 'base_sum_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		amount = SumOfDigits(chips.current)
		local formeramount = amount
		amount = Base10_to_base_less_then_10(chips.current, amount)-chips.current
		key = "fauxEchip_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = Base "..formeramount, G.C.BLUE)
		end
	end
	if theres_a_brainware and ( MyDreamJournal.scoreparammodkeys[og_key] or MyDreamJournal.otherscoremodkeys[og_key] ) and not effect.frombrainware then
		local operations = G.GAME.current_round.previous_operations
		local operation_table = {
			scored_card.unique_val,
			key,
			amount,
			from_edition
		}
		local ordered_operations = {
			[1] = "plus",
			[2] = "x",
			[3] = "e",
			[4] = "ee",
			[5] = "eee",
			[6] = "hyperoperator_hell_is_a_real_place"
		}
		for k = 1, #ordered_operations do
			local b = ordered_operations[k]
			for i = 1, #operations[b] do
				local v = operations[b][i]
				local awesome_card = v[1]
				local effect = { frombrainware = true }
				effect[v[2]] = v[3]
				-- find scored_card
				for i = 1, #G.I.CARD do
					if G.I.CARD[i].unique_val == awesome_card then
						awesome_card = G.I.CARD[i]
					end
				end
				SMODS.calculate_effect(effect, awesome_card, from_edition)
			end
		end
		local heaven_or_hell = MyDreamJournal.scoreparammodkeys[og_key] or MyDreamJournal.otherscoremodkeys[og_key]
		if heaven_or_hell == "add" then
			operations["plus"][#operations["plus"]+1] = operation_table
		elseif heaven_or_hell == "mult" then
			operations["x"][#operations["x"]+1] = operation_table
		elseif heaven_or_hell == "expo" then
			operations["e"][#operations["e"]+1] = operation_table
		elseif heaven_or_hell == "tetra" then
			operations["ee"][#operations["ee"]+1] = operation_table
		elseif heaven_or_hell == "penta" then
			operations["eee"][#operations["eee"]+1] = operation_table
		elseif heaven_or_hell == "hyper" then
			operations["hyperoperator_hell_is_a_real_place"][#operations["hyperoperator_hell_is_a_real_place"]+1] = operation_table
		end
	end
	if key == 'base_mod_plus_one_mult_then_chips' then
		local mult = SMODS.Scoring_Parameters["mult"]
		local chips = SMODS.Scoring_Parameters["chips"]
		local modmult = ((mult.current-1)%(amount-1))+1
		local modchips = ((chips.current-1)%(amount-1))+1
		amount = Base10_to_base_less_then_10(mult.current, modchips)-mult.current
		local otheramount = Base10_to_base_less_then_10(chips.current, modmult)-chips.current
		local othereffect = { fauxEchip_mod = otheramount }
		SMODS.calculate_effect(othereffect, scored_card, from_edition)
		key = "fauxEmult_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "ZZ-ZZ`ZZvZZdZZoZZsZZ_ZZQZZAZZMZZjZZtZZgZZfZZHZZ$ZZ1ZZxZZ/ZZnZZ0ZZ:ZZZZZmZZ?ZZ?ZZFZZzZZ:ZZwZZ,ZZ'ZZLZZrZZ&ZZ3ZZZZZMZZoZZkZZ?ZZ&ZZuZZ'ZZmZZ8ZZlZZ-ZZ_ZZOZZ6ZZ>ZZvZZ[ZZ?ZZ3ZZ$ZZOZZ8ZZtZZuZZMZZcZZ&ZZ:ZZ:ZZLZZ;ZZEZZ`ZZBZZ(ZZ(ZZ^ZZ`ZZ ZZTZZ/ZZ8ZZxZZ,ZZ4ZZaZZTZZTZZ#ZZ/ZZmZZ$ZZSZZUZZ`ZZVZZAZZvZZ5ZZ,ZZ3ZZDZZ?ZZ", G.C.BLACK)
		end
	end
	if key == 'fauxEchip_mod' then
		key = "chip_mod"
	end
	if key == "fauxEmult_mod" then
		key = "mult_mod"
	end
	-- slop
	if key == 'MDJ_key' or key == 'MDJ_amount' or key == 'MDJ_og_key' or key == 'MDJ_og_amount' or key == 'from_mindware_lol' then
        return { [key] = amount }
    end
	local ret = calcindiveffectref(effect, scored_card, key, amount, from_edition)
	if ret then return ret end
end

local function lerp(a, b, x)
	return a + ((b - a) * x)
end

local OLDgambling = pseudorandom
function pseudorandom(seed, min, max)
	local moves = next(SMODS.find_card("j_MDJ_forcedmove"))
	if moves then
		local max_probablity = 2
		local probablities = {}
		-- the game is asking for a normalized result between 0 and 1
		if not max and not min then
			max_probablity = 5
			-- so the game doesn't crash, i can't pick 1 and 0 exactly
			max = 0.999999940395355224609375
			-- the number right before 1 in float32
			min = 0.00000000099999997171806853657471947371959686279
			-- the lowest number that doesn't have a e in it
			probablities[#probablities+1] = min
			probablities[#probablities+1] = 0.25
			probablities[#probablities+1] = 0.5
			probablities[#probablities+1] = 0.75
			probablities[#probablities+1] = max
		else
			for i = 1, 3 do
				local actual_i = i+2
				-- returns a int if possible
				local spaced_out_check = (max-min)/(actual_i-1)
				if spaced_out_check == math.floor(spaced_out_check) then
					max_probablity = actual_i
				end
			end
			if max_probablity == 2 then
				probablities[#probablities+1] = min
				probablities[#probablities+1] = max
			elseif max_probablity == 3 then
				probablities[#probablities+1] = min
				probablities[#probablities+1] = lerp(min,max,0.5)
				probablities[#probablities+1] = max
			elseif max_probablity == 4 then
				probablities[#probablities+1] = min
				probablities[#probablities+1] = math.ceil(lerp(min,max,0.333333333333333333333333333333333333333))
				probablities[#probablities+1] = math.ceil(lerp(min,max,0.666666666666666666666666666666666666666))
				probablities[#probablities+1] = max
			else
				probablities[#probablities+1] = min
				probablities[#probablities+1] = lerp(min,max,0.25)
				probablities[#probablities+1] = lerp(min,max,0.5)
				probablities[#probablities+1] = lerp(min,max,0.75)
				probablities[#probablities+1] = max
			end
		end
		return probablities[OLDgambling(seed, 1, max_probablity)]
	else
		return OLDgambling(seed, min, max)
	end
end

local olddrag = Card.stop_drag
function Card:stop_drag()  -- override 
	olddrag(self)
	local eyes = SMODS.find_card("j_MDJ_eyesjoker")
	if next(eyes) then
		for i = 1, #eyes do
			local left_joker
			local eye = eyes[i]
			for k, v in pairs(G.jokers.cards) do
				if k > 1 and v == eye then left_joker = G.jokers.cards[k-1] end
				if v.debuff == true and v.ability.eyes == true and v ~= left_joker then
					v.ability.eyes = nil
					SMODS.debuff_card(v, false, eye.config.center.key)
				end
			end
			if left_joker then
				left_joker.ability.eyes = true
				SMODS.debuff_card(left_joker, true, eye.config.center.key)
			end
		end
	end
end
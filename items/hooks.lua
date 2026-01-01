---@diagnostic disable: duplicate-set-field, redefined-local
local to_big = to_big or function(n)
	return n
end
local to_number = to_number or function(x)
	return x
end
function SMODS.current_mod.calculate(self, context)
	-- setup
	if not G.GAME.current_round.MDJ_construction_jokers_ranks and not G.GAME.current_round.MDJ_construction_jokers_temp_ranks and not G.GAME.current_round.MDJ_construction_jokers_displayed_ranks and not G.GAME.current_round.MDJ_construction_jokers_first_hand then
		G.GAME.current_round.MDJ_construction_jokers_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_temp_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_displayed_ranks = "None"
		G.GAME.current_round.played_poker_hands = {}
		G.GAME.current_round.played_poker_hands_hash = {}
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
    local approximation = math.log(10, b)
    if n >= big_ass_number and b ~= 1 then
        return n^approximation
	elseif n >= 1001 and b == 1 then
		return (10^n-1)/9
    end
	n = math.floor(to_big(n))
    local result = to_big(0)
    local place = to_big(1)
    
    if b == to_big(1) then
        for i = 1, n do
            result = result * to_big(10) + to_big(1)
        end
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
		return 10^(math.log(n, 10) * math.log(b, 10))
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
    if n >= big_ass_number then
        return 4.5*n
    end
	-- count in decimals if lower then scientific_notation
	if n < scientific_notation then
		n = string.gsub(tostring(n), "%.", "")
		n = math.floor(to_big(tonumber(n)))
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
		return to_big(10)^digits-1
	elseif digits < 1001 then
		local sum = 0
		for i = 1, digits do
			sum = sum * to_big(10) + to_big(x)
		end
		return sum
	else
		return x/9*((to_big(10)^digits)-1)
	end
end
function SetVisibleDigits(n, x)
	n = to_big(n)
	x = to_big(x)
	if n < scientific_notation then
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
	'set_visible_score'
}
-- slop
local slop_key = {
	'MDJ_amount',
	'MDJ_key'
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
	local smfw = next(SMODS.find_card("j_MDJ_smfw"))
	local anarchy_suit = 'Hearts'
	if suit_shuffle then
		anarchy_suit = 'Spades'
	end
	local g = oldcardissuit(self, suit, bypass_debuff, flush_calc)
	if anarchy and not SMODS.has_no_suit(self) then
		if self.base.suit == anarchy_suit then return self.base.suit ~= suit end
	end
	if everything_you_know_is_wrong and suitless(self) then
		return true
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


local calcindiveffectref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	local is_corrupted = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_corrupted")
	local is_dark = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_dark")
	local theres_a_mindware = next(SMODS.find_card("j_MDJ_mindware"))
	local is_demicolon = nil
	-- a scored_card could SOMEHOW not have a center, therefor crashing the game without these checks >:(
	if scored_card then
		if scored_card.config then
			if scored_card.config.center then
				is_demicolon = (scored_card.config.center.key == "j_cry_demicolon")
			end
		end
	end
	if is_corrupted then
		local msg
		if string.find(key, 'chip') then
			msg = "Mult!"
			if MyDreamJournal.chipmodkeys[key] == "add" or key == 'digit_chips' then
				amount = math.floor((amount/7.5)+0.5)
			end
		elseif string.find(key, 'mult') then
			msg = "Chips!"
			-- rounds
			if MyDreamJournal.multmodkeys[key] == "add" or key == 'digit_mult' then
				amount = math.floor((amount*7.5)+0.5)
			end
		end
		if msg and not (Talisman and Talisman.config_file.disable_anims) and scored_card then
			card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = msg, colour = string.find(key, 'chip') and G.C.CHIPS or string.find(key, 'mult') and G.C.MULT, delay = 0.2})
		end
		key = MyDreamJournal.chipmultopswap[key]
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
	if key == 'base_mult' then
		local mult = SMODS.Scoring_Parameters["mult"]
		local formeramount = amount
		amount = Base10_to_base_less_then_10(mult.current, amount)-mult.current
		key = "mult_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "Mult = Base "..formeramount, G.C.RED)
		end
	end
	if key == 'base_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		local formeramount = amount
		amount = Base10_to_base_less_then_10(chips.current, amount)-chips.current
		key = "chip_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = Base "..formeramount, G.C.BLUE)
		end
	end
	if key == "base_sum_mult" then
		local mult = SMODS.Scoring_Parameters["mult"]
		amount = SumOfDigits(mult.current)
		local formeramount = amount
		key = "mult_mod"
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
		key = "chip_mod"
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = Base "..formeramount, G.C.BLUE)
		end
	end
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
		amount = mult.current*(amount/100)
		key = "mult_mod"
	end
	if key == 'percent_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "+"..amount.."%", G.C.BLUE)
		end
		amount = chips.current*(amount/100)
		key = "chip_mod"
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
	if theres_a_mindware and not effect.from_mindware and key then
		local new_effect = Copy3(effect)
		new_effect[key] = nil
		new_effect.from_mindware = true
		local is_chips = MyDreamJournal.chipmodkeys[key]
		local is_mult = MyDreamJournal.multmodkeys[key]
		local swapped = MyDreamJournal.chipmultopswap[key]
		if not is_chips and not is_mult and not swapped then
			goto skip
		end
		local is_additive = ((is_chips == "add") and true) or ((is_mult == "add") and true)
		local new_amount = amount
		if is_additive and is_chips then
			new_amount = new_amount/7.5
		elseif is_additive and is_mult then
			new_amount = new_amount*7.5
		end
		new_effect[swapped] = new_amount
		SMODS.calculate_effect(new_effect, scored_card, from_edition)
		::skip::
	end
	if key and amount and key ~= 'MDJ_key' and key ~= 'MDJ_amount' then
		local alter = SMODS.calculate_context({MDJ_mod_key_and_amount = true, MDJ_amount = amount, MDJ_key = key, demicolon_racism = is_demicolon})
		key = (alter and alter.MDJ_key) or key
		amount = (alter and alter.MDJ_amount) or amount
	end
	if is_dark and amount and ((type(amount) == "table" or type(amount) == "number") or (MyDreamJournal.keystonumbers[MyDreamJournal.chipmodkeys[key] or MyDreamJournal.multmodkeys[key]] == 4)) then
		local operation = MyDreamJournal.chipmodkeys[key] or MyDreamJournal.multmodkeys[key]
		if not operation then
			amount = amount*2
		elseif MyDreamJournal.keystonumbers[operation] == 4 then
			amount[2] = amount[2]*2
		else
			amount = amount*2
		end
	end
	-- slop
	if key == 'MDJ_key' or key == 'MDJ_amount' then
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
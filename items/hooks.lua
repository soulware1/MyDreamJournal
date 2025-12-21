---@diagnostic disable: duplicate-set-field
local to_big = to_big or function(n)
	return n
end
function SMODS.current_mod.calculate(self, context)
	-- setup
	if not G.GAME.current_round.MDJ_construction_jokers_ranks and not G.GAME.current_round.MDJ_construction_jokers_temp_ranks and not G.GAME.current_round.MDJ_construction_jokers_displayed_ranks and not G.GAME.current_round.MDJ_construction_jokers_first_hand then
		G.GAME.current_round.MDJ_construction_jokers_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_temp_ranks = {}
		G.GAME.current_round.MDJ_construction_jokers_displayed_ranks = "None"
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
local scientific_notation = to_big(10)^11
function Base10_to_base_less_then_10(n, b)
    if n == to_big(0) then return to_big(0) end
    b = math.floor(b)
    n = math.floor(n)
	if b > 10 then
		return BaseB_to_base_10(n, b)
	-- silly goose
	elseif b == 10 then
		return n
	end
    -- this is a VERY rough approximation of what would happen during a base conversion, only use for when /10 doesn't reduce the tailsman number or it just takes too long man...
    local approximation = math.log(10, b)
    if n >= big_ass_number and b ~= 1 then
        return n^approximation
	elseif n >= 1001 and b == 1 then
		return 10^n
    end
	n = math.floor(to_big(n))
    local result = to_big(0)
    local place = to_big(1)
    
    if b == 1 then
        for i = 1, n do
            result = result * to_big(10) + to_big(1)
        end
        goto base1_skip
    end

    while n > 0 do
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
	if n > scientific_notation then
		n = to_big(tonumber(string.gsub(tostring(n), ".", "")))
	end
    local sum = 0
    while n ~= 0 do
        local last = n % 10
        sum = sum + last
        n = math.floor(n / 10)
    end
    return sum
end


if not (SMODS.Mods["entr"] and SMODS.Mods["entr"].can_load) then
	for _, v in ipairs({'eq_mult', 'Eqmult_mod', 'eq_chips', 'Eqchips_mod'}) do
		table.insert(SMODS.scoring_parameter_keys or SMODS.calculation_keys or {}, v)
	end
end
for _, v in ipairs({'base_chips', 'base_mult', 'digit_chips', 'digit_mult', 'sum_mult', 'sum_chips', 'base_sum_mult', 'base_sum_chips'}) do
	table.insert(SMODS.scoring_parameter_keys or SMODS.calculation_keys or {}, v)
end

local suitless = SMODS.has_no_suit
SMODS.has_no_suit = function(card)
	if next(SMODS.find_card("j_MDJ_etykiw")) then
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
	local anarchy_suit = 'Hearts'
	if suit_shuffle then
		anarchy_suit = 'Spades'
	end
	local g = oldcardissuit(self, suit, bypass_debuff, flush_calc)
	if anarchy then
		if self.base.suit == anarchy_suit then return self.base.suit ~= suit end
	end
	if everything_you_know_is_wrong and suitless(self) then
		return true
	end
	if suit_shuffle then
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
local oldrank = Card.get_id
function Card:get_id()
	if next(SMODS.find_card("j_MDJ_etykiw")) and SMODS.has_no_rank(self) then
		return -21
	end
	return oldrank(self)
end

local calcindiveffectref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	local is_corrupted = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_corrupted")
	local unicodes = SMODS.find_card("j_MDJ_unicode")
	local emojis = SMODS.find_card("j_MDJ_emoji")
	local jans = SMODS.find_card("j_MDJ_jannasa")
	local soulwares = SMODS.find_card("j_MDJ_soulware")
	local theres_a_bitplane = next(SMODS.find_card("j_MDJ_bitplane"))
	local theres_a_mindware = next(SMODS.find_card("j_MDJ_mindware"))
	local marks = SMODS.find_card("j_MDJ_mark")
	local latins = SMODS.find_card("j_MDJ_latin")
	local haxors = SMODS.find_card("j_MDJ_leet")
	local is_demicolon = nil
	-- a scored_card could SOMEHOW not have a center, therefor crashing the game without these checks >:(
	if scored_card then
		if scored_card.config then
			if scored_card.config.center then
				is_demicolon = (scored_card.config.center.key == "j_cry_demicolon")
			end
		end
	end
	if theres_a_mindware and not effect.from_mindware then
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
	if next(haxors) and MyDreamJournal.dollarmodkeys[key] then
		for i = 1, #haxors do
			amount = amount+haxors[i].ability.extra.add
		end
	end
	if theres_a_bitplane and (MyDreamJournal.chipmodkeys[key] or MyDreamJournal.multmodkeys[key]) == "add" then
		-- round to the nearest power of two
		local amount_is_negative = (amount < 0)
		if amount_is_negative then
			amount = math.abs(amount)
		end
		local log2 = math.log(amount, 2)
		local ceiling = math.ceil(log2)
		amount = 2^ceiling
		if amount_is_negative then
			amount = -amount
		end
	end
	if next(marks) and MyDreamJournal.plustox[key] then
		-- do a loop incase there's a is_corrupted one, shouldn't affect stuff twice
		for i = 1, #marks do
			local v = marks[i]
			local converted_key = MyDreamJournal.plustox[key]
			if converted_key then
				local cglop = SMODS.Scoring_Parameters.kali_glop.current
				local aglop = cglop+amount
				amount = aglop/cglop+v.ability.extra.add
				key = converted_key
			end
		end
	end
	if next(latins) and MyDreamJournal.plustox[key] then
		-- do a loop incase there's a is_corrupted one, shouldn't affect stuff twice
		for i = 1, #latins do
			local v = latins[i]
			local converted_key = MyDreamJournal.plustox[key]
 			---@diagnostic disable-next-line: redefined-local
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if is_corrupted and MyDreamJournal.pluschipstoxchips[key] then
				local cchips = SMODS.Scoring_Parameters.chips.current
				local achips = cchips+amount
				amount = achips/cchips+v.ability.extra.add
				key = converted_key
			elseif not is_corrupted and MyDreamJournal.plusmulttoxmult[key] then
				local cmult = SMODS.Scoring_Parameters.mult.current
				local amult = cmult+amount
				amount = amult/cmult+v.ability.extra.add
				key = converted_key
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
	-- stuff that depends on current state of mult/chips
	if key == 'base_mult' then
		local mult = SMODS.Scoring_Parameters["mult"]
		mult.current = Base10_to_base_less_then_10(mult.current, amount)
		update_hand_text({delay = 0}, {mult = mult.current})
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "Mult = Base "..amount, G.C.RED)
		end
		return true
	end
	if key == 'base_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		chips.current = Base10_to_base_less_then_10(chips.current, amount)
		update_hand_text({delay = 0}, {chips = chips.current})
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = Base "..amount, G.C.BLUE)
		end
		return true
	end
	if key == "base_sum_mult" then
		local mult = SMODS.Scoring_Parameters["mult"]
		amount = SumOfDigits(mult.current)
		mult.current = Base10_to_base_less_then_10(mult.current, amount)
		update_hand_text({delay = 0}, {mult = mult.current})
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent, nil, nil, "Mult = Base "..amount, G.C.RED)
		end
		return true
	end
	if key == 'base_sum_chips' then
		local chips = SMODS.Scoring_Parameters["chips"]
		amount = SumOfDigits(chips.current)
		chips.current = Base10_to_base_less_then_10(chips.current, amount)
		update_hand_text({delay = 0}, {chips = chips.current})
		if not Talisman or not Talisman.config_file.disable_anims then
			MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "Chips = Base "..amount, G.C.BLUE)
		end
		return true
	end
	if key == "digit_mult" then
		key = "mult"
		-- allows decimals to be counted in
		if amount > scientific_notation then
			amount = #string.gsub(tostring(SMODS.Scoring_Parameters.mult.current), ".", "")*to_big(amount)
		else
			amount = to_big(math.floor(to_big(math.log(to_big(SMODS.Scoring_Parameters.mult.current), to_big(10))+1)))*to_big(amount)
		end
	end
	if key == "digit_chips" then
		key = "chips"
		if amount > scientific_notation then
			amount = #string.gsub(tostring(SMODS.Scoring_Parameters.chips.current), ".", "")*to_big(amount)
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
	-- add in the equals if no entropy :sob:
	if not (SMODS.Mods["entr"] and SMODS.Mods["entr"].can_load) then
		if (key == 'eq_mult' or key == 'Eqmult_mod') then
			local mult = SMODS.Scoring_Parameters["mult"]
			mult.current = amount
			update_hand_text({delay = 0}, {mult = mult.current})
			if not Talisman or not Talisman.config_file.disable_anims then
				MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'mult', amount, percent)
			end
			return true
		end
		if (key == 'eq_chips' or key == 'Eqchips_mod') then
			local chips = SMODS.Scoring_Parameters["chips"]
			chips.current = amount
			update_hand_text({delay = 0}, {chips = chips.current})
			if not Talisman or not Talisman.config_file.disable_anims then
				MyDreamJournal.card_eval_status_text_eq(scored_card or effect.card or effect.focus, 'chips', amount, percent, nil, nil, "="..amount.. " Chips", G.C.BLUE)
			end
			return true
		end
	end
	if next(unicodes) and not is_demicolon then
		for i = 1, #unicodes do
			local v = unicodes[i]
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if not is_corrupted then
				local operation = MyDreamJournal.multmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (v.ability.extra.add/10)/(10^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add/10
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (v.ability.extra.add/10)/(10^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add/10
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
			end
		end
	end
	if next(emojis) and not is_demicolon then
		for i = 1, #emojis do
			local v = emojis[i]
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if is_corrupted then
				local operation = MyDreamJournal.multmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (v.ability.extra.add/100)/(10^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add/100
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = (v.ability.extra.add/100)/(10^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add/100
					end
					if not is_hyper then
						amount = amount + op_number
					else
						amount[2] = amount[2] + op_number
					end
				end
			end
		end
	end
	if next(jans) and not is_demicolon then
		for i = 1, #jans do
			local v = jans[i]
			local operation = MyDreamJournal.glopmodkeys[key]
			local op_number = MyDreamJournal.keysToNumbers[operation]
			if operation and op_number then
				-- handle generalized higher order hyperoperations
				local is_hyper = false
				if op_number == 4 then
					op_number = amount[1]
					is_hyper = true
				end
				-- mult has the same amount to add as add
				if op_number ~= -1 and op_number ~= 0 then
					op_number = v.ability.extra.add/(10^op_number)
				else
					op_number = v.ability.extra.add
				end
				if not is_hyper then
					amount = amount + op_number
				else
					amount[2] = amount[2] + op_number
				end
			end
		end
	end
	if next(soulwares) and not is_demicolon then
		for i = 1, #soulwares do
			local v = soulwares[i]
			local is_corrupted = v and (v.edition and v.edition.key == "e_MDJ_corrupted")
			if not is_corrupted then
				local operation = MyDreamJournal.multmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = 1+(v.ability.extra.extra/(2^op_number))
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add*0.8333333333333334
					end
					if not is_hyper then
						amount = amount * op_number
					else
						amount[2] = amount[2] * op_number
					end
				end
			else
				local operation = MyDreamJournal.chipmodkeys[key]
				local op_number = MyDreamJournal.keysToNumbers[operation]
				if operation and op_number then
					-- handle generalized higher order hyperoperations
					local is_hyper = false
					if op_number == 4 then
						op_number = amount[1]
						is_hyper = true
					end
					if op_number ~= -1 and op_number ~= 0 then
						op_number = v.ability.extra.add/(2^op_number)
					elseif op_number == -1 then
						op_number = v.ability.extra.add
					elseif op_number == 0 then
						op_number = v.ability.extra.add*0.8333333333333334
					end
					if not is_hyper then
						amount = amount * op_number
					else
						amount[2] = amount[2] * op_number
					end
				end
			end
		end
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
			probablities[#probablities+1] = max
			probablities[#probablities+1] = min
			probablities[#probablities+1] = 0.75
			probablities[#probablities+1] = 0.25
			probablities[#probablities+1] = 0.5
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
				probablities[#probablities+1] = max
				probablities[#probablities+1] = min
			elseif max_probablity == 3 then
				probablities[#probablities+1] = max
				probablities[#probablities+1] = min
				probablities[#probablities+1] = lerp(min,max,0.5)
			elseif max_probablity == 4 then
				probablities[#probablities+1] = max
				probablities[#probablities+1] = min
				probablities[#probablities+1] = math.ceil(lerp(min,max,0.333333333333333333333333333333333333333))
				probablities[#probablities+1] = math.ceil(lerp(min,max,0.666666666666666666666666666666666666666))
			else
				probablities[#probablities+1] = max
				probablities[#probablities+1] = min
				probablities[#probablities+1] = lerp(min,max,0.5)
				probablities[#probablities+1] = lerp(min,max,0.75)
				probablities[#probablities+1] = lerp(min,max,0.25)
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
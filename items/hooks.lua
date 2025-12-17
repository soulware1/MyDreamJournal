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

local calcindiveffectref = SMODS.calculate_individual_effect
---@diagnostic disable-next-line: duplicate-set-field
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	local is_corrupted = scored_card and (scored_card.edition and scored_card.edition.key == "e_MDJ_corrupted")
	local unicodes = SMODS.find_card("j_MDJ_unicode")
	local emojis = SMODS.find_card("j_MDJ_emoji")
	local jans = SMODS.find_card("j_MDJ_jannasa")
	local soulwares = SMODS.find_card("j_MDJ_soulware")
	local theres_a_bitplane = next(SMODS.find_card("j_MDJ_bitplane"))
	local latins = SMODS.find_card("j_MDJ_latin")
	local haxors = SMODS.find_card("j_MDJ_leet")
	local is_demicolon = false
	-- a scored_card could SOMEHOW not have a center, therefor crashing the game without these checks >:(
	if scored_card then
		if scored_card.config then
			if scored_card.config.center then
				is_demicolon = (scored_card.config.center.key == "j_cry_demicolon")
			end
		end
	end
	if next(haxors) and key == "dollars" then
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
			if MyDreamJournal.multmodkeys[key] == "add" then
				amount = math.floor((amount/7.5)+0.5)
			end
		elseif string.find(key, 'mult') then 
			msg = "Chips!"
			-- rounds
			if MyDreamJournal.multmodkeys[key] == "add" then
				amount = math.floor((amount*7.5)+0.5)
			end
		end
		if msg and not (Talisman and Talisman.config_file.disable_anims) and scored_card then
			card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = msg, colour = string.find(key, 'chip') and G.C.CHIPS or string.find(key, 'mult') and G.C.MULT, delay = 0.2})
		end
		key = MyDreamJournal.chipmultopswap[key]
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
			print(seed)
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
				probablities[#probablities+1] = lerp(min,max,0.3333333333333333333333333333)
				probablities[#probablities+1] = lerp(min,max,0.6666666666666666666666666666)
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

local oldcardissuit = Card.is_suit
---@diagnostic disable-next-line: duplicate-set-field
function Card:is_suit(suit, bypass_debuff, flush_calc)
	local anarchy = next(SMODS.find_card("j_MDJ_anarchy"))
	local suit_shuffle = next(SMODS.find_card("j_MDJ_suitshuffle"))
	local anarchy_suit = 'Hearts'
	if suit_shuffle then
		anarchy_suit = 'Spades'
	end
	local g = oldcardissuit(self, suit, bypass_debuff, flush_calc)
	if anarchy then
        ---@diagnostic disable-next-line: undefined-field
		--- if suit == self.base.suit, return false, else return true, this is basically what this does
		if self.base.suit == anarchy_suit then return self.base.suit ~= suit end
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
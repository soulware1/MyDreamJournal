local oldshuffle = CardArea.shuffle
function CardArea:shuffle(seed)
	if ( ( G.GAME.selected_back.effect.center.key == "b_MDJ_cyclic" or G.GAME.selected_sleeve == "sleeve_MDJ_cyclic" ) or ( Entropy and Entropy.DeckOrSleeve("b_MDJ_cyclic") ) ) and self == G.deck then
		return self
	end
	return oldshuffle(self, seed)
end

local function SetSelectionLimit(n, discards)
    if n == 0 then
        n = 1
    end
    if not n then
        warn("n isn't a number, what on earth are you doing? N:" .. n)
        return
    end
    if not discards then
        G.GAME.starting_params.play_limit = n
        G.hand.config.highlighted_limit = math.max(G.GAME.starting_params.discard_limit, G.GAME.starting_params.play_limit, 5)
        SMODS.update_hand_limit_text(true)
    else
        G.GAME.starting_params.discard_limit = n
        G.hand.config.highlighted_limit = math.max(G.GAME.starting_params.discard_limit, G.GAME.starting_params.play_limit, 5)
        SMODS.update_hand_limit_text(nil, true)
    end
end
SMODS.Back {
    key = "cyclic",
    pos = { x = 0, y = 0 },
    atlas = "decks",
    pools = { RedeemableBacks = true },
    config = {},
    loc_vars = function(self, info_queue, back)
        return { vars = {} }
    end,
    discovered = true,
    apply = function (self, back)
        -- when this function runs, G.deck doesn't exist, so we put in a event so it exists by the time that runs
        G.E_MANAGER:add_event(Event{
        func = function()
            if G.GAME.selected_sleeve ~= "sleeve_MDJ_cyclic" then
                oldshuffle(G.deck, tostring(G.deck))
            end
            return true -- if you do not add this, the event will re-run every single frame until it does return true
        end
        })
    end
}
SMODS.Back {
    key = "sextuplezero",
    pos = { x = 1, y = 0 },
    atlas = "decks",
    pools = { RedeemableBacks = true },
    config = { hands = 0, discards = 0 },
    loc_vars = function(self, info_queue, back)
        return { vars = {} }
    end,
    discovered = true,
    apply = function (self, back)
        -- when this function runs, G.deck doesn't exist, so we put in a event so it exists by the time that runs
        G.E_MANAGER:add_event(Event{
        func = function()
            SetSelectionLimit(G.GAME.starting_params.hands/0.2)
            SetSelectionLimit(G.GAME.starting_params.discards/0.2, true)
            return true -- if you do not add this, the event will re-run every single frame until it does return true
        end
        })
    end,
    calculate = function (self, back, context)
        if context.after then
            SetSelectionLimit(G.GAME.current_round.hands_left/0.2)
            SetSelectionLimit(G.GAME.current_round.discards_left/0.2, true)
        end
        if context.setting_blind then
            SetSelectionLimit(G.GAME.starting_params.hands/0.2)
            SetSelectionLimit(G.GAME.starting_params.discards/0.2, true)
        end
    end
}
if SMODS.Mods["CardSleeves"] and SMODS.Mods["CardSleeves"].can_load then
    CardSleeves.Sleeve {
        key = "cyclic",
        atlas = "sleeves",
        pos = { x = 0, y = 0 },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_MDJ_cyclic" then
                key = self.key .. "_alt"
            end
            return { key = key, vars = vars }
        end,
        config = { },
        apply = function (self, back)
        -- when this function runs, G.deck doesn't exist, so we put in a event so it exists by the time that runs
        G.E_MANAGER:add_event(Event{
        func = function()
            if self.get_current_deck_key() ~= "b_MDJ_cyclic" then
                oldshuffle(G.deck, tostring(G.deck))
            end
            return true -- if you do not add this, the event will re-run every single frame until it does return true
        end
        })
    end
    }
    CardSleeves.Sleeve {
        key = "sextuplezero",
        pos = { x = 1, y = 0 },
        atlas = "sleeves",
        config = { hands = 0, discards = 0 },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_MDJ_sextuplezero" then
                key = self.key .. "_alt"
            end
            return { key = key, vars = vars }
        end,
        discovered = true,
        apply = function (self, back)
            -- when this function runs, G.deck doesn't exist, so we put in a event so it exists by the time that runs
            G.E_MANAGER:add_event(Event{
            func = function()
                SetSelectionLimit(G.GAME.starting_params.hands/0.2)
                SetSelectionLimit(G.GAME.starting_params.discards/0.2, true)
                if self.get_current_deck_key() == "b_MDJ_sextuplezero" then
                    G.GAME.starting_params.discards = G.GAME.starting_params.discards + 1
                    G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
                end
                return true -- if you do not add this, the event will re-run every single frame until it does return true
            end
            })
        end,
        calculate = function (self, back, context)
            if context.after then
                SetSelectionLimit(G.GAME.current_round.hands_left/0.2)
                SetSelectionLimit(G.GAME.current_round.discards_left/0.2, true)
            end
            if context.setting_blind then
                SetSelectionLimit(G.GAME.starting_params.hands/0.2)
                SetSelectionLimit(G.GAME.starting_params.discards/0.2, true)
            end
        end
    }
end
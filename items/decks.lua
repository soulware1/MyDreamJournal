local oldshuffle = CardArea.shuffle
function CardArea:shuffle(seed)
	if G.GAME.selected_back.effect.center.key == "b_MDJ_cyclic" and self == G.deck then
		return self
	end
	return oldshuffle(self, seed)
end
SMODS.Back {
    key = "cyclic",
    pos = { x = 0, y = 0 },
    atlas = "decks",
    config = {},
    loc_vars = function(self, info_queue, back)
        return { vars = {} }
    end,
    discovered = true,
    apply = function (self, back)
        -- when this function runs, G.deck doesn't exist, so we put in a event so it exists by the time that runs
        G.E_MANAGER:add_event(Event{
        func = function()
            oldshuffle(G.deck, tostring(G.deck))
            return true -- if you do not add this, the event will re-run every single frame until it does return true
        end
        })
    end
}

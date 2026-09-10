if MyDreamJournal.entropyinstalled then
    error("Disable Entropy or My Dream Journal")
    SMODS.load_file("items/entropy/rare.lua")()
    SMODS.load_file("items/entropy/veryrare.lua")()
    SMODS.load_file("items/entropy/rlegendary.lua")()
    SMODS.load_file("items/entropy/entropic.lua")()
    SMODS.load_file("items/entropy/tags.lua")()
    SMODS.load_file("items/entropy/stickers.lua")()
    SMODS.load_file("items/entropy/software.lua")()
end

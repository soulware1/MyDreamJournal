--- STEAMODDED HEADER
--- MOD_NAME: My Dream Journal
--- MOD_ID: MyDreamJournal
--- PREFIX: MDJ
--- MOD_AUTHOR: [soulware]
--- MOD_DESCRIPTION: Idk :P also thanks to snonc41 for the construction joker idea
--- BADGE_COLOUR: 00FF00
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0905a]
SMODS.current_mod.optional_features = {
    retrigger_joker = true
}
SMODS.load_file("items/assets.lua")()
SMODS.load_file("items/MyDreamJournal_table.lua")()
SMODS.load_file("items/debug.lua")()
SMODS.load_file("items/editions.lua")()
SMODS.load_file("items/common.lua")()
SMODS.load_file("items/uncommon.lua")()
SMODS.load_file("items/rare.lua")()
SMODS.load_file("items/veryrare.lua")()
SMODS.load_file("items/legendary.lua")()
SMODS.load_file("items/unlegendary.lua")()
SMODS.load_file("items/spectrals.lua")()
SMODS.load_file("items/decks.lua")()
SMODS.load_file("items/blinds.lua")()
SMODS.load_file("items/crossmod.lua")()
SMODS.load_file("items/entropycrossmod.lua")()
SMODS.load_file("items/hooks.lua")()

----------------------------------------------
------------MOD CODE END----------------------

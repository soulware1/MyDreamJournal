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
  SMODS.Atlas({
    key = "enhancements",
    path = "enhancements.png",
    px = 71,
    py = 95
 })
  SMODS.Atlas({
    key = "installers",
    path = "installers.png",
    px = 71,
    py = 95
 })
  SMODS.Atlas({
    key = "exotic",
    path = "unlegendary.png",
    px = 71,
    py = 95
 })
  SMODS.Atlas({
    key = "nine",
    path = "large.png",
    px = 71,
    py = 95,
    atlas_table = 'ANIMATION_ATLAS', -- this line tells SMODS that this is an animated atlas
    frames = 9, -- the number of frames in your animation
    fps = 9 -- the fps to play your animation in (defaults to 10 if not included)
 })
   SMODS.Atlas({
    key = "buffer",
    path = "buffering.png",
    px = 71,
    py = 95,
    atlas_table = 'ANIMATION_ATLAS', -- this line tells SMODS that this is an animated atlas
    frames = 8, -- the number of frames in your animation
    fps = 10 -- the fps to play your animation in (defaults to 10 if not included)
 })
    SMODS.Atlas({
    key = "pretty",
    path = "cynthoni.png",
    px = 71,
    py = 95,
 })
  SMODS.Atlas({
    key = "placeholder",
    path = "placeholder.png",
    px = 71,
    py = 95
 })
   SMODS.Atlas({
    key = "finity",
    path = "finity.png",
    px = 71,
    py = 95
 })
   SMODS.Atlas({
    key = "eplaceholder",
    path = "exoticplaceholder.png",
    px = 71,
    py = 95
 })
   SMODS.Atlas({
    key = "decks",
    path = "deck.png",
    px = 71,
    py = 95
 })
SMODS.Atlas({
    key = "gift",
    path = "gift.png",
    px = 38,
    py = 38
 })
 SMODS.Atlas {
    key = "sleeves",
    path = "sleeves.png",
    px = 73,
    py = 95
}
 SMODS.Atlas({
    key = "blinds",
    path = "blinds.png",
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
 })
 SMODS.Atlas({
    key = "tags",
    path = "tags.png",
    px = 34,
    py = 34,
 })
 SMODS.Font {
	key = "pokemon",
	path = "pokemon-font.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 0.9,
	TEXT_OFFSET = { x = 12, y = -24 },
	FONTSCALE = 0.06,
	squish = 1,
	DESCSCALE = 1.25
}
 SMODS.Font {
	key = "japan",
	path = "Nosutaru-dotMPlusH-10-Regular.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = { x = 0, y = 0 },
	FONTSCALE = 0.075,
	squish = 1,
	DESCSCALE = 1.25
}
 SMODS.Font {
	key = "vcr",
	path = "VCR_OSD_MONO_1.001.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = { x = 0, y = 0 },
	FONTSCALE = 0.075,
	squish = 1,
	DESCSCALE = 1.25
}
 SMODS.Font {
	key = "unifont",
	path = "UnifontExMono.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = { x = 0, y = 0 },
	FONTSCALE = 0.075,
	squish = 1,
	DESCSCALE = 1.25
}
 SMODS.Font {
	key = "omori",
	path = "OMORI_GAME2.ttf",
	render_scale = 300,
	TEXT_HEIGHT_SCALE = 1,
	TEXT_OFFSET = { x = 0, y = 0 },
	FONTSCALE = 0.075,
	squish = 1,
	DESCSCALE = 1.25
}
local gradient = SMODS.Gradient {
   key = "rainbow1",
   colours = {
      HEX("FF0000"),
      HEX("FF6100"),
      HEX("FFC700"),
      HEX("CCFF00"),
      HEX("65FF00"),
      HEX("00FF00"),
      HEX("00FF65"),
      HEX("00FFCB"),
      HEX("00CBFF"),
      HEX("0065FF"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow1 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow2",
   colours = {
      HEX("FF6100"),
      HEX("FFC700"),
      HEX("CCFF00"),
      HEX("65FF00"),
      HEX("00FF00"),
      HEX("00FF65"),
      HEX("00FFCB"),
      HEX("00CBFF"),
      HEX("0065FF"),
      HEX("FF0000"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow2 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow3",
   colours = {
      HEX("FFC700"),
      HEX("CCFF00"),
      HEX("65FF00"),
      HEX("00FF00"),
      HEX("00FF65"),
      HEX("00FFCB"),
      HEX("00CBFF"),
      HEX("0065FF"),
      HEX("FF0000"),
      HEX("FF6100"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow3 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow4",
   colours = {
      HEX("CCFF00"),
      HEX("65FF00"),
      HEX("00FF00"),
      HEX("00FF65"),
      HEX("00FFCB"),
      HEX("00CBFF"),
      HEX("0065FF"),
      HEX("FF0000"),
      HEX("FF6100"),
      HEX("FFC700"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow4 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow5",
   colours = {
      HEX("65FF00"),
      HEX("00FF00"),
      HEX("00FF65"),
      HEX("00FFCB"),
      HEX("00CBFF"),
      HEX("0065FF"),
      HEX("FF0000"),
      HEX("FF6100"),
      HEX("FFC700"),
      HEX("CCFF00"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow5 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow6",
   colours = {
      HEX("00FF00"),
      HEX("00FF65"),
      HEX("00FFCB"),
      HEX("00CBFF"),
      HEX("0065FF"),
      HEX("FF0000"),
      HEX("FF6100"),
      HEX("FFC700"),
      HEX("CCFF00"),
      HEX("65FF00"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow6 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow7",
   colours = {
      HEX("00FF65"),
      HEX("00FFCB"),
      HEX("00CBFF"),
      HEX("0065FF"),
      HEX("FF0000"),
      HEX("FF6100"),
      HEX("FFC700"),
      HEX("CCFF00"),
      HEX("65FF00"),
      HEX("00FF00"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow7 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow8",
   colours = {
      HEX("00FFCB"),
      HEX("00CBFF"),
      HEX("0065FF"),
      HEX("FF0000"),
      HEX("FF6100"),
      HEX("FFC700"),
      HEX("CCFF00"),
      HEX("65FF00"),
      HEX("00FF00"),
      HEX("00FF65"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow8 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow9",
   colours = {
      HEX("00CBFF"),
      HEX("0065FF"),
      HEX("FF0000"),
      HEX("FF6100"),
      HEX("FFC700"),
      HEX("CCFF00"),
      HEX("65FF00"),
      HEX("00FF00"),
      HEX("00FF65"),
      HEX("00FFCB"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow9 = gradient
local gradient = SMODS.Gradient {
   key = "rainbow10",
   colours = {
      HEX("0065FF"),
      HEX("FF0000"),
      HEX("FF6100"),
      HEX("FFC700"),
      HEX("CCFF00"),
      HEX("65FF00"),
      HEX("00FF00"),
      HEX("00FF65"),
      HEX("00FFCB"),
      HEX("00CBFF"),
   },
   cycle = 10,
   interpolation = "linear"
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_rainbow10 = gradient
local gradient = SMODS.Gradient {
   key = "operations",
   colours = {
      G.C.MULT,
      G.C.CHIPS,
      G.C.MONEY,
   },
   cycle = 3,
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_operations = gradient
local gradient = SMODS.Gradient {
   key = "scoreparams",
   colours = {
      G.C.MULT,
      G.C.CHIPS,
   },
   cycle = 4,
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_scoreparams = gradient
G.ARGS.LOC_COLOURS.MDJ_operations = gradient
local gradient = SMODS.Gradient {
   key = "suits",
   colours = {
      G.C.SUITS.Spades,
      G.C.SUITS.Hearts,
      G.C.SUITS.Diamonds,
      G.C.SUITS.Clubs,
   },
   cycle = 4,
}
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_suits = gradient
loc_colour()
G.ARGS.LOC_COLOURS.MDJ_damage = HEX('FF6969')
G.C.SET.Hardware = HEX('4C4C4C')
G.C.SECONDARY_SET.Hardware = HEX('008200')
G.ARGS.LOC_COLOURS.MDJ_hardware = G.C.SECONDARY_SET.Hardware
SMODS.Shader({ key = 'corrupted', path = 'corrupted.fs' })
SMODS.Shader({ key = 'dark', path = 'dark.fs' })
SMODS.Shader({ key = 'amazing', path = 'amazing.fs' })
SMODS.Shader({ key = 'blackscale', path = 'blackscale.fs' })
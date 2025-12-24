return {
    descriptions = {
        Joker = {
            j_MDJ_eyesjoker = {
                name = "Let's take a look",
                text = {
                    "Debuff the {C:attention}Joker{} to the left.",
                }
            },
            j_MDJ_suitshuffle = {
                name = 'Suit Shuffle',
                text = {
                    "{C:spades}Hearts{} count as {C:hearts}Spades{}",
                    "{C:hearts}Spades{} count as {C:spades}Hearts{}",
                    "{C:diamonds}Clubs{} count as {C:clubs}Diamonds{}",
                    "{C:clubs}Diamonds{} count as {C:diamonds}Clubs{}",
                }
            },
            j_MDJ_unicode = {
                -- like the unicode stanred
                name = 'Unicode',
                text = {
                    "{X:mult,C:white}+#1#{} to all {C:mult}+Mult{}",
                    "{X:mult,C:white}+#2#{} to all {X:mult,C:white}XMult{}",
                    "{X:mult,C:white}+(#2#/N){} to all {C:attention}higher-operation{} Mult",
                    "{C:inactive,s:0.9}N being 10^ the used operation{}"
                }
            },
            j_MDJ_emoji = {
                name = 'Emoji',
                text = {
                    "{X:chips,C:white}+#1#{} to all {C:chips}+Chip{}",
                    "{X:chips,C:white}+#2#{} to all {X:chips,C:white}XChip{}",
                    "{X:chips,C:white}+(#2#/N){} to all {C:attention}higher-operation{} Chip",
                    "{C:inactive,s:0.9}N being 10^ the used operation{}"
                }
            },
            j_MDJ_constructionjoker = {
                -- pun on construction worker
                name = 'Construction Joker',
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "every time you play a hand",
                    "that has the same scored ranks as the",
                    "one played at the start of this Ante",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                    "{C:inactive,s:0.85} (Ranks: #3#) {}"
                }
            },
            j_MDJ_anarchy = {
                name = {
                -- this is a song name, probably shouldn't be localized idk :worm:
                    'anarchy!!!',
                    '{s:0.75}By STOMACH BOOK',
                },
                text = {
                    "{C:hearts}Hearts{} count as every suit",
                    "except their own"
                }
            },
            j_MDJ_bones = {
                name = {
                    -- yet again another song name
                    'Skeleton Appreciation Day in Vestal, NY (Bones)',
                    '{s:0.75}By Will Wood',
                },
                text = {
                    "{C:attention}Decrease{} the ranks of scored cards in",
                    "the winning hand by #1# at the end of the round",
                    "{C:inactive}(Aces count as 1s, can't go below 1)",
                }
            },
            j_MDJ_bones_live = {
                name = {
                    -- a song title AND a genetic disorder, wow!
                    'Fibrodysplasia Ossificans Progressiva (Live)',
                    '{s:0.75}By Will Wood',
                },
                text = {
                    "Destroyed or unscored cards get",
                    "replaced by {C:attention}Stone Cards",
                }
            },
            j_MDJ_bitplane = {
                -- https://en.wikipedia.org/wiki/Bit_plane
                name = 'Bit Plane',
                text = {
                    "{C:chips}+Chips{} and {C:mult}+Mult{} are rounded up",
                    "to {C:attention}the nearest power of 2"
                }
            },
            j_MDJ_spiral = {
                name = 'Spiral',
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "every time you {C:attention}continue{} a straight",
                    "{C:inactive,s:0.85} (Ex: 5 4 3 2 A -> K Q J 10 9){}",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
                }
            },
            j_MDJ_installer = {
                -- as in a computer software installer
                name = 'Installer',
                text = {
                    "Scaling {C:attention}Jokers{} scale {C:attention}twice{} as fast"
                }
            },
            j_MDJ_compressed = {
                -- like the file type
                name = 'JPG',
                text = {
                    "Consumables {C:attention}halve{} the amount of slots",
                    "they take every round when held",
                }
            },
            j_MDJ_perfect = {
                name = 'Perfection',
                text = {
                    "At end of {C:attention}ante{}, if less than",
                    "{C:attention}4{} hands were used, create",
                    "{C:attention}3{} {C:dark_edition{}Negative{} {C:attention}consumables{}"
                }
            },
            j_MDJ_heresy = {
                -- a very bad act
                name = 'Heresy',
                text = {
                    "{X:mult,C:white}X#1#{} Mult but permanently",
                    "debuff if a blind is beaten",
                    "in more than 1 hand"
                }
            },
            j_MDJ_forcedmove = {
                -- as in the chess notation
                name = "Forced Move",
                text = {
                    "All random rolls are limited to",
                    "5 or below equally spaced out",
                    "possible outcomes"
                }
            },
            j_MDJ_latin = {
                name = "Latin Script",
                text = {
                    "{C:mult}+Mult{} is converted to {X:mult,C:white}XMult",
                    "using this formula",
                    "{C:inactive}(CMult+Mult)/CMult+#1#",
                    "{C:inactive,s:0.85}CMult being Current Mult"
                }
            },
            j_MDJ_leet = {
                name = "1337 H4X0R",
                text = {
                    "Earn {C:money}$#1#{} for every {E:1,C:attention}payout row",
                    "{X:money,C:white}+#1#{} to money given during scoring"
                }
            },
            j_MDJ_mistake = {
                name = "Mistake",
                text = {
                    "All {C:attention}listed {C:green,E:1}probablities{} are",
                    "set to a {C:green}1 in #1#{} chance"
                }
            },
            j_MDJ_base = {
                name = "33058899",
                text = {
                    "Convert {C:chips}Chips{} to {C:attention,E:1}Base 9",
                }
            },
            j_MDJ_fractal = {
                name = "Juila Fractal",
                text = {
                    "{C:chips}+#1#{} Chips for each digit in {C:chips}Chips",
                }
            },
            j_MDJ_soulware = {
                name = {
                'Soulware',
                "(The Idea)"
                },
                text = {
                "{X:mult,C:white}X#1#{} all {C:mult}+Mult{}",
                "{X:mult,C:white}X#2#{} all {X:mult,C:white}XMult{}",
                "{X:mult,C:white}X(1+(#3#/N)){} all {C:attention}higher-operation{} Mult",
                "{C:inactive,s:0.9}N being 2^ the used operation{}"
                }
            },
            j_MDJ_mindware = {
                name = "Mindware",
                text = {
                    "All {C:mult,E:1}Mult Operations{}",
                    "apply to {C:chips}Chips{} too",
                    "All {C:chips,E:1}Chips Operations{}",
                    "apply to {C:mult}Mult{} too",
                    "{C:inactive,s:0.85}follows {C:attention,s:0.85}Corrupted{C:inactive,s:0.85} logic"
                }
            },
            j_MDJ_mark = {
                name = "MARK - ",
                text = {
                    "{C:glop}+Glop{} is converted to {X:glop,C:white}XGlop",
                    "using this formula",
                    "{C:inactive}(CGlop+Glop)/CGlop+#1#",
                    "{C:inactive,s:0.85}CGlop being Current Glop"
                }
            },
            j_MDJ_etykiw = {
                name = {
                    -- a song title
                    'Everything You Know is Wrong',
                    '{s:0.75}By Weird Al',
                },
                text = {
                    "{C:attention}Suitless{} Cards",
                    "count as every {C:attention}Suit"
                }
            },
            j_MDJ_floatingpoint = {
                name = "Floating Point",
                text = {
                    {"If {C:attention,E:1}scoring hand{} has exactly {C:attention}6{} cards",
                    "Convert {C:chips}Chips{} to {C:attention,E:1}Seximal",
                    "Convert {C:mult}Mult{} to {C:attention,E:1}Heximal",},
                    {"{C:attention}+1{} Card Selection Limit"}
                }
            },
            j_MDJ_decamark = {
                name = "{f:MDJ_pokemon}??????????",
                text = {
                    "{f:MDJ_pokemon}Convert {C:chips,f:MDJ_pokemon}Chips{f:MDJ_pokemon} To Base {C:attention,E:1,f:MDJ_pokemon}THE SUM OF DIGITS IN CHIPS",
                    "{f:MDJ_pokemon}Convert {C:mult,f:MDJ_pokemon}Mult{f:MDJ_pokemon} To Base {C:attention,E:1,f:MDJ_pokemon}THE SUM OF DIGITS IN MULT",
                }
            },
            MDJ_heximal_slop = {
                name = "",
                text = { "yo ddawg heximal and seximal are just base 6" }
            }
        },
        Back = {
            b_MDJ_cyclic = {
                name = "Cyclic Deck",
                text = {
                    "When shuffling deck, don't.",
                }
            }
        },
        Edition = {
            e_MDJ_corrupted = {
                name = "Corrupted",
                text = {
                    "Chips operations {X:chips,C:white}X#2#{} if {C:chips}+Chips{}",
                    "and now affects Mult instead",
                    "Mult operations {X:mult,C:white}X#1#{} if {C:mult}+Mult{}",
                    "and now affects Chips instead",
                }
            },
            e_MDJ_corrupted_glopped = {
				name = "Corrupted",
				text = {
                    "Chips operations {X:chips,C:white}X#2#{} if {C:chips}+Chips{}",
                    "and now affects Mult instead",
                    "Mult operations {X:mult,C:white}X#1#{} if {C:mult}+Mult{}",
                    "and now affects Chips instead",
					'Glop operations {X:glop,C:white}X40{} if {C:glop}+Glop{}',
                    "and now affects Sfark instead",
					'Sfark operations {X:sfark,C:white}X(1/40){} if {C:sfark}+Sfark{}',
                    "and now affects Glop instead",
				},
			},
        },
        Mod = {
            MDJ = {
                name = "My Dream Journal",
                text = {
                    "Idk :P also thanks to snonc41 for the construction joker idea",
                }
            },

        },
        Other = {
            mdj_heximal_slop = {
                name = "{f:MDJ_arial}btw",
                text = {
                    "{f:MDJ_arial}yo ddawg heximal and seximal are just base 6"
                }
            }
        },
    },
    misc = {
        dictionary = {
            MDJ_corrupted = "Corrupted",
            k_MDJ_veryrare = "Unrare",
        },
        labels = {
            MDJ_corrupted = "Corrupted",
            MDJ_veryrare = "Unrare",
        }
    }
}
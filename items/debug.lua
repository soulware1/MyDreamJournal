MyDreamJournal.awesome_path = SMODS.current_mod.path

SMODS.Keybind {
    key_pressed = '`',
    action = function ()
        SMODS.handle_loc_file(MyDreamJournal.awesome_path)
        init_localization()
    end
}
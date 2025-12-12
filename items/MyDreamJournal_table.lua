MyDreamJournal = MyDreamJournal or {}
Talisman = Talisman or nil

MyDreamJournal.rank_shorthands = {
		"_",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"10",
		"J",
		"Q",
		"K",
		"A"
}

MyDreamJournal.chipmultopswap = {
	['chips'] = 'mult',
	['h_chips'] = 'h_mult',
	['chip_mod'] = 'mult_mod',
	['mult'] = 'chips',
	['h_mult'] = 'h_chips',
	['mult_mod'] = 'chip_mod',
	['x_chips'] = 'x_mult',
	['xchips'] = 'xmult',
	['Xchip_mod'] = 'Xmult_mod',
	['x_mult'] = 'x_chips',
	['xmult'] = 'xchips',
	['Xmult'] = 'xchips',
	['x_mult_mod'] = 'Xchip_mod',
	['Xmult_mod'] = 'Xchip_mod',
	-- Talisman.
	['e_mult'] = 'e_chips',
	['emult'] = 'echips',
	['ee_mult'] = 'ee_chips',
	['eemult'] = 'eechips',
	['eee_mult'] = 'eee_chips',
	['eeemult'] = 'eeechips',
	['hypermult'] = 'hyperchips',
	['hyper_mult'] = 'hyper_chips',
	['e_chips'] = 'e_mult',
	['echips'] = 'emult',
	['ee_chips'] = 'ee_mult',
	['eechips'] = 'eemult',
	['eee_chips'] = 'eee_mult',
	['eeechips'] = 'eeemult',
	['hyperchips'] = 'hypermult',
	['hyper_chips'] = 'hyper_mult',
	['Emult_mod'] = 'Echip_mod',
	['EEmult_mod'] = 'EEchip_mod',
	['EEEmult_mod'] = 'EEEchip_mod',
	['hypermult_mod'] = 'hyperchip_mod',
	['Echip_mod'] = 'Emult_mod',
	['EEchip_mod'] = 'EEmult_mod',
	['EEEchip_mod'] = 'EEEmult_mod',
	['hyperchip_mod'] = 'hypermult_mod',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.chipmodkeys = {
	['chips'] = 'add', ['h_chips'] = 'add', ['chip_mod'] = 'add',
	['x_chips'] = 'mult', ['xchips'] = 'mult', ['Xchip_mod'] = 'mult',
	['e_chips'] = 'expo', ['echips'] = 'expo', ['Echip_mod'] = 'expo',
	['ee_chips'] = 'tetra', ['eechips'] = 'tetra', ['EEchip_mod'] = 'tetra',
	['eee_chips'] = 'penta', ['eeechips'] = 'penta', ['EEEchip_mod'] = 'penta',
	['hyperchips'] = 'hyper', ['hyper_chips'] = 'hyper', ['hyperchip_mod'] = 'hyper',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.multmodkeys = {
	['mult'] = 'add', ['h_mult'] = 'add', ['mult_mod'] = 'add',
	['x_mult'] = 'mult', ['xmult'] = 'mult', ['Xmult'] = 'mult', ['x_mult_mod'] = 'mult', ['Xmult_mod'] = 'mult',
	['e_mult'] = 'expo', ['emult'] = 'expo', ['Emult_mod'] = 'expo',
	['ee_mult'] = 'tetra', ['eemult'] = 'tetra', ['EEmult_mod'] = 'tetra',
	['eee_mult'] = 'penta', ['eeemult'] = 'penta', ['EEEmult_mod'] = 'penta',
	['hypermult'] = 'hyper', ['hyper_mult'] = 'hyper', ['hypermult_mod'] = 'hyper',
	-- Other mods can add their custom operations to this table.
}

MyDreamJournal.keysToNumbers = {
	["add"] = -1, ["mult"] = 0, ["expo"] = 1, ["tetra"] = 2, ["penta"] = 3, ["hyper"] = 4
}

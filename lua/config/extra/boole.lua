local keymaps = require("config.ode").get("keymaps").boole
require("boole").setup({
	mappings = {
		increment = keymaps.increment,
		decrement = keymaps.decrement,
	},
	-- User defined loops
	additions = {
		-- {'Foo', 'Bar'},
		-- {'tic', 'tac', 'toe'}
	},
	allow_caps_additions = {
		{ "enable", "disable" },
		-- enable → disable
		-- Enable → Disable
		-- ENABLE → DISABLE
	},
})

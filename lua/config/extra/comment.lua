local keymaps = require("config.ode").get("keymaps").commenter
require("Comment").setup({
	---Add a space b/w comment and the line
	padding = true,
	---Whether the cursor should stay at its position
	sticky = true,
	---Lines to be ignored while (un)comment
	ignore = nil,
	---LHS of toggle mappings in NORMAL mode
	toggler = {
		---Line-comment toggle keymap
		line = keymaps.toggler.line,
		---Block-comment toggle keymap
		block = keymaps.toggler.block,
	},
	---LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		---Line-comment keymap
		line = keymaps.opleader.line,
		---Block-comment keymap
		block = keymaps.opleader.block,
	},
	---LHS of extra mappings
	extra = {
		---Add comment on the line above
		above = keymaps.extra.above,
		---Add comment on the line below
		below = keymaps.extra.below,
		---Add comment at the end of line
		eol = keymaps.extra.eol,
	},
	---Enable keybindings
	---NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = true,
		---Extra mapping; `gco`, `gcO`, `gcA`
		extra = true,
	},
	---Function to call before (un)comment
	pre_hook = nil,
	---Function to call after (un)comment
	post_hook = nil,
})

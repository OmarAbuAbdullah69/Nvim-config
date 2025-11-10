local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
	vim.notify("nvim-autopairs not found!", vim.log.levels.WARN)
	return
end

local Rule = require("nvim-autopairs.rule")

local fast_wrap_map = require("config.ode").get("keymaps").autopairs.fast_wrap
npairs.setup({
	enabled = function(bufnr)
		return true -- Always enable; you could disable for large files if needed
	end,

	-- Disable in these filetypes
	disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },

	-- Disable in certain modes
	disable_in_macro = true, -- no autopairs while recording/executing macros
	disable_in_visualblock = false, -- allow in visual block
	disable_in_replace_mode = true, -- disable in replace mode

	-- Regex to skip pairing when next char matches
	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],

	-- Behavior settings
	enable_moveright = false, -- jump right over existing closing pairs
	enable_afterquote = true, -- allow pairs after quotes
	enable_check_bracket_line = true, -- check for bracket on same line
	enable_bracket_in_quote = true, -- allow brackets inside quotes
	enable_abbr = false, -- disable abbreviation feature
	break_undo = true, -- separate undo steps for pair typing

	-- Treesitter integration
	check_ts = true, -- ✅ smarter pairing based on code context

	-- Mappings
	map_cr = true, -- auto-indent + close braces when pressing Enter
	map_bs = true, -- smart backspace deletes pair if empty
	map_c_h = false,
	map_c_w = false,

	fast_wrap = {
		map = fast_wrap_map, -- trigger key (Alt + e)
		chars = { "{", "[", "(", '"', "'" },
		pattern = [=[[%'%"%)%>%]%)%}%,]]=],
		offset = 0,
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "Search",
		highlight_grey = "Comment",
	},
})

-- enable Treesitter and use 'nvim-autopairs.ts_rule'
local ts_ok, ts_config = pcall(require, "nvim-treesitter.configs")
if ts_ok then
	ts_config.setup({
		autopairs = { enable = true }, -- connect nvim-autopairs with Treesitter
	})
end

-- Example 1: Add extra pair for "$$" (useful in LaTeX or Markdown math)
npairs.add_rule(Rule("$$", "$$", "tex"))

-- Example 2: Only add angle brackets <> in HTML, XML, or TSX files
npairs.add_rule(Rule("<", ">", { "html", "xml", "javascriptreact", "typescriptreact" }))

-- Example 3: Disable single quote pairing in Lua (for strings)
npairs.remove_rule("'") -- removes default single-quote rule

-- Disable autopairs when entering a terminal buffer
vim.api.nvim_create_autocmd("TermEnter", {
	callback = function()
		npairs.disable()
	end,
	desc = "Disable autopairs in terminal mode",
})
-- Re-enable autopairs when leaving terminal buffer
vim.api.nvim_create_autocmd("TermLeave", {
	callback = function()
		npairs.enable()
	end,
	desc = "Re-enable autopairs after leaving terminal",
})

-- Show message when autopairs is loaded
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "NvimAutopairsSetup",
--   callback = function()
--     vim.notify("🔗 nvim-autopairs is ready!", vim.log.levels.INFO)
--   end,
-- })
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local npairs = require("nvim-autopairs")

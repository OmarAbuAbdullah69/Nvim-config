-- =========================
-- Fold column & fillchars
-- =========================
vim.o.foldcolumn = "0" -- keep it 1 char wide
vim.o.foldlevel = 99 -- start unfolded
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.require('ufo').getFoldedResult(v:lnum)"

-- Nice icons instead of numbers
vim.o.fillchars = "fold: ,foldopen:,foldclose:,foldsep:│"

-- =========================
-- Virtual fold text handler
-- =========================
local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (" 󰁂 %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

-- =========================
-- UFO setup
-- =========================
local ufo = require("ufo")

ufo.setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
	fold_virt_text_handler = handler,
	enable_get_fold_virt_text = true, -- UFO handles fold column rendering
})
-- If you want to use the standard keys, but ensure they use ufo functions:
-- map_ufo('n', 'za', 'toggleFold', 'Toggle [a]t cursor')
-- map_ufo('n', 'zc', 'closeFold', 'Close [c]ursor fold')
-- map_ufo('n', 'zo', 'openFold', 'Open [o]utside fold')

-- Set up required vim folding options for UFO to work correctly
-- statuscol
-- statuscol.lua
-- local statuscol = require("statuscol")
-- local builtin = require("statuscol.builtin")
-- local cfg = {
--   setopt = true,         -- Whether to set the 'statuscolumn' option, may be set to false for those who
--                          -- want to use the click handlers in their own 'statuscolumn': _G.Sc[SFL]a().
--                          -- Although I recommend just using the segments field below to build your
--                          -- statuscolumn to benefit from the performance optimizations in this plugin.
--   -- builtin.lnumfunc number string options
--   thousands = false,     -- or line number thousands separator string ("." / ",")
--   relculright = false,   -- whether to right-align the cursor line number with 'relativenumber' set
--   -- Builtin 'statuscolumn' options
--   ft_ignore = nil,       -- Lua table with 'filetype' values for which 'statuscolumn' will be unset
--   bt_ignore = nil,       -- Lua table with 'buftype' values for which 'statuscolumn' will be unset
--   -- Default segments (fold -> sign -> line number + separator), explained below
--   segments = {
--     { text = { "%C" }, click = "v:lua.ScFa" },
--     { text = { "%s" }, click = "v:lua.ScSa" },
--     {
--       text = { builtin.lnumfunc, " " },
--       condition = { true, builtin.not_empty },
--       click = "v:lua.ScLa",
--     }
--   },
--   clickmod = "c",         -- modifier used for certain actions in the builtin clickhandlers:
--                           -- "a" for Alt, "c" for Ctrl and "m" for Meta.
--   clickhandlers = {       -- builtin click handlers, keys are pattern matched
--     Lnum                    = builtin.lnum_click,
--     FoldClose               = builtin.foldclose_click,
--     FoldOpen                = builtin.foldopen_click,
--     FoldOther               = builtin.foldother_click,
--     DapBreakpointRejected   = builtin.toggle_breakpoint,
--     DapBreakpoint           = builtin.toggle_breakpoint,
--     DapBreakpointCondition  = builtin.toggle_breakpoint,
--     ["diagnostic/signs"]    = builtin.diagnostic_click,
--     gitsigns                = builtin.gitsigns_click,
--   },
-- }
--
-- statuscol.setup(cfg)

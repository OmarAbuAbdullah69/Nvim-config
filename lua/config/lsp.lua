local langs = require("config.ode").get("langs")

for _, v in pairs(langs) do
	if v.completion then
		vim.lsp.enable(v.server)
	end
end

local diagnostics = require("config.ode").get("diagnostics")

local virtual_text_active = diagnostics.virtual_text.enabled
local vtl = { --this variable contains the actual setup for virtual text
	-- show inline text annotations
	prefix = "●", -- could be "●", "■", "▎", "●", "▶", or ""
	spacing = 2, -- space between text and diagnostic message
	source = "if_many", -- "always", "if_many", or false
	severity = nil, -- filter severity { min = vim.diagnostic.severity.WARN }
	format = function(diagnostic)
		return string.format("[%s] %s", diagnostic.source, diagnostic.message)
	end,
}
function ToggleDiagnostics()
	virtual_text_active = not virtual_text_active
	if virtual_text_active then
		vim.diagnostic.config({
			virtual_text = vtl,
		})
		print("✅ Diagnostics virtual text enabled")
	else
		vim.diagnostic.config({
			virtual_text = false,
		})
		print("❌ Diagnostics virtual text disabled")
	end
end

local keymaps = require("config.ode").get("keymaps")
vim.api.nvim_set_keymap("n", keymaps.diagnostic.toggle, ":lua ToggleDiagnostics()<CR>", { noremap = true, silent = true })

local vts = vtl --this vatiable holds the value for the virtual text on startup
if not diagnostics.virtual_text.enabled then
	vts = false
end

vim.diagnostic.config({
	-- === General diagnostic behavior ===
	underline = {
	-- whether to underline diagnostic text
	-- can also be a table like { severity = vim.diagnostic.severity.ERROR }
	-- to only underline certain severities
	severity = { min = vim.diagnostic.severity.HINT },
},

	virtual_text = vts,

	signs = {
		-- show icons in the sign column
		active = true, -- can be true, false, or a table of severity
		text = {
			[vim.diagnostic.severity.ERROR] = "", -- Example: Nerd Font icon for error
			[vim.diagnostic.severity.WARN] = "", -- Example: Nerd Font icon for warning
			[vim.diagnostic.severity.INFO] = "", -- Example: Nerd Font icon for info
			[vim.diagnostic.severity.HINT] = "󰌵", -- Example: Nerd Font icon for hint
		},
	},

	-- whether to sort diagnostics by severity
	severity_sort = true,

	-- whether to update diagnostics while typing in insert mode
	update_in_insert = false,

	-- === Floating windows (hover popups, etc.) ===
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "if_many", -- "always", "if_many", or false
		header = "", -- header text above diagnostics
		prefix = "", -- text prefix before each diagnostic line
		close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		scope = "line", -- "line", "cursor", or "buffer"
		format = function(diagnostic)
			return string.format("%s (%s)", diagnostic.message, diagnostic.source)
		end,
	},

	--[[ 	-- === Virtual lines (newer Neovim feature) ===
	virtual_lines = {
		highlight_whole_line = false,
		only_current_line = false,
		severity = nil, -- e.g. { min = vim.diagnostic.severity.WARN }
		source = "if_many",
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
 ]]
	-- === Displaying diagnostics in the statusline / locationlist / etc. ===
	-- These aren’t part of the table directly, but you can mimic their behavior
	-- using vim.diagnostic handlers.

	-- You could add a custom handler for signs if needed:
	-- signs = { priority = 10 },
})

--# key maps
vim.keymap.set('n', keymaps.diagnostic.goto_prev, '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', keymaps.diagnostic.goto_next, '<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.keymap.set('n', keymaps.diagnostic.open_float, '<cmd>lua vim.diagnostic.open_float()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local bufmap = function(mode, rhs, lhs)
      vim.keymap.set(mode, rhs, lhs, {buffer = event.buf})
    end

    bufmap('n', keymaps.lsp.hover, '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', keymaps.lsp.rename, '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', keymaps.lsp.references, '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', keymaps.lsp.definition, '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', keymaps.lsp.code_action, '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('n', keymaps.lsp.declaration, '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', keymaps.lsp.implementation, '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', keymaps.lsp.document_symbol, '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
    bufmap('n', keymaps.lsp.type_definition, '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap({'i', 's'}, keymaps.lsp.signature_help, '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  end,
})
--# key maps


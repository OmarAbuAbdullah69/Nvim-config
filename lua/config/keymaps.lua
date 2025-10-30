local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

local keymaps = require("config.ode").get("keymaps")

--Remap space as leader key
keymap("", keymaps.leader, "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

for m, s in pairs(keymaps.modes) do
	for k, v in pairs(s) do
		keymap(m, k, v, ops)
	end
end

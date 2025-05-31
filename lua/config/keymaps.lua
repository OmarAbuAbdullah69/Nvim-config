local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "dp", "d$", opts)
-- easy quit write
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>wq", ":wq<CR>", opts)

-- buffer navigation
keymap("n", "<leader>bj", ":BufferNext<CR>", opts)
keymap("n", "<leader>bh", ":BufferPrevious<CR>", opts)
keymap("n", "<leader>bc", ":BufferClose<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
 
-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Normal-mode commands
vim.keymap.set('n', '<A-Up>'      ,':MoveLine -1<CR>', opts)
vim.keymap.set('n', '<A-Down>'    ,':MoveLine 1<CR>', opts)
vim.keymap.set('n', '<A-S-Left>'  ,':MoveWord -1<CR>', opts)
vim.keymap.set('n', '<A-S-Right>' ,':MoveWord 1<CR>', opts)

-- exploerer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

--telescopr
keymap("n", "<leader>ff", ":Telescope fd<CR>", opts)
keymap("n", "<leader>f", ":Telescope<CR>", opts)

-- Insert --

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Visual-mode commands
vim.keymap.set('x', '<A-Up>'   , ':MoveBlock 1<CR>', opts)
vim.keymap.set('x', '<A-Down>' , ':MoveBlock -1<CR>', opts)
vim.keymap.set('v', '<A-Left>' , ':MoveHBlock -1<CR>', opts)
vim.keymap.set('v', '<A-Right>', ':MoveHBlock 1<CR>', opts)

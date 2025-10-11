-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

local opts = require("config.ode").get("filetree")

-- OR setup with some options
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  sort = {
    sorter = "name",
    folders_first = opts.sort.items_first == "folders",
    files_first = opts.sort.items_first == "files",
  },
  hijack_cursor = true,
  update_cwd = false,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = opts.diagnostics.enable,
    show_on_dirs = opts.diagnostics.show_ondir,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
	modified = {
		enable = opts.modified.enable,
		show_on_dirs = opts.modified.show_ondir,
	},
  filters = {
		enable = opts.filters.enable,
    dotfiles = opts.filters.dotfiles,
    git_clean = false,
    no_buffer = false,
    custom = {},
    exclude = {},               -- list of names to exclude
  },
  view = {
    width = opts.view.width,
    side = opts.view.side,              -- or "right"
    number = false,
    relativenumber = false,
    signcolumn = "yes",
		centralize_selection = opts.view.centralize_selection,
		cursorline = opts.view.cursorline,
  },
  renderer = {
    group_empty = opts.renderer.group_empty,
    highlight_git = false,
    root_folder_modifier = ":t",   -- how to show root folder
    icons = {
      show = {
        file = opts.renderer.icons.file,
        folder = opts.renderer.icons.folder,
        folder_arrow = opts.renderer.icons.folder_arrow,
        git = opts.renderer.icons.git,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = opts.actions.close_on_fileopen,        -- close tree when opening a file
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "terminal" },
        },
      },
    },
    remove_file = {
      close_window = false,
    },
  },
  on_attach = nil,    -- function(bufnr) to map custom keys
})

-- 1. Load cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
local props = require("config.ode").get("completion")

require("luasnip.loaders.from_vscode").lazy_load()

-- 2. Setup configuration
cmp.setup({
	formatting = {
    format = function(entry, vim_item)
			local kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = " ",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "",
				Event = "",
				Operator = "󰆕",
				TypeParameter = " ",
				Misc = " ",
			}
      -- Set the icon for the completion kind
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or vim_item.kind)

      -- -- Optional: add source name as menu
      -- vim_item.menu = ({
      --   buffer = "[BUF]",
      --   nvim_lsp = "[LSP]",
      --   luasnip = "[SNIP]",
      --   path = "[PATH]",
      -- })[entry.source.name]

      return vim_item
    end,
  },
  snippet = {
    -- (required) this tells cmp how to expand snippets
    expand = function(args)
			luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    [props.select] = cmp.mapping.confirm({ select = true }),  -- confirm suggestion
    [props.abort] = cmp.mapping.abort(),
    [props.complete] = cmp.mapping.complete(),  -- trigger completion manually
		[props.next] = cmp.mapping.select_next_item(),
		[props.prev] = cmp.mapping.select_prev_item(),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" },   -- from LSP
    { name = "luasnip" },   -- from LSP
    { name = "buffer" },     -- from current file text
    { name = "path" },       -- file paths
  }),
})

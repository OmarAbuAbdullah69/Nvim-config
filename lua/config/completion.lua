-- 1. Load cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
local props = require("config.ode").get("completion")

require("luasnip.loaders.from_vscode").lazy_load()

local select_behavior = {}
if props.select_behavior == "select" then
	select_behavior["behavior"] = cmp.SelectBehavior.Select
elseif props.select_behavior == "insert" then
	select_behavior["behavior"] = cmp.SelectBehavior.Insert
end

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

			return vim_item
		end,
	},
	snippet = {
		-- (required) this tells cmp how to expand snippets
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	experimental = {
		ghost_text = props.ghost_text,
	},
	mapping = cmp.mapping.preset.insert({
		[props.select] = cmp.mapping.confirm({ select = false }), -- confirm suggestion
		[props.abort] = cmp.mapping.abort(),
		[props.complete] = cmp.mapping.complete(), -- trigger completion manually
		[props.next] = cmp.mapping.select_next_item( select_behavior ),
		[props.prev] = cmp.mapping.select_prev_item(select_behavior),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- from LSP
		{ name = "luasnip" }, -- Lua snippets
		{ name = "buffer" }, -- from current file text
		{ name = "path" }, -- file paths
	}),
})

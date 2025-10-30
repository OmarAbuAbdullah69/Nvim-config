local langs = require("config.ode").get("langs")
local formatters = {}

for k, v in pairs(langs) do
	formatters[k] = v.formatter
end
require("conform").setup({
	formatters_by_ft = formatters,
})

-- for randomization
math.randomseed(os.time())

local completion = require("config.ode").get("completion").enable

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.themes")
require("config.syntax")
require("config.telescope")
if completion then
	require("config.completion")
end
require("config.lsp")
require("config.expolerer")
require("config.extra")

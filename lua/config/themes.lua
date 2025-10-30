local themesList = require("config.ode").get("themes")
local themes = {}

for _, i in pairs(themesList.selected) do
	themes[#themes + 1] = i
end

local index = math.random(#themes)
local selected = themes[index]

if index == 3 then
	vim.opt.background = "dark"
end

local ode = require("config.ode")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. selected)
if not status_ok then
	return
end

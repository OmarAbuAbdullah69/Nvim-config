local themes = {"monokai-pro", "wich-dark", "oxocarbon", "sonokai", "tokyonight-night", "nightfly", "material-deep-ocean", "neofusion"}
local index = math.random(#themes)
local selected = themes[index]

if index == 3 then
	vim.opt.background="dark"
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. selected)
if not status_ok then
  return
end




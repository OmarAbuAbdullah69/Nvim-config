local M = {}

-- path to the json file
M.path = vim.fn.stdpath("config") .. "/ode.json"

-- Internal cache for data
M.data = {}

-- Helper: load from file
function M.load()
	local ok, content = pcall(vim.fn.readfile, M.path)
	if not ok then
		vim.notify("Could not read ode.json", vim.log.levels.ERROR)
		M.data = {}
		return
	end

	local joined = table.concat(content, "\n")
	local ok2, decoded = pcall(vim.fn.json_decode, joined)
	if not ok2 then
		vim.notify("Invalid JSON in settings.json", vim.log.levels.ERROR)
		M.data = {}
		return
	end

	M.data = decoded
end

-- Helper: write to file
function M.save()
	local ok, encoded = pcall(vim.fn.json_encode, M.data)
	if not ok then
		vim.notify("Failed to encode JSON", vim.log.levels.ERROR)
		return
	end

	local ok2, err = pcall(vim.fn.writefile, { encoded }, M.path)
	if not ok2 then
		vim.notify("Failed to write ode.json: " .. tostring(err), vim.log.levels.ERROR)
	end
end

-- Get a value (with optional default)
function M.get(key, default)
	return M.data[key] ~= nil and M.data[key] or default
end

-- Set a value (does NOT auto-save unless you want)
function M.set(key, value)
	M.data[key] = value
end

-- Load settings when required
M.load()

return M

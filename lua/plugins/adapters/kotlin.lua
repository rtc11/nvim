-- Kotlin DAP via KLS (Kotlin Language Server)
local dap = require("dap")

dap.adapters.kotlin = {
	type = "executable",
	command = os.getenv("HOME") .. "/code/c3/kls/build/kls",
	args = { "--dap" },
}

-- Auto-detect gradle module from current buffer path.
-- Maps: apps/utsjekk/test/... -> :apps:utsjekk
--       libs/auth/test/...    -> :libs:auth
--       models/test/...       -> :models
local function detect_gradle_module()
	local buf_path = vim.fn.expand("%:p")
	local workspace = vim.fn.getcwd()
	local rel = buf_path:sub(#workspace + 2) -- strip workspace + /

	-- Try two-level modules first: apps/name/..., libs/name/...
	local prefix, name = rel:match("^([^/]+)/([^/]+)/")
	if prefix and name then
		if prefix == "apps" or prefix == "libs" then
			return ":" .. prefix .. ":" .. name
		end
	end

	-- Single-level module: models/...
	local single = rel:match("^([^/]+)/")
	if single and single ~= "src" and single ~= "build" then
		return ":" .. single
	end

	return ""
end

dap.configurations.kotlin = {
	{
		name = "Gradle Test",
		type = "kotlin",
		request = "launch",
		workspacePath = function() return vim.fn.getcwd() end,
		gradleModule = detect_gradle_module,
	},

}

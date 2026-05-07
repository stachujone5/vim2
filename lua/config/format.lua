local M = {}

local executable_path = function(name)
	if vim.fn.executable(name) == 1 then
		return name
	end

	return nil
end

local replace_buffer = function(bufnr, text)
	if text == "" then
		return
	end

	local view = vim.fn.winsaveview()
	local lines = vim.split(text, "\n", { plain = true })
	if lines[#lines] == "" then
		table.remove(lines)
	end
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
	vim.fn.winrestview(view)
end

local format_with_stylua = function(bufnr)
	local stylua = executable_path("stylua")
	if stylua == nil then
		vim.notify("stylua is not installed or not on PATH", vim.log.levels.ERROR)
		return
	end

	local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
	local result = vim.system({ stylua, "-" }, { text = true, stdin = input }):wait()
	if result.code ~= 0 then
		local message = result.stderr ~= "" and result.stderr or "stylua failed"
		vim.notify(message, vim.log.levels.ERROR)
		return
	end

	replace_buffer(bufnr, result.stdout)
end

local eslint_markers = {
	"eslint.config.js",
	"eslint.config.mjs",
	"eslint.config.cjs",
	"eslint.config.ts",
	"eslint.config.mts",
	"eslint.config.cts",
	".eslintrc",
	".eslintrc.js",
	".eslintrc.cjs",
	".eslintrc.json",
	".eslintrc.yaml",
	".eslintrc.yml",
}

local biome_markers = { "biome.json", "biome.jsonc" }

local dirname = function(path)
	if path == "" then
		return vim.uv.cwd()
	end

	return vim.fs.dirname(path)
end

local find_upward = function(markers, start)
	local matches = vim.fs.find(markers, { upward = true, path = start })
	return matches[1]
end

local has_package_json_key = function(start, key)
	local package_json = find_upward({ "package.json" }, start)
	if package_json == nil then
		return nil
	end

	local ok, contents = pcall(vim.fn.readfile, package_json)
	if not ok then
		return nil
	end

	local decoded_ok, package = pcall(vim.json.decode, table.concat(contents, "\n"))
	if not decoded_ok or type(package) ~= "table" or package[key] == nil then
		return nil
	end

	return package_json
end

local run_stdin_formatter = function(bufnr, command, args, cwd, failure_message)
	local input = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
	local result = vim.system(vim.list_extend({ command }, args), {
		text = true,
		stdin = input,
		cwd = cwd,
	}):wait()

	if result.code ~= 0 then
		local message = result.stderr ~= "" and result.stderr or failure_message
		vim.notify(message, vim.log.levels.ERROR)
		return
	end

	replace_buffer(bufnr, result.stdout)
end

local format_with_eslint_d = function(bufnr, root)
	local eslint_d = executable_path("eslint_d")
	if eslint_d == nil then
		vim.notify("eslint_d is not installed or not on PATH", vim.log.levels.ERROR)
		return
	end

	local file = vim.api.nvim_buf_get_name(bufnr)
	run_stdin_formatter(
		bufnr,
		eslint_d,
		{ "--stdin", "--stdin-filename", file, "--fix-to-stdout" },
		root,
		"eslint_d failed"
	)
end

local format_with_biome = function(bufnr, root)
	local biome = executable_path("biome")
	if biome == nil then
		vim.notify("biome is not installed or not on PATH", vim.log.levels.ERROR)
		return
	end

	local file = vim.api.nvim_buf_get_name(bufnr)
	run_stdin_formatter(bufnr, biome, { "format", "--stdin-file-path", file }, root, "biome failed")
end

local format_with_project_js_tool = function(bufnr)
	local file = vim.api.nvim_buf_get_name(bufnr)
	local start = dirname(file)

	local eslint_config = find_upward(eslint_markers, start) or has_package_json_key(start, "eslintConfig")
	if eslint_config ~= nil then
		format_with_eslint_d(bufnr, vim.fs.dirname(eslint_config))
		return
	end

	local biome_config = find_upward(biome_markers, start)
	if biome_config ~= nil then
		format_with_biome(bufnr, vim.fs.dirname(biome_config))
		return
	end

	vim.notify("No ESLint or Biome config found; using Biome", vim.log.levels.WARN)
	format_with_biome(bufnr, start)
end

local js_filetypes = {
	javascript = true,
	javascriptreact = true,
	json = true,
	jsonc = true,
	typescript = true,
	typescriptreact = true,
}

M.format_buffer = function(bufnr)
	if vim.bo[bufnr].filetype == "lua" then
		format_with_stylua(bufnr)
		return
	end

	if js_filetypes[vim.bo[bufnr].filetype] then
		format_with_project_js_tool(bufnr)
		return
	end

	vim.notify("No formatter configured for filetype: " .. vim.bo[bufnr].filetype, vim.log.levels.ERROR)
end

return M

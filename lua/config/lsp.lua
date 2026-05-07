local servers = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

local js_filetypes = {
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
}

local biome_filetypes = {
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"typescript",
	"typescriptreact",
}

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

local dirname = function(bufnr)
	local file = vim.api.nvim_buf_get_name(bufnr)
	if file == "" then
		return vim.uv.cwd()
	end

	return vim.fs.dirname(file)
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

local eslint_root = function(start)
	local config = find_upward(eslint_markers, start) or has_package_json_key(start, "eslintConfig")
	if config == nil then
		return nil
	end

	return vim.fs.dirname(config)
end

local biome_root = function(start)
	local config = find_upward(biome_markers, start)
	if config ~= nil then
		return vim.fs.dirname(config)
	end

	return vim.fs.root(start, { "package.json", ".git" }) or start
end

local add_server = function(name, executable, config)
	if vim.fn.executable(executable) ~= 1 then
		vim.notify(executable .. " is not installed or not on PATH", vim.log.levels.ERROR)
		return
	end

	config.capabilities = capabilities
	vim.lsp.config(name, config)
	table.insert(servers, name)
end

add_server("lua_ls", "lua-language-server", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
})

add_server("ts_ls", "typescript-language-server", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = js_filetypes,
	root_markers = { "tsconfig.json", "package.json", ".git" },
})

add_server("eslint", "vscode-eslint-language-server", {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = js_filetypes,
	root_dir = function(bufnr, on_dir)
		local root = eslint_root(dirname(bufnr))
		if root == nil then
			return
		end

		on_dir(root)
	end,
})

add_server("biome", "biome", {
	cmd = { "biome", "lsp-proxy" },
	filetypes = biome_filetypes,
	root_dir = function(bufnr, on_dir)
		local start = dirname(bufnr)
		if eslint_root(start) ~= nil then
			return
		end

		on_dir(biome_root(start))
	end,
})

vim.lsp.enable(servers)

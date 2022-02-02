local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
local lsp_installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lspconfig_status_ok then
	return
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>.
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- mapped to gl to match with LunarVim
	-- buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- add l along with <space>
	buf_set_keymap("n", "<space>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<space>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    -- [svim]
    if client.name == "clangd" then
        buf_set_keymap("n", "<leader>lo", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
        buf_set_keymap("n", "<A-o>", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
    end
end

local get_lsp_capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_nvim_lsp_status_ok then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    end
    return capabilities
end

-- using lspconfig
-- enable lsp servers. commented because of below for loop.
-- lspconfig.golangci_lint_ls.setup{}
-- lspconfig.gopls.setup{}
-- lspconfig.pylsp.setup{cmd={'pyls'}}
-- lspconfig.clangd.setup{}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- [rakesh] will be used only when nvim-lsp-installer is not installed
if not lsp_installer_status_ok then
    local servers = { "sumneko_lua", "vimls", "jsonls", "yamlls", "cmake",
        "golangci_lint_ls", "gopls", "pylsp", "clangd", "rust_analyzer", "tsserver"
    }
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            },
        })
    end
end

-- using nvim-lsp-installer
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
if lsp_installer_status_ok then
    lsp_installer.on_server_ready(function(server)
        local opts = {
            -- map buffer local keybindings when the language server attaches
            on_attach = on_attach,
            capabilities = get_lsp_capabilities(),
        }
        -- (optional) Customize the options passed to the server
        if server.name == "sumneko_lua" or server.name == "jsonls" then
            -- print(server.name .. " - configuring...")
            opts = require("svim.lsp." .. server.name).setup(opts)
        end

        -- This setup() function is exactly the same as lspconfig's setup function.
        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        server:setup(opts)
    end)
end

-- config for nlsp-settings.nvim
local nlspsettings_status_ok, nlspsettings = pcall(require, "nlspsettings")
if nlspsettings_status_ok then
    nlspsettings.setup({
        config_home = vim.fn.stdpath("data") .. "/nlsp-settings",
        local_settings_root_markers = { ".git" },
        jsonls_append_default_schemas = true,
    })
end

-- config for null-ls.nvim
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if null_ls_status_ok then
    null_ls.setup({
        sources = {
            -- lua formatter and linter
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.luacheck,
            -- python formatter and linter
            null_ls.builtins.formatting.black,
            null_ls.builtins.diagnostics.flake8,
            -- spell completion
            null_ls.builtins.completion.spell,
        },
    })
end

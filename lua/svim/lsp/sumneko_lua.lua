local M = {}

function M.setup(opts)
    opts["settings"] = {
        Lua = {
            runtime = {
                version = 'LuaJIT', -- most likely LuaJIT in the case of Neovim
                path = require("svim.utils").get_package_path(), -- Setup your lua path
            },
            diagnostics = {
                globals = { "vim", "lvim", "use" },
            },
            workspace = {
                maxPreload = 100000,
                preloadFileSize = 10000,
                library = require("svim.utils").get_runtime_lua_path(), -- Make the server aware of Neovim runtime files
            },
        },
    }
    local lua_dev_loaded, lua_dev = pcall(require, "lua-dev")
    if lua_dev_loaded then
        local dev_opts = {
          library = {
            vimruntime = true, -- runtime path
            types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
            plugins = true, -- installed opt or start plugins in packpath
            -- you can also specify the list of plugins to make available as a workspace library
            -- plugins = { "plenary.nvim" },
          },
          lspconfig = opts,
        }
        opts = lua_dev.setup(dev_opts)
        -- opts = vim.tbl_deep_extend("force", lua_dev.setup(dev_opts), opts)
        require("svim.utils").print_table(opts.settings.Lua)
    end
    return opts
end

return M

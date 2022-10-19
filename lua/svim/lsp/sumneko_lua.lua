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
    return opts
end

return M

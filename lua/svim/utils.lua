local M = {}

local is_windows = vim.loop.os_uname().version:match "Windows"
local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"

---Join path segments that were passed as input
---@return string
local join_paths = function(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

local get_shell = function()
    if is_windows then
        return '\"C:\\Program Files\\Git\\bin\\bash.exe\"'
    else
        return vim.o.shell
    end
end

local print_table = function(tbl)
    local luarocks_path = ';'
    if is_windows then
        -- TODO get the path using luarocks
        luarocks_path = ';C:\\ProgramData\\chocolatey\\lib\\luarocks\\luarocks-2.4.4-win32\\systree\\share\\lua\\5.1\\?.lua'
    end
    package.path = join_paths(package.path, luarocks_path)
    local inspect_ok, inspect = pcall(require, "inspect")
    if inspect_ok then
        print(inspect(tbl))
    end
end

local get_runtime_lua_path = function()
    local runtime_file_tbl = vim.api.nvim_get_runtime_file("lua/", true)
    local runtime_file_lua_tbl = {}
    for _, runtime_file in pairs(runtime_file_tbl) do
        runtime_file_lua_tbl[runtime_file] = true
    end
    return runtime_file_lua_tbl
end

local get_package_path = function()
    local package_path = vim.split(package.path, ';')
    table.insert(package_path, "lua/?.lua")
    table.insert(package_path, "lua/?/init.lua")
    -- local runtime_file_tbl = vim.api.nvim_get_runtime_file("lua/", true)
    -- for _, runtime_file in pairs(runtime_file_tbl) do
    --     local runtime_lua_path = join_paths(runtime_file, "?.lua")
    --     local runtime_lua_init_path = join_paths(runtime_file, "?", "init.lua")
    --     table.insert(package_path, runtime_lua_path)
    --     table.insert(package_path, runtime_lua_init_path)
    --     package.path = join_paths(package.path, runtime_lua_path)
    --     package.path = join_paths(package.path, runtime_lua_init_path)
    -- end
    return package_path
end

M.is_windows = is_windows
M.join_paths = join_paths
M.get_shell = get_shell
M.print_table = print_table
M.get_runtime_lua_path = get_runtime_lua_path 
M.get_package_path = get_package_path

return M

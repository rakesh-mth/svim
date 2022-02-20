local M = {}

--- Disable autocommand groups if it exists
--- This is more reliable than trying to delete the augroup itself
---@param name string the augroup name
function M.disable_augroup(name)
    -- defer the function in case the autocommand is still in-use
    vim.schedule(function()
        if vim.fn.exists("#" .. name) == 1 then
            vim.cmd("augroup " .. name)
            vim.cmd "autocmd!"
            vim.cmd "augroup END"
        end
    end)
end

--- Create autocommand groups based on the passed definitions
---@param definitions table contains trigger, pattern and text. The key will be used as a group name
---@param buffer boolean indicate if the augroup should be local to the buffer
function M.define_augroups(definitions, buffer)
    for group_name, definition in pairs(definitions) do
        vim.cmd("augroup " .. group_name)
        if buffer then
            vim.cmd [[autocmd! * <buffer>]]
        else
            vim.cmd [[autocmd!]]
        end

        for _, def in pairs(definition) do
            local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
            vim.cmd(command)
        end
        vim.cmd "augroup END"
    end
end


local default_augroup = {
    _general_settings = {
        { "FileType", "qf", "set nobuflisted" },
        { "FileType", "qf,help,man", "nnoremap <silent> <buffer> q :close<CR>" },
        { "TextYankPost", "*", "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})", },
    },
    _formatoptions = {
        { "BufWinEnter,BufRead,BufNewFile", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o", },
    },
    _filetypechanges = {
    },
    _git = {
        { "FileType", "gitcommit", "setlocal wrap" },
        { "FileType", "gitcommit", "setlocal spell" },
    },
    _markdown = {
        { "FileType", "markdown", "setlocal wrap" },
        { "FileType", "markdown", "setlocal spell" },
    },
    _buffer_bindings = {
        { "FileType", "floaterm", "nnoremap <silent> <buffer> q :q<CR>" },
    },
    _auto_resize = {
        -- will cause split windows to be resized evenly if main window is resized
        { "VimResized", "*", "tabdo wincmd =" },
    },
    _general_lsp = {
        -- these are set in autocmd.vim
        -- { "FileType", "lspinfo,lsp-installer,null-ls-info", "nnoremap <silent> <buffer> q :close<CR>" },
    },
    custom_groups = {
    },
}

M.define_augroups(default_augroup)

return M


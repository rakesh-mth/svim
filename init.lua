-- vim.api.nvim_command[[
--     exec 'source ' . expand("<sfile>:p:h") . "/core/svim.vim"
-- ]]
--

function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)"):sub(1, -2)
end

-- print(script_path())

vim.cmd('source ' .. script_path() .. '/core/svim.vim')

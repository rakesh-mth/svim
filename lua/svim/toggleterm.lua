local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end


function _G.set_terminal_keymaps()
    local opts = {noremap = true}
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*toggleterm* lua set_terminal_keymaps()')


toggleterm.setup{
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    -- on_open = fun(t: Terminal), -- function to run when the terminal opens
    -- on_close = fun(t: Terminal), -- function to run when the terminal closes
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    direction =  'float', -- 'vertical' | 'horizontal' | 'window' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell =  require("svim.utils").get_shell(), -- vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'double', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- width = <value>,
        -- height = <value>,
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    }
}

-- terminals: powershell and cmd
local Terminal  = require('toggleterm.terminal').Terminal
if require 'svim.utils'.is_windows then
    local powershell = Terminal:new({
        cmd = "powershell",
        dir = "git_dir",
        hidden = true,
        direction = "float",
        float_opts = {
            border = "double",
        },
        on_open = function(term)
            vim.cmd("startinsert!")
        end,
    })
    local cmd = Terminal:new({
        cmd = "cmd",
        dir = "git_dir",
        hidden = true,
        direction = "float",
        float_opts = {
            border = "double",
        },
        on_open = function(term)
            vim.cmd("startinsert!")
        end,
    })
    function _terminal_toggle(name)
        if name == 'powershell' then
            powershell:toggle()
        end
        if name == 'cmd' then
            cmd:toggle()
        end
    end
    vim.api.nvim_set_keymap("n", "<leader>tp", "<cmd>lua _terminal_toggle('powershell')<CR>", {noremap = true, silent = true})
    vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>lua _terminal_toggle('cmd')<CR>", {noremap = true, silent = true})
end

-- git status using lazygit
local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})
function _lazygit_toggle()
    lazygit:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

-- system monitoring status using btm
local btm = Terminal:new({
    cmd = "btm",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
})
function _btm_toggle()
    btm:toggle()
end
vim.api.nvim_set_keymap("n", "<leader>ab", "<cmd>lua _btm_toggle()<CR>", {noremap = true, silent = true})

-- build projects using ctxmake
local ctxmake_x86 = Terminal:new({
    cmd = "ctxmake -a x86",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
    close_on_exit = false,
})
local ctxmake_x64 = Terminal:new({
    cmd = "ctxmake -a x64",
    hidden = true,
    direction = "float",
    float_opts = {
        border = "double",
    },
    close_on_exit = false,
})
function _ctxmake_toggle(bIsX86)
    if bIsX86 then
        ctxmake_x86:toggle()
    else
        ctxmake_x64:toggle()
    end
end
-- system monitoring status using btm
vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>lua _ctxmake_toggle(true)<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>M", "<cmd>lua _ctxmake_toggle(false)<CR>", {noremap = true, silent = true})

-- git push command and keymap
vim.cmd [[ command! -count=1 TermGitPush  lua require'toggleterm'.exec("git push", <count>, 12) ]]
vim.api.nvim_set_keymap("n", "<leader>gp", "<cmd>TermGitPush<CR>", {noremap = true, silent = true})


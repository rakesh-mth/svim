local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local status_action_ok, actions = pcall(require, "telescope.actions")
if not status_action_ok then
    return
end

local telescope_settings = {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.85,
            preview_cutoff = 120,
            horizontal = { mirror = false },
            vertical = { mirror = false },
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
        },
        mappings = {
            i = {
                ["<C-c>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<CR>"] = actions.select_default + actions.center,
            },
            n = {
                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
        },
        file_ignore_patterns = {},
        path_display = { shorten = 5 },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        pickers = {
            find_files = {
                find_command = { "fd", "--type=file", "--hidden", "--smart-case" },
            },
            live_grep = {
                --@usage don't include the filename in the search results
                only_sort_text = true,
            },
        },
    },
    pickers = {
    },
    extensions = {
        fzf = { -- for telescope-fzf-native.nvim extention
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        project = { -- for telescope-project.nvim extention
            base_dirs = {
                {path = '~/workspaces', max_depth = 2},
                {path = '~/.config/nvim-config', max_depth = 2},
                '~/.config/nvim',
            },
            hidden_files = false -- default: false
        },
    }
}

-- call setup on telescope
telescope.setup(telescope_settings)
telescope.load_extension('project')

-- call setup on project plugin and load telescope project extention
local status_project_nvim_ok, project_nvim = pcall(require, "project_nvim")
if status_project_nvim_ok then
    -- call setup on project_nvim
    project_nvim.setup({
        -- these are defaults
        manual_mode = false,
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        datapath = vim.fn.stdpath("data"),
    })
    -- load telescope extention for project.nvim plugin - note: project vs projects picker
    require("telescope").load_extension('projects')
end

-- keymap for telescope
vim.api.nvim_set_keymap("n", "<leader>tp", "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>Telescope find_files<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>tb", "<cmd>Telescope buffers<CR>", {noremap = true, silent = true})


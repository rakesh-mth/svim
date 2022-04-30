local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

local treesitter_config_status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_config_status_ok then
	return
end

local treesitter_config = {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = { "haskell" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        -- disable = { "c", "rust" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = { "yaml" },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
}

-- treesitter playground
local treesitter_playground_status_ok, _ = pcall(require, "nvim-treesitter-playground")
if treesitter_playground_status_ok then
    treesitter_config["playground"] = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
end


-- treesitter textobjects
local treesitter_textobjects_status_ok, _ = pcall(require, "nvim-treesitter-textobjects")
if treesitter_textobjects_status_ok then
    -- error "found treesitter textobjects"
    treesitter_config["textobjects"] = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = { -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>ta"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>tA"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
    }
end


-- treesitter refactor
local treesitter_refactor_status_ok, _ = pcall(require, "nvim-treesitter-refactor")
if treesitter_refactor_status_ok then
    treesitter_config["refactor"] = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~100.
        },
        highlight_current_scope = {
            enable = false,
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr", -- TODO: change this mapping
            },
        },
        navigation = {
            enable = false, -- TODO: change mapping and enable this
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
            },
        },
    }
end

-- treesitter refactor
local vim_matchup_status_ok, _ = pcall(require, "treesitter-matchup")
if vim_matchup_status_ok then
    treesitter_config["matchup"] = {
        enable = true,              -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
        -- [options]
    }
end

treesitter_configs.setup(treesitter_config)


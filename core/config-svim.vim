" source all plugin configs
exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/options.vim'
exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/mappings.vim'
exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/autocmd.vim'
exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/python.vim'
exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/startify.vim'
exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/path.vim'
exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/log.vim'
" source coc.nvim configs. coc.nvim is used with neovim < 0.5.
if !has('win32unix') && !has('nvim-0.5')
    exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/coc/coc.vim'
    exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/config/coc/coc-extensions.vim'
endif

" source lua files
if has('nvim-0.5') && exists("g:lspconfig")
    exec 'luafile ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/lua/svim/nvim-tree.lua'
    exec 'luafile ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/lua/svim/cmp.lua'
    exec 'luafile ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/lua/svim/lsp-config.lua'
    exec 'luafile ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/lua/svim/treesitter.lua'
    exec 'luafile ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/lua/svim/hop.lua'
endif


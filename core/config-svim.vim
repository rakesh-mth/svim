let s:svimPath = expand('<sfile>:p:h:h')
" source all plugin configs
exec 'source ' . s:svimPath . '/config/options.vim'
exec 'source ' . s:svimPath . '/config/mappings.vim'
exec 'source ' . s:svimPath . '/config/autocmd.vim'
exec 'source ' . s:svimPath . '/config/python.vim'
exec 'source ' . s:svimPath . '/config/startify.vim'
exec 'source ' . s:svimPath . '/config/path.vim'
exec 'source ' . s:svimPath . '/config/log.vim'
" source coc.nvim configs. coc.nvim is used with neovim < 0.5.
if !has('win32unix') && !has('nvim-0.5')
    exec 'source ' . s:svimPath . '/config/coc/coc.vim'
    exec 'source ' . s:svimPath . '/config/coc/coc-extensions.vim'
endif

" source lua files
if has('nvim-0.5') && exists("g:lspconfig")
    exec 'luafile ' . s:svimPath . '/lua/svim/nvim-tree.lua'
    exec 'luafile ' . s:svimPath . '/lua/svim/cmp.lua'
    exec 'luafile ' . s:svimPath . '/lua/svim/lsp-config.lua'
    exec 'luafile ' . s:svimPath . '/lua/svim/treesitter.lua'
    exec 'luafile ' . s:svimPath . '/lua/svim/hop.lua'
endif


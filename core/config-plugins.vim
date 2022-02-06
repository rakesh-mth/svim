" source all plugin configs

let s:svimPath = expand('<sfile>:p:h:h')

exec 'source ' . s:svimPath . '/config/plugins-config/system-copy-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/startify-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/airline-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/tags-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/indent-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/nerdtree-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/ultisnip-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/cpp-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/fzfproject-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/vim-sneak-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/floaterm-config.vim'
exec 'source ' . s:svimPath . '/config/plugins-config/quickscope-config.vim'


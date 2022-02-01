" source all plugin configs

let s:svimPath = expand('<sfile>:p:h:h')

exec 'source ' . s:svimPath . '/config/airline-config.vim'
exec 'source ' . s:svimPath . '/config/tags-config.vim'
exec 'source ' . s:svimPath . '/config/indent-config.vim'
exec 'source ' . s:svimPath . '/config/nerdtree-config.vim'
exec 'source ' . s:svimPath . '/config/ultisnip-config.vim'
exec 'source ' . s:svimPath . '/config/cpp-config.vim'
exec 'source ' . s:svimPath . '/config/fzfproject-config.vim'
exec 'source ' . s:svimPath . '/config/vim-sneak-config.vim'


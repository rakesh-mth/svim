" this file can be used as .vimrc or init.vim on windows, linux and mac
" works with neovim-qt, gvim (windows), fvim (windows), vimr (mac), macvim (mac)
 
" echo "sourcing global.vim"
" source gloabls.vim to bring global variables
exec 'source ' . expand('<sfile>:p:h:h') . '/core/globals.vim'
" echo "done global.vim"
" echo g:UC_VIM_CONFIG_FOLDER_FULL_PATH
" echo g:UC_PLUGGED_DIR

" install plug.vim (bootstrap plugin)
    let plugPath = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/autoload/plug.vim'
    if empty(glob(plugPath))
        silent execute '!curl -fLo ' . plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" add path of rakesh-mth to rtp 
    let &rtp = &rtp . ',' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH


" echo "sourcing plugins.vim"
    " exec 'source ' . g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/core/plugins.vim'

" auto install all plugin if vim-user-config is missing (bootstrap vim-user-config). 
    if !isdirectory(g:UC_PLUGGED_DIR)
        autocmd VimEnter * PlugInstall --sync | call svim#functions#LoadPlug()  | PlugInstall | source $MYVIMRC
    else
        call svim#functions#LoadPlug()
    endif


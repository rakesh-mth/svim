" this file can be used as .vimrc or init.vim on windows, linux and mac
" works with neovim-qt, gvim (windows), fvim (windows), vimr (mac), macvim (mac)
 
" script variables
    let s:svimPath   = expand('<sfile>:p:h:h')
    let s:plugPath   = s:svimPath . '/autoload/plug.vim'
    let s:pluggedDir = s:svimPath . '/plugged'

" global variables
    " user home dir
    if has('win32') | let g:UC_HOME_DIR = $USERPROFILE | else | let g:UC_HOME_DIR = $HOME | endif
    let g:UC_HOME_DIR = substitute(g:UC_HOME_DIR, "\\", "\/", "g")
    " workspace folder
    let g:UC_WORKSPACE_DIR = has('win32') ? 'f:\DevTrees' : $HOME . '/workspaces'
    " vim folder full path
    let g:UC_VIM_CONFIG_FOLDER_FULL_PATH = expand('<sfile>:p:h:h')
    " plugged folder
    let g:UC_PLUGGED_DIR = g:UC_VIM_CONFIG_FOLDER_FULL_PATH . '/plugged' " Specify a directory for plugins 

" function to load svim
    function s:LoadPlug()
        " pre configure plugins
        exec 'source ' . s:svimPath . '/core/config-plugins.vim'
        " enable plugins
        exec 'source ' . s:svimPath . '/core/plugins.vim'
    endfunction

" install plug.vim (bootstrap plugin)
    if empty(glob(s:plugPath))
        silent execute '!curl -fLo ' . s:plugPath . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif

" add path of svim to rtp 
    let &rtp = &rtp . ',' . s:svimPath

" auto install all plugin if vim-user-config is missing (bootstrap vim-user-config). 
    if !isdirectory(s:pluggedDir)
        set background=dark
        augroup svim_bootstrap
            autocmd VimEnter * call s:LoadPlug()  | PlugInstall --sync | call s:LoadPlug() | close | Startify | call svim#onstart#SetColorscheme() | helptags ALL
        augroup END
    else
        call s:LoadPlug()
    endif

" post configure plugins, run it during VimEnter so that all plugins are loaded.
    augroup config_svim
        autocmd! VimEnter * exec 'source ' . s:svimPath . '/core/config-svim.vim'
    augroup END 


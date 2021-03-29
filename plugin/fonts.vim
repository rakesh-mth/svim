" set guifont - some gui frontend might not have guifont option (ex: vimr in mac)

if exists('&guifont') 
    set guifont=MesloLGS\ NF:h24
    " if exists('g:fvim_loaded') " fvim - neovim gui on windows
    "     set guifont=Hack:h24
    " elseif has('gui_macvim') " macvim - vim gui on mac
    "     set guifont=MesloLGS\ NF:h24
    " else
    "     set guifont=Source\ Code\ Pro\ for\ Powerline:h20:cANSI
    "     " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h16:cANSI
    " endif
endif

" use nord colorscheme

set background=dark " light or dark
colorscheme gruvbox
if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    " colorscheme solarized_nvimqt
else
    if has('gui_running')
        " colorscheme solarized
        set guioptions=imTr
        set guioptions-=imTr  "no_icon, menu_bar, toolbar, scrollbar
        nnoremap <F11> <Esc>:call ToggleGUICruft()<cr>
    else
        " colorscheme nord 
    endif
endif

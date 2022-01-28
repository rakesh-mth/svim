" set guifont - some gui frontend might not have guifont option (ex: vimr in mac)

if exists('&guifont') 
    set guifont=MesloLGS\ NF:h20
    if exists('g:fvim_loaded') " fvim - neovim gui on windows
        set guifont=MesloLGS\ NF:h24 "set guifont=Hack:h24
    endif
    " if has('gui_macvim') " macvim - vim gui on mac
    "     set guifont=MesloLGS\ NF:h24
    " else
    "     set guifont=Source\ Code\ Pro\ for\ Powerline:h20:cANSI
    "     " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h16:cANSI
    " endif
endif

" use nord colorscheme


call svim#onstart#SetColorscheme()

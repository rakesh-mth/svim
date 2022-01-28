" set colorscheme and background color
function svim#onstart#SetColorscheme()
    set background=dark " light or dark
    silent! colorscheme gruvbox " ignore error if gruvbox is not installed
    if has('nvim')
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        " colorscheme solarized_nvimqt
    else
        if has('gui_running')
            " colorscheme solarized
            set guioptions=imTr
            set guioptions-=imTr  "no_icon, menu_bar, toolbar, scrollbar
        else
            " colorscheme nord 
        endif
    endif
endfunction

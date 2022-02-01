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

" tabs : change tabs using Alt-1, Alt-2, Alt-3...
function! svim#onstart#AltMapping()
    nnoremap <M-0> 10gt
    for idx in range( 1, 9 )
        execute 'nnoremap <M-' . idx . '> ' . '<C-[>' . idx . 'gt'
    endfor
    if has('mac')
        for altc in items({'¡' : 1, '™': 2, '£': 3, '¢': 4, '∞': 5, '§': 6, '¶': 7, '•': 8, 'ª': 9}) " sed -n l => Alt + 1
            execute 'nnoremap ' . altc[0] . ' ' . '<C-[>' . altc[1] . 'gt'
        endfor
    endif
endfunction

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" it is recommended to put them in an autocmd so that they are updated if and when the colorscheme changes.
augroup qs_colors
    autocmd!
      autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
      autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

let g:qs_max_chars=150

" Blacklist buftypes
let g:qs_buftype_blacklist = ['terminal', 'nofile']
" Blacklist filetypes
let g:qs_filetype_blacklist = ['dashboard', 'startify']

let g:system_copy_silent = 1
if has('win32')
    " set this for neovim since there is no uname on windows
    let g:system_copy#copy_command = 'clip'
    " we can use paste from git bash ot msys except it does not work!
    " download location for paste for dos is mentioned on below PR, but it looks old
    " https://github.com/christoomey/vim-system-copy/pull/35
    " let g:system_copy#paste_command = 'paste'
    " use powershell for paste
    let g:system_copy#paste_command='powershell.exe -NoLogo -NoProfile -Noninteractive -Command "Get-Clipboard"'
endif

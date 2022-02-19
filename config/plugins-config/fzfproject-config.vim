" for plugin fzf-project
let g:fzfSwitchProjectProjectDepth = 2 " one level deep for finding projects
let g:fzfSwitchProjectWorkspaces=[g:UC_WORKSPACE_DIR, g:UC_HOME_DIR . '/.config/nvim-config'] " workspaces
let g:fzfSwitchProjectProjects=[ g:UC_PLUGGED_DIR . '/vim-user-config', g:UC_HOME_DIR . '/.config/emacs/spacemacs/.emacs.d', g:UC_HOME_DIR . '/.config/emacs/doom-emacs/.emacs.d' ] " individual projects
if has('nvim')
    call add(g:fzfSwitchProjectProjects, stdpath("config"))
endif

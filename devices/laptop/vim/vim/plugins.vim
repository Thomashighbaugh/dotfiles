"---------------------------------------------------
"Vim Plug Plugins 
"---------------------------------------------------

" call with directory configuration
call plug#begin('~/.vim/plugged')

" Makes consistent defaults across editors 
Plug 'editorconfig/editorconfig-vim'
" Statusbar Replacement 
Plug 'itchyny/lightline.vim'
" Adds multiple cursors (CRTL + n)
Plug 'terryma/vim-multiple-cursors'
" Adds :Delete :Move :Rename :Chmod :Mkdir :SudoWrite :SudoEdit
Plug 'tpope/vim-eunuch'
"Surround highlighted text with ", {, {, ( etc
Plug 'tpope/vim-surround'
" VIM linting engine
Plug 'w0rp/ale'

" File Explorer
 Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Notes Plugin
Plug  'xolox/vim-notes'
Plug 'xolox/vim-misc'

"--------------------------------------------
" Initialize vim-plug
call plug#end()

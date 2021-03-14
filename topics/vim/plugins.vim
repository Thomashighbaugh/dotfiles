call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'

Plug 'tpope/vim-eunuch'

Plug 'tpope/vim-surround'

Plug 'xolox/vim-misc'

Plug 'vimwiki/vimwiki'

Plug 'junegunn/vim-easy-align'

Plug 'dense-analysis/ale'

Plug 'editorconfig/editorconfig-vim'

Plug 'itchyny/lightline.vim'

Plug 'scrooloose/nerdtree'

Plug 'mhinz/vim-startify'

Plug 'chiel92/vim-autoformat'

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'vimwiki/vimwiki'

Plug 'junegunn/fzf'

Plug 'junegunn/fzf.vim'

Plug 'michal-h21/vim-zettel'

Plug 'ihsanturk/neuron.vim'

Plug 'tpope/vim-fugitive'

Plug 'reedes/vim-pencil'

Plug  'chrisbra/Replay' 



" React, JavaScript 
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

Plug 'jparise/vim-graphql'

Plug 'sheerun/vim-polyglot'

Plug 'othree/html5.vim'

Plug 'cakebaker/scss-syntax.vim'

Plug 'mxw/vim-jsx'

Plug 'pangloss/vim-javascript'

Plug 'leafgarland/typescript-vim'

Plug 'peitalin/vim-jsx-typescript'

Plug 'scrooloose/nerdcommenter'

Plug 'jiangmiao/auto-pairs'

Plug 'farmergreg/vim-lastplace'




Plug 'tpope/vim-dispatch'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sirver/ultisnips'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'klen/python-mode'
Plug 'vim-scripts/DrawIt'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/Shebang'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/css3-mod'

Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/TaskList.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/po.vim--Jelenak'
Plug 'honza/vim-snippets'
Plug 'nono/vim-handlebars'
Plug 'powerman/vim-plugin-viewdoc'

Plug 'vim-airline/vim-airline-themes'
Plug 'editorconfig/editorconfig-vim'
Plug 'tomtom/tcomment_vim'
Plug 'davidhalter/jedi-vim'
Plug 'ludovicchabant/vim-lawrencium'
Plug 'jelera/vim-javascript-syntax'
Plug 'tpope/vim-unimpaired'
Plug 'terryma/vim-multiple-cursors'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-repeat'
Plug 'gregsexton/MatchTag'
Plug 'chriskempson/base16-vim'

Plug 'edkolev/tmuxline.vim'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'Quramy/tsuquyomi'
Plug 'machakann/vim-highlightedyank'
Plug 'ekalinin/Dockerfile.vim'

Plug 'joshdick/onedark.vim' 

" Over 70 language packs
Plug 'sheerun/vim-polyglot'

if v:version >= 800
    " Vim 8.0: Alternative async-completor plugin
    " built-in support for python (jedi), java, etc.
    Plug 'maralla/completor.vim'
    Plug 'w0rp/ale'
else
    Plug 'scrooloose/syntastic'
endif


call plug#end()


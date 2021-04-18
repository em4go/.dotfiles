" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Themes
    Plug 'joshdick/onedark.vim'
    " Stable version of coc
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Keeping up to date with master
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
    " Airline nav
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'    
    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    " Rainbow
    Plug 'junegunn/rainbow_parentheses.vim'
    " Commentaries
    Plug 'tpope/vim-commentary'
    " Add multiple cursors
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    " Startify
    Plug 'mhinz/vim-startify'


call plug#end()

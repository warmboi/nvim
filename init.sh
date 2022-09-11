#! /bin/bash

read -r -d '' INIT_VIM << EOM
if has("syntax")
  syntax on
endif

set hlsearch                    " 검색어 하이라이팅
set nu                          " 줄번
set autoindent                  " 자동 들여쓰기
set ts=4                        " tag select
set sts=4                       " st select
set cindent                     " C언어 자동 들여쓰기
set laststatus=2                " 상태바 표시 항상
set shiftwidth=2                " 자동 들여쓰기 너비 설정
set showmatch                   " 일치하는 괄호 하이라이팅
set smartcase                   " 검색시 대소문자 구별
set smarttab
set smartindent
set ruler                       " 
set fileencodings=utf8,euc-kr
set cul                         " 커서가 있는 라인을 하이라이트 표시
set termguicolors   "true 컬러"
set mouse+=a
set updatetime=250
set backspace=indent,eol,start
set laststatus=2 " turn on bottom bar
set nowrap

let g:airline_theme='onedark'
let g:ctrlp_custom_ignore = { 'dir': 'node_modules$\|dist$' }
let g:ale_fixers ={'javascript': ['prettier', 'eslint'], 'typescript': ['prettier', 'eslint'] }
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:fugitive_dynamic_colors = 0

vnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
nmap <silent> gd <Plug>(coc-definition)

nnoremap <silent> K :call ShowDocumentation()<CR>
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
nnoremap yy "+yy
nnoremap p "+p
nnoremap x "+x
vnoremap y "+y
vnoremap p "+p
vnoremap x "+x

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

call plug#begin('~/.config/nvim/plugged')
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'dense-analysis/ale'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'navarasu/onedark.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'dyng/ctrlsf.vim'
  Plug 'romgrk/barbar.nvim'
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'nvim-neo-tree/neo-tree.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'MunifTanjim/nui.nvim'
call plug#end()

lua << EOF
require('modules.barbar')
require('modules.neo-tree')
require('modules.onedark')
require('modules.dap')
EOF

EOM

rm -rf init.vim
echo "$INIT_VIM" >> init.vim

read -p "is WSL ? (Y/N): " IS_WSL

if [ $IS_WSL == "Y" ]; then
read -r -d '' INIT_VIM << EOM
  let g:clipboard = { 'name': 'WslClipboard', 'copy': { '+': 'clip.exe' }, 'paste': { '+': 'powershell.exe -c [Console]::Out.Write(\$(Get-Clipboard -Raw).tostring().replace("\`r", ""))' }, 'cache_enabled': 0  }

EOM
echo "$INIT_VIM" >> init.vim
fi

read -p "install vim-plug ? (Y/N): " IS_INSTALL_VIM_PLUG
if [ $IS_INSTALL_VIM_PLUG == "Y" ]; then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

read -p "install plugins ? (Y/N): " IS_INSTALL_VIM_PLUGINS
if [ $IS_INSTALL_VIM_PLUGINS == "Y" ]; then
  nvim -c PlugInstall -c q! -c q! .
fi

read -p "install node_debug ? (Y/N): " IS_INSTALL_NODE_DEBUG
if [ $IS_INSTALL_NODE_DEBUG == "Y" ]; then
  rm -rf external/node_debug
  git clone https://github.com/Microsoft/vscode-node-debug2.git external/node_debug
  cd external/node_debug
  npm install && npm run build --no-experimental-fetch && cd ../..
fi

read -p "install coc-tsserver ? (Y/N): " IS_INSTALL_COC_TSSERVER
if [ $IS_INSTALL_COC_TSSERVER == "Y" ]; then
  nvim -c CocInstall coc-tsserver -c q! .
fi

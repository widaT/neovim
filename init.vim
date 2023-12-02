set nu " 设置行号

set nocompatible " 兼容

" set incsearch " 开启实时搜索
" set hlsearch " 开启高亮搜索
set ignorecase " 搜索时大小写不敏感

filetype plugin indent on

" 背景透明
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg

syntax on " 高亮

set showcmd " 输入命令显示

set backspace=indent,eol,start

set mouse="" " 禁止鼠标

set tabstop=4 " 设置tab长度为4空格
set softtabstop=4
set shiftwidth=4
set expandtab

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' "
Plug 'preservim/nerdtree'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'
Plug 'buoto/gotests-vim'
Plug 'rust-lang/rust.vim'
call plug#end()



colorscheme gruvbox
set background=dark

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-l> :NERDTreeFind<CR>
nnoremap <C-t> :TagbarToggle<cr>

inoremap <leader>w <Esc>:w<cr>
noremap <leader>w :w<cr>

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" auto import when save
autocmd BufWritePre *.go !silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufWritePre *.go !silent call CocAction('format')

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:ale_set_highlights = 1
let g:ale_set_quickfix = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap <C-E> <Plug>(ale_next_wrap)
nmap <Leader>d :ALEDetail<CR>
let g:ale_linters_ignore = {
\ 'go': ['golint'],
\ }

let g:Lf_ShortcutF = '<C-P>'
nnoremap <silent> <leader>f :Leaderf rg --current-buffer -F <C-R><C-W><CR>
nnoremap <silent> <leader>g :Leaderf rg -F <C-R><C-W><CR>
set cursorline " 设置光标所在的行高亮
set cursorcolumn " 设置光标所在的列高亮
autocmd FileType proto set shiftwidth=2 | set expandtab | set tabstop=2 | set softtabstop=2

imap <silent><script><expr> <F2> copilot#Accept("")
set clipboard+=unnamedplus

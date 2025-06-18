syntax on
set nocompatible
filetype on
filetype plugin on
set number
set nobackup
set expandtab
set tabstop=4
set shiftwidth=4
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set termwinsize=30x200
set mouse=a
set encoding=UTF-8
set guifont=RobotoMono\ Nerd\ Font\ 11

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.
call plug#begin('~/.vim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'dense-analysis/ale' 
    Plug 'prabirshrestha/vim-lsp'
    Plug 'rhysd/vim-lsp-ale'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'wadackel/vim-dogrun'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'voldikss/vim-floaterm'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'euclio/vim-markdown-composer'
call plug#end()



" }}}
colorscheme dogrun
hi Normal guibg=NONE ctermbg=NONE
highlight ALEWarning ctermfg=Black
highlight ALEWarning ctermbg=86

highlight ALEError ctermbg=DarkRed
highlight ALEError ctermfg=Black

" MAPPING ---------------------------------------------------------------- {{{  

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap ff    <C-f>
nnoremap <C-S-j> :!javac *.java --Xlint:unchecked --Xlint:rawtypes
nnoremap <silent> <C-t> :belowright terminal ++rows=15<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-S-P> :ComposerStart<CR>

inoremap <S-Tab> <C-d>
inoremap <Tab> <C-t>
inoremap <expr> <C-m> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
inoremap <C-w> <esc><C-W>wi
inoremap <C-S-P> <esc> :ComposerUpdate <CR> i
tnoremap <Esc><Esc> <C-w><S-n>
" }}}

" vim-lsp ---------------------------------------------------------------- {{{
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
"}}}

let g:airline_theme='onedark'
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
let g:markdown_composer_autostart = 0

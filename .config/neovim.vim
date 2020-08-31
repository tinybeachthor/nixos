set shell=/bin/sh

let mapleader = "\<space>"
let maplocalleader = "\<space>"

" escapes
imap jw <Esc>
imap wj <Esc>

" marks
nnoremap <S-m> `

" Terminal ---------------------- {{{

" No linenumbers in terminal
au TermOpen * setlocal nonumber norelativenumber
" Autoinsert mode
autocmd BufEnter term://* startinsert
autocmd BufLeave term://* stopinsert
" Open, close, switch window, open in tab, switch tab
nnoremap <leader>tv :vs<CR>:terminal<CR>i
nnoremap <leader>ts :sp<CR>:terminal<CR>i
"nnoremap <leader>tt :tabedit<CR>:terminal<CR>i

tnoremap <C-q> <C-\><C-n>:bdelete!<CR>
tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>

" }}}

" Netrw ---------------------- {{{

let g:netrw_preview   = 1
let g:netrw_liststyle = 2
let g:netrw_winsize   = 20
let g:netrw_banner    = 0
let g:netrw_altv      = 1
let g:netrw_list_hide = netrw_gitignore#Hide() . '.*\.swp$,.*\.un\~$,.git/$'

" }}}

nnoremap <leader><S-a> :<C-u>Back<space>

" Vim basic settings ---------------------- {{{

set encoding=utf-8
" Setup undofiles
set nobackup undofile
" check for external file changes when editing stops
au CursorHold,CursorHoldI * checktime
" Set numbers, scrolloffset
set ruler number relativenumber
set scrolloff=999
set autoindent smartindent
set tabstop=2 shiftwidth=2
set softtabstop=-1 shiftround expandtab
set cursorline
set cc=80
" window behaviour
set splitright splitbelow
set switchbuf="vsplit"
" show matching paren on closing for n 10ths of second
set showmatch matchtime=1
" don't jump to begginning of line on page jumps
set nostartofline
" highlight search, incremental search
if &t_Co > 2 || has("gui_running")
    set hlsearch incsearch
endif
" enable syntax
syntax on
filetype on
filetype plugin indent on

" fuzzy
set path+=**
set wildmenu

" }}}

" Look & Feel ---------------------- {{{

" terminal color normalization fixes
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Sign bar (git + marks)
let g:gitgutter_override_sign_column_highlight = 0
let g:SignatureMarkerTextHLDynamic = 1

" colorscheme
set background=dark
let g:neosolarized_contrast = "high"
let g:neosolarized_visibility = "low"
let g:neosolarized_underline = 0
colorscheme NeoSolarized

" Airline
set noshowmode " Hide mode indicator - included in airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
let g:airline_section_z = '%3p%% %3l/%L:%3v'

" }}}

" Key mappings ---------------------- {{{

" write all
nnoremap <silent> <C-S> :<C-U>wa<CR>

" close current
fun! CloseCurrent()
    " let ntabs = call tabpagenr('$')
    " let nwins = call winnr('$')
    if &readonly || @% == "" || &buftype == 'nofile'
        :execute ':q'
    else
        :execute ':wq'
    endif
endfun
nnoremap <silent> <C-c> :<C-u>call CloseCurrent()<CR>
" close all auxiliary windows (quickfix, help, loclist, preview)
nnoremap <silent> <C-q> :<C-u>cclose<CR>:helpclose<CR>:lclose<CR>:pclose<CR>

" focus quickfix
nnoremap <silent> <leader>q :<C-u>copen<CR>

" Edit new file
nnoremap <leader>nn :<C-U>e<SPACE>
nnoremap <leader>ns <C-w><C-s>:<C-U>e<SPACE>
nnoremap <leader>nv <C-w><C-v>:<C-U>e<SPACE>
nnoremap <leader>nt :<C-U>tabedit<SPACE>

" cycle windows
fun! NextBufferWindow()
    let last = winnr('$')
    let current = winnr()
    let new = current + 1
    while new <= last
      " if not a special window
      if (getwinvar(new, '&syntax') != 'qf')
        execute new.'wincmd w'
        return
      endif
      let new = new + 1
    endwhile
    let new = 1
    while new <= current
      " if not a special window
      if (getwinvar(new, '&syntax') != 'qf')
        execute new.'wincmd w'
        return
      endif
      let new = new + 1
    endwhile
endfun
nnoremap <silent> <TAB> :<C-u>call NextBufferWindow()<CR>
nnoremap <silent> <C-TAB> <C-w><C-w>

" switch buffer
nnoremap <silent> <C-N> :w<CR>:bnext<CR>
nnoremap <silent> <C-P> :w<CR>:bprevious<CR>
" delete buffer + move to next
fun! BufferDeleteCurrent()
    if &readonly
        execute 'bprevious'
        execute 'bd#'
    else
        execute 'w'
        execute 'bprevious'
        execute 'bd#'
    endif
endfun
nnoremap <silent> <C-X> :call BufferDeleteCurrent()<CR>
" choose buffer
nnoremap <Leader>b :set nomore<Bar>:ls<Bar>:set more<CR>:b<Space>

" Use <C-L> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Search and Replace
nnoremap <Leader>sr :%s//g<Left><Left>

nnoremap Q @q

" Shift view by 5 lines
nnoremap <C-E> <C-E><C-E><C-E><C-E><C-E>
inoremap <C-E> <C-O><C-E><C-O><C-E><C-O><C-E><C-O><C-E><C-O><C-E>
nnoremap <C-Y> <C-Y><C-Y><C-Y><C-Y><C-Y>
inoremap <C-Y> <C-O><C-Y><C-O><C-Y><C-O><C-Y><C-O><C-Y><C-O><C-Y>

" }}}

" Clear all registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Filetype specific---------------------- {{{

" vim
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal tabstop=4 shiftwidth=4 cc=0
augroup END
" gitcommit
augroup filetype_gitcommit
    autocmd!
    autocmd FileType gitcommit setlocal tw=72 spell wrap
augroup END
" vimwiki
augroup filetype_vimwiki
    autocmd!
    autocmd FileType vimwiki setlocal tw=72 spell wrap cc=120
augroup END
" markdown
augroup filetype_markdown
    autocmd!
    autocmd FileType markdown setlocal tw=72 spell wrap cc=120
augroup END
" SQL
let g:omni_sql_no_default_maps = 1
" Assembly
augroup filetype_asm
    autocmd!
    autocmd FileType asm setlocal tabstop=4 shiftwidth=4 noexpandtab
    autocmd FileType asm setlocal commentstring=#\ %s
augroup END
" Clojure
augroup filetype_clojure
    autocmd!
    autocmd VimEnter *.clj RainbowParenthesesToggle
    autocmd Syntax clojure RainbowParenthesesLoadRound
    autocmd Syntax clojure RainbowParenthesesLoadSquare
    autocmd Syntax clojure RainbowParenthesesLoadBraces
augroup END
" Java
augroup filetype_java
    autocmd!
    autocmd FileType java setlocal tabstop=4 shiftwidth=4 cc=120
augroup END

" }}}

" disable moving parentheses - detects '<' as a start of sequence in insert mode
let g:AutoPairsMoveCharacter=""

" don't open lines with comments
" don't insert comment leader in insert mode
" remove comment leader on join
augroup global
    autocmd!
    autocmd FileType * set formatoptions=jcql
augroup END

" CoC ---------------------- {{{

" integrate with arline
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

set hidden
set cmdheight=2
set updatetime=250
set signcolumn=yes

" use <tab> for trigger completion and navigate next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <C-x><C-o> to complete 'word', 'emoji' and 'include' sources
imap <silent> <C-x><C-o> <Plug>(coc-complete-custom)

" close completion window on done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show signature help while editing
autocmd CursorHoldI * silent! call CocActionAsync('showSignatureHelp')
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for format selected region
vmap <leader>cf <Plug>(coc-format-selected)
nmap <leader>cf <Plug>(coc-format-selected)

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" enable symbol highlighting
autocmd CursorHold * silent call CocActionAsync('highlight')
" set symbol highlight color
highlight CocHighlightText cterm=bold ctermfg=Yellow gui=bold guifg=#ff8229

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function',\'\')}

" Keymappings

" Remap for format selected region
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

nnoremap <silent> <leader>d  :<C-u>CocAction<CR>

nnoremap <silent> <leader>ca  :<C-u>CocList actions<CR>
nnoremap <silent> <leader>cv  :<C-u>CocList vimcommands<CR>
nnoremap <silent> <leader>cc  :<C-u>CocList cmdhistory<CR>
nnoremap <silent> <leader>cr  :<C-u>CocList mru<CR>

" }}}

" FZF ---------------------- {{{

nnoremap <leader><leader> :FZF<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | call fzf#run({'sink': 'e'}) | endif

" An action can be a reference to a function that processes selected lines
function! s:load_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
  \ 'ctrl-l': function('s:load_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" }}}

" Buffers ---------------------- {{{

nmap <silent> <leader>1 <Plug>AirlineSelectTab1
nmap <silent> <leader>2 <Plug>AirlineSelectTab2
nmap <silent> <leader>3 <Plug>AirlineSelectTab3
nmap <silent> <leader>4 <Plug>AirlineSelectTab4
nmap <silent> <leader>5 <Plug>AirlineSelectTab5
nmap <silent> <leader>6 <Plug>AirlineSelectTab6
nmap <silent> <leader>7 <Plug>AirlineSelectTab7
nmap <silent> <leader>8 <Plug>AirlineSelectTab8
nmap <silent> <leader>9 <Plug>AirlineSelectTab9
nmap <silent> <leader>0 <Plug>AirlineSelectTab10

" switch to last buffer
nnoremap <silent> <Leader>- :b#<CR>

nmap <silent> <leader>v1 <C-w><C-v><Plug>AirlineSelectTab1
nmap <silent> <leader>v2 <C-w><C-v><Plug>AirlineSelectTab2
nmap <silent> <leader>v3 <C-w><C-v><Plug>AirlineSelectTab3
nmap <silent> <leader>v4 <C-w><C-v><Plug>AirlineSelectTab4
nmap <silent> <leader>v5 <C-w><C-v><Plug>AirlineSelectTab5
nmap <silent> <leader>v6 <C-w><C-v><Plug>AirlineSelectTab6
nmap <silent> <leader>v7 <C-w><C-v><Plug>AirlineSelectTab7
nmap <silent> <leader>v8 <C-w><C-v><Plug>AirlineSelectTab8
nmap <silent> <leader>v9 <C-w><C-v><Plug>AirlineSelectTab9
nmap <silent> <leader>v0 <C-w><C-v><Plug>AirlineSelectTab10

nmap <silent> <leader>s1 <C-w><C-s><Plug>AirlineSelectTab1
nmap <silent> <leader>s2 <C-w><C-s><Plug>AirlineSelectTab2
nmap <silent> <leader>s3 <C-w><C-s><Plug>AirlineSelectTab3
nmap <silent> <leader>s4 <C-w><C-s><Plug>AirlineSelectTab4
nmap <silent> <leader>s5 <C-w><C-s><Plug>AirlineSelectTab5
nmap <silent> <leader>s6 <C-w><C-s><Plug>AirlineSelectTab6
nmap <silent> <leader>s7 <C-w><C-s><Plug>AirlineSelectTab7
nmap <silent> <leader>s8 <C-w><C-s><Plug>AirlineSelectTab8
nmap <silent> <leader>s9 <C-w><C-s><Plug>AirlineSelectTab9
nmap <silent> <leader>s0 <C-w><C-s><Plug>AirlineSelectTab10

" split with last buffer
nnoremap <silent> <Leader>v- :vsplit<CR>:b#<CR>
nnoremap <silent> <Leader>s- :split<CR>:b#<CR>

" }}}

let g:local_config_dir = $HOME . "/.config/nvim/"

nnoremap <silent> <leader>ev :<C-U>e ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>ec :<C-U>e ~/.config/nvim/coc-settings.json<CR>

" source local config, if exists
" leave at the end so defaults can be overridden
if filereadable(local_config_dir . "init.vim")
    execute "source " . g:local_config_dir . "init.vim"
endif

" re-source configuration
nnoremap <leader>sv :<C-U>source ~/.config/nvim/init.vim<CR>:nohlsearch<CR>

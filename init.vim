"***************************************************************************
" Vim-Plug core
"***************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,elixir,elm,go,haskell,html,javascript,python,rust,scala,typescript"
let g:vim_bootstrap_editor = "nvim"             " nvim or vim
let g:coc_global_extensions = ['coc-eslint', 'coc-highlight', 'coc-pairs', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-yaml']

" terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

if !filereadable(vimplug_exists)
        if !executable("curl")
                echoerr "You have to install curl or first install vim-plug yourself!"
                execute "q!"
        endif
        echo "Installing Vim-Plug..."
        echo ""
        silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        let g:not_finish_vimplug = "yes"

        autocmd VimEnter * PlugInstall
endif

" Load vim-plug plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/zhou13/vim-easyescape.git'         " Escape with jk or kj
Plug 'https://github.com/justinmk/vim-dirvish.git'          " Path navigator plugin
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " Show what keys using <leader>,
Plug 'junegunn/fzf', { 'do': './install --bin' }            " Fuzzy file search
Plug 'junegunn/fzf.vim'                                     " Fuzzy file search vim
Plug 'Yggdroot/indentLine'                                  " Add indentation lines
Plug 'sbdchd/neoformat'

" Language Support
" ----------------

" Language Specific Plugins
" -------------------------
" c
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'

" elixir
Plug 'elixir-lang/vim-elixir'
Plug 'carlosgaldino/elixir-snippets'

" elm
Plug 'elmcast/elm-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense Engine

" go
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

" haskell
Plug 'eagletmt/neco-ghc'
Plug 'dag/vim2hs'
Plug 'pbrisbin/vim-syntax-shakespeare'

" html
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'

" javascript
Plug 'jelera/vim-javascript-syntax'

" python
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

" rust
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'

" scala
if has('python')
        " sbt-vim
        Plug 'ktvoelker/sbt-vim'
endif

" vim-scala
Plug 'derekwyatt/vim-scala'

" typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'

" terraform
Plug 'hashivim/vim-terraform'

" Appearance
" ----------
Plug 'https://github.com/arcticicestudio/nord-vim.git'          " Nord theme
Plug 'https://github.com/vim-airline/vim-airline.git'           " Statusline
Plug 'https://github.com/vim-airline/vim-airline-themes.git'    " Statusline theme
Plug 'https://github.com/ryanoasis/vim-devicons.git'            " Icons

call plug#end()

set encoding=utf-8
scriptencoding utf-8

syntax enable               " Enable text highlighting
colorscheme nord            " Set colour palette

set laststatus=2            " Always show status line


set tabstop=4               " Tab size in units of columns
set expandtab               " Convert tabs to spaces in insert mode
set softtabstop=4           " Number of columns to use when tab is hit
set shiftwidth=4            " Number of columns used when reindent and indent are used
set smarttab

set cursorline              " Highlight the current line
set colorcolumn=80          " Shows a vertical line at the specified column number
set wildmenu                " Visual autocomplete for command menu

set showbreak=↪\
set list listchars=tab:→\ ,nbsp:␣,extends:…,precedes:…,trail:×

set number relativenumber   " Contextually toggle between relative and actual line numbers

augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" coc nvim START
" --------------

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" coc nvim END
" ------------

" Vim easy escape
" ---------------
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>



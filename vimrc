" Disable compatible mode
set nocompatible

" Set language
set langmenu=en_US.UTF-8
if has("win32")
  language en
endif

" Apply defaults everyone wants
source $VIMRUNTIME/vimrc_example.vim

" Vundle for plugin management
" Install if not present
" IMPORTANT: works in CLI version only.
cd $HOME
let i_have_vundle=1
let vundle_readme=expand('.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p .vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim .vim/bundle/Vundle.vim
  let i_have_vundle=0
endif

" Automatic plugin installation
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/.vim/bundle/')
Plugin 'VundleVim/Vundle.vim'             "Plugin manager
Plugin 'run2cmd/ide.vim'                  "Main vimrc configuration
Plugin 'ctrlpvim/ctrlp.vim'               "Buffer Control
Plugin 'sgur/ctrlp-extensions.vim'        "Extensions for CtrlP (Yankring)
Plugin 'vifm/neovim-vifm'                 "Vim like File explorer integration
Plugin 'w0rp/ale'                         "Syntax Checker
Plugin 'rodjek/vim-puppet'                "Puppet syntax support
Plugin 'tpope/vim-fugitive'               "git support
Plugin 'mhinz/vim-signify'                "VCS differences in sign column
Plugin 'tpope/vim-unimpaired'             "Quick switch over mappings
Plugin 'tpope/vim-surround'               "Easy surround changes
Plugin 'tpope/vim-dispatch'               "Run async commands
Plugin 'airblade/vim-rooter'              "Change root to .git directory
Plugin 'ludovicchabant/vim-gutentags'     "Generate c-tags
Plugin 'lifepillar/vim-mucomplete'        "Completeion Engine
Plugin 'godlygeek/tabular'                "auto tab
Plugin 'plasticboy/vim-markdown'          "Support for markdown docs
Plugin 'Yggdroot/indentLine'              "Indent line
Plugin 'gilsondev/searchtasks.vim'        "Search tasks: TODO, FIXME, etc.
Plugin 'tpope/vim-endwise'                "Auto end functions
Plugin 'sukima/xmledit'                   "Xml support
Plugin 'aklt/plantuml-syntax'             "PlantUML support
if i_have_vundle == 0
  echo "Installing Vundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif
call vundle#end()

" Enable filetype for autocmd
filetype plugin indent on

" Source main config file for windows
if has("win32")
  " Fix for vimdiff on windows
  set diffexpr=MyDiff()
  function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        if empty(&shellxquote)
          let l:shxq_sav = ''
          set shellxquote&
        endif
        let cmd = '"' . $VIMRUNTIME . '\diff"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
      let &shellxquote=l:shxq_sav
    endif
  endfunction
endif

" Set files and directories
set directory=~/.vim/tmp
set backupdir=~/.vim/backup
set viminfo+='1000,n~/.vim/viminfo

" Enable syntax higlight
syntax on

" Set background
set background=dark

" Disable visual bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Reread file if was changed
set autoread

" Enable better histroy
set history=1000

" Make sure that we confirm on unsaved files
set confirm

" Better lists
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Max tab pages
set tabpagemax=50

" Make sure that undofiles are not scatterd
set undodir=~/.vim/undofiles

" Make sure that GVim is in English
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Work mostly on unix files
set fileformat=unix
set fileformats=unix,dos

" Set font for Gvim
set guifont=Consolas:h10

" Disable gvim menus ant toolbars
set guioptions-=m
set guioptions-=T
set guioptions-=t
set guioptions-=r
set guioptions-=L

" Tab names
set guitablabel=%F
set tabline=%F

" Search options
set hlsearch
set incsearch

" Setup encoding for cygwin mostly
setglobal fileencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8

" Improve backspace
set backspace=indent,eol,start

" Set update to get faster results with plugins (default i 14400 = 4sec)
set updatetime=250

" Display completion matches in statusline
set wildmenu

" Set path to look into all subdirectories
set path+=**

" Auto line wrapping
set tw=220

" Delete comment character when joining commented lines
set formatoptions+=j

" Line numbers
set number

" Set standard textwidth
set textwidth=220

" Always show one line blow/above cursor
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Tab config
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Lets go PRO. No Arrows movements.
nnoremap <Up>    <C-W><C-K>
nnoremap <Down>  <C-W><C-J>
nnoremap <Left>  <C-W><C-H>
nnoremap <Right> <C-W><C-L>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" Syntax Highlight sync
autocmd BufEnter * :syntax sync fromstart

" Shortcuts
nnoremap gc :%s/\s\+$//<CR>:noh<CR>
nnoremap go :tabnew<CR>

" QuickFixWindow
autocmd QuickFixCmdPost [^l]* copen 10
autocmd QuickFixCmdPost    l* lopen 10

" netrw configuratoin
"nnoremap tf :Explore<CR>
let g:netrw_fastbrowse     = 0
let g:netrw_banner         = 0
let g:netrw_preview        = 1
let g:netrw_winsize        = 25
let g:netrw_altv           = 1
let g:netrw_fastbrowse     = 2
let g:netrw_keepdir        = 0
let g:netrw_liststyle      = 1
let g:netrw_retmap         = 1
let g:netrw_silent         = 1
let g:netrw_special_syntax = 1

" Session manager
set sessionoptions-=blank
map <F2> :mksession! ~/.vim/vim_session <cr>
map <F3> :source ~/.vim/vim_session <cr>

" Turn on omni-completion
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest,menuone,noinsert,noselect
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowAccess = 1
set shortmess+=c
" Disable to scan inlucdes and tags since it tends to work very slow
set complete-=i
set complete-=t

" Set colorscheme
colorscheme bugi
"colorscheme torte

" MUcomplete
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {
      \ 'default' : ['path', 'omni', 'keyn', 'keyp', 'c-n', 'c-p', 'uspl', 'tags' ],
      \ 'vim' : [ 'path', 'cmd', 'keyn', 'keyp' ],
      \ 'puppet' : [ 'path', 'omni', 'keyn', 'keyp', 'tags', 'c-n', 'c-p', 'uspl', 'ulti' ],
      \ 'python' : [ 'path', 'omni', 'keyn', 'keyp', 'c-n', 'c-p', 'uspl', 'ulti', 'tags' ],
      \ 'ruby' : [ 'path', 'omni', 'keyn', 'keyp', 'c-n', 'c-p', 'uspl', 'ulti', 'tags' ],
      \ }

" CtrlP
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:15,results:30'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
\ 'dir':  '\.git$\|\.svn$\|\.hg$\|\.yardoc$\|node_modules\|spec\\fixtures\\modules$',
\ }
nnoremap <C-y> :CtrlPYankring<CR>

" vim-puppet
" Disable => autointent
let g:puppet_align_hashes = 0

" Ale checker
" Does not support puppet options yet, so need to setup '--no-140chars-check' in  ~/.puppet-lint.rc
let g:ale_echo_msg_format = '[%linter%][%severity%][%code%] %s'
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_eruby_erubylint_options = "-T '-'"
if has("win32")
  let g:ale_ruby_rubocop_options = '-c %USERPROFILE%\.rubocop.yaml'
else
  let g:ale_ruby_rubocop_options = '-c ~/.rubocop.yaml'
endif
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
nmap <silent> gj <Plug>(ale_previous_wrap)
nmap <silent> gk <Plug>(ale_next_wrap)
" Custom Ale Linter
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? 'OK' : printf(
  \   '%dW %dE',
  \   all_non_errors,
  \   all_errors
  \)
endfunction

" Disable folding for .md files
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

" Tags
let g:gutentags_cache_dir = '~/.vim/tags'
let g:gutentags_exclude_project_root = ['fixtures']

" Tabular vim
nnoremap gp :Tab/=><CR>

" Vim-rooter
let g:rooter_silent_chdir = 1

" Fila Explorer
nnoremap <F6> :edit %:p:h<CR>

" Filetype support
autocmd BufNewFile,BufReadPost *.rb setlocal tabstop=2 shiftwidth=2
autocmd BufNewFile,BufReadPost Gemfile* setlocal tabstop=2 shiftwidth=2 filetype=ruby syntax=ruby
autocmd BufNewFile,BufReadPost *.todo setlocal textwidth=1000
autocmd BufNewFile,BufReadPost *Jenkinsfile* setlocal tabstop=4 shiftwidth=4 syntax=groovy filetype=groovy
autocmd BufNewFile,BufReadPost *Vagrantfile* setlocal tabstop=2 shiftwidth=2 syntax=ruby filetype=ruby
autocmd BufNewFile,BufReadPost *.xml setlocal tabstop=2 shiftwidth=2 syntax=xml filetype=xml
autocmd BufNewFile,BufReadPost *.groovy setlocal tabstop=4 shiftwidth=4 syntax=groovy filetype=groovy
autocmd BufNewFile,BufReadPost *.gradle setlocal tabstop=4 shiftwidth=4 syntax=groovy filetype=groovy
autocmd BufNewFile,BufReadPost *.yaml setlocal tabstop=2 shiftwidth=2 syntax=yaml filetype=yaml
autocmd BufNewFile,BufReadPost *.yml setlocal tabstop=2 shiftwidth=2 syntax=yaml filetype=yaml
autocmd BufNewFile,BufReadPost *.bat setlocal tabstop=2 shiftwidth=2 ff=dos
autocmd BufNewFile,BufReadPost *.md setlocal textwidth=80

" Run Tests with vim-dispatch
autocmd Filetype ruby let b:dispatch = "bash.exe --login -c \"echo '%' \| tr -s '\\' '/' \| xargs -i rspec {}\""
autocmd Filetype groovy let b:dispatch = 'gradlew clean test build --info'
autocmd Filetype xml let b:dispatch = 'mvn clean install -f % -DskipTests'
autocmd Filetype uml,plantuml,pu let b:dispatch = 'plantuml %'
autocmd Filetype yaml,yml let b:dispatch = "bash.exe --login -c \"ansible-lint '%'\""
" Require Putty jenkins-lint profile setup
autocmd BufNewFile,BufReadPost Jenkinsfile let b:dispatch = "type % | plink -batch -load jenkins-lint declarative-linter"
nnoremap <F7> :Dispatch<CR>
" Move quickfix window to very bottom
autocmd FileType qf wincmd J

" Ruby change syntaxt to 2.1
nnoremap <F8> :%s/\(\w*\)[ ]*=>/\1:/gc<CR>

" Set status line
set laststatus=2
set statusline=
set statusline+=%F\ %y[%{&ff}]
set statusline+=[%{strlen(&fenc)?&fenc:&enc}a]
set statusline+=\ %h%m%r%w
set statusline+=\ [Ale(%{LinterStatus()})]
set statusline+=%<\ %{fugitive#statusline()}
set statusline+=\ [%l,%c/%L]

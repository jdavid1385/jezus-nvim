" This configuration uses both CommandT and CtrlP, the latter being used
" solely by the fact of bringing a better styled "jump to tag (a.k.a :tjump)
set nocompatible      " We're running Vim, not Vi!
set hidden
set encoding=utf-8

" Let VIM shine bright :)
source ~/.vim/Plugins.vim

if has('python3')
  set pyxversion=3
endif

if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
  let g:CtrlSpaceGlobCommand = 'rg --color=never --files'
elseif executable("ag")
  let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

" Color scheme stuff. You have two fairly good options, make your pick!
set background=dark
" colorscheme monokai

" A good color scheme composed of two XD
" colorscheme morning
" colorscheme gruvbox

let g:gruvbox_italic = 1

colorscheme elly
let g:airline_theme='elly'
"
set termguicolors

" Airline stuff
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" let g:airline_theme = 'molokai'
" let g:airline_theme='alduin'

" this was taking ages on big files
let g:easytags_auto_highlight = 0
" https://github.com/neovim/neovim/issues/4930
set re=1

" Bookmarks per working directory
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

"let NERDTreeShowBookmarks=1
"Ignored file types list
" Setting Solargraph as the autocompletion server
" [[For stdio communication]]
"let g:LanguageClient_serverCommands = {
           "\ 'ruby': [ 'solargraph',  'stdio' ],
           "\ }

" [[For socket communication]] Tell the language client to use the default IP and port
" that Solargraph runs on

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['tcp://localhost:7658']
    \ }

" Don't send a stop signal to the server when exiting vim.
let g:LanguageClient_autoStop = -1

source ~/.vim/Global.vim
source ~/.vim/Bindings.vim


" WhichKey
nnoremap <silent> <leader> :WhichKey ',' <CR>
set timeoutlen=500
" let NERDTreeIgnore = ['\.git$']
"Allow nerdtree to change cwd

let g:NERDTreeChDirMode=2

let g:CommandTMatchWindowAtTop=0
let g:CommandTMaxHeight=10
let g:CommandTMinHeight=10

" At this point I am not sure this makes any sense, try disabling it and check
" if the tags behave the same, we still need to stabilize the setup and some
" experimenting is still needed
let g:easytags_dynamic_files = 1
let g:easytags_on_cursorhold = 1
let g:easytags_updatetime_min = 4000
let g:easytags_auto_update = 1
let g:easytags_async = 1

" I am pretty confident we are not using ruby complete for anything, but until I
" can make sure this stays here
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_load_gemfile = 1

" Gundo tree won't work with the default setup of macvim with +python3 -python
let g:gundo_prefer_python3 = 1

" CtrlP-tjump settings
let g:ctrlp_tjump_shortener = ['/home/.*/gems/', '.../']

let g:ctrlp_tjump_skip_tag_name = 1
let g:ctrlp_tjump_only_silent = 1

" Side search
"
" How should we execute the search?
" --heading and --stats are required!

" ag --word-regexp --ignore={'*.js.map','gems.tags','tags','*.csv'} --heading --stats -B 1 -A 4 operations.rb $(find . -name "Gemfile" -type f -exec sh -c 'cd $(dirname $1) && bundle _1.17_ >/dev/null 2>&1 && bundle _1.17_ show --paths' -- {} \;) $(pwd)
let g:side_search_prg = 'ag --word-regexp'
  \. " --ignore={'*.js.map','gems.tags','tags','*.csv'}"
  \. " --heading --stats -B 1 -A 4"
" \. \"$(find . -name \"Gemfile\" -type f -exec sh -c 'cd $(dirname $1) && bundle _1.17_ >/dev/null 2>&1 && bundle _1.17_ show --paths' -- {} \;) $(pwd)"
" Can use `vnew` or `new`
let g:side_search_splitter = 'vnew'
" I like 40% splits, change it if you don't
let g:side_search_split_pct = 0.4
let ruby_fold = 1
set tags+=gems.tags
" let g:SuperTabLongestHighlight = 1



autocmd FileType html setlocal omnifunc=emoji#complete
autocmd FileType html call deoplete#custom#option('auto_complete', v:true)
" autocmd FileType ruby setlocal omnifunc=syntaxcomplete#Complete
" set completefunc=LanguageClient#complete
" Set ripper-tags for updating the tags on save
" autocmd BufWritePost *.rb !ripper-tags -R --exclude=vendor
"let g:gutentags_ctags_executable_ruby = 'rtags'
let g:gutentags_ctags_executable_ruby = 'ripper-tags -R --fields=+n --exclude=vendor' 
let g:gutentags_trace = 1
" Command-T max files increased
let g:CommandTMaxFiles=80000

set redrawtime=10000
" set autochdir
"autocmd FileType ruby let &l:tags = pathogen#legacyjoin(pathogen#uniq(
"      \ pathogen#split(&tags) +
"      \ map(split($GEM_PATH,':'),'v:val."/gems/*/tags"')))
"
" .Net# Stuff
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
let g:OmniSharp_highlight_types = 2

" quick fix preview window in popup
augroup qfpreview
    autocmd!
    autocmd FileType qf nmap <buffer> p <plug>(qf-preview-open)
augroup END

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

function SetCSSettings()
"     Use deoplete.
     call deoplete#enable()
 "    Use smartcase.
     call deoplete#custom#option('smart_case', v:true)
  "   Use OmniSharp-vim omnifunc 
     call deoplete#custom#source('omni', 'functions', { 'cs':  'OmniSharp#Complete' })
   "  Set how Deoplete filters omnifunc output.
     call deoplete#custom#var('omni', 'input_patterns', {
        \ 'cs': '[^. *\t]\.\w*',
        \})

     call deoplete#custom#option('auto_complete', v:false)
endfunction

function SetRubySettings()
"     Use deoplete.
     call deoplete#enable()
  "   Use OmniSharp-vim omnifunc 
     call deoplete#custom#source('omni', 'functions', { 'ruby':  'LanguageClient#complete' })
   "  Set how Deoplete filters omnifunc output.
     call deoplete#custom#var('tabnine', {
     \ 'line_limit': 500,
     \ 'max_num_results': 20,
     \ })
     call deoplete#custom#option('auto_complete', v:false)

endfunction

augroup csharp_commands
    autocmd!
    "Use smartcase.
    call deoplete#custom#option('smart_case', v:true) 
    autocmd FileType cs call SetCSSettings()
    autocmd Filetype cs AnyFoldActivate               " activate for all filetypes
    let g:anyfold_fold_comments=1
    set foldlevel=99  " close all folds
augroup END

augroup ruby_commands
    autocmd!
    "Use smartcase.
    autocmd FileType ruby call SetRubySettings()
    autocmd Filetype ruby AnyFoldActivate               " activate for all filetypes
    autocmd FileType ruby let b:codeclimateflags="--engine rubocop"

    " Ruby is an oddball in the family, use special spacing/rules
    if v:version >= 703
      " Note: Relative number is quite slow with Ruby, so is cursorline, fold
      " method=syntax also has some of the fault, https://github.com/vim/vim/issues/282#issuecomment-169837021
      autocmd FileType ruby setlocal ts=2 sts=2 sw=2 norelativenumber nocursorline ttyfast lazyredraw re=1 foldmethod=manual
    else
      autocmd FileType ruby setlocal ts=2 sts=2 sw=2
    endif

    let g:anyfold_fold_comments=1
    set foldlevel=99  " close all folds
augroup END

let g:CommandTTraverseSCM='pwd'

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
nnoremap <Leader>nm :OmniSharpRename<CR>

nnoremap <Leader>os :OmniSharpStartServer<CR>

let g:dbext_default_profile_mySQL = 'type=MYSQL:user=root:passwd=admin:dbname=si_reporting:srvname=dockervm'
let g:vimspector_enable_mappings = 'HUMAN'

" Change airline positions
function! AirlineInit()
  call airline#parts#define_function('zoom', 'zoom#statusline')
  " call airline#parts#define_condition('zoom', 'zoom#statusline() != \"normal\"')
  let g:airline_section_y = airline#section#create_right(['ffenc', 'zoom'])
endfunction

autocmd User AirlineAfterInit call AirlineInit()

let g:qfpreview = {'number': 1, 'sign': {'text': '>>', 'texthl': 'Todo'}}


source $HOME/.config/nvim/plug-config/floaterm.vim
"function! InsertTabWrapper()
    "let col = col('.') - 1
    "if !col || getline('.')[col - 1] !~ '\k'
        "return \"\<tab>"
    "else
        "return \"\<c-x>\<c-o>"
    "endif
"endfunction
"inoremap <expr> <tab> InsertTabWrapper()
"inoremap <s-tab> <c-n>

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

let g:FerretExecutableArguments = {
            \   'rg': "--color=never --hidden --glob '!.git' --ignore-file /Users/jesus.nunez/Scripts/.gitignore --vimgrep --no-heading --no-config --max-columns 4096"
  \ }

" Color scheme stuff. You have two fairly good options, make your pick!
set background=dark
" colorscheme monokai

" A good color scheme composed of two XD
colorscheme morning
colorscheme gruvbox
" this is to be used only when the two above are set
" https://github.com/junegunn/fzf.vim/issues/1179
let $FZF_PREVIEW_COMMAND="BAT_THEME='ansi-dark' bat --style=numbers --highlight-line 1:1 --color=always {}"


let g:gruvbox_italic = 1

" colorscheme elly
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

" let g:LanguageClient_serverCommands = {
"    \ 'ruby': ['tcp://localhost:7658']
"    \ }

" Don't send a stop signal to the server when exiting vim.
"let g:LanguageClient_autoStop = -1

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

function SetRubySettings_Deoplete()
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

function SetRubySettings_NavigatorLua()

    lua<<EOF
  require'navigator'.setup({
  debug = false, -- log output, set to true and log path: ~/.cache/nvim/gh.log
  width = 0.75, -- max width ratio (number of cols for the floating window) / (window width)
  height = 0.3, -- max list window height, 0.3 by default
  preview_height = 0.35, -- max height of preview windows
  border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}, -- border style, can be one of 'none', 'single', 'double',
                                                     -- 'shadow', or a list of chars which defines the border
  on_attach = function(client, bufnr)
    -- your hook
  end,
  -- put a on_attach of your own here, e.g
  -- function(client, bufnr)
  --   -- the on_attach will be called at end of navigator on_attach
  -- end,
  -- The attach code will apply to all LSP clients

  default_mapping = true,  -- set to false if you will remap every key
  keymaps = {{key = "gK", func = "declaration()"}}, -- a list of key maps
  -- this kepmap gK will override "gD" mapping function declaration()  in default kepmap
  -- please check mapping.lua for all keymaps
  treesitter_analysis = true, -- treesitter variable context
  transparency = 50, -- 0 ~ 100 blur the main window, 100: fully transparent, 0: opaque,  set to nil or 100 to disable it

  lsp_signature_help = true, -- if you would like to hook ray-x/lsp_signature plugin in navigator
  -- setup here. if it is nil, navigator will not init signature help
  signature_help_cfg = nil, -- if you would like to init ray-x/lsp_signature plugin in navigator, and pass in your own config to signature help
  icons = {
    -- Code action
    code_action_icon = "🏏",
    -- Diagnostics
    diagnostic_head = '🐛',
    diagnostic_head_severity_1 = "🈲",
    servers = {'solargraph'}
    -- refer to lua/navigator.lua for more icons setups
  }
  })
EOF
endfunction

function SetRubySettings_Coq()
"     Use deoplete.
     let g:coq_settings = { 'auto_start': v:true, 'clients': {'tabnine': {'enabled': v:true}} }

"   Read the config for navigator.lua: https://github.com/ray-x/navigator.lua
    lua << EOF
         local lsp = require "lspconfig"
         local coq = require "coq" -- add this
         lsp.solargraph.setup{}
         lsp.solargraph.setup(coq.lsp_ensure_capabilities())
         vim.lsp.set_log_level("debug")
EOF
endfunction

function SetRubySettings_Coc()
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
    set encoding=utf-8

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
    if has("nvim-0.5.0") || has("patch-8.1.1564")
      " Recently vim can merge signcolumn and number column into one
      set signcolumn=number
    else
      set signcolumn=yes
    endif

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
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
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
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
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
    xmap <leader>aa  <Plug>(coc-codeaction-selected)
    nmap <leader>aa  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Run the Code Lens action on the current line.
    nmap <leader>cl  <Plug>(coc-codelens-action)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
    autocmd FileType ruby call SetRubySettings_Coc()
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

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

augroup MyQuickfixPreview
  au!
  au FileType qf noremap <silent><buffer> p :call quickui#tools#preview_quickfix()<cr>
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

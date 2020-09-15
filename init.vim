" Auto install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  " Auto install all the things
  au VimEnter * PlugInstall
  au VimEnter * LspInstall bashls
  au VimEnter * LspInstall clangd
  au VimEnter * LspInstall gdscript
  au VimEnter * LspInstall html
  au VimEnter * LspInstall jsonls
  au VimEnter * LspInstall pyls
  au VimEnter * LspInstall tsserver
  au VimEnter * LspInstall vimls
endif        

let mapleader = ' '

call plug#begin('~/.config/nvim/plugged')
    " Core stuff, absolute minimum to keep me sane
    Plug 'neovim/nvim-lspconfig'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    let g:completion_enable_auto_hover = 0
    let g:completion_enable_auto_signature = 0
    Plug 'haorenW1025/completion-nvim'

    let g:diagnostic_enable_virtual_text = 0
    let g:diagnostic_show_sign = 1
    Plug 'haorenW1025/diagnostic-nvim'

    " Languages
    Plug 'sheerun/vim-polyglot'  " All the languages
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    Plug 'clktmr/vim-gdscript3', {'for': 'gdscript3'}

    " Hand holding
    let g:ultisnips_python_style = 'google'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    let g:auto_docstring_style = 'google'
    Plug 'ColinKennedy/vim-auto_docstring'

    let g:nord_cursor_line_number_background = 1
    Plug 'arcticicestudio/nord-vim'
call plug#end()

silent! colorscheme nord  " Don't bork if nord is not available

hi EndOfbuffer guifg=bg  " Hide empty line character
hi Over80 guibg=#5b4252
hi Over100 guibg=#7b4252
hi VertSplit guibg=#4c566a
hi LspDiagnosticsError guibg=#4a4252
hi LspDiagnosticsWarning guibg=#4c566a
hi LspDiagnosticsUnderline guibg=#4f4050

set mouse=a
set textwidth=80
set wrapmargin=2
set ignorecase smartcase
set cursorline showtabline=2 noshowmode
set completeopt=menuone,noinsert,noselect
set guicursor=  " Gimme block cursor dammit!
set softtabstop=4 tabstop=4 shiftwidth=4 expandtab
set termguicolors  " Support GUI colors in terminal
set numberwidth=4 number signcolumn=yes
set splitright splitbelow  " Focus new split when created
set fillchars=vert:\  " Don't show vertical split character
set pumblend=25 winblend=12  " Transparent floating windows
set nobackup nowritebackup noswapfile  " Don't create tmp files

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'
"" LSP ------------------------------------------------------------------------
call sign_define("LspDiagnosticsErrorSign",
      \{"text" : "E", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign",
      \{"text" : "W", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign",
      \{"text" : "I", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticHintSign",
      \{"text" : "H", "texthl" : "LspDiagnosticsHint"})
au BufEnter * silent! lua require'completion'.on_attach()

silent ! lua require'nvim_lsp'.vimls.setup{on_attach=require'diagnostic'.on_attach}
silent ! lua require'nvim_lsp'.bashls.setup{on_attach=require'diagnostic'.on_attach}
silent ! lua require'nvim_lsp'.clangd.setup{on_attach=require'diagnostic'.on_attach}
silent ! lua require'nvim_lsp'.gdscript.setup{on_attach=require'diagnostic'.on_attach}
silent ! lua require'nvim_lsp'.tsserver.setup{on_attach=require'diagnostic'.on_attach}
silent ! lua require'nvim_lsp'.html.setup{on_attach=require'diagnostic'.on_attach}
silent ! lua require'nvim_lsp'.cssls.setup{on_attach=require'diagnostic'.on_attach}
silent ! lua require'nvim_lsp'.jsonls.setup{on_attach=require'diagnostic'.on_attach}

" this is a bit much, kinda slow
silent ! lua require'nvim_lsp'.pyls.setup{settings={pyls={plugins={
      \ flake8={enabled=true, import_order_style='google'},
      \ pycodestyle={enabled=true},
      \ pydocstyle={enabled=true},
      \ pylint={enabled=true}
      \ }}},on_attach=require'diagnostic'.on_attach}

nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> td <cmd>lua vim.lsp.buf.type_definition()<cr>
noremap <silent> <c-K> :PrevDiagnostic<cr>
noremap <silent> <c-J> :NextDiagnostic<cr>

au VimResized * wincmd = " automatically evenly resize splits
au Filetype terminal setl nonumber
au Filetype c,cpp,vim,javascript setl softtabstop=2 tabstop=2 shiftwidth=2 expandtab
au Filetype c,cpp,python,sh,javascript,gdscript3 setl omnifunc=v:lua.vim.lsp.omnifunc
au Filetype cpp,c,gdscript3,python,vim,elixir set colorcolumn=80,100 |
      \ call matchadd('Over80',  '\%81v.\+',  100) |
      \ call matchadd('Over100', '\%101v.\+', 100)

" Shortcuts
nnoremap <leader>s :w<cr>
vnoremap <leader>s :sort<cr>
nnoremap <leader>w :q<cr>
nnoremap <leader>1 :e ~/.notes<cr>
nnoremap <leader>0 :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>p :Files<cr>
nnoremap <leader>h :Help<cr>
nnoremap <leader>f :BLines<cr>
nnoremap <leader>r :Rg<cr>
noremap <f5> :setlocal spell! spellang=en_au<cr>

" Visual line movement for wrapped lines
noremap j gj
noremap k gk

" Splits
nnoremap <leader>b :sp<cr>
nnoremap <leader>v :vsp<cr>

" Tabs
noremap <c-t> :tabe<cr>
nnoremap <tab> :tabnext<cr>
nnoremap <s-tab> :tabprevious<cr>

" Vertically shift a visual text block, respect indent
vnoremap K :move '<-2<cr>gv=gv
vnoremap J :move '>+1<cr>gv=gv

" Change indent
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" Don't move in normal mode
nnoremap <space> <nop>

" Clear search highlight with <cr>
nnoremap <cr> :noh<cr>

" Flatten visual text block with F, don't flatten with J in normal mode
vnoremap F :'<.'>j<cr>
nnoremap J <nop>

" Auto install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  " Auto install all the things
  au VimEnter * PlugInstall
  " LspInstall bashls
  " LspInstall clangd
  " LspInstall gdscript
  " LspInstall html
  " LspInstall jsonls
  " LspInstall pyls
  " LspInstall tsserver
  " LspInstall vimls
endif        

let mapleader = ' '

call plug#begin('~/.config/nvim/plugged')
    " Core stuff, absolute minimum to keep me sane
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'haorenW1025/completion-nvim'

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

    Plug 'sbdchd/neoformat'

    let g:nord_cursor_line_number_background = 1
    Plug 'arcticicestudio/nord-vim'
    Plug 'norcalli/nvim-colorizer.lua'

    Plug 'voldikss/vim-floaterm'
call plug#end()

silent! colorscheme nord  " Don't bork if nord is not available

hi EndOfbuffer guifg=bg  " Hide empty line character
hi Over80 guibg=#5b4252
hi Over100 guibg=#7b4252
hi VertSplit guibg=#4c566a
hi LspDiagnosticsUnderlineError guibg=#7b4252
hi LspDiagnosticsUnderlineWarning guibg=#6b5b00
hi LspDiagnosticsUnderlineInformation guibg=#4c566a
hi LspDiagnosticsUnderlineHint guibg=#4c566a
hi LspDiagnosticsSignError guifg=#7b4252
hi LspDiagnosticsSignWarning guifg=#6b5b00
hi LspDiagnosticsSignInformation guifg=#4c566a
hi LspDiagnosticsSignHint guifg=#4c566a

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
" The following lua calls will bork on the first use of this config
au BufEnter * lua require'completion'.on_attach()
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.clangd.setup{}
lua require'lspconfig'.gdscript.setup{}
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.html.setup{}
lua require'lspconfig'.cssls.setup{}
lua require'lspconfig'.jsonls.setup{}

" this is a bit much, kinda slow
lua require'lspconfig'.pyls.setup{settings={pyls={plugins={
      \ flake8={enabled=true, import_order_style='google'},
      \ pycodestyle={enabled=true},
      \ pydocstyle={enabled=true},
      \ pylint={enabled=true}
      \ }}}}

lua vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      \ vim.lsp.diagnostic.on_publish_diagnostics,
      \ {underline=true,virtual_text=false,signs=true})

lua require'colorizer'.setup()

nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> td <cmd>lua vim.lsp.buf.type_definition()<cr>
noremap <silent> <c-K> <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
noremap <silent> <c-J> <cmd>lua vim.lsp.diagnostic.goto_next()<cr>

au VimResized * wincmd = " automatically evenly resize splits
au Filetype terminal setl nonumber
au Filetype c,cpp,vim,javascript setl softtabstop=2 tabstop=2 shiftwidth=2 expandtab
au Filetype html,c,cpp,python,sh,javascript,gdscript3,elixir setl omnifunc=v:lua.vim.lsp.omnifunc
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

noremap <C-s> :FloatermToggle<cr>

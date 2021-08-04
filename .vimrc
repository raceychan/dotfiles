" Core
set nobackup
set nowritebackup
set relativenumber
set hidden
set showmode
set showcmd
set wildmenu
set ttimeoutlen=50

" Hide status
set guioptions-=r
set guioptions-=L
set guioptions-=b

" Formatting
set encoding=UTF-8
set scrolloff=5
set cmdheight=2
set shiftwidth=5
set updatetime=300
set shortmess+=c
set autoindent

" Hilight cursor
set cursorline  

" Hightlight search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Appearance 
set ambiwidth=double
let laststatus = 2
let &t_8f = "\<ESC>[38;2;%lu;%lu;%lum"
let &t_8b = "\<ESC>[48;2;%lu;%lu;%lum"
set termguicolors

autocmd BufWritePost $MYVIMRC source $MYVIMRC
"" ===============================Vim-Plug-Start============================
filetype off       
call plug#begin('~/.vim/plugged')  

" Some Old Stuff To Keep
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'junegunn/fzf.vim'

" Core
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'puremourning/vimspector' " <Leader>b: breakpoint
Plug 'voldikss/vim-floaterm'   " <Leader>tt: floaterm
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' " <Leader> ff
Plug 'akinsho/nvim-bufferline.lua' " bn: next tab, bp: previous tab,  bq: close tab
Plug 'terryma/vim-multiple-cursors' " <C-n> Multi-Cursors
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mbbill/undotree'

" Python
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'vim-python/python-syntax'

" Appearance
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'glepnir/dashboard-nvim'
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" CocExtensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" CocInstall coc-json
" CocInstall coc-pyright
" CocInstall coc-tabnine
" CocInstall coc-git
" CocInstall coc-pairs

call plug#end()            
filetype plugin indent on   
" ===============================vim-plug-end============================


" ============================== Key-Mapping ==============================

" Core KeyMapping
nnoremap ; :
inoremap jk <Esc>
nnoremap <SPACE> <Nop>
let g:mapleader="\<Space>"

nmap gb 0
nmap ge $
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
:nnoremap <Leader>co :copen<CR>
:nnoremap <Leader>cc :cclose<CR>


" CHADtree 
" nnoremap <C-t> :CHADopen <cr>
nnoremap <C-t> :CocCommand explorer <cr>
" nnoremap <leader>l <cmd>call setqflist([])<cr>

" bufferline
" hese commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>bn :BufferLineCycleNext<CR>
nnoremap <silent>bp :BufferLineCyclePrev<CR>
:nnoremap <Leader>qq :bd<CR>
:nnoremap <Leader>q! :bd!<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>
nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>T

" Change vim's working directory. 			 	['b']
" Change vim's working directory. 		  	 	['c']
" Set CHADTree's root one level up. 			 	['C']
" Open file at cursor in vertical split  		 	['w'].
" Set a glob pattern to narrow down visible files. 	 	['f']
" Select files under cursor or visual block. 		 	['s']
" Create new file at location under curso 		 	['a']
" Copy the selected files to location under cursor. 	 	['p']
" Move the selected files to location under cursor. 	 	['x']
" Delete the selected files. Items deleted cannot be recovered. ['d']

" Use CTRL-S for selections ranges.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)


" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Applying codeAction to the selected region.
" Example: <`leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>cca  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>cfc  <Plug>(coc-fix-current)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

" Python mode
xmap <leader>pf :PymodeLintAuto<CR>
nmap <leader>pf :PymodeLintAuto<CR>

" dashboard-keymap
nnoremap <silent> <Leader>fl :Lines<CR>
nnoremap <silent> <Leader>fg :Gfiles<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>fc :Commands<CR>

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

" Float terminal
nmap <Leader>tt :FloatermToggle<CR>
nmap <Leader>tn :FloatermNew<CR>
nmap <Leader>tk :FloatermKill<CR>
nmap <Leader>ts :FloatermSend<CR>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>cla  :<C-u>CocList diagnostics<cr> 
nnoremap <silent><nowait> <leader>cle  :<C-u>CocList extensions<cr>
"" Show commands.
nnoremap <silent><nowait> <leader>clc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>clo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>cj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>ck  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>clr  :<C-u>CocListResume<CR>

" Coc Config.
nnoremap <silent><nowait> <leader>ccf  :<C-u>CocConfig<CR>
" ============================== Key-Mapping ==============================


" ===============================FZF-Config============================

function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')



" appearance
function! s:build_quickfix_list(lines)
     call setqflist(map(copy(a:lines), '{"filename"}: v:val '))
     copen
     cc
endfunction

let g:fzf_action = {
        \ 'ctrl-q': function('s:build_quickfix_list'),
     	\ 'ctrl-t': 'tab split',
	\ 'ctrl-x': 'split',
        \ 'ctrl-s': 'vsplit' }

let g:fzf_commits_log_options = '--graph --color=always --format=%C"auto)(%h%d %s %Cblack(%C)bold(%cr"))"'


" Custom Statusline
function! s:fzf_statusline()
     highlight fzf1 ctermfg=161 ctermbg=251
     highlight fzf2 ctermfg=23 ctermbg=251
     highlight fzf3 ctermfg=237 ctermbg=251
     setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
       
autocmd! User FzfStatusLine call <SID>fzf_statusline()
autocmd FileType json syntax match Comment +\/\/.\+$+
" ===============================FZF-Config============================


" ===============================CocConfig-Start============================

if has("nvim-0.5.0") || has("patch-8.1.1564")
     set signcolumn=number
else
     set signcolumn=yes
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

" Add :Format`` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
"
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ===============================CocConfig-End============================

colorscheme nord
" set background=dark
" SeeThrough Backgound
highlight Normal guibg=NONE ctermbg=None

let g:Powerline_symbols='fancy'
let g:airline_theme='nord'
let g:airline_powerline_fonts=1 
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#branch#enabled=1

let g:pymode_python='python3'
let g:python_highlight_all = 1
let g:vimspector_enable_mappings='HUMAN'

let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_shortcut={
\ 'last_session'       : 'SPC s l',
\ 'find_history'       : 'SPC f h',
\ 'find_file'          : 'SPC f f',
\ 'new_file'           : 'SPC c n',
\ 'change_colorscheme' : 'SPC t c',
\ 'find_word'          : 'SPC f a',
\ 'book_marks'         : 'SPC f b',
\ }

let g:dashboard_custom_header = [
    \'',
     \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣴⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
     \'⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀ ',
     \'⠀⠀⠀⠀⣠⣾⣿⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣶⡀⠀⠀⠀⠀ ',
     \'⠀⠀⠀⣴⣿⣿⠟⠁⠀⠀⠀⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀ ',
     \'⠀⠀⣼⣿⣿⠋⠀⠀⠀⠀⠀⠛⠛⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀ ',
     \'⠀⢸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⡇⠀ ',
     \'⠀⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀ ',
     \'⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⢹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⠀ ',
     \'⠀⣿⣿⣷⠀⠀⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⢻⣿⣿⡄⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀ ',
     \'⠀⢸⣿⣿⡆⠀⠀⠀⠀⣴⣿⡿⠃⠀⠀⠀⠈⢿⣿⣷⣤⣤⡆⠀⠀⣰⣿⣿⠇⠀ ',
     \'⠀⠀⢻⣿⣿⣄⠀⠀⠾⠿⠿⠁⠀⠀⠀⠀⠀⠘⣿⣿⡿⠿⠛⠀⣰⣿⣿⡟⠀⠀ ',
     \'⠀⠀⠀⠻⣿⣿⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠏⠀⠀⠀ ',
     \'⠀⠀⠀⠀⠈⠻⣿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠟⠁⠀⠀⠀⠀ ',
     \'⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀ ',
     \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
     \]

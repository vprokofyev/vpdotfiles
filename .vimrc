"-----------------------------------------------------------------------------
" Init
"-----------------------------------------------------------------------------
set nocompatible
scriptencoding utf-8
set encoding=utf-8
set termencoding=utf-8
set clipboard=unnamedplus
filetype off
set path+=**
" Lets switch with Ctrl-^
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
set rtp+=~/.vim/bundle/Vundle.vim
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
call vundle#begin()
Plugin 'Vundle/Vundle.vim'

"-----------------------------------------------------------------------------
" Plugins
"-----------------------------------------------------------------------------
Plugin 'morhetz/gruvbox'
Plugin 'danilo-augusto/vim-afterglow'
"Plugin 'lifepillar/vim-wwdc16-theme'
Plugin 'rakr/vim-one'
Plugin 'sonph/onehalf'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdcommenter'
Plugin 'jez/vim-superman'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-dadbod'
Plugin 'tpope/vim-markdown'
Plugin 'kristijanhusak/vim-dadbod-ui'
Plugin 'thinca/vim-themis'
Plugin 'tpope/vim-dotenv'
"Plugin 'puremourning/vimspector'
Plugin 'dominikduda/vim_current_word'
"Plugin 'atweiden/vim-dragvisuals'
"Plugin 'nixon/vim-vmath'
"Plugin 'rhysd/open-pdf.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Yggdroot/indentLine'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'machakann/vim-highlightedyank'
Plugin 'rhysd/clever-f.vim'
Plugin 'sickill/vim-pasta.git'
" Syntax Highlighting
Plugin 'chr4/nginx.vim'
Plugin 'nfnty/vim-nftables'
" Some coder stuff
"Plugin 'WolfgangMehner/bash-support'
"Plugin 'WolfgangMehner/c-support'
"Plugin 'pchynoweth/a.vim'
"Plugin 'WolfgangMehner/lua-support'
Plugin 'fatih/vim-go'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
" Plugin 'junegunn/goyo.vim'
Plugin 'preservim/tagbar'
"Plugin 'dense-analysis/ale'
Plugin 'pearofducks/ansible-vim'
Plugin 'andrewstuart/vim-kubernetes'
"Plugin 'neoclide/coc.nvim', { 'branch': 'release' }
Plugin 'fannheyward/coc-pyright'
Plugin 'hashivim/vim-terraform'
call vundle#end()

"-----------------------------------------------------------------------------
" vim_current_word
"-----------------------------------------------------------------------------
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 0
let g:vim_current_word#highlight_delay = 1
let g:vim_current_word#highlight_only_in_focused_windows = 1

"-----------------------------------------------------------------------------
" vim-commentary
"-----------------------------------------------------------------------------
autocmd FileType rs setlocal commentstring=//\ %s

"-----------------------------------------------------------------------------
" Airline
"-----------------------------------------------------------------------------
let g:airline_theme='badwolf'
let g:airline_section_x='%{expand("%:p")}'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_tab_count = 0
" " Enumerate tabs
" let g:airline#extensions#tabline#tab_nr_type = 1
" let g:airline#extensions#tabline#tabs_label = 'desktop'
" let g:airline#extensions#tabline#formatter = 'short_path'
" let g:airline#extensions#tabline#buffer_min_count = 0

"-----------------------------------------------------------------------------
" vim-markdown
"-----------------------------------------------------------------------------
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']


"-----------------------------------------------------------------------------
" Sets
"-----------------------------------------------------------------------------
set scrolloff=7
set timeout timeoutlen=500 ttimeoutlen=500
set smartindent
set hidden
set nohlsearch
set ignorecase
set incsearch
set wildmenu
set showcmd
set noshowmode
set autoread
set list!
set listchars=tab:‣\ ,trail:·,precedes:«,extends:»,eol:¬
set nu
set relativenumber
set ttyfast
set nowrap
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start
set colorcolumn=80
set termwinsize=10x200
set textwidth=80
" Don't format to 79 textwidth by default
set formatoptions=
set splitright

"-----------------------------------------------------------------------------
" IndentLine
"-----------------------------------------------------------------------------

let g:indentLine_setColors = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_color_gui = '#7f7061'
"let g:indentLine_color_tty_light = 7 " (default: 4)
"let g:indentLine_color_dark = 1 " (default: 2)

"-----------------------------------------------------------------------------
" Autocommands
"-----------------------------------------------------------------------------

" tmux tabs with name of file open in vim
"autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))

" Open help docs in vertical split
augroup helpfiles
  au!
  au BufRead,BufEnter */doc/* wincmd L
augroup END

" Add a comment when joining commented strings
"au BufWinEnter * set formatoptions+=j
" Set textwidth to specified files and format them automatically
au BufRead,BufNewFile *.md,*.wiki,*.py,*.txt,*.c setlocal textwidth=80
au BufRead,BufNewFile *.md,*.wiki,*.py,*.txt,*.c setlocal formatoptions+=t
" Highlight horizontal line in NORMAL mode
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END
" Highlight characters if line length is over 79 and apply it to files
"augroup linelength
    "au ColorScheme * set colorcolumn=80
    "au ColorScheme * highlight ColorColumn ctermbg=darkgrey guibg=#592929
    "au BufEnter *.md,*.wiki,*.py,*.txt,*.c,*.sh highlight OverLength ctermbg=darkgrey guibg=#592929
    "au BufEnter *.md,*.wiki,*.py,*.txt,*.c,*.sh match OverLength /\%80v.*/
    "au ColorScheme * set colorcolumn=80
    "au ColorScheme * highlight ColorColumn ctermbg=darkgrey guibg=#592929
    "au BufEnter * set colorcolumn=80
    "au BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
    "au BufEnter * match OverLength /\%80v.*/
"augroup END


" Open help in new buffer to the right
function! HelpInNewTab ()
  if &buftype == 'help'
    execute "normal \<C-W>T"
  endif
endfunction

autocmd Filetype python nnoremap <buffer> <F10> :w<CR> :bo ter python3 "%"<CR>

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" Fix default weird vim behaviour with json files
let g:vim_json_conceal = 0
" Ripgrep function used by \s
command! -bang -nargs=* RG call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob='!{/proc,/sys,**/*.js,**/*.css,/home,**/*.py}' --no-follow firefox /".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"-----------------------------------------------------------------------------
" YAML
"-----------------------------------------------------------------------------
"au BufNewFile,BufRead *.yaml,*.yml  setf yaml

" Fix auto-indentation for YAML files
augroup yaml_fix
    autocmd!
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
augroup END

"-----------------------------------------------------------------------------
" Color and visual settings
"-----------------------------------------------------------------------------

set t_Co=256
syntax enable
colorscheme gruvbox
"colorscheme afterglow
"colorscheme one
set background=dark

" run in term for transp
" :highlight Normal ctermbg=NONE guibg=NONE
highlight Normal ctermbg=NONE guibg=NONE

" vim_current_word colors
hi CurrentWord ctermbg=53
hi CurrentWordTwins ctermbg=239

"if &term =~ "xterm\\|rxvt"
    "" disable Background Color Erase (BCE) so that color schemes
    "" render properly when inside 256-color tmux and GNU screen.
    "" see also https://sunaku.github.io/vim-256color-bce.html
    "set t_ut=
"endif

if exists('+termguicolors')
  " Tmux colors fix
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Cursos color
"if &term =~ "xterm\\|rxvt"
  "" use an orange cursor in insert mode
  "let &t_SI = "\<Esc>]12;blue\x7"
  "" use a red cursor otherwisue
  "let &t_EI = "\<Esc>]12;white\x7"
  "silent !echo -ne "\033]12;white\007"
  "" reset cursor when vim exits
  "autocmd VimLeave * silent !echo -ne "\033]112\007"
  "" use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
"endif
"-----------------------------------------------------------------------------
" Custom binds
"-----------------------------------------------------------------------------

" Go full-vim mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
" Numbers on/off
map <F1> :set nu!<CR> :set rnu!<CR><ESC>
" Toggle special indent characters
map <F2> :IndentLinesToggle<CR>
" Toggle special characters
map <F3> :set list!<CR>
" Paste mode on/off
set pastetoggle=<F4>
" compile C
"map <F7> :w <CR> :!gcc % -o %< && ./%< <CR>
map <F7> :w <CR> :!gcc % -o %< <CR>:vert term ./%<<CR>
"Remove all trailing whitespace by pressing F8
nnoremap <F8> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" System clipboard binds 
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y

" Xplr binds to open new buffers
"let g:nnn#action = {
      "\ '<c-t>': 'tab split',
      "\ '<c-x>': 'split',
      "\ '<c-v>': 'vsplit' }
"-----------------------------------------------------------------------------
" FZF
"-----------------------------------------------------------------------------
" FZF Buffer Delete
function! s:list_buffers() abort
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines) abort
  " Use bdelete so buffers stay in locationlist
  execute 'bdelete' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({ 'source': s:list_buffers(), 'sink*': { lines -> s:delete_buffers(lines) }, 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
" List all buffers
nnoremap <silent> <C-b> :Buffers<CR>
" Search in current buffer
nnoremap <silent> <C-f> :BLines<CR>
" Search in all buffers
nnoremap <silent> <C-l> :Lines<CR>
" Search in marks
"nnoremap <silent> <C-m> :Marks<CR>
" Search in history
nnoremap <silent> <C-h> :History<CR>
" Navigation in NORMAL mode
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" Navigation in INSERT mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-w> <S-Right>
"inoremap <C-b> <S-Left>
" Scroll beetween tabs
"nnoremap <C-h> gT
"nnoremap <C-l> gt
" Scroll inside tab beetween panes
nnoremap <C-j> <C-W><C-H>
nnoremap <C-k> <C-W><C-L>
" Resize panes
noremap <C-Down> <C-w>+
noremap <C-Up> <C-w>-
noremap <C-Right> <C-w>>
noremap <C-Left> <C-w><
"-----------------------------------------------------------------------------
" leader \ shortcuts
"-----------------------------------------------------------------------------

" Go
nnoremap <leader>gb :GoBuild<CR>

" Add date with postfix for calendar
nmap <leader>dm :put =strftime(\"%d/%m/%Y\")<CR>viWS]$a Meet<ESC>_i+ <ESC>$a 
nmap <leader>dt :put =strftime(\"%d/%m/%Y\")<CR>viWS]$a Task<ESC>_i+ <ESC>$a 
nmap <leader>do :put =strftime(\"%d/%m/%Y\")<CR>viWS]$a Obs<ESC>_i+ <ESC>$a 

" Fzf
" Global file search
nnoremap <leader>f :Files .<CR>
nnoremap <leader>/ :Files /<CR>
" Search in cwd with rg
nnoremap <leader>s :RG<CR>
nnoremap <leader>t :below terminal<CR>
nnoremap <leader>c :Calendar<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>pi :PluginInstall<CR>
nnoremap <leader>vv :vsplit<CR>
"nnoremap <leader>x :XplrPicker<CR>
" File shortcuts
nnoremap <leader>ef :e /sbin/firewall<CR>
nnoremap <leader>ei :e /etc/network/interfaces<CR>
nnoremap <leader>et :e $HOME/.tmux.conf<CR>
nnoremap <leader>ev :e $HOME/.vimrc<CR>
nnoremap <leader>ex :e $HOME/.config/xplr/init.lua<CR>
" Wrap line under cursor to 80 width
nnoremap <leader>8 :normal Vgq<CR>
" Delete marks in document
nnoremap <leader>m :delm! | delm A-Z0-9<CR>
" Select again deselected
nnoremap <leader>v V`]
" Turn of the highlighting after search
nnoremap <leader>] :nohl<CR>
" Indent select with Shift-< and Shift->
nnoremap <lt>> V`]<
nnoremap ><lt> V`]>
nnoremap =- V`]=

" vim-surround
" add surroundings for word
nnoremap <leader>( :normal viWS)<CR>
nnoremap <leader>) :normal viWS)<CR>
nnoremap <leader>[ :normal viWS]<CR>
nnoremap <leader>] :normal viWS]<CR>
nnoremap <leader>{ :normal viWS}<CR>
nnoremap <leader>} :normal viWS}<CR>
nnoremap <leader>{ :normal viWS}<CR>
nnoremap <leader>. :normal viWS><CR>
nnoremap <leader>, :normal viWS><CR>
nnoremap <leader>" :normal viWS"<CR>
nnoremap <leader>' :normal viWS'<CR>
nnoremap <leader>` :normal viWS`<CR>
" yss) - add for line
" ds) - delete for line

"-----------------------------------------------------------------------------
" Backup settings
"-----------------------------------------------------------------------------
set undofile                      " enable undo's
" disabled due to coc-plugin
"set backup                        " enable backups
set noswapfile                    " it's 2013, Vim.
" Folder paths
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif


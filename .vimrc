" Identify platform. From spf13
silent function! OSX()
  return has('macunix')
endfunction
silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
  return  (has('win32') || has('win64'))
endfunction

set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-bufferline'
Plug 'airblade/vim-gitgutter'
Plug 'Valloric/YouCompleteMe'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'altercation/vim-colors-solarized'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'Raimondi/delimitMate'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'hynek/vim-python-pep8-indent'
Plug 'hdima/python-syntax'
Plug 'scrooloose/syntastic'
Plug 'google/vim-searchindex'
call plug#end()

filetype plugin indent on
syntax on
let mapleader = ","    " set mapleader
"set autoread
set fileencodings=utf-8,gbk,ucs-bom,cp936
set showmatch          " Show matching brackets.
" set ignorecase         "搜索时不区分大小写, 如果键入了大写字母则区分大小写
" set smartcase          " Do smart case matching, 只有搜索关键字中出现一个大写字母时才区分大小写
set hlsearch           "搜索高亮, 按下 gd 就有效果
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and :make
" set hidden             " Hide buffers when they are abandoned
set virtualedit=block
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set mouse=nicr
" set mouse=a            " Enable mouse usage (all modes)
if has('clipboard')
  " set clipboard=unnamed
  vnoremap <c-c> "+y
endif
set t_Co=256
colorscheme mycolor
" colorscheme solarized
set wildmenu      "下栏中显示<tab>预测项
set ruler
set nobackup
set laststatus=2
set showcmd        "在状态栏显示目前输入的命令
set backspace=indent,eol,start
set so=5          " Minimum lines to keep above and below cursor
" set scrolljump=-50              " Lines to scroll when cursor leaves screen
set go-=m  "不要菜单栏,工具栏(T),书签栏(B)
set go-=T
" set nowrap                      " Do not wrap long lines
set nu
set cpo+=n
let &showbreak = '↳ '
set breakindent
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set synmaxcol=2000
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set list
set listchars=tab:\ \ ,trail:•,extends:#,nbsp:.  " Highlight problematic whitespace
" set listchars=tab:»\ ,trail:•,extends:#,nbsp:.  " Highlight problematic whitespace
" set listchars=tab:»·,trail:•,extends:#,nbsp:.  " Highlight problematic whitespace
set pastetoggle=<F12>
set autoindent
" set smartindent
"第一行, vim使用自动对起, 也就是把当前行的对起格式应用到下一行；
"第二行, 依据上面的对起格式, 智能的选择对起方式, 对于类似C语言编写上很有用
set expandtab       "tab用空格表示
set tabstop=2
set shiftwidth=2
set softtabstop=2   "backspace一次消除4个空格
set nojoinspaces    " Prevents inserting two spaces after punctuation on a join (J)
set fdm=marker
" set spell

" Fonts
" set guifont=Courier_New:h12:cANSI
" set guifont=文泉驿等宽微米黑\ 12
if OSX()
  set guifont=Monaco:h12
endif

if has('transparency')
  set transparency=18
endif
if has('gui_running')
  set lines=32 columns=95
endif

"光标所在行只加一条下划线
set cursorline
hi cursorline gui=underline    guibg=NONE
hi cursorline cterm=underline  ctermbg=NONE
"hi cursorline ctermbg=NONE cterm=underline

" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,longest,preview
set completeopt=menu,longest
"set complete=.,w,b,u  " CTRL-P/N 和 C-x-l 的扫瞄范围

"see  :help last-position-jump
" comment it, because when open .js it can't support syntax, so you should type  g'"  to go previous position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" coderoot
let g:coderoot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if g:coderoot == ''
  let g:coderoot = substitute(system('hg root'), '[\n\r]', '', 'g')
endif


"move around the windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

nnoremap <Space> i<Space><Esc>l
inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I

" Window
nnoremap <leader>q :close<CR>

" Buffer
nnoremap <leader>lb :buffers<CR>
nnoremap <leader>dc :bdelete %<CR>
nnoremap <leader>dp :bdelete #<CR>
" " Don't close window, when deleting a buffer
nnoremap <leader>dd :Bclose<CR>
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif
  if bufnr("%") == l:currentBufNum
    new
  endif
  if buflisted(l:currentBufNum)
    execute("bdelete ".l:currentBufNum)
  endif
endfunction

" location list
function! s:BufferCount()
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction
function! s:LListToggle()
  let buffer_count_before = s:BufferCount()
  silent! lclose

  if s:BufferCount() == buffer_count_before
    execute "silent! lopen"
  endif
endfunction
nnoremap <leader>ll :call <SID>LListToggle()<CR>

" Map <leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nnoremap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" rename word
nnoremap gr :%s/\C\<<C-R>=expand("<cword>")<CR>\>//gc<left><left><left>

" copy full path of current path
nnoremap <Leader>cp :let @+=expand('%:p')<CR>

" When pressing <leader>cd switch to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<CR>

"针对长行调整移动
set display=lastline
function! MapFlow()
  nnoremap j gj
  nnoremap k gk
  nnoremap 0 g0
  nnoremap ^ g^
  nnoremap $ g$
endfunction
function! UnMapFlow()
  nunmap j
  nunmap k
  nunmap 0
  nunmap ^
  nunmap $
endfunction
command! MapFlow :call MapFlow()
command! UnMapFlow :call UnMapFlow()
" call MapFlow()

"make the column where the cursor is highlighted or not
nnoremap <leader>hc :call SetColorColumn()<CR>
function! SetColorColumn()
  let col_num = virtcol(".")
  let cc_list = split(&cc, ',')
  if count(cc_list, string(col_num)) <= 0
    execute "set cc+=".col_num
  else
    execute "set cc-=".col_num
  endif
endfunction

"To hex modle
let s:hexModle = "N"
function! ToHexModle()
  if s:hexModle == "Y"
    %!xxd -r
    let s:hexModle = "N"
  else
    %!xxd
    let s:hexModle = "Y"
  endif
endfunction
map <leader>hex :call ToHexModle()<CR>


" GNU GLOBAL
set cscopeprg=gtags-cscope

" add tags
function! AddTags()
  set nocsverb
  if g:coderoot != ''
    " add GTAGS
    if filereadable(g:coderoot . '/GTAGS')
      exe 'cs add ' . g:coderoot . '/GTAGS'
    endif
    " add tags
    if filereadable(g:coderoot . '/tags')
      let &tags = &tags . ',' . g:coderoot . '/tags'
    endif
  elseif filereadable("GTAGS")
    cs add GTAGS
  endif
  set csverb
endfunction
" 映射 [[[2
" Find symbol
nnoremap css :cs find s <C-R>=expand("<cword>")<CR><CR>
" Find definition
nnoremap csg :cs find g <C-R>=expand("<cword>")<CR><CR>
" Find functions calling this function
nnoremap csc :cs find c <C-R>=expand("<cword>")<CR><CR>
" Find text string
nnoremap cst :cs find t <C-R>=expand("<cword>")<CR><CR>
" Find egrep pattern
nnoremap cse :cs find e <C-R>=expand("<cword>")<CR><CR>
" Find path
nnoremap csf :cs find f <C-R>=expand("<cfile>")<CR><CR>
" Find include file
nnoremap csi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" Find custom command
nnoremap cs<Space> :cs find

" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
"xml,html,php

" ---------- FileType ----------
autocmd FileType xml,html,php call FT_xml()
function! FT_xml()
  "inoremap </ </<c-x><c-o><Esc>a
  set cuc
endfunction

" C
autocmd FileType c call FT_c()
function! FT_c()
  call AddTags()
  set cin
  set cinoptions=:0
  "set makeprg=gcc\ -Wall\ -D__DEBUG__\ -o\ %<.exe\ %
  if filereadable('./.ycm_extra_conf.py')
    let g:ycm_global_ycm_extra_conf = './.ycm_extra_conf.py'
  elseif g:coderoot != '' && filereadable(g:coderoot . '/.ycm_extra_conf.py')
    let g:ycm_global_ycm_extra_conf = g:coderoot . '/.ycm_extra_conf.py'
  else
    let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf/c.ycm_extra_conf.py'
  endif
endfunction

" C++
autocmd FileType cpp call FT_cpp()
function! FT_cpp()
  call AddTags()
  set cin
  set cinoptions=:0,g0
  "set makeprg=g++\ -Wall\ -D__DEBUG__\ -o\ %<.exe\ %
  if filereadable('./.ycm_extra_conf.py')
    let g:ycm_global_ycm_extra_conf = './.ycm_extra_conf.py'
  elseif g:coderoot != '' && filereadable(g:coderoot . '/.ycm_extra_conf.py')
    let g:ycm_global_ycm_extra_conf = g:coderoot . '/.ycm_extra_conf.py'
  else
    let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf/cpp.ycm_extra_conf.py'
  endif
endfunction

" python
autocmd FileType python call FT_python()
let python_highlight_all = 1
function! FT_python()
  call AddTags()
  syn keyword pythonDecorator self
  setlocal wrap  " wrap ,although pymode is on
  set foldmethod=indent
  set foldlevel=99
  set cuc
  " Allow triple quotes in python
  let b:delimitMate_nesting_quotes = ['"', "'"]
  setlocal et ts=2 sw=2 sts=2
endfunction

" Java
autocmd FileType java call FT_java()
function! FT_java()
  call AddTags()
endfunction

" ---------- Plugins ----------
" YouCompleteMe
let g:ycm_key_detailed_diagnostics = '<leader>yd'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_always_populate_location_list = 1 "default 0
nnoremap <leader>js :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jg :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jj :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
let g:ycm_error_symbol = '❌'
let g:ycm_warning_symbol = '⚠️'
" add following line into .bashrc or .profile.
" alias vims="vim --cmd 'let g:ycm_show_diagnostics_ui=1'"
if !exists("g:ycm_show_diagnostics_ui")
  let g:ycm_show_diagnostics_ui = 0
endif
" " autocmd FileType c,cpp,objc,objcpp let g:ycm_show_diagnostics_ui = 1
" autocmd FileType c,cpp,objc,objcpp nnoremap <leader>s :call <SID>YcmSyntaxToggle()<CR>
" function! s:YcmSyntaxToggle()
"   let g:ycm_show_diagnostics_ui = xor(g:ycm_show_diagnostics_ui, 1)
"   if g:ycm_show_diagnostics_ui == 0
"     echo 'YCM Syntastic Off!'
"   else
"     echo 'YCM Syntastic On!'
"   endif
" endfunction

" syntastic
" let g:syntastic_mode_map = { "passive_filetypes": ["c", "cpp", "objc", "objcpp"] }
let g:syntastic_error_symbol = '❌'
let g:syntastic_warning_symbol = '⚠️'
nnoremap <leader>s :SyntasticToggleMode<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_c_checkers = []
let g:syntastic_cpp_checkers = []
let g:syntastic_objc_checkers = []
let g:syntastic_objcpp_checkers = []
" let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_checkers = ['flake8']  " pip/pip3 install flake8
" let g:syntastic_python_flake8_args = '--select=F,W,C9 --max-complexity=12'
let g:syntastic_python_flake8_args = '--select=F,W'
let g:syntastic_python_flake8_quiet_messages = { "regex": '\mF403' }

" vim-bufferline
" let g:bufferline_echo = 0

" vim-gitgutter
let g:gitgutter_enabled = 0
nnoremap <leader>g :GitGutterToggle<CR>

" delimitMate
let delimitMate_matchpairs = "(:),[:],{:}"
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let delimitMate_jump_expansion = 1

" ultisnipslet
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger="<C-f>"
let g:UltiSnipsJumpForwardTrigger="<C-f>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"
let g:ultisnips_python_style="google"

" CtrlP
nnoremap <leader>ft :CtrlP<CR>
nnoremap <leader>fb :CtrlPBuffer<CR>
nnoremap <leader>fc :CtrlPClearCache<CR>:CtrlP<CR>
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

" ctrlp-funky
nnoremap <leader>fu :CtrlPFunky<Cr>
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_funky_syntax_highlight = 1

" tagbar
let g:tagbar_sort = 0
nnoremap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_width = 30
let g:tagbar_ctags_bin = 'ctags'

" plasticboy/vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_initial_foldlevel=1

" vim-commentary
autocmd FileType c,cpp set commentstring=//\ %s

" airline
let g:airline_theme = "dark"
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#bufferline#enabled = 0

" vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

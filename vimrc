set nocompatible              " be iMproved, required
filetype off                  " required
"
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
Plugin 'ervandew/supertab'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'

call vundle#end()            " required

filetype plugin indent on    " required
"bundle end

set foldmethod=marker

"YouCompleteMe 自动补全配置
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>" 

"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1

"从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1 
"禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0    
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1  
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 跳转到定义处
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

nmap <F4> :YcmDiags<CR>  
"在接受补全后不分裂出一个窗口显示接受的项  
set completeopt-=preview  
"不显示开启vim时检查ycm_extra_conf文件的信息  
let g:ycm_confirm_extra_conf=0  

"set foldmethod=indent

"显示状态栏 (默认值为 1, 无法显示状态栏)
set laststatus=2

colorscheme desert
"colorscheme freya

"为光标所在行加下划线
"set cursorline

"显示最多行，不用@@
set dy=lastline

set backspace=indent,eol,start
sy on
set nobackup
set hlsearch
set showmatch

"全局使用鼠标 
"set mouse=a
set mouse=

"vim 关闭后内容显示在屏幕上
set t_ti= t_te=      

map mm :w<cr>
map nh :noh<cr>
imap jj <esc> 

"这里设置（软）制表符宽度为4：
set tabstop=4
set softtabstop=4
set expandtab

" 设置缩进的空格数为4
set shiftwidth=4

"let g:SuperTabDefaultCompletionType="context"  
"let g:SuperTabDefaultCompletionType="<c-x><c-u>"

"设置自动缩进：即每行的缩进值与上一行相等；使用 noautoindent 取消设置：
"set autoindent

"设置使用 C/C++ 语言的自动缩进方式：
"set cin

"set cino=:0g0t0(su
"set cino=N-s,:0,g0,t0,(s,us,i0

"设置C/C++语言的具体缩进方式（以我的windows风格为例）：
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

" 如果想在左侧显示文本的行号，可以用以下语句：
set nu

"缩进设置  只对tab有效
set list
set listchars=tab:\|\ 

"设定文件浏览器目录为当前目录
"set autochdir

"在输入要搜索的文字时，vim会实时匹配
set incsearch 

"允许退格键的使用
"set backspace=indent,eol,start whichwrap+=<,>,[,] 

"编码问题
"let termencoding=&encoding
"set fileencodings=gbk,gb18030,utf-8

"自动打开上次退出时的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 

"majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>

""进行Tlist的设置
""TlistUpdate可以更新tags
""按下F8就可以呼出了
"map <F8> :silent! Tlist<CR>
"let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
"let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
"let Tlist_Show_One_File=0 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
"let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
"let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
"let Tlist_Process_File_Always=1 "是否一直处理tags.1:处理;0:不处理。不是一直实时更新tags，因为没有必要
"let Tlist_Inc_Winwidth=0

set encoding=utf-8
set fileencodings=utf-8,cp936,ucs-bom


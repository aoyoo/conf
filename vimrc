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

"YouCompleteMe �Զ���ȫ����
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
"��Vim�Ĳ�ȫ�˵���Ϊ��һ��IDEһ��(�ο�VimTip1228)
set completeopt=longest,menu
"�뿪����ģʽ���Զ��ر�Ԥ������
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"�س���ѡ�е�ǰ��
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>" 

"�������Ҽ�����Ϊ ����ʾ������Ϣ
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"���� YCM ���ڱ�ǩ����
let g:ycm_collect_identifiers_from_tags_files=1

"�ӵ�2�������ַ��Ϳ�ʼ����ƥ����
let g:ycm_min_num_of_chars_for_completion=1 
"��ֹ����ƥ����,ÿ�ζ���������ƥ����
let g:ycm_cache_omnifunc=0    
" �﷨�ؼ��ֲ�ȫ
let g:ycm_seed_identifiers_with_syntax=1  
"��ע��������Ҳ�ܲ�ȫ
let g:ycm_complete_in_comments = 1
"���ַ���������Ҳ�ܲ�ȫ
let g:ycm_complete_in_strings = 1
"ע�ͺ��ַ����е�����Ҳ�ᱻ���벹ȫ
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" ��ת�����崦
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

nmap <F4> :YcmDiags<CR>  
"�ڽ��ܲ�ȫ�󲻷��ѳ�һ��������ʾ���ܵ���  
set completeopt-=preview  
"����ʾ����vimʱ���ycm_extra_conf�ļ�����Ϣ  
let g:ycm_confirm_extra_conf=0  

"set foldmethod=indent

"��ʾ״̬�� (Ĭ��ֵΪ 1, �޷���ʾ״̬��)
set laststatus=2

colorscheme desert
"colorscheme freya

"Ϊ��������м��»���
"set cursorline

"��ʾ����У�����@@
set dy=lastline

set backspace=indent,eol,start
sy on
set nobackup
set hlsearch
set showmatch

"ȫ��ʹ����� 
"set mouse=a
set mouse=

"vim �رպ�������ʾ����Ļ��
set t_ti= t_te=      

map mm :w<cr>
map nh :noh<cr>
imap jj <esc> 

"�������ã����Ʊ�����Ϊ4��
set tabstop=4
set softtabstop=4
set expandtab

" ���������Ŀո���Ϊ4
set shiftwidth=4

"let g:SuperTabDefaultCompletionType="context"  
"let g:SuperTabDefaultCompletionType="<c-x><c-u>"

"�����Զ���������ÿ�е�����ֵ����һ����ȣ�ʹ�� noautoindent ȡ�����ã�
"set autoindent

"����ʹ�� C/C++ ���Ե��Զ�������ʽ��
"set cin

"set cino=:0g0t0(su
"set cino=N-s,:0,g0,t0,(s,us,i0

"����C/C++���Եľ���������ʽ�����ҵ�windows���Ϊ������
"set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

" ������������ʾ�ı����кţ�������������䣺
set nu

"��������  ֻ��tab��Ч
set list
set listchars=tab:\|\ 

"�趨�ļ������Ŀ¼Ϊ��ǰĿ¼
"set autochdir

"������Ҫ����������ʱ��vim��ʵʱƥ��
set incsearch 

"�����˸����ʹ��
"set backspace=indent,eol,start whichwrap+=<,>,[,] 

"��������
"let termencoding=&encoding
"set fileencodings=gbk,gb18030,utf-8

"�Զ����ϴ��˳�ʱ��λ��
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 

"majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>

""����Tlist������
""TlistUpdate���Ը���tags
""����F8�Ϳ��Ժ�����
"map <F8> :silent! Tlist<CR>
"let Tlist_Ctags_Cmd='ctags' "��Ϊ���Ƿ��ڻ�����������Կ���ֱ��ִ��
"let Tlist_Use_Right_Window=1 "�ô�����ʾ���ұߣ�0�Ļ�������ʾ�����
"let Tlist_Show_One_File=0 "��taglist����ͬʱչʾ����ļ��ĺ����б������ֻ��1��������Ϊ1
"let Tlist_File_Fold_Auto_Close=1 "�ǵ�ǰ�ļ��������б��۵�����
"let Tlist_Exit_OnlyWindow=1 "��taglist�����һ���ָ��ʱ���Զ��Ƴ�vim
"let Tlist_Process_File_Always=1 "�Ƿ�һֱ����tags.1:����;0:����������һֱʵʱ����tags����Ϊû�б�Ҫ
"let Tlist_Inc_Winwidth=0

set encoding=utf-8
set fileencodings=utf-8,cp936,ucs-bom


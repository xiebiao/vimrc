"=======================
"	Public(公共)
"=======================
if has('mouse') 
    set mouse=a       "可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
endif 
set cursorcolumn                 "光标所在列高亮(vim6.0以上)
set cursorline                   "光标所在行高亮(vim6.0以上)
set textwidth=80                 "设置70个字符就自动换行
set guifont=Monaco\ 12           "设置字体
set nocompatible       "不要使用vi的键盘模式，而是vim自己的
set syntax=on    "开启语法高亮
set noeb       "去掉输入错误的提示声音
set confirm    "在处理未保存或只读文件的时候，弹出确认
set clipboard+=unnamed   "和外界共享粘贴板内容
set nocompatible   "不兼容vi

"=======================
"	Indent(缩进)
"=======================

filetype plugin indent on   "vundle配置
"filetype indent on    "为特定文件类型载入相关缩进文件
set smartindent   "为C程序提供自动缩进
"set autoindent    "自动缩进
set cindent       "C/C++语言风格缩进
set tabstop=4      "制表符号宽度
set softtabstop=4    "统一缩进为4
"set list                          "显示Tab,便于查看缩进
"set listchars=tab:+.,trail:.

set expandtab	   "使用空格代替tab，因为他不在不同编辑器上显示不一致
set noexpandtab   "不要用空格代替制表符
set shiftwidth=4   "设置缩进的空格数为4
"set smarttab    "在行和段开始处使用制表符

set number  "显示行号
set ruler  "显示列号
set history=50   "历史记录数
set nobackup   "禁止生成临时文件
set noswapfile
set ignorecase     "搜索忽略大小写
"	set ic			"搜索忽略大小写
"set hlsearch   "搜索逐字符高亮
set incsearch
set gdefault   "行内替换
set ff=unix "设置fileformat为unix，windows下ff=dos
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8   "语言设置
set helplang=cn
set fileencodings=utf-8,gbk,ucs-bom,cp936,unicode,latin-1   "设置文件编码列表
set enc=utf-8   "编码设置
set fileencoding=utf-8
set encoding=utf-8
" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
set laststatus=2  "总是显示状态行
set ruler             "在编辑过程中，在右下角显示光标位置的状态行
set cmdheight=1   "命令行（在状态行下）的高度，默认为1，这里是2
set viminfo+=!   " 保存全局变量
set iskeyword+=_,$,@,%,#,-   " 带有如下符号的单词不要被换行分割
set linespace=0   "字符间插入的像素行数目
set wildmenu   "增强模式中的命令行自动完成操作
set backspace=2   "使回格键（backspace）正常处理indent, eol, start等
set whichwrap+=<,>,h,l    "允许backspace和光标键跨越行边界
set selection=exclusive
set selectmode=mouse,key
set report=0   "通过使用: commands命令，告诉我们文件的哪一行被改变过
"set shortmess=atI   "启动的时候不显示那个援助索马里儿童的提示(我们应该显示)
set fillchars=vert:\ ,stl:\ ,stlnc:\   "在被分割的窗口间显示空白，便于阅读
set showmatch   "高亮显示匹配的括号
set matchtime=5   "匹配括号高亮的时间（单位是十分之一秒）
set scrolloff=3   "光标移动到buffer的顶部和底部时保持3行距离
"set path +=/usr/include "C语言头文件查找位置
"
"============================
"	File types(文件类型)
"============================
"
"filetype on    "侦测文件类型
filetype off "vundle配置
filetype plugin on    "载入文件类型插件
"setlocal omnifunc=javacomplete#Complete 
" python不要 tab 
autocmd FileType python setlocal et | setlocal sta | setlocal sw=4

"=======================
"	Colors(配色)
"=======================
"
"colorscheme murphy 
"colorscheme my_desert
"colorscheme desert
"colorscheme devbox-dark-256 

colorscheme molokai
let g:rehash256 = 1
" let g:molokai_original = 1
" set t_Co=256

"colorscheme darkblue
"colorscheme darkburn
"colorscheme lucius
"colorscheme freya
"colorscheme skittles_dark
"
"=======================
"	Key map(快捷键映射)
"=======================

map <F2> :set nonu!<CR> "不显示行号
map <F3> :set list!<CR> "不显示tab内容
map <F4> :NERDTreeToggle<cr> "打开NERDTree
map <F5> :e!<cr> " 手动刷新文件
map <F6> :set nopaste!<CR>
map <F8> :TagbarToggle<CR> "打开taglist
nmap <S-y> y$<CR> "光标位置复制到行尾

"窗口切换
nmap <C-j> <C-w><Down>
nmap <C-k> <C-w><Up>
nmap <C-l> <C-w><Right>
nmap <C-h> <C-w><Left>

" 设置 Ctrl + s 保存当前文件
" 由于Ctrl+S被其他使用，首先要修改~/.bashrc文件，在最后加上
" stty stop ''
map <silent><C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>a

"=======================
"	Vundle
"=======================

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" My Bundles here:
"  
" original repos on github
Bundle 'scrooloose/nerdtree'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'majutsushi/tagbar'
" Go
Bundle 'fatih/vim-go'
" Python
Bundle 'hdima/python-syntax'

"========================
"   Cscope 
"========================
"
"========================
"   Go 
"========================
let g:go_disable_autoinstall = 1



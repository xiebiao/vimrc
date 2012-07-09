"===================
"	Public
"===================
set cursorcolumn                 "光标所在列高亮(vim6.0以上)
set cursorline                   "光标所在行高亮(vim6.0以上)
set textwidth=80                 "设置70个字符就自动换行
set guifont=Monaco\ 12           "设置字体
set nocompatible       "不要使用vi的键盘模式，而是vim自己的
set syntax=on    "开启语法高亮
set noeb       "去掉输入错误的提示声音
set confirm    "在处理未保存或只读文件的时候，弹出确认
set smartindent   "为C程序提供自动缩进
set autoindent    "自动缩进
set cindent
set tabstop=4      "Tab键的宽度
"set list                          "显示Tab,便于查看缩进
"set listchars=tab:+.,trail:.

set expandtab	   "使用空格代替tab，因为他不在不同编辑器上显示不一致
"set noexpandtab   "不要用空格代替制表符
set softtabstop=4    "统一缩进为4
set shiftwidth=4

set smarttab    "在行和段开始处使用制表符
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
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8   "语言设置
set helplang=cn
set enc=utf-8   "编码设置
set fileencodings=utf-8,gbk,ucs-bom,cp936   "设置文件编码
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
set mouse=a       "可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set selection=exclusive
set selectmode=mouse,key
set report=0   "通过使用: commands命令，告诉我们文件的哪一行被改变过
"set shortmess=atI   "启动的时候不显示那个援助索马里儿童的提示(我们应该显示)
set fillchars=vert:\ ,stl:\ ,stlnc:\   "在被分割的窗口间显示空白，便于阅读
set showmatch   "高亮显示匹配的括号
set matchtime=5   "匹配括号高亮的时间（单位是十分之一秒）
set scrolloff=3   "光标移动到buffer的顶部和底部时保持3行距离

"========================
"	File types
"========================
filetype on    "侦测文件类型
filetype plugin on    "载入文件类型插件
filetype indent on    "为特定文件类型载入相关缩进文件
"setlocal omnifunc=javacomplete#Complete 
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

"===================
"	Colors
"===================
"colorscheme murphy 
"colorscheme my_desert
colorscheme devbox-dark-256 
"colorscheme darkblue
"colorscheme darkburn
"colorscheme lucius
"colorscheme freya
"colorscheme skittles_dark
"

"===================
"	Key map
"===================
map <F4> :NERDTree<cr>
" 手动刷新文件
map <F5> :e!<cr>    
map <F12> :TlistToggle<cr>


"===================
"   Taglist
"===================
"if MySys() == "windows"                "设定windows系统中ctags程序的位置
"	   let Tlist_Ctags_Cmd = 'ctags'
"elseif MySys() == "linux"              "设定windows系统中ctags程序的位置
"	   let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"endif
"let Tlist_Auto_Open=1                  "默认打开taglist
let Tlist_Auto_Open=0               
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口
"===================
"	Python
"===================
" 不要 tab 
autocmd FileType python setlocal et | setlocal sta | setlocal sw=4

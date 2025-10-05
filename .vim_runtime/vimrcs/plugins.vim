"=======================
" 插件管理:	https://github.com/junegunn/vim-plug
"=======================
"插件默认安装在plugged目录中
call plug#begin()
Plug 'navarasu/onedark.nvim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'rust-lang/rust.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"显示列缩进线
Plug 'Yggdroot/indentLine'

cal plug#end()
set tags=%HOME%\scoop\apps\ctags\current\ctags.exe
filetype plugin indent on   "vundle配置
"需要插件加载后才能执行配色切换
let g:onedark_style = 'warmer'
colorscheme onedark

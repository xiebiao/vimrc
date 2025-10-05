"=======================
" 插件管理:	https://github.com/junegunn/vim-plug
"=======================
"插件默认安装在plugged目录中
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  echo "Installing https://github.com/junegunn/vim-plug...\n" 
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine' "显示列缩进线
"Plug 'Olical/conjure' "clojure支持
cal plug#end()

" NERDTree config
map <F4> :NERDTreeToggle<cr> 


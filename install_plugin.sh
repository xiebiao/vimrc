#!/bin/sh

#--------------
# author:xiaog
#--------------

#
#   NOTE:Make sure you have INSTALLed git and ctags
#

_CURRENT_PATH=`pwd`
_TEMP_DIR=$_CURRENT_PATH/temp
_USER=`whoami`
_VIM_HOME=""
_VIMRC=""
_VIM_PLUGIN=""
_VIM_SYNTAX=""
_VIM_DOC=""
_VIM_FTPLUGIN=""

_DEBUG=$*

init()
{
    if [ ! -f "/usr/bin/git" ];then
        echo "Install git ..."
        sudo apt-get install git
    fi
    if [ "$_USER" = "root" ];then
        _VIM_HOME="/root/.vim"
    else
        _VIM_HOME="/home/"$_USER"/.vim"
        if [ ! -d "$_VIM_HOME" ];then
            mkdir $_VIM_HOME
        fi
        _VIMRC="/home/"$_USER"/.vimrc"
    fi
    rm -rf $_VIM_HOME/*
    _VIM_PLUGIN=$_VIM_HOME"/plugin"
    _VIM_DOC=$_VIM_HOME"/doc"
    _VIM_FTPLUGIN=$_VIM_HOME"/ftplugin"
    _VIM_SYNTAX=$_VIM_HOME"/syntax"

    if [ ! -d "$_VIM_PLUGIN" ]; then
        echo "mkdir $_VIM_PLUGIN ..."
        mkdir $_VIM_PLUGIN
    fi
    if [ ! -d "$_VIM_FTPLUGIN" ]; then
        echo "mkdir $_VIM_FTPLUGIN ..."
        mkdir $_VIM_FTPLUGIN
    fi
    rm -rf $_TEMP_DIR
    if [ ! -d "$_TEMP_DIR" ]; then
        echo "mkdir $_TEMP_DIR ..."
        mkdir "$_TEMP_DIR"
    fi
}
pathogen(){
	
	PLUGIN="vim-pathogen"

    if [ ! -d "$_TEMP_DIR/$PLUGIN" ]; then
		mkdir $_TEMP_DIR/$PLUGIN
		git clone	https://github.com/tpope/vim-pathogen.git $_TEMP_DIR/$PLUGIN
	fi
	cp -rf $_TEMP_DIR/$PLUGIN/autoload  $_VIM_HOME
}
# taglist.vim
taglist()
{
    if [ ! -f "/usr/bin/ctags" ];then
        echo "Install ctags ..."
        sudo apt-get install ctags
    fi
    _TAGLIST="taglist"
    echo "INSTALL $_TAGLIST start ..."
    echo "..."
    _TAGLIST_FILE="taglist.zip"

    if [ ! -d "$_TEMP_DIR/$_TAGLIST" ]; then
        echo "  mkdir $_TAGLIST ..."
        mkdir "$_TEMP_DIR/$_TAGLIST"
        git clone https://github.com/vim-scripts/taglist.vim.git \
        $_TEMP_DIR/$_TAGLIST
    fi
    cp -rf $_TEMP_DIR/$_TAGLIST/plugin $_VIM_HOME 
    cp -rf $_TEMP_DIR/$_TAGLIST/doc $_VIM_HOME
    echo "INSTALL $_TAGLIST success ..."
    echo "..."
}
#   INSTALL https://github.com/godlygeek/tabular.git
tabular()
{

    _PLUGIN="tabular"
    echo "INSTALL $_PLUGIN start ..."
    echo "..."
    if [ ! -d "$_TEMP_DIR/$_PLUGIN" ]; then
        mkdir $_TEMP_DIR/$_PLUGIN
        git clone https://github.com/godlygeek/tabular.git $_TEMP_DIR/$_PLUGIN 
    fi
    cp -rf $_TEMP_DIR/$_PLUGIN/plugin $_VIM_HOME 
    cp -rf $_TEMP_DIR/$_PLUGIN/doc $_VIM_HOME
    echo "INSTALL $_PLUGIN success ..."
    echo "..."

}
# NERDTree
nerdtree()
{
	pathogen;
    PLUGIN="nerdtree"
    echo "INSTALL $PLUGIN start ..."
    echo "..."
    if [ ! -d "$_TEMP_DIR/$PLUGIN" ]; then
        mkdir $_TEMP_DIR/$PLUGIN
        git clone https://github.com/scrooloose/nerdtree.git $_TEMP_DIR/$PLUGIN
    fi
	mkdir -p $_VIM_HOME/bundle/
    cp -rf $_TEMP_DIR/$PLUGIN/ $_VIM_HOME/bundle/
    echo "INSTALL $PLUGIN success ..."
    echo "..." 
}
# a.vim
# A few of quick commands to swtich between source files and header files
# quickly. 
a(){
    _A="a.vim"
    echo "INSTALL $_A start ..."
    echo "..."
    wget -q -nd -O $_VIM_PLUGIN/$_A \
    http://www.vim.org/scripts/download_script.php?src_id=7218
    echo "INSTALL $_A success ..."
    echo "..."
}

# c.vim
# description
# Statement oriented editing of  C / C++ programs 
# Speed up writing new code considerably. 
# Write code und comments with a professional appearance from the beginning. 
# Use code snippets
c()
{
    _C_FILE="cvim"
    echo "INSTALL $_C_FILE start ..."
    echo "..."
    if [ ! -d "$_TEMP_DIR/$_C_FILE" ]; then
        mkdir "$_TEMP_DIR/$_C_FILE" 
        git clone https://github.com/vim-scripts/c.vim.git $_TEMP_DIR/$_C_FILE
    fi
    cp -rf $_TEMP_DIR/$_C_FILE/* $_VIM_HOME/
    echo "INSTALL $_C_FILE success ..."
    echo "..."
}
vala()
{
    wget -O $_TEMP_DIR/vala.vim \
    "https://live.gnome.org/Vala/Vim?action=AttachFile&do=get&target=vala.vim"
    if [ ! -d "$_VIM_SYNTAX" ]; then
        echo "mkdir $_VIM_SYNTAX ..."
        mkdir $_VIM_SYNTAX
    fi
    cp $_TEMP_DIR/vala.vim $_VIM_SYNTAX/
}

#python语法检测工具
#需要安装 sudo apt-get install pyflakes
pyflakes(){

    if [ ! -f "/usr/bin/pyflakes" ];then
        echo "Install pyflakes ..."
        sudo apt-get install pyflakes
    fi
    _PLUGIN="pyflakes"
    echo "INSTALL $_PLUGIN start ..."
    echo "..."
    if [ ! -d "$_TEMP_DIR/$_PLUGIN" ]; then
        mkdir $_TEMP_DIR/$_PLUGIN
        git clone https://github.com/kevinw/pyflakes-vim.git $_TEMP_DIR/$_PLUGIN 
    fi
    cp -rf $_TEMP_DIR/$_PLUGIN/ftplugin/ $_VIM_HOME 
    echo "INSTALL $_PLUGIN success ..."
}

cscope(){
    # http://graceco.de/manual/cscope_vim_tutorial_zh.html
    if [ ! -f "/usr/bin/cscope" ];then
        echo "Install cscope ..."
        sudo apt-get install cscope 
    fi
    _PLUGIN="cscope"
    echo "INSTALL $_PLUGIN start ..."
    echo "..."
    if [ ! -d "$_TEMP_DIR/$_PLUGIN" ]; then
        mkdir $_TEMP_DIR/$_PLUGIN
        git clone https://github.com/vim-scripts/cscope.vim.git $_TEMP_DIR/$_PLUGIN 
    fi
    cp -rf $_TEMP_DIR/$_PLUGIN/plugin/ $_VIM_HOME 
    echo "INSTALL $_PLUGIN success ..."
}

main()
{
     init;
	 c;
     nerdtree;
     taglist;
    # vala;
     pyflakes;
     cscope;
    #tabular;
}

main
./install_vimrc.sh


#!/bin/sh

#--------------
# author:xiaog
#--------------

#
#   NOTE: This script just tested on Ubuntu 12.04
#

_CURRENT_PATH=`pwd`
_TEMP_DIR=$_CURRENT_PATH/plugins
_USER=`whoami`
_USER_HOME="/home/"$_USER"/"
_VIM_HOME=""
_VIMRC=""
_VIM_PLUGIN=""
_VIM_SYNTAX=""
_VIM_DOC=""
_VIM_FTPLUGIN=""
_VIM_COLORS=""

_INSTALL=$*

_DEBUG_INSTALL="INSTALL "
_DEBUG_SUCCESS=" SUCCESS ..."
_DEBUG_FAILED=" FAILED ..."

init()
{
    if [ ! -f "/usr/bin/git" ];then
        echo $_DEBUG_INSTALL"git ..."
        sudo apt-get install git
		if [ ! $? = 0 ];then
			echo $_DEBUG_INSTALL"git"$_DEBUG_FAILED
			exit;
	    fi
	    echo $_DEBUG_INSTALL"git"$_DEBUG_SUCCESS
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

	echo "_VIMRC=$_VIMRC"
	echo "_VIM_HOME=$_VIM_HOME"
	echo "_USER_HOME=$_USER_HOME"

    rm -rf $_VIM_HOME/*
    _VIM_PLUGIN=$_VIM_HOME"/plugin"
    _VIM_DOC=$_VIM_HOME"/doc"
    _VIM_FTPLUGIN=$_VIM_HOME"/ftplugin"
    _VIM_SYNTAX=$_VIM_HOME"/syntax"
	_VIM_COLORS=$_VIM_HOME"/colors"

    if [ ! -d "$_VIM_PLUGIN" ]; then
        echo "mkdir $_VIM_PLUGIN ..."
        mkdir $_VIM_PLUGIN
    fi
    if [ ! -d "$_VIM_FTPLUGIN" ]; then
        echo "mkdir $_VIM_FTPLUGIN ..."
        mkdir $_VIM_FTPLUGIN
    fi
    if [ ! -d "$_VIM_COLORS" ]; then
        echo "mkdir $_VIM_COLORS ..."
        mkdir $_VIM_COLORS
    fi
    rm -rf $_TEMP_DIR
    if [ ! -d "$_TEMP_DIR" ]; then
        echo "mkdir $_TEMP_DIR ..."
        mkdir "$_TEMP_DIR"
    fi
}

vimrc(){

	_VIMRC=".vimrc"
	_SHELL_PATH=`dirname $0`
	echo $_SHELL_PATH
	cp $_SHELL_PATH/$_VIMRC $_USER_HOME$_VIMRC
	echo "Copy $_SHELL_PATH/$_VIMRC to "$_USER_HOME$_VIMRC" ..."
	cp $_SHELL_PATH/colors/* $_VIM_COLORS 
	echo "Done ..."
}

#---- 管理所有插件的工具
pathogen(){
	
	PLUGIN="vim-pathogen"

    if [ ! -d "$_TEMP_DIR/$PLUGIN" ]; then
		mkdir $_TEMP_DIR/$PLUGIN
		git clone	https://github.com/tpope/vim-pathogen.git $_TEMP_DIR/$PLUGIN
	fi
	cp -rf $_TEMP_DIR/$PLUGIN/autoload  $_VIM_HOME
	echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"
}
#----  taglist.vim
taglist()
{
    if [ ! -f "/usr/bin/ctags" ];then
        echo $_DEBUG_INSTALL" ctags ..."
        sudo apt-get install ctags
		if [ ! $? = 0 ];then
			echo $_DEBUG_INSTALL"ctags"$_DEBUG_FAILED
			exit;
	    fi
    fi
    _TAGLIST="taglist"
    echo $_DEBUG_INSTALL"$_TAGLIST start ..."
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
    echo "$_DEBUG_INSTALL $_TAGLIST $_DEBUG_SUCCESS\n"
}
#----    INSTALL https://github.com/godlygeek/tabular.git
tabular()
{

    _PLUGIN="tabular"
    echo "INSTALL $_PLUGIN start ..."
    if [ ! -d "$_TEMP_DIR/$_PLUGIN" ]; then
        mkdir $_TEMP_DIR/$_PLUGIN
        git clone https://github.com/godlygeek/tabular.git $_TEMP_DIR/$_PLUGIN 
    fi
    cp -rf $_TEMP_DIR/$_PLUGIN/plugin $_VIM_HOME 
    cp -rf $_TEMP_DIR/$_PLUGIN/doc $_VIM_HOME
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"

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
    echo "$_DEBUG_INSTALL $PLUGIN $_DEBUG_SUCCESS\n"
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
    echo "$_DEBUG_INSTALL $_A $_DEBUG_SUCCESS\n"
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
    echo "$_DEBUG_INSTALL $_C_FILE $_DEBUG_SUCCESS\n"
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

#---- python语法检测工具
#---- 需要安装 sudo apt-get install pyflakes
pyflakes(){

    if [ ! -f "/usr/bin/pyflakes" ];then
        echo "Install pyflakes ..."
        sudo apt-get install pyflakes
    fi
    _PLUGIN="pyflakes"
    echo "INSTALL $_PLUGIN start ..."
    if [ ! -d "$_TEMP_DIR/$_PLUGIN" ]; then
        mkdir $_TEMP_DIR/$_PLUGIN
        git clone https://github.com/kevinw/pyflakes-vim.git $_TEMP_DIR/$_PLUGIN 
    fi
    cp -rf $_TEMP_DIR/$_PLUGIN/ftplugin/ $_VIM_HOME 
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"
}

cscope(){
    # http://graceco.de/manual/cscope_vim_tutorial_zh.html
    if [ ! -f "/usr/bin/cscope" ];then
        echo "Install cscope ..."
        sudo apt-get install cscope 
    fi
    _PLUGIN="cscope"
    echo "INSTALL $_PLUGIN start ..."
    if [ ! -d "$_TEMP_DIR/$_PLUGIN" ]; then
        mkdir $_TEMP_DIR/$_PLUGIN
        git clone https://github.com/vim-scripts/cscope.vim.git $_TEMP_DIR/$_PLUGIN 
    fi
    cp -rf $_TEMP_DIR/$_PLUGIN/plugin/ $_VIM_HOME 
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"
}

#---- Install plugins ----
plugins()
{
     init;
	 c;
     nerdtree;
     taglist;
    # vala;
     pyflakes;
     cscope;
    #tabular;
	echo "Done ..."
}
echo $*
if [ "$*" = "vimrc" ];then
    init
    vimrc
else
    init
    plugins
fi


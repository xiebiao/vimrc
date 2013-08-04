#!/bin/sh

#--------------
# author:xiaog
#--------------

#
#   NOTE: This script just tested on Ubuntu 12.04
#

_CURRENT_PATH=`pwd`
_PLUGINS_DIR=$_CURRENT_PATH/plugins
_USER=`whoami`
_USER_HOME="/home/"$_USER"/"
_VIM_HOME=""
_VIMRC=""
_VIM_PLUGIN=""
_VIM_BUNDLE=""
_VIM_SYNTAX=""
_VIM_DOC=""
_VIM_FTPLUGIN=""
_VIM_COLORS=""

_DEBUG_INSTALL="INSTALL "
_DEBUG_SUCCESS=" SUCCESS ..."
_DEBUG_FAILED=" FAILED ..."

init()
{
	echo "#-----------------------------------"
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
	echo "#-----------------------------------"

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
    if [ ! -d "$_PLUGINS_DIR" ]; then
        echo "mkdir $_PLUGINS_DIR ..."
        mkdir "$_PLUGINS_DIR"
    fi
	echo "#-----------------------------------\n"
}

vimrc(){

    echo "$_DEBUG_INSTALL .vimrc"
	_VIMRC=".vimrc"
	_SHELL_PATH=`pwd`
	echo $_SHELL_PATH
	cp $_SHELL_PATH/$_VIMRC $_USER_HOME$_VIMRC
	echo "Copy $_SHELL_PATH/$_VIMRC to "$_USER_HOME$_VIMRC" ..."
	cp $_SHELL_PATH/colors/* $_VIM_COLORS 
	echo "Done ...\n"
}

#---- 管理所有插件的工具
pathogen(){
	
	_PLUGIN="vim-pathogen"

    if [ ! -d "$_PLUGINS_DIR/$_PLUGIN" ]; then
		mkdir $_PLUGINS_DIR/$_PLUGIN
		git clone	https://github.com/tpope/vim-pathogen.git $_PLUGINS_DIR/$_PLUGIN
	else
	    cd $_PLUGINS_DIR/$_PLUGIN
		git pull
		echo "git pull\n"
		cd $_CURRENT_PATH
	fi
	cp -rf $_PLUGINS_DIR/$_PLUGIN/autoload  $_VIM_HOME
    mkdir $_VIM_HOME/bundle
	echo "mkdir $_VIM_HOME/bundle"
	_VIM_BUNDLE="$_VIM_HOME/bundle"
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
    echo "$_DEBUG_INSTALL $_TAGLIST start ..."
    _TAGLIST_FILE="taglist.zip"

    if [ ! -d "$_PLUGINS_DIR/$_TAGLIST" ]; then
        echo "  mkdir $_TAGLIST ..."
        mkdir "$_PLUGINS_DIR/$_TAGLIST"
        git clone https://github.com/vim-scripts/taglist.vim.git \
        $_PLUGINS_DIR/$_TAGLIST
    else
	    git pull
		echo "git pull\n"
    fi
	ln -s $_PLUGINS_DIR/$_TAGLIST $_VIM_BUNDLE/$_TAGLIST
    echo "$_DEBUG_INSTALL $_TAGLIST $_DEBUG_SUCCESS\n"
}
#----    INSTALL https://github.com/godlygeek/tabular.git
tabular()
{

    _PLUGIN="tabular"
    echo "$_DEBUG_INSTALL $_PLUGIN start ..."
    if [ ! -d "$_PLUGINS_DIR/$_PLUGIN" ]; then
        mkdir $_PLUGINS_DIR/$_PLUGIN
        git clone https://github.com/godlygeek/tabular.git $_PLUGINS_DIR/$_PLUGIN 
	else
	    git pull
		echo "git pull\n"
    fi
	ln -s $_PLUGINS_DIR/$_PLUGIN $_VIM_BUNDLE/$_PLUGIN
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"

}
# NERDTree
nerdtree()
{
    _PLUGIN="nerdtree"
    echo "$_DEBUG_INSTALL $_PLUGIN start ..."
    if [ ! -d "$_PLUGINS_DIR/$_PLUGIN" ]; then
        mkdir $_PLUGINS_DIR/$_PLUGIN
        git clone https://github.com/scrooloose/nerdtree.git $_PLUGINS_DIR/$_PLUGIN
	else
		git pull
		echo "git pull\n"
    fi
	ln -s $_PLUGINS_DIR/$_PLUGIN $_VIM_BUNDLE/$_PLUGIN
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"
}
# a.vim
# A few of quick commands to swtich between source files and header files
# quickly. 
a(){
    _PLUGIN="a.vim"
    echo "$_DEBUG_INSTALL $_PLUGIN start ..."
	if [ ! -d "$_PLUGINS_DIR/$_PLUGIN" ];then
		mkdir $_PLUGINS_DIR/$_PLUGIN
		git clone https://github.com/vim-scripts/a.vim.git \
		$_PLUGINS_DIR/$_PLUGIN
	else
		git pull
		echo "git pull\n"
	fi
	ln -s $_PLUGINS_DIR/$_PLUGIN $_VIM_BUNDLE/$_PLUGIN
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"
}

# c.vim
# description
# Statement oriented editing of  C / C++ programs 
# Speed up writing new code considerably. 
# Write code und comments with a professional appearance from the beginning. 
# Use code snippets

c()
{
    _PLUGIN="cvim"
    echo "$_DEBUG_INSTALL $_PLUGIN start ..."
    if [ ! -d "$_PLUGINS_DIR/$_PLUGIN" ]; then
        mkdir "$_PLUGINS_DIR/$_PLUGIN" 
        git clone https://github.com/vim-scripts/c.vim.git $_PLUGINS_DIR/$_PLUGIN
	else
		git pull
		echo "git pull\n"
    fi
	ln -s $_PLUGINS_DIR/$_PLUGIN $_VIM_BUNDLE/$_PLUGIN
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"
}

vala()
{
    wget -O $_PLUGINS_DIR/vala.vim \
    "https://live.gnome.org/Vala/Vim?action=AttachFile&do=get&target=vala.vim"
    if [ ! -d "$_VIM_SYNTAX" ]; then
        echo "mkdir $_VIM_SYNTAX ..."
        mkdir $_VIM_SYNTAX
    fi
    cp $_PLUGINS_DIR/vala.vim $_VIM_SYNTAX/
}

#---- python语法检测工具
#---- 需要安装 sudo apt-get install pyflakes
pyflakes(){

    if [ ! -f "/usr/bin/pyflakes" ];then
        echo "$_DEBUG_INSTALL pyflakes ..."
        sudo apt-get install pyflakes
    fi
    _PLUGIN="pyflakes"
    echo "$_DEBUG_INSTALL $_PLUGIN start ..."
    if [ ! -d "$_PLUGINS_DIR/$_PLUGIN" ]; then
        mkdir $_PLUGINS_DIR/$_PLUGIN
        git clone https://github.com/kevinw/pyflakes-vim.git $_PLUGINS_DIR/$_PLUGIN 
	else
		git pull
		echo "git pull\n"
    fi
	ln -s $_PLUGINS_DIR/$_PLUGIN $_VIM_BUNDLE/$_PLUGIN
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"
}

cscope(){
    # http://graceco.de/manual/cscope_vim_tutorial_zh.html
    if [ ! -f "/usr/bin/cscope" ];then
        echo "$_DEBUG_INSTALL cscope ..."
        sudo apt-get install cscope 
    fi
    _PLUGIN="cscope"
    echo "INSTALL $_PLUGIN start ..."
    if [ ! -d "$_PLUGINS_DIR/$_PLUGIN" ]; then
        mkdir $_PLUGINS_DIR/$_PLUGIN
        git clone https://github.com/vim-scripts/cscope.vim.git $_PLUGINS_DIR/$_PLUGIN 
	else
		git pull
		echo "git pull\n"
    fi
	ln -s $_PLUGINS_DIR/$_PLUGIN $_VIM_BUNDLE/$_PLUGIN
    echo "$_DEBUG_INSTALL $_PLUGIN $_DEBUG_SUCCESS\n"
}

#---- Install plugins ----
plugins()
{
     vimrc
	 c;
     nerdtree;
     taglist;
    # vala;
     pyflakes;
     cscope;
    #tabular;
	echo "Done ..."
}

#---- Install main  ----
init
pathogen

if [ "$*" = "vimrc" ];then
    vimrc
else
    plugins
fi


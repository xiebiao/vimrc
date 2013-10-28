#!/bin/sh

#--------------
# author:xiaog
#--------------

#
#   NOTE: This script just tested on Ubuntu 12.04
#

_CURRENT_PATH=`pwd`
_PLUGINS_DIR=$_CURRENT_PATH/temp
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
    if [ ! -f "/usr/bin/vim" ];then
        echo "$_DEBUG_INSTALL vim ..."
        sudo apt-get install vim
        if [ ! $? = 0 ];then
           echo "$_DEBUG_INSTALL vim $_DEBUG_FAILED"
           exit;
        fi
    fi 
    if [ ! -f "/usr/bin/git" ];then
        echo "$_DEBUG_INSTALL git ..."
        sudo apt-get install git
		if [ ! $? = 0 ];then
			echo "$_DEBUG_INSTALL git $_DEBUG_FAILED"
			exit;
	    fi
	    echo $_DEBUG_INSTALL"git"$_DEBUG_SUCCESS
    fi
    if [ "$_USER" = "root" ];then
        _VIM_HOME="/root/.vim"
        _VIMRC="/root/.vimrc"
        _USER_HOME="/root/"
    else
        _VIM_HOME="/home/"$_USER"/.vim"
        _VIMRC="/home/"$_USER"/.vimrc"
    fi
    if [ ! -d "$_VIM_HOME" ];then
        mkdir $_VIM_HOME
    fi

	echo "_VIMRC=$_VIMRC"
	echo "_VIM_HOME=$_VIM_HOME"
	echo "_USER_HOME=$_USER_HOME"
	
    _VIM_COLORS=$_VIM_HOME/colors
    if [ ! -d "$_VIM_COLORS" ];then
        mkdir $_VIM_COLORS
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

#---- 管理所有插件
vundle(){

	_PLUGIN="vundle"
    _PLUGIN_LOCAL=$_VIM_HOME/bundle/vundle

    if [ ! -d "$_PLUGIN_LOCAL" ]; then
	    echo "mkdir $_PLUGIN_LOCAL"
		mkdir -p $_PLUGIN_LOCAL 
		git clone https://github.com/gmarik/vundle.git $_PLUGIN_LOCAL
	else
	    cd $_PLUGIN_LOCAL
		git pull
		echo "Update vundle"
		cd $_CURRENT_PATH
	fi

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
		echo "git pull"
    fi
	ln -s $_PLUGINS_DIR/$_TAGLIST $_VIM_BUNDLE/$_TAGLIST
    echo "$_DEBUG_INSTALL $_TAGLIST $_DEBUG_SUCCESS\n"
}

#---- Install main
init
vimrc
vundle

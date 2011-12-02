#!/bin/sh

#-------------------
#   author:xiaog
#-------------------

#	Test on vim 7.2+
#
_CURRENT_PATH=`pwd`
_SHELL_PATH=`dirname $0`
_USER=`whoami`
if [ $_USER = "root" ];then
	_USER_HOME=/root
else
	_USER_HOME=/home/$_USER
fi
_VIMRC=".vimrc"
_VIM=$_USER_HOME/.vim

_VIM_COLORS=$_VIM/colors
if [ ! -d $_VIM_COLORS ];then
   mkdir -p $_VIM_COLORS
fi

cp $_SHELL_PATH/vimrc $_USER_HOME"/"$_VIMRC
echo "Copy $_SHELL_PATH/vimrc to "$_USER_HOME/$_VIMRC

cp colors/my_desert.vim  $_VIM_COLORS 
